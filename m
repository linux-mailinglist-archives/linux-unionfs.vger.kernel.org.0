Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B136313C86
	for <lists+linux-unionfs@lfdr.de>; Mon,  8 Feb 2021 19:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbhBHSHg (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 8 Feb 2021 13:07:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:46604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235239AbhBHSDk (ORCPT <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 8 Feb 2021 13:03:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A53064EE8;
        Mon,  8 Feb 2021 17:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612807192;
        bh=egN8kW5Z55ckGja4eJwQaEtGjHmBhaSTC0Nr0vjE+as=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S5ING7HJa4ZByhVgPsa0RMYaZqke4AtSq+9gKMQvXeg0TRARY9vc4SixZxoIa3004
         CUAj3cT2kdbZjZkufKW1HIc8Fc3QKEZ8CimL8xZQLadiXMclHyl62Mx2prKybK8rq3
         4tIFp0PTcDDMxF0NQYcRSvBVz53vELHweYOacAAcYYFLhRqBa+vUe64SIz0XZTgGfZ
         biq2Joth9efQGCAY3RZs7XuedtZbRWDzJqLKGYeJGZgHM6VK0/9VwfKbGFbEIfGw0M
         5lLJkOS99ysSMePCi7D5yNOJFjkefNRpiW+EdWgN6eMek5xBLwMce7wPfRoLgNp+Zz
         3/rWEo+olO9kQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sasha Levin <sashal@kernel.org>, linux-unionfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 4/9] ovl: perform vfs_getxattr() with mounter creds
Date:   Mon,  8 Feb 2021 12:59:41 -0500
Message-Id: <20210208175946.2092374-4-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210208175946.2092374-1-sashal@kernel.org>
References: <20210208175946.2092374-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit 554677b97257b0b69378bd74e521edb7e94769ff ]

The vfs_getxattr() in ovl_xattr_set() is used to check whether an xattr
exist on a lower layer file that is to be removed.  If the xattr does not
exist, then no need to copy up the file.

This call of vfs_getxattr() wasn't wrapped in credential override, and this
is probably okay.  But for consitency wrap this instance as well.

Reported-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 30a1c7fc8c75c..ac6efac119fb9 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -216,7 +216,9 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 		goto out;
 
 	if (!value && !upperdentry) {
+		old_cred = ovl_override_creds(dentry->d_sb);
 		err = vfs_getxattr(realdentry, name, NULL, 0);
+		revert_creds(old_cred);
 		if (err < 0)
 			goto out_drop_write;
 	}
-- 
2.27.0

