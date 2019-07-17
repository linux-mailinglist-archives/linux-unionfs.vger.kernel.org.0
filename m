Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F37AB6C210
	for <lists+linux-unionfs@lfdr.de>; Wed, 17 Jul 2019 22:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfGQUWO (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 17 Jul 2019 16:22:14 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:35407 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQUWO (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 17 Jul 2019 16:22:14 -0400
Received: by mail-yb1-f193.google.com with SMTP id p85so3290574yba.2
        for <linux-unionfs@vger.kernel.org>; Wed, 17 Jul 2019 13:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xpuRhIGT8JIAfuYNYuDxSwd+0fpkjIYyrIfutZv48h4=;
        b=SXFsxyeSta3HQRZjQYlzc89hTnPnr+PW9mCpWfuX+GIxhMojpteV64i8vw/bVHtE8y
         gz9pIW11uemEOxOJEPEkKuufnizVYaAsaby88+LKmVvrZXM2jasZOX9yq8+C7a6RHzbX
         YJSEgGiL5tLzK2WfZXKQbeKhXjYjIRzpbzg9phoRK7R73GBL9Q9Om23/QMrsH8iph645
         aspStz1XYa791vRoJT3nMt5x58IxemoTR3N5/aLz9VKwiJTX9TLnFrC8nr2o2Jn/TY2h
         IK3NrriaeJCadyAg75ZDpW/aFxkylswQ1BvGz3Aq7fxgY3ehC4qLKuYki9lKUawafS05
         dYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xpuRhIGT8JIAfuYNYuDxSwd+0fpkjIYyrIfutZv48h4=;
        b=awbV+R0SNDlamwVfbK35kJSckt0x00UI1zA5mAxgs+YXaEAi/lDmbopr3oUEsWqMq1
         vaP6jE9Q+E0Sra/LOdPNaQjfvSlS96MXTyx8OqsnjtQ9IYg2vqddtXzmGRlIKMC5hN4i
         oEWEvXSW84ByvXVRLDawJNcOjcZTTwgwb6tLnxHLqyB5eD2Nrpe/2RILLfkuu4bItcNO
         3XvMq4f1nZkf7z0VY+HPMVqh2vSocxAB2ul9PDSQS0EbkyVgI5ZbVLcyxeXZIRvmCH/N
         iGq5tugP6fvaXq5Dp7zbYVfysX/S3N5wiX8JTJloxqZr3F16f3giSAg9wAgFSoMPHTMv
         D3XQ==
X-Gm-Message-State: APjAAAVsInJZoTZkusT1TeqPehVzT4dfxG894vdYC22HpY6MucdN4lB9
        AE6Xpu1mPjP+qUfA3fSTUGt6zWJcGT3OZmTu+da+5A==
X-Google-Smtp-Source: APXvYqyIjhVh7zsg8pmgPlUghVJTymasN/FBRvKcC4nstH8X0oNuK3jluE5KkuagZ2rFUWInTq5hWJdNyaQCRBrnFzI=
X-Received: by 2002:a25:c486:: with SMTP id u128mr26182051ybf.428.1563394932928;
 Wed, 17 Jul 2019 13:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190712122434.14809-1-amir73il@gmail.com> <20190717184031.GA31226@redhat.com>
In-Reply-To: <20190717184031.GA31226@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 17 Jul 2019 23:22:00 +0300
Message-ID: <CAOQ4uxivNhDT3XS3Se8hNe54wRJM4KfSu-jNig-CMqU726jweg@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix regression caused by overlapping layers detection
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Jul 17, 2019 at 9:40 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Fri, Jul 12, 2019 at 03:24:34PM +0300, Amir Goldstein wrote:
> > Once upon a time, commit 2cac0c00a6cd ("ovl: get exclusive ownership on
> > upper/work dirs") in v4.13 added some sanity checks on overlayfs layers.
> > This change caused a docker regression. The root cause was mount leaks
> > by docker, which as far as I know, still exist.
> >
> > To mitigate the regression, commit 85fdee1eef1a ("ovl: fix regression
> > caused by exclusive upper/work dir protection") in v4.14 turned the
> > mount errors into warnings for the default index=off configuration.
> >
> > Recently, commit 146d62e5a586 ("ovl: detect overlapping layers") in
> > v5.2, re-introduced exclusive upper/work dir checks regardless of
> > index=off configuration.
> >
> > This changes the status quo and mount leak related bug reports have
> > started to re-surface. Restore the status quo to fix the regressions.
> > To clarify, index=off does NOT relax overlapping layers check for this
> > ovelayfs mount. index=off only relaxes exclusive upper/work dir checks
> > with another overlayfs mount.
> >
> > To cover the part of overlapping layers detection that used the
> > exclusive upper/work dir checks to detect overlap with self upper/work
> > dir, add a trap also on the work base dir.
>
> Adding a trap for work base dir, seems as if should be a separate patch.
> IIUC, its nice to have but is not must for stable backport.

Not accurate. The two changes are dependent.
When removing the in-use check for lowerdir, it regresses the case
of lowerdir=work,upperdir=upper,workdir=work
The trap on work base dir is needed to not regress this case.

The only reason stable tree picked up "detect overlap layers"
was that it stops syzbot from mutating those overlapping layers repros,
so we don't want to go back to that state.

Thanks for review!
Amir.

>
> This is just a minor nit. If it was me, I probably would have split it
> in two patches. One for in-use error/warn thing and other for putting
> a trap on workbase dir. Anywyay...
>
> Acked-by: Vivek Goyal <vgoyal@redhat.com>
>
> Vivek
>
> >
> > Link: https://github.com/moby/moby/issues/34672
> > Link: https://lore.kernel.org/linux-fsdevel/20171006121405.GA32700@veci.piliscsaba.szeredi.hu/
> > Link: https://github.com/containers/libpod/issues/3540
> > Fixes: 146d62e5a586 ("ovl: detect overlapping layers")
> > Cc: <stable@vger.kernel.org> # v4.19+
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Miklos,
> >
> > This showed up initially on libpod github and since then also surfaced
> > in coreos who have merged some band aid fix for their kernel.
> > I bet docker users will start noticing this soon as well.
> >
> > I have modified xfstest overlay/065 to accomodate these changes and will
> > post the patch later.
> >
> > Thanks,
> > Amir.
> >
> >  Documentation/filesystems/overlayfs.txt |  2 +-
> >  fs/overlayfs/ovl_entry.h                |  1 +
> >  fs/overlayfs/super.c                    | 73 ++++++++++++++++---------
> >  3 files changed, 49 insertions(+), 27 deletions(-)
> >
> > diff --git a/Documentation/filesystems/overlayfs.txt b/Documentation/filesystems/overlayfs.txt
> > index 1da2f1668f08..845d689e0fd7 100644
> > --- a/Documentation/filesystems/overlayfs.txt
> > +++ b/Documentation/filesystems/overlayfs.txt
> > @@ -302,7 +302,7 @@ beneath or above the path of another overlay lower layer path.
> >
> >  Using an upper layer path and/or a workdir path that are already used by
> >  another overlay mount is not allowed and may fail with EBUSY.  Using
> > -partially overlapping paths is not allowed but will not fail with EBUSY.
> > +partially overlapping paths is not allowed and may fail with EBUSY.
> >  If files are accessed from two overlayfs mounts which share or overlap the
> >  upper layer and/or workdir path the behavior of the overlay is undefined,
> >  though it will not result in a crash or deadlock.
> > diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> > index 28a2d12a1029..a8279280e88d 100644
> > --- a/fs/overlayfs/ovl_entry.h
> > +++ b/fs/overlayfs/ovl_entry.h
> > @@ -66,6 +66,7 @@ struct ovl_fs {
> >       bool workdir_locked;
> >       /* Traps in ovl inode cache */
> >       struct inode *upperdir_trap;
> > +     struct inode *workbasedir_trap;
> >       struct inode *workdir_trap;
> >       struct inode *indexdir_trap;
> >       /* Inode numbers in all layers do not use the high xino_bits */
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index b368e2e102fa..afbcb116a7f1 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -212,6 +212,7 @@ static void ovl_free_fs(struct ovl_fs *ofs)
> >  {
> >       unsigned i;
> >
> > +     iput(ofs->workbasedir_trap);
> >       iput(ofs->indexdir_trap);
> >       iput(ofs->workdir_trap);
> >       iput(ofs->upperdir_trap);
> > @@ -1003,6 +1004,25 @@ static int ovl_setup_trap(struct super_block *sb, struct dentry *dir,
> >       return 0;
> >  }
> >
> > +/*
> > + * Determine how we treat concurrent use of upperdir/workdir based on the
> > + * index feature. This is papering over mount leaks of container runtimes,
> > + * for example, an old overlay mount is leaked and now its upperdir is
> > + * attempted to be used as a lower layer in a new overlay mount.
> > + */
> > +static int ovl_report_in_use(struct ovl_fs *ofs, const char *name)
> > +{
> > +     if (ofs->config.index) {
> > +             pr_err("overlayfs: %s is in-use as upperdir/workdir of another mount, mount with '-o index=off' to override exclusive upperdir protection.\n",
> > +                    name);
> > +             return -EBUSY;
> > +     } else {
> > +             pr_warn("overlayfs: %s is in-use as upperdir/workdir of another mount, accessing files from both mounts will result in undefined behavior.\n",
> > +                     name);
> > +             return 0;
> > +     }
> > +}
> > +
> >  static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
> >                        struct path *upperpath)
> >  {
> > @@ -1040,14 +1060,12 @@ static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
> >       upper_mnt->mnt_flags &= ~(MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME);
> >       ofs->upper_mnt = upper_mnt;
> >
> > -     err = -EBUSY;
> >       if (ovl_inuse_trylock(ofs->upper_mnt->mnt_root)) {
> >               ofs->upperdir_locked = true;
> > -     } else if (ofs->config.index) {
> > -             pr_err("overlayfs: upperdir is in-use by another mount, mount with '-o index=off' to override exclusive upperdir protection.\n");
> > -             goto out;
> >       } else {
> > -             pr_warn("overlayfs: upperdir is in-use by another mount, accessing files from both mounts will result in undefined behavior.\n");
> > +             err = ovl_report_in_use(ofs, "upperdir");
> > +             if (err)
> > +                     goto out;
> >       }
> >
> >       err = 0;
> > @@ -1157,16 +1175,19 @@ static int ovl_get_workdir(struct super_block *sb, struct ovl_fs *ofs,
> >
> >       ofs->workbasedir = dget(workpath.dentry);
> >
> > -     err = -EBUSY;
> >       if (ovl_inuse_trylock(ofs->workbasedir)) {
> >               ofs->workdir_locked = true;
> > -     } else if (ofs->config.index) {
> > -             pr_err("overlayfs: workdir is in-use by another mount, mount with '-o index=off' to override exclusive workdir protection.\n");
> > -             goto out;
> >       } else {
> > -             pr_warn("overlayfs: workdir is in-use by another mount, accessing files from both mounts will result in undefined behavior.\n");
> > +             err = ovl_report_in_use(ofs, "workdir");
> > +             if (err)
> > +                     goto out;
> >       }
> >
> > +     err = ovl_setup_trap(sb, ofs->workbasedir, &ofs->workbasedir_trap,
> > +                          "workdir");
> > +     if (err)
> > +             goto out;
> > +
> >       err = ovl_make_workdir(sb, ofs, &workpath);
> >
> >  out:
> > @@ -1313,16 +1334,16 @@ static int ovl_get_lower_layers(struct super_block *sb, struct ovl_fs *ofs,
> >               if (err < 0)
> >                       goto out;
> >
> > -             err = -EBUSY;
> > -             if (ovl_is_inuse(stack[i].dentry)) {
> > -                     pr_err("overlayfs: lowerdir is in-use as upperdir/workdir\n");
> > -                     goto out;
> > -             }
> > -
> >               err = ovl_setup_trap(sb, stack[i].dentry, &trap, "lowerdir");
> >               if (err)
> >                       goto out;
> >
> > +             if (ovl_is_inuse(stack[i].dentry)) {
> > +                     err = ovl_report_in_use(ofs, "lowerdir");
> > +                     if (err)
> > +                             goto out;
> > +             }
> > +
> >               mnt = clone_private_mount(&stack[i]);
> >               err = PTR_ERR(mnt);
> >               if (IS_ERR(mnt)) {
> > @@ -1469,8 +1490,8 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
> >   * - another layer of this overlayfs instance
> >   * - upper/work dir of any overlayfs instance
> >   */
> > -static int ovl_check_layer(struct super_block *sb, struct dentry *dentry,
> > -                        const char *name)
> > +static int ovl_check_layer(struct super_block *sb, struct ovl_fs *ofs,
> > +                        struct dentry *dentry, const char *name)
> >  {
> >       struct dentry *next = dentry, *parent;
> >       int err = 0;
> > @@ -1482,13 +1503,11 @@ static int ovl_check_layer(struct super_block *sb, struct dentry *dentry,
> >
> >       /* Walk back ancestors to root (inclusive) looking for traps */
> >       while (!err && parent != next) {
> > -             if (ovl_is_inuse(parent)) {
> > -                     err = -EBUSY;
> > -                     pr_err("overlayfs: %s path overlapping in-use upperdir/workdir\n",
> > -                            name);
> > -             } else if (ovl_lookup_trap_inode(sb, parent)) {
> > +             if (ovl_lookup_trap_inode(sb, parent)) {
> >                       err = -ELOOP;
> >                       pr_err("overlayfs: overlapping %s path\n", name);
> > +             } else if (ovl_is_inuse(parent)) {
> > +                     err = ovl_report_in_use(ofs, name);
> >               }
> >               next = parent;
> >               parent = dget_parent(next);
> > @@ -1509,7 +1528,8 @@ static int ovl_check_overlapping_layers(struct super_block *sb,
> >       int i, err;
> >
> >       if (ofs->upper_mnt) {
> > -             err = ovl_check_layer(sb, ofs->upper_mnt->mnt_root, "upperdir");
> > +             err = ovl_check_layer(sb, ofs, ofs->upper_mnt->mnt_root,
> > +                                   "upperdir");
> >               if (err)
> >                       return err;
> >
> > @@ -1520,13 +1540,14 @@ static int ovl_check_overlapping_layers(struct super_block *sb,
> >                * workbasedir.  In that case, we already have their traps in
> >                * inode cache and we will catch that case on lookup.
> >                */
> > -             err = ovl_check_layer(sb, ofs->workbasedir, "workdir");
> > +             err = ovl_check_layer(sb, ofs, ofs->workbasedir, "workdir");
> >               if (err)
> >                       return err;
> >       }
> >
> >       for (i = 0; i < ofs->numlower; i++) {
> > -             err = ovl_check_layer(sb, ofs->lower_layers[i].mnt->mnt_root,
> > +             err = ovl_check_layer(sb, ofs,
> > +                                   ofs->lower_layers[i].mnt->mnt_root,
> >                                     "lowerdir");
> >               if (err)
> >                       return err;
> > --
> > 2.17.1
> >
