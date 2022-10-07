Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2965F7974
	for <lists+linux-unionfs@lfdr.de>; Fri,  7 Oct 2022 16:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiJGOG1 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 7 Oct 2022 10:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJGOGO (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 7 Oct 2022 10:06:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6B2120BC8;
        Fri,  7 Oct 2022 07:06:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0A1161CE8;
        Fri,  7 Oct 2022 14:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B241DC433C1;
        Fri,  7 Oct 2022 14:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665151572;
        bh=Vps0QCj3UIiopC9IDOr5YC5CJtso3JrXt2THEfh6OmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E4ol+h7mua9J/zlD64E/wKK/loTHW1yQPXorW2j4YsX0H92vbKKkqM54lZFgTQYal
         jFjRMu4JiL8tgITPlhvfjnA8DbzUWXK+3qvA8S+MeTZioHlpGxsft9ybDnX81CCyoa
         qbOWaIZoX2+4H0gv5eJv2qeGhHK7765USfVAfxsHK5oNaSu4bHkERx5I3h7d5BJB0A
         +hcDTBHVE0GYsJEDHlspLC5EclIlFJXBRO0HAfrglMQtIlg4MKkj/uarTvgd5t+ya5
         c5BfUIo712S3F4wsKzSLb0h2JwjmRU0GXho1invrTqN15iIygnu6YlS39V/odPEf2W
         OQVIHAk6xJ6Uw==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/5] attr: use consistent sgid stripping checks
Date:   Fri,  7 Oct 2022 16:05:41 +0200
Message-Id: <20221007140543.1039983-4-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221007140543.1039983-1-brauner@kernel.org>
References: <20221007140543.1039983-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11556; i=brauner@kernel.org; h=from:subject; bh=Vps0QCj3UIiopC9IDOr5YC5CJtso3JrXt2THEfh6OmQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQ7GBmsvTrZ40KPaaPallqOLU6Tm4yONp5TvuW3VTnJNXfX W67THaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZUc/IsMxxr25gaMrvz2GzlxzwyS mqTPD/zcBwpmNXf7xQ0LcTuxj+yoaY9S/rMg+WN/Wa1v9HISdp5xPFA9XTf80TKmDTVa5nAgA=
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

Currently setgid stripping in file_remove_privs()'s should_remove_suid()
helper is inconsistent with other parts of the vfs. Specifically, it only
raises ATTR_KILL_SGID if the inode is S_ISGID and S_IXGRP but not if the
inode isn't in the caller's groups and the caller isn't privileged over the
inode although we require this already in setattr_prepare() and
setattr_copy() and so all filesystem implement this requirement implicitly
because they have to use setattr_{prepare,copy}() anyway.

But the inconsistency shows up in setgid stripping bugs for overlayfs in
xfstests (e.g., generic/673, generic/683, generic/685, generic/686,
generic/687). For example, we test whether suid and setgid stripping works
correctly when performing various write-like operations as an unprivileged
user (fallocate, reflink, write, etc.):

echo "Test 1 - qa_user, non-exec file $verb"
setup_testfile
chmod a+rws $junk_file
commit_and_check "$qa_user" "$verb" 64k 64k

The test basically creates a file with 6666 permissions. While the file has
the S_ISUID and S_ISGID bits set it does not have the S_IXGRP set. On a
regular filesystem like xfs what will happen is:

sys_fallocate()
-> vfs_fallocate()
   -> xfs_file_fallocate()
      -> file_modified()
         -> __file_remove_privs()
            -> dentry_needs_remove_privs()
               -> should_remove_suid()
            -> __remove_privs()
               newattrs.ia_valid = ATTR_FORCE | kill;
               -> notify_change()
                  -> setattr_copy()

In should_remove_suid() we can see that ATTR_KILL_SUID is raised
unconditionally because the file in the test has S_ISUID set.

But we also see that ATTR_KILL_SGID won't be set because while the file
is S_ISGID it is not S_IXGRP (see above) which is a condition for
ATTR_KILL_SGID being raised.

So by the time we call notify_change() we have attr->ia_valid set to
ATTR_KILL_SUID | ATTR_FORCE. Now notify_change() sees that
ATTR_KILL_SUID is set and does:

ia_valid = attr->ia_valid |= ATTR_MODE
attr->ia_mode = (inode->i_mode & ~S_ISUID);

which means that when we call setattr_copy() later we will definitely
update inode->i_mode. Note that attr->ia_mode still contains S_ISGID.

Now we call into the filesystem's ->setattr() inode operation which will
end up calling setattr_copy(). Since ATTR_MODE is set we will hit:

