Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E42677F10
	for <lists+linux-unionfs@lfdr.de>; Sun, 28 Jul 2019 12:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfG1KVg (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 28 Jul 2019 06:21:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34805 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfG1KVg (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 28 Jul 2019 06:21:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so40943357wmd.1;
        Sun, 28 Jul 2019 03:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AM5xoqG592mlWQqIb35SMW+8Fi9TD+x/hYozXH6NBqs=;
        b=Xc2HF+zwigCMFKtM+VUv1DP59AlwiffK7MTkobnfNslv9pLiJAw2coJ9FFOyMUBYqj
         C46uayS0QiOVURUlejeBNn4r8bNYPXgD9/Q4qo98LW9ui92Yt6F5SVFyPgg3Pbnp38hf
         Gco0kjWhb2e1rnQK6wDTI0qJQFyQNEdde0KcO7VKkNY3HVQ8/0j70sG0Je/DC9gT9f/h
         y2AlmuWTca1iMUg7GFh4LQ0QUHUI4tgzJO5YxvLkRotfpTQz1cQ2q4XbRW/H/B0cFz8U
         SdUijxUX0T2A165FFSxrLTJZijS0dtlbM4tk6u7u9uSzcy4dIz2kKRX85TJY8iLgE2ji
         Y3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AM5xoqG592mlWQqIb35SMW+8Fi9TD+x/hYozXH6NBqs=;
        b=mn1YUZEaGzmKWZ6OJGiwDHRNFyHaNHOnYgP49P9lEUYFHGbDBIEgPh4Ct0a2qPY/x5
         BRHCudBj2S0GGNrxXH0boE4sZiJpJN+SO7dwvzMUpzXogn1kMe9w6X0Iy0fQ3vP+DZCn
         XqOJ1RKLIUehMVZKwfoDHL/kMX1vutMWDS51rVVVTLdmKXU4+93Sw97HMNlleCR3xpIi
         qwXzHIACOLCjHZ2yNf+WJQCIaNt7HefxG6Zmkkdnfl0yYO0MHuV/dtBxp6+GvTTIvjoz
         g3cWeQByFbFVVECU8M6rNuAtCIz+0Jc1IQZaO+BNBHvpDGIXHfamvPoKVNiTl8xBfTbZ
         v0rg==
X-Gm-Message-State: APjAAAVI1Vr3PgzUpGy8rD0yKLnUG69/2lVmnuv5zOQoxKWkRLcoSUnI
        uXHYBWXMn+KSgbqS0zLdTQCQ7nNx
X-Google-Smtp-Source: APXvYqz5MnrXup6FD9kZFwE7wsDbw21Z9Bwj3caPdG5wzUhn5dl2RGtXKOjFqK1pngkBetRczjvsBg==
X-Received: by 2002:a1c:2dd1:: with SMTP id t200mr1222363wmt.1.1564309294058;
        Sun, 28 Jul 2019 03:21:34 -0700 (PDT)
Received: from amir-VirtualBox.ctera.local ([37.26.148.169])
        by smtp.gmail.com with ESMTPSA id o6sm117755059wra.27.2019.07.28.03.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 03:21:33 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>, linux-unionfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: [PATCH v2] overlay/065: adjust test to expect EBUSY only with index=on
Date:   Sun, 28 Jul 2019 13:21:24 +0300
Message-Id: <20190728102124.1265-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

This is needed to support the kernel regression fix commit 0be0bfd2de9d
("ovl: fix regression caused by overlapping layers detection").

Overlayfs mount is not supposed to fail due to upper/work dir in-use
by other mount unless option index=on is enabled.

Add test variants for index=on and index=off.

Fix some wrong comments and clean noise lines in golden output.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Eryu,

I piggy backed two minor cleanups in this update on top of your requested
change.

Thanks,
Amir.

Changes since v1:
- Add test variants with index=on/off
- Fix wring comment about expect EEXIST
- Make golden output deterministic by changing 'find $mnt2'
  to find '$mnt2/upper'

 tests/overlay/065     | 56 +++++++++++++++++++++++++++++--------------
 tests/overlay/065.out | 12 +++++-----
 2 files changed, 44 insertions(+), 24 deletions(-)

diff --git a/tests/overlay/065 b/tests/overlay/065
index abfc6737..f41a6982 100755
--- a/tests/overlay/065
+++ b/tests/overlay/065
@@ -13,9 +13,14 @@
 #
 # Overlapping layers on mount or lookup results in ELOOP.
 # Overlapping lowerdir with other mount upperdir/workdir
-# result in EBUSY.
+# result in EBUSY (only if index=on is used).
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
@@ -91,7 +97,7 @@ $UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
 rm -rf $upperdir $workdir
 mkdir $upperdir $workdir
 
-# Try to mount an overlay with the same lower layers - expect EEXIST
+# Try to mount an overlay with the same lower layers - expect ELOOP
 echo Conflicting lower layers
 _overlay_scratch_mount_dirs $lowerdir:$lowerdir $upperdir $workdir \
 	2>&1 | _filter_error_mount
@@ -118,36 +124,50 @@ $UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
 rm -rf $upperdir $workdir
 mkdir -p $upperdir/upper $workdir $mnt2
 
-# Mount overlay with non overlapping lowerdir, upperdir, workdir - expect
-# success
+# Mount overlay with non overlapping lowerdir, upperdir, workdir -
+# expect success
 _overlay_mount_dirs $lowerdir $upperdir $workdir overlay $mnt2
 
 rm -rf $upperdir2 $workdir2
 mkdir -p $upperdir2 $workdir2 $mnt2
 
 # Try to mount an overlay with layers overlapping with another overlayfs
-# upperdir - expect EBUSY
-echo Overlapping with upperdir of another instance
+# upperdir - expect EBUSY with index=on and success with index=off
+echo "Overlapping with upperdir of another instance (index=on)"
 _overlay_scratch_mount_dirs $upperdir/upper $upperdir2 $workdir2 \
-	2>&1 | _filter_busy_mount
+	-oindex=on 2>&1 | _filter_busy_mount
 $UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
 
 rm -rf $upperdir2 $workdir2
 mkdir -p $upperdir2 $workdir2
 
+echo "Overlapping with upperdir of another instance (index=off)"
+_overlay_scratch_mount_dirs $upperdir/upper $upperdir2 $workdir2 \
+	-oindex=off && $UMOUNT_PROG $SCRATCH_MNT
+
+rm -rf $upperdir2 $workdir2
+mkdir -p $upperdir2 $workdir2
+
 # Try to mount an overlay with layers overlapping with another overlayfs
-# workdir - expect EBUSY
-echo Overlapping with workdir of another instance
+# workdir - expect EBUSY with index=on and success with index=off
+echo "Overlapping with workdir of another instance (index=on)"
 _overlay_scratch_mount_dirs $workdir/work $upperdir2 $workdir2 \
-	2>&1 | _filter_busy_mount
+	-oindex=on 2>&1 | _filter_busy_mount
 $UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
 
+rm -rf $upperdir2 $workdir2
+mkdir -p $upperdir2 $workdir2
+
+echo "Overlapping with workdir of another instance (index=off)"
+_overlay_scratch_mount_dirs $workdir/work $upperdir2 $workdir2 \
+	-oindex=off && $UMOUNT_PROG $SCRATCH_MNT
+
 # Move upper layer root into lower layer after mount
 echo Overlapping upperdir/lowerdir after mount
 mv $upperdir $lowerdir/
-# Lookup files in overlay mount with overlapping layers - expect ELOOP
-# when overlay merge dir is found
-find $mnt2 2>&1 | _filter_scratch
+# Lookup files in overlay mount with overlapping layers -
+# expect ELOOP when upper layer root is found in lower layer
+find $mnt2/upper 2>&1 | _filter_scratch
 
 # success, all done
 status=0
diff --git a/tests/overlay/065.out b/tests/overlay/065.out
index 0260327c..3639ceb5 100644
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
@@ -11,11 +11,11 @@ Overlapping lower layers below
 mount: Too many levels of symbolic links
 Overlapping lower layers above
 mount: Too many levels of symbolic links
-Overlapping with upperdir of another instance
+Overlapping with upperdir of another instance (index=on)
 mount: device already mounted or mount point busy
-Overlapping with workdir of another instance
+Overlapping with upperdir of another instance (index=off)
+Overlapping with workdir of another instance (index=on)
 mount: device already mounted or mount point busy
+Overlapping with workdir of another instance (index=off)
 Overlapping upperdir/lowerdir after mount
-SCRATCH_DEV/mnt.2
-SCRATCH_DEV/mnt.2/lower
 find: 'SCRATCH_DEV/mnt.2/upper': Too many levels of symbolic links
-- 
2.17.1

