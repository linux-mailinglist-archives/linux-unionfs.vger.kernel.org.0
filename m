Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554204ED86D
	for <lists+linux-unionfs@lfdr.de>; Thu, 31 Mar 2022 13:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbiCaL0V (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 31 Mar 2022 07:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbiCaL0T (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 31 Mar 2022 07:26:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110486257
        for <linux-unionfs@vger.kernel.org>; Thu, 31 Mar 2022 04:24:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93BFC614ED
        for <linux-unionfs@vger.kernel.org>; Thu, 31 Mar 2022 11:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295C7C340ED;
        Thu, 31 Mar 2022 11:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648725871;
        bh=ejX0adYSjT8yZ2cNEkiZD0b0OjMCMl47AtqYtz1Xc+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pW09nBW5dU8gQlnx1ftTMHrLIzNQMIgeFw2/f0rXzv2hEkJ7PuWICvnp/DozefnJG
         fltRd0iKmfTqA/vu4k/I0fHMlodH/gYNj3TX+9Fohxbp9IoLUW4u2O7jVyGHgi0XP/
         67aQcH5r+Y4k7pykChgmOyL5w9A+C5ucYC3c91SmAx4M41cnDYmKIUXAyXl7/9QqBF
         owieusf0p+mZl3PvYrtXNkCU8hKftxibHiwfBWLRYVmiKQk+0kxVsRvvuugfUsSRBO
         03Prgr1dgtXtdvnk5mJ3IZu88klW8RGzUzBsrGgABzqjVahZo++OGFTy287ML4kn+L
         xe9nlERWDZHmw==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-unionfs@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos Catelin <rodrigo@sdfg.com.ar>,
        Seth Forshee <sforshee@digitalocean.com>,
        Luca Bocassi <luca.boccassi@microsoft.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>
Subject: [PATCH v3 11/19] ovl: use ovl_path_getxattr() wrapper
Date:   Thu, 31 Mar 2022 13:23:09 +0200
Message-Id: <20220331112318.1377494-12-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220331112318.1377494-1-brauner@kernel.org>
References: <20220331112318.1377494-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16290; h=from:subject; bh=ejX0adYSjT8yZ2cNEkiZD0b0OjMCMl47AtqYtz1Xc+A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS59kvN/tj2iKl7xg/+2ycjGU6x5V3rP6JQ/J9dM1ut4pXc 9t/LO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbS9YXhf/ij/W2ResGsRluXsay7XF ou0L3//549ocvWvGqM5FvevYHhf9yl2muzAxt7/u8Wbe88of4mcpbO5dlVGhPbp9tGKLvYswMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Add a helper that allows to retrieve ovl xattrs from either lower or
upper layers. To stop passing mnt and dentry separately everywhere use
struct path which more accurately reflects the tight coupling between
mount and dentry in this helper. Swich over all places to pass a path
argument that can operate on either upper or lower layers. This is
needed to support idmapped base layers with overlayfs.

Cc: <linux-unionfs@vger.kernel.org>
Tested-by: Giuseppe Scrivano <gscrivan@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
/* v2 */
unchanged

/* v3 */
unchanged
---
 fs/overlayfs/copy_up.c   | 18 +++++++-----
 fs/overlayfs/dir.c       |  2 +-
 fs/overlayfs/inode.c     |  7 ++++-
 fs/overlayfs/namei.c     | 29 +++++++++++++------
 fs/overlayfs/overlayfs.h | 62 +++++++++++++++++++++++++++++-----------
 fs/overlayfs/util.c      | 25 ++++++++--------
 6 files changed, 95 insertions(+), 48 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 19b5f75d1fe2..957c14f9124c 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -44,10 +44,10 @@ static bool ovl_must_copy_xattr(const char *name)
 	       !strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN);
 }
 
