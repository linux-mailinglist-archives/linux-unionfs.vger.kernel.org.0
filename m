Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F115D5E66C7
	for <lists+linux-unionfs@lfdr.de>; Thu, 22 Sep 2022 17:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiIVPSz (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 22 Sep 2022 11:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbiIVPSl (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 22 Sep 2022 11:18:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFD4F08B3;
        Thu, 22 Sep 2022 08:18:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A0C763617;
        Thu, 22 Sep 2022 15:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C6DC433C1;
        Thu, 22 Sep 2022 15:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663859915;
        bh=np0pV9lTb9RKAfvEjmlaVRyX3e5sMqhMsmScpHv8PfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T346UEOuO5GXDbqMfDW4tuURtmhHyRuU9AdxMLXX2JPNsMMGkAIFc68FvAHA9fcLg
         KcQ0ue/B5ZHTp3FESKN3Py3yxFb+ojDqW000fVGDXM7ysI9YtD4l9wkwWK1IKCVSIH
         TXxTWJGpFRbVVLum6hMGgs4mEOXwyfEqYAHQ7w7a9GhQiML+ZqrU6GDlpr9dDW8Nuy
         9BY+Zp7o+dSSKtQfkaP14Jne8Nh2SNWyqceQ8HtQ3hhX7NT/jif2uHZiHTGmFYjnjO
         +c2UgQ8eDw5zK7WIntcdd+cigl1WM9aTB7DYOSiSBO9FuVRGrM5OayL9z/gNSyncKL
         GVbko2A5CVTPA==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-unionfs@vger.kernel.org
Subject: [PATCH 22/29] ovl: implement set acl method
Date:   Thu, 22 Sep 2022 17:17:20 +0200
Message-Id: <20220922151728.1557914-23-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922151728.1557914-1-brauner@kernel.org>
References: <20220922151728.1557914-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7168; i=brauner@kernel.org; h=from:subject; bh=np0pV9lTb9RKAfvEjmlaVRyX3e5sMqhMsmScpHv8PfU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTr1FRPM2jO6TxavEuCTeBexOIvaf/+boyR4ptkHfh7wZOT x4T2dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEehUjw+3+vlD9Ph+2/k5zgWMySu cqD57PqexS1AvOWq6wdH7ATEaGTxzOi9NfXrfu/SCpN4u1gW+N9Ik1DTcKFs5898VQ3eI7MwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

The current way of setting and getting posix acls through the generic
xattr interface is error prone and type unsafe. The vfs needs to
interpret and fixup posix acls before storing or reporting it to
userspace. Various hacks exist to make this work. The code is hard to
understand and difficult to maintain in it's current form. Instead of
making this work by hacking posix acls through xattr handlers we are
building a dedicated posix acl api around the get and set inode
operations. This removes a lot of hackiness and makes the codepaths
easier to maintain. A lot of background can be found in [1].

In order to build a type safe posix api around get and set acl we need
all filesystem to implement get and set acl.

Now that we have added get and set acl inode operations that allow easy
access to the dentry we give overlayfs it's own get and set acl inode
operations.

The set acl inode operation is duplicates most of the ovl posix acl
xattr handler. The main difference being that the set acl inode
operation relies on the new posix acl api. Once the vfs has been
switched over the custom posix acl xattr handler will be removed
completely.

Note, until the vfs has been switched to the new posix acl api this
patch is a non-functional change.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/overlayfs/dir.c       |  1 +
 fs/overlayfs/inode.c     | 81 ++++++++++++++++++++++++++++++++++++++++
 fs/overlayfs/overlayfs.h | 17 +++++++++
 3 files changed, 99 insertions(+)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index eb49d5d7b56f..0e817ebce92c 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1313,6 +1313,7 @@ const struct inode_operations ovl_dir_inode_operations = {
 	.listxattr	= ovl_listxattr,
 	.get_inode_acl	= ovl_get_inode_acl,
 	.get_acl	= ovl_get_acl,
+	.set_acl	= ovl_set_acl,
 	.update_time	= ovl_update_time,
 	.fileattr_get	= ovl_fileattr_get,
 	.fileattr_set	= ovl_fileattr_set,
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index dd11e13cd288..b0a19f9deaf1 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -596,6 +596,85 @@ struct posix_acl *ovl_get_acl(struct user_namespace *mnt_userns,
 	revert_creds(old_cred);
 	return acl;
 }
+
+int ovl_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+		struct posix_acl *acl, int type)
+{
+	int err;
+	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
+	struct inode *inode = d_inode(dentry);
+	struct dentry *upperdentry = ovl_dentry_upper(dentry);
+	struct dentry *realdentry = upperdentry ?: ovl_dentry_lower(dentry);
+	struct dentry *workdir = ovl_workdir(dentry);
+	struct inode *realinode = ovl_inode_real(inode);
+	struct path realpath;
+	const struct cred *old_cred;
+	const char *acl_name;
+
+	if (!IS_POSIXACL(d_inode(workdir)))
+		return -EOPNOTSUPP;
+	if (!realinode->i_op->set_acl)
+		return -EOPNOTSUPP;
+	if (type == ACL_TYPE_DEFAULT && !S_ISDIR(inode->i_mode))
+		return acl ? -EACCES : 0;
+	if (!inode_owner_or_capable(&init_user_ns, inode))
+		return -EPERM;
+
+	/*
+	 * Check if sgid bit needs to be cleared (actual setacl operation will
+	 * be done with mounter's capabilities and so that won't do it for us).
+	 */
+	if (unlikely(inode->i_mode & S_ISGID) && type == ACL_TYPE_ACCESS &&
+	    !in_group_p(inode->i_gid) &&
+	    !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID)) {
+		struct iattr iattr = { .ia_valid = ATTR_KILL_SGID };
+
+		err = ovl_setattr(&init_user_ns, dentry, &iattr);
+		if (err)
+			return err;
+	}
+
+	err = ovl_want_write(dentry);
+	if (err)
+		goto out;
+
+	acl_name = posix_acl_xattr_name(type);
+	if (!acl && !upperdentry) {
+		struct posix_acl *real_acl;
+
+		ovl_path_lower(dentry, &realpath);
+		old_cred = ovl_override_creds(dentry->d_sb);
+		real_acl = vfs_get_acl(mnt_user_ns(realpath.mnt), realdentry,
+				       posix_acl_xattr_name(type));
+		revert_creds(old_cred);
+		posix_acl_release(real_acl);
+		if (IS_ERR(real_acl))
+			goto out_drop_write;
+	}
+
+	if (!upperdentry) {
+		err = ovl_copy_up(dentry);
+		if (err)
+			goto out_drop_write;
+
+		realdentry = ovl_dentry_upper(dentry);
+	}
+
+	old_cred = ovl_override_creds(dentry->d_sb);
+	if (acl)
+		err = ovl_do_set_acl(ofs, realdentry, acl_name, acl);
+	else
+		err = ovl_do_remove_acl(ofs, realdentry, acl_name);
+	revert_creds(old_cred);
+
+	/* copy c/mtime */
+	ovl_copyattr(inode);
+
+out_drop_write:
+	ovl_drop_write(dentry);
+out:
+	return err;
+}
 #endif
 
 int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags)
