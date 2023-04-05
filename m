Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4B06D7763
	for <lists+linux-unionfs@lfdr.de>; Wed,  5 Apr 2023 10:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbjDEIzw (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 5 Apr 2023 04:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbjDEIzu (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 5 Apr 2023 04:55:50 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4184030F8
        for <linux-unionfs@vger.kernel.org>; Wed,  5 Apr 2023 01:55:48 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id i189-20020a6b3bc6000000b00758a1ed99c2so21601127ioa.1
        for <linux-unionfs@vger.kernel.org>; Wed, 05 Apr 2023 01:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680684947; x=1683276947;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gW9o6KUk5mM/VZpzbUF/+r0YpaUIjfVWfRZvrqXmET0=;
        b=w7svA0Hsfa+UURe3Gt850+AjxAn9RcCLfH5FM9PSwsSEoWTh+Ie57kyYFkdDDSdwTv
         mpqeoYdeen6tclhfS3v6hLPBhlnd0iyl4J3D3K/5an5SIy+/5Bjdnua6vDLsDfPthbIM
         itnVDeJFRtZ+Da0NgUfjLhcv1MG7OZ9RwwPrNy0ISiJfGGQJchonK8BOVOUjFkXOkLZR
         fNywLzS/DiEEtZ6YhTeoa1sQVvD8y1xSxWpL+yDwOd2bXN/MJIm8MAlumxB/v2rbIDIz
         LMRe0g79HejxOVrP24sPiYBUp9Ug3ly/awRVVMwDoOxGYCMBe5c/ZLNR4yCif214HXzM
         LVBA==
X-Gm-Message-State: AAQBX9e8S6FoK5wKU2Ym9u6eUQvB+lSYgd3NZtI8T6at0+ZzzseU/aoh
        GIXL7l1dfMI6UEYi2peTa9/WsLYO26LwSbqYRiLRtMIkEWcb
X-Google-Smtp-Source: AKy350atZsR/b5sleI6/xqFnXJtAo9+T2biISUU0v4Uh7Q8dqJLG414PZJ4xP/gkMcG6kCKaWHaCmXz7Hj2Uq6AIUvo2bLyT7LJT
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b21:b0:326:1bf1:234 with SMTP id
 e1-20020a056e020b2100b003261bf10234mr3330838ilu.3.1680684947582; Wed, 05 Apr
 2023 01:55:47 -0700 (PDT)
Date:   Wed, 05 Apr 2023 01:55:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047b8d005f892f5f0@google.com>
Subject: [syzbot] Monthly overlayfs report
From:   syzbot <syzbot+listf458cf6e943ee253729f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hello overlayfs maintainers/developers,

This is a 30-day syzbot report for the overlayfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/overlayfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 11 issues are still open and 17 have been fixed so far.

Some of the still happening issues:

Crashes Repro Title
785     Yes   possible deadlock in ovl_maybe_copy_up
              https://syzkaller.appspot.com/bug?extid=c18f2f6a7b08c51e3025
442     Yes   possible deadlock in mnt_want_write (2)
              https://syzkaller.appspot.com/bug?extid=b42fe626038981fb7bfa
24      Yes   BUG: unable to handle kernel paging request in take_dentry_name_snapshot
              https://syzkaller.appspot.com/bug?extid=90392eaed540afcc8fc3
11      Yes   WARNING: locking bug in take_dentry_name_snapshot
              https://syzkaller.appspot.com/bug?extid=5a195884ee3ad761db4e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.
