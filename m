Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C993E7B78BF
	for <lists+linux-unionfs@lfdr.de>; Wed,  4 Oct 2023 09:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241529AbjJDHay (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 4 Oct 2023 03:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241479AbjJDHay (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 4 Oct 2023 03:30:54 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEE7A7
        for <linux-unionfs@vger.kernel.org>; Wed,  4 Oct 2023 00:30:49 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6c4deb5c9e3so768445a34.0
        for <linux-unionfs@vger.kernel.org>; Wed, 04 Oct 2023 00:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696404649; x=1697009449;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5QaEuhNUG2u0gjcE5rRLCa9ZuWdzsZH122JJe8SJznI=;
        b=LW5NgC1bQTubfTnidfQm24a+kEfjvoci4razqH9J3he/W08+S7THBEjMNU4Zwo9wcW
         9Ra0FGsET2wxtywWq48tQ+yJtBNlpCB9aoz26XgZiIYULJzXlVrhZZJUrAOwM8d8jgCo
         kXZtmBmL5C25/7yic+rIP82JItyZI3rV2MQwNGdTV+sTM0IWaUPNud/i3Io5zNTqbILV
         zuS9yNQA3hFwgNWl262s/BjjIoJyVHu89Igyl2mioizHWjgW5DegZjVLg29DfDV9Zwdc
         EpvXwD+jjnRy/Ft5hBle4bQHnjdmfBnB0pHco0TTsXtYHQ3ZIz0YpG4d+9rrfr02tI3c
         18/w==
X-Gm-Message-State: AOJu0YzPkTOkpg2mjAEhfS0kaNJ4CQymwxSRxQYhmKVRlMFZmg1T/E7A
        EpzpjMaL3shgHf4GmuKSxwYOTZQ2ZMY6ywdGe/Ar5nWAZNrc
X-Google-Smtp-Source: AGHT+IHXtCmEy6T+yEflnajIuE0+uj7DiV5VNTPbvc60HO7N2Oomc3w9gTo1e8HdhI1DLL2cDH00OrA0fz9gdr00dDBVv4cPS98n
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1407:b0:6b7:528c:d8bf with SMTP id
 v7-20020a056830140700b006b7528cd8bfmr1594231otp.0.1696404649180; Wed, 04 Oct
 2023 00:30:49 -0700 (PDT)
Date:   Wed, 04 Oct 2023 00:30:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082839e0606defcaf@google.com>
Subject: [syzbot] Monthly overlayfs report (Oct 2023)
From:   syzbot <syzbot+list66be8346f4383d3fe5a9@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hello overlayfs maintainers/developers,

This is a 31-day syzbot report for the overlayfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/overlayfs

During the period, 4 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 18 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 836     Yes   possible deadlock in mnt_want_write (2)
                  https://syzkaller.appspot.com/bug?extid=b42fe626038981fb7bfa
<2> 27      Yes   BUG: unable to handle kernel paging request in take_dentry_name_snapshot
                  https://syzkaller.appspot.com/bug?extid=90392eaed540afcc8fc3
<3> 1       No    possible deadlock in ovl_copy_up_start (2)
                  https://syzkaller.appspot.com/bug?extid=e8628856801e9809216f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
