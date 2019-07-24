Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0CBD737B0
	for <lists+linux-unionfs@lfdr.de>; Wed, 24 Jul 2019 21:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfGXTSc (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 24 Jul 2019 15:18:32 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:50933 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbfGXTSH (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 24 Jul 2019 15:18:07 -0400
Received: by mail-io1-f70.google.com with SMTP id m26so52127776ioh.17
        for <linux-unionfs@vger.kernel.org>; Wed, 24 Jul 2019 12:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/KbbthRJZk0AxJWbum4pr1UQLrzvmUjB/GqGbUAPhkE=;
        b=gxj3g4SWE0zNTapkfWsTbMQA4dju+E8PPblyfsxrLJ21ZdEi+rRVkEhF6ScNItkpwr
         L6vSINF4iRnQjZ0dnH/VsDbhyyNQOfWH97ajbHMJqREjaQpSYbMbdEGI1kgvSwrOUqe0
         Q+co1DB0OWY4Ga2+oUv1kXgyBvnaaawHp1MTAUxETjruJedfuVBhrL1VfIxxG5j0H4XE
         Z61wKkHcH5rIsMLQW4D+2kFT5dOL9IMmmG/Ic060aNyQUtIZ6Q9arzIPF+izTB6moL8R
         pm2DMXkjEk4pw3cQl2fsxoQBt8KDgp6hhr6bzBqbMIKBZWJhovIK5IXKrI+ZW0uErb3+
         /BdQ==
X-Gm-Message-State: APjAAAUvc2IA9Oya5rfmJ/X3oFiALLvZ6fwd45qE/vTyx/g5iIlPxRjH
        uz+Wow/+APBWakQFSX63t9nxEz7EI+CV0Qj5OwfvgT8qBtB3
X-Google-Smtp-Source: APXvYqyFDeSAO4sa6RZWdMFSrRfA6xw74ThmADE7c0L0BoUD9BTewtNZ1iTIGdPQiciu8ZsPIdTxkSWkapBZnbtOmAfyK9+bJOHK
MIME-Version: 1.0
X-Received: by 2002:a5d:8447:: with SMTP id w7mr1629918ior.197.1563995887252;
 Wed, 24 Jul 2019 12:18:07 -0700 (PDT)
Date:   Wed, 24 Jul 2019 12:18:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a3a63058e722b94@google.com>
Subject: WARNING in ovl_real_fdget_meta
From:   syzbot <syzbot+032bc63605089a199d30@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c6dd78fc Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1346d53fa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c8985c08e1f9727
dashboard link: https://syzkaller.appspot.com/bug?extid=032bc63605089a199d30
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15855334600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fcc4c8600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+032bc63605089a199d30@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8471 at fs/overlayfs/file.c:55 ovl_change_flags  
fs/overlayfs/file.c:55 [inline]
WARNING: CPU: 1 PID: 8471 at fs/overlayfs/file.c:55  
ovl_real_fdget_meta.cold+0x11/0x1e fs/overlayfs/file.c:106
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 8471 Comm: syz-executor111 Not tainted 5.2.0+ #71
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x16f/0x1f0 lib/dump_stack.c:113
  panic+0x2dc/0x755 kernel/panic.c:219
  __warn.cold+0x20/0x4c kernel/panic.c:576
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1026
RIP: 0010:ovl_change_flags fs/overlayfs/file.c:55 [inline]
RIP: 0010:ovl_real_fdget_meta.cold+0x11/0x1e fs/overlayfs/file.c:106
Code: e9 b3 fd ff ff e8 0c 68 4f ff e9 fb fd ff ff e8 02 68 4f ff e9 15 fe  
ff ff e8 b8 a6 15 ff 48 c7 c7 a0 45 b3 87 e8 c0 db ff fe <0f> 0b 41 bc fb  
ff ff ff e9 68 c6 ff ff e8 9a a6 15 ff 48 c7 c7 a0
RSP: 0018:ffff8880a1bffdc0 EFLAGS: 00010286
RAX: 0000000000000024 RBX: 0000000004048000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815b9de2 RDI: ffffed101437ffaa
RBP: ffff8880a1bffdf0 R08: 0000000000000024 R09: ffffed1015d26079
R10: ffffed1015d26078 R11: ffff8880ae9303c7 R12: 000000000000a000
R13: ffff88809bc592c0 R14: ffff88809bc59338 R15: ffff8880898e0460
  ovl_real_fdget fs/overlayfs/file.c:113 [inline]
  ovl_llseek+0x105/0x3b0 fs/overlayfs/file.c:163
  vfs_llseek fs/read_write.c:300 [inline]
  ksys_lseek+0x116/0x1b0 fs/read_write.c:313
  __do_sys_lseek fs/read_write.c:324 [inline]
  __se_sys_lseek fs/read_write.c:322 [inline]
  __x64_sys_lseek+0x73/0xb0 fs/read_write.c:322
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441ce9
Code: e8 1c b4 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcff68e398 EFLAGS: 00000246 ORIG_RAX: 0000000000000008
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000441ce9
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000402af0 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
