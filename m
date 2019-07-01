Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 424C410A53
	for <lists+linux-unionfs@lfdr.de>; Wed,  1 May 2019 17:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfEAP4H (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 1 May 2019 11:56:07 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:38904 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfEAP4H (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 1 May 2019 11:56:07 -0400
Received: by mail-it1-f200.google.com with SMTP id r198so5643850itb.3
        for <linux-unionfs@vger.kernel.org>; Wed, 01 May 2019 08:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3L9qIVywPxn4NdTzZ0/yrPZgy1EQg/K092XtGtDKgZI=;
        b=F6Eut6IXFYVFz1eipFYpsswmRUvxhm1sbK3TgSVB4fmebFnP6bp2RUbJT3LB0VPDlJ
         3903K8WDb98o/YzUcx8bbx11yJBUdY9PoatJBuHJHwZ9ibVu6tAnRKgpHKZunQGGcgV5
         WdlUARw5DKl3d0ULP+s39iIMP2t/sptOTIBL8xkoyUwJDWbF06Se68NYXsJFPDToqMqV
         CXbII8XH5SF06KNfrfdu/bh/pXAjRpFqjEFtaX6JKY9Xi6ERIKPjU+ElzVknEu85AqrV
         +2frj9myJ7ppYNF/ZMwk2cWPP+Is+Vop7PYRvvfG+jjX6vBFfqgD8LbmcCwO6qt7Ri4s
         3XSw==
X-Gm-Message-State: APjAAAXGu5I0PwLWq7tnKKKKKKU6fd/yalZt8yHfY8VJOwOybDS5NzEw
        gCMJIT4CulPFRNuXDPxG0RuOlXnjdWrjCwbL0H7+0pEdCHeH
X-Google-Smtp-Source: APXvYqwDUh6w7HAsgUF+XhKPrtpFhuL0giycAnJdFa54DEqYDEtt0AIDph+ND+4T6j0lfmsTdnM073k0YWkwsRPJSrZ1asRki4zJ
MIME-Version: 1.0
X-Received: by 2002:a24:7a8b:: with SMTP id a133mr8418165itc.118.1556726166096;
 Wed, 01 May 2019 08:56:06 -0700 (PDT)
Date:   Wed, 01 May 2019 08:56:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002492cc0587d58ed8@google.com>
Subject: WARNING in ovl_rename
From:   syzbot <syzbot+bb1836a212e69f8e201a@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        mszeredi@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    037904a2 Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f58ecca00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a42d110b47dd6b36
dashboard link: https://syzkaller.appspot.com/bug?extid=bb1836a212e69f8e201a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ba097ca00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10be1ceca00000

The bug was bisected to:

commit 6eaf011144af10cad34c0d46f82e50d382c8e926
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Thu Oct 12 16:03:04 2017 +0000

     ovl: fix EIO from lookup of non-indexed upper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1430a262a00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1630a262a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1230a262a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+bb1836a212e69f8e201a@syzkaller.appspotmail.com
Fixes: 6eaf011144af ("ovl: fix EIO from lookup of non-indexed upper")

overlayfs: workdir and upperdir must reside under the same mount
WARNING: CPU: 0 PID: 8323 at fs/overlayfs/dir.c:1176  
ovl_rename+0x159c/0x1940 fs/overlayfs/dir.c:1176
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8323 Comm: syz-executor156 Not tainted 5.1.0-rc6+ #89
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x45 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:ovl_rename+0x159c/0x1940 fs/overlayfs/dir.c:1176
Code: 80 00 00 00 e8 45 f7 19 ff 8b b4 24 80 00 00 00 85 f6 0f 85 cd f6 ff  
ff e8 b1 f5 19 ff 4c 89 f7 e9 a5 f6 ff ff e8 a4 f5 19 ff <0f> 0b e9 a4 f3  
ff ff e8 98 f5 19 ff 48 8b 54 24 70 b8 ff ff 37 00
RSP: 0018:ffff88809366fad8 EFLAGS: 00010293
RAX: ffff88808bb781c0 RBX: 0000000000000000 RCX: ffff888095efc6e0
RDX: 0000000000000000 RSI: ffffffff8256970c RDI: ffff888095efc738
RBP: ffff88809366fbf8 R08: ffff88808bb781c0 R09: 0000000000000008
R10: ffffed1015d05bc7 R11: ffff8880ae82de3b R12: ffff88808b22f160
R13: 0000000000000000 R14: ffff888095efc580 R15: ffff88809366fb90
  vfs_rename+0x803/0x1ac0 fs/namei.c:4475
  do_renameat2+0xb0f/0xc40 fs/namei.c:4625
  __do_sys_rename fs/namei.c:4671 [inline]
  __se_sys_rename fs/namei.c:4669 [inline]
  __x64_sys_rename+0x61/0x80 fs/namei.c:4669
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446d89
Code: e8 ec b9 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 db 06 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8603ed4d98 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00000000006dcc28 RCX: 0000000000446d89
RDX: 0000000000446d89 RSI: 0000000020000140 RDI: 00000000200000c0
RBP: 00000000006dcc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dcc2c
R13: 69647265776f6c2c R14: 30656c69662f2e3d R15: 7269647265707075
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
