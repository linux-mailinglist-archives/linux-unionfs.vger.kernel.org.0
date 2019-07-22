Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F47E6F8AB
	for <lists+linux-unionfs@lfdr.de>; Mon, 22 Jul 2019 07:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfGVFCg (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 22 Jul 2019 01:02:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35664 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfGVFCg (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 22 Jul 2019 01:02:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so33896717wmg.0;
        Sun, 21 Jul 2019 22:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OxIEwsisU2GX7C0xYZAcnnok/PiBZauC/idx9Unda/c=;
        b=BZnp7ccrFiSkaGczXBbqwxXF/TTW//N/MlKrz5DrrkNIwbV79RD/fyrxfLmX7Ycc+b
         3g/nUOmK4ByqnRG6+Iijh+7XOoQ/M3MHOn32zDi4AFHt0aSUWo+lF7GXeOu4VLQR5+TQ
         NLgeY/6H+isJUFwxUKsQ09u1mQA8QG84nCHhCMv57DI8vjHtJ+H8i/MIxvxkm5xn+hXx
         G74YnIpwUGWY26ErQzDUgF9xdW8YqnZCe6T6nHaTw5sZ0rcWR7czGrjHP0K5MGyFg+EY
         jGs8Df2CrT5xJYDzEMqqVvGNaprtOUgbNkqf6TwjOO82VWZZ4wpZxE2Kg1MlPyK/z3PI
         G1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OxIEwsisU2GX7C0xYZAcnnok/PiBZauC/idx9Unda/c=;
        b=t8k4wjxMLLAtiAPZsVzRWWl2iANvqHs1O+xeIwb3Ev7nssLwzmdoSTIGiGgWi4Bfs4
         Eeu+ljQOc16QLpdgp3DZao6T2/j2wlelMUZuUANH0bChhzRPqHPItmnXCKsqp6pZ85/G
         YW7F/kbhccmkx8VMFXvF1vP8/KFEmp+lqZ0jojcW9E5ctsU+HItSbGfm7Pjzb2KWc4kJ
         uQjXm60J4FpJC8ub9Trg4QuFQm927xuGU94STs/fhhxdWqEdPe8C2jfyLvJGjefdw0au
         8MaFqXkYb+If+oCa0+zdW2s8WXhib+jmthUfRSUfFrPEbWDuDwVtj8RJ2xmKFKl9iFhe
         oR7g==
X-Gm-Message-State: APjAAAVajvRoD0v58Mi2wajoKjBOnum7/Ml+Kwziv9qE72WPo81PxntE
        FMrZgh+mYnwcFTPpo/C3p2Aqytkt
X-Google-Smtp-Source: APXvYqzVZIyvG/ng9FRJBUpCWwQgL0GyyeCEAFXH7eWiRoO32aLPNa5NrboyS8COiXrzvxugdmxTEg==
X-Received: by 2002:a1c:f418:: with SMTP id z24mr12488605wma.80.1563771753996;
        Sun, 21 Jul 2019 22:02:33 -0700 (PDT)
Received: from amir-VirtualBox.ctera.local ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id z5sm27043186wmf.48.2019.07.21.22.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jul 2019 22:02:33 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>, linux-unionfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: [PATCH] overlay/065: adjust test to expect EBUSY only with index=on
Date:   Mon, 22 Jul 2019 08:02:27 +0300
Message-Id: <20190722050227.24944-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

This is needed to support the kernel regression fix commit 0be0bfd2de9d
("ovl: fix regression caused by overlapping layers detection").

Overlayfs mount is not supposed to fail due to upper/work dir in-use
by other mount unless option index=on is enabled.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Eryu,

With this applied, test is expected to fail on upstream kernel,
because upstream kernel has a regression.

The kernel fix commit is on Miklos' overlayfs-next branch.

Thanks,
Amir.

 tests/overlay/065     | 26 ++++++++++++++++----------
 tests/overlay/065.out |  4 ++--
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/tests/overlay/065 b/tests/overlay/065
index abfc6737..a75a9a10 100755
--- a/tests/overlay/065
+++ b/tests/overlay/065
@@ -13,9 +13,14 @@
 #
 # Overlapping layers on mount or lookup results in ELOOP.
 # Overlapping lowerdir with other mount upperdir/workdir
-# result in EBUSY.
+# result in EBUSY (if index=on is used).
 #
-# Kernel patch "ovl: detect overlapping layers" is needed to pass the test.
+# This is a regression test for kernel commit:
+#
+#    146d62e5a586 "ovl: detect overlapping layers"
+#
+# and its followup fix commit:
+#    0be0bfd2de9d "ovl: fix regression caused by overlapping layers detection"
 #
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
@@ -46,6 +51,7 @@ _supported_os Linux
 # Use non-default scratch underlying overlay dirs, we need to check
 # them explicity after test.
 _require_scratch_nocheck
+_require_scratch_feature index
 
 # Remove all files from previous tests
 _scratch_mkfs
@@ -61,10 +67,10 @@ mnt2=$basedir/mnt.2
 
 mkdir -p $lowerdir/lower $upperdir $workdir
 
-# Try to mount an overlay with the same upperdir/lowerdir - expect EBUSY
+# Try to mount an overlay with the same upperdir/lowerdir - expect ELOOP
 echo Conflicting upperdir/lowerdir
 _overlay_scratch_mount_dirs $upperdir $upperdir $workdir \
-	2>&1 | _filter_busy_mount
+	2>&1 | _filter_error_mount
 $UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
 
 # Use new upper/work dirs for each test to avoid ESTALE errors
@@ -72,11 +78,11 @@ $UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
 rm -rf $upperdir $workdir
 mkdir $upperdir $workdir
 
-# Try to mount an overlay with the same workdir/lowerdir - expect EBUSY
+# Try to mount an overlay with the same workdir/lowerdir - expect ELOOP
 # because $workdir/work overlaps with lowerdir
 echo Conflicting workdir/lowerdir
 _overlay_scratch_mount_dirs $workdir $upperdir $workdir \
-	2>&1 | _filter_busy_mount
+	-oindex=off 2>&1 | _filter_error_mount
 $UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
 
 rm -rf $upperdir $workdir
@@ -126,20 +132,20 @@ rm -rf $upperdir2 $workdir2
 mkdir -p $upperdir2 $workdir2 $mnt2
 
 # Try to mount an overlay with layers overlapping with another overlayfs
-# upperdir - expect EBUSY
+# upperdir - expect EBUSY with index=on
 echo Overlapping with upperdir of another instance
 _overlay_scratch_mount_dirs $upperdir/upper $upperdir2 $workdir2 \
-	2>&1 | _filter_busy_mount
+	-oindex=on 2>&1 | _filter_busy_mount
 $UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
 
 rm -rf $upperdir2 $workdir2
 mkdir -p $upperdir2 $workdir2
 
 # Try to mount an overlay with layers overlapping with another overlayfs
-# workdir - expect EBUSY
+# workdir - expect EBUSY with index=on
 echo Overlapping with workdir of another instance
 _overlay_scratch_mount_dirs $workdir/work $upperdir2 $workdir2 \
-	2>&1 | _filter_busy_mount
+	-oindex=on 2>&1 | _filter_busy_mount
 $UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
 
 # Move upper layer root into lower layer after mount
diff --git a/tests/overlay/065.out b/tests/overlay/065.out
index 0260327c..c63d4df8 100644
--- a/tests/overlay/065.out
+++ b/tests/overlay/065.out
@@ -1,8 +1,8 @@
 QA output created by 065
 Conflicting upperdir/lowerdir
-mount: device already mounted or mount point busy
+mount: Too many levels of symbolic links
 Conflicting workdir/lowerdir
-mount: device already mounted or mount point busy
+mount: Too many levels of symbolic links
 Overlapping upperdir/lowerdir
 mount: Too many levels of symbolic links
 Conflicting lower layers
-- 
2.17.1

