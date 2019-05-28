Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D46CF2CA2A
	for <lists+linux-unionfs@lfdr.de>; Tue, 28 May 2019 17:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfE1PRd (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 28 May 2019 11:17:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33663 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfE1PRd (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 28 May 2019 11:17:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id d9so20689109wrx.0;
        Tue, 28 May 2019 08:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D2tiTFln/if3GrLE8MLMPVx2reMyc0yTmj93edCCdaY=;
        b=FFdXFRA2xxNNzhGAFQtq/vPXXSDotclvP/U6tkeJ3QiT8SislSK0qq6jvWx5ek1hid
         o4xi5xf9EjtbD94T/u/gr/XELUA18K0JXvboh/AWma3JiRUbW0cWBt/rcnoBSAelkqj9
         SWJ8zUR8wbUZwXP4VWV+RHC5Ff+WiVMqKZYN4iXYras5dFrH43cLC97lLL6rVFObx+HC
         1Gynb7Vtt28mXZ4UmrloAl3wHkJD+bO8JrppnAyeqOcyQ/L7pHnt3qnRBKNK4g/BjIA+
         4KvV798h46Jj5qTgikqqudFkyW8Ve9l3Xvfmfp9+KKEJD2paM6FwqG2CnjMU2w2008lP
         ahoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D2tiTFln/if3GrLE8MLMPVx2reMyc0yTmj93edCCdaY=;
        b=hZqRVgZMKrdM8NDzOX6uuR8iJVZGE1n1uMxenoSL+jmm+HDUD3t/vJlqxzfcdoRO1+
         yGffrkil4UQBnh/9I6j5VTnD4z95SCG0AIj0ukqaOKaQ+g9fy0ReiNnkRg3DHbD1NTAc
         MTJu88u7tzS9J09oqwY+zazR9MB0QYG6sQZhoLsfbYz6NbHMhcJ/ZTtf1dszerkR1LgE
         LnqPBkqi5mmIKLn/jQxW9F9zbo76S1mNTA2m8Lj//N5kKGW0bhvpWzL3iiCj8sYWd8nR
         c3MDvcYr4K8r0tTaGICIuXGQ4sJ33t5xLP7wuf/mAHW6MZ+QKLP7eKKDqo20+/w36K6M
         RpQw==
X-Gm-Message-State: APjAAAW0cQfJjJYBM4v2AGQ2MhuTa79dflDNtpjNPglzRhEdmJvncB1u
        EQMdDLxd8oyP9W2a+vCl6umxbW+I
X-Google-Smtp-Source: APXvYqzfErGiBzi/PiL9uCsQjDzUB+k2U80Irh7x4LAFoSgST9MjZziT+htATg9tPkiKoaxdbtBCHg==
X-Received: by 2002:adf:e404:: with SMTP id g4mr39160723wrm.161.1559056651907;
        Tue, 28 May 2019 08:17:31 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id z65sm5017010wme.37.2019.05.28.08.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 08:17:31 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     zhangyi <yi.zhang@huawei.com>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH v3 1/4] fstests: define constants for fsck exit codes
Date:   Tue, 28 May 2019 18:17:20 +0300
Message-Id: <20190528151723.12525-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190528151723.12525-1-amir73il@gmail.com>
References: <20190528151723.12525-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Define the constants for hard coded values used in _repair_scratch_fs()
to check fsck exit code.

Suggested-by: zhangyi (F) <yi.zhang@huawei.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 common/config | 11 +++++++++++
 common/rc     |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/common/config b/common/config
index 364432bb..bd64be62 100644
--- a/common/config
+++ b/common/config
@@ -69,6 +69,17 @@ export OVL_WORK="ovl-work"
 # overlay mount point parent must be the base fs root
 export OVL_MNT="ovl-mnt"
 
+# From e2fsprogs/e2fsck/e2fsck.h:
+# Exit code used by fsck-type programs
+export FSCK_OK=0
+export FSCK_NONDESTRUCT=1
+export FSCK_REBOOT=2
+export FSCK_UNCORRECTED=4
+export FSCK_ERROR=8
+export FSCK_USAGE=16
+export FSCK_CANCELED=32
+export FSCK_LIBRARY=128
+
 export PWD=`pwd`
 #export DEBUG=${DEBUG:=...} # arbitrary CFLAGS really.
 export MALLOCLIB=${MALLOCLIB:=/usr/lib/libefence.a}
diff --git a/common/rc b/common/rc
index e78e0920..cedc1cfa 100644
--- a/common/rc
+++ b/common/rc
@@ -1116,7 +1116,7 @@ _repair_scratch_fs()
         fsck -t $FSTYP -y $SCRATCH_DEV 2>&1
 	local res=$?
 	case $res in
-	0|1|2)
+	$FSCK_OK|$FSCK_NONDESTRUCT|$FSCK_REBOOT)
 		res=0
 		;;
 	*)
-- 
2.17.1

