Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912C1393515
	for <lists+linux-unionfs@lfdr.de>; Thu, 27 May 2021 19:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhE0Rrj (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 27 May 2021 13:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhE0Rrj (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 27 May 2021 13:47:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E772EC061760
        for <linux-unionfs@vger.kernel.org>; Thu, 27 May 2021 10:46:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n4so722593wrw.3
        for <linux-unionfs@vger.kernel.org>; Thu, 27 May 2021 10:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fWNc0/4lXnBigvtF9/tcTyql3KW7unSFtJ4JH3X7KAc=;
        b=qYp8L/8qTNM1xIBdDywYhLemKIFhKzQmst342Sk2wktJFQ9sso6uAW+UKTTrMOWYHh
         h9QBD1yiKos/JfJ3riaBJACFEh0PZAhAEhJUSo7ZBGKa2Sr6dfyx0dr0/cRmwL+BhZvJ
         BRdnLiL9WHuUMucTN3OZtmnuwU38flGsb6S1fhnHcVnnJasNOFIbh52s8/XT7ivoTqBB
         y/+NzcEZ84+EXpDOHZwiKhVhMIhEQgos2xT66kA1gbMRjwtZm7ESlg6JBHWexIXkI9dh
         ne/NybLo3Jp+NQNxR/jXQg2fw+Mvyp8a2ed6fdwUgTSiJPlDbeCcHyTSHM8YuuusFJ+1
         hz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fWNc0/4lXnBigvtF9/tcTyql3KW7unSFtJ4JH3X7KAc=;
        b=KNzmeyaGRqI3oOHAZ5QX8vJ3NB4X9Pk24/+QlGFOPjexA4K4NpvQLl24G7BfGnKifw
         EsYRli283zjdl3Yag3s+lQM6PjLZleHwA3amtm/S5tKb2eQ/lt99ej6QX+4U59JKIlzB
         RVByFfOQ4rbOraYnh1Ue7i0vjy2avk1Vbrrnif5W6EbFWy/rUdzBd0vwBoqv427JH9yJ
         6Vj3maAwa3HXw8tcZ8weFfkuLHwf/xJzt2E6xWwbIEUAUK/bTYK7lKpFCLsDQsD90Pte
         ZRb6uE+Ojm2udBh8ebnqzWxqthMNyinwE71N4WZRQSO+6rhRx2NPZsw4AerbOrS2Q4hW
         nRBA==
X-Gm-Message-State: AOAM531H8uiOspf2bVeRBb/2zSArd7m5Ti7SwSJVYMd3BNZB3nDnsVeG
        jX407cQrcekkb15X0fv9k98=
X-Google-Smtp-Source: ABdhPJzj7trf+XdCJqBoG1ObI0OlDSj/G8M1qJP9+HtjjZuyFa+LN55RvggvVpJcWkNPSZ+13RbiCg==
X-Received: by 2002:adf:ef47:: with SMTP id c7mr4823200wrp.97.1622137564354;
        Thu, 27 May 2021 10:46:04 -0700 (PDT)
Received: from uvv-2004-vm.localdomain (dslb-002-205-242-053.002.205.pools.vodafone-ip.de. [2.205.242.53])
        by smtp.gmail.com with ESMTPSA id f7sm4999837wrg.34.2021.05.27.10.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 10:46:03 -0700 (PDT)
From:   Vyacheslav Yurkov <uvv.mail@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     linux-unionfs@vger.kernel.org,
        Vyacheslav Yurkov <Vyacheslav.Yurkov@bruker.com>
Subject: [PATCH v3 2/3] ovl: add ovl_allow_offline_changes() helper
Date:   Thu, 27 May 2021 19:45:46 +0200
Message-Id: <20210527174547.109269-2-uvv.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527174547.109269-1-uvv.mail@gmail.com>
References: <20210527174547.109269-1-uvv.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

From: Vyacheslav Yurkov <Vyacheslav.Yurkov@bruker.com>

Allows to check whether any of extended features are enabled

Signed-off-by: Vyacheslav Yurkov <Vyacheslav.Yurkov@bruker.com>
---
 fs/overlayfs/overlayfs.h | 12 ++++++++++++
 fs/overlayfs/super.c     |  4 +---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 6ec73db4bf9e..29d71f253db4 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -262,6 +262,18 @@ static inline bool ovl_open_flags_need_copy_up(int flags)
 	return ((OPEN_FMODE(flags) & FMODE_WRITE) || (flags & O_TRUNC));
 }
 
+static inline bool ovl_allow_offline_changes(struct ovl_fs *ofs)
+{
+	/*
+	 * To avoid regressions in existing setups with overlay lower offline
+	 * changes, we allow lower changes only if none of the new features
+	 * are used.
+	 */
+	return (!ofs->config.index && !ofs->config.metacopy &&
+		!ofs->config.redirect_dir && ofs->config.xino != OVL_XINO_ON);
+}
+
+
 /* util.c */
 int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 97ea35fdd933..178daa5e82c9 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1599,9 +1599,7 @@ static bool ovl_lower_uuid_ok(struct ovl_fs *ofs, const uuid_t *uuid)
 	 * user opted-in to one of the new features that require following the
 	 * lower inode of non-dir upper.
 	 */
-	if (!ofs->config.index && !ofs->config.metacopy &&
-	    !ofs->config.redirect_dir && ofs->config.xino != OVL_XINO_ON &&
-	    uuid_is_null(uuid))
+	if (ovl_allow_offline_changes(ofs) && uuid_is_null(uuid))
 		return false;
 
 	for (i = 0; i < ofs->numfs; i++) {
-- 
2.25.1

