Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 493523D1C7
	for <lists+linux-unionfs@lfdr.de>; Tue, 11 Jun 2019 18:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391877AbfFKQIs (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 11 Jun 2019 12:08:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36511 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391873AbfFKQIr (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 11 Jun 2019 12:08:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id u8so3558945wmm.1;
        Tue, 11 Jun 2019 09:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JbTb7II0Y+dG5GeTrOm9MNVRZtehoJwHZOh9kblNSSg=;
        b=uog9bI+RkrcFwuXJ53DmiN6BS52k3YF66MMMlH91xNkSyq3KyiX1E+lk4sckKjV6cF
         DiHceFcoX9wbIBY6qPYwcWiYWOsxeVg2lJcQtOAm+OgimKlp3a6ac/rpBTgbnA1qC1xk
         ZgYEbiGvp4SWuTZ8dC8V35eqEia1lgoTdSS5xFuzTgzHUxiJHkJIq0fUdiB3q2eV+Tag
         8F/sj8N/4liQBtZR7Xy3Z4jHalIH1ua3YgPiHDNnD9dXV3YZevWeI39hFBbuDmm4znB1
         gIZzjL6O1SEGlCLAVaj/LEpAQc2qc3F+tXqdTlIMNOkOiYTXOz7o2HYutFLWs2HaKN4W
         /qJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JbTb7II0Y+dG5GeTrOm9MNVRZtehoJwHZOh9kblNSSg=;
        b=ojme2edgliiPuHqjrGW8Z4jBnN0cGJvxt4qXBPIW97DsV8CwIvIjvlE2Mju2taxR8E
         4Ru16jXNTCzKz8rOQ3W3MrLCjVgon0LrfND6Kis6NRTEv6GpOg2lT02Kt2Z9T99qOj19
         mFY5Jgb1uatgfp+NKhnXZo9gpmHxqM2y2ALrP9lNndFMmrb4LA48jGdj1mmH47Gy7vvT
         6iY1oTPjqROU6UhU28FKFQt/l7DJ0QVrvQIOPQ6c4LJR6LWrQeVwjNbJwR6eZGKj2k6u
         QYmI3DnBZzNxt7a/ZrmWWJ7WZjdZ+3MMHzb6jPIYvUxLC6sIxLUl+Rcrk8nHZcl8IYXF
         SHsA==
X-Gm-Message-State: APjAAAU3xRhRUIjqBD9ouxXMvxUsdYsRMbZARu+443UVMRnkfC7OA4F6
        IK8unGOPMAVGnR97udVNsqM1C3V3
X-Google-Smtp-Source: APXvYqx37hEsNnm4ZgRrGEZLet+fUlbL20679g5crE2bijbCBYlYChuvoSWjzreA+1rEr3RA791oSA==
X-Received: by 2002:a1c:1f06:: with SMTP id f6mr19159726wmf.60.1560269325542;
        Tue, 11 Jun 2019 09:08:45 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id u11sm10942873wrn.1.2019.06.11.09.08.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 09:08:44 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH 0/3] Improved FS_IOC_FSSETXATTR tests
Date:   Tue, 11 Jun 2019 19:08:36 +0300
Message-Id: <20190611160839.14777-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Eryu,

Overlayfs gained support for FS_IOC_FSSETXATTR ioctl in v5.2-rc4
with buggy capability check. The fix is trivial so it should land
upstream soon.

This series adds a generic test to cover the bug in overlayfs v5.2-rc4.
It also adds a proper _require directive to test filesystem support
for FS_IOC_FSSETXATTR and let the tests that use this ioctl require
filesystem support for it.

The only existing generic test that needed this requirement is the
recently added generic/553 copy_range immutable file test. When run on
overlayfs over xfs/ext4/btrfs, generic/553 would fail instead of _notrun
with kernel v5.2-rc3.

But the requirement fix is not only for overlayfs, other filesystems
that support FS_IOC_SETFLAGS but not FS_IOC_FSSETXATTR (e.g. ext2),
need those fixes to _notrun generic/553.

Thanks,
Amir.


Amir Goldstein (3):
  fstests: print out xfs_io parameter when command fails
  fstests: check for filesystem FS_IOC_FSSETXATTR support
  generic: check CAP_LINUX_IMMUTABLE capability with FS_IOC_FSSETXATTR

 common/rc                    | 30 ++++++++++-----
 doc/requirement-checking.txt |  2 +-
 tests/generic/553            |  3 +-
 tests/generic/555            | 74 ++++++++++++++++++++++++++++++++++++
 tests/generic/555.out        |  9 +++++
 tests/generic/group          |  1 +
 tests/xfs/260                |  2 +-
 tests/xfs/431                |  2 +-
 8 files changed, 108 insertions(+), 15 deletions(-)
 create mode 100755 tests/generic/555
 create mode 100644 tests/generic/555.out

-- 
2.17.1

