Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72A201C438
	for <lists+linux-unionfs@lfdr.de>; Tue, 14 May 2019 09:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfENH4A (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 14 May 2019 03:56:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38859 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfENHz7 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 14 May 2019 03:55:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id f2so1713201wmj.3
        for <linux-unionfs@vger.kernel.org>; Tue, 14 May 2019 00:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=AZcNqe5qvtY4dcuVPf2hIhfe8ZNEonQhM7fP56+pLys=;
        b=azwnJ7Adc4FZ5DZhip+da3lj0FuE4ctMi8uwjjtF6REh0S/xbSWaaWoR3pl2lBJ6c/
         4/AFKediJhhtbToQwNWayxFyhA/SQ1iQO4sPNLbvA78Xll94OM4X3TAwfQNqRThw5/0p
         brF2Ue4q6T7QUBNvraTRt15t+C82uucOVWxmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AZcNqe5qvtY4dcuVPf2hIhfe8ZNEonQhM7fP56+pLys=;
        b=HI6jOeds2JbRbxOIaJMp6xePyR7ibWuEHwPP3BhuusnAyTQv6RfvdCNIu1BAq53lp+
         z8dbrk1rsNEZyn81JyOwXdW7TeKUOtnF8ENryrRtaq8p4aSFGBAawvAwI8LHZxTeodq+
         ffyXrfa7Sym2fsyRDgVYVMdE4PXNABM3CZlv2TZ5xMrnMGbX7GddkDxC9kO9OuXccwoe
         Ily7knnmBz8S4xAVBUBGVg/O1gtOy3KfaV3erZkM2ocqUHh4eJWHS/DMA8EriBaKKU3B
         7jOoMz97EZP9NOgaFwHWJ03VHknrPJditJG/HNp2wJAhN0XHzGABti1l70+VGKOsZwHv
         sqog==
X-Gm-Message-State: APjAAAWQOT8N9gxNkGNkQEXhmlnzri9MQR76fUZgOanM8PJHInNupMwz
        qM80hJrTgxs7i2m/LrV+HIZ5lQ==
X-Google-Smtp-Source: APXvYqzy2E5+GTUUanOar5cUy7aboEwVSs6bEVbybGdEIZoPPQiyThOSHxOHiq40am/MaT6+1a5IrQ==
X-Received: by 2002:a1c:21c1:: with SMTP id h184mr1682103wmh.78.1557820558015;
        Tue, 14 May 2019 00:55:58 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (217-197-180-204.pool.digikabel.hu. [217.197.180.204])
        by smtp.gmail.com with ESMTPSA id t6sm2302733wmt.8.2019.05.14.00.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 00:55:57 -0700 (PDT)
Date:   Tue, 14 May 2019 09:55:55 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs update for 5.2
Message-ID: <20190514075555.GB7850@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.2

Just bug fixes in this small update.

Thanks,
Miklos

---
Amir Goldstein (4):
      ovl: fix missing upper fs freeze protection on copy up for ioctl
      ovl: support stacked SEEK_HOLE/SEEK_DATA
      ovl: do not generate duplicate fsnotify events for "fake" path
      ovl: relax WARN_ON() for overlapping layers use case

Jiufei Xue (1):
      ovl: check the capability before cred overridden

---
 fs/overlayfs/copy_up.c   |   6 +--
 fs/overlayfs/dir.c       |   2 +-
 fs/overlayfs/file.c      | 133 +++++++++++++++++++++++++++++++++++++----------
 fs/overlayfs/inode.c     |   3 +-
 fs/overlayfs/overlayfs.h |   2 +-
 5 files changed, 113 insertions(+), 33 deletions(-)
