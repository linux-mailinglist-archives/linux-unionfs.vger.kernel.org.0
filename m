Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4E6634BA7
	for <lists+linux-unionfs@lfdr.de>; Tue,  4 Jun 2019 17:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfFDPKn (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 4 Jun 2019 11:10:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37704 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbfFDPKn (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 4 Jun 2019 11:10:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id h1so16237810wro.4
        for <linux-unionfs@vger.kernel.org>; Tue, 04 Jun 2019 08:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CVe8GNIy/jQT2Xib23+VR1m07gUIdS0n/O8YMNvFuQU=;
        b=YV5RxoXXaXO3ffWGqNRG9787gKuJ4vqkGLKaBQSzDKk3614orRzvJXG9oE8mfj5zTa
         +mi6Pc5RtnhjUay9dHSScFM7FPwQ+1SFUUIJo/E1woWbb7ygGydVD1yCxpUVWbfxOpQY
         lYY4E8Ba1aPmqMeVFuyaPo/mKqWewpGAsVa1yqzwAkZKqHRWPfs4Juy2WIeSwfMniPt0
         jvwqwipqQ+Zl7EeZ11CLwOZZUuWlhtM9FvbblLEm7GbcM13Tz744A28F9/SmxDSHP84Q
         cI6atxgu2lEUgl+D5Ibu4r8w4FUDSro/sL3DYULBWYrJwprcYxPIl5Mkw3ekhvmtrfMj
         gtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CVe8GNIy/jQT2Xib23+VR1m07gUIdS0n/O8YMNvFuQU=;
        b=F3wmsArjFlSXQRh700lDplqPiSmD4mt883uGuki6OJpwzJEC/iz5jUQZ3j1St5G9Jh
         jIk5+jh486/W9lipJ4WUPLtwGSMizP9FDUASuyngX2nr/lDUJvkwoVhiGpnchd6KlioE
         agTW5RtVf8WcDA1i6c+7QHXWyoUl2At9Y9nC01TPxrpDM8jOJJVPxDIGGFbcXDkQChAs
         COHZEXjyD4vMP2qDTasEaJu6uWrcV8d4ts/JYec2iVVnQ9U/HWe+a7J6v4k7P0cDHhCR
         /nFCNnR2ampkZum0ti8NG1s+ChTl9gAZTemoNcaC18zA8dCVoPdCmw6Gl3n4xasUTruo
         BeFw==
X-Gm-Message-State: APjAAAVYMpw1xwxL05vCZKyHJEF1NUqtFEU9o+1xmVWTU5ucOPfZxQx0
        PAq3Lp1b4xZL3UDcJZghPjC390V1Oc0=
X-Google-Smtp-Source: APXvYqyQxF4n08JLQREYaGKaXOmoa21LoiTQNR4fiDJ1Li0myH8dw3ML6w7yb3PkmrU2GRg41Ey7vQ==
X-Received: by 2002:adf:c5c1:: with SMTP id v1mr3636700wrg.129.1559661041439;
        Tue, 04 Jun 2019 08:10:41 -0700 (PDT)
Received: from localhost.localdomain (p548C66C4.dip0.t-ipconnect.de. [84.140.102.196])
        by smtp.gmail.com with ESMTPSA id l7sm9077326wmh.20.2019.06.04.08.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 08:10:40 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Cyril Hrubis <chrubis@suse.cz>, Murphy Zhou <xzhou@redhat.com>,
        Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, ltp@lists.linux.it
Subject: [PATCH v2 1/2] fanotify06: add a test case for overlayfs
Date:   Tue,  4 Jun 2019 18:10:34 +0300
Message-Id: <20190604151035.6123-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

This test fails on overlayfs since kernel v4.19.
Added a test case for overlayfs mount.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Changes since v1:
- Use new overlayfs mount helpers
- Add patch to fix EBUSY error on overlayfs umount

 .../kernel/syscalls/fanotify/fanotify06.c     | 61 +++++++++++++------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c b/testcases/kernel/syscalls/fanotify/fanotify06.c
index 6a2e2494f..e053da0e5 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify06.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
@@ -15,6 +15,14 @@
  *  Date:   Thu Nov 13 15:19:33 2014 -0800
  *
  *      fanotify: fix notification of groups with inode & mount marks
+ *
+ * The overlayfs test case is a regression test for:
+ *
+ *  commit d989903058a83e8536cc7aadf9256a47d5c173fe
+ *  Author: Amir Goldstein <amir73il@gmail.com>
+ *  Date:   Wed Apr 24 19:39:50 2019 +0300
+ *
+ *      ovl: do not generate duplicate fsnotify events for "fake" path
  */
 #define _GNU_SOURCE
 #include "config.h"
@@ -54,8 +62,18 @@ static int fd_notify[FANOTIFY_PRIORITIES][GROUPS_PER_PRIO];
 
 static char event_buf[EVENT_BUF_LEN];
 
-#define MOUNT_NAME "mntpoint"
-static int mount_created;
+static const char mntpoint[] = OVL_BASE_MNTPOINT;
+
+static int ovl_mounted;
+
+static struct tcase {
+	const char *tname;
+	const char *mnt;
+	int use_overlay;
+} tcases[] = {
+	{ "Fanotify merge mount mark", mntpoint, 0 },
+	{ "Fanotify merge overlayfs mount mark", OVL_MNT, 1 },
+};
 
 static void create_fanotify_groups(void)
 {
@@ -72,12 +90,12 @@ static void create_fanotify_groups(void)
 			ret = fanotify_mark(fd_notify[p][i],
 					    FAN_MARK_ADD | FAN_MARK_MOUNT,
 					    FAN_MODIFY,
-					    AT_FDCWD, ".");
+					    AT_FDCWD, fname);
 			if (ret < 0) {
 				tst_brk(TBROK | TERRNO,
 					"fanotify_mark(%d, FAN_MARK_ADD | "
 					"FAN_MARK_MOUNT, FAN_MODIFY, AT_FDCWD,"
-					" '.') failed", fd_notify[p][i]);
+					" %s) failed", fd_notify[p][i], fname);
 			}
 			/* Add ignore mark for groups with higher priority */
 			if (p == 0)
@@ -130,11 +148,23 @@ static void verify_event(int group, struct fanotify_event_metadata *event)
 	}
 }
 
