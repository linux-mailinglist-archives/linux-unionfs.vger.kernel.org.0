Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A55A7128D31
	for <lists+linux-unionfs@lfdr.de>; Sun, 22 Dec 2019 09:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfLVIIQ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 22 Dec 2019 03:08:16 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39871 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfLVIIQ (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 22 Dec 2019 03:08:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id 20so13135633wmj.4
        for <linux-unionfs@vger.kernel.org>; Sun, 22 Dec 2019 00:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ysn4PyamFCPj1RG+2n7swbrQKJcxexm/bHNQ2Tzw4JY=;
        b=VEqZWqYPte1Eg0GBPk61DGeII4MXRHyo9IwnC06ZLuMpMUVOKXJskMVLrIKHU+mSq9
         n+i9T9Qka/jdxn7Ue9mUwfGzkq8qHqet6EtzPtPk02HZOe/kACts78RKXvUlBjUPJZxD
         XpEptxNz9AAf0rEXXKbPCdSrAWxUi5K/2mRTcy7RjECIHC4dSxzSP19zwCaXO9r8R4YY
         RWUOk7gg6u+BADPTGYbfO/GrQMmNiaMANIdXLyZkf4c4rmmLGWJOouOSOEl1n3Kc1W2D
         jf6UlsrLSbw8HokjH8t8u6HNHZ4mlfKumQZ3qicn9iHK1aGwW7xmfqBQ2YjvR1xR0R30
         fs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ysn4PyamFCPj1RG+2n7swbrQKJcxexm/bHNQ2Tzw4JY=;
        b=qNcaXA1rWvzsNWogJJLJHV3m1oY4/Zez6PkEzVvan5zCwXhlE0R0LrqnlaOVnMS/JW
         eDUw9PyNgkq2sXXpRt2t1M374RJbab2sWOuOfNY88eaYQk/P9mJkGRdmPdM6pWu9uvbz
         sdYqZAc7N43B+pHjQFsATobDBtQMB3vWucLWn2WC0hc/vMLFuMQgrkqTOTxlA/ge9nGt
         PlD308LjV/TMzGy96YaNOGLxExcrVUA2VSqKNVCMtKSXRGM29GChXfe0OZ4r2Lgxo9zX
         AzI+6Lno4wcCo4lpcL6hhoyr0wZeTerYUMrr068wAB5Dak8KukoBFnX5zSDAny+YMhvd
         8CPw==
X-Gm-Message-State: APjAAAW0OnN5OfWRxTqJEg0zFjS2iPYGdY3Df8adVs7zLftr/nmuqB6o
        gXMj1STXn8qamrvP1IbVPjD194qK
X-Google-Smtp-Source: APXvYqxsAF4R++6MZu22WDcI2R8EttU9GYOcMB3daOcOuqdiFBqcoOJ/TyPKb1lTLp4WjOfixaB2Bg==
X-Received: by 2002:a1c:cc11:: with SMTP id h17mr26575321wmb.19.1577002093699;
        Sun, 22 Dec 2019 00:08:13 -0800 (PST)
Received: from localhost.localdomain ([141.226.162.223])
        by smtp.gmail.com with ESMTPSA id g23sm15697141wmk.14.2019.12.22.00.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 00:08:13 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org
Subject: [PATCH v2 4/5] ovl: fix corner case of conflicting lower layer uuid
Date:   Sun, 22 Dec 2019 10:07:58 +0200
Message-Id: <20191222080759.32035-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191222080759.32035-1-amir73il@gmail.com>
References: <20191222080759.32035-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

This fixes ovl_lower_uuid_ok() to correctly detect the corner case:
- two filesystems, A and B, both have null uuid
- upper layer is on A
- lower layer 1 is also on A
- lower layer 2 is on B

In this case, bad_uuid would not have been set for B, because the check
only involved the list of lower fs.  Hence we'll try to decode a layer 2
origin on layer 1 and fail.

We check for conflicting (and null) uuid among all lower layers,
including those layers that are on the same fs as the upper layer.

Reported-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/ovl_entry.h | 2 ++
 fs/overlayfs/super.c     | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 4c1d3b20a4e8..951d0e6a5269 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -24,6 +24,8 @@ struct ovl_sb {
 	dev_t pseudo_dev;
 	/* Unusable (conflicting) uuid */
 	bool bad_uuid;
+	/* Used as a lower layer (but maybe also as upper) */
+	bool is_lower;
 };
 
 struct ovl_layer {
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 8522c66134b5..733dad90606e 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1256,7 +1256,7 @@ static bool ovl_lower_uuid_ok(struct ovl_fs *ofs, const uuid_t *uuid)
 	if (!ofs->config.nfs_export && !ofs->upper_mnt)
 		return true;
 
-	for (i = 1; i < ofs->numfs; i++) {
+	for (i = 0; i < ofs->numfs; i++) {
 		/*
 		 * We use uuid to associate an overlay lower file handle with a
 		 * lower layer, so we can accept lower fs with null uuid as long
@@ -1264,7 +1264,8 @@ static bool ovl_lower_uuid_ok(struct ovl_fs *ofs, const uuid_t *uuid)
 		 * if we detect multiple lower fs with the same uuid, we
 		 * disable lower file handle decoding on all of them.
 		 */
-		if (uuid_equal(&ofs->fs[i].sb->s_uuid, uuid)) {
+		if (ofs->fs[i].is_lower &&
+		    uuid_equal(&ofs->fs[i].sb->s_uuid, uuid)) {
 			ofs->fs[i].bad_uuid = true;
 			return false;
 		}
@@ -1336,10 +1337,12 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 	/*
 	 * All lower layers that share the same fs as upper layer, use the real
 	 * upper st_dev.
+	 * is_lower will be set if upper fs is shared with a lower layer.
 	 */
 	if (ofs->upper_mnt) {
 		ofs->fs[0].sb = ofs->upper_mnt->mnt_sb;
 		ofs->fs[0].pseudo_dev = ofs->upper_mnt->mnt_sb->s_dev;
+		ofs->fs[0].is_lower = false;
 	}
 
 	for (i = 0; i < numlower; i++) {
@@ -1381,6 +1384,7 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 		ofs->layers[ofs->numlower].idx = ofs->numlower;
 		ofs->layers[ofs->numlower].fsid = fsid;
 		ofs->layers[ofs->numlower].fs = &ofs->fs[fsid];
+		ofs->fs[fsid].is_lower = true;
 	}
 
 	/*
-- 
2.17.1

