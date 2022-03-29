Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880494EAB5E
	for <lists+linux-unionfs@lfdr.de>; Tue, 29 Mar 2022 12:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiC2KiR (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 29 Mar 2022 06:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbiC2KiQ (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 29 Mar 2022 06:38:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A859F6DB
        for <linux-unionfs@vger.kernel.org>; Tue, 29 Mar 2022 03:36:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46BE961231
        for <linux-unionfs@vger.kernel.org>; Tue, 29 Mar 2022 10:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF82BC340ED;
        Tue, 29 Mar 2022 10:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648550191;
        bh=caguW/7DtopM5kVZRs8oDc4gzig/UhKjEYWMLlIA1x8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iCd8mW/8UeKcRjoAQDQ5Ho/A7kGXWUUMXs29EiejKa916KSzVlNaGJfedsLqG8p91
         c7O0wLHzROLTENnzwao5hQbkaajHvdPtAGunJmlcqvXeGU6m3kxfpzKHyt4BYMGLDp
         Snbe0JR0MgAhX1uyI88mxLe7MfQnJvrpYDKRhUz3Kv8PlUZpvw/MG8r2BHjlaLlPSV
         FAxN9eyuhGJW2+xYRfx9/LS+aR9UDn+36C0EdlxSjbFkCWyC1EW1XpIAR/4bFvk1mn
         FJfGKqvc3YiYKYp0bDiWpKG3YFQ9IQ+kCQoCo3iJnSZw8XfCxhoayZGvQt51dVN5tV
         l/TQJ0Fzx8DJg==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-unionfs@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos Catelin <rodrigoca@microsoft.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        Luca Bocassi <luca.boccassi@microsoft.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 03/18] ovl: use wrappers to all vfs_*xattr() calls
Date:   Tue, 29 Mar 2022 12:35:10 +0200
Message-Id: <20220329103526.1207086-4-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220329103526.1207086-1-brauner@kernel.org>
References: <20220329103526.1207086-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15116; i=brauner@kernel.org; h=from:subject; bh=ToX1Iw3RmS6ARNIhpgxHQvXFsmcKCRFmKeZO9R7mdBs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQ5PdiT9fc539VbIUa7nqRmvjTiyQqKUnt+qY5Hd6/rVIVz Kf++dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkwllGhuXzJX5ZhE6vT/OqTl/uwx LzKHrFHJ+HPpPt/1m1vqwQU2JkOHayRK3J7kXItFLNUsW/7NMuOG1U5XERNX8a4swTd2EDIwA=
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

From: Amir Goldstein <amir73il@gmail.com>

Use helpers ovl_*xattr() to access user/trusted.overlay.* xattrs
and use helpers ovl_do_*xattr() to access generic xattrs. This is a
preparatory patch for using idmapped base layers with overlay.

Cc: <linux-unionfs@vger.kernel.org>
Tested-by: Giuseppe Scrivano <gscrivan@redhat.com>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c   | 22 ++++++++++++----------
 fs/overlayfs/dir.c       |  4 +++-
 fs/overlayfs/inode.c     | 13 +++++++------
 fs/overlayfs/namei.c     |  6 +++---
 fs/overlayfs/overlayfs.h | 37 +++++++++++++++++++++++++++----------
 fs/overlayfs/readdir.c   |  4 ++--
 fs/overlayfs/super.c     | 12 ++++++------
 fs/overlayfs/util.c      | 16 ++++++++--------
 8 files changed, 68 insertions(+), 46 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index e040970408d4..104de97f85d6 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -47,6 +47,7 @@ static bool ovl_must_copy_xattr(const char *name)
 int ovl_copy_xattr(struct super_block *sb, struct dentry *old,
 		   struct dentry *new)
 {
+	struct ovl_fs *ofs = OVL_FS(sb);
 	ssize_t list_size, size, value_size = 0;
 	char *buf, *name, *value = NULL;
 	int error = 0;
@@ -117,7 +118,7 @@ int ovl_copy_xattr(struct super_block *sb, struct dentry *old,
 			goto retry;
 		}
 
-		error = vfs_setxattr(&init_user_ns, new, name, value, size, 0);
+		error = ovl_do_setxattr(ofs, new, name, value, size, 0);
 		if (error) {
 			if (error != -EOPNOTSUPP || ovl_must_copy_xattr(name))
 				break;
@@ -433,7 +434,7 @@ static int ovl_set_upper_fh(struct ovl_fs *ofs, struct dentry *upper,
 	if (IS_ERR(fh))
 		return PTR_ERR(fh);
 
-	err = ovl_do_setxattr(ofs, index, OVL_XATTR_UPPER, fh->buf, fh->fb.len);
+	err = ovl_setxattr(ofs, index, OVL_XATTR_UPPER, fh->buf, fh->fb.len);
 
 	kfree(fh);
 	return err;
@@ -865,12 +866,13 @@ static bool ovl_need_meta_copy_up(struct dentry *dentry, umode_t mode,
 	return true;
 }
 
-static ssize_t ovl_getxattr(struct dentry *dentry, char *name, char **value)
+static ssize_t ovl_getxattr_value(struct ovl_fs *ofs, struct dentry *dentry,
+				  char *name, char **value)
 {
 	ssize_t res;
 	char *buf;
 
-	res = vfs_getxattr(&init_user_ns, dentry, name, NULL, 0);
+	res = ovl_do_getxattr(ofs, dentry, name, NULL, 0);
 	if (res == -ENODATA || res == -EOPNOTSUPP)
 		res = 0;
 
@@ -879,7 +881,7 @@ static ssize_t ovl_getxattr(struct dentry *dentry, char *name, char **value)
 		if (!buf)
 			return -ENOMEM;
 
-		res = vfs_getxattr(&init_user_ns, dentry, name, buf, res);
+		res = ovl_do_getxattr(ofs, dentry, name, buf, res);
 		if (res < 0)
 			kfree(buf);
 		else
@@ -906,8 +908,8 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 		return -EIO;
 
 	if (c->stat.size) {
-		err = cap_size = ovl_getxattr(upperpath.dentry, XATTR_NAME_CAPS,
-					      &capability);
+		err = cap_size = ovl_getxattr_value(ofs, upperpath.dentry,
+						    XATTR_NAME_CAPS, &capability);
 		if (cap_size < 0)
 			goto out;
 	}
@@ -921,14 +923,14 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 	 * don't want that to happen for normal copy-up operation.
 	 */
 	if (capability) {
-		err = vfs_setxattr(&init_user_ns, upperpath.dentry,
-				   XATTR_NAME_CAPS, capability, cap_size, 0);
+		err = ovl_do_setxattr(ofs, upperpath.dentry, XATTR_NAME_CAPS,
+				      capability, cap_size, 0);
 		if (err)
 			goto out_free;
 	}
 
 
-	err = ovl_do_removexattr(ofs, upperpath.dentry, OVL_XATTR_METACOPY);
+	err = ovl_removexattr(ofs, upperpath.dentry, OVL_XATTR_METACOPY);
 	if (err)
 		goto out_free;
 
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index f18490813170..d21e3bbcf082 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -435,6 +435,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 static int ovl_set_upper_acl(struct dentry *upperdentry, const char *name,
 			     const struct posix_acl *acl)
 {
+	struct ovl_fs *ofs = OVL_FS(upperdentry->d_sb);
 	void *buffer;
 	size_t size;
 	int err;
@@ -451,7 +452,8 @@ static int ovl_set_upper_acl(struct dentry *upperdentry, const char *name,
 	if (err < 0)
 		goto out_free;
 
-	err = vfs_setxattr(&init_user_ns, upperdentry, name, buffer, size, XATTR_CREATE);
+	err = ovl_do_setxattr(ofs, upperdentry, name, buffer, size,
+			      XATTR_CREATE);
 out_free:
 	kfree(buffer);
 	return err;
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 1f36158c7dbe..c51a9dd36cc7 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -342,6 +342,7 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 		  const void *value, size_t size, int flags)
 {
 	int err;
+	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *upperdentry = ovl_i_dentry_upper(inode);
 	struct dentry *realdentry = upperdentry ?: ovl_dentry_lower(dentry);
 	const struct cred *old_cred;
@@ -368,11 +369,11 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	if (value)
-		err = vfs_setxattr(&init_user_ns, realdentry, name, value, size,
-				   flags);
+		err = ovl_do_setxattr(ofs, realdentry, name, value, size,
+				      flags);
 	else {
 		WARN_ON(flags != XATTR_REPLACE);
-		err = vfs_removexattr(&init_user_ns, realdentry, name);
+		err = ovl_do_removexattr(ofs, realdentry, name);
 	}
 	revert_creds(old_cred);
 
@@ -871,8 +872,8 @@ static int ovl_set_nlink_common(struct dentry *dentry,
 	if (WARN_ON(len >= sizeof(buf)))
 		return -EIO;
 
-	return ovl_do_setxattr(OVL_FS(inode->i_sb), ovl_dentry_upper(dentry),
-			       OVL_XATTR_NLINK, buf, len);
+	return ovl_setxattr(OVL_FS(inode->i_sb), ovl_dentry_upper(dentry),
+			    OVL_XATTR_NLINK, buf, len);
 }
 
 int ovl_set_nlink_upper(struct dentry *dentry)
@@ -897,7 +898,7 @@ unsigned int ovl_get_nlink(struct ovl_fs *ofs, struct dentry *lowerdentry,
 	if (!lowerdentry || !upperdentry || d_inode(lowerdentry)->i_nlink == 1)
 		return fallback;
 
-	err = ovl_do_getxattr(ofs, upperdentry, OVL_XATTR_NLINK,
+	err = ovl_getxattr(ofs, upperdentry, OVL_XATTR_NLINK,
 			      &buf, sizeof(buf) - 1);
 	if (err < 0)
 		goto fail;
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 1a9b515fc45d..042f6394a3d5 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -111,7 +111,7 @@ static struct ovl_fh *ovl_get_fh(struct ovl_fs *ofs, struct dentry *dentry,
 	int res, err;
 	struct ovl_fh *fh = NULL;
 
-	res = ovl_do_getxattr(ofs, dentry, ox, NULL, 0);
+	res = ovl_getxattr(ofs, dentry, ox, NULL, 0);
 	if (res < 0) {
 		if (res == -ENODATA || res == -EOPNOTSUPP)
 			return NULL;
@@ -125,7 +125,7 @@ static struct ovl_fh *ovl_get_fh(struct ovl_fs *ofs, struct dentry *dentry,
 	if (!fh)
 		return ERR_PTR(-ENOMEM);
 
-	res = ovl_do_getxattr(ofs, dentry, ox, fh->buf, res);
+	res = ovl_getxattr(ofs, dentry, ox, fh->buf, res);
 	if (res < 0)
 		goto fail;
 
@@ -464,7 +464,7 @@ int ovl_verify_set_fh(struct ovl_fs *ofs, struct dentry *dentry,
 
 	err = ovl_verify_fh(ofs, dentry, ox, fh);
 	if (set && err == -ENODATA)
-		err = ovl_do_setxattr(ofs, dentry, ox, fh->buf, fh->fb.len);
+		err = ovl_setxattr(ofs, dentry, ox, fh->buf, fh->fb.len);
 	if (err)
 		goto fail;
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 2cd5741c873b..6a53ca0d2c96 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -183,10 +183,9 @@ static inline int ovl_do_symlink(struct inode *dir, struct dentry *dentry,
 }
 
 static inline ssize_t ovl_do_getxattr(struct ovl_fs *ofs, struct dentry *dentry,
-				      enum ovl_xattr ox, void *value,
+				      const char *name, void *value,
 				      size_t size)
 {
-	const char *name = ovl_xattr(ofs, ox);
 	int err = vfs_getxattr(&init_user_ns, dentry, name, value, size);
 	int len = (value && err > 0) ? err : 0;
 
@@ -195,26 +194,44 @@ static inline ssize_t ovl_do_getxattr(struct ovl_fs *ofs, struct dentry *dentry,
 	return err;
 }
 
+static inline ssize_t ovl_getxattr(struct ovl_fs *ofs, struct dentry *dentry,
+				   enum ovl_xattr ox, void *value,
+				   size_t size)
+{
+	return ovl_do_getxattr(ofs, dentry, ovl_xattr(ofs, ox), value, size);
+}
+
 static inline int ovl_do_setxattr(struct ovl_fs *ofs, struct dentry *dentry,
-				  enum ovl_xattr ox, const void *value,
-				  size_t size)
+				  const char *name, const void *value,
+				  size_t size, int flags)
 {
-	const char *name = ovl_xattr(ofs, ox);
-	int err = vfs_setxattr(&init_user_ns, dentry, name, value, size, 0);
-	pr_debug("setxattr(%pd2, \"%s\", \"%*pE\", %zu, 0) = %i\n",
-		 dentry, name, min((int)size, 48), value, size, err);
+	int err = vfs_setxattr(&init_user_ns, dentry, name, value, size, flags);
+	pr_debug("setxattr(%pd2, \"%s\", \"%*pE\", %zu, %d) = %i\n",
+		 dentry, name, min((int)size, 48), value, size, flags, err);
 	return err;
 }
 
+static inline int ovl_setxattr(struct ovl_fs *ofs, struct dentry *dentry,
+			       enum ovl_xattr ox, const void *value,
+			       size_t size)
+{
+	return ovl_do_setxattr(ofs, dentry, ovl_xattr(ofs, ox), value, size, 0);
+}
+
 static inline int ovl_do_removexattr(struct ovl_fs *ofs, struct dentry *dentry,
-				     enum ovl_xattr ox)
+				     const char *name)
 {
-	const char *name = ovl_xattr(ofs, ox);
 	int err = vfs_removexattr(&init_user_ns, dentry, name);
 	pr_debug("removexattr(%pd2, \"%s\") = %i\n", dentry, name, err);
 	return err;
 }
 
+static inline int ovl_removexattr(struct ovl_fs *ofs, struct dentry *dentry,
+				  enum ovl_xattr ox)
+{
+	return ovl_do_removexattr(ofs, dentry, ovl_xattr(ofs, ox));
+}
+
 static inline int ovl_do_rename(struct inode *olddir, struct dentry *olddentry,
 				struct inode *newdir, struct dentry *newdentry,
 				unsigned int flags)
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 150fdf3bc68d..c7b542331065 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -623,8 +623,8 @@ static struct ovl_dir_cache *ovl_cache_get_impure(struct path *path)
 		 * Removing the "impure" xattr is best effort.
 		 */
 		if (!ovl_want_write(dentry)) {
-			ovl_do_removexattr(ofs, ovl_dentry_upper(dentry),
-					   OVL_XATTR_IMPURE);
+			ovl_removexattr(ofs, ovl_dentry_upper(dentry),
+					OVL_XATTR_IMPURE);
 			ovl_drop_write(dentry);
 		}
 		ovl_clear_flag(OVL_IMPURE, d_inode(dentry));
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 7bb0a47cb615..f35116db6e94 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -809,13 +809,13 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 		 * allowed as upper are limited to "normal" ones, where checking
 		 * for the above two errors is sufficient.
 		 */
-		err = vfs_removexattr(&init_user_ns, work,
-				      XATTR_NAME_POSIX_ACL_DEFAULT);
+		err = ovl_do_removexattr(ofs, work,
+					 XATTR_NAME_POSIX_ACL_DEFAULT);
 		if (err && err != -ENODATA && err != -EOPNOTSUPP)
 			goto out_dput;
 
-		err = vfs_removexattr(&init_user_ns, work,
-				      XATTR_NAME_POSIX_ACL_ACCESS);
+		err = ovl_do_removexattr(ofs, work,
+					 XATTR_NAME_POSIX_ACL_ACCESS);
 		if (err && err != -ENODATA && err != -EOPNOTSUPP)
 			goto out_dput;
 
@@ -1411,7 +1411,7 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 	/*
 	 * Check if upper/work fs supports (trusted|user).overlay.* xattr
 	 */
-	err = ovl_do_setxattr(ofs, ofs->workdir, OVL_XATTR_OPAQUE, "0", 1);
+	err = ovl_setxattr(ofs, ofs->workdir, OVL_XATTR_OPAQUE, "0", 1);
 	if (err) {
 		ofs->noxattr = true;
 		if (ofs->config.index || ofs->config.metacopy) {
@@ -1429,7 +1429,7 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 		}
 		err = 0;
 	} else {
-		ovl_do_removexattr(ofs, ofs->workdir, OVL_XATTR_OPAQUE);
+		ovl_removexattr(ofs, ofs->workdir, OVL_XATTR_OPAQUE);
 	}
 
 	/*
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index f48284a2a896..453551f56467 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -554,7 +554,7 @@ bool ovl_check_origin_xattr(struct ovl_fs *ofs, struct dentry *dentry)
 {
 	int res;
 
-	res = ovl_do_getxattr(ofs, dentry, OVL_XATTR_ORIGIN, NULL, 0);
+	res = ovl_getxattr(ofs, dentry, OVL_XATTR_ORIGIN, NULL, 0);
 
 	/* Zero size value means "copied up but origin unknown" */
 	if (res >= 0)
@@ -572,7 +572,7 @@ bool ovl_check_dir_xattr(struct super_block *sb, struct dentry *dentry,
 	if (!d_is_dir(dentry))
 		return false;
 
-	res = ovl_do_getxattr(OVL_FS(sb), dentry, ox, &val, 1);
+	res = ovl_getxattr(OVL_FS(sb), dentry, ox, &val, 1);
 	if (res == 1 && val == 'y')
 		return true;
 
@@ -612,7 +612,7 @@ int ovl_check_setxattr(struct ovl_fs *ofs, struct dentry *upperdentry,
 	if (ofs->noxattr)
 		return xerr;
 
-	err = ovl_do_setxattr(ofs, upperdentry, ox, value, size);
+	err = ovl_setxattr(ofs, upperdentry, ox, value, size);
 
 	if (err == -EOPNOTSUPP) {
 		pr_warn("cannot set %s xattr on upper\n", ovl_xattr(ofs, ox));
@@ -652,7 +652,7 @@ void ovl_check_protattr(struct inode *inode, struct dentry *upper)
 	char buf[OVL_PROTATTR_MAX+1];
 	int res, n;
 
-	res = ovl_do_getxattr(ofs, upper, OVL_XATTR_PROTATTR, buf,
+	res = ovl_getxattr(ofs, upper, OVL_XATTR_PROTATTR, buf,
 			      OVL_PROTATTR_MAX);
 	if (res < 0)
 		return;
@@ -708,7 +708,7 @@ int ovl_set_protattr(struct inode *inode, struct dentry *upper,
 		err = ovl_check_setxattr(ofs, upper, OVL_XATTR_PROTATTR,
 					 buf, len, -EPERM);
 	} else if (inode->i_flags & OVL_PROT_I_FLAGS_MASK) {
-		err = ovl_do_removexattr(ofs, upper, OVL_XATTR_PROTATTR);
+		err = ovl_removexattr(ofs, upper, OVL_XATTR_PROTATTR);
 		if (err == -EOPNOTSUPP || err == -ENODATA)
 			err = 0;
 	}
@@ -951,7 +951,7 @@ int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct dentry *dentry)
 	if (!S_ISREG(d_inode(dentry)->i_mode))
 		return 0;
 
-	res = ovl_do_getxattr(ofs, dentry, OVL_XATTR_METACOPY, NULL, 0);
+	res = ovl_getxattr(ofs, dentry, OVL_XATTR_METACOPY, NULL, 0);
 	if (res < 0) {
 		if (res == -ENODATA || res == -EOPNOTSUPP)
 			return 0;
@@ -993,7 +993,7 @@ char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
 	int res;
 	char *s, *next, *buf = NULL;
 
-	res = ovl_do_getxattr(ofs, dentry, OVL_XATTR_REDIRECT, NULL, 0);
+	res = ovl_getxattr(ofs, dentry, OVL_XATTR_REDIRECT, NULL, 0);
 	if (res == -ENODATA || res == -EOPNOTSUPP)
 		return NULL;
 	if (res < 0)
@@ -1005,7 +1005,7 @@ char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
 
-	res = ovl_do_getxattr(ofs, dentry, OVL_XATTR_REDIRECT, buf, res);
+	res = ovl_getxattr(ofs, dentry, OVL_XATTR_REDIRECT, buf, res);
 	if (res < 0)
 		goto fail;
 	if (res == 0)
-- 
2.32.0

