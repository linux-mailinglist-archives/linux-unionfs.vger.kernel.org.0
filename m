Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C965B4ED870
	for <lists+linux-unionfs@lfdr.de>; Thu, 31 Mar 2022 13:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbiCaL0b (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 31 Mar 2022 07:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbiCaL0b (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 31 Mar 2022 07:26:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5204A6257
        for <linux-unionfs@vger.kernel.org>; Thu, 31 Mar 2022 04:24:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4B8A6158A
        for <linux-unionfs@vger.kernel.org>; Thu, 31 Mar 2022 11:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700EAC340ED;
        Thu, 31 Mar 2022 11:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648725883;
        bh=19qQh6FhHQ6GHiVm5KpG+/P9s19pV5NWWoQjqIYJqls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C6jGlX0qOYgMGW2EZLy5S8sFoa+v/R1e+jsjRqBzFWi9KeuYHg7C2y5jAYdsEIXwI
         tUi1Twh6VdolYtJQXUKGNSWQBsP3PJmRfPF5PlCN7KEV/iCmbWTztVaPpjxO7dFrFd
         DCzat8Z/cWveL/oRX1yrrHtiL4i4FL6bw52s2JyQO+zoFX6/ZgG3ZBqzBmJniJdLFE
         U2gHKtVv+T5ohQu5/qFTzYBIdLwFJTK/sG+HpQntDjcVSzQcFxtjiqICDWkqhpGyPa
         tIVEErgMDjwAXhnTKQ6Fd0Frp2sexe658pSHpgW6DxwxTCAwdyd+w7YthB4h7rvvTR
         xQWrBWbKaviDQ==
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
Subject: [PATCH v3 14/19] ovl: store lower path in ovl_inode
Date:   Thu, 31 Mar 2022 13:23:12 +0200
Message-Id: <20220331112318.1377494-15-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220331112318.1377494-1-brauner@kernel.org>
References: <20220331112318.1377494-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7947; i=brauner@kernel.org; h=from:subject; bh=1WNPUZwcaG3ioK0e64kQfgvcvD/cSqHD3zjUkyQPTL4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS59kun3e7tnHFO53FrcsTdq+fF9eeU/AhbyDfna3vuipPR JRbSHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNR/8DwVzb4nuEpGUXBN50BH3ZyHn 3sobzJzdNd45FqYIyCfp6CLyPDq5L6LpbElud6DfdKlIVn3OfaldG7Sqeg/23AZ/l1amc4AQ==
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

Create some ovl_i_* helpers to get real path from ovl inode. Instead of
just stashing struct inode for the lower layer we stash struct path for
the lower layer. The helpers allow to retrieve a struct path for the
relevant upper or lower layer. This will be used when retrieving
information based on struct inode when copying up inode attributes from
upper or lower inodes to ovl inodes and when checking permissions in
ovl_permission() in following patches. This is needed to support
idmapped base layers with overlay.

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
---
 fs/overlayfs/inode.c     | 11 +++++---
 fs/overlayfs/overlayfs.h |  6 ++++
 fs/overlayfs/ovl_entry.h |  2 +-
 fs/overlayfs/super.c     |  5 ++--
 fs/overlayfs/util.c      | 61 ++++++++++++++++++++++++++++++++++------
 5 files changed, 69 insertions(+), 16 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index f18b02b9dd53..e28b7ed755b3 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -779,13 +779,16 @@ void ovl_inode_init(struct inode *inode, struct ovl_inode_params *oip,
 		    unsigned long ino, int fsid)
 {
 	struct inode *realinode;
+	struct ovl_inode *oi = OVL_I(inode);
 
 	if (oip->upperdentry)
-		OVL_I(inode)->__upperdentry = oip->upperdentry;
-	if (oip->lowerpath && oip->lowerpath->dentry)
-		OVL_I(inode)->lower = igrab(d_inode(oip->lowerpath->dentry));
+		oi->__upperdentry = oip->upperdentry;
+	if (oip->lowerpath && oip->lowerpath->dentry) {
+		oi->lowerpath.dentry = dget(oip->lowerpath->dentry);
+		oi->lowerpath.layer = oip->lowerpath->layer;
+	}
 	if (oip->lowerdata)
-		OVL_I(inode)->lowerdata = igrab(d_inode(oip->lowerdata));
+		oi->lowerdata = igrab(d_inode(oip->lowerdata));
 
 	realinode = ovl_inode_real(inode);
 	ovl_copyattr(realinode, inode);
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 347096a3d4a3..6bae54d2ba78 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -361,18 +361,24 @@ bool ovl_dentry_remote(struct dentry *dentry);
 void ovl_dentry_update_reval(struct dentry *dentry, struct dentry *upperdentry,
 			     unsigned int mask);
 bool ovl_dentry_weird(struct dentry *dentry);
+enum ovl_path_type ovl_i_path_type(struct inode *inode, bool is_dir,
+				   int numlower);
 enum ovl_path_type ovl_path_type(struct dentry *dentry);
 void ovl_path_upper(struct dentry *dentry, struct path *path);
 void ovl_path_lower(struct dentry *dentry, struct path *path);
 void ovl_path_lowerdata(struct dentry *dentry, struct path *path);
+enum ovl_path_type ovl_i_path_real(struct inode *inode, struct path *path);
 enum ovl_path_type ovl_path_real(struct dentry *dentry, struct path *path);
 enum ovl_path_type ovl_path_realdata(struct dentry *dentry, struct path *path);
 struct dentry *ovl_dentry_upper(struct dentry *dentry);
 struct dentry *ovl_dentry_lower(struct dentry *dentry);
 struct dentry *ovl_dentry_lowerdata(struct dentry *dentry);
+const struct ovl_layer *ovl_i_layer_lower(struct inode *inode);
 const struct ovl_layer *ovl_layer_lower(struct dentry *dentry);
 struct dentry *ovl_dentry_real(struct dentry *dentry);
+struct dentry *ovl_i_dentry_real(struct inode *inode);
 struct dentry *ovl_i_dentry_upper(struct inode *inode);
+struct dentry *ovl_i_dentry_lower(struct inode *inode);
 struct inode *ovl_inode_upper(struct inode *inode);
 struct inode *ovl_inode_lower(struct inode *inode);
 struct inode *ovl_inode_lowerdata(struct inode *inode);
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 22ce60426de2..79b612cfbe52 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -134,7 +134,7 @@ struct ovl_inode {
 	unsigned long flags;
 	struct inode vfs_inode;
 	struct dentry *__upperdentry;
-	struct inode *lower;
+	struct ovl_path lowerpath;
 
 	/* synchronize copy up and more */
 	struct mutex lock;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 1ed230c7baf1..9a656a24f7b1 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -184,7 +184,8 @@ static struct inode *ovl_alloc_inode(struct super_block *sb)
 	oi->version = 0;
 	oi->flags = 0;
 	oi->__upperdentry = NULL;
-	oi->lower = NULL;
+	oi->lowerpath.dentry = NULL;
+	oi->lowerpath.layer = NULL;
 	oi->lowerdata = NULL;
 	mutex_init(&oi->lock);
 
@@ -205,7 +206,7 @@ static void ovl_destroy_inode(struct inode *inode)
 	struct ovl_inode *oi = OVL_I(inode);
 
 	dput(oi->__upperdentry);
-	iput(oi->lower);
+	dput(oi->lowerpath.dentry);
 	if (S_ISDIR(inode->i_mode))
 		ovl_dir_cache_free(inode);
 	else
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 3065393d143e..7dd9901c9d17 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -125,31 +125,37 @@ bool ovl_dentry_weird(struct dentry *dentry)
 				  DCACHE_OP_COMPARE);
 }
 
-enum ovl_path_type ovl_path_type(struct dentry *dentry)
+enum ovl_path_type ovl_i_path_type(struct inode *inode, bool is_dir,
+				   int numlower)
 {
-	struct ovl_entry *oe = dentry->d_fsdata;
 	enum ovl_path_type type = 0;
 
-	if (ovl_dentry_upper(dentry)) {
+	if (ovl_i_dentry_upper(inode)) {
 		type = __OVL_PATH_UPPER;
 
 		/*
 		 * Non-dir dentry can hold lower dentry of its copy up origin.
 		 */
-		if (oe->numlower) {
-			if (ovl_test_flag(OVL_CONST_INO, d_inode(dentry)))
+		if (numlower) {
+			if (ovl_test_flag(OVL_CONST_INO, inode))
 				type |= __OVL_PATH_ORIGIN;
-			if (d_is_dir(dentry) ||
-			    !ovl_has_upperdata(d_inode(dentry)))
+			if (is_dir || !ovl_has_upperdata(inode))
 				type |= __OVL_PATH_MERGE;
 		}
 	} else {
-		if (oe->numlower > 1)
+		if (numlower > 1)
 			type |= __OVL_PATH_MERGE;
 	}
 	return type;
 }
 
+enum ovl_path_type ovl_path_type(struct dentry *dentry)
+{
+	struct ovl_entry *oe = dentry->d_fsdata;
+
+	return ovl_i_path_type(d_inode(dentry), d_is_dir(dentry), oe->numlower);
+}
+
 void ovl_path_upper(struct dentry *dentry, struct path *path)
 {
 	struct ovl_fs *ofs = dentry->d_sb->s_fs_info;
@@ -250,6 +256,41 @@ struct dentry *ovl_i_dentry_upper(struct inode *inode)
 	return ovl_upperdentry_dereference(OVL_I(inode));
 }
 
+struct dentry *ovl_i_dentry_lower(struct inode *inode)
+{
+	return OVL_I(inode)->lowerpath.dentry;
+}
+
+struct dentry *ovl_i_dentry_real(struct inode *inode)
+{
+	return ovl_i_dentry_upper(inode) ?: ovl_i_dentry_lower(inode);
+}
+
+const struct ovl_layer *ovl_i_layer_lower(struct inode *inode)
+{
+	return OVL_I(inode)->lowerpath.layer;
+}
+
+enum ovl_path_type ovl_i_path_real(struct inode *inode, struct path *path)
+{
+	struct dentry *lowerdentry = ovl_i_dentry_lower(inode);
+	/* Will not set the __OVL_PATH_MERGE bit for merge lowers dir */
+	enum ovl_path_type type = ovl_i_path_type(inode, S_ISDIR(inode->i_mode),
+						  !!lowerdentry);
+
+	if (OVL_TYPE_UPPER(type)) {
+		path->dentry = ovl_i_dentry_upper(inode);
+		path->mnt = ovl_upper_mnt(OVL_FS(inode->i_sb));
+	} else if (lowerdentry) {
+		path->dentry = lowerdentry;
+		path->mnt = ovl_i_layer_lower(inode)->mnt;
+	} else {
+		*path = (struct path) { };
+	}
+
+	return type;
+}
+
 struct inode *ovl_inode_upper(struct inode *inode)
 {
 	struct dentry *upperdentry = ovl_i_dentry_upper(inode);
@@ -259,7 +300,9 @@ struct inode *ovl_inode_upper(struct inode *inode)
 
 struct inode *ovl_inode_lower(struct inode *inode)
 {
-	return OVL_I(inode)->lower;
+	struct dentry *lowerdentry = ovl_i_dentry_lower(inode);
+
+	return lowerdentry ? d_inode(lowerdentry) : NULL;
 }
 
 struct inode *ovl_inode_real(struct inode *inode)
-- 
2.32.0

