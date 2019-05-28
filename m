Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA2E2CA2D
	for <lists+linux-unionfs@lfdr.de>; Tue, 28 May 2019 17:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfE1PRj (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 28 May 2019 11:17:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44875 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbfE1PRi (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 28 May 2019 11:17:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id w13so12306696wru.11;
        Tue, 28 May 2019 08:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Lg0K0q8VReszXMeOvyTdpLQyUXLxJAiBvY9d4NKRqQ=;
        b=pxqRKt7YOONRzl8/jtjQiWihKpEd2TpjXgtXBfLkXppF/fTdpl/0rpNeeZSaGj/zO5
         ekPbGmIeLR1HD2oNFDp13oLaih+dJ73NUN8faXhr2EwSMOsqR8YFCjDflcY/L1vpw0nO
         V9BDA01DlTmud1o9Zgkr1FblQlzyTfPl/oDbYw0dUL4pKDrnuZx14O947A9mg+554zY3
         RkiqOaPFZ4jieU07TamFnOXE8ENhEuNyYpwL399e3xWfkY+NuDSABNDFtirlT23ZMmAp
         akW1f6TE1fJukXEEUNqSnQcoHX2vZ/l4q8Q7jkH7HZK4lcVeoZELj/Cdsce+oVEKgr0k
         T4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Lg0K0q8VReszXMeOvyTdpLQyUXLxJAiBvY9d4NKRqQ=;
        b=JhvquEFwjnx1fYFe8A2Sfd1YZ8kFjB8rmNbEfpHJCfR1OmHAgW3JyIAiv+E/OM/XzQ
         9oNUMYl4ORuAueswkJuqYiAeA6z/3msW7PTJFyiZ8V+fTgDXviGsH4Jh2Yrnp+62t/F6
         EgWiRHtCyxD/xErk4tqHlLNFKPSGZFklfq5F5uYIOG8v3J8I0gZue13OldkgiqkDiFhi
         BZXq/06gUI/ldr3teMHuf2Aw9QTZJAz+QvQkgF9ej3ZM5USp0IJ2HfeGIO9LnRU/SkvL
         YstHcvYkRy/E0+8xv6thbiHw83fMAYrGnjb/RjBe1CsXMpp+Bbfg0G4vfXtloh1SmUu/
         fBbw==
X-Gm-Message-State: APjAAAWJeoT+WEwa2mF72wjzw1R/wIXp3IV3IDCUqsNjvqy66fxGm1iD
        oT6w2T5akXKvGaqt8BG3oAj16lYD
X-Google-Smtp-Source: APXvYqwzRLG91zNR5ThmrPSX2M4AzfrpQB2OMwzlkbahiGrfL9r5Jre6/NImMBVfZPPtE8dPIR46GA==
X-Received: by 2002:adf:f292:: with SMTP id k18mr52692440wro.321.1559056656524;
        Tue, 28 May 2019 08:17:36 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id z65sm5017010wme.37.2019.05.28.08.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 08:17:35 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     zhangyi <yi.zhang@huawei.com>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH v3 4/4] overlay: fix exit code for some fsck.overlay valid cases
Date:   Tue, 28 May 2019 18:17:23 +0300
Message-Id: <20190528151723.12525-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190528151723.12525-1-amir73il@gmail.com>
References: <20190528151723.12525-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

From: "zhangyi (F)" <yi.zhang@huawei.com>

Some valid test cases about fsck.overlay may be not valid enough now,
they lose the impure xattr on the parent directory of the simluated
redirect directory, and lose the whiteout which use to cover the origin
lower object. Then fsck.overlay will fix these two inconsistency which
are not those test cases want to cover, thus it will lead to
fsck.overlay return FSCK_NONDESTRUCT instead of FSCK_OK. Fix these by
complement the missing overlay related features.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 tests/overlay/045 | 19 ++++++++++++++++---
 tests/overlay/046 | 13 +++++++++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/tests/overlay/045 b/tests/overlay/045
index 6b5e8ae4..34b7ce4c 100755
--- a/tests/overlay/045
+++ b/tests/overlay/045
@@ -37,6 +37,7 @@ _require_attrs
 _require_command "$FSCK_OVERLAY_PROG" fsck.overlay
 
 OVL_XATTR_OPAQUE_VAL=y
+OVL_XATTR_IMPURE_VAL=y
 
 # remove all files from previous tests
 _scratch_mkfs
@@ -69,6 +70,15 @@ make_opaque_dir()
 	$SETFATTR_PROG -n $OVL_XATTR_OPAQUE -v $OVL_XATTR_OPAQUE_VAL $target
 }
 
