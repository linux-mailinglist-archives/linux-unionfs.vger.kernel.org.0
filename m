Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDC312D088
	for <lists+linux-unionfs@lfdr.de>; Mon, 30 Dec 2019 15:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfL3OOg (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 30 Dec 2019 09:14:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36638 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfL3OOg (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 30 Dec 2019 09:14:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so14263843wma.1;
        Mon, 30 Dec 2019 06:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GEb0yxKoNJZGLX/qXtAVpxhdRJoeLzeoz2pO/c3+lto=;
        b=IHmozsdBvmY6t9AuxlUX9Rvfr544ZDOrPRoZ9nFCIertYq0xZMr6luS6SpC11gAlUY
         CnFHXFNYqZmd9mskQUkM+fpawiteuIyQ0IIoBKvQvoe4rgMAjykLVMalPdbeYhotsefP
         CQR+Bp8lUUZdJHZSskEFmA/q0e/QONMW3rlMiisDL7/fT8H/2v+z6N83xvcuzncxE//N
         lj64P77rRKPnZp8Wx99ccCX6x2QzDTWMWkO6VXQfoSoKOHW8Gw6zCG5xmn+rVGu8E3t7
         18BHyuFRvgAX0iT0QHHUH+B/KBgNFdbmun94XHV4Hh54PKQN6GrDHluDX+9pLFIRnFUZ
         4NyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GEb0yxKoNJZGLX/qXtAVpxhdRJoeLzeoz2pO/c3+lto=;
        b=G66JUi2I16IvaDXajJ1Y5l0rkdUHlwAaLglpMolDEC6tqSt14Io44RFtvSVpAe+jmT
         2pRimsHiM/uIwSMTmSS2LWTePaiGjy3hsN4pixpWEyGiHpsVV8UA6X6GNIcZybNselBT
         F4L+GOD2ykbXDZelPyx1qlikB7wRgFM1ueRXJop8EDOJshYL0icue9dzBJu76jqmyZsU
         NKWT+q2ZHLiaeFnAhS8fyXsLYLFQifB3/KU1RETHy6AkFbYQCeXo2u3+2/zNHmenGowm
         YrbWzGFRnyMPs0kxZOPS0xexCDsUWBzTA2QOJmZBQs+FidOh5Mz1osJkJO+kduUwMC7H
         XqbQ==
X-Gm-Message-State: APjAAAUg38OMvomFYbuzGCl0r773eVoCJ8MqMkPAtF/lE9549HoXCK/2
        TC9Ng0lu0o20FbEeZty+AF4=
X-Google-Smtp-Source: APXvYqz+c76rQrZmf6aTIkrqAJ3b4JnKipbmYBp3ZIETc8FwOzEX2kEbZ56GVFWvxY8EIMQ4XF4+ww==
X-Received: by 2002:a1c:7715:: with SMTP id t21mr34325448wmi.149.1577715272790;
        Mon, 30 Dec 2019 06:14:32 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id t8sm44532651wrp.69.2019.12.30.06.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 06:14:32 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Jeff Layton <jlayton@poochiereds.net>,
        linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH v2 2/5] overlay: test file handles with nested overlay over samefs lower
Date:   Mon, 30 Dec 2019 16:14:20 +0200
Message-Id: <20191230141423.31695-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230141423.31695-1-amir73il@gmail.com>
References: <20191230141423.31695-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

This is a variant of overlay file handles test for an overlayfs that
is nested over another lower overlayfs on the same fs.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/overlay/068     | 304 ++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/068.out |  50 +++++++
 tests/overlay/group   |   1 +
 3 files changed, 355 insertions(+)
 create mode 100755 tests/overlay/068
 create mode 100644 tests/overlay/068.out

diff --git a/tests/overlay/068 b/tests/overlay/068
new file mode 100755
index 00000000..2b533f22
--- /dev/null
+++ b/tests/overlay/068
@@ -0,0 +1,304 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 CTERA Networks. All Rights Reserved.
+#
+# FS QA Test No. 068
+#
+# Test encode/decode of nested overlay file handles
+#
+# This is a variant of overlay file handles test for an overlayfs that is
+# nested over another lower overlayfs on the same fs.
+#
+# - Check encode/write/decode/read content of lower/upper file handles
+# - Check encode/decode/write/read content of lower/upper file handles
+# - Check decode/read of unlinked lower/upper files and directories
+# - Check decode/read of lower file handles after copy up, link and unlink
+# - Check decode/read of lower file handles after rename of parent and self
+#
+# This test does not cover connectable file handles of non-directories,
+# because name_to_handle_at() syscall does not support requesting connectable
+# file handles.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	# Unmount the nested overlay mount
+	$UMOUNT_PROG $mnt2 2>/dev/null
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+
+_supported_fs overlay
+_supported_os Linux
+_require_scratch
+# _require_exportfs already requires open_by_handle, but let's not count on it
+_require_test_program "open_by_handle"
+# We need to require all features together, because nfs_export cannot
+# be enabled when index is disabled
+_require_scratch_overlay_features index nfs_export redirect_dir
+
+# Lower dir of nested overlay is the scratch overlay mount at SCRATCH_MNT
+upper2=$OVL_BASE_SCRATCH_MNT/$OVL_UPPER.2
+work2=$OVL_BASE_SCRATCH_MNT/$OVL_WORK.2
+mnt2=$OVL_BASE_SCRATCH_MNT/$OVL_MNT.2
+
+lowerdir=$OVL_BASE_SCRATCH_MNT/$OVL_LOWER/lowertestdir
+upperdir=$OVL_BASE_SCRATCH_MNT/$OVL_UPPER/uppertestdir
+lowertestdir=$mnt2/lowertestdir
+uppertestdir=$mnt2/uppertestdir
+NUMFILES=1
+
+# Create test dir and empty test files
+create_test_files()
+{
+	local dir=$1
+	local opt=$2
+
+	src/open_by_handle -cp $opt $dir $NUMFILES
+}
+
+# Test encode/decode file handles on overlay mount
+test_file_handles()
+{
+	local dir=$1
+	shift
+
+	echo test_file_handles $dir $* | _filter_scratch | _filter_ovl_dirs | \
+				sed -e "s,$tmp\.,,g"
+	$here/src/open_by_handle $* $dir $NUMFILES
+}
+
+# Re-create lower/upper/work dirs
+create_dirs()
+{
+	# Create the underlying overlay dirs
+	_scratch_mkfs
+
+	# Create the nested overlay upper dirs
+	mkdir -p $upper2 $work2 $mnt2
+}
+
+# Mount a nested overlay with $SCRATCH_MNT as lower layer
+mount_dirs()
+{
+	# Mount the underlying overlay
+	_scratch_mount -o "index=on,nfs_export=on,redirect_dir=on"
+
+	# Mount the nested overlay
+	_overlay_mount_dirs $SCRATCH_MNT $upper2 $work2 overlay2 $mnt2 \
+		-o "index=on,nfs_export=on,redirect_dir=on" 2>/dev/null ||
+		_notrun "cannot mount nested overlay with nfs_export=on option"
+	_fs_options overlay2 | grep -q "nfs_export=on" || \
+		_notrun "cannot enable nfs_export feature on nested overlay"
+}
+
+# Unmount the nested overlay mount and check underlying overlay layers
+unmount_dirs()
+{
+	# unmount & check nested overlay
+	$UMOUNT_PROG $mnt2
+	_overlay_check_dirs $SCRATCH_MNT $upper2 $work2 \
+		-o "index=on,nfs_export=on,redirect_dir=on"
+
+	# unmount & check underlying overlay
+	_scratch_unmount
+	_check_scratch_fs
+}
+
+# Check non-stale file handles of lower/upper files and verify
+# that handle decoded before copy up is encoded to upper after
+# copy up. Verify reading data from file open by file handle
+# and verify access_at() with dirfd open by file handle.
+create_dirs
+create_test_files $upperdir
+create_test_files $lowerdir
+mount_dirs
+# Check encode/decode of upper regular file handles
+test_file_handles $uppertestdir
+# Check encode/decode of upper dir file handle
+test_file_handles $uppertestdir -p
+# Check encode/write/decode/read/write of upper file handles
+test_file_handles $uppertestdir -wrap
+# Check encode/decode of lower regular file handles before copy up
+test_file_handles $lowertestdir
+# Check encode/decode of lower dir file handles before copy up
+test_file_handles $lowertestdir -p
+# Check encode/write/decode/read/write of lower file handles across copy up
+test_file_handles $lowertestdir -wrap
+unmount_dirs
+
+# Check copy up after encode/decode of lower/upper files
+# (copy up of disconnected dentry to index dir)
+create_dirs
+create_test_files $upperdir
+create_test_files $lowerdir
+mount_dirs
+# Check encode/decode/write/read of upper regular file handles
+test_file_handles $uppertestdir -a
+test_file_handles $uppertestdir -r
+# Check encode/decode/write/read of lower regular file handles
+test_file_handles $lowertestdir -a
+test_file_handles $lowertestdir -r
+unmount_dirs
+
+# Check non-stale handles to unlinked but open lower/upper files
+create_dirs
+create_test_files $upperdir
+create_test_files $upperdir.rw
+create_test_files $lowerdir
+create_test_files $lowerdir.rw
+mount_dirs
+test_file_handles $uppertestdir -dk
+# Check encode/write/unlink/decode/read of upper regular file handles
+test_file_handles $uppertestdir.rw -rwdk
+test_file_handles $lowertestdir -dk
+# Check encode/write/unlink/decode/read of lower file handles across copy up
+test_file_handles $lowertestdir.rw -rwdk
+unmount_dirs
+
+# Check stale handles of unlinked lower/upper files (nlink = 1,0)
+create_dirs
+create_test_files $upperdir
+create_test_files $lowerdir
+mount_dirs
+# Check decode of upper file handles after unlink/rmdir (nlink == 0)
+test_file_handles $uppertestdir -dp
+# Check decode of lower file handles after unlink/rmdir (nlink == 0)
+test_file_handles $lowertestdir -dp
+unmount_dirs
+
+# Check non-stale file handles of linked lower/upper files (nlink = 1,2,1)
+create_dirs
+create_test_files $upperdir
+create_test_files $lowerdir
+mount_dirs
+# Check encode/decode of upper file handles (nlink == 1)
+test_file_handles $uppertestdir
+# Check decode/read of upper file handles after link (nlink == 2)
+test_file_handles $uppertestdir -wlr
+# Check decode/read of upper file handles after link + unlink (nlink == 1)
+test_file_handles $uppertestdir -ur
+# Check encode/decode of lower file handles before copy up (nlink == 1)
+test_file_handles $lowertestdir
+# Check decode/read of lower file handles after copy up + link (nlink == 2)
+test_file_handles $lowertestdir -wlr
+# Check decode/read of lower file handles after copy up + link + unlink (nlink == 1)
+test_file_handles $lowertestdir -ur
+unmount_dirs
+
+# Check non-stale file handles of linked lower/upper hardlinks (nlink = 2,1)
+create_dirs
+create_test_files $upperdir
+create_test_files $lowerdir
+# Create lower/upper hardlinks
+test_file_handles $lowerdir -l >/dev/null
+test_file_handles $upperdir -l >/dev/null
+mount_dirs
+# Check encode/decode of upper hardlink file handles (nlink == 2)
+test_file_handles $uppertestdir
+# Check decode/read of upper hardlink file handles after unlink (nlink == 1)
+test_file_handles $uppertestdir -wur
+# Check encode/decode of lower hardlink file handles before copy up (nlink == 2)
+test_file_handles $lowertestdir
+# Check decode/read of lower hardlink file handles after copy up + unlink (nlink == 1)
+test_file_handles $lowertestdir -wur
+unmount_dirs
+
+# Check stale file handles of unlinked lower/upper hardlinks (nlink = 2,0)
+create_dirs
+create_test_files $upperdir
+create_test_files $lowerdir
+# Create lower/upper hardlinks
+test_file_handles $lowerdir -l >/dev/null
+test_file_handles $upperdir -l >/dev/null
+mount_dirs
+# Check encode/decode of upper hardlink file handles (nlink == 2)
+test_file_handles $uppertestdir
+# Check decode of upper hardlink file handles after 2*unlink (nlink == 0)
+test_file_handles $uppertestdir -d
+# Check encode/decode of lower hardlink file handles before copy up (nlink == 2)
+test_file_handles $lowertestdir
+# Check decode of lower hardlink file handles after copy up + 2*unlink (nlink == 0)
+test_file_handles $lowertestdir -d
+unmount_dirs
+
+# Check non-stale file handles of lower/upper renamed files
+create_dirs
+create_test_files $upperdir
+create_test_files $lowerdir
+mount_dirs
+# Check decode/read of upper file handles after rename in same upper parent
+test_file_handles $uppertestdir -wmr
+# Check decode/read of lower file handles after copy up + rename in same merge parent
+test_file_handles $lowertestdir -wmr
+unmount_dirs
+
+# Check non-stale file handles of lower/upper moved files
+create_dirs
+create_test_files $upperdir -w
+create_test_files $lowerdir -w
+mkdir -p $lowerdir.lo $lowerdir.up $upperdir.lo $upperdir.up
+mount_dirs
+# Check encode/decode/read of lower/upper file handles after move to new upper testdir
+test_file_handles $uppertestdir -o $tmp.upper_file_handles
+test_file_handles $lowertestdir -o $tmp.lower_file_handles
+mv $uppertestdir/* $uppertestdir.up/
+mv $lowertestdir/* $uppertestdir.lo/
+# Check open and read from stored file handles
+test_file_handles $mnt2 -r -i $tmp.upper_file_handles
+test_file_handles $mnt2 -r -i $tmp.lower_file_handles
+# Check encode/decode/read of lower/upper file handles after move to new merge testdir
+test_file_handles $uppertestdir.up -o $tmp.upper_file_handles
+test_file_handles $uppertestdir.lo -o $tmp.lower_file_handles
+mv $uppertestdir.up/* $lowertestdir.up/
+mv $uppertestdir.lo/* $lowertestdir.lo/
+# Check open and read from stored file handles
+test_file_handles $mnt2 -r -i $tmp.upper_file_handles
+test_file_handles $mnt2 -r -i $tmp.lower_file_handles
+unmount_dirs
+
+# Check non-stale file handles of lower/upper renamed dirs
+create_dirs
+create_test_files $upperdir -w
+create_test_files $lowerdir -w
+create_test_files $upperdir/subdir -w
+create_test_files $lowerdir/subdir -w
+mount_dirs
+# Check encode/decode/read of lower/upper file handles after rename of testdir
+test_file_handles $uppertestdir -p -o $tmp.upper_file_handles
+test_file_handles $lowertestdir -p -o $tmp.lower_file_handles
+# Check encode/decode/read of lower/upper file handles after rename of testdir's parent
+test_file_handles $uppertestdir/subdir -p -o $tmp.upper_subdir_file_handles
+test_file_handles $lowertestdir/subdir -p -o $tmp.lower_subdir_file_handles
+# Rename pure upper dir
+mv $uppertestdir $uppertestdir.new/
+# Copy up lower dir, index and rename
+mv $lowertestdir $lowertestdir.new/
+# Check open, read and readdir from stored file handles
+# (testdir argument is the mount point and NOT the dir
+#  we are trying to open by stored file handle)
+test_file_handles $mnt2 -rp -i $tmp.upper_file_handles
+test_file_handles $mnt2 -rp -i $tmp.lower_file_handles
+test_file_handles $mnt2 -rp -i $tmp.upper_subdir_file_handles
+test_file_handles $mnt2 -rp -i $tmp.lower_subdir_file_handles
+# Retry decoding lower subdir file handle when indexed testdir is in dcache
+# (providing renamed testdir argument pins the indexed testdir to dcache)
+test_file_handles $lowertestdir.new -rp -i $tmp.lower_subdir_file_handles
+unmount_dirs
+
+status=0
+exit
diff --git a/tests/overlay/068.out b/tests/overlay/068.out
new file mode 100644
index 00000000..9fd75c7f
--- /dev/null
+++ b/tests/overlay/068.out
@@ -0,0 +1,50 @@
+QA output created by 068
+test_file_handles SCRATCH_MNT.2/uppertestdir
+test_file_handles SCRATCH_MNT.2/uppertestdir -p
+test_file_handles SCRATCH_MNT.2/uppertestdir -wrap
+test_file_handles SCRATCH_MNT.2/lowertestdir
+test_file_handles SCRATCH_MNT.2/lowertestdir -p
+test_file_handles SCRATCH_MNT.2/lowertestdir -wrap
+test_file_handles SCRATCH_MNT.2/uppertestdir -a
+test_file_handles SCRATCH_MNT.2/uppertestdir -r
+test_file_handles SCRATCH_MNT.2/lowertestdir -a
+test_file_handles SCRATCH_MNT.2/lowertestdir -r
+test_file_handles SCRATCH_MNT.2/uppertestdir -dk
+test_file_handles SCRATCH_MNT.2/uppertestdir.rw -rwdk
+test_file_handles SCRATCH_MNT.2/lowertestdir -dk
+test_file_handles SCRATCH_MNT.2/lowertestdir.rw -rwdk
+test_file_handles SCRATCH_MNT.2/uppertestdir -dp
+test_file_handles SCRATCH_MNT.2/lowertestdir -dp
+test_file_handles SCRATCH_MNT.2/uppertestdir
+test_file_handles SCRATCH_MNT.2/uppertestdir -wlr
+test_file_handles SCRATCH_MNT.2/uppertestdir -ur
+test_file_handles SCRATCH_MNT.2/lowertestdir
+test_file_handles SCRATCH_MNT.2/lowertestdir -wlr
+test_file_handles SCRATCH_MNT.2/lowertestdir -ur
+test_file_handles SCRATCH_MNT.2/uppertestdir
+test_file_handles SCRATCH_MNT.2/uppertestdir -wur
+test_file_handles SCRATCH_MNT.2/lowertestdir
+test_file_handles SCRATCH_MNT.2/lowertestdir -wur
+test_file_handles SCRATCH_MNT.2/uppertestdir
+test_file_handles SCRATCH_MNT.2/uppertestdir -d
+test_file_handles SCRATCH_MNT.2/lowertestdir
+test_file_handles SCRATCH_MNT.2/lowertestdir -d
+test_file_handles SCRATCH_MNT.2/uppertestdir -wmr
+test_file_handles SCRATCH_MNT.2/lowertestdir -wmr
+test_file_handles SCRATCH_MNT.2/uppertestdir -o upper_file_handles
+test_file_handles SCRATCH_MNT.2/lowertestdir -o lower_file_handles
+test_file_handles SCRATCH_MNT.2 -r -i upper_file_handles
+test_file_handles SCRATCH_MNT.2 -r -i lower_file_handles
+test_file_handles SCRATCH_MNT.2/uppertestdir.up -o upper_file_handles
+test_file_handles SCRATCH_MNT.2/uppertestdir.lo -o lower_file_handles
+test_file_handles SCRATCH_MNT.2 -r -i upper_file_handles
+test_file_handles SCRATCH_MNT.2 -r -i lower_file_handles
+test_file_handles SCRATCH_MNT.2/uppertestdir -p -o upper_file_handles
+test_file_handles SCRATCH_MNT.2/lowertestdir -p -o lower_file_handles
+test_file_handles SCRATCH_MNT.2/uppertestdir/subdir -p -o upper_subdir_file_handles
+test_file_handles SCRATCH_MNT.2/lowertestdir/subdir -p -o lower_subdir_file_handles
+test_file_handles SCRATCH_MNT.2 -rp -i upper_file_handles
+test_file_handles SCRATCH_MNT.2 -rp -i lower_file_handles
+test_file_handles SCRATCH_MNT.2 -rp -i upper_subdir_file_handles
+test_file_handles SCRATCH_MNT.2 -rp -i lower_subdir_file_handles
+test_file_handles SCRATCH_MNT.2/lowertestdir.new -rp -i lower_subdir_file_handles
diff --git a/tests/overlay/group b/tests/overlay/group
index e809f7f2..be628dd1 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -70,3 +70,4 @@
 065 auto quick mount
 066 auto quick copyup
 067 auto quick copyup nonsamefs
+068 auto quick copyup hardlink exportfs nested
-- 
2.17.1

