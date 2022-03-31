Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59754ED873
	for <lists+linux-unionfs@lfdr.de>; Thu, 31 Mar 2022 13:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbiCaL0p (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 31 Mar 2022 07:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbiCaL0o (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 31 Mar 2022 07:26:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487FB6257
        for <linux-unionfs@vger.kernel.org>; Thu, 31 Mar 2022 04:24:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8B57615ED
        for <linux-unionfs@vger.kernel.org>; Thu, 31 Mar 2022 11:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299C4C340ED;
        Thu, 31 Mar 2022 11:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648725896;
        bh=arGNvql8KTR35imeDr7Zjrm1EIQhAhQQ5jSTKBM5HQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bFAKIkAJoUo5fccNhs9jVmAhjO9udcsIPxbJkVIXSbrCkqyitQxS2V0AC7Ug6qFJp
         SwFoxZTBY+HpPKFLeT8TScHM8llfRAAARSKKp3vwDSLUJmVpZ335RLPFEYh2Jg6sAi
         AhptSoYz7UF2MeRgwxqkJXDjLnuD3lGxwofYiyQHP7dQ57eNMQjNhzfp6pMbltO3K5
         rLufDpGRxpNdKpX4IRceLxpcYy2SwFNjH3lwL0jQvb1BN9Zpr/ViBvO49mOR+08Xdi
         b6/wwMTj0CC4IWkgxzHkYen+s9vqFOyfKws4QLeogwdgMn3BK0+l9UQvlH62iu1gXt
         atkrHINxiBAAg==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-unionfs@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos Catelin <rodrigo@sdfg.com.ar>,
        Seth Forshee <sforshee@digitalocean.com>,
        Luca Bocassi <luca.boccassi@microsoft.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>
Subject: [PATCH v3 17/19] ovl: handle idmappings in layer open helpers
Date:   Thu, 31 Mar 2022 13:23:15 +0200
Message-Id: <20220331112318.1377494-18-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220331112318.1377494-1-brauner@kernel.org>
References: <20220331112318.1377494-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2781; h=from:subject; bh=arGNvql8KTR35imeDr7Zjrm1EIQhAhQQ5jSTKBM5HQA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS59sukXjp901vx2St5x8sx1ge2rzwvvfxCeXxnCu/l3Ybf fObc6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI6WqG/7U9JtVpN6xXFBdd8yvX+X 3q/d1bGVuUK/7oM7gJTDWxLGL4p8t+SeNDfMnC4t8Xq2LUZPr+z+rlbzoVI9/qkFHCZxfKBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

In earlier patches we already passed down the relevant upper or lower
path to ovl_open_realfile(). Now let the open helpers actually take the
idmapping of the relevant mount into account when checking permissions.
This is needed to support idmapped base layers with overlay.

Cc: <linux-unionfs@vger.kernel.org>
Tested-by: Giuseppe Scrivano <gscrivan@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
/* v2 */
unchanged

/* v3 */
unchanged
---
 fs/overlayfs/file.c | 7 +++++--
 fs/overlayfs/util.c | 5 +++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 656c30bf20a6..7dd44f4e2757 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -42,6 +42,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 {
 	struct inode *realinode = d_inode(realpath->dentry);
 	struct inode *inode = file_inode(file);
+	struct user_namespace *real_idmap;
 	struct file *realfile;
 	const struct cred *old_cred;
 	int flags = file->f_flags | OVL_OPEN_FLAGS;
@@ -51,12 +52,14 @@ static struct file *ovl_open_realfile(const struct file *file,
 	if (flags & O_APPEND)
 		acc_mode |= MAY_APPEND;
 
+
 	old_cred = ovl_override_creds(inode->i_sb);
-	err = inode_permission(&init_user_ns, realinode, MAY_OPEN | acc_mode);
+	real_idmap = mnt_user_ns(realpath->mnt);
+	err = inode_permission(real_idmap, realinode, MAY_OPEN | acc_mode);
 	if (err) {
 		realfile = ERR_PTR(err);
 	} else {
-		if (!inode_owner_or_capable(&init_user_ns, realinode))
+		if (!inode_owner_or_capable(real_idmap, realinode))
 			flags &= ~O_NOATIME;
 
 		realfile = open_with_fake_path(&file->f_path, flags, realinode,
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 79fae06ee10a..7dd2e5e6662a 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -523,6 +523,7 @@ bool ovl_is_whiteout(struct dentry *dentry)
 struct file *ovl_path_open(struct path *path, int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
+	struct user_namespace *real_idmap = mnt_user_ns(path->mnt);
 	int err, acc_mode;
 
 	if (flags & ~(O_ACCMODE | O_LARGEFILE))
@@ -539,12 +540,12 @@ struct file *ovl_path_open(struct path *path, int flags)
 		BUG();
 	}
 
-	err = inode_permission(&init_user_ns, inode, acc_mode | MAY_OPEN);
+	err = inode_permission(real_idmap, inode, acc_mode | MAY_OPEN);
 	if (err)
 		return ERR_PTR(err);
 
 	/* O_NOATIME is an optimization, don't fail if not permitted */
-	if (inode_owner_or_capable(&init_user_ns, inode))
+	if (inode_owner_or_capable(real_idmap, inode))
 		flags |= O_NOATIME;
 
 	return dentry_open(path, flags, current_cred());
-- 
2.32.0

