Return-Path: <linux-unionfs+bounces-683-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFDA8AA7F9
	for <lists+linux-unionfs@lfdr.de>; Fri, 19 Apr 2024 07:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61E81F21003
	for <lists+linux-unionfs@lfdr.de>; Fri, 19 Apr 2024 05:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262B5BA39;
	Fri, 19 Apr 2024 05:37:21 +0000 (UTC)
X-Original-To: linux-unionfs@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C14B666
	for <linux-unionfs@vger.kernel.org>; Fri, 19 Apr 2024 05:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713505041; cv=none; b=EeYtnaGyGS44Hug6kq1wKc4w26gplQKVIDvrmmtPePEySyghxNMvOK2KhQl+HaGjpSQwbLluxrJLmk6mnfTs8o9MpoZBnBK8N1WVKe/au2MNv2FLXTtusEfgSwGonWPdET/2O0fnKnFgUTM7bIeTkqAdyk0IvipXF0jLOO4WNLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713505041; c=relaxed/simple;
	bh=UFb0IbNMZ2771Sd8wCVhg4t6SdHICV5yL98AXgQyYk0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iwc6LI/E9RP2xtlD0pIoOhFCFNZUPbR0IXpUEUjXCYCG+81FzDNvofmhzXJgsvpE6ilrkfuGxnhgftk0rr/Pmu2yEa0SlVaSY72DxTwEMD0c57gbxq3dMZ6I7koju305NTU0Q21bnmc8jT7JWU8sVj4N5OG2HJ5dvKf9yrs5cro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7da41c44e78so93720539f.1
        for <linux-unionfs@vger.kernel.org>; Thu, 18 Apr 2024 22:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713505038; x=1714109838;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TLy/cq6gIbC/KyMsxIN++4ZIw5jS13lNmCV1sCfXD38=;
        b=uyHEWlVOd7mNxzqqlOypnqYPlwZMAfvc+lYbR3We5hD4VwHBjfM1CjwadqYtjiLt7k
         z2IesdCUb+jT9dlUbGc6z/5VKg36XZW/5rR5Kepnp5mRI6tPPAMeczWNtvI7xaXmCjgR
         UMGkGLk4roMps1G+SyJ/YoELtdq6DfOh1ZQqSf0XIyKuqvmBBeixEJtiTvaFdVTWCUiV
         Ed2gCFCgw5RTEZCfmpnEPPLM/1ScxdEKqIcBlRs6aDe1QOcaam0QxrJ7+We6UzIdldhK
         AIcLaG0XMhn2jGdx5b28ycvUzITBxJxpIoLMmr0hEOkCkpb45BXBjrOeZ6Uzc5g4iS+r
         skAw==
X-Forwarded-Encrypted: i=1; AJvYcCUV3ADO1dHRO9GCZzWl6mApjWb4te2nPrpb67jSSWzh3KzKrhQa+l8sEwKd4tlL1aPdRsfLcKjmYQpCllrwJc1tTDWa9qLhrDLsmUbOvA==
X-Gm-Message-State: AOJu0YxP2lnbupctofz9SzEuHIMJh5NpyUeMhCombtbFLFMwCh8yJyS0
	72RBVQ0uL8UMmrRZ+UYJqca6OoCtDU0Yn++rKwr4AwtUvL3d48j0aJPi3SHSA1aNkdFnv+hAOVV
	9pinyCpZBL8zEQB/L3M7cUoJ1e/cOyo87WbtydNJQIG1aIRWmHywB3pA=
X-Google-Smtp-Source: AGHT+IHhjYJGuZzLpP0NnOszMvzZBDo9jDufUsBk2FDDkU+U4aphoS5Ph3+Wr/jeKLe+e1UTThU/JXBQuASPnrU/iOczWujy2K/B
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2281:b0:7da:18bc:9cb1 with SMTP id
 d1-20020a056602228100b007da18bc9cb1mr15854iod.0.1713505038631; Thu, 18 Apr
 2024 22:37:18 -0700 (PDT)
Date: Thu, 18 Apr 2024 22:37:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002615fd06166c7b16@google.com>
Subject: [syzbot] [overlayfs?] possible deadlock in ovl_nlink_start
From: syzbot <syzbot+5ad5425056304cbce654@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=106c9fa3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=5ad5425056304cbce654
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/72ab73815344/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d6d6b0d7071/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48e275e5478b/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5ad5425056304cbce654@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
------------------------------------------------------
syz-executor.4/10551 is trying to acquire lock:
ffff88807383ff38 (&ovl_i_lock_key[depth]){+.+.}-{3:3}, at: ovl_inode_lock_interruptible fs/overlayfs/overlayfs.h:654 [inline]
ffff88807383ff38 (&ovl_i_lock_key[depth]){+.+.}-{3:3}, at: ovl_nlink_start+0xdc/0x390 fs/overlayfs/util.c:1162

