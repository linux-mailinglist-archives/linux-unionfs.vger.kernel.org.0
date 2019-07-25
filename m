Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3940D7443F
	for <lists+linux-unionfs@lfdr.de>; Thu, 25 Jul 2019 06:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfGYEYB (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 25 Jul 2019 00:24:01 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:37099 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfGYEYB (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 25 Jul 2019 00:24:01 -0400
Received: by mail-io1-f69.google.com with SMTP id v3so53525854ios.4
        for <linux-unionfs@vger.kernel.org>; Wed, 24 Jul 2019 21:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4ykhyuiBMEbxqBLsBHdyDvPAOtbB9E2k09FumAP9piY=;
        b=B5HaP2K6NRIxV4lanaT8I4dAvylXpueGqhsKwqB0FGyujczHmbYDjzSH9iJRBAkxMA
         O5B8TdIwaVV4uEFe3JfncCDV5rhCVQ776Ijn24630UqZ3Drw3hBwX3VNjeL7JF9qplMm
         jzeLyK8kT7DqW4C1V7Y+ELl78rN+6fcHscCJcGch1gBp6jV+LOrDq0+TWM3tuffCT8NG
         XnlHIrYJ72VuQDR5DuhBslkDJfc5dyqQaiYJhAm1o0ilWA5KyzG1/+6+UGyK59vVlab0
         6WerkAYoi/Ua1y3HedFF6dJJeiZkxhCi9FvwN9MRTVzuWqtjZfUEo1I98Dtiw7rPuOgL
         /oxQ==
X-Gm-Message-State: APjAAAVlOZMJBxUJNejiXs4PuEAg8aIQmaHBjUDnt/0uf+Z3hUuE7HG4
        09ZNGNJ3rXP/+WyLTBtAsOkdwtfKh8oa+OxYQE+R6pJFqj5S
X-Google-Smtp-Source: APXvYqzisP9svwAdUk2M7vpsY1nwZNJ9MmjI4tHYq0ELgBH3s/kK/fffQN/IDt9aWlEkMTECMVVjYMhh99FscjT9fYsgt99Ef1Bm
MIME-Version: 1.0
X-Received: by 2002:a5d:94d0:: with SMTP id y16mr43188529ior.123.1564028640346;
 Wed, 24 Jul 2019 21:24:00 -0700 (PDT)
Date:   Wed, 24 Jul 2019 21:24:00 -0700
In-Reply-To: <0000000000004a3a63058e722b94@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086c732058e79cb59@google.com>
Subject: Re: WARNING in ovl_real_fdget_meta
From:   syzbot <syzbot+032bc63605089a199d30@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

syzbot has bisected this bug to:

commit 387e3746d01c34457d6a73688acd90428725070b
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Fri Jun 7 14:24:38 2019 +0000

     locks: eliminate false positive conflicts for write lease

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a79594600000
start commit:   c6dd78fc Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17a79594600000
console output: https://syzkaller.appspot.com/x/log.txt?x=13a79594600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c8985c08e1f9727
dashboard link: https://syzkaller.appspot.com/bug?extid=032bc63605089a199d30
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15855334600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fcc4c8600000

Reported-by: syzbot+032bc63605089a199d30@syzkaller.appspotmail.com
Fixes: 387e3746d01c ("locks: eliminate false positive conflicts for write  
lease")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
