Return-Path: <linux-unionfs+bounces-1129-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCD79D3C8F
	for <lists+linux-unionfs@lfdr.de>; Wed, 20 Nov 2024 14:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BAF4B2291E
	for <lists+linux-unionfs@lfdr.de>; Wed, 20 Nov 2024 13:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266BE19C542;
	Wed, 20 Nov 2024 13:31:29 +0000 (UTC)
X-Original-To: linux-unionfs@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F559200CB
	for <linux-unionfs@vger.kernel.org>; Wed, 20 Nov 2024 13:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732109489; cv=none; b=M7gcpNpNBURBm6FuroM4hGek2QF+7VsN/NzyQHsWP2QV1YabVCTaoEID8y4OuzNxaRgotTtcUqvSMuUMkM3gie/mfz5XRz+FnJ9KcV0fR159KIttI8ceBR45q0gD9e/RvZTcX95BXfmmW5sJ7SV0w2/qQtl80cYOrrKjOn4IJiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732109489; c=relaxed/simple;
	bh=MU57nMisx/6DEWDRufdi0/bsONzbPtV2fDCpEnmn7FU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KI2d9IG0WCoP31ghuS+IfIeh/PHJrOHex4kUeAkLKWbgnyIq31enb6H8Oqcq4wWl6f4oA0i2KR7oBYZJJw3Oriiwt5CmUjHrNCDAfeYO2nYbSH7kTTkp2z+8o0h5WXsj4f1qLpUSFqSi9mE4MhjgK66t8qlyF8kbHbsYVyeRcd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83aed4f24a9so438589039f.0
        for <linux-unionfs@vger.kernel.org>; Wed, 20 Nov 2024 05:31:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732109486; x=1732714286;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/BK3spmsTuxEzWm9e/Iu6YJGilsWDZvSEFFz5TUplE=;
        b=jVioXC0cWcosIc9uTnqVWnGZID7c3rojj6IK1MkUKB/fX0V7Wf/o4lwn9NL8+HGWKT
         1r24eTDZbZHIdmjeeS5SRkzyRazu3GUTfwJYXzcNYY6HjyiDWaUdfrw/UZz41NXvqIDO
         97zvU6+svBHGFvYdmdFGtE++8/066jkhBNRTTjNyFfTOyvI9TBelJVkC5UOyiDTDV6x5
         oOMTPvnJ1UfFszZLvhVsGRwrltUtBGkL2GpJNEP8cOn1l+dM6Y/Z8eDkY4vFxn9r7O7U
         7+7mlpmhslj+07DZNB6HwL8DV0SXrwChD+5UXutbfBGhcpz4kBWSm2KoXZXGrSp6zrb9
         AFag==
X-Forwarded-Encrypted: i=1; AJvYcCXbyWpu+2sD6qIuhFZkrN+6EV7DbNmK7n9bpEFiqiCcO5jpCNwVpFHAELL+bjoYqMJ+FezMFnBhKBF2qrJM@vger.kernel.org
X-Gm-Message-State: AOJu0YwOJJ4w1p4+SGyAAHO4I6yN00lzt5iIkPXPrHvJf0OrbGFEGPFy
	tsJd12AYOHPhVC3H1nfzaqWlmgcWVxE+vg0yCsuaYgD7zvwqynIXvNbmz3S8oiZN52ZsE88tAW7
	z42XRRZnNK/5PfTTo1DABx9achGMekFk2ZoB07D2U3oHLfGOjtECF/QY=
X-Google-Smtp-Source: AGHT+IGNkM4FXQLC52rJnBBrgYZ9hMSrVqlzi9r0gSGenJtqsEGtG1gV/hn0Rixsya44TSqnTcavRAE0WGshWuFspPKsCC6vq7Of
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3104:b0:3a7:8cdd:c08d with SMTP id
 e9e14a558f8ab-3a78cddc108mr12190545ab.4.1732109486630; Wed, 20 Nov 2024
 05:31:26 -0800 (PST)
Date: Wed, 20 Nov 2024 05:31:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673de4ae.050a0220.3c9d61.0162.GAE@google.com>
Subject: [syzbot] Monthly overlayfs report (Nov 2024)
From: syzbot <syzbot+list777de70fa5f0bf9080a5@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello overlayfs maintainers/developers,

This is a 31-day syzbot report for the overlayfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/overlayfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 28 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 130     Yes   BUG: unable to handle kernel NULL pointer dereference in __lookup_slow (3)
                  https://syzkaller.appspot.com/bug?extid=94891a5155abdf6821b7
<2> 4       Yes   WARNING in ovl_encode_real_fh
                  https://syzkaller.appspot.com/bug?extid=ec07f6f5ce62b858579f
<3> 2       No    possible deadlock in pipe_lock (6)
                  https://syzkaller.appspot.com/bug?extid=603e6f91a1f6c5af8c02

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

