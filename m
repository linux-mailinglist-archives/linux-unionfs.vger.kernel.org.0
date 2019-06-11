Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3B3B3D1C9
	for <lists+linux-unionfs@lfdr.de>; Tue, 11 Jun 2019 18:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391879AbfFKQIt (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 11 Jun 2019 12:08:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36514 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391878AbfFKQIs (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 11 Jun 2019 12:08:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id u8so3559031wmm.1;
        Tue, 11 Jun 2019 09:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=13N4Ag9KCv4dGo80Rtk1TpuZs5X9rJWOgPG6ZRw49Qw=;
        b=YEGRXUMdZb2akUAQHdQ9SgQU97ytflxLVqF7/Co2m9ieD1C7dSwpdI1YldcJwB4c8f
         +ZWGmbIbmdjzOM8b6TwtcaALHSEdPLb4QZbaMHIoKnSvd/FGBkcED5A1XxkjCyyAn1Mg
         I8JBvRXL07SaiBJAIvkLuqzidTFgSNIFsmohTNmAaIVEBIhGW6xIdG1Vzj9Xhy+PdC9c
         KIjZmDBhfoW9MQt7N6eYDhzTs8NDwO+X58pWpw5SdlqiRbrsPatWJ9Rn9lREPyRAH/iL
         eMMPFjsNckNnWqfXbQN0EvJjlWqjUmVxd8pZ8x4V/cxZ6RXbdqA2wanTv/8JjD/lkZl9
         083g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=13N4Ag9KCv4dGo80Rtk1TpuZs5X9rJWOgPG6ZRw49Qw=;
        b=J4cjranJwQaskZfbfTlTSOoOMjKTN1kB9UrQ5v161RomJf5xNVpan/Y6Trw5DUWlGE
         JIEy10mMG6KpDjGpTLxZDc/7gOqYLcx9glRAb1e81X3fj4xxJj1Yi4bHsJ+AlLSnUPLw
         27QqwoxDntOfIjwbUJ5rXk34p73xHu2f5HBKKwlqoq2EF8fZ86h29+Ol7PsR8+nVZ6Sr
         eUZbL8oX4puus1LggDp+nbpRi+u1J5FQjPip4N1FS7VVd/tOl9FxD70KB3RFZUxZRm0m
         hdbliQbXOeXbJJ0ChJGYckmy4QeAz+GHkN/eVF/zYii10B5MzjzNWuycazxpRKVfXfqE
         cUiw==
X-Gm-Message-State: APjAAAXO5Sed+bzpS2eQcWuuEp3vFVY86j3onQ2uJAI8ABRZrucZJJAm
        GvFbfWkQ+/dVuc64j4CV3/o=
X-Google-Smtp-Source: APXvYqyY/ioOd7xjQB9mN4O7OIvNiIIgozZIYAzqngnDHyLcTM0d6Za07540a77AIVYRWVh1v/JuUg==
X-Received: by 2002:a05:600c:28d:: with SMTP id 13mr6373119wmk.5.1560269326954;
        Tue, 11 Jun 2019 09:08:46 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id u11sm10942873wrn.1.2019.06.11.09.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 09:08:46 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH 1/3] fstests: print out xfs_io parameter when command fails
Date:   Tue, 11 Jun 2019 19:08:37 +0300
Message-Id: <20190611160839.14777-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190611160839.14777-1-amir73il@gmail.com>
References: <20190611160839.14777-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

In _require_xfs_io_command, when command fails for one of the
generic reasons, if command was tested with params, print out
the params of the failed command.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 common/rc | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/common/rc b/common/rc
index d0aa36a0..85330de2 100644
--- a/common/rc
+++ b/common/rc
@@ -2084,7 +2084,7 @@ _require_xfs_io_command()
 	local command=$1
 	shift
 	local param="$*"
-	local param_checked=0
+	local param_checked=""
 	local opts=""
 
 	local testfile=$TEST_DIR/$$.xfs_io
@@ -2101,7 +2101,7 @@ _require_xfs_io_command()
 		;;
 	"falloc" )
 		testio=`$XFS_IO_PROG -F -f -c "falloc $param 0 1m" $testfile 2>&1`
-		param_checked=1
+		param_checked="$param"
 		;;
 	"fpunch" | "fcollapse" | "zero" | "fzero" | "finsert" | "funshare")
 		local blocksize=$(_get_block_size $TEST_DIR)
@@ -2119,7 +2119,7 @@ _require_xfs_io_command()
 		fi
 		testio=`$XFS_IO_PROG -F -f -c "pwrite 0 20k" -c "fsync" \
 			-c "fiemap -v $param" $testfile 2>&1`
-		param_checked=1
+		param_checked="$param"
 		;;
 	"flink")
 		local testlink=$TEST_DIR/$$.link.xfs_io
@@ -2159,7 +2159,7 @@ _require_xfs_io_command()
 		fi
 		testio=`$XFS_IO_PROG -f $opts -c \
 		        "pwrite $pwrite_opts $param 0 4k" $testfile 2>&1`
-		param_checked=1
+		param_checked="$pwrite_opts $param"
 		;;
 	"scrub"|"repair")
 		testio=`$XFS_IO_PROG -x -c "$command probe" $TEST_DIR 2>&1`
@@ -2179,19 +2179,19 @@ _require_xfs_io_command()
 
 	rm -f $testfile 2>&1 > /dev/null
 	echo $testio | grep -q "not found" && \
-		_notrun "xfs_io $command support is missing"
+		_notrun "xfs_io $command $param_checked support is missing"
 	echo $testio | grep -q "Operation not supported\|Inappropriate ioctl" && \
-		_notrun "xfs_io $command failed (old kernel/wrong fs?)"
+		_notrun "xfs_io $command $param_checked failed (old kernel/wrong fs?)"
 	echo $testio | grep -q "Invalid" && \
-		_notrun "xfs_io $command failed (old kernel/wrong fs/bad args?)"
+		_notrun "xfs_io $command $param_checked failed (old kernel/wrong fs/bad args?)"
 	echo $testio | grep -q "foreign file active" && \
-		_notrun "xfs_io $command not supported on $FSTYP"
+		_notrun "xfs_io $command $param_checked not supported on $FSTYP"
 	echo $testio | grep -q "Function not implemented" && \
-		_notrun "xfs_io $command support is missing (missing syscall?)"
+		_notrun "xfs_io $command $param_checked support is missing (missing syscall?)"
 
 	[ -n "$param" ] || return
 
-	if [ $param_checked -eq 0 ]; then
+	if [ -z "$param_checked" ]; then
 		$XFS_IO_PROG -c "help $command" | grep -q "^ $param --" || \
 			_notrun "xfs_io $command doesn't support $param"
 	else
-- 
2.17.1

