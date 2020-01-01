Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01BCE12DFDB
	for <lists+linux-unionfs@lfdr.de>; Wed,  1 Jan 2020 18:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgAAR6b (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 1 Jan 2020 12:58:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44589 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbgAAR6b (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 1 Jan 2020 12:58:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so37383815wrm.11
        for <linux-unionfs@vger.kernel.org>; Wed, 01 Jan 2020 09:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EVWyOs1JH8yTs0it/+YAtg8P/RVsoOtkFd5zeQ5JblI=;
        b=heP94P7olH4JLu8gmpU4OyKtUWzjFgE/nCMPfBC/wAt9RankH+u1mxfIiMvhTNJMiC
         BeJsXDE9NnhhfvwSfv8GEVMRK5IwnvXHQkoNttheTFyCRkRAHwSkK9/dDsBMr/a1KScc
         iutywFPcmsLL/7OQ9PS++pXACKci80rE1ZkHSpQQ+tb0xQrkdJUTdEOXITrAytU4QQPh
         UzV5FuySE9myksViFxLgm5hdM3D9g28NNWMDQQMnkmMGC0B6gjb2ybTZJFlIAY/UPkPm
         ctRWuZQ8JgNGmGzoW/fiNFbH98nA6AIGr++C3Dce1lOY2/7919t5rAXtBDXlpPM5Uqz3
         uqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EVWyOs1JH8yTs0it/+YAtg8P/RVsoOtkFd5zeQ5JblI=;
        b=Y1RTn6wQF/dUHagxN9XfZ016o5nW3aZ5kYvZwPw9XO8DxTMwaCSJB7kmP5891fFHh/
         EPM1+1uBA8nuRUx7AAna0LuUOz2E9VZUETWcR5aXSXfjG0I1ZPfmOpkd6TqsNu7y0AAD
         rXhkSgb7eHLukZ3FFH0f78FH4s0H5VhvM0d8EOVwax8WiZRX7m2aEpCtAlzut+V44IEl
         XsXeXs2NoVHMIIgNHDwbE1bhSi2bmHnZNX/zUYGB0TBTAIv/eUJe5gAUkl9l5qoatFuI
         KDHqHTPB5pObtyhR2Rm/x2DnKkvHan/+KodBs0Gdkb208XWY9haDPa1b/t4GJa6RqYg1
         dKVQ==
X-Gm-Message-State: APjAAAUvo/cvAomMEAlc7Rb/EMAvZKvMYnq9FAmsA6ByMqvlh4yWJZFb
        nnXLc7H/UpNfas9MpbLIqoLzancK
X-Google-Smtp-Source: APXvYqwBr+znu4LmNbcZ5Ux2/ytETTki4LQ/7vTiKvrK0EEu5e1cnKQMw4TtusiTVTKL12CglO9MPQ==
X-Received: by 2002:adf:9104:: with SMTP id j4mr79181105wrj.221.1577901508751;
        Wed, 01 Jan 2020 09:58:28 -0800 (PST)
Received: from localhost.localdomain ([141.226.169.66])
        by smtp.gmail.com with ESMTPSA id z3sm53274778wrs.94.2020.01.01.09.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 09:58:28 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org
Subject: [PATCH 4/7] ovl: simplify i_ino initialization
Date:   Wed,  1 Jan 2020 19:58:11 +0200
Message-Id: <20200101175814.14144-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200101175814.14144-1-amir73il@gmail.com>
References: <20200101175814.14144-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Move i_ino initialization to ovl_inode_init() to avoid the dance
of setting i_ino in ovl_fill_inode() sometimes on the first call
and sometimes on the seconds call.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/inode.c     | 35 ++++++++++++++++++++++++++---------
 fs/overlayfs/overlayfs.h |  4 ++--
 fs/overlayfs/super.c     | 13 +++++++++++--
 fs/overlayfs/util.c      | 18 ------------------
 4 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 9ed94c70e3cb..04e8e8de2012 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -561,8 +561,7 @@ static inline void ovl_lockdep_annotate_inode_mutex_key(struct inode *inode)
 #endif
 }
 
-static void ovl_fill_inode(struct inode *inode, umode_t mode, dev_t rdev,
-			   unsigned long ino, int fsid)
+static void ovl_map_ino(struct inode *inode, unsigned long ino, int fsid)
 {
 	int xinobits = ovl_xino_bits(inode->i_sb);
 
@@ -572,10 +571,6 @@ static void ovl_fill_inode(struct inode *inode, umode_t mode, dev_t rdev,
 	 * so inode number exposed via /proc/locks and a like will be
 	 * consistent with d_ino and st_ino values. An i_ino value inconsistent
 	 * with d_ino also causes nfsd readdirplus to fail.
-	 *
-	 * When called from ovl_create_object() => ovl_new_inode(), with
-	 * ino = 0, i_ino will be updated to consistent value later on in
-	 * ovl_get_inode() => ovl_fill_inode().
 	 */
 	if (ovl_same_dev(inode->i_sb)) {
 		inode->i_ino = ino;
@@ -584,6 +579,28 @@ static void ovl_fill_inode(struct inode *inode, umode_t mode, dev_t rdev,
 	} else {
 		inode->i_ino = get_next_ino();
 	}
+}
+
+void ovl_inode_init(struct inode *inode, struct ovl_inode_params *oip,
+		    unsigned long ino, int fsid)
+{
+	struct inode *realinode;
+
+	if (oip->upperdentry)
+		OVL_I(inode)->__upperdentry = oip->upperdentry;
+	if (oip->lowerpath && oip->lowerpath->dentry)
+		OVL_I(inode)->lower = igrab(d_inode(oip->lowerpath->dentry));
+	if (oip->lowerdata)
+		OVL_I(inode)->lowerdata = igrab(d_inode(oip->lowerdata));
+
+	realinode = ovl_inode_real(inode);
+	ovl_copyattr(realinode, inode);
+	ovl_copyflags(realinode, inode);
+	ovl_map_ino(inode, ino, fsid);
+}
+
+static void ovl_fill_inode(struct inode *inode, umode_t mode, dev_t rdev)
+{
 	inode->i_mode = mode;
 	inode->i_flags |= S_NOCMTIME;
 #ifdef CONFIG_FS_POSIX_ACL
@@ -721,7 +738,7 @@ struct inode *ovl_new_inode(struct super_block *sb, umode_t mode, dev_t rdev)
 
 	inode = new_inode(sb);
 	if (inode)
-		ovl_fill_inode(inode, mode, rdev, 0, 0);
+		ovl_fill_inode(inode, mode, rdev);
 
 	return inode;
 }
@@ -946,8 +963,8 @@ struct inode *ovl_get_inode(struct super_block *sb,
 		ino = realinode->i_ino;
 		fsid = lowerpath->layer->fsid;
 	}
-	ovl_fill_inode(inode, realinode->i_mode, realinode->i_rdev, ino, fsid);
-	ovl_inode_init(inode, upperdentry, lowerdentry, oip->lowerdata);
+	ovl_fill_inode(inode, realinode->i_mode, realinode->i_rdev);
+	ovl_inode_init(inode, oip, ino, fsid);
 
 	if (upperdentry && ovl_is_impuredir(upperdentry))
 		ovl_set_flag(OVL_IMPURE, inode);
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index f7d01c06cdaf..140510d24d9f 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -269,8 +269,6 @@ void ovl_set_upperdata(struct inode *inode);
 bool ovl_redirect_dir(struct super_block *sb);
 const char *ovl_dentry_get_redirect(struct dentry *dentry);
 void ovl_dentry_set_redirect(struct dentry *dentry, const char *redirect);
-void ovl_inode_init(struct inode *inode, struct dentry *upperdentry,
-		    struct dentry *lowerdentry, struct dentry *lowerdata);
 void ovl_inode_update(struct inode *inode, struct dentry *upperdentry);
 void ovl_dir_modified(struct dentry *dentry, bool impurity);
 u64 ovl_dentry_version_get(struct dentry *dentry);
@@ -412,6 +410,8 @@ struct ovl_inode_params {
 	char *redirect;
 	struct dentry *lowerdata;
 };
+void ovl_inode_init(struct inode *inode, struct ovl_inode_params *oip,
+		    unsigned long ino, int fsid);
 struct inode *ovl_new_inode(struct super_block *sb, umode_t mode, dev_t rdev);
 struct inode *ovl_lookup_inode(struct super_block *sb, struct dentry *real,
 			       bool is_upper);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 18db065d73b3..d072f982d3de 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1586,6 +1586,13 @@ static struct dentry *ovl_get_root(struct super_block *sb,
 				   struct ovl_entry *oe)
 {
 	struct dentry *root;
+	struct ovl_path *lowerpath = &oe->lowerstack[0];
+	unsigned long ino = d_inode(lowerpath->dentry)->i_ino;
+	int fsid = lowerpath->layer->fsid;
+	struct ovl_inode_params oip = {
+		.upperdentry = upperdentry,
+		.lowerpath = lowerpath,
+	};
 
 	root = d_make_root(ovl_new_inode(sb, S_IFDIR, 0));
 	if (!root)
@@ -1594,6 +1601,9 @@ static struct dentry *ovl_get_root(struct super_block *sb,
 	root->d_fsdata = oe;
 
 	if (upperdentry) {
+		/* Root inode uses upper st_ino/i_ino */
+		ino = d_inode(upperdentry)->i_ino;
+		fsid = 0;
 		ovl_dentry_set_upper_alias(root);
 		if (ovl_is_impuredir(upperdentry))
 			ovl_set_flag(OVL_IMPURE, d_inode(root));
@@ -1603,8 +1613,7 @@ static struct dentry *ovl_get_root(struct super_block *sb,
 	ovl_set_flag(OVL_WHITEOUTS, d_inode(root));
 	ovl_dentry_set_flag(OVL_E_CONNECTED, root);
 	ovl_set_upperdata(d_inode(root));
-	ovl_inode_init(d_inode(root), upperdentry, ovl_dentry_lower(root),
-		       NULL);
+	ovl_inode_init(d_inode(root), &oip, ino, fsid);
 
 	return root;
 }
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index b28ccede1da9..d6e3f8f42647 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -388,24 +388,6 @@ void ovl_dentry_set_redirect(struct dentry *dentry, const char *redirect)
 	oi->redirect = redirect;
 }
 
-void ovl_inode_init(struct inode *inode, struct dentry *upperdentry,
-		    struct dentry *lowerdentry, struct dentry *lowerdata)
-{
-	struct inode *realinode = d_inode(upperdentry ?: lowerdentry);
-
-	if (upperdentry)
-		OVL_I(inode)->__upperdentry = upperdentry;
-	if (lowerdentry)
-		OVL_I(inode)->lower = igrab(d_inode(lowerdentry));
-	if (lowerdata)
-		OVL_I(inode)->lowerdata = igrab(d_inode(lowerdata));
-
-	ovl_copyattr(realinode, inode);
-	ovl_copyflags(realinode, inode);
-	if (!inode->i_ino)
-		inode->i_ino = realinode->i_ino;
-}
-
 void ovl_inode_update(struct inode *inode, struct dentry *upperdentry)
 {
 	struct inode *upperinode = d_inode(upperdentry);
-- 
2.17.1