-int ovl_copy_xattr(struct super_block *sb, struct dentry *old,
-		   struct dentry *new)
+int ovl_copy_xattr(struct super_block *sb, struct path *path, struct dentry *new)
 {
 	struct ovl_fs *ofs = OVL_FS(sb);
+	struct dentry *old = path->dentry;
 	ssize_t list_size, size, value_size = 0;
 	char *buf, *name, *value = NULL;
 	int error = 0;
@@ -95,9 +95,9 @@ int ovl_copy_xattr(struct super_block *sb, struct dentry *old,
 			continue; /* Discard */
 		}
 retry:
-		size = vfs_getxattr(&init_user_ns, old, name, value, value_size);
+		size = ovl_do_getxattr(path, name, value, value_size);
 		if (size == -ERANGE)
-			size = vfs_getxattr(&init_user_ns, old, name, NULL, 0);
+			size = ovl_do_getxattr(path, name, NULL, 0);
 
 		if (size < 0) {
 			error = size;
@@ -583,7 +583,7 @@ static int ovl_copy_up_inode(struct ovl_copy_up_ctx *c, struct dentry *temp)
 			return err;
 	}
 
-	err = ovl_copy_xattr(c->dentry->d_sb, c->lowerpath.dentry, temp);
+	err = ovl_copy_xattr(c->dentry->d_sb, &c->lowerpath, temp);
 	if (err)
 		return err;
 
@@ -879,8 +879,12 @@ static ssize_t ovl_getxattr_value(struct ovl_fs *ofs, struct dentry *dentry,
 {
 	ssize_t res;
 	char *buf;
+	struct path upperpath = {
+		.dentry = dentry,
+		.mnt = ovl_upper_mnt(ofs),
+	};
 
-	res = ovl_do_getxattr(ofs, dentry, name, NULL, 0);
+	res = ovl_do_getxattr(&upperpath, name, NULL, 0);
 	if (res == -ENODATA || res == -EOPNOTSUPP)
 		res = 0;
 
@@ -889,7 +893,7 @@ static ssize_t ovl_getxattr_value(struct ovl_fs *ofs, struct dentry *dentry,
 		if (!buf)
 			return -ENOMEM;
 
-		res = ovl_do_getxattr(ofs, dentry, name, buf, res);
+		res = ovl_do_getxattr(&upperpath, name, buf, res);
 		if (res < 0)
 			kfree(buf);
 		else
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index d470eedfd42c..cacb34c0094d 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -398,7 +398,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	if (IS_ERR(opaquedir))
 		goto out_unlock;
 
-	err = ovl_copy_xattr(dentry->d_sb, upper, opaquedir);
+	err = ovl_copy_xattr(dentry->d_sb, &upperpath, opaquedir);
 	if (err)
 		goto out_cleanup;
 
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 9a8e6b94d9e8..763dada2ae68 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -1176,8 +1176,13 @@ struct inode *ovl_get_inode(struct super_block *sb,
 
 	/* Check for non-merge dir that may have whiteouts */
 	if (is_dir) {
+		struct path realpath = {
+			.dentry = upperdentry ?: lowerdentry,
+			.mnt = upperdentry ? ovl_upper_mnt(ofs) : lowerpath->layer->mnt,
+		};
+
 		if (((upperdentry && lowerdentry) || oip->numlower > 1) ||
-		    ovl_check_origin_xattr(ofs, upperdentry ?: lowerdentry)) {
+		    ovl_path_check_origin_xattr(ofs, &realpath)) {
 			ovl_set_flag(OVL_WHITEOUTS, inode);
 		}
 	}
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 042f6394a3d5..32f9d9089059 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -16,6 +16,7 @@
 
 struct ovl_lookup_data {
 	struct super_block *sb;
+	struct vfsmount *mnt;
 	struct qstr name;
 	bool is_dir;
 	bool opaque;
@@ -25,14 +26,14 @@ struct ovl_lookup_data {
 	bool metacopy;
 };
 
-static int ovl_check_redirect(struct dentry *dentry, struct ovl_lookup_data *d,
+static int ovl_check_redirect(struct path *path, struct ovl_lookup_data *d,
 			      size_t prelen, const char *post)
 {
 	int res;
 	char *buf;
 	struct ovl_fs *ofs = OVL_FS(d->sb);
 
-	buf = ovl_get_redirect_xattr(ofs, dentry, prelen + strlen(post));
+	buf = ovl_get_redirect_xattr(ofs, path, prelen + strlen(post));
 	if (IS_ERR_OR_NULL(buf))
 		return PTR_ERR(buf);
 
@@ -193,9 +194,9 @@ struct dentry *ovl_decode_real_fh(struct ovl_fs *ofs, struct ovl_fh *fh,
 	return real;
 }
 
-static bool ovl_is_opaquedir(struct super_block *sb, struct dentry *dentry)
+static bool ovl_is_opaquedir(struct ovl_fs *ofs, struct path *path)
 {
-	return ovl_check_dir_xattr(sb, dentry, OVL_XATTR_OPAQUE);
+	return ovl_path_check_dir_xattr(ofs, path, OVL_XATTR_OPAQUE);
 }
 
 static struct dentry *ovl_lookup_positive_unlocked(const char *name,
@@ -224,6 +225,7 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 			     struct dentry **ret, bool drop_negative)
 {
 	struct dentry *this;
+	struct path path;
 	int err;
 	bool last_element = !post[0];
 
@@ -253,12 +255,15 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 		d->stop = true;
 		goto put_and_out;
 	}
+
+	path.dentry = this;
+	path.mnt = d->mnt;
 	if (!d_can_lookup(this)) {
 		if (d->is_dir || !last_element) {
 			d->stop = true;
 			goto put_and_out;
 		}
-		err = ovl_check_metacopy_xattr(OVL_FS(d->sb), this);
+		err = ovl_check_metacopy_xattr(OVL_FS(d->sb), &path);
 		if (err < 0)
 			goto out_err;
 
@@ -278,14 +283,14 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 		if (d->last)
 			goto out;
 
-		if (ovl_is_opaquedir(d->sb, this)) {
+		if (ovl_is_opaquedir(OVL_FS(d->sb), &path)) {
 			d->stop = true;
 			if (last_element)
 				d->opaque = true;
 			goto out;
 		}
 	}
-	err = ovl_check_redirect(this, d, prelen, post);
+	err = ovl_check_redirect(&path, d, prelen, post);
 	if (err)
 		goto out_err;
 out:
@@ -856,6 +861,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	old_cred = ovl_override_creds(dentry->d_sb);
 	upperdir = ovl_dentry_upper(dentry->d_parent);
 	if (upperdir) {
+		d.mnt = ovl_upper_mnt(ofs);
 		err = ovl_lookup_layer(upperdir, &d, &upperdentry, true);
 		if (err)
 			goto out;
@@ -911,6 +917,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		else
 			d.last = lower.layer->idx == roe->numlower;
 
+		d.mnt = lower.layer->mnt;
 		err = ovl_lookup_layer(lower.dentry, &d, &this, false);
 		if (err)
 			goto out_put;
@@ -1071,14 +1078,18 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	if (upperdentry)
 		ovl_dentry_set_upper_alias(dentry);
 	else if (index) {
+		struct path upperpath;
+
 		upperdentry = dget(index);
-		upperredirect = ovl_get_redirect_xattr(ofs, upperdentry, 0);
+		upperpath.dentry = upperdentry;
+		upperpath.mnt = ovl_upper_mnt(ofs);
+		upperredirect = ovl_get_redirect_xattr(ofs, &upperpath, 0);
 		if (IS_ERR(upperredirect)) {
 			err = PTR_ERR(upperredirect);
 			upperredirect = NULL;
 			goto out_free_oe;
 		}
-		err = ovl_check_metacopy_xattr(ofs, upperdentry);
+		err = ovl_check_metacopy_xattr(ofs, &upperpath);
 		if (err < 0)
 			goto out_free_oe;
 		uppermetacopy = err;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 4ecf49ce4fae..347096a3d4a3 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -216,15 +216,15 @@ static inline int ovl_do_symlink(struct ovl_fs *ofs,
 	return err;
 }
 
-static inline ssize_t ovl_do_getxattr(struct ovl_fs *ofs, struct dentry *dentry,
-				      const char *name, void *value,
-				      size_t size)
+static inline ssize_t ovl_do_getxattr(struct path *path, const char *name,
+				      void *value, size_t size)
 {
-	int err = vfs_getxattr(&init_user_ns, dentry, name, value, size);
+	int err = vfs_getxattr(mnt_user_ns(path->mnt), path->dentry,
+			       name, value, size);
 	int len = (value && err > 0) ? err : 0;
 
 	pr_debug("getxattr(%pd2, \"%s\", \"%*pE\", %zu, 0) = %i\n",
-		 dentry, name, min(len, 48), value, size, err);
+		 path->dentry, name, min(len, 48), value, size, err);
 	return err;
 }
 
@@ -232,14 +232,26 @@ static inline ssize_t ovl_getxattr(struct ovl_fs *ofs, struct dentry *dentry,
 				   enum ovl_xattr ox, void *value,
 				   size_t size)
 {
-	return ovl_do_getxattr(ofs, dentry, ovl_xattr(ofs, ox), value, size);
+	struct path upperpath = {
+		.dentry = dentry,
+		.mnt = ovl_upper_mnt(ofs),
+	};
+	return ovl_do_getxattr(&upperpath, ovl_xattr(ofs, ox), value, size);
+}
+
+static inline ssize_t ovl_path_getxattr(struct ovl_fs *ofs,
+					 struct path *path,
+					 enum ovl_xattr ox, void *value,
+					 size_t size)
+{
+	return ovl_do_getxattr(path, ovl_xattr(ofs, ox), value, size);
 }
 
 static inline int ovl_do_setxattr(struct ovl_fs *ofs, struct dentry *dentry,
 				  const char *name, const void *value,
 				  size_t size, int flags)
 {
-	int err = vfs_setxattr(&init_user_ns, dentry, name, value, size, flags);
+	int err = vfs_setxattr(ovl_upper_idmap(ofs), dentry, name, value, size, flags);
 	pr_debug("setxattr(%pd2, \"%s\", \"%*pE\", %zu, %d) = %i\n",
 		 dentry, name, min((int)size, 48), value, size, flags, err);
 	return err;
@@ -255,7 +267,7 @@ static inline int ovl_setxattr(struct ovl_fs *ofs, struct dentry *dentry,
 static inline int ovl_do_removexattr(struct ovl_fs *ofs, struct dentry *dentry,
 				     const char *name)
 {
-	int err = vfs_removexattr(&init_user_ns, dentry, name);
+	int err = vfs_removexattr(ovl_upper_idmap(ofs), dentry, name);
 	pr_debug("removexattr(%pd2, \"%s\") = %i\n", dentry, name, err);
 	return err;
 }
@@ -391,9 +403,27 @@ struct file *ovl_path_open(struct path *path, int flags);
 int ovl_copy_up_start(struct dentry *dentry, int flags);
 void ovl_copy_up_end(struct dentry *dentry);
 bool ovl_already_copied_up(struct dentry *dentry, int flags);
-bool ovl_check_origin_xattr(struct ovl_fs *ofs, struct dentry *dentry);
-bool ovl_check_dir_xattr(struct super_block *sb, struct dentry *dentry,
-			 enum ovl_xattr ox);
+bool ovl_path_check_dir_xattr(struct ovl_fs *ofs, struct path *path,
+			      enum ovl_xattr ox);
+static inline bool ovl_check_dir_xattr(struct ovl_fs *ofs,
+				       struct dentry *dentry, enum ovl_xattr ox)
+{
+	struct path upperpath = {
+		.dentry = dentry,
+		.mnt = ovl_upper_mnt(ofs),
+	};
+	return ovl_path_check_dir_xattr(ofs, &upperpath, ox);
+}
+bool ovl_path_check_origin_xattr(struct ovl_fs *ofs, struct path *path);
+static inline bool ovl_check_origin_xattr(struct ovl_fs *ofs,
+					  struct dentry *dentry)
+{
+	struct path upperpath = {
+		.dentry = dentry,
+		.mnt = ovl_upper_mnt(ofs),
+	};
+	return ovl_path_check_origin_xattr(ofs, &upperpath);
+}
 int ovl_check_setxattr(struct ovl_fs *ofs, struct dentry *upperdentry,
 		       enum ovl_xattr ox, const void *value, size_t size,
 		       int xerr);
@@ -405,10 +435,9 @@ bool ovl_need_index(struct dentry *dentry);
 int ovl_nlink_start(struct dentry *dentry);
 void ovl_nlink_end(struct dentry *dentry);
 int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *upperdir);
-int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct dentry *dentry);
+int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct path *path);
 bool ovl_is_metacopy_dentry(struct dentry *dentry);
-char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
-			     int padding);
+char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct path *path, int padding);
 int ovl_sync_status(struct ovl_fs *ofs);
 
 static inline void ovl_set_flag(unsigned long flag, struct inode *inode)
@@ -429,7 +458,7 @@ static inline bool ovl_test_flag(unsigned long flag, struct inode *inode)
 static inline bool ovl_is_impuredir(struct super_block *sb,
 				    struct dentry *dentry)
 {
-	return ovl_check_dir_xattr(sb, dentry, OVL_XATTR_IMPURE);
+	return ovl_check_dir_xattr(OVL_FS(sb), dentry, OVL_XATTR_IMPURE);
 }
 
 /*
@@ -656,8 +685,7 @@ int ovl_fileattr_set(struct user_namespace *mnt_userns,
 int ovl_copy_up(struct dentry *dentry);
 int ovl_copy_up_with_data(struct dentry *dentry);
 int ovl_maybe_copy_up(struct dentry *dentry, int flags);
-int ovl_copy_xattr(struct super_block *sb, struct dentry *old,
-		   struct dentry *new);
+int ovl_copy_xattr(struct super_block *sb, struct path *path, struct dentry *new);
 int ovl_set_attr(struct ovl_fs *ofs, struct dentry *upper, struct kstat *stat);
 struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct dentry *real,
 				  bool is_upper);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 79e5a22a3c7c..3065393d143e 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -564,11 +564,11 @@ void ovl_copy_up_end(struct dentry *dentry)
 	ovl_inode_unlock(d_inode(dentry));
 }
 
-bool ovl_check_origin_xattr(struct ovl_fs *ofs, struct dentry *dentry)
+bool ovl_path_check_origin_xattr(struct ovl_fs *ofs, struct path *path)
 {
 	int res;
 
-	res = ovl_getxattr(ofs, dentry, OVL_XATTR_ORIGIN, NULL, 0);
+	res = ovl_path_getxattr(ofs, path, OVL_XATTR_ORIGIN, NULL, 0);
 
 	/* Zero size value means "copied up but origin unknown" */
 	if (res >= 0)
@@ -577,16 +577,16 @@ bool ovl_check_origin_xattr(struct ovl_fs *ofs, struct dentry *dentry)
 	return false;
 }
 
-bool ovl_check_dir_xattr(struct super_block *sb, struct dentry *dentry,
-			 enum ovl_xattr ox)
+bool ovl_path_check_dir_xattr(struct ovl_fs *ofs, struct path *path,
+			       enum ovl_xattr ox)
 {
 	int res;
 	char val;
 
-	if (!d_is_dir(dentry))
+	if (!d_is_dir(path->dentry))
 		return false;
 
-	res = ovl_getxattr(OVL_FS(sb), dentry, ox, &val, 1);
+	res = ovl_path_getxattr(ofs, path, ox, &val, 1);
 	if (res == 1 && val == 'y')
 		return true;
 
@@ -957,15 +957,15 @@ int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *upperdir)
 }
 
 /* err < 0, 0 if no metacopy xattr, 1 if metacopy xattr found */
-int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct dentry *dentry)
+int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct path *path)
 {
 	int res;
 
 	/* Only regular files can have metacopy xattr */
-	if (!S_ISREG(d_inode(dentry)->i_mode))
+	if (!S_ISREG(d_inode(path->dentry)->i_mode))
 		return 0;
 
-	res = ovl_getxattr(ofs, dentry, OVL_XATTR_METACOPY, NULL, 0);
+	res = ovl_path_getxattr(ofs, path, OVL_XATTR_METACOPY, NULL, 0);
 	if (res < 0) {
 		if (res == -ENODATA || res == -EOPNOTSUPP)
 			return 0;
@@ -1001,13 +1001,12 @@ bool ovl_is_metacopy_dentry(struct dentry *dentry)
 	return (oe->numlower > 1);
 }
 
-char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
-			     int padding)
+char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct path *path, int padding)
 {
 	int res;
 	char *s, *next, *buf = NULL;
 
-	res = ovl_getxattr(ofs, dentry, OVL_XATTR_REDIRECT, NULL, 0);
+	res = ovl_path_getxattr(ofs, path, OVL_XATTR_REDIRECT, NULL, 0);
 	if (res == -ENODATA || res == -EOPNOTSUPP)
 		return NULL;
 	if (res < 0)
@@ -1019,7 +1018,7 @@ char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
 
-	res = ovl_getxattr(ofs, dentry, OVL_XATTR_REDIRECT, buf, res);
+	res = ovl_path_getxattr(ofs, path, OVL_XATTR_REDIRECT, buf, res);
 	if (res < 0)
 		goto fail;
 	if (res == 0)
-- 
2.32.0

