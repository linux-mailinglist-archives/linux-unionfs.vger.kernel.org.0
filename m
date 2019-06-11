Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9C2A3D1CB
	for <lists+linux-unionfs@lfdr.de>; Tue, 11 Jun 2019 18:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391884AbfFKQIv (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 11 Jun 2019 12:08:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54323 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391878AbfFKQIv (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 11 Jun 2019 12:08:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id g135so3574737wme.4;
        Tue, 11 Jun 2019 09:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ki6HzX+YKjMEcrusZ5tv0RltwNZY1Y8Nd9PWQp/oxvQ=;
        b=IVrkk2cM41oEx0eBa0Sra7ZvhoJL1eINYmL6gT4FJqI1OTe7Q2suF9DIhiylFKtMHI
         yxzqWptNqvCqd0qK6V5+CIsNPoRJGcGDhHBeSyYqZS/BSuq9sEXKBYoaqgYtriobkyAh
         bW/3KY6BKDRAjjtUP5DHfkVICXcm4thjznvaCu2o3RRACAA2KcFQrdRw4PQtDZf4umtl
         0fbpQ1swCZLRkCUzAYEAhNBfgCI0WD+X00apprfHdf+TypNz+Kodvs8pzfnNSJGYU0Vl
         yEVGtaNv1wijmupEkTKfEqDi9xj3jlrEhTpOkweFnu/aC3Y01BXXSImP0H0IugMR4kNO
         A7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ki6HzX+YKjMEcrusZ5tv0RltwNZY1Y8Nd9PWQp/oxvQ=;
        b=BUSbl9gtyzTchJmbR/daLecxfXW0tvtKa6BhGnnDF4jnyU6B08XiHDQW4Ybm2IGGeV
         b3aJXL6S54yVscBS915Z+KTFgBFjAM4Ob4NLwn+xeqOvsQgh0tUo48vr26seRg5IW8WJ
         8OfsXB/FjWGC2akEhWdMLnptWSHEDkKyGlI0EJiNq56V7enYpK2qk++M0TStgATujk62
         I6dHpOO/w/5Om/fTpr5jQblpdr3sy5Ehd9DNdvW++U3z96n/OsCmCb8OaYuExnzoMb1I
         +Vw2gxAyJZ3hAi1e7kwAQrFuGe9LqlmvXM/6pq9ysGFr7LVSdcNgUzrlHTPBktLPp+yr
         +nuw==
X-Gm-Message-State: APjAAAUPIT259f7z4oW0Kf/Phnht2ITRcSiAJHTh+UCKPnfu3VKLOv7D
        9kxJVpG4hgz2Mr9YEoouma0=
X-Google-Smtp-Source: APXvYqwJIjMAIfL9jy9PjEFI3ZHfj8JzKr1DU5yNKz3ljPT8ChR81N+8z9PZPnHc3Ss2c+d+RzvB3w==
X-Received: by 2002:a1c:a7ca:: with SMTP id q193mr19838278wme.150.1560269329490;
        Tue, 11 Jun 2019 09:08:49 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id u11sm10942873wrn.1.2019.06.11.09.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 09:08:48 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH 3/3] generic: check CAP_LINUX_IMMUTABLE capability with FS_IOC_FSSETXATTR
Date:   Tue, 11 Jun 2019 19:08:39 +0300
Message-Id: <20190611160839.14777-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190611160839.14777-1-amir73il@gmail.com>
References: <20190611160839.14777-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

This is a flavor of test generic/545 with FS_IOC_FSSETXATTR ioctl
instead of FS_IOC_SETFLAGS ioctl.

Overlayfs gained support for FS_IOC_FSSETXATTR ioctl in v5.2-rc4
with buggy capability check. This change fixed the problem:

  ovl: fix wrong flags check in FS_IOC_FS[SG]ETXATTR ioctls

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/generic/555     | 74 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/555.out |  9 ++++++
 tests/generic/group   |  1 +
 3 files changed, 84 insertions(+)
 create mode 100755 tests/generic/555
 create mode 100644 tests/generic/555.out

diff --git a/tests/generic/555 b/tests/generic/555
new file mode 100755
index 00000000..e100da97
--- /dev/null
+++ b/tests/generic/555
@@ -0,0 +1,74 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 CTERA Networks. All Rights Reserved.
+#
+# FS QA Test No. 555
+#
+# Check that we can't set FS_XFLAG_APPEND and FS_XFLAG_IMMUTABLE inode
+# flags without capbility CAP_LINUX_IMMUTABLE.
+#
+# This test uses xfs_io chattr, rather than the (e2fsprogs) chattr
+# program to exercise the FS_IOC_FSSETXATTR ioctl.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	# Cleanup of flags on both file in case test is aborted
+	# (i.e. CTRL-C), so we have no immutable/append-only files
+	$XFS_IO_PROG -f -r -c "chattr -ia" $workdir/file1 >/dev/null 2>&1
+	$XFS_IO_PROG -f -r -c "chattr -ia" $workdir/file2 >/dev/null 2>&1
+
+	cd /
+	rm -rf $tmp.* $workdir
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/attr
+
+# real QA test starts here
+_supported_os Linux
+_supported_fs generic
+
+_require_test
+_require_xfs_io_command "chattr" "ia"
+_require_command "$CAPSH_PROG" "capsh"
+
+workdir="$TEST_DIR/test-$seq"
+rm -rf $workdir
+mkdir $workdir
+
+echo "Create the original files"
+touch $workdir/file1
+touch $workdir/file2
+
+do_filter_output()
+{
+	grep -o "Operation not permitted"
+}
+
+echo "Try to xfs_io chattr +ia with capabilities CAP_LINUX_IMMUTABLE"
+$XFS_IO_PROG -f -c "chattr +ia" $workdir/file1
+
+echo "Try to xfs_io chattr +ia/-ia without capability CAP_LINUX_IMMUTABLE"
+$CAPSH_PROG --drop=cap_linux_immutable -- -c "$XFS_IO_PROG -f -c 'chattr +a' $workdir/file2" 2>&1 | do_filter_output
+$CAPSH_PROG --drop=cap_linux_immutable -- -c "$XFS_IO_PROG -f -c 'chattr +i' $workdir/file2" 2>&1 | do_filter_output
+
+$CAPSH_PROG --drop=cap_linux_immutable -- -c "$XFS_IO_PROG -f -r -c 'chattr -i' $workdir/file1" 2>&1 | do_filter_output
+$CAPSH_PROG --drop=cap_linux_immutable -- -c "$XFS_IO_PROG -f -r -c 'chattr -a' $workdir/file1" 2>&1 | do_filter_output
+
+echo "Try to xfs_io chattr -ia with capability CAP_LINUX_IMMUTABLE"
+$XFS_IO_PROG -f -r -c "chattr -ia" $workdir/file1
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/555.out b/tests/generic/555.out
new file mode 100644
index 00000000..c4f989d1
--- /dev/null
+++ b/tests/generic/555.out
@@ -0,0 +1,9 @@
+QA output created by 555
+Create the original files
+Try to xfs_io chattr +ia with capabilities CAP_LINUX_IMMUTABLE
+Try to xfs_io chattr +ia/-ia without capability CAP_LINUX_IMMUTABLE
+Operation not permitted
+Operation not permitted
+Operation not permitted
+Operation not permitted
+Try to xfs_io chattr -ia with capability CAP_LINUX_IMMUTABLE
diff --git a/tests/generic/group b/tests/generic/group
index 44ce8eff..8262b09c 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -557,3 +557,4 @@
 552 auto quick log
 553 auto quick copy_range
 554 auto quick copy_range swap
+555 auto quick cap
-- 
2.17.1

