Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A737483A9
	for <lists+linux-unionfs@lfdr.de>; Wed,  5 Jul 2023 14:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjGEMAr (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 5 Jul 2023 08:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjGEMAq (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 5 Jul 2023 08:00:46 -0400
Received: from mail-pj1-f80.google.com (mail-pj1-f80.google.com [209.85.216.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4928E6E
        for <linux-unionfs@vger.kernel.org>; Wed,  5 Jul 2023 05:00:45 -0700 (PDT)
Received: by mail-pj1-f80.google.com with SMTP id 98e67ed59e1d1-263fd992ab2so35405a91.1
        for <linux-unionfs@vger.kernel.org>; Wed, 05 Jul 2023 05:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688558445; x=1691150445;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VpenHbvdJzQxgfCS5scbblLnDf+ZQHvl9YuFMax7724=;
        b=DiHTV8yuEQT1Nt/MiSrcqXdWvBB5uwZ+DJr4pbJNPy+QvZoR0AFQ0lkafsMRhJCMjM
         ZRBDp9NPVV80WKf0xJMdG+QnFu/WItvLLl8+AqbeKmzmcuGX/q48GoBzDYcYRe8lpa+z
         TvpSF63HQF/kzqwHc3+u/ThcBT1Xama23Icx1iJpTFWXFilTVTJ7EOLQMC+WrI0OzQC4
         5b8s+ZHZ233RGaAbW9rktzmo05fg2/5KasOB8Da1Hx2ShI2UBO/kvsY5orbx99Z9QoHY
         xuQtQKVo24qlSd+AxGKq0XE6PBkfWadya3I+LSipZTrT+TzPiQxBOJHzaCLcXKFEwiAT
         e2EA==
X-Gm-Message-State: ABy/qLZ4WCXC7y6c1oUneQJV42iKTzHrMw04F0SwTco/fAPEKLsi2Gah
        8EEen4KmEBZLjKl80KgP4ZBpwlL8YJy0uK5y41672bpPgtJ9
X-Google-Smtp-Source: APBJJlGjdj3nzwXgF+QJ+/AzUmplUcm6ibES17LCr8wRC1xuyPlyq+LtPIoeSAJgZDtwP5sBFlvzDJmL3lJKwACGvOqu6Hf8N9JW
MIME-Version: 1.0
X-Received: by 2002:a17:90b:3c51:b0:261:22fb:4462 with SMTP id
 pm17-20020a17090b3c5100b0026122fb4462mr1595800pjb.3.1688558445211; Wed, 05
 Jul 2023 05:00:45 -0700 (PDT)
Date:   Wed, 05 Jul 2023 05:00:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f34d705ffbc2604@google.com>
Subject: [syzbot] [overlayfs?] general protection fault in d_path
From:   syzbot <syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d528014517f2 Revert ".gitignore: ignore *.cover and *.mbx"
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14fad002a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1085b4238c9eb6ba
dashboard link: https://syzkaller.appspot.com/bug?extid=a67fc5321ffb4b311c98
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fef94e788067/disk-d5280145.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/576412ea518b/vmlinux-d5280145.xz
kernel image: https://storage.googleapis.com/syzbot-assets/685a0e4be06b/bzImage-d5280145.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000000000a: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
CPU: 1 PID: 10127 Comm: syz-executor.3 Not tainted 6.4.0-syzkaller-11478-gd528014517f2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:__lock_acquire+0x10d/0x7f70 kernel/locking/lockdep.c:5012
Code: 85 75 18 00 00 83 3d 15 c8 2c 0d 00 48 89 9c 24 10 01 00 00 0f 84 f8 0f 00 00 83 3d 5c de b3 0b 00 74 34 48 89 d0 48 c1 e8 03 <42> 80 3c 00 00 74 1a 48 89 d7 e8 b4 51 79 00 48 8b 94 24 80 00 00
RSP: 0018:ffffc900169be9e0 EFLAGS: 00010006
RAX: 000000000000000a RBX: 1ffff92002d37d60 RCX: 0000000000000002
RDX: 0000000000000050 RSI: 0000000000000000 RDI: 0000000000000050
RBP: ffffc900169beca8 R08: dffffc0000000000 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff1d2fe76 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000002 R15: ffff88802091d940
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa22a3fe000 CR3: 000000004b5e1000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
 seqcount_lockdep_reader_access+0x139/0x220 include/linux/seqlock.h:102
 get_fs_root_rcu fs/d_path.c:244 [inline]
 d_path+0x2f0/0x6e0 fs/d_path.c:286
 audit_log_d_path+0xd3/0x310 kernel/audit.c:2139
 dump_common_audit_data security/lsm_audit.c:224 [inline]
 common_lsm_audit+0x7cf/0x1a90 security/lsm_audit.c:458
 smack_log+0x421/0x540 security/smack/smack_access.c:383
 smk_tskacc+0x2ff/0x360 security/smack/smack_access.c:253
 smack_inode_getattr+0x203/0x270 security/smack/smack_lsm.c:1202
 security_inode_getattr+0xd3/0x120 security/security.c:2114
 vfs_getattr+0x25/0x70 fs/stat.c:167
 ovl_getattr+0x1b1/0xf70 fs/overlayfs/inode.c:174
 ima_check_last_writer security/integrity/ima/ima_main.c:171 [inline]
 ima_file_free+0x26e/0x4b0 security/integrity/ima/ima_main.c:203
 __fput+0x36a/0x950 fs/file_table.c:378
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x68f/0x2290 kernel/exit.c:874
 do_group_exit+0x206/0x2c0 kernel/exit.c:1024
 get_signal+0x1709/0x17e0 kernel/signal.c:2877
 arch_do_signal_or_restart+0x91/0x670 arch/x86/kernel/signal.c:308
 exit_to_user_mode_loop+0x6a/0x100 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7f3ca8c389
Code: Unable to access opcode bytes at 0x7f7f3ca8c35f.
RSP: 002b:00007f7f3d741168 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: fffffffffffffffb RBX: 00007f7f3cbac050 RCX: 00007f7f3ca8c389
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000020000180
RBP: 00007f7f3cad7493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff8432555f R14: 00007f7f3d741300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x10d/0x7f70 kernel/locking/lockdep.c:5012
Code: 85 75 18 00 00 83 3d 15 c8 2c 0d 00 48 89 9c 24 10 01 00 00 0f 84 f8 0f 00 00 83 3d 5c de b3 0b 00 74 34 48 89 d0 48 c1 e8 03 <42> 80 3c 00 00 74 1a 48 89 d7 e8 b4 51 79 00 48 8b 94 24 80 00 00
RSP: 0018:ffffc900169be9e0 EFLAGS: 00010006
RAX: 000000000000000a RBX: 1ffff92002d37d60 RCX: 0000000000000002
RDX: 0000000000000050 RSI: 0000000000000000 RDI: 0000000000000050
RBP: ffffc900169beca8 R08: dffffc0000000000 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff1d2fe76 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000002 R15: ffff88802091d940
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa22a3fe000 CR3: 000000004b5e1000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	85 75 18             	test   %esi,0x18(%rbp)
   3:	00 00                	add    %al,(%rax)
   5:	83 3d 15 c8 2c 0d 00 	cmpl   $0x0,0xd2cc815(%rip)        # 0xd2cc821
   c:	48 89 9c 24 10 01 00 	mov    %rbx,0x110(%rsp)
  13:	00
  14:	0f 84 f8 0f 00 00    	je     0x1012
  1a:	83 3d 5c de b3 0b 00 	cmpl   $0x0,0xbb3de5c(%rip)        # 0xbb3de7d
  21:	74 34                	je     0x57
  23:	48 89 d0             	mov    %rdx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 00 00       	cmpb   $0x0,(%rax,%r8,1) <-- trapping instruction
  2f:	74 1a                	je     0x4b
  31:	48 89 d7             	mov    %rdx,%rdi
  34:	e8 b4 51 79 00       	callq  0x7951ed
  39:	48                   	rex.W
  3a:	8b                   	.byte 0x8b
  3b:	94                   	xchg   %eax,%esp
  3c:	24 80                	and    $0x80,%al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
