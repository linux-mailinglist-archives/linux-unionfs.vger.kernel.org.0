Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEF10FCFAA
	for <lists+linux-unionfs@lfdr.de>; Thu, 14 Nov 2019 21:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfKNU2v (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 14 Nov 2019 15:28:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36000 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfKNU2v (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 14 Nov 2019 15:28:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id c22so7654820wmd.1
        for <linux-unionfs@vger.kernel.org>; Thu, 14 Nov 2019 12:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GuhQ/eIJU2qCLP+5GlYbtFrxs77uOUfsnQN8yRCoz74=;
        b=qTH3YfpE8pHzfygxmhXqzNVJU1RHgk2pktpUraiiwe3K/2nuDl59Uatkdrf9DMyAex
         lk/wkl21kwK7ZGm8fofLXBOYDaG+y1Zs2EsRgdMlQ+TfwHVR+eWZFuj8r/pY6IVXFFGt
         yyurCEycFZYMH9pzA3bPEJ+GYDvJToisSqoox9VC8U+zpCcJB996CRlmrLMRFxTZ57Jf
         ZCm5pz1LYLTtSTe0p98AcUIBawg78h67VOwThCjerMHPwOAF1Bjtxaf2ALdn3CxN981x
         tbqPj47rSUP18zkcZFO8lB4JaPN3m2kP003PBj5bshD9AX8Rwr6Ad7qC58Bq7uk3qsVL
         qKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GuhQ/eIJU2qCLP+5GlYbtFrxs77uOUfsnQN8yRCoz74=;
        b=e5vGHPcux6hDULxjLmwhZwgZ7DDUdHwu4dxsslu1YBm8TRKIBPnm9ywEG9XrwAysph
         mqOMaRZQH+3V9u+1nBSRKVJ8TnHhywXUcF4M+JIIlm982feIGsTRUBJh+SVYRmqQ/bau
         XrQxZWTVyEKig8jV/7mUSHHrCMuENJitTViN0ad1slWyEseRXJUpRNFeCbUrY+zNclny
         sL+QHMoO4iXh2xKLLz9Cskd7v6YiEdl/cFUsjCwEAHvHmHrw9vK6U6bHL7shu41dCyTa
         I49ptt6M9EpZm9fGFULB4vivDda+MFJvfzYMeyK35ocdKXUN/sQnTU4Z8S9LINtPGi70
         iDIQ==
X-Gm-Message-State: APjAAAXnOd0ma1zyVoeynBSfqDpY1Y0D4hDqjwzRZ2eDep/eFNN2wfMW
        TrEV5XoL8dCQV4neMTXXE7Q=
X-Google-Smtp-Source: APXvYqz0U9uu6Rjya5DfgxcZiYWtAifMekPVHppVU1nPGsB4aI5IxQH2weZ/01TuIBsZUE1BU2085Q==
X-Received: by 2002:a05:600c:22d1:: with SMTP id 17mr10768389wmg.31.1573763328442;
        Thu, 14 Nov 2019 12:28:48 -0800 (PST)
Received: from localhost.localdomain ([94.230.83.228])
        by smtp.gmail.com with ESMTPSA id o189sm8356756wmo.23.2019.11.14.12.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 12:28:47 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Colin Ian King <colin.king@canonical.com>,
        linux-unionfs@vger.kernel.org
Subject: [PATCH v5] ovl: fix lookup failure on multi lower squashfs
Date:   Thu, 14 Nov 2019 22:28:41 +0200
Message-Id: <20191114202841.6502-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

In the past, overlayfs required that lower fs have non null uuid in
order to support nfs export and decode copy up origin file handles.

Commit 9df085f3c9a2 ("ovl: relax requirement for non null uuid of
lower fs") relaxed this requirement for nfs export support, as long
as uuid (even if null) is unique among all lower fs.

However, said commit unintentionally also relaxed the non null uuid
requirement for decoding copy up origin file handles, regardless of
the unique uuid requirement.

Amend this mistake by disabling decoding of copy up origin file handle
from lower fs with a conflicting uuid.

We still encode copy up origin file handles from those fs, because
file handles like those already exist in the wild and because they
might provide useful information in the future.

There is an unhandled corner case described by Miklos this way:
- two filesystems, A and B, both have null uuid
- upper layer is on A
- lower layer 1 is also on A
- lower layer 2 is on B

In this case bad_uuid won't be set for B, because the check only
involves the list of lower fs.  Hence we'll try to decode a layer 2
origin on layer 1 and fail.

We will deal with this corner case later.

Reported-by: Colin Ian King <colin.king@canonical.com>
Tested-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/lkml/20191106234301.283006-1-colin.king@canonical.com/
Fixes: 9df085f3c9a2 ("ovl: relax requirement for non null uuid ...")
Cc: stable@vger.kernel.org # v4.20+
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Changes since v4:
- Go back to "falling back to index=off,nfs_export=off" warning
- Mention remaining corner case in commit message

 fs/overlayfs/namei.c     |  8 ++++++++
 fs/overlayfs/ovl_entry.h |  2 ++
 fs/overlayfs/super.c     | 24 +++++++++++++++++-------
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index e9717c2f7d45..f47c591402d7 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -325,6 +325,14 @@ int ovl_check_origin_fh(struct ovl_fs *ofs, struct ovl_fh *fh, bool connected,
 	int i;
 
 	for (i = 0; i < ofs->numlower; i++) {
+		/*
+		 * If lower fs uuid is not unique among lower fs we cannot match
+		 * fh->uuid to layer.
+		 */
+		if (ofs->lower_layers[i].fsid &&
+		    ofs->lower_layers[i].fs->bad_uuid)
+			continue;
+
 		origin = ovl_decode_real_fh(fh, ofs->lower_layers[i].mnt,
 					    connected);
 		if (origin)
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index a8279280e88d..28348c44ea5b 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -22,6 +22,8 @@ struct ovl_config {
 struct ovl_sb {
 	struct super_block *sb;
 	dev_t pseudo_dev;
+	/* Unusable (conflicting) uuid */
+	bool bad_uuid;
 };
 
 struct ovl_layer {
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 4a6b7870ba8e..cfb236e37fd9 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1255,7 +1255,7 @@ static bool ovl_lower_uuid_ok(struct ovl_fs *ofs, const uuid_t *uuid)
 {
 	unsigned int i;
 
-	if (!ofs->config.nfs_export && !(ofs->config.index && ofs->upper_mnt))
+	if (!ofs->config.nfs_export && !ofs->upper_mnt)
 		return true;
 
 	for (i = 0; i < ofs->numlowerfs; i++) {
@@ -1263,9 +1263,13 @@ static bool ovl_lower_uuid_ok(struct ovl_fs *ofs, const uuid_t *uuid)
 		 * We use uuid to associate an overlay lower file handle with a
 		 * lower layer, so we can accept lower fs with null uuid as long
 		 * as all lower layers with null uuid are on the same fs.
+		 * if we detect multiple lower fs with the same uuid, we
+		 * disable lower file handle decoding on all of them.
 		 */
-		if (uuid_equal(&ofs->lower_fs[i].sb->s_uuid, uuid))
+		if (uuid_equal(&ofs->lower_fs[i].sb->s_uuid, uuid)) {
+			ofs->lower_fs[i].bad_uuid = true;
 			return false;
+		}
 	}
 	return true;
 }
@@ -1277,6 +1281,7 @@ static int ovl_get_fsid(struct ovl_fs *ofs, const struct path *path)
 	unsigned int i;
 	dev_t dev;
 	int err;
+	bool bad_uuid = false;
 
 	/* fsid 0 is reserved for upper fs even with non upper overlay */
 	if (ofs->upper_mnt && ofs->upper_mnt->mnt_sb == sb)
@@ -1288,11 +1293,15 @@ static int ovl_get_fsid(struct ovl_fs *ofs, const struct path *path)
 	}
 
 	if (!ovl_lower_uuid_ok(ofs, &sb->s_uuid)) {
-		ofs->config.index = false;
-		ofs->config.nfs_export = false;
-		pr_warn("overlayfs: %s uuid detected in lower fs '%pd2', falling back to index=off,nfs_export=off.\n",
-			uuid_is_null(&sb->s_uuid) ? "null" : "conflicting",
-			path->dentry);
+		bad_uuid = true;
+		if (ofs->config.index || ofs->config.nfs_export) {
+			ofs->config.index = false;
+			ofs->config.nfs_export = false;
+			pr_warn("overlayfs: %s uuid detected in lower fs '%pd2', falling back to index=off,nfs_export=off.\n",
+				uuid_is_null(&sb->s_uuid) ? "null" :
+							    "conflicting",
+				path->dentry);
+		}
 	}
 
 	err = get_anon_bdev(&dev);
@@ -1303,6 +1312,7 @@ static int ovl_get_fsid(struct ovl_fs *ofs, const struct path *path)
 
 	ofs->lower_fs[ofs->numlowerfs].sb = sb;
 	ofs->lower_fs[ofs->numlowerfs].pseudo_dev = dev;
+	ofs->lower_fs[ofs->numlowerfs].bad_uuid = bad_uuid;
 	ofs->numlowerfs++;
 
 	return ofs->numlowerfs;
-- 
2.17.1

