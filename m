Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B906229DDC2
	for <lists+linux-unionfs@lfdr.de>; Thu, 29 Oct 2020 01:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388862AbgJ2AmO (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 28 Oct 2020 20:42:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33585 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388852AbgJ2Alu (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 28 Oct 2020 20:41:50 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kXvuu-0008Ep-GW; Thu, 29 Oct 2020 00:35:48 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-audit@redhat.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 21/34] open: handle idmapped mounts
Date:   Thu, 29 Oct 2020 01:32:39 +0100
Message-Id: <20201029003252.2128653-22-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

For core file operations such as changing directories or chrooting, determining
file access, changing mode or ownership the vfs will verify that the caller is
privileged over the inode. Extend the various helpers to handle idmapped
mounts. If the inode is accessed through an idmapped mount it is mapped
according to the mount's user namespace. Afterwards the permissions checks are
identical to non-idmapped mounts. When changing file ownership we need to map
the mount from the mount's user namespace. If the initial user namespace is
passed all mapping operations are a nop so non-idmapped mounts will not see a
change in behavior and will also not see any performance impact.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/open.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index efa462b6b9c7..ca113399010a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -401,6 +401,7 @@ static const struct cred *access_override_creds(void)
 
 static long do_faccessat(int dfd, const char __user *filename, int mode, int flags)
 {
+	struct user_namespace *user_ns;
 	struct path path;
 	struct inode *inode;
 	int res;
@@ -441,7 +442,8 @@ static long do_faccessat(int dfd, const char __user *filename, int mode, int fla
 			goto out_path_release;
 	}
 
-	res = inode_permission(inode, mode | MAY_ACCESS);
+	user_ns = mnt_user_ns(path.mnt);
+	res = mapped_inode_permission(user_ns, inode, mode | MAY_ACCESS);
 	/* SuS v2 requires we report a read only fs too */
 	if (res || !(mode & S_IWOTH) || special_file(inode->i_mode))
 		goto out_path_release;
@@ -489,6 +491,7 @@ SYSCALL_DEFINE2(access, const char __user *, filename, int, mode)
 
 SYSCALL_DEFINE1(chdir, const char __user *, filename)
 {
+	struct user_namespace *user_ns;
 	struct path path;
 	int error;
 	unsigned int lookup_flags = LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
@@ -497,7 +500,8 @@ SYSCALL_DEFINE1(chdir, const char __user *, filename)
 	if (error)
 		goto out;
 
-	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
+	user_ns = mnt_user_ns(path.mnt);
+	error = mapped_inode_permission(user_ns, path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
 	if (error)
 		goto dput_and_out;
 
@@ -515,6 +519,7 @@ SYSCALL_DEFINE1(chdir, const char __user *, filename)
 
 SYSCALL_DEFINE1(fchdir, unsigned int, fd)
 {
+	struct user_namespace *user_ns;
 	struct fd f = fdget_raw(fd);
 	int error;
 
@@ -526,7 +531,8 @@ SYSCALL_DEFINE1(fchdir, unsigned int, fd)
 	if (!d_can_lookup(f.file->f_path.dentry))
 		goto out_putf;
 
-	error = inode_permission(file_inode(f.file), MAY_EXEC | MAY_CHDIR);
+	user_ns = mnt_user_ns(f.file->f_path.mnt);
+	error = mapped_inode_permission(user_ns, file_inode(f.file), MAY_EXEC | MAY_CHDIR);
 	if (!error)
 		set_fs_pwd(current->fs, &f.file->f_path);
 out_putf:
@@ -537,6 +543,7 @@ SYSCALL_DEFINE1(fchdir, unsigned int, fd)
 
 SYSCALL_DEFINE1(chroot, const char __user *, filename)
 {
+	struct user_namespace *user_ns;
 	struct path path;
 	int error;
 	unsigned int lookup_flags = LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
@@ -545,7 +552,8 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
 	if (error)
 		goto out;
 
-	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
+	user_ns = mnt_user_ns(path.mnt);
+	error = mapped_inode_permission(user_ns, path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
 	if (error)
 		goto dput_and_out;
 
@@ -570,6 +578,7 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
 
 int chmod_common(const struct path *path, umode_t mode)
 {
+	struct user_namespace *user_ns;
 	struct inode *inode = path->dentry->d_inode;
 	struct inode *delegated_inode = NULL;
 	struct iattr newattrs;
@@ -585,7 +594,8 @@ int chmod_common(const struct path *path, umode_t mode)
 		goto out_unlock;
 	newattrs.ia_mode = (mode & S_IALLUGO) | (inode->i_mode & ~S_IALLUGO);
 	newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
-	error = notify_change(path->dentry, &newattrs, &delegated_inode);
+	user_ns = mnt_user_ns(path->mnt);
+	error = notify_mapped_change(user_ns, path->dentry, &newattrs, &delegated_inode);
 out_unlock:
 	inode_unlock(inode);
 	if (delegated_inode) {
@@ -646,6 +656,7 @@ SYSCALL_DEFINE2(chmod, const char __user *, filename, umode_t, mode)
 
 int chown_common(const struct path *path, uid_t user, gid_t group)
 {
+	struct user_namespace *user_ns;
 	struct inode *inode = path->dentry->d_inode;
 	struct inode *delegated_inode = NULL;
 	int error;
@@ -656,6 +667,12 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	uid = make_kuid(current_user_ns(), user);
 	gid = make_kgid(current_user_ns(), group);
 
+	user_ns = mnt_user_ns(path->mnt);
+	if (mnt_idmapped(path->mnt)) {
+		uid = kuid_from_mnt(user_ns, uid);
+		gid = kgid_from_mnt(user_ns, gid);
+	}
+
 retry_deleg:
 	newattrs.ia_valid =  ATTR_CTIME;
 	if (user != (uid_t) -1) {
@@ -676,7 +693,7 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	inode_lock(inode);
 	error = security_path_chown(path, uid, gid);
 	if (!error)
-		error = notify_change(path->dentry, &newattrs, &delegated_inode);
+		error = notify_mapped_change(user_ns, path->dentry, &newattrs, &delegated_inode);
 	inode_unlock(inode);
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
@@ -1133,7 +1150,7 @@ struct file *filp_open(const char *filename, int flags, umode_t mode)
 {
 	struct filename *name = getname_kernel(filename);
 	struct file *file = ERR_CAST(name);
-	
+
 	if (!IS_ERR(name)) {
 		file = file_open_name(name, flags, mode);
 		putname(name);
-- 
2.29.0