but task is already holding lock:
ffff88807383fb80 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: inode_lock include/linux/fs.h:793 [inline]
ffff88807383fb80 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: vfs_rmdir+0x101/0x4c0 fs/namei.c:4198

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
       inode_lock_shared include/linux/fs.h:803 [inline]
       lookup_slow+0x45/0x70 fs/namei.c:1708
       walk_component+0x2e1/0x410 fs/namei.c:2004
       lookup_last fs/namei.c:2461 [inline]
       path_lookupat+0x16f/0x450 fs/namei.c:2485
       filename_lookup+0x256/0x610 fs/namei.c:2514
       kern_path+0x35/0x50 fs/namei.c:2622
       lookup_bdev+0xc5/0x290 block/bdev.c:1072
       resume_store+0x1a0/0x710 kernel/power/hibernate.c:1235
       kernfs_fop_write_iter+0x3a4/0x500 fs/kernfs/file.c:334
       call_write_iter include/linux/fs.h:2108 [inline]
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0xa84/0xcb0 fs/read_write.c:590
       ksys_write+0x1a0/0x2c0 fs/read_write.c:643
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #1 (&of->mutex){+.+.}-{3:3}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       kernfs_fop_llseek+0x7e/0x2a0 fs/kernfs/file.c:867
       ovl_llseek+0x314/0x470 fs/overlayfs/file.c:218
       vfs_llseek fs/read_write.c:289 [inline]
       ksys_lseek fs/read_write.c:302 [inline]
       __do_sys_lseek fs/read_write.c:313 [inline]
       __se_sys_lseek fs/read_write.c:311 [inline]
       __x64_sys_lseek+0x153/0x1e0 fs/read_write.c:311
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #0 (&ovl_i_lock_key[depth]){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       ovl_inode_lock_interruptible fs/overlayfs/overlayfs.h:654 [inline]
       ovl_nlink_start+0xdc/0x390 fs/overlayfs/util.c:1162
       ovl_do_remove+0x1fa/0xd90 fs/overlayfs/dir.c:893
       vfs_rmdir+0x367/0x4c0 fs/namei.c:4209
       do_rmdir+0x3b5/0x580 fs/namei.c:4268
       __do_sys_rmdir fs/namei.c:4287 [inline]
       __se_sys_rmdir fs/namei.c:4285 [inline]
       __x64_sys_rmdir+0x49/0x60 fs/namei.c:4285
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

Chain exists of:
  &ovl_i_lock_key[depth] --> &of->mutex --> &ovl_i_mutex_dir_key[depth]

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ovl_i_mutex_dir_key[depth]);
                               lock(&of->mutex);
                               lock(&ovl_i_mutex_dir_key[depth]);
  lock(&ovl_i_lock_key[depth]);

 *** DEADLOCK ***

3 locks held by syz-executor.4/10551:
 #0: ffff88806386a420 (sb_writers#28){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:409
 #1: ffff888076f2aff0 (&ovl_i_mutex_dir_key[depth]/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:828 [inline]
 #1: ffff888076f2aff0 (&ovl_i_mutex_dir_key[depth]/1){+.+.}-{3:3}, at: do_rmdir+0x263/0x580 fs/namei.c:4256
 #2: ffff88807383fb80 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: inode_lock include/linux/fs.h:793 [inline]
 #2: ffff88807383fb80 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: vfs_rmdir+0x101/0x4c0 fs/namei.c:4198

stack backtrace:
CPU: 1 PID: 10551 Comm: syz-executor.4 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 ovl_inode_lock_interruptible fs/overlayfs/overlayfs.h:654 [inline]
 ovl_nlink_start+0xdc/0x390 fs/overlayfs/util.c:1162
 ovl_do_remove+0x1fa/0xd90 fs/overlayfs/dir.c:893
 vfs_rmdir+0x367/0x4c0 fs/namei.c:4209
 do_rmdir+0x3b5/0x580 fs/namei.c:4268
 __do_sys_rmdir fs/namei.c:4287 [inline]
 __se_sys_rmdir fs/namei.c:4285 [inline]
 __x64_sys_rmdir+0x49/0x60 fs/namei.c:4285
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f210ca7de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f210d8860c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 00007f210cbabf80 RCX: 00007f210ca7de69
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000000
RBP: 00007f210caca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f210cbabf80 R15: 00007fff023ba638
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

