Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB04A6A1C8
	for <lists+linux-unionfs@lfdr.de>; Tue, 16 Jul 2019 07:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfGPFPf (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 16 Jul 2019 01:15:35 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40982 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfGPFPf (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 16 Jul 2019 01:15:35 -0400
Received: by mail-yw1-f66.google.com with SMTP id i138so8240244ywg.8
        for <linux-unionfs@vger.kernel.org>; Mon, 15 Jul 2019 22:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DxYLCuAqRfnIRShxAWD388iC6BcZ6P/JJK/OJzpAv9Q=;
        b=EM838BuXjCWSjpmMMpg67mKG2FS09AK+2Ey3g6r5+L1XW+ZTeVR5E+P80onxQMQ8FA
         UMZ06K1tvd6v+JPvMBKbdC4qzpI/TbFblKvBC+i+8OsNPq0TWMTzSaM4txMuxPwPAieD
         DIJBtvhTQ5TVq2DaK3CMOKfryFavWUggnOsbQjvTq6B4kjK1aRBD7xvOHgEcSR46rNg1
         MP22b1ia/vuTYUfW7yGo9LzqxSCCnMdA5LWUqHFRzw+m1i9Tc2dr8LUGBVN7NivLYZJ/
         WlduU0YIFIHaZeTuGaji5y2isRWyRoV4Truc3Zda0k87mAIV9sYrjdnvDiOP01i3HCC4
         0zow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DxYLCuAqRfnIRShxAWD388iC6BcZ6P/JJK/OJzpAv9Q=;
        b=nUlWy81V62ks9q3dYPYI9cjK7Tqev088Hd+gqoAtdg0LUU6M9vuz5wu5rTCAReNk52
         1K5aHcpii7RHju2NBUdyHNMPYhqIKSJ54weY2bwB0X+JjiCNGaq211/o1GT76fC49tSL
         KQJHlUSFDu6royLPSMgek7f63udFCx70Bf1JZDx4O7ovQHxWpNIQ+NmHX5jZDVptEUl6
         g29YOB3OPEdZ+Ue+CtWQNSHzFfDeaOwjqNR/bW7pW//dwN4cR693ovt21us/CSP2q81O
         VKSH7G8mWcAIzjBQ/7rywqwosDlXvtvYjEPlbkWPtvOKaaRIfzSpq9aDDvOLJKxIJZFL
         eAww==
X-Gm-Message-State: APjAAAWU+J2XUKzTIySdKQBJ9TQBMk69O7z5VHIy5zqf8rMzWM4EwYQE
        uDAAt72g1RgM/mz3kvRDvUzn4FdctWy85d4WiKXgoa1k
X-Google-Smtp-Source: APXvYqwbEbSGlXuFV4S87/ldBulXUyFkGTdWjxZd8H06B8gHW318lyEsDEvVGuZTbKH56uarpxG81lL9/dCW9FalAPs=
X-Received: by 2002:a81:50d5:: with SMTP id e204mr17862713ywb.379.1563254133654;
 Mon, 15 Jul 2019 22:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190712122434.14809-1-amir73il@gmail.com>
In-Reply-To: <20190712122434.14809-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 16 Jul 2019 08:15:22 +0300
Message-ID: <CAOQ4uxg+equ2vt3xqsC_v=m=YMFSAj2ywk2pga=BGZWgOQcVoA@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix regression caused by overlapping layers detection
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Colin Walters <walters@verbum.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Fri, Jul 12, 2019 at 3:24 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Once upon a time, commit 2cac0c00a6cd ("ovl: get exclusive ownership on
> upper/work dirs") in v4.13 added some sanity checks on overlayfs layers.
> This change caused a docker regression. The root cause was mount leaks
> by docker, which as far as I know, still exist.
>
> To mitigate the regression, commit 85fdee1eef1a ("ovl: fix regression
> caused by exclusive upper/work dir protection") in v4.14 turned the
> mount errors into warnings for the default index=off configuration.
>
> Recently, commit 146d62e5a586 ("ovl: detect overlapping layers") in
> v5.2, re-introduced exclusive upper/work dir checks regardless of
> index=off configuration.
>
> This changes the status quo and mount leak related bug reports have
> started to re-surface. Restore the status quo to fix the regressions.
> To clarify, index=off does NOT relax overlapping layers check for this
> ovelayfs mount. index=off only relaxes exclusive upper/work dir checks
> with another overlayfs mount.
>
> To cover the part of overlapping layers detection that used the
> exclusive upper/work dir checks to detect overlap with self upper/work
> dir, add a trap also on the work base dir.
>
> Link: https://github.com/moby/moby/issues/34672
> Link: https://lore.kernel.org/linux-fsdevel/20171006121405.GA32700@veci.piliscsaba.szeredi.hu/
> Link: https://github.com/containers/libpod/issues/3540
> Fixes: 146d62e5a586 ("ovl: detect overlapping layers")
> Cc: <stable@vger.kernel.org> # v4.19+
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Miklos,

Please add:
Tested-by: Colin Walters <walters@verbum.org>

Thanks,
Amir.

> ---
>
> Miklos,
>
> This showed up initially on libpod github and since then also surfaced
> in coreos who have merged some band aid fix for their kernel.
> I bet docker users will start noticing this soon as well.
>
> I have modified xfstest overlay/065 to accomodate these changes and will
> post the patch later.
>
> Thanks,
> Amir.
>
>  Documentation/filesystems/overlayfs.txt |  2 +-
>  fs/overlayfs/ovl_entry.h                |  1 +
>  fs/overlayfs/super.c                    | 73 ++++++++++++++++---------
>  3 files changed, 49 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/filesystems/overlayfs.txt b/Documentation/filesystems/overlayfs.txt
> index 1da2f1668f08..845d689e0fd7 100644
> --- a/Documentation/filesystems/overlayfs.txt
> +++ b/Documentation/filesystems/overlayfs.txt
> @@ -302,7 +302,7 @@ beneath or above the path of another overlay lower layer path.
>
>  Using an upper layer path and/or a workdir path that are already used by
>  another overlay mount is not allowed and may fail with EBUSY.  Using
> -partially overlapping paths is not allowed but will not fail with EBUSY.
> +partially overlapping paths is not allowed and may fail with EBUSY.
>  If files are accessed from two overlayfs mounts which share or overlap the
>  upper layer and/or workdir path the behavior of the overlay is undefined,
>  though it will not result in a crash or deadlock.
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index 28a2d12a1029..a8279280e88d 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -66,6 +66,7 @@ struct ovl_fs {
>         bool workdir_locked;
>         /* Traps in ovl inode cache */
>         struct inode *upperdir_trap;
> +       struct inode *workbasedir_trap;
>         struct inode *workdir_trap;
>         struct inode *indexdir_trap;
>         /* Inode numbers in all layers do not use the high xino_bits */
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index b368e2e102fa..afbcb116a7f1 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -212,6 +212,7 @@ static void ovl_free_fs(struct ovl_fs *ofs)
>  {
>         unsigned i;
>
> +       iput(ofs->workbasedir_trap);
>         iput(ofs->indexdir_trap);
>         iput(ofs->workdir_trap);
>         iput(ofs->upperdir_trap);
> @@ -1003,6 +1004,25 @@ static int ovl_setup_trap(struct super_block *sb, struct dentry *dir,
>         return 0;
>  }
>
> +/*
> + * Determine how we treat concurrent use of upperdir/workdir based on the
> + * index feature. This is papering over mount leaks of container runtimes,
> + * for example, an old overlay mount is leaked and now its upperdir is
> + * attempted to be used as a lower layer in a new overlay mount.
> + */
> +static int ovl_report_in_use(struct ovl_fs *ofs, const char *name)
> +{
> +       if (ofs->config.index) {
> +               pr_err("overlayfs: %s is in-use as upperdir/workdir of another mount, mount with '-o index=off' to override exclusive upperdir protection.\n",
> +                      name);
> +               return -EBUSY;
> +       } else {
> +               pr_warn("overlayfs: %s is in-use as upperdir/workdir of another mount, accessing files from both mounts will result in undefined behavior.\n",
> +                       name);
> +               return 0;
> +       }
> +}
> +
>  static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
>                          struct path *upperpath)
>  {
> @@ -1040,14 +1060,12 @@ static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
>         upper_mnt->mnt_flags &= ~(MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME);
>         ofs->upper_mnt = upper_mnt;
>
> -       err = -EBUSY;
>         if (ovl_inuse_trylock(ofs->upper_mnt->mnt_root)) {
>                 ofs->upperdir_locked = true;
> -       } else if (ofs->config.index) {
> -               pr_err("overlayfs: upperdir is in-use by another mount, mount with '-o index=off' to override exclusive upperdir protection.\n");
> -               goto out;
>         } else {
> -               pr_warn("overlayfs: upperdir is in-use by another mount, accessing files from both mounts will result in undefined behavior.\n");
> +               err = ovl_report_in_use(ofs, "upperdir");
> +               if (err)
> +                       goto out;
>         }
>
>         err = 0;
> @@ -1157,16 +1175,19 @@ static int ovl_get_workdir(struct super_block *sb, struct ovl_fs *ofs,
>
>         ofs->workbasedir = dget(workpath.dentry);
>
> -       err = -EBUSY;
>         if (ovl_inuse_trylock(ofs->workbasedir)) {
>                 ofs->workdir_locked = true;
> -       } else if (ofs->config.index) {
> -               pr_err("overlayfs: workdir is in-use by another mount, mount with '-o index=off' to override exclusive workdir protection.\n");
> -               goto out;
>         } else {
> -               pr_warn("overlayfs: workdir is in-use by another mount, accessing files from both mounts will result in undefined behavior.\n");
> +               err = ovl_report_in_use(ofs, "workdir");
> +               if (err)
> +                       goto out;
>         }
>
> +       err = ovl_setup_trap(sb, ofs->workbasedir, &ofs->workbasedir_trap,
> +                            "workdir");
> +       if (err)
> +               goto out;
> +
>         err = ovl_make_workdir(sb, ofs, &workpath);
>
>  out:
> @@ -1313,16 +1334,16 @@ static int ovl_get_lower_layers(struct super_block *sb, struct ovl_fs *ofs,
>                 if (err < 0)
>                         goto out;
>
> -               err = -EBUSY;
> -               if (ovl_is_inuse(stack[i].dentry)) {
> -                       pr_err("overlayfs: lowerdir is in-use as upperdir/workdir\n");
> -                       goto out;
> -               }
> -
>                 err = ovl_setup_trap(sb, stack[i].dentry, &trap, "lowerdir");
>                 if (err)
>                         goto out;
>
> +               if (ovl_is_inuse(stack[i].dentry)) {
> +                       err = ovl_report_in_use(ofs, "lowerdir");
> +                       if (err)
> +                               goto out;
> +               }
> +
>                 mnt = clone_private_mount(&stack[i]);
>                 err = PTR_ERR(mnt);
>                 if (IS_ERR(mnt)) {
> @@ -1469,8 +1490,8 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
>   * - another layer of this overlayfs instance
>   * - upper/work dir of any overlayfs instance
>   */
> -static int ovl_check_layer(struct super_block *sb, struct dentry *dentry,
> -                          const char *name)
> +static int ovl_check_layer(struct super_block *sb, struct ovl_fs *ofs,
> +                          struct dentry *dentry, const char *name)
>  {
>         struct dentry *next = dentry, *parent;
>         int err = 0;
> @@ -1482,13 +1503,11 @@ static int ovl_check_layer(struct super_block *sb, struct dentry *dentry,
>
>         /* Walk back ancestors to root (inclusive) looking for traps */
>         while (!err && parent != next) {
> -               if (ovl_is_inuse(parent)) {
> -                       err = -EBUSY;
> -                       pr_err("overlayfs: %s path overlapping in-use upperdir/workdir\n",
> -                              name);
> -               } else if (ovl_lookup_trap_inode(sb, parent)) {
> +               if (ovl_lookup_trap_inode(sb, parent)) {
>                         err = -ELOOP;
>                         pr_err("overlayfs: overlapping %s path\n", name);
> +               } else if (ovl_is_inuse(parent)) {
> +                       err = ovl_report_in_use(ofs, name);
>                 }
>                 next = parent;
>                 parent = dget_parent(next);
> @@ -1509,7 +1528,8 @@ static int ovl_check_overlapping_layers(struct super_block *sb,
>         int i, err;
>
>         if (ofs->upper_mnt) {
> -               err = ovl_check_layer(sb, ofs->upper_mnt->mnt_root, "upperdir");
> +               err = ovl_check_layer(sb, ofs, ofs->upper_mnt->mnt_root,
> +                                     "upperdir");
>                 if (err)
>                         return err;
>
> @@ -1520,13 +1540,14 @@ static int ovl_check_overlapping_layers(struct super_block *sb,
>                  * workbasedir.  In that case, we already have their traps in
>                  * inode cache and we will catch that case on lookup.
>                  */
> -               err = ovl_check_layer(sb, ofs->workbasedir, "workdir");
> +               err = ovl_check_layer(sb, ofs, ofs->workbasedir, "workdir");
>                 if (err)
>                         return err;
>         }
>
>         for (i = 0; i < ofs->numlower; i++) {
> -               err = ovl_check_layer(sb, ofs->lower_layers[i].mnt->mnt_root,
> +               err = ovl_check_layer(sb, ofs,
> +                                     ofs->lower_layers[i].mnt->mnt_root,
>                                       "lowerdir");
>                 if (err)
>                         return err;
> --
> 2.17.1
>
