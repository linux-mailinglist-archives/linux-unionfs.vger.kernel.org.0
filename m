Return-Path: <linux-unionfs+bounces-761-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B97A909963
	for <lists+linux-unionfs@lfdr.de>; Sat, 15 Jun 2024 19:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3353A283328
	for <lists+linux-unionfs@lfdr.de>; Sat, 15 Jun 2024 17:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA054F5FB;
	Sat, 15 Jun 2024 17:49:23 +0000 (UTC)
X-Original-To: linux-unionfs@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D6C4965D
	for <linux-unionfs@vger.kernel.org>; Sat, 15 Jun 2024 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718473762; cv=none; b=P9QK3Iyai/+g1ONYM+nRGMaa2erPRD+0eZM4jyphil05EwM1n1AJh1kent+PpixCsHay49g5n+lAPnYjHtqVenh77l7KtOsO52rU5uO++67AXqsQrUk/d2RlkQJoHOm0ODnJehyi6rLndj6gvwnWATAuN0nkJhiSZlXR+wpIW9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718473762; c=relaxed/simple;
	bh=F2Y8xYsdrjSOZp3BZrwFQlCfRppI2jLEnYkfqcrbbX0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eG6XLZKDxJGeen328a68OIFNsSniLRyEcf0EcL437jsikA2PCQ9GNeDn49NBKtuf6Xq25J+u/wRqABnfuuBLE1e2OF7AYxemOwJPUKIr6p9QoBf8hoWCa7YKIX83jvifr391MF/Wt2wf0za50QvYaeClqVDGM1rys2zrPM3Wo9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ebea0e968eso255649639f.3
        for <linux-unionfs@vger.kernel.org>; Sat, 15 Jun 2024 10:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718473761; x=1719078561;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3m+yhIqhD41WwtddUIkZr1hXB+VF5dDQxD68iyhy/10=;
        b=ew0BzE6gRWviR5iRHzp8JbWccDKL44sgfB7pIqUN80ioAvbUz9jS+Tq8IVG4GNQOOj
         5wKV29BOetwtEmsmn++nVT58RMc6uh70IOCU4WoAI5qPhIlR7zzalJIO/ZkeLiiLcA25
         aNcy8y+XCSH1wAzfdUXWjDpSFEKp6HVbDosSxU+Sl/tF2My3tXfFuEKXdaxzgTAY4jcm
         NJUhRcQ67Jue7wokRd9FfBICfdvw+nn4z6Rm81C6atA7+Nzpa3XdHjqbenw5os4BSGHf
         3PY7Wh9vWWSCvSDcgmrA+YAx15rrarAi1tcV/uJRv1bZhCAzDgYZq8YhSSJ0EfGsiJuq
         Xksw==
X-Forwarded-Encrypted: i=1; AJvYcCXqCBlgAZbv8p/78p3Ksm0WCiA4fKfOalDVtkTFV+aymtHd5H2Aug9PnTpMvAjx4i7klw4NOmfwel5eXPtYzjbydqHx8rd6aANvK17Vag==
X-Gm-Message-State: AOJu0YyP2B9zcZKsEB9zO8Z+T8oixSaQDk0gDC4UTPNN9pfWTp8XUXgA
	7qmAYwGJ/pJMhJ0dBNgrc9numiwwrAMWs+9usDPOIyi3WpWu25VUE9gkJfOJEJnW1sSsQmC8SdB
	eWSz+lu4SLz1v4PNCU83hNS0UuGeF7q+zqDMBPbYQV2rNPFuS564YBvo=
X-Google-Smtp-Source: AGHT+IEIsnY8M9xnbm0uV/MxzT83wFTQUT1wNFZVbWDNHIyszyimRD0bwBzDQm4WyqpO/0gIAnkrC/OA3g+RXyG+4RHGfPZZ7ay6
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:258a:b0:488:e34a:5f76 with SMTP id
 8926c6da1cb9f-4b963f947efmr273756173.1.1718473760819; Sat, 15 Jun 2024
 10:49:20 -0700 (PDT)
Date: Sat, 15 Jun 2024 10:49:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011db0b061af15a3c@google.com>
Subject: [syzbot] Monthly overlayfs report (Jun 2024)
From: syzbot <syzbot+list316c1d421205de40320d@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello overlayfs maintainers/developers,

This is a 31-day syzbot report for the overlayfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/overlayfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 26 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 21      Yes   BUG: unable to handle kernel NULL pointer dereference in __lookup_slow (3)
                  https://syzkaller.appspot.com/bug?extid=94891a5155abdf6821b7
<2> 7       No    possible deadlock in ovl_copy_up_start (4)
                  https://syzkaller.appspot.com/bug?extid=6d34d0b636fea8b593eb
<3> 4       No    KASAN: slab-use-after-free Read in ovl_dentry_update_reval
                  https://syzkaller.appspot.com/bug?extid=316db8a1191938280eb6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

