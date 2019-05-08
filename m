Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 959A716FD3
	for <lists+linux-unionfs@lfdr.de>; Wed,  8 May 2019 06:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbfEHELX (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 8 May 2019 00:11:23 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:50817 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbfEHELX (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 8 May 2019 00:11:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TR9VU.X_1557288679;
Received: from localhost(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0TR9VU.X_1557288679)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 May 2019 12:11:19 +0800
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
To:     fstests@vger.kernel.org
Cc:     darrick.wong@oracle.com, linux-unionfs@vger.kernel.org,
        amir73il@gmail.com, guaneryu@gmail.com, joseph.qi@linux.alibaba.com
Subject: [PATCH v2] generic: add a testcase to check the capability CAP_LINUX_IMMUTABLE
Date:   Wed,  8 May 2019 12:11:19 +0800
Message-Id: <20190508041119.25145-1-jiufei.xue@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

It should return error while changing IMMUTABLE_FL flag if the process
has no capability CAP_LINUX_IMMUTABLE.

However, it's not true on overlayfs after kernel version v4.19 since
the process's subjective cred is overridden with ofs->creator_cred
before calling real vfs_ioctl.

The following patch for ovl fix the problem:
  "ovl: check the capability before cred overridden"

Add this testcase to cover this bug.

v2: add testcases to check APPEND_FL and clear these flags. Suggested by
Amir Goldstein.

Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
---
 common/config         |  1 +
 tests/generic/545     | 74 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/545.out | 10 ++++++
 tests/generic/group   |  1 +
 4 files changed, 86 insertions(+)
 create mode 100755 tests/generic/545
 create mode 100755 tests/generic/545.out

diff --git a/common/config b/common/config
index 64f87057..364432bb 100644
--- a/common/config
+++ b/common/config
@@ -196,6 +196,7 @@ export SQLITE3_PROG="$(type -P sqlite3)"
 export TIMEOUT_PROG="$(type -P timeout)"
 export SETCAP_PROG="$(type -P setcap)"
 export GETCAP_PROG="$(type -P getcap)"
+export CAPSH_PROG="$(type -P capsh)"
 export CHECKBASHISMS_PROG="$(type -P checkbashisms)"
 export XFS_INFO_PROG="$(type -P xfs_info)"
 export DUPEREMOVE_PROG="$(type -P duperemove)"
diff --git a/tests/generic/545 b/tests/generic/545
new file mode 100755
index 00000000..a7c142e2
--- /dev/null
+++ b/tests/generic/545
@@ -0,0 +1,74 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Alibaba Group.  All Rights Reserved.
+#
+# FS QA Test No. 545
+#
+# Check that we can't set the FS_APPEND_FL and FS_IMMUTABLE_FL inode
+# flags without capbility CAP_LINUX_IMMUTABLE
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
+    cd /
+    rm -rf $tmp.* $testdir
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/attr
+
+# real QA test starts here
+_supported_os Linux
+_require_chattr i
+_require_chattr a
+_require_command "$CAPSH_PROG" "capsh"
+
+rm -f $seqres.full
+
+echo "Format and mount"
+testdir="$TEST_DIR/test-$seq"
+rm -rf $testdir
+mkdir $testdir
+
+echo "Create the original files"
+touch $testdir/file1
+touch $testdir/file2
+
+do_filter_output()
+{
+    err_str=`_filter_test_dir | grep "Operation not permitted"`
+    test -n "$err_str" && echo "Operation not permitted"
+}
+
+echo "Try to chattr +ia with capabilities CAP_LINUX_IMMUTABLE"
+$CHATTR_PROG +a $testdir/file1 2>&1
+$CHATTR_PROG +i $testdir/file1 2>&1
+
+echo "Try to chattr +ia/-ia without capability CAP_LINUX_IMMUTABLE"
+$CAPSH_PROG --drop=cap_linux_immutable -- -c "$CHATTR_PROG +a $testdir/file2" 2>&1 | do_filter_output
+$CAPSH_PROG --drop=cap_linux_immutable -- -c "$CHATTR_PROG +i $testdir/file2" 2>&1 | do_filter_output
+
+$CAPSH_PROG --drop=cap_linux_immutable -- -c "$CHATTR_PROG -i $testdir/file1" 2>&1 | do_filter_output
+$CAPSH_PROG --drop=cap_linux_immutable -- -c "$CHATTR_PROG -a $testdir/file1" 2>&1 | do_filter_output
+
+echo "Try to chattr -ia with capability CAP_LINUX_IMMUTABLE"
+$CHATTR_PROG -i $testdir/file1 2>&1
+$CHATTR_PROG -a $testdir/file1 2>&1
+
+# in case chattr +ia succeed without capability
+$CHATTR_PROG -i $testdir/file2 2>&1
+$CHATTR_PROG -a $testdir/file2 2>&1
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/545.out b/tests/generic/545.out
new file mode 100755
index 00000000..8c6e4082
--- /dev/null
+++ b/tests/generic/545.out
@@ -0,0 +1,10 @@
+QA output created by 545
+Format and mount
+Create the original files
+Try to chattr +ia with capabilities CAP_LINUX_IMMUTABLE
+Try to chattr +ia/-ia without capability CAP_LINUX_IMMUTABLE
+Operation not permitted
+Operation not permitted
+Operation not permitted
+Operation not permitted
+Try to chattr -ia with capability CAP_LINUX_IMMUTABLE
diff --git a/tests/generic/group b/tests/generic/group
index 40deb4d0..7a457e81 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -547,3 +547,4 @@
 542 auto quick clone
 543 auto quick clone
 544 auto quick clone
+545 auto quick cap
-- 
2.19.1.856.g8858448bb

