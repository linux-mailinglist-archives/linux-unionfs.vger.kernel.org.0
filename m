Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88A0BE03D4
	for <lists+linux-unionfs@lfdr.de>; Tue, 22 Oct 2019 14:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387575AbfJVM1X (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 22 Oct 2019 08:27:23 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21142 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387479AbfJVM1X (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 22 Oct 2019 08:27:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571747199; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=ZQya63fb0erza0FoiZtJfdTBxn8t2ipKOIjNTlFDAMmQ9sqODvG71W9ZWMIDKRXf1jpP9SfsqXu4GQGIe2LINpcdOD1a9AUI4Wz0HlpL6Bx6yze2yUXRlegJFNI09Ec2jO8wCnCye3FUMw8qcdOp9fDt1VQah46rQ9CGLPp6jT8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1571747199; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=tSQFdaFIC/Vx+c0BcqNbbCkD9v1+arnQd/AIzDppyTg=; 
        b=Yu1m0UrsrASHo92SqaFNaDU11YKJ67QJh7mFv/+J7o78BSJ/0FguOkjoa6SJ6hrLffFkW4ykCoW9wjfCUnbr6+DzbeKDwWmC7ILpnGtkfVowN6YYZ0zCetp5hFDt2bkZBIX9TzoCo923hYdDCeoSSb2l+z6WEWYy2MVbjY7qAds=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571747199;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=4294; bh=tSQFdaFIC/Vx+c0BcqNbbCkD9v1+arnQd/AIzDppyTg=;
        b=ezXA8/PvNtzR59Es1hifZimesTC7AbDOCqiO5N6xxruY/TsKrJsfwjxorBw84ohQ
        VLdJAYP51LwiMGf20XLceQJP7p7teFz32g6hwSV2iemrZywjal0Se0Wq2wtjPYLbqFp
        OSiWcz71/gmZpkEgGCmEguT9cF5xSBjQnZPr6t/k=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1571747197281762.2415362494289; Tue, 22 Oct 2019 20:26:37 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     fstests@vger.kernel.org, linux-unionfs@vger.kernel.org
Cc:     guaneryu@gmail.com, amir73il@gmail.com, miklos@szeredi.hu,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191022122621.27374-1-cgxu519@mykernel.net>
Subject: [PATCH] overlay/066: copy-up test for variant sparse files
Date:   Tue, 22 Oct 2019 20:26:21 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

This is intensive copy-up test for sparse files,
these cases are mainly used for regression test
of copy-up improvement for sparse files.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 tests/overlay/066     | 108 ++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/066.out |   2 +
 tests/overlay/group   |   1 +
 3 files changed, 111 insertions(+)
 create mode 100755 tests/overlay/066
 create mode 100644 tests/overlay/066.out

diff --git a/tests/overlay/066 b/tests/overlay/066
new file mode 100755
index 00000000..0394b14e
--- /dev/null
+++ b/tests/overlay/066
@@ -0,0 +1,108 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Chengguang Xu <cgxu519@mykernel.net>. All Rights Rese=
rved.
+#
+# FS QA Test 066
+#
+# Test overlayfs copy-up function for variant sparse files.
+#
+seq=3D`basename $0`
+seqres=3D$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=3D`pwd`
+tmp=3D/tmp/$$
+status=3D1=09# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+=09cd /
+=09rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_scratch
+
+# Remove all files from previous tests
+_scratch_mkfs
+_require_fs_space $OVL_BASE_SCRATCH_MNT $((10*1024*13 + 100*1024))
+
+lowerdir=3D$OVL_BASE_SCRATCH_MNT/$OVL_LOWER
+upperdir=3D$OVL_BASE_SCRATCH_MNT/$OVL_UPPER
+testfile=3D"copyup_sparse_test"
+mkdir -p $lowerdir
+
+# Create a completely empty hole file.
+$XFS_IO_PROG -fc "truncate 10M" "${lowerdir}/${testfile}_empty_holefile" >=
>$seqres.full
+
+iosize=3D`stat -c %o "${lowerdir}/${testfile}_empty_holefile"`
+if [ $iosize -le 1024 ]; then
+=09ioszie=3D1
+else
+=09iosize=3D`expr $iosize / 1024`
+fi
+
+# Create test files with different hole size patterns.
+while [ $iosize -le 2048 ]; do
+=09pos=3D$iosize
+=09$XFS_IO_PROG -fc "truncate 10M" "${lowerdir}/${testfile}_iosize${iosize=
}K_holefile" >>$seqres.full
+=09while [ $pos -lt 8192 ]; do
+=09=09$XFS_IO_PROG -fc "pwrite ${pos}K ${iosize}K" "${lowerdir}/${testfile=
}_iosize${iosize}K_holefile" >>$seqres.full
+=09=09pos=3D`expr $pos + $iosize + $iosize`
+=09done
+=09iosize=3D`expr $iosize + $iosize`
+done
+
+# Create test file with many random holes(1M~2M).
+$XFS_IO_PROG -fc "truncate 100M" "${lowerdir}/${testfile}_random_holefile"=
 >>$seqres.full
+pos=3D2048
+while [ $pos -le 81920 ]; do
+=09iosize=3D`expr $RANDOM % 2048`
+=09if [ $iosize -lt 1024 ]; then
+=09=09iosize=3D`expr $iosize + 1024`
+=09fi
+=09$XFS_IO_PROG -fc "pwrite ${pos}K ${iosize}K" "${lowerdir}/${testfile}_r=
andom_holefile" >>$seqres.full
+=09pos=3D`expr $pos + $iosize + $iosize`
+done
+
+_scratch_mount
+
+# Open the files should succeed, no errors are expected.
+for f in $SCRATCH_MNT/*; do
+=09$XFS_IO_PROG -c "open" $f >>$seqres.full
+done
+
+echo "Silence is golden"
+
+# Check all copy-up files in upper layer.
+iosize=3D`stat -c %o "${lowerdir}/${testfile}_empty_holefile"`
+if [ $iosize -le 1024 ]; then
+=09ioszie=3D1
+else
+=09iosize=3D`expr $iosize / 1024`
+fi
+
+while [ $iosize -le 2048 ]; do
+=09diff "${lowerdir}/${testfile}_iosize${iosize}K_holefile" "${upperdir}/$=
{testfile}_iosize${iosize}K_holefile" >>$seqres.full
+=09iosize=3D`expr $iosize + $iosize`
+done
+
+diff "${lowerdir}/${testfile}_empty_holefile"  "${upperdir}/${testfile}_em=
pty_holefile"  >>$seqres.full
+diff "${lowerdir}/${testfile}_random_holefile" "${upperdir}/${testfile}_ra=
ndom_holefile" >>$seqres.full
+
+# success, all done
+status=3D0
+exit
diff --git a/tests/overlay/066.out b/tests/overlay/066.out
new file mode 100644
index 00000000..b60cc24c
--- /dev/null
+++ b/tests/overlay/066.out
@@ -0,0 +1,2 @@
+QA output created by 066
+Silence is golden
diff --git a/tests/overlay/group b/tests/overlay/group
index ef8517a1..1dec7db9 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -68,3 +68,4 @@
 063 auto quick whiteout
 064 auto quick copyup
 065 auto quick mount
+066 auto quick copyup
--=20
2.20.1



