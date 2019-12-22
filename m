Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C54B128D30
	for <lists+linux-unionfs@lfdr.de>; Sun, 22 Dec 2019 09:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfLVIIO (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 22 Dec 2019 03:08:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38015 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfLVIIO (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 22 Dec 2019 03:08:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so13496698wrh.5
        for <linux-unionfs@vger.kernel.org>; Sun, 22 Dec 2019 00:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m34Irb+3SmUjqqRr9x8wBetSfBFzbu8iKHS2EMORYz4=;
        b=pMX6m9Yd9p2qS/q5PfLY6ovCqSUfNN1UIR5aA16ZKUGYMG6BjFvd2s70VGyZAzZQ15
         GLZXPtY8wJQcAf5ppTcxhhRGqA9X9P/lh8+kj90hu1Pr9LF++oakIw44HA4ZS7hczLgK
         44o9yObY95JUbEnxk7t7kHVilLUVr1h/AKbYMPldJTCCH92P7PoZvQOENoD3ERivkudx
         nD1n3Ws0NLXgOqXqau9yd1YJPqYVM291eNFSoOxIuQBA0gb0ShL6qZqshGs1xN5WOCR0
         9bwxcJF5OcSIqsGVVR3Ex2W/D3sbFrb01PNAPXyYcMrAV/RIqaezpHuVh28TMmBnASKa
         4EGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m34Irb+3SmUjqqRr9x8wBetSfBFzbu8iKHS2EMORYz4=;
        b=EjgHncY6/EVA7/xjWunW0tP/C3oqejyg80+NAxYnaWVhI1uQUhrd4TnJeLsyxn4kno
         hGEZ6yba4a+/7RWPdqO6huq37mMADrX8jg+8jvtIYrWgNwaAT3D8gf3qSlL8jr/ilWR8
         61njvcXoRtdGO3azQA6wfbgHL7ic1GDHQkhY4xCStedKfx41OHHY1yRvIXh7gKhacYoD
         Y/LVBP093E2QEDxvUWxhe8K/X4WGASQ6PdDhjrExroY7BS2jpnd1LvmPvF+b9l+Y0/Nr
         oEYgVhH0KGjI/OFi4GvWcNpKTAvEIeWkzb7lmats7IUHBcAWpc782yLwHiny7jN+kjG0
         YSpQ==
X-Gm-Message-State: APjAAAX4buFPY6VGcw4VH2oFldAvS8Sfkv8zDZSCIM3II14f4KMG7uNQ
        DKW++OOmEQ5Tc4iaV1d7TsM=
X-Google-Smtp-Source: APXvYqy+8CxRwaNXiy9xSiqsoMGcTMwhIVNPs7WDCJLGTmWTWhSY5dsgxD1mjGaCrDMD5Crcjawubw==
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr23069050wrw.373.1577002091297;
        Sun, 22 Dec 2019 00:08:11 -0800 (PST)
Received: from localhost.localdomain ([141.226.162.223])
        by smtp.gmail.com with ESMTPSA id g23sm15697141wmk.14.2019.12.22.00.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 00:08:10 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org
Subject: [PATCH v2 2/5] ovl: simplify ovl_same_sb() helper
Date:   Sun, 22 Dec 2019 10:07:56 +0200
Message-Id: <20191222080759.32035-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191222080759.32035-1-amir73il@gmail.com>
References: <20191222080759.32035-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

No code uses the sb returned from this helper, so make it retrun
a boolean and rename it to ovl_same_fs().

The xino mode is irrelevant when all layers are on same fs, so
instead of describing samefs with mode OVL_XINO_OFF, use a new mode
OVL_XINO_SAME_FS, which is different than the case of non-samefs
with xino=off.

Create a new helper ovl_same_dev(), to use instead of the common check
for (ovl_same_fs() || xinobits).

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/inode.c     |  8 ++++----
 fs/overlayfs/overlayfs.h | 21 ++++++++++++++++++++-
 fs/overlayfs/ovl_entry.h |  5 +++++
 fs/overlayfs/readdir.c   |  4 ++--
 fs/overlayfs/super.c     | 13 +++++--------
 fs/overlayfs/util.c      | 12 ------------
 6 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 35712f54fdf9..b510e8408be3 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -78,7 +78,7 @@ int ovl_setattr(struct dentry *dentry, struct iattr *attr)
 static int ovl_map_dev_ino(struct dentry *dentry, struct kstat *stat,
 			   struct ovl_layer *lower_layer)
 {
-	bool samefs = ovl_same_sb(dentry->d_sb);
+	bool samefs = ovl_same_fs(dentry->d_sb);
 	unsigned int xinobits = ovl_xino_bits(dentry->d_sb);
 
 	if (samefs) {
@@ -146,7 +146,7 @@ int ovl_getattr(const struct path *path, struct kstat *stat,
 	struct path realpath;
 	const struct cred *old_cred;
 	bool is_dir = S_ISDIR(dentry->d_inode->i_mode);
-	bool samefs = ovl_same_sb(dentry->d_sb);
+	bool samefs = ovl_same_fs(dentry->d_sb);
 	struct ovl_layer *lower_layer = NULL;
 	int err;
 	bool metacopy_blocks = false;
@@ -168,7 +168,7 @@ int ovl_getattr(const struct path *path, struct kstat *stat,
 	 * If lower filesystem supports NFS file handles, this also guaranties
 	 * persistent st_ino across mount cycle.
 	 */
-	if (!is_dir || samefs || ovl_xino_bits(dentry->d_sb)) {
+	if (!is_dir || ovl_same_dev(dentry->d_sb)) {
 		if (!OVL_TYPE_UPPER(type)) {
 			lower_layer = ovl_dentry_layer(dentry);
 		} else if (OVL_TYPE_ORIGIN(type)) {
@@ -586,7 +586,7 @@ static void ovl_fill_inode(struct inode *inode, umode_t mode, dev_t rdev,
 	 * ovl_new_inode(), ino arg is 0, so i_ino will be updated to real
 	 * upper inode i_ino on ovl_inode_init() or ovl_inode_update().
 	 */
-	if (ovl_same_sb(inode->i_sb) || xinobits) {
+	if (ovl_same_dev(inode->i_sb)) {
 		inode->i_ino = ino;
 		if (xinobits && fsid && !(ino >> (64 - xinobits)))
 			inode->i_ino |= (unsigned long)fsid << (64 - xinobits);
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 50d41a314308..f7d01c06cdaf 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -45,6 +45,14 @@ enum ovl_entry_flag {
 	OVL_E_CONNECTED,
 };
 
+enum {
+	OVL_XINO_OFF,
+	OVL_XINO_AUTO,
+	OVL_XINO_ON,
+	/* With samefs, xino is irrelevant */
+	OVL_XINO_SAME_FS,
+};
+
 /*
  * The tuple (fh,uuid) is a universal unique identifier for a copy up origin,
  * where:
@@ -221,7 +229,6 @@ int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
 struct dentry *ovl_workdir(struct dentry *dentry);
 const struct cred *ovl_override_creds(struct super_block *sb);
-struct super_block *ovl_same_sb(struct super_block *sb);
 int ovl_can_decode_fh(struct super_block *sb);
 struct dentry *ovl_indexdir(struct super_block *sb);
 bool ovl_index_all(struct super_block *sb);
@@ -306,6 +313,18 @@ static inline unsigned int ovl_xino_bits(struct super_block *sb)
 	return ofs->xino_bits;
 }
 
+/* All layers on same fs? */
+static inline bool ovl_same_fs(struct super_block *sb)
+{
+	return OVL_FS(sb)->config.xino == OVL_XINO_SAME_FS;
+}
+
+/* All overlay inodes have same st_dev? */
+static inline bool ovl_same_dev(struct super_block *sb)
+{
+	return OVL_FS(sb)->config.xino != OVL_XINO_OFF;
+}
+
 static inline int ovl_inode_lock(struct inode *inode)
 {
 	return mutex_lock_interruptible(&OVL_I(inode)->lock);
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index ffaf7376f4ab..ef05817d8d89 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -75,6 +75,11 @@ struct ovl_fs {
 	unsigned int xino_bits;
 };
 
+static inline struct ovl_fs *OVL_FS(struct super_block *sb)
+{
+	return (struct ovl_fs *)sb->s_fs_info;
+}
+
 /* private information held for every overlayfs dentry */
 struct ovl_entry {
 	union {
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 32a7f8a38091..56f13e9ccbe6 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -469,7 +469,7 @@ static int ovl_cache_update_ino(struct path *path, struct ovl_cache_entry *p)
 	int xinobits = ovl_xino_bits(dir->d_sb);
 	int err = 0;
 
-	if (!ovl_same_sb(dir->d_sb) && !xinobits)
+	if (!ovl_same_dev(dir->d_sb))
 		goto out;
 
 	if (p->name[0] == '.') {
@@ -737,7 +737,7 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 		 * entries.
 		 */
 		if (ovl_xino_bits(dentry->d_sb) ||
-		    (ovl_same_sb(dentry->d_sb) &&
+		    (ovl_same_fs(dentry->d_sb) &&
 		     (ovl_is_impure_dir(file) ||
 		      OVL_TYPE_MERGE(ovl_path_type(dentry->d_parent))))) {
 			return ovl_iterate_real(file, ctx);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 84f96f64bbb8..2d03ab26e202 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -316,12 +316,6 @@ static const char *ovl_redirect_mode_def(void)
 	return ovl_redirect_dir_def ? "on" : "off";
 }
 
-enum {
-	OVL_XINO_OFF,
-	OVL_XINO_AUTO,
-	OVL_XINO_ON,
-};
-
 static const char * const ovl_xino_str[] = {
 	"off",
 	"auto",
@@ -358,7 +352,8 @@ static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 	if (ofs->config.nfs_export != ovl_nfs_export_def)
 		seq_printf(m, ",nfs_export=%s", ofs->config.nfs_export ?
 						"on" : "off");
-	if (ofs->config.xino != ovl_xino_def())
+	if (ofs->config.xino != ovl_xino_def() &&
+	    ofs->config.xino != OVL_XINO_SAME_FS)
 		seq_printf(m, ",xino=%s", ovl_xino_str[ofs->config.xino]);
 	if (ofs->config.metacopy != ovl_metacopy_def)
 		seq_printf(m, ",metacopy=%s",
@@ -1393,8 +1388,10 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 	 * inode number.
 	 */
 	if (!ofs->numlowerfs || (ofs->numlowerfs == 1 && !ofs->upper_mnt)) {
+		if (ofs->config.xino == OVL_XINO_ON)
+			pr_info("overlayfs: \"xino=on\" is useless with all layers on same fs, ignore.\n");
 		ofs->xino_bits = 0;
-		ofs->config.xino = OVL_XINO_OFF;
+		ofs->config.xino = OVL_XINO_SAME_FS;
 	} else if (ofs->config.xino == OVL_XINO_ON && !ofs->xino_bits) {
 		/*
 		 * This is a roundup of number of bits needed for numlowerfs+1
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 3fa1ca8ddd48..256f166b4a17 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -40,18 +40,6 @@ const struct cred *ovl_override_creds(struct super_block *sb)
 	return override_creds(ofs->creator_cred);
 }
 
-struct super_block *ovl_same_sb(struct super_block *sb)
-{
-	struct ovl_fs *ofs = sb->s_fs_info;
-
-	if (!ofs->numlowerfs)
-		return ofs->upper_mnt->mnt_sb;
-	else if (ofs->numlowerfs == 1 && !ofs->upper_mnt)
-		return ofs->lower_fs[0].sb;
-	else
-		return NULL;
-}
-
 /*
  * Check if underlying fs supports file handles and try to determine encoding
  * type, in order to deduce maximum inode number used by fs.
-- 
2.17.1

