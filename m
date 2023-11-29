Return-Path: <linux-unionfs+bounces-30-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3451E7FE263
	for <lists+linux-unionfs@lfdr.de>; Wed, 29 Nov 2023 22:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6332C1C20A8E
	for <lists+linux-unionfs@lfdr.de>; Wed, 29 Nov 2023 21:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1323B1A9;
	Wed, 29 Nov 2023 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAcI0tbP"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8E461FD4;
	Wed, 29 Nov 2023 21:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B13AC4AF5C;
	Wed, 29 Nov 2023 21:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701294658;
	bh=FWlHUtx1il/2WmiearZx3LNeV83xpbRFd1g6e9syKsA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bAcI0tbPjMNanqFp6BahN4cGnqvFSgWqISkhobG33OIwOhGJPetz//8/MOO7EHgQu
	 UcyStUo6qyxEqn4ml/4hm9r2vRvry1p5F1awMPhl4HV9wG2prG6wEhWzt4JgJUiIcK
	 KNXfUMMbtP6Bbb6aejIpouOKBsW2lxMxv+OlBR6zluHjJ8PdJVokhJeuACkKWEIzwD
	 9idToiv8SeabdHCJLwIk5bsnsesbLGE4+HyEno3SvAeyzS2y5taXd2f6HOSQ/D4sDZ
	 FyIJMZfj9zvLjxU5sOdVl/4jkUVemKRXmcBbPYg/Jzge8DNfvTJ3wM3gVmsh6v1zjQ
	 QB3fZltHLvmbQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2910AC10DC1;
	Wed, 29 Nov 2023 21:50:58 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 29 Nov 2023 15:50:33 -0600
Subject: [PATCH 15/16] commoncap: use vfs fscaps interfaces for killpriv
 checks
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-idmap-fscap-refactor-v1-15-da5a26058a5b@kernel.org>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
In-Reply-To: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, 
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
 James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, 
 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=FWlHUtx1il/2WmiearZx3LNeV83xpbRFd1g6e9syKsA=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBlZ7I+qo1rIY3IOTiiUwRAxi2OM?=
 =?utf-8?q?NSepIYyq0YWIbCA_KDVnYlCJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZWeyPgAKCRBTA5mu5fQxyQptCA_CBRf/0K9qKrdU9ZyL7OUgLfoKpWZ3Y5Xvo2?=
 =?utf-8?q?/RWzXlmQ2DXKoq/UH+loOnYsDaqePGfdWVh5uyo58d5_tr4QxdG4SYWTf0aojF8Nv?=
 =?utf-8?q?/Ap+jz0JAT1fkv5J5wNpK8VYaurr5U74/r2olZuglS8yOIpiotQf/sS7m_FPb8lsc?=
 =?utf-8?q?649YKHNU1fc+t9qPO3v3pygCKP9+bJJ2r6HSyaZw6SPYHtvKOlS1chbYH20mqdKLa?=
 =?utf-8?q?40NzU3_WzZnkXBYpChnZM7Wx7072VG8CmqZ/WS7DNSeX8HZx14OF7c4clq4hsIZ16?=
 =?utf-8?q?P0bYtxnGjcdxJfekad8I?= TE9Ua9977cqAsf27gse9g5nBZH9JZX
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 security/commoncap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index ced7a3c9685f..15344c86c759 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -295,11 +295,12 @@ int cap_capset(struct cred *new,
  */
 int cap_inode_need_killpriv(struct dentry *dentry)
 {
-	struct inode *inode = d_backing_inode(dentry);
+	struct vfs_caps caps;
 	int error;
 
-	error = __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, NULL, 0);
-	return error > 0;
+	/* Use nop_mnt_idmap for no mapping here as mapping is unimportant */
+	error= __vfs_get_fscaps(&nop_mnt_idmap, dentry, &caps);
+	return error == 0;
 }
 
 /**
@@ -322,7 +323,7 @@ int cap_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry)
 {
 	int error;
 
-	error = __vfs_removexattr(idmap, dentry, XATTR_NAME_CAPS);
+	error = __vfs_remove_fscaps(idmap, dentry);
 	if (error == -EOPNOTSUPP)
 		error = 0;
 	return error;

-- 
2.43.0