+# Create impure directories
+make_impure_dir()
+{
+	for dir in $*; do
+		mkdir -p $dir
+		$SETFATTR_PROG -n $OVL_XATTR_IMPURE -v $OVL_XATTR_IMPURE_VAL $dir
+	done
+}
+
 # Create a redirect directory
 make_redirect_dir()
 {
@@ -155,8 +165,9 @@ echo "+ Valid whiteout(2)"
 make_test_dirs
 mkdir $lowerdir/origin
 touch $lowerdir/origin/foo
+make_impure_dir $upperdir
 make_redirect_dir $upperdir/testdir "origin"
-make_whiteout $upperdir/testdir/foo
+make_whiteout $upperdir/origin $upperdir/testdir/foo
 
 _overlay_fsck_expect $FSCK_OK $lowerdir $upperdir $workdir -p
 check_whiteout $upperdir/testdir/foo
@@ -169,7 +180,8 @@ mkdir -p $lowerdir2/origin/subdir
 touch $lowerdir2/origin/subdir/foo
 make_redirect_dir $lowerdir/testdir "origin"
 mkdir -p $upperdir/testdir/subdir
-make_whiteout $upperdir/testdir/subdir/foo
+make_whiteout $lowerdir/origin $upperdir/testdir/subdir/foo
+make_impure_dir $upperdir/testdir $upperdir
 
 _overlay_fsck_expect $FSCK_OK "$lowerdir:$lowerdir2" $upperdir $workdir -p
 check_whiteout $upperdir/testdir/subdir/foo
@@ -195,7 +207,8 @@ mkdir $lowerdir/origin
 touch $lowerdir/origin/foo
 make_opaque_dir $upperdir/testdir
 make_redirect_dir $upperdir/testdir/subdir "/origin"
-make_whiteout $upperdir/testdir/subdir/foo
+make_whiteout $upperdir/origin $upperdir/testdir/subdir/foo
+make_impure_dir $upperdir/testdir
 
 _overlay_fsck_expect $FSCK_OK $lowerdir $upperdir $workdir -p
 check_whiteout $upperdir/testdir/subdir/foo
diff --git a/tests/overlay/046 b/tests/overlay/046
index 4a9ee68f..36c74207 100755
--- a/tests/overlay/046
+++ b/tests/overlay/046
@@ -40,6 +40,16 @@ _require_command "$FSCK_OVERLAY_PROG" fsck.overlay
 _scratch_mkfs
 
 OVL_XATTR_OPAQUE_VAL=y
+OVL_XATTR_IMPURE_VAL=y
+
+# Create impure directories
+make_impure_dir()
+{
+	for dir in $*; do
+		mkdir -p $dir
+		$SETFATTR_PROG -n $OVL_XATTR_IMPURE -v $OVL_XATTR_IMPURE_VAL $dir
+	done
+}
 
 # Create a redirect directory
 make_redirect_dir()
@@ -140,6 +150,7 @@ make_test_dirs
 mkdir $lowerdir/origin
 make_whiteout $upperdir/origin
 make_redirect_dir $upperdir/testdir "origin"
+make_impure_dir $upperdir
 
 _overlay_fsck_expect $FSCK_OK $lowerdir $upperdir $workdir -p
 check_redirect $upperdir/testdir "origin"
@@ -151,6 +162,7 @@ make_test_dirs
 mkdir $lowerdir/origin
 make_whiteout $upperdir/origin
 make_redirect_dir $upperdir/testdir1/testdir2 "/origin"
+make_impure_dir $upperdir/testdir1
 
 _overlay_fsck_expect $FSCK_OK $lowerdir $upperdir $workdir -p
 check_redirect $upperdir/testdir1/testdir2 "/origin"
@@ -172,6 +184,7 @@ make_test_dirs
 mkdir $lowerdir/{testdir1,testdir2}
 make_redirect_dir $upperdir/testdir1 "testdir2"
 make_redirect_dir $upperdir/testdir2 "testdir1"
+make_impure_dir $upperdir
 
 _overlay_fsck_expect $FSCK_OK $lowerdir $upperdir $workdir -p
 check_redirect $upperdir/testdir1 "testdir2"
-- 
2.17.1

