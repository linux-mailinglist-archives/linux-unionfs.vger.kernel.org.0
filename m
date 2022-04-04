Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3862E4F1366
	for <lists+linux-unionfs@lfdr.de>; Mon,  4 Apr 2022 12:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356386AbiDDKzu (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 4 Apr 2022 06:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358584AbiDDKzs (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 4 Apr 2022 06:55:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B05114026
        for <linux-unionfs@vger.kernel.org>; Mon,  4 Apr 2022 03:53:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6021F60AE2
        for <linux-unionfs@vger.kernel.org>; Mon,  4 Apr 2022 10:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E432AC340F3;
        Mon,  4 Apr 2022 10:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649069629;
        bh=Ey/3XPZ6kg4076G/5z6aH+hG6coL/gORxacZG9YwIHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TGP8cWPJGdCob0VxMSumXI2Xjcdoeg2wMtQrmMRpdqCWFxoPQjsSz0MoCO1jm1RM1
         4iwcloP47u8RRDKmq047n8aTTwoz1NGJ7cAQPEOjDzVmvLfZxtqztt6PxPVHkRtu6/
         +B2P7F2b9K+dd1rFRjHGcdO/VslsiBAHLr/sorV3PYtkr3YUIRNv26fxyPC+3TKPbU
         bZqoQx11wWuLbOzX7KMgBw1mB94g36QPJ0xSQceY6YTeHURTke7rUNJXxGg1F5qEd6
         DuMO7/ElbfYB/7qeY9SjuBl6T1oIcpQUxw05ICQ4LhYnjJOvmplGVQDlEFBogR/0qI
         j6nMcNeqyMNmw==
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
Subject: [PATCH v4 07/19] ovl: pass ofs to setattr operations
Date:   Mon,  4 Apr 2022 12:51:46 +0200
Message-Id: <20220404105159.1567595-8-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404105159.1567595-1-brauner@kernel.org>
References: <20220404105159.1567595-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4425; h=from:subject; bh=Ey/3XPZ6kg4076G/5z6aH+hG6coL/gORxacZG9YwIHY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR5nT2S55891yhyhVftykSvZ2dlBRc0/xA/0eCZ5upbM391 yaVdHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5wc7IMP11+yslzqrry21e33doVl KdwC/5Zdr5zYEpkR9afH4xMjIybHliJy7lcujjFLcVDTGbDwres2ZsTfKZbW4pY/PCbE0SNwA=
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

Pass down struct ovl_fs to setattr operations so we can ultimately
retrieve the relevant upper mount and take the mount's idmapping into
account when creating new filesystem objects. This is needed to support
idmapped base layers with overlay.

Cc: <linux-unionfs@vger.kernel.org>
Tested-by: Giuseppe Scrivano <gscrivan@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
/* v2 */
unchanged

/* v3 */
unchanged

/* v4 */
unchanged
---
 fs/overlayfs/copy_up.c   | 19 +++++++++++--------
 fs/overlayfs/dir.c       |  2 +-
 fs/overlayfs/overlayfs.h |  2 +-
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 44605c51a382..2c336acb2ba0 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -293,7 +293,8 @@ static int ovl_copy_up_data(struct ovl_fs *ofs, struct path *old,
 	return error;
 }
 
-static int ovl_set_size(struct dentry *upperdentry, struct kstat *stat)
+static int ovl_set_size(struct ovl_fs *ofs,
+			struct dentry *upperdentry, struct kstat *stat)
 {
 	struct iattr attr = {
 		.ia_valid = ATTR_SIZE,
@@ -303,7 +304,8 @@ static int ovl_set_size(struct dentry *upperdentry, struct kstat *stat)
 	return notify_change(&init_user_ns, upperdentry, &attr, NULL);
 }
 
-static int ovl_set_timestamps(struct dentry *upperdentry, struct kstat *stat)
+static int ovl_set_timestamps(struct ovl_fs *ofs, struct dentry *upperdentry,
+			      struct kstat *stat)
 {
 	struct iattr attr = {
 		.ia_valid =
@@ -315,7 +317,8 @@ static int ovl_set_timestamps(struct dentry *upperdentry, struct kstat *stat)
 	return notify_change(&init_user_ns, upperdentry, &attr, NULL);
 }
 
-int ovl_set_attr(struct dentry *upperdentry, struct kstat *stat)
+int ovl_set_attr(struct ovl_fs *ofs, struct dentry *upperdentry,
+		 struct kstat *stat)
 {
 	int err = 0;
 
@@ -335,7 +338,7 @@ int ovl_set_attr(struct dentry *upperdentry, struct kstat *stat)
 		err = notify_change(&init_user_ns, upperdentry, &attr, NULL);
 	}
 	if (!err)
-		ovl_set_timestamps(upperdentry, stat);
+		ovl_set_timestamps(ofs, upperdentry, stat);
 
 	return err;
 }
@@ -542,7 +545,7 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
 
 		if (!err) {
 			/* Restore timestamps on parent (best effort) */
-			ovl_set_timestamps(upperdir, &c->pstat);
+			ovl_set_timestamps(ofs, upperdir, &c->pstat);
 			ovl_dentry_set_upper_alias(c->dentry);
 		}
 	}
@@ -616,9 +619,9 @@ static int ovl_copy_up_inode(struct ovl_copy_up_ctx *c, struct dentry *temp)
 
 	inode_lock(temp->d_inode);
 	if (S_ISREG(c->stat.mode))
-		err = ovl_set_size(temp, &c->stat);
+		err = ovl_set_size(ofs, temp, &c->stat);
 	if (!err)
-		err = ovl_set_attr(temp, &c->stat);
+		err = ovl_set_attr(ofs, temp, &c->stat);
 	inode_unlock(temp->d_inode);
 
 	return err;
@@ -840,7 +843,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 
 		/* Restore timestamps on parent (best effort) */
 		inode_lock(udir);
-		ovl_set_timestamps(c->destdir, &c->pstat);
+		ovl_set_timestamps(ofs, c->destdir, &c->pstat);
 		inode_unlock(udir);
 
 		ovl_dentry_set_upper_alias(c->dentry);
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 8da72b1ebafc..27a40b6754f4 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -408,7 +408,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 		goto out_cleanup;
 
 	inode_lock(opaquedir->d_inode);
-	err = ovl_set_attr(opaquedir, &stat);
+	err = ovl_set_attr(ofs, opaquedir, &stat);
 	inode_unlock(opaquedir->d_inode);
 	if (err)
 		goto out_cleanup;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 85c503ba9c76..05b549a01b70 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -622,7 +622,7 @@ int ovl_copy_up_with_data(struct dentry *dentry);
 int ovl_maybe_copy_up(struct dentry *dentry, int flags);
 int ovl_copy_xattr(struct super_block *sb, struct dentry *old,
 		   struct dentry *new);
-int ovl_set_attr(struct dentry *upper, struct kstat *stat);
+int ovl_set_attr(struct ovl_fs *ofs, struct dentry *upper, struct kstat *stat);
 struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct dentry *real,
 				  bool is_upper);
 int ovl_set_origin(struct ovl_fs *ofs, struct dentry *lower,
-- 
2.32.0

