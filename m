Return-Path: <linux-unionfs+bounces-1143-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665A59D8661
	for <lists+linux-unionfs@lfdr.de>; Mon, 25 Nov 2024 14:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2606E2875DF
	for <lists+linux-unionfs@lfdr.de>; Mon, 25 Nov 2024 13:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797AB1AB6D8;
	Mon, 25 Nov 2024 13:27:27 +0000 (UTC)
X-Original-To: linux-unionfs@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9F1AAE17
	for <linux-unionfs@vger.kernel.org>; Mon, 25 Nov 2024 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732541247; cv=none; b=ON++eHhICA9s2YXByj6bN+hTyGnyM5QBZXFHPNAlyldbOTLNBGF5/J1I6pOlc3Ql1kqgPxIcA5AM7E5pXbOhQC5Hj5/SqTFABAsKKw1E4w19VNxSKZUw68liXxNRGcFs1dY1tbEY/d6KMyJ6r9K5igdJFXr197xumybJWuo/1Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732541247; c=relaxed/simple;
	bh=PeRp8aLqF/N88ANxnxrByMrp+dmp9+mvcu63+YQnG0g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m477+vXvUHisuT+La3gxiC3zU5SPJdv+FYIyZtAufDGS3eACR8F6RA3jMs7JsfApJ438SwTK2BcRf6CVdYFlp3Dp43/LY4FmZEfx4FbhwLBwL6988PjvV5eD0tI0nMT9HrMYBfR6Om+QsTXVWCK1F0M36sroKV1FBrPB0IU3ke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a794990ef3so35622275ab.1
        for <linux-unionfs@vger.kernel.org>; Mon, 25 Nov 2024 05:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732541245; x=1733146045;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=826JRgY1oDQK9ZChjmH3AkNOhNoLCyWSt0RsBZe9OEA=;
        b=XAZOzQJpXRmiHD7CuOeVWJJRgyqf+et8Zu1ZdDORVI6/mFUvgxlgE79SR7/bJD2Si9
         RKcztrM7iGSp2VjpJr6JcQRagU1TEukwWsjjc1JVJBcSVqxuawccvRMblVmDEYeI0SRB
         Any1olVjedPHCt4IlzywThYO59fcoqyVH92xXNsAKZpd97Jvn28dqSbCKT/0msEezLKY
         Fg3FKe5sN5zEwCNpUhTUOsPOM79obYrHTfKlj6oJZRQFPWmTWb64THf9W+TTHk5N6b9P
         sN0BBUwrMutbUrKOQaY+WlMrGt0M3aOMxrYgiuI+ouBlPFTFcAMrYNdymoWq6S36AWLj
         lySw==
X-Forwarded-Encrypted: i=1; AJvYcCU1Bs/O1K24QkiVQQjDP1yygQeMhsAtfhVi8NWb9GZ43HssB7OVdaXTsjU9PMobkK/j4IcxlwTPuCc3UzQu@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrc9htmtZ0caieZLHqsvBBt6dsHyBkPOtQN6f33DwEzoUmHuGl
	gg+uIf3OaDfVs0FQ/Frwifx66of0OOhYai+9nMoEbeoQVsd2km3gdA7RG7Mqq36WKGcPAL7YN+m
	I8jmi74o148n24Ohx6VENUuVJBrJIYtOtVcWtLJW+6ZTZ4vkBx+B4LtU=
X-Google-Smtp-Source: AGHT+IFARb1qmdIrPgEul6s66dhRIFucD4YpsdPtKkZbIPQeDbCGyMproE8Ikima22wSwGVimvNtX+GQq9A5RiuvF4J4giE6owxE
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c542:0:b0:3a7:ab88:8c0 with SMTP id
 e9e14a558f8ab-3a7ab88093bmr80619425ab.10.1732541244939; Mon, 25 Nov 2024
 05:27:24 -0800 (PST)
Date: Mon, 25 Nov 2024 05:27:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67447b3c.050a0220.1cc393.0085.GAE@google.com>
Subject: [syzbot] [overlayfs?] KASAN: slab-out-of-bounds Read in ovl_inode_upper
From: syzbot <syzbot+8d1206605b05ca9a0e6a@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    85a2dd7d7c81 Add linux-next specific files for 20241125
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10b52778580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45719eec4c74e6ba
dashboard link: https://syzkaller.appspot.com/bug?extid=8d1206605b05ca9a0e6a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b46530580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1578dee8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5422dd6ada68/disk-85a2dd7d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3a382ed71d3a/vmlinux-85a2dd7d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9b4d03eb0da3/bzImage-85a2dd7d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/29b16c7eaa78/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8d1206605b05ca9a0e6a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in ovl_upperdentry_dereference fs/overlayfs/ovl_entry.h:195 [inline]
BUG: KASAN: slab-out-of-bounds in ovl_i_dentry_upper fs/overlayfs/util.c:366 [inline]
BUG: KASAN: slab-out-of-bounds in ovl_inode_upper+0x36/0x80 fs/overlayfs/util.c:386
Read of size 8 at addr ffff88807df938e0 by task syz-executor150/5827

