Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3488D3D1CA
	for <lists+linux-unionfs@lfdr.de>; Tue, 11 Jun 2019 18:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391883AbfFKQIv (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 11 Jun 2019 12:08:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53413 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391873AbfFKQIu (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 11 Jun 2019 12:08:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so3573919wmj.3;
        Tue, 11 Jun 2019 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bNFR7niArjzEiYRwqofbjXTdRAsYaLCBdJcgFSYXXD4=;
        b=fKA9bciDfV4/r1ttJXJ+KD4hFaCvq6DTRa0WuTKQLBhEwbDnnXmVjBW/pnci+hjoM5
         1hdRCLzaObug3Po2VsQt12VucdxTpfT04hBjz+o/5zpB+RyS40Yr8eTcpPwf5sn0n+y+
         sqcuBUqJMkSKzPR8WWjAfKtoMkmsjFzrEGu6mEb9vfvzK7CwFLa6HgTvNk/E7NlBEj6W
         qgK7fqI3UXzMXsZz9bxz0owDJvZoNSHY4U/g6XABJPOnmx1khSa1gvmTNYuWkjItGkqO
         bVSapN4JrOUVThPgL1YJny9tqmwDwchtt+lLkH6H/eEE+VjU5y1WFkrOesInXge4nY0v
         O8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bNFR7niArjzEiYRwqofbjXTdRAsYaLCBdJcgFSYXXD4=;
        b=GS3Y+AN+7KRbOKCe4fhLwTxmddvw963Xtb+Ibi3kU2B+MAKCaGxIy60reubfHUPmrq
         2dOj0sVds7hb90Wvc2Rj6tJALfWUcfMQ/MqkH2DD8tWZXUwWlmQ08OHmfluF60ZsZ4vZ
         e6B4R7geUvmrEe+6ddpxZUfJZO4fmXcRc2mPhusyWRH6wq2fXdDlb+5YuRLjI6OCl2i+
         avY3CXr+AiyjCSt+HpKsYSN6Q0XaH30gthwL9dcyI24TL6pV0rZx98Gt+JjuTNiWYb+k
         qfsmGwDBEM+qkZPkfRv+07IrbLrL0e1uYBblRHQ6o3MpRJk7XcfbU6VNlujXkKTz3tVg
         Fp6A==
X-Gm-Message-State: APjAAAVfXydmn8LIEpOCD+aepHz64KidpQEgG5P/ygWG1Wnms8zDRspW
        KTeAwGVH35Ayf59A/bE4IaBs9bD+
X-Google-Smtp-Source: APXvYqyMGGEO3qi1ZZnasj94FoaBEBVq9J76+tgZKUpF0gJEvXyGx9GFjHSe1T9+A2WVSdRigY+ieg==
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr19016561wmj.41.1560269328205;
        Tue, 11 Jun 2019 09:08:48 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id u11sm10942873wrn.1.2019.06.11.09.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 09:08:47 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH 2/3] fstests: check for filesystem FS_IOC_FSSETXATTR support
Date:   Tue, 11 Jun 2019 19:08:38 +0300
Message-Id: <20190611160839.14777-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190611160839.14777-1-amir73il@gmail.com>
References: <20190611160839.14777-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

With "_require_xfs_io_command chattr <letter>", check that
flag can be set/cleared using FS_IOC_FSSETXATTR ioctl, similar
to "_require_chattr <letter>" and FS_IOC_SETFLAGS ioctl.

Update the documentation and the tests that use
"_require_xfs_io_command chattr" to test filesystem support
and not only xfs_io support.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 common/rc                    | 10 ++++++++++
 doc/requirement-checking.txt |  2 +-
 tests/generic/553            |  3 +--
 tests/xfs/260                |  2 +-
 tests/xfs/431                |  2 +-
 5 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/common/rc b/common/rc
index 85330de2..25203bb4 100644
--- a/common/rc
+++ b/common/rc
@@ -2090,6 +2090,16 @@ _require_xfs_io_command()
 	local testfile=$TEST_DIR/$$.xfs_io
 	local testio
 	case $command in
+	"chattr")
+		if [ -z "$param" ]; then
+			param=s
+		fi
+		# Test xfs_io chattr support AND
+		# filesystem FS_IOC_FSSETXATTR support
+		testio=`$XFS_IO_PROG -F -f -c "chattr +$param" $testfile 2>&1`
+		$XFS_IO_PROG -F -f -r -c "chattr -$param" $testfile 2>&1
+		param_checked="+$param"
+		;;
 	"chproj")
 		testio=`$XFS_IO_PROG -F -f -c "chproj 0" $testfile 2>&1`
 		;;
diff --git a/doc/requirement-checking.txt b/doc/requirement-checking.txt
index 1ec04d4b..45d2756b 100644
--- a/doc/requirement-checking.txt
+++ b/doc/requirement-checking.txt
@@ -69,7 +69,7 @@ _require_xfs_io_command <name> [<switch>]
      switch.  For example:
 
 	_require_xfs_io_command "falloc"
-	_require_xfs_io_command "chattr" "+/-x"
+	_require_xfs_io_command "chattr" "x"
 
      The first requires that xfs_io support the falloc command and the second
      that it supports the chattr command and that the chattr command supports
diff --git a/tests/generic/553 b/tests/generic/553
index efe25d84..98ef77cc 100755
--- a/tests/generic/553
+++ b/tests/generic/553
@@ -34,9 +34,8 @@ _supported_fs generic
 rm -f $seqres.full
 
 _require_test
-_require_chattr i
 _require_xfs_io_command "copy_range"
-_require_xfs_io_command "chattr"
+_require_xfs_io_command "chattr" "i"
 
 rm -rf $workdir
 mkdir $workdir
diff --git a/tests/xfs/260 b/tests/xfs/260
index ba606998..4956752c 100755
--- a/tests/xfs/260
+++ b/tests/xfs/260
@@ -33,7 +33,7 @@ _supported_os Linux
 _require_scratch_dax
 _require_test_program "feature"
 _require_test_program "t_mmap_dio"
-_require_xfs_io_command "chattr" "+/-x"
+_require_xfs_io_command "chattr" "x"
 _require_xfs_io_command "falloc"
 
 prep_files()
diff --git a/tests/xfs/431 b/tests/xfs/431
index 63b45fd4..febc89d5 100755
--- a/tests/xfs/431
+++ b/tests/xfs/431
@@ -38,7 +38,7 @@ rm -f $seqres.full
 # Modify as appropriate.
 _supported_fs xfs
 _supported_os Linux
-_require_xfs_io_command "chattr"
+_require_xfs_io_command "chattr" "t"
 _require_xfs_io_command "fsync"
 _require_xfs_io_command "pwrite"
 _require_scratch
-- 
2.17.1

