Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B60FA2CA2C
	for <lists+linux-unionfs@lfdr.de>; Tue, 28 May 2019 17:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfE1PRg (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 28 May 2019 11:17:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53040 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbfE1PRf (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 28 May 2019 11:17:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id y3so3397723wmm.2;
        Tue, 28 May 2019 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AgFYfL9iguIZiE1nP0hatiHAbHNWsO2s/qiB0KNMhuc=;
        b=nrkdSd/dMUa6S5Yc4AZaFY92y+WN8Ncz5ctWVlk2PRw+wBcYL8NFqgX5zFfk3jsNNN
         89IzxqWgPGQyIziLE+cU1FvGZ+ghyzMA1Dv680I+j+K29RBTZ8R5j5UhrNIdIhXcYMnF
         uyfBT2o2Y+oI48MDIxMfBe+Jby/R8F0CDZNdULBnq/AfUNA+M80GasJo75yvGRPPUHRZ
         hxNBNLliSoaIWV/sq7AvA776xy6nY3rp7VZMUk9mt/XlLtU8x0+agRzlw6VJw3lm6u1J
         VOd3xLUm4on95FEECPE9QUd4OVo/rM2Tsh0SnGS0EZ1qWOqBGS3IXo63JM0CU/KEcFus
         cHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AgFYfL9iguIZiE1nP0hatiHAbHNWsO2s/qiB0KNMhuc=;
        b=SmN5yrdF9rXySbD6CPkSf6NuNFKuAJpWfcwiPMQfh36mX41IQckJT//dmG654FWwcy
         YttvcbTeQWpneQQbqcbEl6/9tFHN3rEShJkhLrh2yiIC2AhVjAqrCH4TFDpY2rbRfHtE
         nmxnxvng802qizMmGS+bbpSx6ury2EpwtmDMsTV5sksSNGNpl2TNzmA4987AtcU7P7YN
         GYNy8lI+fXnnsjcKhm/8231hPQZPWmL3E6r/NeZX2wFE62QdXQqT+uH5orXO2LZI+hzu
         c9Sc+e3azzEumxu0hV6hQaAIvcHLEXXfSJcHPpXfXr6aySNXWU1meDpNpznenclPO2Fv
         WXnw==
X-Gm-Message-State: APjAAAWSF8D0zRWm7VfJc4iLCGymJJt5AUb1y1XzqgKul/97YRj9KYat
        WnF6Hnbmm/78sBaDsjnvl/o=
X-Google-Smtp-Source: APXvYqyluOCHPetznwr36Ep4Eu0VYZXoZ/iPcvEXCI+0o9t/cIbUam3JlkA5TanaAqwU3PghhPC4PA==
X-Received: by 2002:a1c:d182:: with SMTP id i124mr3658637wmg.102.1559056653441;
        Tue, 28 May 2019 08:17:33 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id z65sm5017010wme.37.2019.05.28.08.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 08:17:32 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     zhangyi <yi.zhang@huawei.com>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH v3 2/4] overlay: fix _repair_scratch_fs
Date:   Tue, 28 May 2019 18:17:21 +0300
Message-Id: <20190528151723.12525-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190528151723.12525-1-amir73il@gmail.com>
References: <20190528151723.12525-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

_repair_scratch_fs did not do the right thing for overlay.
Implement and call _repair_overlay_scratch_fs to repair
overlay filesystem and then fall through to repair base filesystem.

The only tests currentrly calling _repair_scratch_fs on a
./check -overlay run are generic/330 generic/332 in case the
base fs supports reflink. The rest of the tests calling
_repair_scratch_fs require that $SCRATCH_DEV is a block device.

Suggested-by: zhangyi (F) <yi.zhang@huawei.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 common/overlay | 17 +++++++++++++++++
 common/rc      | 13 +++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/common/overlay b/common/overlay
index b526f24d..a71c2035 100644
--- a/common/overlay
+++ b/common/overlay
@@ -320,3 +320,20 @@ _check_overlay_scratch_fs()
 		"$OVL_BASE_SCRATCH_DEV" "$OVL_BASE_SCRATCH_MNT" \
 		$OVL_BASE_MOUNT_OPTIONS $SELINUX_MOUNT_OPTIONS
 }
+
+_repair_overlay_scratch_fs()
+{
+	_overlay_fsck_dirs $OVL_BASE_SCRATCH_MNT/$OVL_LOWER \
+		$OVL_BASE_SCRATCH_MNT/$OVL_UPPER \
+		$OVL_BASE_SCRATCH_MNT/$OVL_WORK -y
+	local res=$?
+	case $res in
+	$FSCK_OK|$FSCK_NONDESTRUCT)
+		res=0
+		;;
+	*)
+		_dump_err2 "fsck.overlay failed, err=$res"
+		;;
+	esac
+	return $res
+}
diff --git a/common/rc b/common/rc
index cedc1cfa..d0aa36a0 100644
--- a/common/rc
+++ b/common/rc
@@ -1112,8 +1112,17 @@ _repair_scratch_fs()
 	return $res
         ;;
     *)
-        # Let's hope fsck -y suffices...
-        fsck -t $FSTYP -y $SCRATCH_DEV 2>&1
+	local dev=$SCRATCH_DEV
+	local fstyp=$FSTYP
+	if [ $FSTYP = "overlay" -a -n "$OVL_BASE_SCRATCH_DEV" ]; then
+		_repair_overlay_scratch_fs
+		# Fall through to repair base fs
+		dev=$OVL_BASE_SCRATCH_DEV
+		fstyp=$OVL_BASE_FSTYP
+		$UMOUNT_PROG $OVL_BASE_SCRATCH_MNT
+	fi
+	# Let's hope fsck -y suffices...
+	fsck -t $fstyp -y $dev 2>&1
 	local res=$?
 	case $res in
 	$FSCK_OK|$FSCK_NONDESTRUCT|$FSCK_REBOOT)
-- 
2.17.1

