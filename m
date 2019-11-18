Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1493DFFD06
	for <lists+linux-unionfs@lfdr.de>; Mon, 18 Nov 2019 03:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfKRCOC (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 17 Nov 2019 21:14:02 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:35312 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfKRCOC (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 17 Nov 2019 21:14:02 -0500
Received: by mail-io1-f71.google.com with SMTP id h7so12380417ioh.2
        for <linux-unionfs@vger.kernel.org>; Sun, 17 Nov 2019 18:14:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0hJK8rPWOFUddMB0lJimGQDZPQJFXDrAgb0buhY0TvU=;
        b=lMikO+VFzxTkh0K6syJFo+iWvoa4j5Y/FdN+dXfAL2iU9dPWz1j7OiatfSqJfUk9De
         wWDKptn3bbZkrcwzG+vwZxK13A1977GuGiR0XYJ/OGsux02l5U/fyBHUX3FZNolbRLlQ
         tjCUsIRrCe7zxh3Jq7XvJYXRsR9mndyQWCAqGV9Rvlf+rFCshR2E1bZC3kAI9hmOwlJm
         4Rw/+ky0rkQAvU5l7+CEXBsxo3qJCq6zJnyJPWWSQ86smw3vBL9AFTJpATK7jhxwR3ZF
         lICzrx/iwE/5KJLqdE8ed0CwVsxOJhRZdkr3edbNn6l1ZyAzfUjZnxZRvcWKkTzjidfP
         xxhg==
X-Gm-Message-State: APjAAAXEE4cswGheNh2/KKtKDXm7Ol5woJ8PvBuO8rqYXl0KKNoeDN8e
        3rx7gclXc0jdfLLcExyqFF97CEI2O8xvbhDqz/NjIYvHy5rx
X-Google-Smtp-Source: APXvYqwZhRrNpOcp3K1jSna3NVMQ3Y9eKDGXT7VjA9/ZYXXiCNJMlXd57obKMz7tPT7gqZ5PakMzS/X78yIoSTTNHjwPUi2z8UDS
MIME-Version: 1.0
X-Received: by 2002:a92:660e:: with SMTP id a14mr13677440ilc.235.1574043241343;
 Sun, 17 Nov 2019 18:14:01 -0800 (PST)
Date:   Sun, 17 Nov 2019 18:14:01 -0800
In-Reply-To: <00000000000044cbf80576baaecd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042f41905979580cc@google.com>
Subject: Re: possible deadlock in path_openat
From:   syzbot <syzbot+a55ccfc8a853d3cff213@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, ast@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

syzbot has bisected this bug to:

commit 8e54cadab447dae779f80f79c87cbeaea9594f60
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sun Nov 27 01:05:42 2016 +0000

     fix default_file_splice_read()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=108f4416e00000
start commit:   6d906f99 Merge tag 'arm64-fixes' of git://git.kernel.org/p..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=128f4416e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=148f4416e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
dashboard link: https://syzkaller.appspot.com/bug?extid=a55ccfc8a853d3cff213
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101767b7200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c15013200000

Reported-by: syzbot+a55ccfc8a853d3cff213@syzkaller.appspotmail.com
Fixes: 8e54cadab447 ("fix default_file_splice_read()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
