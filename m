Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E82316F86
	for <lists+linux-unionfs@lfdr.de>; Wed, 10 Feb 2021 20:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhBJTEs (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 10 Feb 2021 14:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbhBJTEY (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 10 Feb 2021 14:04:24 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF287C06174A;
        Wed, 10 Feb 2021 11:03:39 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id p20so6087807ejb.6;
        Wed, 10 Feb 2021 11:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C2k4AmnHtUh0OVe9iECxCs78XogrR+lg0yB62QXs+9E=;
        b=kx4B9Ki589BDEBvT/0Cd9YL+L1gc2ftBtjc/8QBxF0/4jUEiH9DXo9VbdP5naG/YVj
         hapoKIvgjXiv9NDuNiX6pygRdpmUBvkwrokRbmVZtt5l4/Obluq+FlEBK9E/3aQZ202d
         PEdH6sgmAkDbA1MBe6Ud9n1UsrZP3FaaDgQSLlS6dBZ1hVpq17V0XpRDx+ypOm2H4JYv
         SEhG559raRoF/c79xSarwiz7uUVFsRoEuOiBNiP7DbeginSH60CIn0uvmU5NR9sq2VkU
         Vqnp33sEhaiK447SXiqi4Pn+QoG1rv7rqOGFf6CGT+kdGpjkDIaiFLm5naBBFIYkLNld
         VosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2k4AmnHtUh0OVe9iECxCs78XogrR+lg0yB62QXs+9E=;
        b=UHypHS1x8H7H6OF1pfuiTW+3yotG9DALrlS4atHX1MyoAZf+8CksO0Xgrc3MhRVihX
         ZvkhABhlh7sbnpihC1uBzXwCYFRwpScT/RBcL41BRm9+Ec/tUSzwS0Sbp5FPa77vpoXM
         RaJ3o8cc1MbV4W9rhvdFNOeQFyjWgGK0DE7kiVfB939X6xZsxQefjCB2tyo7v6lABy6e
         BRyAAMHazMY22yg9bWwaH1gi8M3OiGOwZnqOsxgesfefQkbd7Mcu6NNf76EyKyYO9pd6
         C2b9D0Q/7xHBKBn6qHlWFlhdGfGn/jluXv6US2nO25CW5ceRS/tE8hd1WEbv+W+5v4o0
         yowg==
X-Gm-Message-State: AOAM530sgEwSqA3fR7VxYcyI9f5rIbdQ4+JOxduxXuq+mEbd7IG64wka
        jU3EvWdvznNnGHxPZPRsVeg=
X-Google-Smtp-Source: ABdhPJzdj4MSVefSqkjevM1EVbAUDfpGnSiYCvP7AE7vXXFRBsKLVrimPEeGhI9dccCaDmUPN9CLhw==
X-Received: by 2002:a17:907:20f2:: with SMTP id rh18mr4478312ejb.350.1612983818758;
        Wed, 10 Feb 2021 11:03:38 -0800 (PST)
Received: from localhost.localdomain ([141.226.162.179])
        by smtp.gmail.com with ESMTPSA id m19sm1743617edq.81.2021.02.10.11.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 11:03:38 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Icenowy Zheng <icenowy@aosc.io>,
        Chengguang Xu <cgxu519@mykernel.net>,
        linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH v2 1/5] overlay/030: Update comment w.r.t upstream kernel
Date:   Wed, 10 Feb 2021 21:03:30 +0200
Message-Id: <20210210190334.1212210-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210210190334.1212210-1-amir73il@gmail.com>
References: <20210210190334.1212210-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

commit 61536bed2149 ("ovl: support [S|G]ETFLAGS and FS[S|G]ETXATTR
ioctls for directories") makes the comment in test header inaccurate.
Fix the comment to include this information.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/overlay/030 | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/overlay/030 b/tests/overlay/030
index 3ef206b6..c461e502 100755
--- a/tests/overlay/030
+++ b/tests/overlay/030
@@ -8,8 +8,11 @@
 # and directories in an overlayfs upper directory.
 #
 # This test is similar and was derived from generic/079, but
-# the original test is _notrun on overlay mount because FS_IOC_GETFLAGS
-# FS_IOC_SETFLAGS ioctls fail on overlay directory inodes.
+# the original test is _notrun with FSTYP=overlay on kernel < v5.10
+# because prior to commit 61536bed2149 ("ovl: support [S|G]ETFLAGS
+# and FS[S|G]ETXATTR ioctls for directories"), t_immutable -c would
+# fail to prepare immutable/append-only directories on the overlay
+# mount path.
 #
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
-- 
2.25.1

