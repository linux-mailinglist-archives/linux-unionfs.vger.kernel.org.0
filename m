Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E1A77E512
	for <lists+linux-unionfs@lfdr.de>; Wed, 16 Aug 2023 17:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344132AbjHPPYY (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 16 Aug 2023 11:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344217AbjHPPYM (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 16 Aug 2023 11:24:12 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A16273A
        for <linux-unionfs@vger.kernel.org>; Wed, 16 Aug 2023 08:23:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31956020336so3514724f8f.0
        for <linux-unionfs@vger.kernel.org>; Wed, 16 Aug 2023 08:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692199424; x=1692804224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CyOfVav4LHoNjRn46bnSSw93nrFYxkCMD+SBuW63oo=;
        b=Z1GK6ahEoEW3QUsfmm7roleYtOsmKHFcLD2F6GsvpFAdSt/MOg+Lh7d9HlIsVxfYxd
         CXNOHfNio0RR/wQq9AYt6LMc8yb5lmjPX/f/o3SEJimTY64bB25lbLBO5PMDNSBVCrtQ
         /gfRjzR5kVaAPof+1d1pmM3pfeH/2z6ZNfayAhcyCdWURl3hvwavM6NiurUyqr2UF6dv
         lGXVDTa6ba0Gsj7XehToYesfoE1ZN2JJwuX6U7OJAWsr3CnuNjtA7egUE9FweSKXSrmm
         yfBjsmedZKO8jj7NfnCmgo5kNgq28aL1Kxoj88g4pHODrsH4zAQqGmlNu9alhy+7+BKF
         p+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692199424; x=1692804224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CyOfVav4LHoNjRn46bnSSw93nrFYxkCMD+SBuW63oo=;
        b=L5g7NdDKx9/MkT3rhsu8qE6w1g5ZWW4wmDOsyDytEe+67mIH2EypdceL3pNkihtItm
         H8UDqdgm30UEa0VC63XLVKsRLQ7CQ1A6AnMP0iKFFwzw/oitq567CksKktQNUodzuuNU
         G3F0b4O+XGEm5Jne097PuUheWNa7qyvbKW8QJZ8wKAzuNlfoJMKT7towAVY7L1mWMlRv
         2sZuHUt5ohOd3tZzLxQRWJn2p8w3SeOcIRsRKubcLHQde2f7xG8uUpgYWwOOPV+Fe5M4
         UWgv7JnLPA1TnRrbZJGPYLmVdUh3SNkqPn4PPmWxpPPTJ/0zheqh4bAk4rGCvZ7Hdj66
         LUqA==
X-Gm-Message-State: AOJu0Yx/L9jfueiU/rvr7R2X85yEaqERhlhqF3ASFkhNKQGmpDnVw2Xr
        HF/bYc2Jx5kkvFfzgk07DYfyjyIvFDA=
X-Google-Smtp-Source: AGHT+IEWzqXCLRxUGVbmGKMkoYHGs/v89RwWx1Ejv/AjYiLALbodhJhwt9KzL0I0aE9Hz+KduBIW+w==
X-Received: by 2002:a5d:4489:0:b0:319:7ec8:53ba with SMTP id j9-20020a5d4489000000b003197ec853bamr1955480wrq.14.1692199423688;
        Wed, 16 Aug 2023 08:23:43 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id k7-20020adfe3c7000000b003176c6e87b1sm21701988wrm.81.2023.08.16.08.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:23:43 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org
Subject: [PATCH v3 4/4] ovl: do not encode lower fh with upper sb_writers held
Date:   Wed, 16 Aug 2023 18:23:34 +0300
Message-Id: <20230816152334.924960-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816152334.924960-1-amir73il@gmail.com>
References: <20230816152334.924960-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

When lower fs is a nested overlayfs, calling encode_fh() on a lower
directory dentry may trigger copy up and take sb_writers on the upper fs
of the lower nested overlayfs.

The lower nested overlayfs may have the same upper fs as this overlayfs,
so nested sb_writers lock is illegal.

Move all the callers that encode lower fh to before ovl_want_write().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c   | 52 ++++++++++++++++++++++++----------------
 fs/overlayfs/namei.c     | 37 +++++++++++++++++++++-------
 fs/overlayfs/overlayfs.h | 26 ++++++++++++++------
 fs/overlayfs/super.c     | 20 +++++++++++-----
 fs/overlayfs/util.c      | 11 ++++++++-
 5 files changed, 103 insertions(+), 43 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index add5861cf06b..c0bac6bd90cf 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -434,29 +434,29 @@ struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct dentry *real,
 	return ERR_PTR(err);
 }
 
-int ovl_set_origin(struct ovl_fs *ofs, struct dentry *lower,
-		   struct dentry *upper)
+struct ovl_fh *ovl_get_origin_fh(struct ovl_fs *ofs, struct dentry *origin)
 {
-	const struct ovl_fh *fh = NULL;
-	int err;
-
 	/*
 	 * When lower layer doesn't support export operations store a 'null' fh,
 	 * so we can use the overlay.origin xattr to distignuish between a copy
 	 * up and a pure upper inode.
 	 */
-	if (ovl_can_decode_fh(lower->d_sb)) {
-		fh = ovl_encode_real_fh(ofs, lower, false);
-		if (IS_ERR(fh))
-			return PTR_ERR(fh);
-	}
+	if (!ovl_can_decode_fh(origin->d_sb))
+		return NULL;
+
+	return ovl_encode_real_fh(ofs, origin, false);
+}
+
+int ovl_set_origin_fh(struct ovl_fs *ofs, const struct ovl_fh *fh,
+		      struct dentry *upper)
+{
+	int err;
 
 	/*
 	 * Do not fail when upper doesn't support xattrs.
 	 */
 	err = ovl_check_setxattr(ofs, upper, OVL_XATTR_ORIGIN, fh->buf,
 				 fh ? fh->fb.len : 0, 0);
-	kfree(fh);
 
 	/* Ignore -EPERM from setting "user.*" on symlink/special */
 	return err == -EPERM ? 0 : err;
@@ -484,7 +484,7 @@ static int ovl_set_upper_fh(struct ovl_fs *ofs, struct dentry *upper,
  *
  * Caller must hold i_mutex on indexdir.
  */
-static int ovl_create_index(struct dentry *dentry, struct dentry *origin,
+static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 			    struct dentry *upper)
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
@@ -510,7 +510,7 @@ static int ovl_create_index(struct dentry *dentry, struct dentry *origin,
 	if (WARN_ON(ovl_test_flag(OVL_INDEX, d_inode(dentry))))
 		return -EIO;
 
-	err = ovl_get_index_name(ofs, origin, &name);
+	err = ovl_get_index_name_fh(fh, &name);
 	if (err)
 		return err;
 
@@ -549,6 +549,7 @@ struct ovl_copy_up_ctx {
 	struct dentry *destdir;
 	struct qstr destname;
 	struct dentry *workdir;
+	const struct ovl_fh *origin_fh;
 	bool origin;
 	bool indexed;
 	bool metacopy;
@@ -648,7 +649,7 @@ static int ovl_copy_up_metadata(struct ovl_copy_up_ctx *c, struct dentry *temp)
 	 * hard link.
 	 */
 	if (c->origin) {
-		err = ovl_set_origin(ofs, c->lowerpath.dentry, temp);
+		err = ovl_set_origin_fh(ofs, c->origin_fh, temp);
 		if (err)
 			return err;
 	}
@@ -771,7 +772,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 		goto cleanup;
 
 	if (S_ISDIR(c->stat.mode) && c->indexed) {
-		err = ovl_create_index(c->dentry, c->lowerpath.dentry, temp);
+		err = ovl_create_index(c->dentry, c->origin_fh, temp);
 		if (err)
 			goto cleanup;
 	}
@@ -889,6 +890,8 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 {
 	int err;
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
+	struct dentry *origin = c->lowerpath.dentry;
+	struct ovl_fh *fh = NULL;
 	bool to_index = false;
 
 	/*
@@ -905,17 +908,25 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 			to_index = true;
 	}
 
-	if (S_ISDIR(c->stat.mode) || c->stat.nlink == 1 || to_index)
+	if (S_ISDIR(c->stat.mode) || c->stat.nlink == 1 || to_index) {
+		fh = ovl_get_origin_fh(ofs, origin);
+		if (IS_ERR(fh))
+			return PTR_ERR(fh);
+
+		/* origin_fh may be NULL */
+		c->origin_fh = fh;
 		c->origin = true;
+	}
 
 	if (to_index) {
 		c->destdir = ovl_indexdir(c->dentry->d_sb);
-		err = ovl_get_index_name(ofs, c->lowerpath.dentry, &c->destname);
+		err = ovl_get_index_name(ofs, origin, &c->destname);
 		if (err)
-			return err;
+			goto out;
 	} else if (WARN_ON(!c->parent)) {
 		/* Disconnected dentry must be copied up to index dir */
-		return -EIO;
+		err = -EIO;
+		goto out;
 	} else {
 		/*
 		 * Mark parent "impure" because it may now contain non-pure
@@ -925,7 +936,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 		err = ovl_set_impure(c->parent, c->destdir);
 		ovl_end_write(c->dentry);
 		if (err)
-			return err;
+			goto out;
 	}
 
 	/* Should we copyup with O_TMPFILE or with workdir? */
@@ -959,6 +970,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 out:
 	if (to_index)
 		kfree(c->destname.name);
+	kfree(fh);
 	return err;
 }
 
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 80391c687c2a..f10ac4ae35f0 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -507,6 +507,19 @@ static int ovl_verify_fh(struct ovl_fs *ofs, struct dentry *dentry,
 	return err;
 }
 
+int ovl_verify_set_fh(struct ovl_fs *ofs, struct dentry *dentry,
+		      enum ovl_xattr ox, const struct ovl_fh *fh,
+		      bool is_upper, bool set)
+{
+	int err;
+
+	err = ovl_verify_fh(ofs, dentry, ox, fh);
+	if (set && err == -ENODATA)
+		err = ovl_setxattr(ofs, dentry, ox, fh->buf, fh->fb.len);
+
+	return err;
+}
+
 /*
  * Verify that @real dentry matches the file handle stored in xattr @name.
  *
@@ -515,9 +528,9 @@ static int ovl_verify_fh(struct ovl_fs *ofs, struct dentry *dentry,
  *
  * Return 0 on match, -ESTALE on mismatch, -ENODATA on no xattr, < 0 on error.
  */
-int ovl_verify_set_fh(struct ovl_fs *ofs, struct dentry *dentry,
-		      enum ovl_xattr ox, struct dentry *real, bool is_upper,
-		      bool set)
+int ovl_verify_origin_xattr(struct ovl_fs *ofs, struct dentry *dentry,
+			    enum ovl_xattr ox, struct dentry *real,
+			    bool is_upper, bool set)
 {
 	struct inode *inode;
 	struct ovl_fh *fh;
@@ -530,9 +543,7 @@ int ovl_verify_set_fh(struct ovl_fs *ofs, struct dentry *dentry,
 		goto fail;
 	}
 
-	err = ovl_verify_fh(ofs, dentry, ox, fh);
-	if (set && err == -ENODATA)
-		err = ovl_setxattr(ofs, dentry, ox, fh->buf, fh->fb.len);
+	err = ovl_verify_set_fh(ofs, dentry, ox, fh, is_upper, set);
 	if (err)
 		goto fail;
 
@@ -548,6 +559,7 @@ int ovl_verify_set_fh(struct ovl_fs *ofs, struct dentry *dentry,
 	goto out;
 }
 
+
 /* Get upper dentry from index */
 struct dentry *ovl_index_upper(struct ovl_fs *ofs, struct dentry *index,
 			       bool connected)
@@ -684,7 +696,7 @@ int ovl_verify_index(struct ovl_fs *ofs, struct dentry *index)
 	goto out;
 }
 
-static int ovl_get_index_name_fh(struct ovl_fh *fh, struct qstr *name)
+int ovl_get_index_name_fh(const struct ovl_fh *fh, struct qstr *name)
 {
 	char *n, *s;
 
@@ -873,20 +885,27 @@ int ovl_path_next(int idx, struct dentry *dentry, struct path *path)
 static int ovl_fix_origin(struct ovl_fs *ofs, struct dentry *dentry,
 			  struct dentry *lower, struct dentry *upper)
 {
+	const struct ovl_fh *fh;
 	int err;
 
 	if (ovl_check_origin_xattr(ofs, upper))
 		return 0;
 
+	fh = ovl_get_origin_fh(ofs, lower);
+	if (IS_ERR(fh))
+		return PTR_ERR(fh);
+
 	err = ovl_want_write(dentry);
 	if (err)
-		return err;
+		goto out;
 
-	err = ovl_set_origin(ofs, lower, upper);
+	err = ovl_set_origin_fh(ofs, fh, upper);
 	if (!err)
 		err = ovl_set_impure(dentry->d_parent, upper->d_parent);
 
 	ovl_drop_write(dentry);
+out:
+	kfree(fh);
 	return err;
 }
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 6da49bf78b90..4e8a2b830c71 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -628,11 +628,15 @@ struct dentry *ovl_decode_real_fh(struct ovl_fs *ofs, struct ovl_fh *fh,
 int ovl_check_origin_fh(struct ovl_fs *ofs, struct ovl_fh *fh, bool connected,
 			struct dentry *upperdentry, struct ovl_path **stackp);
 int ovl_verify_set_fh(struct ovl_fs *ofs, struct dentry *dentry,
-		      enum ovl_xattr ox, struct dentry *real, bool is_upper,
-		      bool set);
+		      enum ovl_xattr ox, const struct ovl_fh *fh,
+		      bool is_upper, bool set);
+int ovl_verify_origin_xattr(struct ovl_fs *ofs, struct dentry *dentry,
+			    enum ovl_xattr ox, struct dentry *real,
+			    bool is_upper, bool set);
 struct dentry *ovl_index_upper(struct ovl_fs *ofs, struct dentry *index,
 			       bool connected);
 int ovl_verify_index(struct ovl_fs *ofs, struct dentry *index);
+int ovl_get_index_name_fh(const struct ovl_fh *fh, struct qstr *name);
 int ovl_get_index_name(struct ovl_fs *ofs, struct dentry *origin,
 		       struct qstr *name);
 struct dentry *ovl_get_index_fh(struct ovl_fs *ofs, struct ovl_fh *fh);
@@ -644,17 +648,24 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			  unsigned int flags);
 bool ovl_lower_positive(struct dentry *dentry);
 
+static inline int ovl_verify_origin_fh(struct ovl_fs *ofs, struct dentry *upper,
+				       const struct ovl_fh *fh, bool set)
+{
+	return ovl_verify_set_fh(ofs, upper, OVL_XATTR_ORIGIN, fh, false, set);
+}
+
 static inline int ovl_verify_origin(struct ovl_fs *ofs, struct dentry *upper,
 				    struct dentry *origin, bool set)
 {
-	return ovl_verify_set_fh(ofs, upper, OVL_XATTR_ORIGIN, origin,
-				 false, set);
+	return ovl_verify_origin_xattr(ofs, upper, OVL_XATTR_ORIGIN, origin,
+				       false, set);
 }
 
 static inline int ovl_verify_upper(struct ovl_fs *ofs, struct dentry *index,
 				   struct dentry *upper, bool set)
 {
-	return ovl_verify_set_fh(ofs, index, OVL_XATTR_UPPER, upper, true, set);
+	return ovl_verify_origin_xattr(ofs, index, OVL_XATTR_UPPER, upper,
+				       true, set);
 }
 
 /* readdir.c */
@@ -819,8 +830,9 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *path, struct dentr
 int ovl_set_attr(struct ovl_fs *ofs, struct dentry *upper, struct kstat *stat);
 struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct dentry *real,
 				  bool is_upper);
-int ovl_set_origin(struct ovl_fs *ofs, struct dentry *lower,
-		   struct dentry *upper);
+struct ovl_fh *ovl_get_origin_fh(struct ovl_fs *ofs, struct dentry *origin);
+int ovl_set_origin_fh(struct ovl_fs *ofs, const struct ovl_fh *fh,
+		      struct dentry *upper);
 
 /* export.c */
 extern const struct export_operations ovl_export_operations;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index def266b5e2a3..93d500d4fda9 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -881,15 +881,20 @@ static int ovl_get_indexdir(struct super_block *sb, struct ovl_fs *ofs,
 {
 	struct vfsmount *mnt = ovl_upper_mnt(ofs);
 	struct dentry *indexdir;
+	struct dentry *origin = ovl_lowerstack(oe)->dentry;
+	const struct ovl_fh *fh;
 	int err;
 
+	fh = ovl_get_origin_fh(ofs, origin);
+	if (IS_ERR(fh))
+		return PTR_ERR(fh);
+
 	err = mnt_want_write(mnt);
 	if (err)
-		return err;
+		goto out_free_fh;
 
 	/* Verify lower root is upper root origin */
-	err = ovl_verify_origin(ofs, upperpath->dentry,
-				ovl_lowerstack(oe)->dentry, true);
+	err = ovl_verify_origin_fh(ofs, upperpath->dentry, fh, true);
 	if (err) {
 		pr_err("failed to verify upper root origin\n");
 		goto out;
@@ -921,9 +926,10 @@ static int ovl_get_indexdir(struct super_block *sb, struct ovl_fs *ofs,
 		 * directory entries.
 		 */
 		if (ovl_check_origin_xattr(ofs, ofs->indexdir)) {
-			err = ovl_verify_set_fh(ofs, ofs->indexdir,
-						OVL_XATTR_ORIGIN,
-						upperpath->dentry, true, false);
+			err = ovl_verify_origin_xattr(ofs, ofs->indexdir,
+						      OVL_XATTR_ORIGIN,
+						      upperpath->dentry, true,
+						      false);
 			if (err)
 				pr_err("failed to verify index dir 'origin' xattr\n");
 		}
@@ -941,6 +947,8 @@ static int ovl_get_indexdir(struct super_block *sb, struct ovl_fs *ofs,
 
 out:
 	mnt_drop_write(mnt);
+out_free_fh:
+	kfree(fh);
 	return err;
 }
 
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 4e67ef0cc8da..5d92252cee30 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1013,12 +1013,18 @@ static void ovl_cleanup_index(struct dentry *dentry)
 	struct dentry *index = NULL;
 	struct inode *inode;
 	struct qstr name = { };
+	bool got_write = false;
 	int err;
 
 	err = ovl_get_index_name(ofs, lowerdentry, &name);
 	if (err)
 		goto fail;
 
+	err = ovl_want_write(dentry);
+	if (err)
+		goto fail;
+
+	got_write = true;
 	inode = d_inode(upperdentry);
 	if (!S_ISDIR(inode->i_mode) && inode->i_nlink != 1) {
 		pr_warn_ratelimited("cleanup linked index (%pd2, ino=%lu, nlink=%u)\n",
@@ -1056,6 +1062,8 @@ static void ovl_cleanup_index(struct dentry *dentry)
 		goto fail;
 
 out:
+	if (got_write)
+		ovl_drop_write(dentry);
 	kfree(name.name);
 	dput(index);
 	return;
@@ -1135,6 +1143,8 @@ void ovl_nlink_end(struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
 
+	ovl_drop_write(dentry);
+
 	if (ovl_test_flag(OVL_INDEX, inode) && inode->i_nlink == 0) {
 		const struct cred *old_cred;
 
@@ -1143,7 +1153,6 @@ void ovl_nlink_end(struct dentry *dentry)
 		revert_creds(old_cred);
 	}
 
-	ovl_drop_write(dentry);
 	ovl_inode_unlock(inode);
 }
 
-- 
2.34.1

