Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EF91FE661
	for <lists+linux-unionfs@lfdr.de>; Thu, 18 Jun 2020 04:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgFRCdJ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 17 Jun 2020 22:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729417AbgFRBO6 (ORCPT <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 17 Jun 2020 21:14:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64BCE20EDD;
        Thu, 18 Jun 2020 01:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442898;
        bh=c6VpuJJmM3SJJVJBzIjuWts789Ks6N5gnyM90yPAznw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u1uRglkxkPMK6P0Yk/6hNQGOwysiEeon0XYYuBSX4VTTgcDbFfMTFKhl0a8N1KM4e
         XhtQZjiom3jXDXzl5xPaLDBGNoa0/IInXvAsCyUiExBAopXMP1jnuIGHoFGht1DMlD
         pZLEwuivfp3jRxIKiMTxteGKUwhGss1OVh3IKNb8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-unionfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 319/388] ovl: verify permissions in ovl_path_open()
Date:   Wed, 17 Jun 2020 21:06:56 -0400
Message-Id: <20200618010805.600873-319-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit 56230d956739b9cb1cbde439d76227d77979a04d ]

Check permission before opening a real file.

ovl_path_open() is used by readdir and copy-up routines.

ovl_permission() theoretically already checked copy up permissions, but it
doesn't hurt to re-do these checks during the actual copy-up.

For directory reading ovl_permission() only checks access to topmost
underlying layer.  Readdir on a merged directory accesses layers below the
topmost one as well.  Permission wasn't checked for these layers.

Note: modifying ovl_permission() to perform this check would be far more
complex and hence more bug prone.  The result is less precise permissions
returned in access(2).  If this turns out to be an issue, we can revisit
this bug.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/util.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 36b60788ee47..a0878039332a 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -459,7 +459,32 @@ bool ovl_is_whiteout(struct dentry *dentry)
 
 struct file *ovl_path_open(struct path *path, int flags)
 {
-	return dentry_open(path, flags | O_NOATIME, current_cred());
+	struct inode *inode = d_inode(path->dentry);
+	int err, acc_mode;
+
+	if (flags & ~(O_ACCMODE | O_LARGEFILE))
+		BUG();
+
+	switch (flags & O_ACCMODE) {
+	case O_RDONLY:
+		acc_mode = MAY_READ;
+		break;
+	case O_WRONLY:
+		acc_mode = MAY_WRITE;
+		break;
+	default:
+		BUG();
+	}
+
+	err = inode_permission(inode, acc_mode | MAY_OPEN);
+	if (err)
+		return ERR_PTR(err);
+
+	/* O_NOATIME is an optimization, don't fail if not permitted */
+	if (inode_owner_or_capable(inode))
+		flags |= O_NOATIME;
+
+	return dentry_open(path, flags, current_cred());
 }
 
 /* Caller should hold ovl_inode->lock */
-- 
2.25.1

