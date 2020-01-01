Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE8812DFDD
	for <lists+linux-unionfs@lfdr.de>; Wed,  1 Jan 2020 18:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgAAR6d (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 1 Jan 2020 12:58:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37145 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbgAAR6d (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 1 Jan 2020 12:58:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so3949792wmf.2
        for <linux-unionfs@vger.kernel.org>; Wed, 01 Jan 2020 09:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qd6J1B9kgHTV0/epgnMncrIUuklnSk8WpIEXl719SCA=;
        b=USNp9VBco5vuWT8wpQynBz4y3I3NvU1RVNmYTlA/ELWbx9eMzl6TiTlMT4kVfocGwq
         X3GE39lO3hI+mI9tmZOcEu0D9xVQUz4skHKWmR9ENKBrdzfSlxfAi7zgw3GedY2kWsya
         NHkb8pv18jYlKu5zJLTHzJHyq3pq7B+zfCdYDtK+N0bxi1Rn2zoaMhjenEI6yRo88Fpu
         EUdi2nL1pnAHEAD1kgy0JMi3qGu2hiagv5LYyKe2kTsNwxaUjiQ7dE/RkdNm+tleUZLR
         kPamsqN1mMZ5bHx3R7oeyEHaAisOsFaMBrkpsc5TbAzF08HtM6TU3vGYNYCMKBf9zAcx
         S1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qd6J1B9kgHTV0/epgnMncrIUuklnSk8WpIEXl719SCA=;
        b=dXdmESeIxh53EV2QjQAY5xn9su+FBIyvrOEDaPzg6gIABk3jZCyLjh9dGW++QqJ+2j
         Vjwnfr+TxGNuyjICLkiuqWAmt+cDCxRvuAbHnvtHLscKbCL7hGTdD4+78ITkogXK5xYs
         tTHSoxc5uZXicOxNw7ibdvwEgyB9OU4T0sbwpipBJo2GYQj23XRI+HFgpV+3oaD0S/pn
         saiZ84F1wb4/9OIvmC//TfR0dxPKK4E2RaaqlbNB9VNR2ny5+iSNs7NBzzWpBGBKjoR1
         V16gia0AIMKB2+UMWOjWoSseDeBAaukONL9/U9VW9v+UijOL1e3kej3Yavx8YyNJZgZK
         QVIg==
X-Gm-Message-State: APjAAAVshRLtY1G/DxShSu84mXey4eJyBR/TXLNpWputfckQAj2k9Xyy
        vNaz7OUfNjPNaWhQaNcRH7A=
X-Google-Smtp-Source: APXvYqyKE1lgBXu1SqKvl7p4jujKXBkV8XwSe2gmIp6n96kyLoEAGZZRJ4qXylJqAIcDDZSdawau7A==
X-Received: by 2002:a1c:2355:: with SMTP id j82mr10567832wmj.135.1577901509802;
        Wed, 01 Jan 2020 09:58:29 -0800 (PST)
Received: from localhost.localdomain ([141.226.169.66])
        by smtp.gmail.com with ESMTPSA id z3sm53274778wrs.94.2020.01.01.09.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 09:58:29 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org
Subject: [PATCH 5/7] ovl: avoid possible inode number collisions with xino=on
Date:   Wed,  1 Jan 2020 19:58:12 +0200
Message-Id: <20200101175814.14144-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200101175814.14144-1-amir73il@gmail.com>
References: <20200101175814.14144-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

When xino feature is enabled and a real directory inode number
overflows the lower xino bits, we cannot map this directory inode
number to a unique and persistent inode number and we fall back to
the real inode st_ino and overlay st_dev.

The real inode st_ino with high bits may collide with a lower inode
number on overlay st_dev that was mapped using xino.

To avoid possible collision with legitimate xino values, map a non
persistent inode number to a dedicated range in the xino address space.
The dedicated range is created by adding one more bit to the number of
reserved high xino bits.  We could have added just one more fsid, but
that would have had the undesired effect of changing persistent overlay
inode numbers on kernel or require more complex xino mapping code.

The non persistent inode number is allocated with get_next_ino()
and stored in i_generation.  To reduce the burn rate of get_next_ino()
numbers in the system, we avoid calling get_next_ino() on non dir,
because we are not going to use it and we reuse i_generation from
recycled ovl_inode objects.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/inode.c     | 54 ++++++++++++++++++++++++++++++++--------
 fs/overlayfs/overlayfs.h |  7 ++++++
 fs/overlayfs/super.c     | 28 ++++++++++++---------
 3 files changed, 66 insertions(+), 23 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 04e8e8de2012..415d9efa4799 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -79,6 +79,7 @@ static int ovl_map_dev_ino(struct dentry *dentry, struct kstat *stat, int fsid)
 {
 	bool samefs = ovl_same_fs(dentry->d_sb);
 	unsigned int xinobits = ovl_xino_bits(dentry->d_sb);
+	unsigned int shift = 64 - xinobits;
 
 	if (samefs) {
 		/*
@@ -89,7 +90,6 @@ static int ovl_map_dev_ino(struct dentry *dentry, struct kstat *stat, int fsid)
 		stat->dev = dentry->d_sb->s_dev;
 		return 0;
 	} else if (xinobits) {
-		unsigned int shift = 64 - xinobits;
 		/*
 		 * All inode numbers of underlying fs should not be using the
 		 * high xinobits, so we use high xinobits to partition the
@@ -116,11 +116,25 @@ static int ovl_map_dev_ino(struct dentry *dentry, struct kstat *stat, int fsid)
 		 * overlay mount boundaries.
 		 *
 		 * If not all layers are on the same fs the pair {real st_ino;
-		 * overlay st_dev} is not unique, so use the non persistent
-		 * overlay st_ino for directories.
+		 * overlay st_dev} is not unique, so use a non persistent
+		 * overlay st_ino for directories, which is allocated with
+		 * get_next_ino() and stored in i_generation.
+		 *
+		 * To avoid ino collision with legitimate xino values from upper
+		 * layer (fsid 0), use fsid 1 to map the non persistent inode
+		 * numbers to the unified st_ino address space.
+		 *
+		 * In this case (xino bits overflow on directory inode), the
+		 * value of overlay inode st_ino will not be consistent with
+		 * d_ino and i_ino. i_ino will have the value of the real inode
+		 * i_ino and d_ino will have either the value of i_ino or the
+		 * value of st_ino, depending on the directory iteration mode
+		 * that is used on the parent (i.e. real/merge/impure).
 		 */
 		stat->dev = dentry->d_sb->s_dev;
-		stat->ino = dentry->d_inode->i_ino;
+		stat->ino = dentry->d_inode->i_generation;
+		if (xinobits)
+			stat->ino |= ((u64)1) << shift;
 	} else {
 		/*
 		 * For non-samefs setup, if we cannot map all layers st_ino
@@ -128,7 +142,7 @@ static int ovl_map_dev_ino(struct dentry *dentry, struct kstat *stat, int fsid)
 		 * is unique per underlying fs, so we use the unique anonymous
 		 * bdev assigned to the underlying fs.
 		 */
-		stat->dev = OVL_FS(dentry->d_sb)->fs[fsid].pseudo_dev;
+		stat->dev = ovl_dentry_fs(dentry, fsid)->pseudo_dev;
 	}
 
 	return 0;
@@ -564,6 +578,7 @@ static inline void ovl_lockdep_annotate_inode_mutex_key(struct inode *inode)
 static void ovl_map_ino(struct inode *inode, unsigned long ino, int fsid)
 {
 	int xinobits = ovl_xino_bits(inode->i_sb);
+	bool overflow = ino >> (64 - xinobits);
 
 	/*
 	 * When d_ino is consistent with st_ino (samefs or i_ino has enough
@@ -571,13 +586,30 @@ static void ovl_map_ino(struct inode *inode, unsigned long ino, int fsid)
 	 * so inode number exposed via /proc/locks and a like will be
 	 * consistent with d_ino and st_ino values. An i_ino value inconsistent
 	 * with d_ino also causes nfsd readdirplus to fail.
+	 *
+	 * When real inode bits overflow into xino bits, we leave i_ino value as
+	 * the real inode to be consitent with d_ino.  For directory inodes on
+	 * non-samefs with xino disabled or xino overflow, we reserve a unique
+	 * 32bit generation number, to be used for resolving st_ino collisions
+	 * in ovl_map_dev_ino(). With xino disabled, this 32bit number is also
+	 * used as i_ino.
 	 */
-	if (ovl_same_dev(inode->i_sb)) {
-		inode->i_ino = ino;
-		if (xinobits && fsid && !(ino >> (64 - xinobits)))
-			inode->i_ino |= (unsigned long)fsid << (64 - xinobits);
-	} else {
-		inode->i_ino = get_next_ino();
+	inode->i_ino = ino;
+	if (ovl_same_dev(inode->i_sb) && !overflow) {
+		inode->i_ino |= (unsigned long)fsid << (64 - xinobits);
+	} else if (S_ISDIR(inode->i_mode)) {
+		/*
+		 * Reuse unique 32bit ino from recycled ovl_inode object.
+		 * get_next_ino() wraps around at 32bit, but may be extended
+		 * to 64bit in the future, so be prepared.
+		 */
+		if (!inode->i_generation) {
+			inode->i_generation = (u32)get_next_ino();
+			if (unlikely(!inode->i_generation))
+				inode->i_generation = (u32)get_next_ino();
+		}
+		if (!ovl_same_dev(inode->i_sb))
+			inode->i_ino = inode->i_generation;
 	}
 }
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 140510d24d9f..c0b15fd2b395 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -311,6 +311,13 @@ static inline unsigned int ovl_xino_bits(struct super_block *sb)
 	return ofs->xino_bits;
 }
 
+static inline struct ovl_sb *ovl_dentry_fs(struct dentry *dentry, int fsid)
+{
+	/* fsid bit 1 is reserved for non persistent ino range */
+	WARN_ON_ONCE(fsid & 1);
+	return &OVL_FS(dentry->d_sb)->fs[fsid >> 1];
+}
+
 /* All layers on same fs? */
 static inline bool ovl_same_fs(struct super_block *sb)
 {
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index d072f982d3de..d636a23df541 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1272,8 +1272,8 @@ static bool ovl_lower_uuid_ok(struct ovl_fs *ofs, const uuid_t *uuid)
 	return true;
 }
 
-/* Get a unique fsid for the layer */
-static int ovl_get_fsid(struct ovl_fs *ofs, const struct path *path)
+/* Get a unique fs for the layer */
+static int ovl_get_fs(struct ovl_fs *ofs, const struct path *path)
 {
 	struct super_block *sb = path->mnt->mnt_sb;
 	unsigned int i;
@@ -1353,9 +1353,9 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 	for (i = 0; i < numlower; i++) {
 		struct vfsmount *mnt;
 		struct inode *trap;
-		int fsid;
+		int n;
 
-		err = fsid = ovl_get_fsid(ofs, &stack[i]);
+		err = n = ovl_get_fs(ofs, &stack[i]);
 		if (err < 0)
 			goto out;
 
@@ -1387,9 +1387,10 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 		ofs->layers[ofs->numlower].trap = trap;
 		ofs->layers[ofs->numlower].mnt = mnt;
 		ofs->layers[ofs->numlower].idx = ofs->numlower;
-		ofs->layers[ofs->numlower].fsid = fsid;
-		ofs->layers[ofs->numlower].fs = &ofs->fs[fsid];
-		ofs->fs[fsid].is_lower = true;
+		/* fsid bit 1 is reserved for non persistent ino range */
+		ofs->layers[ofs->numlower].fsid = n << 1;
+		ofs->layers[ofs->numlower].fs = &ofs->fs[n];
+		ofs->fs[n].is_lower = true;
 	}
 
 	/*
@@ -1398,7 +1399,8 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 	 * free high bits in underlying fs to hold the unique fsid.
 	 * If overlayfs does encounter underlying inodes using the high xino
 	 * bits reserved for fsid, it emits a warning and uses the original
-	 * inode number.
+	 * inode number or a non persistent inode number allocated from a
+	 * dedicated range.
 	 */
 	if (ofs->numfs == 1 || (ofs->numfs == 2 && !ofs->upper_mnt)) {
 		if (ofs->config.xino == OVL_XINO_ON)
@@ -1408,11 +1410,13 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 	} else if (ofs->config.xino == OVL_XINO_ON && !ofs->xino_bits) {
 		/*
 		 * This is a roundup of number of bits needed for encoding
-		 * fsid, where fsid 0 is reserved for upper fs even with
-		 * lower only overlay.
+		 * fsid, where fsid 0 is reserved for upper fs (even with
+		 * lower only overlay) and fsid bit 1 is reserved for the non
+		 * persistent inode number range that is used for resolving
+		 * xino lower bits overflow.
 		 */
-		BUILD_BUG_ON(ilog2(OVL_MAX_STACK) > 31);
-		ofs->xino_bits = ilog2(ofs->numfs - 1) + 1;
+		BUILD_BUG_ON(ilog2(OVL_MAX_STACK) > 30);
+		ofs->xino_bits = ilog2(ofs->numfs - 1) + 2;
 	}
 
 	if (ofs->xino_bits) {
-- 
2.17.1

