Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C719E49EA
	for <lists+linux-unionfs@lfdr.de>; Fri, 25 Oct 2019 13:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438603AbfJYL3Y (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 25 Oct 2019 07:29:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21533 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726539AbfJYL3Y (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 25 Oct 2019 07:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572002963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Tawb+nccujPimrWiHS9Aa32LfRsfrtEJbJYur7m9f88=;
        b=Ja2wLQeWVQJrin19JM6+yPFiicY0vegf5CZo5wOP8muVf8kf7gf/9QrSqltn47Bm28g3Si
        tqiQb6AUbcwifnrwrQqGp09meZdoAZ3WfDiSfpACz/bEyggZ3p4P4vGPCRtLtW4Fn2/ASn
        VZm1KyIeLl43sJtkJ/xezO5TXR3em/Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-BM2qPMqDOeWAuOzIP9fkJQ-1; Fri, 25 Oct 2019 07:29:22 -0400
Received: by mail-wm1-f71.google.com with SMTP id m16so785901wmg.8
        for <linux-unionfs@vger.kernel.org>; Fri, 25 Oct 2019 04:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+LV2TveLTnx1fiN/bkmnJtZ0B+hWPbHsr/HLlAeKi1Y=;
        b=hHkLZgtRhO/qAAeGMISDgwr4/qVy5rSes+7ytJUlN6/s/yi8JNVNrcBoebgnWWHGKn
         WFAz6sYs5I9Z73FctHLM8wYOcv/ZdwoUAtn4BhB9KWG2qr8HNRGVaxAL6cSnOELJ4DQL
         LG7L21dDhFzH2Rw/3wQBSYivnwkQNiZsyxon7AifeaDFyCKjrCqVnyxhjaVOtbqwd36U
         ZeAA3tQYHZoIfzD/PUkWYUKBW2xrUPqX61CMyRdBsZ1anVIe4TXIJ2Bt8cPGDdr+fcjo
         Z/A//8N1TsLBBFXoV5U9qLiCIcEaCexOnMrhw8LQb8EACV5GbLx4By9xAmszw93y0z/v
         QhLg==
X-Gm-Message-State: APjAAAWY4S2R2ksWSbhQ9O5HRl4V+FqH7dhgz7+L9nAzbiLgQq5JzOo1
        HCv+dYoJ2/E1VUP+7nplyqFPK6stIhUjit1d9xcij1fwg8pjsckrNkqz1D/27gwnCBbj4PBr8M2
        uscNEZXGpB/KFckJeOCVZ/j3LjA==
X-Received: by 2002:adf:b1d1:: with SMTP id r17mr2546009wra.201.1572002960743;
        Fri, 25 Oct 2019 04:29:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzq6KqqiDo1k9UizmtJKHpklyWh4CoC38j2QsAc29ZM9Kley/036A6fB9ibAZsda5ZgBfW13A==
X-Received: by 2002:adf:b1d1:: with SMTP id r17mr2545995wra.201.1572002960542;
        Fri, 25 Oct 2019 04:29:20 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (185-79-95-246.pool.digikabel.hu. [185.79.95.246])
        by smtp.gmail.com with ESMTPSA id l18sm3974080wrn.48.2019.10.25.04.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 04:29:19 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/5] allow unprivileged overlay mounts
Date:   Fri, 25 Oct 2019 13:29:12 +0200
Message-Id: <20191025112917.22518-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: BM2qPMqDOeWAuOzIP9fkJQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi Eric,

Can you please have a look at this patchset?

The most interesting one is the last oneliner adding FS_USERNS_MOUNT;
whether I'm correct in stating that this isn't going to introduce any
holes, or not...

Thanks,
Miklos

---
Miklos Szeredi (5):
  ovl: document permission model
  ovl: ignore failure to copy up unknown xattrs
  vfs: allow unprivileged whiteout creation
  ovl: user xattr
  ovl: unprivieged mounts

 Documentation/filesystems/overlayfs.txt | 44 +++++++++++++
 fs/char_dev.c                           |  3 +
 fs/namei.c                              | 17 ++---
 fs/overlayfs/copy_up.c                  | 34 +++++++---
 fs/overlayfs/dir.c                      |  2 +-
 fs/overlayfs/export.c                   |  2 +-
 fs/overlayfs/inode.c                    | 39 ++++++------
 fs/overlayfs/namei.c                    | 56 +++++++++--------
 fs/overlayfs/overlayfs.h                | 81 +++++++++++++++---------
 fs/overlayfs/ovl_entry.h                |  1 +
 fs/overlayfs/readdir.c                  |  5 +-
 fs/overlayfs/super.c                    | 53 +++++++++++-----
 fs/overlayfs/util.c                     | 82 +++++++++++++++++++++----
 include/linux/device_cgroup.h           |  3 +
 14 files changed, 298 insertions(+), 124 deletions(-)

--=20
2.21.0

