Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B54F7FFA8F
	for <lists+linux-unionfs@lfdr.de>; Sun, 17 Nov 2019 16:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfKQPoG (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 17 Nov 2019 10:44:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38292 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfKQPoG (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 17 Nov 2019 10:44:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so16548071wro.5
        for <linux-unionfs@vger.kernel.org>; Sun, 17 Nov 2019 07:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LHIJziy+TNYO5ubVZnIoXGbjE0m77U4aqvZkwnamp1k=;
        b=hM1SBi65/BCpvvMMxbnPhYcr4lap2OjRmMDZPYM1UiAbzre+gXWqQFdafx4ovcphkg
         OPFXq1oEVDiPw+amBUCp8XmCYz8RpuM2p55bLX+eYL0Ygp+mxbiSAsFArGRkRrUt4TDU
         9oGv422kNZhNP0SXkSZiCyDRxRpRHqA2fUmUQfX/nLEsnsixAglySXglRseI5rADHpKM
         gSrEGdaQjgT/dfBMFQZFLGC7bZcpBN4as2iZ49Ru/RPaOldF3Vbvvtje9giD3kstihFu
         k/WxtQltI9kudW0vFRxO5hnyYwAEa5US+Ah3CVwogFUp6doZg1TeqNhgvv/yVtyboGyi
         BjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LHIJziy+TNYO5ubVZnIoXGbjE0m77U4aqvZkwnamp1k=;
        b=jtWOOJ8IjAvnPA9Jjsaba4j9YBrUSX6naCnF2kthtMWaJ3VnKNfNqarxhRTZq6vaNQ
         NiyFYnXN5/2l3UHHbBYlf+g5X5S+bHiH4stIODqcBE+CUYW6l1eWybVHWiBGOULvVGQ6
         e/FTZWMoU/85rHSkGoeShHAQxOMW/i/Q0K32xBlwVidyNVgpeyMxdfYq7IcO7OQe/WSd
         g1+nt2fUl9+uJBg+kHvt12ftqqaRDjluv0j/0gXvGx8kKCeL9u+3PkanXY1dywsFf7QS
         U+ftD2R/yeQxJkY6bbD1zmmPn0HLlj8VC9dGNH+BhdvYy3REM/CFXqPGwtUQPKVE/TLk
         xCMQ==
X-Gm-Message-State: APjAAAUyKoWF5G6QZ8bubiDWQ2E1eiRbW+pRx5f9R0n2LcNxlfn+Ua1j
        wjkfY2dDVo6mjQKYd2p3uWw=
X-Google-Smtp-Source: APXvYqwgcOUz/pH40unGMgBFlvCvzDnkZI303vIYeMkz4/yORVnAJ2mF2g5qia3F0ktJKenZGHLx4g==
X-Received: by 2002:a5d:67c2:: with SMTP id n2mr25259083wrw.222.1574005444117;
        Sun, 17 Nov 2019 07:44:04 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id z8sm19061613wrp.49.2019.11.17.07.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 07:44:03 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Colin Ian King <colin.king@canonical.com>,
        linux-unionfs@vger.kernel.org
Subject: [PATCH 5/6] ovl: fix corner case of conflicting lower layer uuid
Date:   Sun, 17 Nov 2019 17:43:48 +0200
Message-Id: <20191117154349.28695-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191117154349.28695-1-amir73il@gmail.com>
References: <20191117154349.28695-1-amir73il@gmail.com>
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
index 93e9fd5fba9d..6c04b6a4e6bf 100644
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
index 09e53780d9bc..e80f79bb8a4e 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1256,7 +1256,7 @@ static bool ovl_lower_uuid_ok(struct ovl_fs *ofs, const uuid_t *uuid)
 	if (!ofs->config.nfs_export && !ofs->upper_mnt)
 		return true;
 
-	for (i = 1; i <= ofs->maxfsid; i++) {
+	for (i = 0; i <= ofs->maxfsid; i++) {
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

