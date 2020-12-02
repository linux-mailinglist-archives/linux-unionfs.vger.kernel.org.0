Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252232CC05F
	for <lists+linux-unionfs@lfdr.de>; Wed,  2 Dec 2020 16:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgLBPJW (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 2 Dec 2020 10:09:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27206 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730264AbgLBPJW (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 2 Dec 2020 10:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606921674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v6LoCnXCOZFTRxO1qKhTnYC4bSjIoMSh4G/XFMQkuJU=;
        b=jI0tNPZ5+7Vx/RODF4j6Vg4SH0L5xH5exKwjfg1bifYa+MR/31E8qlgLz7LR6/wMNbZVWV
        G8Ua8iV/RDziuZkOG3JSY7kwztq4lQUV2FwSgW5SiECnnRFALL+lU5U9Txxv96EouHBV0C
        bmaUxrYz2HW/kFenLw1BtMMdiVU4WmM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-Sz9bfsChMGCmlAhLxTT6fQ-1; Wed, 02 Dec 2020 10:07:50 -0500
X-MC-Unique: Sz9bfsChMGCmlAhLxTT6fQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A827D805BFB;
        Wed,  2 Dec 2020 15:07:48 +0000 (UTC)
Received: from horse.redhat.com (ovpn-117-99.rdu2.redhat.com [10.10.117.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CBE118F0A;
        Wed,  2 Dec 2020 15:07:48 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A53A622054F; Wed,  2 Dec 2020 10:07:47 -0500 (EST)
Date:   Wed, 2 Dec 2020 10:07:47 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] overlay: Implement volatile-specific fsync error
 behaviour
Message-ID: <20201202150747.GB147783@redhat.com>
References: <20201202092720.41522-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202092720.41522-1-sargun@sargun.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Dec 02, 2020 at 01:27:20AM -0800, Sargun Dhillon wrote:
> Overlayfs's volatile option allows the user to bypass all forced sync calls
> to the upperdir filesystem. This comes at the cost of safety. We can never
> ensure that the user's data is intact, but we can make a best effort to
> expose whether or not the data is likely to be in a bad state.
> 
> We decided[1] that the best way to handle this in the time being is that if
> an overlayfs's upperdir experiences an error after a volatile mount occurs,
> that error will be returned on fsync, fdatasync, sync, and syncfs. This is
> contradictory to the traditional behaviour of VFS which fails the call
> once, and only raises an error if a subsequent fsync error has occured,
> and been raised by the filesystem.
> 
> One awkward aspect of the patch is that we have to manually set the
> superblock's errseq_t after the sync_fs callback as opposed to just
> returning an error from syncfs. This is because the call chain looks
> something like this:
> 
> sys_syncfs ->
> 	sync_filesystem ->
> 		__sync_filesystem ->
> 			/* The return value is ignored here
> 			sb->s_op->sync_fs(sb)
> 			_sync_blockdev
> 		/* Where the VFS fetches the error to raise to userspace */
> 		errseq_check_and_advance
> 
> Because of this we call errseq_set every time the sync_fs callback occurs.
> 
> [1]: https://lore.kernel.org/linux-fsdevel/36d820394c3e7cd1faa1b28a8135136d5001dadd.camel@redhat.com/T/#u
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-unionfs@vger.kernel.org
> Cc: Jeff Layton <jlayton@redhat.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> ---
>  Documentation/filesystems/overlayfs.rst |  8 ++++++++
>  fs/overlayfs/file.c                     |  5 +++--
>  fs/overlayfs/overlayfs.h                |  1 +
>  fs/overlayfs/ovl_entry.h                |  2 ++
>  fs/overlayfs/readdir.c                  |  5 +++--
>  fs/overlayfs/super.c                    | 24 +++++++++++++++-------
>  fs/overlayfs/util.c                     | 27 +++++++++++++++++++++++++
>  7 files changed, 61 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
> index 580ab9a0fe31..3af569cea6a7 100644
> --- a/Documentation/filesystems/overlayfs.rst
> +++ b/Documentation/filesystems/overlayfs.rst
> @@ -575,6 +575,14 @@ without significant effort.
>  The advantage of mounting with the "volatile" option is that all forms of
>  sync calls to the upper filesystem are omitted.
>  
> +In order to avoid a giving a false sense of safety, the syncfs (and fsync)
> +semantics of volatile mounts are slightly different than that of the rest of
> +VFS.  If any error occurs on the upperdir's filesystem after a volatile mount
> +takes place, all sync functions will return the last error observed on the
> +upperdir filesystem.  Once this condition is reached, the filesystem will not
> +recover, and every subsequent sync call will return an error, even if the
> +upperdir has not experience a new error since the last sync call.
> +
>  When overlay is mounted with "volatile" option, the directory
>  "$workdir/work/incompat/volatile" is created.  During next mount, overlay
>  checks for this directory and refuses to mount if present. This is a strong
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 802259f33c28..2479b297a966 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -445,8 +445,9 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>  	const struct cred *old_cred;
>  	int ret;
>  
> -	if (!ovl_should_sync(OVL_FS(file_inode(file)->i_sb)))
> -		return 0;
> +	ret = ovl_check_sync(OVL_FS(file_inode(file)->i_sb));
> +	if (ret <= 0)
> +		return ret;
>  
>  	ret = ovl_real_fdget_meta(file, &real, !datasync);
>  	if (ret)
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index f8880aa2ba0e..af79c3a2392e 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -322,6 +322,7 @@ int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct dentry *dentry);
>  bool ovl_is_metacopy_dentry(struct dentry *dentry);
>  char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
>  			     int padding);
> +int ovl_check_sync(struct ovl_fs *ofs);
>  
>  static inline bool ovl_is_impuredir(struct super_block *sb,
>  				    struct dentry *dentry)
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index 1b5a2094df8e..9460a52abea3 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -79,6 +79,8 @@ struct ovl_fs {
>  	atomic_long_t last_ino;
>  	/* Whiteout dentry cache */
>  	struct dentry *whiteout;
> +	/* snapshot of upperdir's errseq_t at mount time for volatile mounts */
> +	errseq_t upper_errseq;
>  };
>  
>  static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 01620ebae1bd..f7f1a29e290f 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -909,8 +909,9 @@ static int ovl_dir_fsync(struct file *file, loff_t start, loff_t end,
>  	struct file *realfile;
>  	int err;
>  
> -	if (!ovl_should_sync(OVL_FS(file->f_path.dentry->d_sb)))
> -		return 0;
> +	err = ovl_check_sync(OVL_FS(file->f_path.dentry->d_sb));
> +	if (err <= 0)
> +		return err;
>  
>  	realfile = ovl_dir_real_file(file, true);
>  	err = PTR_ERR_OR_ZERO(realfile);
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 290983bcfbb3..82a096a05bce 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -261,11 +261,18 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
>  	struct super_block *upper_sb;
>  	int ret;
>  
> -	if (!ovl_upper_mnt(ofs))
> -		return 0;
> +	ret = ovl_check_sync(ofs);
> +	/*
> +	 * We have to always set the err, because the return value isn't
> +	 * checked, and instead VFS looks at the writeback errseq after
> +	 * this call.
> +	 */
> +	if (ret < 0)
> +		errseq_set(&sb->s_wb_err, ret);

I was wondering that why errseq_set() will result in returning error
all the time. Then realized that last syncfs() call must have set
ERRSEQ_SEEN flag and that will mean errseq_set() will increment
counter and that means this syncfs() will will return error too. Cool.

> +
> +	if (!ret)
> +		return ret;
>  
> -	if (!ovl_should_sync(ofs))
> -		return 0;
>  	/*
>  	 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
>  	 * All the super blocks will be iterated, including upper_sb.
> @@ -1927,6 +1934,8 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
>  	sb->s_op = &ovl_super_operations;
>  
>  	if (ofs->config.upperdir) {
> +		struct super_block *upper_mnt_sb;
> +
>  		if (!ofs->config.workdir) {
>  			pr_err("missing 'workdir'\n");
>  			goto out_err;
> @@ -1943,9 +1952,10 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
>  		if (!ofs->workdir)
>  			sb->s_flags |= SB_RDONLY;
>  
> -		sb->s_stack_depth = ovl_upper_mnt(ofs)->mnt_sb->s_stack_depth;
> -		sb->s_time_gran = ovl_upper_mnt(ofs)->mnt_sb->s_time_gran;
> -
> +		upper_mnt_sb = ovl_upper_mnt(ofs)->mnt_sb;
> +		sb->s_stack_depth = upper_mnt_sb->s_stack_depth;
> +		sb->s_time_gran = upper_mnt_sb->s_time_gran;
> +		ofs->upper_errseq = errseq_sample(&upper_mnt_sb->s_wb_err);

I asked this question in last email as well. errseq_sample() will return
0 if current error has not been seen yet. That means next time a sync
call comes for volatile mount, it will return an error. But that's
not what we want. When we mounted a volatile overlay, if there is an
existing error (seen/unseen), we don't care. We only care if there
is a new error after the volatile mount, right?

I guess we will need another helper similar to errseq_smaple() which
just returns existing value of errseq. And then we will have to
do something about errseq_check() to not return an error if "since"
and "eseq" differ only by "seen" bit.

Otherwise in current form, volatile mount will always return error
if upperdir has error and it has not been seen by anybody.

How did you finally end up testing the error case. Want to simualate
error aritificially and test it.

>  	}
>  	oe = ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
>  	err = PTR_ERR(oe);
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 23f475627d07..9b460cd7b151 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -950,3 +950,30 @@ char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
>  	kfree(buf);
>  	return ERR_PTR(res);
>  }
> +
> +/*
> + * ovl_check_sync provides sync checking, and safety for volatile mounts
> + *
> + * Returns 1 if sync required.
> + *
> + * Returns 0 if syncing can be skipped because mount is volatile, and no errors
> + * have occurred on the upperdir since the mount.
> + *
> + * Returns -errno if it is a volatile mount, and the error that occurred since
> + * the last mount. If the error code changes, it'll return the latest error
> + * code.
> + */
> +
> +int ovl_check_sync(struct ovl_fs *ofs)
> +{
> +	struct vfsmount *mnt;
> +
> +	if (ovl_should_sync(ofs))
> +		return 1;
> +
> +	mnt = ovl_upper_mnt(ofs);
> +	if (!mnt)
> +		return 0;
> +
> +	return errseq_check(&mnt->mnt_sb->s_wb_err, ofs->upper_errseq);

I guess we can do another patch later to set one global flag in overlayfs
super block and use that flag to return errors on other paths like 
read/write etc. But that's for a separate patch later.

Thanks
Vivek

