Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1EB11291FF
	for <lists+linux-unionfs@lfdr.de>; Mon, 23 Dec 2019 07:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbfLWGke (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 23 Dec 2019 01:40:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32830 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfLWGkd (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 23 Dec 2019 01:40:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id d139so14145169wmd.0
        for <linux-unionfs@vger.kernel.org>; Sun, 22 Dec 2019 22:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TsdDO6Fvx1hNtH4ksJPjWRDU5gBfU7bbW5YrbLh++qM=;
        b=A/pxAl2rJPxPlS35x8+BqVb8kvqKbFIcc8yOA7JO/lk3WdViCwlD91xhPY3HhcGEtu
         +jceT5O2u8NFQ/tGckUbSpvhOOW9YQM18hHRinp/C2N+Tz/1T8b2ai3IOa/G0MB/6vF/
         ehCcUgnB5vrfdBQ3RMPCPiFjC4l0BtF2Ch3PdIugG28tpKBVlmt/43BkHsrRnUpVtiGe
         GQjMlBpmrsslOfzZ0IGOD946TvSxUG6Kl04vNQ5hLyjW62Ppi7TH6m21Lb7HfigcWDB+
         O/H3EC1z5BtH/8dCKlsMI7AyqzrJfCN0Vu2ouFKun9/UWevIoyVJ1+MAgkvO2wPI/Al5
         bCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TsdDO6Fvx1hNtH4ksJPjWRDU5gBfU7bbW5YrbLh++qM=;
        b=X3/iS86AQ3SQKI2uQaLnSbUiO0kb/ZJo5yr4hHCCJee75pt48bAID8TjrnKoY6IZU+
         waYrh6DfFOSACmy6CiGE8Qq34+UCplUbCP/YmFb/560HVOrXgMWQANSsvGlfyJgqloGT
         04VdmS2175anFF/M2vwb2ZC0oKPpOVdiwegOv2eUlaawiY9dphSx1B/N4LdgvaAKjXRj
         4+iVBGRDGVamF/1VU444IO1+KoKKW82D/2eaMP6Qrn3dA4KfqwVV0KREHtQB37gHccVa
         Xi6Vs6w7ksSc4fLCBYgqS3MVS+hM29kYpg/6ovddl8HHNHTJQ/e8Rmgv1U8zO8x4b8mD
         +TXg==
X-Gm-Message-State: APjAAAXamS6HsQKwJs85OMGlLWddl9+5xOf3YrLfXl4OlqG435NPJA8I
        5St4t4SfOsY5QtWZwWn60DWr2/OH
X-Google-Smtp-Source: APXvYqyU4IToQk1Shi7avpWOfQIHKD8spImPSWGRX/GEKw0IKWJkniMA4vbfsQr6XDr7j7RuPDTlVw==
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr24004127wmc.20.1577083231784;
        Sun, 22 Dec 2019 22:40:31 -0800 (PST)
Received: from localhost.localdomain ([141.226.162.223])
        by smtp.gmail.com with ESMTPSA id p17sm19045770wmk.30.2019.12.22.22.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 22:40:31 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org
Subject: [PATCH] ovl: fix wrong WARN_ON() in ovl_cache_update_ino()
Date:   Mon, 23 Dec 2019 08:40:25 +0200
Message-Id: <20191223064025.23801-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

The WARN_ON() that child entry is always on overlay st_dev became wrong
when we allowed this function to update d_ino in non-samefs setup with
xino enabled.

It is not true in case of xino bits overflow on a non-dir inode.
Leave the WARN_ON() only for directories, where assertion is still true.

Fixes: adbf4f7ea834 ("ovl: consistent d_ino for non-samefs with xino")
Cc: <stable@vger.kernel.org> # v4.17+
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Miklos,

Another fall out from testing nested xino setup.

Thanks,
Amir.

 fs/overlayfs/readdir.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 47a91c9733a5..7255e6a5838f 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -504,7 +504,13 @@ static int ovl_cache_update_ino(struct path *path, struct ovl_cache_entry *p)
 		if (err)
 			goto fail;
 
-		WARN_ON_ONCE(dir->d_sb->s_dev != stat.dev);
+		/*
+		 * Directory inode is always on overlay st_dev.
+		 * Non-dir with ovl_same_dev() could be on pseudo st_dev in case
+		 * of xino bits overflow.
+		 */
+		WARN_ON_ONCE(S_ISDIR(stat.mode) &&
+			     dir->d_sb->s_dev != stat.dev);
 		ino = stat.ino;
 	} else if (xinobits && !OVL_TYPE_UPPER(type)) {
 		ino = ovl_remap_lower_ino(ino, xinobits,
-- 
2.17.1

