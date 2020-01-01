Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C37BB12DFDC
	for <lists+linux-unionfs@lfdr.de>; Wed,  1 Jan 2020 18:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgAAR6d (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 1 Jan 2020 12:58:33 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42353 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgAAR6d (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 1 Jan 2020 12:58:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id q6so37326305wro.9
        for <linux-unionfs@vger.kernel.org>; Wed, 01 Jan 2020 09:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HivUCuW4LwEtog80JA/BnImcj0Iu9Z98W92h5uNUOQI=;
        b=IVjnzjh6TuV2bU8Iy+W0d7dTBRVdpC0uS94ImvFT3mN2NW5TxgOEzIggE13XA2pL4F
         068jxo0do34XdR/ueO9YCBW7dGKmBPRCXzMGWzrEm23qQE4Vx+ijzwsNZ8VV/siJtbPc
         x55TfCbrLSe7+WDWQUfzpcBzWPhFIOGgynfYs/D12bJFR6ciKxtu79ufs80NZbnE0x7v
         znyX+R9S9m1sR6JtJTdV3qrwU+RWkOMuoNmLUyfmMOYOCVWRgSPP0PMoEzBpXLKgO17t
         jMPjIG0OMXYX2vTN7oj+q3zaE/9I/IJE9TBId41EFkwmD8MHAS1c2r8shWL9fqdEN+3U
         AmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HivUCuW4LwEtog80JA/BnImcj0Iu9Z98W92h5uNUOQI=;
        b=QMy5n2ZCiE+11Asbt75uCYIZ0jj0kgPvdRQvNAZKWQDQ8B/h4wT7JXRhnj4d8xhTQq
         SefIIu4gCGcy6n3Z3SeROOOvn+KKj9S/a/slNmKqDlHzqrVoUEAQKYsTAEPGI1hdFubW
         Pb6ky+OKrRaj/2QpfGUxL65LfoKJAV4un9HghEs56d1WO2zHk8Dff0nqxF74OmXmOOKh
         KPeWtrMg3boWWrTqCzGnoCC5rHyOak8xzR8hFyj/tc22lmtjF/1OlXBogEvCZCSOMGr6
         XOVipE7TSjNa+MSe1bhyuWHNPRvTSiVQqjr8BbwjGWgsOrcGQeSvIllh+m+CLXfr7FhT
         TCaQ==
X-Gm-Message-State: APjAAAXvcfN7S3xJ2hs/dRIXYGN2/UzKZbkGcF2FRI83L9GlbvGXVldm
        39hTxXAhKjyZaI9rXwWIk/g=
X-Google-Smtp-Source: APXvYqxn/20a5ED8Ktsey3BuiCbPx3QlLfyryj2sD5+5UYLimtD18N8wtbuJR8T5rHs+f9+AbpR/Xg==
X-Received: by 2002:a5d:528e:: with SMTP id c14mr81788319wrv.308.1577901510835;
        Wed, 01 Jan 2020 09:58:30 -0800 (PST)
Received: from localhost.localdomain ([141.226.169.66])
        by smtp.gmail.com with ESMTPSA id z3sm53274778wrs.94.2020.01.01.09.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 09:58:30 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org
Subject: [PATCH 6/7] ovl: enable xino automatically in more cases
Date:   Wed,  1 Jan 2020 19:58:13 +0200
Message-Id: <20200101175814.14144-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200101175814.14144-1-amir73il@gmail.com>
References: <20200101175814.14144-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

So far, with xino=auto, we only enable xino if we know that all
underlying filesystem use 32bit inode numbers.

When users configure overlay with xino=auto, they already declare that
they are ready to handle 64bit inode number from overlay.

It is a very common case, that underlying filesystem uses 64bit ino,
but rarely or never uses the high inode number bits (e.g. tmpfs, xfs).
Leaving it for the users to declare high ino bits are unused with
xino=on is not a recipe for many users to enjoy the benefits of xino.

There appears to be very little reason not to enable xino when users
declare xino=auto even if we do not know how many bits underlying
filesystem uses for inode numbers.

In the worst case of xino bits overflow by real inode number, we
already fall back to the non-xino behavior - real inode number with
unique pseudo dev or to non persistent inode number and overlay st_dev
(for directories).

The only annoyance from auto enabling xino is that xino bits overflow
emits a warning to kmsg. Suppress those warnings unless users explicitly
asked for xino=on, suggesting that they expected high ino bits to be
unused by underlying filesystem.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/inode.c     |  8 ++++----
 fs/overlayfs/overlayfs.h | 10 ++++++++++
 fs/overlayfs/readdir.c   | 17 +++++++++++------
 fs/overlayfs/super.c     |  2 +-
 4 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 415d9efa4799..7b94f0338536 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -98,13 +98,13 @@ static int ovl_map_dev_ino(struct dentry *dentry, struct kstat *stat, int fsid)
 		 * and all inodes use overlay st_dev. Inode numbers are also
 		 * persistent for a given layer configuration.
 		 */
-		if (stat->ino >> shift) {
-			pr_warn_ratelimited("overlayfs: inode number too big (%pd2, ino=%llu, xinobits=%d)\n",
-					    dentry, stat->ino, xinobits);
-		} else {
+		if (likely(!(stat->ino >> shift))) {
 			stat->ino |= ((u64)fsid) << shift;
 			stat->dev = dentry->d_sb->s_dev;
 			return 0;
+		} else if (ovl_xino_warn(dentry->d_sb)) {
+			pr_warn_ratelimited("overlayfs: inode number too big (%pd2, ino=%llu, xinobits=%d)\n",
+					    dentry, stat->ino, xinobits);
 		}
 	}
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index c0b15fd2b395..667e8096f56c 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -318,6 +318,16 @@ static inline struct ovl_sb *ovl_dentry_fs(struct dentry *dentry, int fsid)
 	return &OVL_FS(dentry->d_sb)->fs[fsid >> 1];
 }
 
+/*
+ * With xino=auto, we do best effort to keep all inodes on same st_dev and
+ * d_ino consistent with st_ino.
+ * With xino=on, we do the same effort but we warn if we failed.
+ */
+static inline bool ovl_xino_warn(struct super_block *sb)
+{
+	return OVL_FS(sb)->config.xino == OVL_XINO_ON;
+}
+
 /* All layers on same fs? */
 static inline bool ovl_same_fs(struct super_block *sb)
 {
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 0f5ab53b4184..7dbf3df99150 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -438,11 +438,13 @@ static struct ovl_dir_cache *ovl_cache_get(struct dentry *dentry)
 
 /* Map inode number to lower fs unique range */
 static u64 ovl_remap_lower_ino(u64 ino, int xinobits, int fsid,
-			       const char *name, int namelen)
+			       const char *name, int namelen, bool warn)
 {
-	if (ino >> (64 - xinobits)) {
-		pr_warn_ratelimited("overlayfs: d_ino too big (%.*s, ino=%llu, xinobits=%d)\n",
-				    namelen, name, ino, xinobits);
+	if (unlikely(ino >> (64 - xinobits))) {
+		if (warn) {
+			pr_warn_ratelimited("overlayfs: d_ino too big (%.*s, ino=%llu, xinobits=%d)\n",
+					    namelen, name, ino, xinobits);
+		}
 		return ino;
 	}
 
@@ -515,7 +517,8 @@ static int ovl_cache_update_ino(struct path *path, struct ovl_cache_entry *p)
 	} else if (xinobits && !OVL_TYPE_UPPER(type)) {
 		ino = ovl_remap_lower_ino(ino, xinobits,
 					  ovl_dentry_layer(this)->fsid,
-					  p->name, p->len);
+					  p->name, p->len,
+					  ovl_xino_warn(dir->d_sb));
 	}
 
 out:
@@ -645,6 +648,7 @@ struct ovl_readdir_translate {
 	u64 parent_ino;
 	int fsid;
 	int xinobits;
+	bool xinowarn;
 };
 
 static int ovl_fill_real(struct dir_context *ctx, const char *name,
@@ -665,7 +669,7 @@ static int ovl_fill_real(struct dir_context *ctx, const char *name,
 			ino = p->ino;
 	} else if (rdt->xinobits) {
 		ino = ovl_remap_lower_ino(ino, rdt->xinobits, rdt->fsid,
-					  name, namelen);
+					  name, namelen, rdt->xinowarn);
 	}
 
 	return orig_ctx->actor(orig_ctx, name, namelen, offset, ino, d_type);
@@ -695,6 +699,7 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 		.ctx.actor = ovl_fill_real,
 		.orig_ctx = ctx,
 		.xinobits = ovl_xino_bits(dir->d_sb),
+		.xinowarn = ovl_xino_warn(dir->d_sb),
 	};
 
 	if (rdt.xinobits)
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index d636a23df541..ca3204fe87bc 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1407,7 +1407,7 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 			pr_info("overlayfs: \"xino=on\" is useless with all layers on same fs, ignore.\n");
 		ofs->xino_bits = 0;
 		ofs->config.xino = OVL_XINO_SAME_FS;
-	} else if (ofs->config.xino == OVL_XINO_ON && !ofs->xino_bits) {
+	} else if (ofs->config.xino != OVL_XINO_OFF && !ofs->xino_bits) {
 		/*
 		 * This is a roundup of number of bits needed for encoding
 		 * fsid, where fsid 0 is reserved for upper fs (even with
-- 
2.17.1

