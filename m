Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4234128D2E
	for <lists+linux-unionfs@lfdr.de>; Sun, 22 Dec 2019 09:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfLVIIL (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 22 Dec 2019 03:08:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36046 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfLVIIK (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 22 Dec 2019 03:08:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so13491066wru.3
        for <linux-unionfs@vger.kernel.org>; Sun, 22 Dec 2019 00:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CHe9o2QVpcRRl3sMNccipZ3M1YbJ9oMbDOWrsT+UC44=;
        b=GJMi9G3Vn71muvyl96eOlW/VyxhG/nZ0aGSBe5Jffk1Y4BmMQ2G3KeLrcMk0nhxu19
         h3RkYkRE+YJiW0UlTnjyHW9in2UahDlcQiRXywQosEq+i83XHks8W3cIuL02wzdbE2U0
         8CW2Kwf14uJq4KBJHmsSwG26TKJLru53kh7Px55L7i0rD96Duk0iTHMlcXNvueIPCTEB
         1Vg8IfhrqhYRi2YYcwAweMye3rlLYZnHAqcFtfDTWt7WihsCIIHS8oQ7+lv4VxsTobeh
         A1Rfc7V6CeKvnG4ruSCnuJwnHYtzpWt9y4YHkf1LYrlmJtsVOi1+X5H+VTDFuWJNSw/Z
         uCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CHe9o2QVpcRRl3sMNccipZ3M1YbJ9oMbDOWrsT+UC44=;
        b=Jhg8UGCWZlLIGa963Q3wKJ7KbAcrX5CaY5sJuLJPezmULou8VBMnvOxKCoAADZwyAs
         BFZtOcEpwyd8KhXQ9RDkAsRSANXYgFaHbQc+boR/kkwIJ6ecWtp94reTdP/mhnpQ/3Mf
         Jae4gNYU35J1T6qMGxol73xtovsYJgJ+GNrzvIUyhcdcNMDijJAuoRX5VGym8EhE20Ri
         sOdG6sVjP0XSkU7yWTzgno4v6URWrnMsuAbIdYmJm3nSZY21X+lK2ebsNXXkxrZec0f1
         DnlDIZcPO6YZNJNyX3aP9CBntvPyiCsVrhRP7NcJLpJcAYPy7Sd7bF/3q/4l1Ja9IUUV
         GDoQ==
X-Gm-Message-State: APjAAAW6CwS16SI8IEMrq3WeJziULv6eb1IeEHEhIWKOtpsBSbIp8hIs
        6t7VtG55JdGcMEVcyMLYrvM=
X-Google-Smtp-Source: APXvYqzLX2z06Xb1ajj72IE4R6Qxj8M687bKTsqpBAkbWN6X4GXUdcJ8OZJIa2pypNB0QbzD0Jt3qA==
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr23274894wrw.391.1577002088443;
        Sun, 22 Dec 2019 00:08:08 -0800 (PST)
Received: from localhost.localdomain ([141.226.162.223])
        by smtp.gmail.com with ESMTPSA id g23sm15697141wmk.14.2019.12.22.00.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 00:08:07 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org
Subject: [PATCH v2 0/5] Sort out overlay layers and fs arrays
Date:   Sun, 22 Dec 2019 10:07:54 +0200
Message-Id: <20191222080759.32035-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Miklos,

This is the promised follow up to "fix corner case of non-unique
st_dev;st_ino" that was merged to v5.5-rc2.
The full details are available in the 1st posting of this patch set [1].

These patches have been tested with many different layer configurations
using the tests in [2][3] among them also configurations of multi lower
layer, where some lower fs are on safe fs as upper.

Note that this patchset introduces a change of behavior for overlayfs.
stat(2) on pure upper objects no longer report the real st_dev.
Upper fs is now also assigned a pseudo dev number, like all lower fs
and it is used when reporting stat(2) for pure upper objects as well as
for objects on lower layer which uses the same fs as upper fs.

These patches are also available on my github ovl-layers branch [4].
As mentioned before, I have a follow up series on branch ovl-ino [5]
that fixes another rare case of st_dev;st_ino collision and some more
improvements and fixes to xino. I still did not complete the tests for
that follow up series.

Thanks,
Amir.

Changes since v1:
- "fix corner case of non-unique st_dev;st_ino" already merged
- Replaced maxfsid notation with numfsid


[1] https://marc.info/?l=linux-unionfs&m=157400544101251&w=2
[2] https://github.com/amir73il/xfstests/commits/ovl-nested
[3] https://github.com/amir73il/unionmount-testsuite/commits/ovl-nested
[4] https://github.com/amir73il/linux/commits/ovl-layers
[5] https://github.com/amir73il/linux/commits/ovl-ino

Amir Goldstein (5):
  ovl: generalize the lower_layers[] array
  ovl: simplify ovl_same_sb() helper
  ovl: generalize the lower_fs[] array
  ovl: fix corner case of conflicting lower layer uuid
  ovl: fix corner case of non-constant st_dev;st_ino

 fs/overlayfs/export.c    |   6 +-
 fs/overlayfs/inode.c     |  43 +++++---------
 fs/overlayfs/namei.c     |  10 ++--
 fs/overlayfs/overlayfs.h |  23 ++++++-
 fs/overlayfs/ovl_entry.h |  15 +++--
 fs/overlayfs/readdir.c   |  11 ++--
 fs/overlayfs/super.c     | 125 ++++++++++++++++++++++-----------------
 fs/overlayfs/util.c      |  18 ++----
 8 files changed, 134 insertions(+), 117 deletions(-)

-- 
2.17.1

