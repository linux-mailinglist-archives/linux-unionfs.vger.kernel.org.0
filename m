Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E62AE66EBA
	for <lists+linux-unionfs@lfdr.de>; Fri, 12 Jul 2019 14:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfGLMYo (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 12 Jul 2019 08:24:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39680 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfGLMYn (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 12 Jul 2019 08:24:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id z23so4575659wma.4
        for <linux-unionfs@vger.kernel.org>; Fri, 12 Jul 2019 05:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=epEqY61YFiwCb9u7QSmtlCgm4bPnOsSUObJNjbMEqR4=;
        b=Vg2VkZvULBgeGVFTiB+BX6faKgqNSi7pwEDfcY5CPTHk3mvnvNRgr8JDPHyHSjxOnR
         clazxSzCxUKbqBbpymQaIYZsYsBqLZS+91gNlHhdA3svuzFDSbu3D0RETxBgyE4eG+Uz
         ORxDOHENP+b+zQH434LpOTqvBtKMwsQQa9i1rOP4Yvt9GlSxJnUwTb2O00XBRnQHDRcZ
         R28qvyyzWV12PLGdCzr1VZwrfm1FwukFKHQkZNqbPBRUEbEbObnAexLSCB2yysyNXMFV
         /nTuZLRS60RLR/2/Wue0uBSWa4l4i4/7kBSOGy/aMGUMSS8vUlTfFOgANOwGSyoEH+tX
         OVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=epEqY61YFiwCb9u7QSmtlCgm4bPnOsSUObJNjbMEqR4=;
        b=HZgmajWoBnZZqqT7VlaOX6DzYBFXDwPx6EPwivpFeL5/lhSrjpSil5LNsC5JvOeZHo
         BIYbtJGYFdPJQQS50OcCEXZGYcaTGuwH4n87kqu1wkAcg3J1jexxni796hidqKLogmWM
         +haXENZ8R1HN7O9pp/Sihx2XxCHFgr7jOr+3/3X7MBlhX+T37M6V8bWDvAVwToONx8kM
         yPrVgLe4s+hLKMsgVcvXrz7ZIVk1WWmhAubedwDtlq6mK7KBYesRJ6UUYK0PozSRa01R
         nIvS+TyYzlpONAhd7eu08L3o+EKbLD+JKyEl09qgSbLT4MU8eoXTXWIfIgSC5Fb3Z8sL
         mvbA==
X-Gm-Message-State: APjAAAXyhdT2gAtJMQHg7xqOSSSvcbfkEJOT9FhN5nt2LU6UKbsPzoui
        HnSHB86u2+ZiYqfsgfcfvUibngi1
X-Google-Smtp-Source: APXvYqwVOykCUwSr5A1cCMfngmbuG0MAZX6fZ/mk3ajPDomWdjVUKRIIf4HYo6ANfmNGBA+UWpaOWw==
X-Received: by 2002:a1c:b155:: with SMTP id a82mr9313167wmf.35.1562934281214;
        Fri, 12 Jul 2019 05:24:41 -0700 (PDT)
Received: from amir-VirtualBox.ctera.local ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id c12sm13011984wrd.21.2019.07.12.05.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 05:24:40 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-unionfs@vger.kernel.org
Subject: [PATCH] ovl: fix regression caused by overlapping layers detection
Date:   Fri, 12 Jul 2019 15:24:34 +0300
Message-Id: <20190712122434.14809-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Once upon a time, commit 2cac0c00a6cd ("ovl: get exclusive ownership on
upper/work dirs") in v4.13 added some sanity checks on overlayfs layers.
This change caused a docker regression. The root cause was mount leaks
by docker, which as far as I know, still exist.

To mitigate the regression, commit 85fdee1eef1a ("ovl: fix regression
caused by exclusive upper/work dir protection") in v4.14 turned the
mount errors into warnings for the default index=off configuration.

Recently, commit 146d62e5a586 ("ovl: detect overlapping layers") in
v5.2, re-introduced exclusive upper/work dir checks regardless of
index=off configuration.

This changes the status quo and mount leak related bug reports have
started to re-surface. Restore the status quo to fix the regressions.
To clarify, index=off does NOT relax overlapping layers check for this
ovelayfs mount. index=off only relaxes exclusive upper/work dir checks
with another overlayfs mount.

To cover the part of overlapping layers detection that used the
exclusive upper/work dir checks to detect overlap with self upper/work
dir, add a trap also on the work base dir.

Link: https://github.com/moby/moby/issues/34672
Link: https://lore.kernel.org/linux-fsdevel/20171006121405.GA32700@veci.piliscsaba.szeredi.hu/
Link: https://github.com/containers/libpod/issues/3540
Fixes: 146d62e5a586 ("ovl: detect overlapping layers")
Cc: <stable@vger.kernel.org> # v4.19+
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Miklos,

This showed up initially on libpod github and since then also surfaced
in coreos who have merged some band aid fix for their kernel.
I bet docker users will start noticing this soon as well.

I have modified xfstest overlay/065 to accomodate these changes and will
post the patch later.

Thanks,
Amir.

 Documentation/filesystems/overlayfs.txt |  2 +-
 fs/overlayfs/ovl_entry.h                |  1 +
 fs/overlayfs/super.c                    | 73 ++++++++++++++++---------
 3 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.txt b/Documentation/filesystems/overlayfs.txt
index 1da2f1668f08..845d689e0fd7 100644
--- a/Documentation/filesystems/overlayfs.txt
+++ b/Documentation/filesystems/overlayfs.txt
@@ -302,7 +302,7 @@ beneath or above the path of another overlay lower layer path.
 
 Using an upper layer path and/or a workdir path that are already used by
 another overlay mount is not allowed and may fail with EBUSY.  Using
-partially overlapping paths is not allowed but will not fail with EBUSY.
+partially overlapping paths is not allowed and may fail with EBUSY.
 If files are accessed from two overlayfs mounts which share or overlap the
 upper layer and/or workdir path the behavior of the overlay is undefined,
 though it will not result in a crash or deadlock.
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 28a2d12a1029..a8279280e88d 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -66,6 +66,7 @@ struct ovl_fs {
 	bool workdir_locked;
 	/* Traps in ovl inode cache */
 	struct inode *upperdir_trap;
+	struct inode *workbasedir_trap;
 	struct inode *workdir_trap;
 	struct inode *indexdir_trap;
 	/* Inode numbers in all layers do not use the high xino_bits */
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index b368e2e102fa..afbcb116a7f1 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -212,6 +212,7 @@ static void ovl_free_fs(struct ovl_fs *ofs)
 {
 	unsigned i;
 
+	iput(ofs->workbasedir_trap);
 	iput(ofs->indexdir_trap);
 	iput(ofs->workdir_trap);
 	iput(ofs->upperdir_trap);
@@ -1003,6 +1004,25 @@ static int ovl_setup_trap(struct super_block *sb, struct dentry *dir,
 	return 0;
 }
 
+/*
+ * Determine how we treat concurrent use of upperdir/workdir based on the
+ * index feature. This is papering over mount leaks of container runtimes,
+ * for example, an old overlay mount is leaked and now its upperdir is
+ * attempted to be used as a lower layer in a new overlay mount.
+ */
+static int ovl_report_in_use(struct ovl_fs *ofs, const char *name)
+{
+	if (ofs->config.index) {
+		pr_err("overlayfs: %s is in-use as upperdir/workdir of another mount, mount with '-o index=off' to override exclusive upperdir protection.\n",
+		       name);
+		return -EBUSY;
+	} else {
+		pr_warn("overlayfs: %s is in-use as upperdir/workdir of another mount, accessing files from both mounts will result in undefined behavior.\n",
+			name);
+		return 0;
+	}
+}
+
 static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
 			 struct path *upperpath)
 {
@@ -1040,14 +1060,12 @@ static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
 	upper_mnt->mnt_flags &= ~(MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME);
 	ofs->upper_mnt = upper_mnt;
 
-	err = -EBUSY;
 	if (ovl_inuse_trylock(ofs->upper_mnt->mnt_root)) {
 		ofs->upperdir_locked = true;
-	} else if (ofs->config.index) {
-		pr_err("overlayfs: upperdir is in-use by another mount, mount with '-o index=off' to override exclusive upperdir protection.\n");
-		goto out;
 	} else {
-		pr_warn("overlayfs: upperdir is in-use by another mount, accessing files from both mounts will result in undefined behavior.\n");
+		err = ovl_report_in_use(ofs, "upperdir");
+		if (err)
+			goto out;
 	}
 
 	err = 0;
@@ -1157,16 +1175,19 @@ static int ovl_get_workdir(struct super_block *sb, struct ovl_fs *ofs,
 
 	ofs->workbasedir = dget(workpath.dentry);
 
-	err = -EBUSY;
 	if (ovl_inuse_trylock(ofs->workbasedir)) {
 		ofs->workdir_locked = true;
-	} else if (ofs->config.index) {
-		pr_err("overlayfs: workdir is in-use by another mount, mount with '-o index=off' to override exclusive workdir protection.\n");
-		goto out;
 	} else {
-		pr_warn("overlayfs: workdir is in-use by another mount, accessing files from both mounts will result in undefined behavior.\n");
+		err = ovl_report_in_use(ofs, "workdir");
+		if (err)
+			goto out;
 	}
 
+	err = ovl_setup_trap(sb, ofs->workbasedir, &ofs->workbasedir_trap,
+			     "workdir");
+	if (err)
+		goto out;
+
 	err = ovl_make_workdir(sb, ofs, &workpath);
 
 out:
@@ -1313,16 +1334,16 @@ static int ovl_get_lower_layers(struct super_block *sb, struct ovl_fs *ofs,
 		if (err < 0)
 			goto out;
 
-		err = -EBUSY;
-		if (ovl_is_inuse(stack[i].dentry)) {
-			pr_err("overlayfs: lowerdir is in-use as upperdir/workdir\n");
-			goto out;
-		}
-
 		err = ovl_setup_trap(sb, stack[i].dentry, &trap, "lowerdir");
 		if (err)
 			goto out;
 
+		if (ovl_is_inuse(stack[i].dentry)) {
+			err = ovl_report_in_use(ofs, "lowerdir");
+			if (err)
+				goto out;
+		}
+
 		mnt = clone_private_mount(&stack[i]);
 		err = PTR_ERR(mnt);
 		if (IS_ERR(mnt)) {
@@ -1469,8 +1490,8 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
  * - another layer of this overlayfs instance
  * - upper/work dir of any overlayfs instance
  */
-static int ovl_check_layer(struct super_block *sb, struct dentry *dentry,
-			   const char *name)
+static int ovl_check_layer(struct super_block *sb, struct ovl_fs *ofs,
+			   struct dentry *dentry, const char *name)
 {
 	struct dentry *next = dentry, *parent;
 	int err = 0;
@@ -1482,13 +1503,11 @@ static int ovl_check_layer(struct super_block *sb, struct dentry *dentry,
 
 	/* Walk back ancestors to root (inclusive) looking for traps */
 	while (!err && parent != next) {
-		if (ovl_is_inuse(parent)) {
-			err = -EBUSY;
-			pr_err("overlayfs: %s path overlapping in-use upperdir/workdir\n",
-			       name);
-		} else if (ovl_lookup_trap_inode(sb, parent)) {
+		if (ovl_lookup_trap_inode(sb, parent)) {
 			err = -ELOOP;
 			pr_err("overlayfs: overlapping %s path\n", name);
+		} else if (ovl_is_inuse(parent)) {
+			err = ovl_report_in_use(ofs, name);
 		}
 		next = parent;
 		parent = dget_parent(next);
@@ -1509,7 +1528,8 @@ static int ovl_check_overlapping_layers(struct super_block *sb,
 	int i, err;
 
 	if (ofs->upper_mnt) {
-		err = ovl_check_layer(sb, ofs->upper_mnt->mnt_root, "upperdir");
+		err = ovl_check_layer(sb, ofs, ofs->upper_mnt->mnt_root,
+				      "upperdir");
 		if (err)
 			return err;
 
@@ -1520,13 +1540,14 @@ static int ovl_check_overlapping_layers(struct super_block *sb,
 		 * workbasedir.  In that case, we already have their traps in
 		 * inode cache and we will catch that case on lookup.
 		 */
-		err = ovl_check_layer(sb, ofs->workbasedir, "workdir");
+		err = ovl_check_layer(sb, ofs, ofs->workbasedir, "workdir");
 		if (err)
 			return err;
 	}
 
 	for (i = 0; i < ofs->numlower; i++) {
-		err = ovl_check_layer(sb, ofs->lower_layers[i].mnt->mnt_root,
+		err = ovl_check_layer(sb, ofs,
+				      ofs->lower_layers[i].mnt->mnt_root,
 				      "lowerdir");
 		if (err)
 			return err;
-- 
2.17.1