if (ia_valid & ATTR_MODE) {
        umode_t mode = attr->ia_mode;
        vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
        if (!vfsgid_in_group_p(vfsgid) &&
            !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
                mode &= ~S_ISGID;
        inode->i_mode = mode;
}

and since the caller in the test is neither capable nor in the group of the
inode the S_ISGID bit is stripped.

But assume the file isn't suid then ATTR_KILL_SUID won't be raised which
has the consequence that neither the setgid nor the suid bits are stripped
even though it should be stripped because the inode isn't in the caller's
groups and the caller isn't privileged over the inode.

If overlayfs is in the mix things become a bit more complicated and the bug
shows up more clearly. When e.g., ovl_setattr() is hit from
ovl_fallocate()'s call to file_remove_privs() then ATTR_KILL_SUID and
ATTR_KILL_SGID might be raised but because the check in notify_change() is
questioning the ATTR_KILL_SGID flag again by requiring S_IXGRP for it to be
stripped the S_ISGID bit isn't removed even though it should be stripped:

sys_fallocate()
-> vfs_fallocate()
   -> ovl_fallocate()
      -> file_remove_privs()
         -> dentry_needs_remove_privs()
            -> should_remove_suid()
         -> __remove_privs()
            newattrs.ia_valid = ATTR_FORCE | kill;
            -> notify_change()
               -> ovl_setattr()
                  // TAKE ON MOUNTER'S CREDS
                  -> ovl_do_notify_change()
                     -> notify_change()
                  // GIVE UP MOUNTER'S CREDS
     // TAKE ON MOUNTER'S CREDS
     -> vfs_fallocate()
        -> xfs_file_fallocate()
           -> file_modified()
              -> __file_remove_privs()
                 -> dentry_needs_remove_privs()
                    -> should_remove_suid()
                 -> __remove_privs()
                    newattrs.ia_valid = attr_force | kill;
                    -> notify_change()

The fix for all of this is to make file_remove_privs()'s
should_remove_suid() helper to perform the same checks as we already
require in setattr_prepare() and setattr_copy() and have notify_change()
not pointlessly requiring S_IXGRP again. It doesn't make any sense in the
first place because the caller must calculate the flags via
should_remove_suid() anyway which would raise ATTR_KILL_SGID.

Running xfstests with this doesn't report any regressions. We should really
try and use consistent checks.

Co-Developed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    Amir Goldstein <amir73il@gmail.com>:
    - mention xfstests that failed prior to that
    
    Christian Brauner <brauner@kernel.org>:
    - Use should_remove_sgid() in chown_common() just like we do in do_truncate().

 fs/attr.c          |  2 +-
 fs/fuse/file.c     |  2 +-
 fs/inode.c         | 24 ++++++++----------------
 fs/internal.h      |  3 ++-
 fs/ocfs2/file.c    |  4 ++--
 fs/open.c          |  8 ++++----
 include/linux/fs.h |  2 +-
 7 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index d0bb1dae425e..888b34e8c268 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -421,7 +421,7 @@ int notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
 		}
 	}
 	if (ia_valid & ATTR_KILL_SGID) {
-		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
+		if (mode & S_ISGID) {
 			if (!(ia_valid & ATTR_MODE)) {
 				ia_valid = attr->ia_valid |= ATTR_MODE;
 				attr->ia_mode = inode->i_mode;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1a3afd469e3a..fccc2c7e88fd 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1313,7 +1313,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			return err;
 
 		if (fc->handle_killpriv_v2 &&
-		    should_remove_suid(file_dentry(file))) {
+		    should_remove_suid(&init_user_ns, file_dentry(file))) {
 			goto writethrough;
 		}
 
diff --git a/fs/inode.c b/fs/inode.c
index ba1de23c13c1..092a66324c65 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1949,26 +1949,17 @@ void touch_atime(const struct path *path)
 }
 EXPORT_SYMBOL(touch_atime);
 
-/*
- * The logic we want is
- *
- *	if suid or (sgid and xgrp)
- *		remove privs
- */
-int should_remove_suid(struct dentry *dentry)
+int should_remove_suid(struct user_namespace *mnt_userns, struct dentry *dentry)
 {
-	umode_t mode = d_inode(dentry)->i_mode;
+	struct inode *inode = d_inode(dentry);
+	umode_t mode = inode->i_mode;
 	int kill = 0;
 
 	/* suid always must be killed */
 	if (unlikely(mode & S_ISUID))
 		kill = ATTR_KILL_SUID;
 
-	/*
-	 * sgid without any exec bits is just a mandatory locking mark; leave
-	 * it alone.  If some exec bits are set, it's a real sgid; kill it.
-	 */
-	if (unlikely((mode & S_ISGID) && (mode & S_IXGRP)))
+	if (unlikely(should_remove_sgid(mnt_userns, inode)))
 		kill |= ATTR_KILL_SGID;
 
 	if (unlikely(kill && !capable(CAP_FSETID) && S_ISREG(mode)))
@@ -1983,7 +1974,8 @@ EXPORT_SYMBOL(should_remove_suid);
  * response to write or truncate. Return 0 if nothing has to be changed.
  * Negative value on error (change should be denied).
  */
-int dentry_needs_remove_privs(struct dentry *dentry)
+int dentry_needs_remove_privs(struct user_namespace *mnt_userns,
+			      struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
 	int mask = 0;
@@ -1992,7 +1984,7 @@ int dentry_needs_remove_privs(struct dentry *dentry)
 	if (IS_NOSEC(inode))
 		return 0;
 
-	mask = should_remove_suid(dentry);
+	mask = should_remove_suid(mnt_userns, dentry);
 	ret = security_inode_need_killpriv(dentry);
 	if (ret < 0)
 		return ret;
@@ -2024,7 +2016,7 @@ static int __file_remove_privs(struct file *file, unsigned int flags)
 	if (IS_NOSEC(inode) || !S_ISREG(inode->i_mode))
 		return 0;
 
-	kill = dentry_needs_remove_privs(dentry);
+	kill = dentry_needs_remove_privs(file_mnt_user_ns(file), dentry);
 	if (kill < 0)
 		return kill;
 
diff --git a/fs/internal.h b/fs/internal.h
index 9d165ab65a2a..b46881b7f8a0 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -139,7 +139,8 @@ extern int vfs_open(const struct path *, struct file *);
  * inode.c
  */
 extern long prune_icache_sb(struct super_block *sb, struct shrink_control *sc);
-extern int dentry_needs_remove_privs(struct dentry *dentry);
+extern int dentry_needs_remove_privs(struct user_namespace *,
+				     struct dentry *dentry);
 
 /*
  * fs-writeback.c
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 9c67edd215d5..e421491783c3 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1991,7 +1991,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
 		}
 	}
 
-	if (file && should_remove_suid(file->f_path.dentry)) {
+	if (file && should_remove_suid(&init_user_ns, file->f_path.dentry)) {
 		ret = __ocfs2_write_remove_suid(inode, di_bh);
 		if (ret) {
 			mlog_errno(ret);
@@ -2279,7 +2279,7 @@ static int ocfs2_prepare_inode_for_write(struct file *file,
 		 * inode. There's also the dinode i_size state which
 		 * can be lost via setattr during extending writes (we
 		 * set inode->i_size at the end of a write. */
-		if (should_remove_suid(dentry)) {
+		if (should_remove_suid(&init_user_ns, dentry)) {
 			if (meta_level == 0) {
 				ocfs2_inode_unlock_for_extent_tree(inode,
 								   &di_bh,
diff --git a/fs/open.c b/fs/open.c
index 8a813fa5ca56..d955ecef758f 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -54,7 +54,7 @@ int do_truncate(struct user_namespace *mnt_userns, struct dentry *dentry,
 	}
 
 	/* Remove suid, sgid, and file capabilities on truncate too */
-	ret = dentry_needs_remove_privs(dentry);
+	ret = dentry_needs_remove_privs(mnt_userns, dentry);
 	if (ret < 0)
 		return ret;
 	if (ret)
@@ -721,10 +721,10 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 		return -EINVAL;
 	if ((group != (gid_t)-1) && !setattr_vfsgid(&newattrs, gid))
 		return -EINVAL;
-	if (!S_ISDIR(inode->i_mode))
-		newattrs.ia_valid |=
-			ATTR_KILL_SUID | ATTR_KILL_SGID | ATTR_KILL_PRIV;
 	inode_lock(inode);
+	if (!S_ISDIR(inode->i_mode))
+		newattrs.ia_valid |= ATTR_KILL_SUID | ATTR_KILL_PRIV |
+				     should_remove_sgid(mnt_userns, inode);
 	/* Continue to send actual fs values, not the mount values. */
 	error = security_path_chown(
 		path,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9eced4cc286e..993ab96af619 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3090,7 +3090,7 @@ extern void __destroy_inode(struct inode *);
 extern struct inode *new_inode_pseudo(struct super_block *sb);
 extern struct inode *new_inode(struct super_block *sb);
 extern void free_inode_nonrcu(struct inode *inode);
-extern int should_remove_suid(struct dentry *);
+extern int should_remove_suid(struct user_namespace *, struct dentry *);
 extern int file_remove_privs(struct file *);
 
 /*
-- 
2.34.1

