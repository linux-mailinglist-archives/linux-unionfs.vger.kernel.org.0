Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85E634D591
	for <lists+linux-unionfs@lfdr.de>; Mon, 29 Mar 2021 18:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhC2Qy1 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 29 Mar 2021 12:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhC2Qxy (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 29 Mar 2021 12:53:54 -0400
X-Greylist: delayed 315 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 29 Mar 2021 09:53:53 PDT
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fa8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78426C061574
        for <linux-unionfs@vger.kernel.org>; Mon, 29 Mar 2021 09:53:53 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4F8JS42VlrzMpnYQ;
        Mon, 29 Mar 2021 18:48:36 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4F8JS36lhyzlppyy;
        Mon, 29 Mar 2021 18:48:35 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>, stable@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v1] ovl: Fix leaked dentry
Date:   Mon, 29 Mar 2021 18:49:07 +0200
Message-Id: <20210329164907.2133175-1-mic@digikod.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Since commit 6815f479ca90 ("ovl: use only uppermetacopy state in
ovl_lookup()"), overlayfs doesn't put temporary dentry when there is a
metacopy error, which leads to dentry leaks when shutting down the
related superblock:

  overlayfs: refusing to follow metacopy origin for (/file0)
  ...
  BUG: Dentry (____ptrval____){i=3f33,n=file3}  still in use (1) [unmount of overlay overlay]
  ...
  WARNING: CPU: 1 PID: 432 at umount_check.cold+0x107/0x14d
  CPU: 1 PID: 432 Comm: unmount-overlay Not tainted 5.12.0-rc5 #1
  ...
  RIP: 0010:umount_check.cold+0x107/0x14d
  ...
  Call Trace:
   d_walk+0x28c/0x950
   ? dentry_lru_isolate+0x2b0/0x2b0
   ? __kasan_slab_free+0x12/0x20
   do_one_tree+0x33/0x60
   shrink_dcache_for_umount+0x78/0x1d0
   generic_shutdown_super+0x70/0x440
   kill_anon_super+0x3e/0x70
   deactivate_locked_super+0xc4/0x160
   deactivate_super+0xfa/0x140
   cleanup_mnt+0x22e/0x370
   __cleanup_mnt+0x1a/0x30
   task_work_run+0x139/0x210
   do_exit+0xb0c/0x2820
   ? __kasan_check_read+0x1d/0x30
   ? find_held_lock+0x35/0x160
   ? lock_release+0x1b6/0x660
   ? mm_update_next_owner+0xa20/0xa20
   ? reacquire_held_locks+0x3f0/0x3f0
   ? __sanitizer_cov_trace_const_cmp4+0x22/0x30
   do_group_exit+0x135/0x380
   __do_sys_exit_group.isra.0+0x20/0x20
   __x64_sys_exit_group+0x3c/0x50
   do_syscall_64+0x45/0x70
   entry_SYSCALL_64_after_hwframe+0x44/0xae
  ...
  VFS: Busy inodes after unmount of overlay. Self-destruct in 5 seconds.  Have a nice day...

This fix has been tested with a syzkaller reproducer.

Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: <stable@vger.kernel.org> # v5.7+
Reported-by: syzbot <syzkaller@googlegroups.com>
Fixes: 6815f479ca90 ("ovl: use only uppermetacopy state in ovl_lookup()")
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20210329164907.2133175-1-mic@digikod.net
---
 fs/overlayfs/namei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 3fe05fb5d145..424c594afd79 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -921,6 +921,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		if ((uppermetacopy || d.metacopy) && !ofs->config.metacopy) {
 			err = -EPERM;
 			pr_warn_ratelimited("refusing to follow metacopy origin for (%pd2)\n", dentry);
+			dput(this);
 			goto out_put;
 		}
 

base-commit: a5e13c6df0e41702d2b2c77c8ad41677ebb065b3
-- 
2.30.2