@@ -772,6 +851,7 @@ static const struct inode_operations ovl_file_inode_operations = {
 	.listxattr	= ovl_listxattr,
 	.get_inode_acl	= ovl_get_inode_acl,
 	.get_acl	= ovl_get_acl,
+	.set_acl	= ovl_set_acl,
 	.update_time	= ovl_update_time,
 	.fiemap		= ovl_fiemap,
 	.fileattr_get	= ovl_fileattr_get,
@@ -793,6 +873,7 @@ static const struct inode_operations ovl_special_inode_operations = {
 	.listxattr	= ovl_listxattr,
 	.get_inode_acl	= ovl_get_inode_acl,
 	.get_acl	= ovl_get_acl,
+	.set_acl	= ovl_set_acl,
 	.update_time	= ovl_update_time,
 };
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 68a3030332e9..b2645baeba2f 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -8,6 +8,8 @@
 #include <linux/uuid.h>
 #include <linux/fs.h>
 #include <linux/namei.h>
+#include <linux/posix_acl.h>
+#include <linux/posix_acl_xattr.h>
 #include "ovl_entry.h"
 
 #undef pr_fmt
@@ -278,6 +280,18 @@ static inline int ovl_removexattr(struct ovl_fs *ofs, struct dentry *dentry,
 	return ovl_do_removexattr(ofs, dentry, ovl_xattr(ofs, ox));
 }
 
+static inline int ovl_do_set_acl(struct ovl_fs *ofs, struct dentry *dentry,
+				 const char *acl_name, struct posix_acl *acl)
+{
+	return vfs_set_acl(ovl_upper_mnt_userns(ofs), dentry, acl_name, acl);
+}
+
+static inline int ovl_do_remove_acl(struct ovl_fs *ofs, struct dentry *dentry,
+				    const char *acl_name)
+{
+	return vfs_remove_acl(ovl_upper_mnt_userns(ofs), dentry, acl_name);
+}
+
 static inline int ovl_do_rename(struct ovl_fs *ofs, struct inode *olddir,
 				struct dentry *olddentry, struct inode *newdir,
 				struct dentry *newdentry, unsigned int flags)
@@ -595,12 +609,15 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size);
 struct posix_acl *ovl_get_inode_acl(struct inode *inode, int type, bool rcu);
 struct posix_acl *ovl_get_acl(struct user_namespace *mnt_userns,
 			      struct dentry *dentry, int type);
+int ovl_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
+		struct posix_acl *acl, int type);
 void ovl_idmap_posix_acl(struct inode *realinode,
 			 struct user_namespace *mnt_userns,
 			 struct posix_acl *acl);
 #else
 #define ovl_get_inode_acl	NULL
 #define ovl_get_acl		NULL
+#define ovl_set_acl		NULL
 #endif
 
 int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags);
-- 
2.34.1

