Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A1A2AFC7
	for <lists+linux-unionfs@lfdr.de>; Mon, 27 May 2019 10:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfE0IKw (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 27 May 2019 04:10:52 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44196 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfE0IKv (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 27 May 2019 04:10:51 -0400
Received: by mail-yw1-f66.google.com with SMTP id e74so6336015ywe.11
        for <linux-unionfs@vger.kernel.org>; Mon, 27 May 2019 01:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0N3nV+7E0hx3SRiA2AP79e5NcIZFRgiJubEBVtTuDFo=;
        b=sx0yAgqjnxwGPS+5sAHZ9y1DtaF13qJ2d/Jhv1slTwm2MA5x+aIOLwv8fNNJUGqahv
         fkTzpb9A46C7AZRUZ7+URYlSwgxZv4vnt7eR3bZHCGNfu8ZshDYutXUM4ZvRvvmdcrhl
         THwbH+syHLhKLTOajsky5LM8adBueI5JD10qUEfYHqLincBqY7si1HzNd1oNrcLcwDzT
         l5sQGYy/ZjJKaWmZXmUmPUZX2Ox7dOG9bm9oH450KYiwqn+ugWQpb+izwIdaagBotXVB
         MNpmfBHwP/xN9WjW8S7sdkTCKok0/vStwOotJR5Xj+T4JKRyOl/Bk03/QJR+EM6d3Nyh
         X+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0N3nV+7E0hx3SRiA2AP79e5NcIZFRgiJubEBVtTuDFo=;
        b=gvxYfwBaIpUmpqNT7SpNXT/sVtCkvGpKij7ANM/AwOo+arZReso11+ypeJ9lQdGdd0
         9jrGoOztWDLoN2zVN+Z3f9T5S31Q4+4Ow4LGihJ4Fk+OwJYm5XtZfPRU9ZI8tlV6mGQk
         dMeSPnEL9s23O2xfRyTNVTpeh7WmkBW/8CikEN7mbcr+hRhHYbQvjNBm7UwCyEFUPG36
         XwwHS+EEwgpvR0M5bsZv0p3RxvIYYNXMz2fURf+sXuGBPPUMqFIsc8Q9FZd9Xvk8sFCK
         zvWuD8pQNZ1aF57/ghvCq5VfvLcowQ6ZWQKQFC4xsKE7GxYe2jVeEq7Q3mDzbzCQK/cS
         qUZw==
X-Gm-Message-State: APjAAAWN7/wYudLMV/ZQFQUrrSxsRity4Fni52AFzLUZPD4IQfWIbCt3
        I5EOBrrvU9U9xnZ3/q/vwxZmKeD5GsFt496+exo=
X-Google-Smtp-Source: APXvYqyq8F+QxtYsn3aakw1goO3mb2GkB5FQXpKDWN/Lef+x+nYIcdNPFX2IYDHmxclF2DMSYky6fySLEgLTIl3Q8U4=
X-Received: by 2002:a81:3956:: with SMTP id g83mr2014036ywa.183.1558944650362;
 Mon, 27 May 2019 01:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190418144208.21832-1-amir73il@gmail.com>
In-Reply-To: <20190418144208.21832-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 27 May 2019 11:10:38 +0300
Message-ID: <CAOQ4uxjLB5L5-3U0AvRA_7w+ro-+FmWbbL5UMW0G4eOTdovG=g@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: detect overlapping layers
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, Apr 18, 2019 at 5:42 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Overlapping overlay layers are not supported and can cause unexpected
> behavior, but overlayfs does not currently check or warn about these
> configurations.
>
> User is not supposed to specify the same directory for upper and
> lower dirs or for different lower layers and user is not supposed to
> specify directories that are descendants of each other for overlay
> layers, but that is exactly what this zysbot repro did:
>
>     https://syzkaller.appspot.com/x/repro.syz?x=12c7a94f400000
>
> Moving layer root directories into other layers while overlayfs
> is mounted could also result in unexpected behavior.
>
> This commit places "traps" in the overlay inode hash table.
> Those traps are dummy overlay inodes that are hashed by the layers
> root inodes.
>
> On mount, the hash table trap entries are used to verify that overlay
> layers are not overlapping.  While at it, we also verify that overlay
> layers are not overlapping with directories "in-use" by other overlay
> instances as upperdir/workdir.
>
> On lookup, the trap entries are used to verify that overlay layers
> root inodes have not been moved into other layers after mount.
>
> Some examples:
>
> $ ./run --ov --samefs -s
> ...
> ( mkdir -p base/upper/0/u base/upper/0/w base/lower lower upper mnt
>   mount -o bind base/lower lower
>   mount -o bind base/upper upper
>   mount -t overlay none mnt ...
>         -o lowerdir=lower,upperdir=upper/0/u,workdir=upper/0/w)
>
> $ umount mnt
> $ mount -t overlay none mnt ...
>         -o lowerdir=base,upperdir=upper/0/u,workdir=upper/0/w
>
>   [   94.434900] overlayfs: overlapping upperdir path
>   mount: mount overlay on mnt failed: Too many levels of symbolic links
>
> $ mount -t overlay none mnt ...
>         -o lowerdir=upper/0/u,upperdir=upper/0/u,workdir=upper/0/w
>
>   [  151.350132] overlayfs: conflicting lowerdir path
>   mount: none is already mounted or mnt busy
>
> $ mount -t overlay none mnt ...
>         -o lowerdir=lower:lower/a,upperdir=upper/0/u,workdir=upper/0/w
>
>   [  201.205045] overlayfs: overlapping lowerdir path
>   mount: mount overlay on mnt failed: Too many levels of symbolic links
>
> $ mount -t overlay none mnt ...
>         -o lowerdir=lower,upperdir=upper/0/u,workdir=upper/0/w
> $ mv base/upper/0/ base/lower/
> $ find mnt/0
>   mnt/0
>   mnt/0/w
>   find: 'mnt/0/w/work': Too many levels of symbolic links
>   find: 'mnt/0/u': Too many levels of symbolic links
>
> Reported-by: syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Miklos,
>
> I realized it was very low hanging to also verify layers are
> not overlapping with upperdir/workdir "in-use" by other instances.
>
> I tested this work with new xfstest [1]. this patch was tested
> on top of my ovl-fixes [2] branch, although it does not depend on
> anything from that branch.
>
> The commit "ovl: relax WARN_ON() for overlapping layers use case"
> at the HEAD of ovl-fixes is either redundant or complementary to this
> patch, up to you. I left it there because I figured it would be easier
> to backport than this patch.
>
> Othen than that, there are two other for-stable fixes waiting for you
> on ovl-fixes. Neither of those fixes are urgent IMO.
>
> Thanks,
> Amir.
>

Ping.

> Changes since v1:
> - Check for layers overlapping with OVL_INUSE dirs
> - Return EBUSY for layers overlapping upper/work dirs
> - Return ELOOP for conflicting layers instead of EEXIST
> - Do not report "conflicting layers" on ENOMEM (Vivek)
>
> [1] https://github.com/amir73il/xfstests/commit/7b90ac83a41e13f8e64e682b60eb371a89eccfd8
> [2] https://github.com/amir73il/linux/commits/ovl-fixes
>
>  fs/overlayfs/inode.c     |  48 +++++++++++
>  fs/overlayfs/namei.c     |   8 ++
>  fs/overlayfs/overlayfs.h |   3 +
>  fs/overlayfs/ovl_entry.h |   6 ++
>  fs/overlayfs/super.c     | 168 +++++++++++++++++++++++++++++++++++----
>  fs/overlayfs/util.c      |  12 +++
>  6 files changed, 228 insertions(+), 17 deletions(-)
>
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index b48273e846ad..f7eba21effa5 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -777,6 +777,54 @@ struct inode *ovl_lookup_inode(struct super_block *sb, struct dentry *real,
>         return inode;
>  }
>
> +bool ovl_lookup_trap_inode(struct super_block *sb, struct dentry *dir)
> +{
> +       struct inode *key = d_inode(dir);
> +       struct inode *trap;
> +       bool res;
> +
> +       trap = ilookup5(sb, (unsigned long) key, ovl_inode_test, key);
> +       if (!trap)
> +               return false;
> +
> +       res = IS_DEADDIR(trap) && !ovl_inode_upper(trap) &&
> +                                 !ovl_inode_lower(trap);
> +
> +       iput(trap);
> +       return res;
> +}
> +
> +/*
> + * Create an inode cache entry for layer root dir, that will intentionally
> + * fail ovl_verify_inode(), so any lookup that will find some layer root
> + * will fail.
> + */
> +struct inode *ovl_get_trap_inode(struct super_block *sb, struct dentry *dir)
> +{
> +       struct inode *key = d_inode(dir);
> +       struct inode *trap;
> +
> +       if (!d_is_dir(dir))
> +               return ERR_PTR(-ENOTDIR);
> +
> +       trap = iget5_locked(sb, (unsigned long) key, ovl_inode_test,
> +                           ovl_inode_set, key);
> +       if (!trap)
> +               return ERR_PTR(-ENOMEM);
> +
> +       if (!(trap->i_state & I_NEW)) {
> +               /* Conflicting layer roots? */
> +               iput(trap);
> +               return ERR_PTR(-ELOOP);
> +       }
> +
> +       trap->i_mode = S_IFDIR;
> +       trap->i_flags = S_DEAD;
> +       unlock_new_inode(trap);
> +
> +       return trap;
> +}
> +
>  /*
>   * Does overlay inode need to be hashed by lower inode?
>   */
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index efd372312ef1..badf039267a2 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -18,6 +18,7 @@
>  #include "overlayfs.h"
>
>  struct ovl_lookup_data {
> +       struct super_block *sb;
>         struct qstr name;
>         bool is_dir;
>         bool opaque;
> @@ -244,6 +245,12 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
>                 if (!d->metacopy || d->last)
>                         goto out;
>         } else {
> +               if (ovl_lookup_trap_inode(d->sb, this)) {
> +                       /* Caught in a trap of overlapping layers */
> +                       err = -ELOOP;
> +                       goto out_err;
> +               }
> +
>                 if (last_element)
>                         d->is_dir = true;
>                 if (d->last)
> @@ -819,6 +826,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
>         int err;
>         bool metacopy = false;
>         struct ovl_lookup_data d = {
> +               .sb = dentry->d_sb,
>                 .name = dentry->d_name,
>                 .is_dir = false,
>                 .opaque = false,
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index d26efed9f80a..cec40077b522 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -270,6 +270,7 @@ void ovl_clear_flag(unsigned long flag, struct inode *inode);
>  bool ovl_test_flag(unsigned long flag, struct inode *inode);
>  bool ovl_inuse_trylock(struct dentry *dentry);
>  void ovl_inuse_unlock(struct dentry *dentry);
> +bool ovl_is_inuse(struct dentry *dentry);
>  bool ovl_need_index(struct dentry *dentry);
>  int ovl_nlink_start(struct dentry *dentry);
>  void ovl_nlink_end(struct dentry *dentry);
> @@ -376,6 +377,8 @@ struct ovl_inode_params {
>  struct inode *ovl_new_inode(struct super_block *sb, umode_t mode, dev_t rdev);
>  struct inode *ovl_lookup_inode(struct super_block *sb, struct dentry *real,
>                                bool is_upper);
> +bool ovl_lookup_trap_inode(struct super_block *sb, struct dentry *dir);
> +struct inode *ovl_get_trap_inode(struct super_block *sb, struct dentry *dir);
>  struct inode *ovl_get_inode(struct super_block *sb,
>                             struct ovl_inode_params *oip);
>  static inline void ovl_copyattr(struct inode *from, struct inode *to)
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index ec237035333a..6ed1ace8f8b3 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -29,6 +29,8 @@ struct ovl_sb {
>
>  struct ovl_layer {
>         struct vfsmount *mnt;
> +       /* Trap in ovl inode cache */
> +       struct inode *trap;
>         struct ovl_sb *fs;
>         /* Index of this layer in fs root (upper idx == 0) */
>         int idx;
> @@ -65,6 +67,10 @@ struct ovl_fs {
>         /* Did we take the inuse lock? */
>         bool upperdir_locked;
>         bool workdir_locked;
> +       /* Traps in ovl inode cache */
> +       struct inode *upperdir_trap;
> +       struct inode *workdir_trap;
> +       struct inode *indexdir_trap;
>         /* Inode numbers in all layers do not use the high xino_bits */
>         unsigned int xino_bits;
>  };
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 0116735cc321..9e6d3c8336a8 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -217,6 +217,9 @@ static void ovl_free_fs(struct ovl_fs *ofs)
>  {
>         unsigned i;
>
> +       iput(ofs->indexdir_trap);
> +       iput(ofs->workdir_trap);
> +       iput(ofs->upperdir_trap);
>         dput(ofs->indexdir);
>         dput(ofs->workdir);
>         if (ofs->workdir_locked)
> @@ -225,8 +228,10 @@ static void ovl_free_fs(struct ovl_fs *ofs)
>         if (ofs->upperdir_locked)
>                 ovl_inuse_unlock(ofs->upper_mnt->mnt_root);
>         mntput(ofs->upper_mnt);
> -       for (i = 0; i < ofs->numlower; i++)
> +       for (i = 0; i < ofs->numlower; i++) {
> +               iput(ofs->lower_layers[i].trap);
>                 mntput(ofs->lower_layers[i].mnt);
> +       }
>         for (i = 0; i < ofs->numlowerfs; i++)
>                 free_anon_bdev(ofs->lower_fs[i].pseudo_dev);
>         kfree(ofs->lower_layers);
> @@ -984,7 +989,25 @@ static const struct xattr_handler *ovl_xattr_handlers[] = {
>         NULL
>  };
>
> -static int ovl_get_upper(struct ovl_fs *ofs, struct path *upperpath)
> +static int ovl_setup_trap(struct super_block *sb, struct dentry *dir,
> +                         struct inode **ptrap, const char *name)
> +{
> +       struct inode *trap;
> +       int err;
> +
> +       trap = ovl_get_trap_inode(sb, dir);
> +       err = PTR_ERR(trap);
> +       if (IS_ERR(trap) && err == -ELOOP) {
> +               pr_err("overlayfs: conflicting %s path\n", name);
> +               return err;
> +       }
> +
> +       *ptrap = trap;
> +       return 0;
> +}
> +
> +static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
> +                        struct path *upperpath)
>  {
>         struct vfsmount *upper_mnt;
>         int err;
> @@ -1004,6 +1027,11 @@ static int ovl_get_upper(struct ovl_fs *ofs, struct path *upperpath)
>         if (err)
>                 goto out;
>
> +       err = ovl_setup_trap(sb, upperpath->dentry, &ofs->upperdir_trap,
> +                            "upperdir");
> +       if (err)
> +               goto out;
> +
>         upper_mnt = clone_private_mount(upperpath);
>         err = PTR_ERR(upper_mnt);
>         if (IS_ERR(upper_mnt)) {
> @@ -1030,7 +1058,8 @@ static int ovl_get_upper(struct ovl_fs *ofs, struct path *upperpath)
>         return err;
>  }
>
> -static int ovl_make_workdir(struct ovl_fs *ofs, struct path *workpath)
> +static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
> +                           struct path *workpath)
>  {
>         struct vfsmount *mnt = ofs->upper_mnt;
>         struct dentry *temp;
> @@ -1045,6 +1074,10 @@ static int ovl_make_workdir(struct ovl_fs *ofs, struct path *workpath)
>         if (!ofs->workdir)
>                 goto out;
>
> +       err = ovl_setup_trap(sb, ofs->workdir, &ofs->workdir_trap, "workdir");
> +       if (err)
> +               goto out;
> +
>         /*
>          * Upper should support d_type, else whiteouts are visible.  Given
>          * workdir and upper are on same fs, we can do iterate_dir() on
> @@ -1105,7 +1138,8 @@ static int ovl_make_workdir(struct ovl_fs *ofs, struct path *workpath)
>         return err;
>  }
>
> -static int ovl_get_workdir(struct ovl_fs *ofs, struct path *upperpath)
> +static int ovl_get_workdir(struct super_block *sb, struct ovl_fs *ofs,
> +                          struct path *upperpath)
>  {
>         int err;
>         struct path workpath = { };
> @@ -1136,19 +1170,16 @@ static int ovl_get_workdir(struct ovl_fs *ofs, struct path *upperpath)
>                 pr_warn("overlayfs: workdir is in-use by another mount, accessing files from both mounts will result in undefined behavior.\n");
>         }
>
> -       err = ovl_make_workdir(ofs, &workpath);
> -       if (err)
> -               goto out;
> +       err = ovl_make_workdir(sb, ofs, &workpath);
>
> -       err = 0;
>  out:
>         path_put(&workpath);
>
>         return err;
>  }
>
> -static int ovl_get_indexdir(struct ovl_fs *ofs, struct ovl_entry *oe,
> -                           struct path *upperpath)
> +static int ovl_get_indexdir(struct super_block *sb, struct ovl_fs *ofs,
> +                           struct ovl_entry *oe, struct path *upperpath)
>  {
>         struct vfsmount *mnt = ofs->upper_mnt;
>         int err;
> @@ -1167,6 +1198,11 @@ static int ovl_get_indexdir(struct ovl_fs *ofs, struct ovl_entry *oe,
>
>         ofs->indexdir = ovl_workdir_create(ofs, OVL_INDEXDIR_NAME, true);
>         if (ofs->indexdir) {
> +               err = ovl_setup_trap(sb, ofs->indexdir, &ofs->indexdir_trap,
> +                                    "indexdir");
> +               if (err)
> +                       goto out;
> +
>                 /*
>                  * Verify upper root is exclusively associated with index dir.
>                  * Older kernels stored upper fh in "trusted.overlay.origin"
> @@ -1254,8 +1290,8 @@ static int ovl_get_fsid(struct ovl_fs *ofs, const struct path *path)
>         return ofs->numlowerfs;
>  }
>
> -static int ovl_get_lower_layers(struct ovl_fs *ofs, struct path *stack,
> -                               unsigned int numlower)
> +static int ovl_get_lower_layers(struct super_block *sb, struct ovl_fs *ofs,
> +                               struct path *stack, unsigned int numlower)
>  {
>         int err;
>         unsigned int i;
> @@ -1273,16 +1309,28 @@ static int ovl_get_lower_layers(struct ovl_fs *ofs, struct path *stack,
>
>         for (i = 0; i < numlower; i++) {
>                 struct vfsmount *mnt;
> +               struct inode *trap;
>                 int fsid;
>
>                 err = fsid = ovl_get_fsid(ofs, &stack[i]);
>                 if (err < 0)
>                         goto out;
>
> +               err = -EBUSY;
> +               if (ovl_is_inuse(stack[i].dentry)) {
> +                       pr_err("overlayfs: lowerdir is in-use as upperdir/workdir\n");
> +                       goto out;
> +               }
> +
> +               err = ovl_setup_trap(sb, stack[i].dentry, &trap, "lowerdir");
> +               if (err)
> +                       goto out;
> +
>                 mnt = clone_private_mount(&stack[i]);
>                 err = PTR_ERR(mnt);
>                 if (IS_ERR(mnt)) {
>                         pr_err("overlayfs: failed to clone lowerpath\n");
> +                       iput(trap);
>                         goto out;
>                 }
>
> @@ -1292,6 +1340,7 @@ static int ovl_get_lower_layers(struct ovl_fs *ofs, struct path *stack,
>                  */
>                 mnt->mnt_flags |= MNT_READONLY | MNT_NOATIME;
>
> +               ofs->lower_layers[ofs->numlower].trap = trap;
>                 ofs->lower_layers[ofs->numlower].mnt = mnt;
>                 ofs->lower_layers[ofs->numlower].idx = i + 1;
>                 ofs->lower_layers[ofs->numlower].fsid = fsid;
> @@ -1386,7 +1435,7 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
>                 goto out_err;
>         }
>
> -       err = ovl_get_lower_layers(ofs, stack, numlower);
> +       err = ovl_get_lower_layers(sb, ofs, stack, numlower);
>         if (err)
>                 goto out_err;
>
> @@ -1418,6 +1467,85 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
>         goto out;
>  }
>
> +/*
> + * Check if this layer root is a decendant of:
> + * - another layer of this overlayfs instance
> + * - upper/work dir of any overlayfs instance
> + * - a disconnected dentry (detached root)
> + */
> +static int ovl_check_layer(struct super_block *sb, struct dentry *dentry,
> +                          const char *name)
> +{
> +       struct dentry *next, *parent;
> +       bool is_root = false;
> +       int err = 0;
> +
> +       if (!dentry || dentry == dentry->d_sb->s_root)
> +               return 0;
> +
> +       next = dget(dentry);
> +       /* Walk back ancestors to fs root (inclusive) looking for traps */
> +       do {
> +               parent = dget_parent(next);
> +               is_root = (parent == next);
> +               if (ovl_is_inuse(parent)) {
> +                       err = -EBUSY;
> +                       pr_err("overlayfs: %s path overlapping in-use upperdir/workdir\n",
> +                              name);
> +               } else if (ovl_lookup_trap_inode(sb, parent)) {
> +                       err = -ELOOP;
> +                       pr_err("overlayfs: overlapping %s path\n", name);
> +               }
> +               dput(next);
> +               next = parent;
> +       } while (!err && !is_root);
> +
> +       /* Did we really walk to fs root or found a detached root? */
> +       if (!err && next != dentry->d_sb->s_root) {
> +               err = -ESTALE;
> +               pr_err("overlayfs: disconnected %s path\n", name);
> +       }
> +
> +       dput(next);
> +
> +       return err;
> +}
> +
> +/*
> + * Check if any of the layers or work dirs overlap.
> + */
> +static int ovl_check_overlapping_layers(struct super_block *sb,
> +                                       struct ovl_fs *ofs)
> +{
> +       int i, err;
> +
> +       if (ofs->upper_mnt) {
> +               err = ovl_check_layer(sb, ofs->upper_mnt->mnt_root, "upperdir");
> +               if (err)
> +                       return err;
> +
> +               /*
> +                * Checking workbasedir avoids hitting ovl_is_inuse(parent) of
> +                * this instance and covers overlapping work and index dirs,
> +                * unless work or index dir have been moved since created inside
> +                * workbasedir.  In that case, we already have their traps in
> +                * inode cache and we will catch that case on lookup.
> +                */
> +               err = ovl_check_layer(sb, ofs->workbasedir, "workdir");
> +               if (err)
> +                       return err;
> +       }
> +
> +       for (i = 0; i < ofs->numlower; i++) {
> +               err = ovl_check_layer(sb, ofs->lower_layers[i].mnt->mnt_root,
> +                                     "lowerdir");
> +               if (err)
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +
>  static int ovl_fill_super(struct super_block *sb, void *data, int silent)
>  {
>         struct path upperpath = { };
> @@ -1457,17 +1585,20 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
>         if (ofs->config.xino != OVL_XINO_OFF)
>                 ofs->xino_bits = BITS_PER_LONG - 32;
>
> +       /* alloc/destroy_inode needed for setting up traps in inode cache */
> +       sb->s_op = &ovl_super_operations;
> +
>         if (ofs->config.upperdir) {
>                 if (!ofs->config.workdir) {
>                         pr_err("overlayfs: missing 'workdir'\n");
>                         goto out_err;
>                 }
>
> -               err = ovl_get_upper(ofs, &upperpath);
> +               err = ovl_get_upper(sb, ofs, &upperpath);
>                 if (err)
>                         goto out_err;
>
> -               err = ovl_get_workdir(ofs, &upperpath);
> +               err = ovl_get_workdir(sb, ofs, &upperpath);
>                 if (err)
>                         goto out_err;
>
> @@ -1488,7 +1619,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
>                 sb->s_flags |= SB_RDONLY;
>
>         if (!(ovl_force_readonly(ofs)) && ofs->config.index) {
> -               err = ovl_get_indexdir(ofs, oe, &upperpath);
> +               err = ovl_get_indexdir(sb, ofs, oe, &upperpath);
>                 if (err)
>                         goto out_free_oe;
>
> @@ -1501,6 +1632,10 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
>
>         }
>
> +       err = ovl_check_overlapping_layers(sb, ofs);
> +       if (err)
> +               goto out_free_oe;
> +
>         /* Show index=off in /proc/mounts for forced r/o mount */
>         if (!ofs->indexdir) {
>                 ofs->config.index = false;
> @@ -1522,7 +1657,6 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
>         cap_lower(cred->cap_effective, CAP_SYS_RESOURCE);
>
>         sb->s_magic = OVERLAYFS_SUPER_MAGIC;
> -       sb->s_op = &ovl_super_operations;
>         sb->s_xattr = ovl_xattr_handlers;
>         sb->s_fs_info = ofs;
>         sb->s_flags |= SB_POSIXACL;
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 4035e640f402..e135064e87ad 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -652,6 +652,18 @@ void ovl_inuse_unlock(struct dentry *dentry)
>         }
>  }
>
> +bool ovl_is_inuse(struct dentry *dentry)
> +{
> +       struct inode *inode = d_inode(dentry);
> +       bool inuse;
> +
> +       spin_lock(&inode->i_lock);
> +       inuse = (inode->i_state & I_OVL_INUSE);
> +       spin_unlock(&inode->i_lock);
> +
> +       return inuse;
> +}
> +
>  /*
>   * Does this overlay dentry need to be indexed on copy up?
>   */
> --
> 2.17.1
>
