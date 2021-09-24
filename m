Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAEA41693B
	for <lists+linux-unionfs@lfdr.de>; Fri, 24 Sep 2021 03:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243692AbhIXBKt (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 23 Sep 2021 21:10:49 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16289 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbhIXBKs (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 23 Sep 2021 21:10:48 -0400
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HFv6g5HmDz8tMk
        for <linux-unionfs@vger.kernel.org>; Fri, 24 Sep 2021 09:08:27 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggeme756-chm.china.huawei.com
 (10.3.19.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Fri, 24
 Sep 2021 09:09:13 +0800
From:   Zheng Liang <zhengliang6@huawei.com>
To:     <miklos@szeredi.hu>
CC:     <linux-unionfs@vger.kernel.org>, <zhengliang6@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH] ovl: fix oops in ovl_rename
Date:   Fri, 24 Sep 2021 09:16:27 +0800
Message-ID: <20210924011628.2069334-1-zhengliang6@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

We find a kernel NULL pointer dereference problem in overlayfs.
The problem can appear in the following scene:

mkdir lower upper work merge
touch lower/old
touch lower/new
mount -t overlay overlay -olowerdir=lower,upperdir=upper,workdir=work merge
rm merge/new
------------------------------------------------------------------------------------------
process A(rename file in merge)                                process B(delete file in upper)
renameat2(AT_FDCWD, "old", AT_FDCWD, "new", 0)
(new is whiteout file in upper)
  do_renameat2
    vfs_rename
      ovl_rename
      (overwrite=true,ovl_lower_positive(old)=true,
      ovl_dentry_is_whiteout(new)=true)
      (we can add some delay after "flags|=RENAME_EXCHANGE",
      it can make the problem appear more easy)
      ……                                                       unlink(new)
      ……                                                       (delete whiteout in upper)
      (newdentry is negative)
        ovl_do_rename

So,before commencing with ovl_do_rename that the flags maybe attach RENAME_EXCHANGE
and the newdentry is negative in ovl_rename.If we enabled selinux,it
will lead to kernel panic.such as the following log:
PID: 2552045  TASK: ffff8880302faf00  CPU: 2   COMMAND: "fsstress"
 #0 [ffff888080e772a0] machine_kexec at ffffffff856adedc
 #1 [ffff888080e773a8] __crash_kexec at ffffffff8585cd20
 #2 [ffff888080e774c0] panic at ffffffff8572b288
 #3 [ffff888080e77590] oops_end at ffffffff85641f6e
 #4 [ffff888080e775f0] __do_page_fault at ffffffff856cd55b
 #5 [ffff888080e77668] do_page_fault at ffffffff856cd834
 #6 [ffff888080e776a0] async_page_fault at ffffffff8660125e
    [exception RIP: __inode_security_revalidate+34]
    RIP: ffffffff85c43452  RSP: ffff888080e77758  RFLAGS: 00010202
    RAX: 0000000000000000  RBX: 0000000000000000  RCX: ffffffff8593ae7e
    RDX: 0000000000000000  RSI: 0000000000000297  RDI: 0000000000000297
    RBP: ffff8881984e6628   R8: ffffed10115e3f39   R9: ffffed10115e3f39
    R10: 0000000000000001  R11: ffffed10115e3f38  R12: 0000000000000001
    R13: 0000000000000000  R14: ffff88808350a000  R15: 1ffff110101ceef5
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #7 [ffff888080e77780] selinux_inode_rename at ffffffff85c4418d
 #8 [ffff888080e77858] security_inode_rename at ffffffff85c35f24
 #9 [ffff888080e77890] vfs_rename at ffffffff85b01209
 #10 [ffff888080e779a8] ovl_do_rename at ffffffffc0a44c22 [overlay]
 #11 [ffff888080e779d8] ovl_rename at ffffffffc0a46575 [overlay]
 #12 [ffff888080e77b48] vfs_rename at ffffffff85b0155a
 #13 [ffff888080e77c60] do_renameat2 at ffffffff85b06e65
 #14 [ffff888080e77f00] __x64_sys_renameat2 at ffffffff85b06fb2
 #15 [ffff888080e77f30] do_syscall_64 at ffffffff85606243
 #16 [ffff888080e77f50] entry_SYSCALL_64_after_hwframe at ffffffff866000ad

We can add some check in ovl_rename for this scene and return error to avoid kernel panic.

Signed-off-by: Zheng Liang <zhengliang6@huawei.com>
---
 fs/overlayfs/dir.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 1fefb2b8960e..93c7c267de93 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1219,9 +1219,13 @@ static int ovl_rename(struct user_namespace *mnt_userns, struct inode *olddir,
 				goto out_dput;
 		}
 	} else {
-		if (!d_is_negative(newdentry) &&
-		    (!new_opaque || !ovl_is_whiteout(newdentry)))
-			goto out_dput;
+		if (!d_is_negative(newdentry)) {
+			if (!new_opaque || !ovl_is_whiteout(newdentry))
+				goto out_dput;
+		} else {
+			if (flags & RENAME_EXCHANGE)
+				goto out_dput;
+		}
 	}
 
 	if (olddentry == trap)
-- 
2.25.4