CPU: 0 UID: 0 PID: 5827 Comm: syz-executor150 Not tainted 6.12.0-next-20241125-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 ovl_upperdentry_dereference fs/overlayfs/ovl_entry.h:195 [inline]
 ovl_i_dentry_upper fs/overlayfs/util.c:366 [inline]
 ovl_inode_upper+0x36/0x80 fs/overlayfs/util.c:386
 ovl_file_accessed+0x7e/0x370 fs/overlayfs/file.c:307
 backing_file_mmap+0x1f8/0x260 fs/backing-file.c:345
 ovl_mmap+0x1c9/0x220 fs/overlayfs/file.c:487
 call_mmap include/linux/fs.h:2183 [inline]
 mmap_file mm/internal.h:124 [inline]
 __mmap_new_file_vma mm/vma.c:2291 [inline]
 __mmap_new_vma mm/vma.c:2355 [inline]
 __mmap_region+0x2204/0x2cd0 mm/vma.c:2456
 mmap_region+0x1d0/0x2c0 mm/mmap.c:1347
 do_mmap+0x8f0/0x1000 mm/mmap.c:496
 vm_mmap_pgoff+0x214/0x430 mm/util.c:580
 ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:542
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb229019739
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffdd8656a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007fb229019739
RDX: 0000000000000000 RSI: 0000000000004000 RDI: 0000000020ffc000
RBP: 00007fb22908d610 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000012 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffdd865878 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 5827:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 kmem_cache_alloc_lru_noprof+0x1dd/0x390 mm/slub.c:4172
 nilfs_alloc_inode+0x2e/0x110 fs/nilfs2/super.c:158
 alloc_inode+0x65/0x1a0 fs/inode.c:336
 iget5_locked+0x4a/0xa0 fs/inode.c:1404
 nilfs_iget_locked fs/nilfs2/inode.c:535 [inline]
 nilfs_iget+0x130/0x810 fs/nilfs2/inode.c:544
 nilfs_lookup+0x198/0x210 fs/nilfs2/namei.c:69
 __lookup_slow+0x28c/0x3f0 fs/namei.c:1791
 lookup_slow fs/namei.c:1808 [inline]
 lookup_one_unlocked+0x1a4/0x290 fs/namei.c:2966
 ovl_lookup_positive_unlocked fs/overlayfs/namei.c:210 [inline]
 ovl_lookup_single+0x200/0xbd0 fs/overlayfs/namei.c:240
 ovl_lookup_layer+0x417/0x510 fs/overlayfs/namei.c:333
 ovl_lookup+0xcf7/0x2a60 fs/overlayfs/namei.c:1124
 lookup_open fs/namei.c:3627 [inline]
 open_last_lookups fs/namei.c:3748 [inline]
 path_openat+0x11a7/0x3590 fs/namei.c:3984
 do_filp_open+0x27f/0x4e0 fs/namei.c:4014
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_open fs/open.c:1425 [inline]
 __se_sys_open fs/open.c:1421 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1421
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807df93300
 which belongs to the cache nilfs2_inode_cache of size 1504
The buggy address is located 0 bytes to the right of
 allocated 1504-byte region [ffff88807df93300, ffff88807df938e0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7df90
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801f711140 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080140014 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801f711140 dead000000000122 0000000000000000
head: 0000000000000000 0000000080140014 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea0001f7e401 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0xd2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_RECLAIMABLE), pid 5827, tgid 5827 (syz-executor150), ts 58768101635, free_ts 15530782696
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3725/0x3870 mm/page_alloc.c:3510
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4787
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2408
 allocate_slab+0x5a/0x2f0 mm/slub.c:2574
 new_slab mm/slub.c:2627 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3815
 __slab_alloc+0x58/0xa0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 kmem_cache_alloc_lru_noprof+0x26c/0x390 mm/slub.c:4172
 nilfs_alloc_inode+0x2e/0x110 fs/nilfs2/super.c:158
 alloc_inode+0x65/0x1a0 fs/inode.c:336
 iget5_locked+0x4a/0xa0 fs/inode.c:1404
 nilfs_iget_locked+0x113/0x160 fs/nilfs2/inode.c:535
 nilfs_dat_read+0xc3/0x320 fs/nilfs2/dat.c:511
 nilfs_load_super_root fs/nilfs2/the_nilfs.c:118 [inline]
 load_nilfs+0x579/0x1090 fs/nilfs2/the_nilfs.c:299
 nilfs_fill_super+0x31e/0x720 fs/nilfs2/super.c:1067
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xdf9/0x1140 mm/page_alloc.c:2693
 free_contig_range+0x152/0x550 mm/page_alloc.c:6666
 destroy_args+0x92/0x910 mm/debug_vm_pgtable.c:1017
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1397
 do_one_initcall+0x248/0x880 init/main.c:1266
 do_initcall_level+0x157/0x210 init/main.c:1328
 do_initcalls+0x3f/0x80 init/main.c:1344
 kernel_init_freeable+0x435/0x5d0 init/main.c:1577
 kernel_init+0x1d/0x2b0 init/main.c:1466
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff88807df93780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807df93800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88807df93880: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
                                                       ^
 ffff88807df93900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807df93980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

