Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F768114AAC
	for <lists+linux-unionfs@lfdr.de>; Fri,  6 Dec 2019 02:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfLFByD (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 5 Dec 2019 20:54:03 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:44292 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfLFByB (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 5 Dec 2019 20:54:01 -0500
Received: by mail-io1-f71.google.com with SMTP id t17so3739835ioi.11
        for <linux-unionfs@vger.kernel.org>; Thu, 05 Dec 2019 17:54:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=rAeCsgZxV9UJGkBQ4eWnQ9S3cKiAG0istSYvhHhfEbE=;
        b=LOfbOzhsVirpjN0TOfNEKXNDbIoJFdcRxNS0x6v13qGFgxkyRiG9cVtVq4z3XWuQ0P
         I89ELERRQ5eNSZXPrTXJaKu8SJyn5twYmGar+8099F2BVdFE4bprpV2HLbh6C3xEWxWS
         zA5V10AaiyVOXiXbfcUGFwu669Gz8tWPa6d1sVqXzShtRGbauggyAtesmq9cNeDSjeD5
         Bm9WX/SW9XKbytU4G3R6rn4ErPkolqzpYjxexW6G0l7xV51I7htNqxOkfxqVJ6m8rHuz
         BV9DHMIokBA5FjMIAWsftp9k9anJAIpzMHsH9Xfm4yAO2UTs6twzEKgjhvGZR+OTQoCt
         6Dew==
X-Gm-Message-State: APjAAAVYlJ3zQmWsJFV2+pHv2VSqcocTnrgMAfSbR5W0hTuPOK3VgFgm
        Jwu7+qAVMZMD6nZapSDxvCIV0kIdvaPYHx3ZzIlatfbmG8hl
X-Google-Smtp-Source: APXvYqzsPCD57qboZKu4afU8AjADTn/f/SbgP9h50QEUqO4V8Qa1IqsWP4i1pyRvC9AmRjLOlMpOdVS7zTYOkMfgGrm4fe23QH+N
MIME-Version: 1.0
X-Received: by 2002:a92:844d:: with SMTP id l74mr12309671ild.16.1575597240974;
 Thu, 05 Dec 2019 17:54:00 -0800 (PST)
Date:   Thu, 05 Dec 2019 17:54:00 -0800
In-Reply-To: <0000000000002492cc0587d58ed8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db84550598ff519f@google.com>
Subject: Re: WARNING in ovl_rename
From:   syzbot <syzbot+bb1836a212e69f8e201a@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        mszeredi@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 146d62e5a5867fbf84490d82455718bfb10fe824
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Thu Apr 18 14:42:08 2019 +0000

     ovl: detect overlapping layers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=138841dae00000
start commit:   037904a2 Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a42d110b47dd6b36
dashboard link: https://syzkaller.appspot.com/bug?extid=bb1836a212e69f8e201a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ba097ca00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10be1ceca00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: ovl: detect overlapping layers

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