-void test01(void)
+void test_fanotify(unsigned int n)
 {
 	int ret;
 	unsigned int p, i;
 	struct fanotify_event_metadata *event;
+	struct tcase *tc = &tcases[n];
+
+	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
+
+	if (tc->use_overlay && !ovl_mounted) {
+		tst_res(TCONF,
+		        "overlayfs is not configured in this kernel.");
+		return;
+	}
+
+	sprintf(fname, "%s/tfile_%d", tc->mnt, getpid());
+	SAFE_TOUCH(fname, 0644, NULL);
 
 	create_fanotify_groups();
 
@@ -196,31 +226,26 @@ void test01(void)
 
 static void setup(void)
 {
-	SAFE_MKDIR(MOUNT_NAME, 0755);
-	SAFE_MOUNT(MOUNT_NAME, MOUNT_NAME, "none", MS_BIND, NULL);
-	mount_created = 1;
-	SAFE_CHDIR(MOUNT_NAME);
-
-	sprintf(fname, "tfile_%d", getpid());
-	SAFE_FILE_PRINTF(fname, "1");
+	ovl_mounted = TST_MOUNT_OVERLAY();
 }
 
 static void cleanup(void)
 {
 	cleanup_fanotify_groups();
 
-	SAFE_CHDIR("../");
-
-	if (mount_created && tst_umount(MOUNT_NAME) < 0)
-		tst_brk(TBROK | TERRNO, "umount failed");
+	if (ovl_mounted)
+		SAFE_UMOUNT(OVL_MNT);
 }
 
 static struct tst_test test = {
-	.test_all = test01,
+	.test = test_fanotify,
+	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
-	.needs_root = 1
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = mntpoint,
 };
 
 #else
-- 
2.17.1

