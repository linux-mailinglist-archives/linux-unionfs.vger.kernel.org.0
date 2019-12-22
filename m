Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9586B128D33
	for <lists+linux-unionfs@lfdr.de>; Sun, 22 Dec 2019 09:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbfLVIIR (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 22 Dec 2019 03:08:17 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:37619 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfLVIIR (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 22 Dec 2019 03:08:17 -0500
Received: by mail-wr1-f47.google.com with SMTP id w15so836809wru.4
        for <linux-unionfs@vger.kernel.org>; Sun, 22 Dec 2019 00:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZUMPWVl2HgYN9npf6+6nmLXoCdKSnA8HHHkFR3I+3Wk=;
        b=YZhHYe5XD+7LF0I6hrQl3Xbh+pzbf/+NAK0ZR6QMlY6gfv1TRYpyv8Ei8JJfa8rGus
         fIr/LQgHtZbReow5B0EwNSMO1YCJgKQZZsFosvvNjD9WvJ3fxu8hE+4uCPNiH6KnVDd4
         E+hpFXskh6m0XwkikEO7jRY23ptb+x6GLUzA/nzj3/EIg9QQ29vqJ13Mcn7X2pOYRT21
         QbftuGCGv0AgpkGEixL/iTNaLqIbR4DI8y9P43ALZtdRkwm86Z1drzFuY4b0auBVvf8X
         gFWDMVPqoaTAM27chJpsNRF6lUL+xhEOyxd3h+KvAxpy0E/O4fqm8SA+7WvbWEHMe3Vp
         75Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZUMPWVl2HgYN9npf6+6nmLXoCdKSnA8HHHkFR3I+3Wk=;
        b=B0QQXqhEUBgho3KzpNFN4WEe52gsqsldm4dKTdbIAWxgv0E5RkhUQJgzKKLEDaMiHb
         ZA53SOqSHqakl3moX4q6FQpCIf0qa6RwYtMy9NHYbSfaNIohGdAGlFB9R7tNfOJgv74S
         7bRikCrrJJ8168OaOvJIaYbXetLhPaxobvozwp/tdGeFeogTmVn7JV1HJufg/ivrrBXi
         PstTlTR2ab3++1XscVq1Cx4fxDDMN079PHcQwmybTd+7Erjn/vO6cJtgsdKR24vJ3ING
         5yq7hP9A16Zd6Yias3Vc0yOBcnQzVovdNatB1Eanq7iB+xAnY1zMQS4kiNQCq3HVNtK9
         hvwA==
X-Gm-Message-State: APjAAAWP+HbMd6Pa33wPBVkGuPhnpmGs+xzOaAQII4CcV2w4NoYDg2Lk
        7rXrFnx2blAy3etZtIHsZFY=
X-Google-Smtp-Source: APXvYqzn+gRDQwBDsoVL07z7jehsdlS7BY2BfCd2Hw2/x/8AFxbNL6NyBM8AFsBEcA35bhEAaXy+hA==
X-Received: by 2002:a5d:494b:: with SMTP id r11mr24279344wrs.184.1577002094736;
        Sun, 22 Dec 2019 00:08:14 -0800 (PST)
Received: from localhost.localdomain ([141.226.162.223])
        by smtp.gmail.com with ESMTPSA id g23sm15697141wmk.14.2019.12.22.00.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 00:08:14 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org
Subject: [PATCH v2 5/5] ovl: fix corner case of non-constant st_dev;st_ino
Date:   Sun, 22 Dec 2019 10:07:59 +0200
Message-Id: <20191222080759.32035-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191222080759.32035-1-amir73il@gmail.com>
References: <20191222080759.32035-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On non-samefs overlay without xino, non pure upper inodes should use a
pseudo_dev assigned to each unique lower fs, but if lower layer is on
the same fs and upper layer, it has no pseudo_dev assigned.

In this overlay layers setup:
- two filesystems, A and B
- upper layer is on A
- lower layer 1 is also on A
- lower layer 2 is on B

Non pure upper overlay inode, whose origin is in layer 1 will have the
st_dev;st_ino values of the real lower inode before copy up and the
st_dev;st_ino values of the real upper inode after copy up.

Fix this inconsitency by assigning a unique pseudo_dev also for upper fs,
that will be used as st_dev value along with the lower inode st_dev for
overlay inodes in the case above.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/inode.c | 14 +++-----------
 fs/overlayfs/super.c | 15 ++++++++++-----
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 09153dbe8090..3afae2e2d0ea 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -125,9 +125,8 @@ static int ovl_map_dev_ino(struct dentry *dentry, struct kstat *stat, int fsid)
 		/*
 		 * For non-samefs setup, if we cannot map all layers st_ino
 		 * to a unified address space, we need to make sure that st_dev
-		 * is unique per lower fs. Layers that are on the same fs as
-		 * upper layer use real upper st_dev and other lower layers use
-		 * the unique anonymous bdev assigned to the lower fs.
+		 * is unique per underlying fs, so we use the unique anonymous
+		 * bdev assigned to the underlying fs.
 		 */
 		stat->dev = OVL_FS(dentry->d_sb)->fs[fsid].pseudo_dev;
 	}
@@ -143,7 +142,6 @@ int ovl_getattr(const struct path *path, struct kstat *stat,
 	struct path realpath;
 	const struct cred *old_cred;
 	bool is_dir = S_ISDIR(dentry->d_inode->i_mode);
-	bool samefs = ovl_same_fs(dentry->d_sb);
 	int fsid;
 	int err;
 	bool metacopy_blocks = false;
@@ -196,13 +194,7 @@ int ovl_getattr(const struct path *path, struct kstat *stat,
 			if (ovl_test_flag(OVL_INDEX, d_inode(dentry)) ||
 			    (!ovl_verify_lower(dentry->d_sb) &&
 			     (is_dir || lowerstat.nlink == 1))) {
-				/*
-				 * Cannot use origin st_dev;st_ino because
-				 * origin inode content may differ from overlay
-				 * inode content.
-				 */
-				if (samefs || fsid)
-					stat->ino = lowerstat.ino;
+				stat->ino = lowerstat.ino;
 			} else {
 				fsid = 0;
 			}
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 733dad90606e..2afa60ab9133 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -230,8 +230,7 @@ static void ovl_free_fs(struct ovl_fs *ofs)
 	}
 	kfree(ofs->layers);
 	if (ofs->fs) {
-		/* fs[0].pseudo_dev is either null or real upper st_dev */
-		for (i = 1; i < ofs->numfs; i++)
+		for (i = 0; i < ofs->numfs; i++)
 			free_anon_bdev(ofs->fs[i].pseudo_dev);
 		kfree(ofs->fs);
 	}
@@ -1335,13 +1334,19 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 	ofs->layers[0].fsid = 0;
 
 	/*
-	 * All lower layers that share the same fs as upper layer, use the real
-	 * upper st_dev.
+	 * All lower layers that share the same fs as upper layer, use the same
+	 * pseudo_dev as upper layer.  Allocate fs[0].pseudo_dev even for lower
+	 * only overlay to simplify ovl_fs_free().
 	 * is_lower will be set if upper fs is shared with a lower layer.
 	 */
+	err = get_anon_bdev(&ofs->fs[0].pseudo_dev);
+	if (err) {
+		pr_err("overlayfs: failed to get anonymous bdev for upper fs\n");
+		goto out;
+	}
+
 	if (ofs->upper_mnt) {
 		ofs->fs[0].sb = ofs->upper_mnt->mnt_sb;
-		ofs->fs[0].pseudo_dev = ofs->upper_mnt->mnt_sb->s_dev;
 		ofs->fs[0].is_lower = false;
 	}
 
-- 
2.17.1

