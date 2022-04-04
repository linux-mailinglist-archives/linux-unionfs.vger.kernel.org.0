Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375F14F1367
	for <lists+linux-unionfs@lfdr.de>; Mon,  4 Apr 2022 12:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358349AbiDDKzz (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 4 Apr 2022 06:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358537AbiDDKzy (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 4 Apr 2022 06:55:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1260514026
        for <linux-unionfs@vger.kernel.org>; Mon,  4 Apr 2022 03:53:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 949ED60AE5
        for <linux-unionfs@vger.kernel.org>; Mon,  4 Apr 2022 10:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3118BC2BBE4;
        Mon,  4 Apr 2022 10:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649069638;
        bh=RfGvySdIDdoYNKqsxp0UMi/xg9UVPxU4Q6pNh0kyKCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K1CiQWq6EFCtfV6weHP1JfbKrKD53sqSt58R10CKvhIXlHC5UsJJbMmXszASobwH2
         bKnW4fhN/qUzCwnx7khjUXnGGoyHvPZ0pPK/VrbRsMS1i2ZsrbxRol3PneB+NzaLfv
         D8ee8d1exTfP9QTV0V39+YjHeKqdC1UnlH/455ojKsps4AsDq1l+5B4H9bvRl0szOC
         9FKFydPyAjXU63f09yKzuUDKg83njcFxvW6C1//AY6F2PCnYgkvfcgE1MCcppoazM3
         O16bWEDnCZy8YTWqhsYyn/NVkafesqhAplT+8ZXpAT98WVc9A6Q/QaakvnNG4mEIn2
         GlXdGhMf+zEPQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-unionfs@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos Catelin <rodrigo@sdfg.com.ar>,
        Seth Forshee <sforshee@digitalocean.com>,
        Luca Bocassi <luca.boccassi@microsoft.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v4 08/19] ovl: pass layer mnt to ovl_open_realfile()
Date:   Mon,  4 Apr 2022 12:51:47 +0200
Message-Id: <20220404105159.1567595-9-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404105159.1567595-1-brauner@kernel.org>
References: <20220404105159.1567595-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4598; i=brauner@kernel.org; h=from:subject; bh=KNaZ6S6ZUCaO3/Hn2aoNeHZA/LiznvLaq+XaIUp1QDU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR5nT3y2Yb34zVW6zvqm2MYlu5cqP/jgJ7BuUfM9wq0X8qU t+zx6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIzwpGhk8+p/Zce3u18ojQikdNd8 O/tR6XW251j49n22tG64b++UsYGe4uV3h+fJXRiU7ha6/l2hSftYgK6BkWFCe6Vajt+ur+lBUA
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

Ensure that ovl_open_realfile() takes the mount's idmapping into
account. We add a new helper ovl_path_realdata() that can be used to
easily retrieve the relevant path which we can pass down. This is needed
to support idmapped base layers with overlay.

Cc: <linux-unionfs@vger.kernel.org>
Tested-by: Giuseppe Scrivano <gscrivan@redhat.com>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
/* v2 */
unchanged

/* v3 */
unchanged

/* v4 */
unchanged
---
 fs/overlayfs/file.c      | 22 +++++++++++++---------
 fs/overlayfs/overlayfs.h |  1 +
 fs/overlayfs/util.c      | 14 ++++++++++++++
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index fa125feed0ff..9250e04e97af 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -38,8 +38,9 @@ static char ovl_whatisit(struct inode *inode, struct inode *realinode)
 #define OVL_OPEN_FLAGS (O_NOATIME | FMODE_NONOTIFY)
 
 static struct file *ovl_open_realfile(const struct file *file,
-				      struct inode *realinode)
+				      struct path *realpath)
 {
+	struct inode *realinode = d_inode(realpath->dentry);
 	struct inode *inode = file_inode(file);
 	struct file *realfile;
 	const struct cred *old_cred;
@@ -104,21 +105,21 @@ static int ovl_change_flags(struct file *file, unsigned int flags)
 static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
 			       bool allow_meta)
 {
-	struct inode *inode = file_inode(file);
-	struct inode *realinode;
+	struct dentry *dentry = file_dentry(file);
+	struct path realpath;
 
 	real->flags = 0;
 	real->file = file->private_data;
 
 	if (allow_meta)
-		realinode = ovl_inode_real(inode);
+		ovl_path_real(dentry, &realpath);
 	else
-		realinode = ovl_inode_realdata(inode);
+		ovl_path_realdata(dentry, &realpath);
 
 	/* Has it been copied up since we'd opened it? */
-	if (unlikely(file_inode(real->file) != realinode)) {
+	if (unlikely(file_inode(real->file) != d_inode(realpath.dentry))) {
 		real->flags = FDPUT_FPUT;
-		real->file = ovl_open_realfile(file, realinode);
+		real->file = ovl_open_realfile(file, &realpath);
 
 		return PTR_ERR_OR_ZERO(real->file);
 	}
@@ -144,17 +145,20 @@ static int ovl_real_fdget(const struct file *file, struct fd *real)
 
 static int ovl_open(struct inode *inode, struct file *file)
 {
+	struct dentry *dentry = file_dentry(file);
 	struct file *realfile;
+	struct path realpath;
 	int err;
 
-	err = ovl_maybe_copy_up(file_dentry(file), file->f_flags);
+	err = ovl_maybe_copy_up(dentry, file->f_flags);
 	if (err)
 		return err;
 
 	/* No longer need these flags, so don't pass them on to underlying fs */
 	file->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 
-	realfile = ovl_open_realfile(file, ovl_inode_realdata(inode));
+	ovl_path_realdata(dentry, &realpath);
+	realfile = ovl_open_realfile(file, &realpath);
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 05b549a01b70..716e31ace058 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -319,6 +319,7 @@ void ovl_path_upper(struct dentry *dentry, struct path *path);
 void ovl_path_lower(struct dentry *dentry, struct path *path);
 void ovl_path_lowerdata(struct dentry *dentry, struct path *path);
 enum ovl_path_type ovl_path_real(struct dentry *dentry, struct path *path);
+enum ovl_path_type ovl_path_realdata(struct dentry *dentry, struct path *path);
 struct dentry *ovl_dentry_upper(struct dentry *dentry);
 struct dentry *ovl_dentry_lower(struct dentry *dentry);
 struct dentry *ovl_dentry_lowerdata(struct dentry *dentry);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 5a7e5d1e884b..42293610f64e 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -194,6 +194,20 @@ enum ovl_path_type ovl_path_real(struct dentry *dentry, struct path *path)
 	return type;
 }
 
+enum ovl_path_type ovl_path_realdata(struct dentry *dentry, struct path *path)
+{
+	enum ovl_path_type type = ovl_path_type(dentry);
+
+	WARN_ON_ONCE(d_is_dir(dentry));
+
+	if (!OVL_TYPE_UPPER(type) || OVL_TYPE_MERGE(type))
+		ovl_path_lowerdata(dentry, path);
+	else
+		ovl_path_upper(dentry, path);
+
+	return type;
+}
+
 struct dentry *ovl_dentry_upper(struct dentry *dentry)
 {
 	return ovl_upperdentry_dereference(OVL_I(d_inode(dentry)));
-- 
2.32.0

