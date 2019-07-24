Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15C9573CB9
	for <lists+linux-unionfs@lfdr.de>; Wed, 24 Jul 2019 22:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388685AbfGXULZ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 24 Jul 2019 16:11:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46516 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392096AbfGXT5s (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 24 Jul 2019 15:57:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id c73so21453248pfb.13
        for <linux-unionfs@vger.kernel.org>; Wed, 24 Jul 2019 12:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GPGMp3Z5tMKTlSIY4+dJ+EwBidIrQV9yOiqz0I+KpuI=;
        b=N9EtOxCV3Gt0JC1yxlszeEqw4DZKIHiIA8l32BuQmt6ExFUWXDv6AJyIQjTM8DU5E6
         WlGCmJTIc/L0sDTtjNZTLCUERVUFKeo56J1gnRKLmpGkLlVWz3xVPHcjmnwnLP00mxex
         Y/jIG/XnMuiZ3JdsPN602FJWmVJvjUg/60aIDIRNhI4FpkSWotFviKfQOVOH6/5Z+eH4
         bnJUpguzK+BCBSVOgJwHF9u3d4b1Y7hHSUQ6wPZD6xFPzL91Y92+KvS8NZVXx+UAhOeL
         FiS7oal3j5yx59QRlzs+FTZgnOrJOXl0jG+5z3ShITkjGZ2cCOwxKGGgm252InOtK37e
         T/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GPGMp3Z5tMKTlSIY4+dJ+EwBidIrQV9yOiqz0I+KpuI=;
        b=gQlYbLpQM57DIV+TeRmf0Ia+dV0mARkFSb819KYdqZ9OSGruTVzilnvaoULiPM+FqC
         pI9tG/BBJy3JBwQGokagfbDwGnbOstgkUQWozwknpfCXWiToZLsMIIIgRG+DEdDOhOEB
         P4OwKza2dG6AQ08wSFkY9NosO+zOgOmDuokcN8IVytrcG7Ocr9nzPma9ALuzdS85JcS3
         dm8Xo7sE7Gt2fYG/V52WYAOnSGvhjCVwkBuV7DC/83kBbm/J1EdAZSsJkd5FuM4m37KV
         jEq51CFWeIEnLsdvoM7WHApnCs0NMNhqpq/cJZztaFrIfbq7hnxlAaw8hKAIax3Ozl6R
         88OA==
X-Gm-Message-State: APjAAAVBATBqmzmRaKakOArzB1B6xXSHPat+cKjn9yw07EaU9ujEgE8M
        dgJBgfDms3QPFA4fpuUQTiO3VuEb
X-Google-Smtp-Source: APXvYqyJwFQzJLxFbKWVANgLXI/3zYzrbuzCqQk6pCxCVWrScTR3LPgO3aG4qe30g9x4GfYTlkr0bw==
X-Received: by 2002:a62:ab18:: with SMTP id p24mr13021944pff.113.1563998267434;
        Wed, 24 Jul 2019 12:57:47 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id f88sm46307394pjg.5.2019.07.24.12.57.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 12:57:47 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v10 5/5] overlayfs: override_creds=off option bypass creator_cred
Date:   Wed, 24 Jul 2019 12:57:16 -0700
Message-Id: <20190724195719.218307-6-salyzyn@android.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190724195719.218307-1-salyzyn@android.com>
References: <20190724195719.218307-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

By default, all access to the upper, lower and work directories is the
recorded mounter's MAC and DAC credentials.  The incoming accesses are
checked against the caller's credentials.

If the principles of least privilege are applied, the mounter's
credentials might not overlap the credentials of the caller's when
accessing the overlayfs filesystem.  For example, a file that a lower
DAC privileged caller can execute, is MAC denied to the generally
higher DAC privileged mounter, to prevent an attack vector.

We add the option to turn off override_creds in the mount options; all
subsequent operations after mount on the filesystem will be only the
caller's credentials.  The module boolean parameter and mount option
override_creds is also added as a presence check for this "feature",
existence of /sys/module/overlay/parameters/override_creds.

It was not always this way.  Circa 4.6 there was no recorded mounter's
credentials, instead privileged access to upper or work directories
were temporarily increased to perform the operations.  The MAC
(selinux) policies were caller's in all cases.  override_creds=off
partially returns us to this older access model minus the insecure
temporary credential increases.  This is to permit use in a system
with non-overlapping security models for each executable including
the agent that mounts the overlayfs filesystem.  In Android
this is the case since init, which performs the mount operations,
has a minimal MAC set of privileges to reduce any attack surface,
and services that use the content have a different set of MAC
privileges (eg: read, for vendor labelled configuration, execute for
vendor libraries and modules).  The caveats are not a problem in
the Android usage model, however they should be fixed for
completeness and for general use in time.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-unionfs@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
---
v10:
- Rebase (and expand because of increased revert_cred usage)

v9:
- Add to the caveats

v8:
- drop pr_warn message after straw poll to remove it.
- added a use case in the commit message

v7:
- change name of internal parameter to ovl_override_creds_def
- report override_creds only if different than default

v6:
- Drop CONFIG_OVERLAY_FS_OVERRIDE_CREDS.
- Do better with the documentation.
- pr_warn message adjusted to report consequences.

v5:
- beefed up the caveats in the Documentation
- Is dependent on
  "overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh"
  "overlayfs: check CAP_MKNOD before issuing vfs_whiteout"
- Added prwarn when override_creds=off

v4:
- spelling and grammar errors in text

v3:
- Change name from caller_credentials / creator_credentials to the
  boolean override_creds.
- Changed from creator to mounter credentials.
- Updated and fortified the documentation.
- Added CONFIG_OVERLAY_FS_OVERRIDE_CREDS

v2:
- Forward port changed attr to stat, resulting in a build error.
- altered commit message.

a
---
 Documentation/filesystems/overlayfs.txt | 23 +++++++++++++++++++++++
 fs/overlayfs/copy_up.c                  |  2 +-
 fs/overlayfs/dir.c                      | 11 ++++++-----
 fs/overlayfs/file.c                     | 20 ++++++++++----------
 fs/overlayfs/inode.c                    | 18 +++++++++---------
 fs/overlayfs/namei.c                    |  6 +++---
 fs/overlayfs/overlayfs.h                |  1 +
 fs/overlayfs/ovl_entry.h                |  1 +
 fs/overlayfs/readdir.c                  |  4 ++--
 fs/overlayfs/super.c                    | 22 +++++++++++++++++++++-
 fs/overlayfs/util.c                     | 12 ++++++++++--
 11 files changed, 87 insertions(+), 33 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.txt b/Documentation/filesystems/overlayfs.txt
index 1da2f1668f08..d48125076602 100644
--- a/Documentation/filesystems/overlayfs.txt
+++ b/Documentation/filesystems/overlayfs.txt
@@ -102,6 +102,29 @@ Only the lists of names from directories are merged.  Other content
 such as metadata and extended attributes are reported for the upper
 directory only.  These attributes of the lower directory are hidden.
 
+credentials
+-----------
+
+By default, all access to the upper, lower and work directories is the
+recorded mounter's MAC and DAC credentials.  The incoming accesses are
+checked against the caller's credentials.
+
+In the case where caller MAC or DAC credentials do not overlap, a
+use case available in older versions of the driver, the
+override_creds mount flag can be turned off and help when the use
+pattern has caller with legitimate credentials where the mounter
+does not.  Several unintended side effects will occur though.  The
+caller without certain key capabilities or lower privilege will not
+always be able to delete files or directories, create nodes, or
+search some restricted directories.  The ability to search and read
+a directory entry is spotty as a result of the cache mechanism not
+retesting the credentials because of the assumption, a privileged
+caller can fill cache, then a lower privilege can read the directory
+cache.  The uneven security model where cache, upperdir and workdir
+are opened at privilege, but accessed without creating a form of
+privilege escalation, should only be used with strict understanding
+of the side effects and of the security policies.
+
 whiteouts and opaque directories
 --------------------------------
 
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index b801c6353100..1311ab4aea00 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -886,7 +886,7 @@ int ovl_copy_up_flags(struct dentry *dentry, int flags)
 		dput(parent);
 		dput(next);
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 702aa63f6774..c4b061c3a6ef 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -563,7 +563,8 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 		override_cred->fsgid = inode->i_gid;
 		if (!attr->hardlink) {
 			err = security_dentry_create_files_as(dentry,
-					attr->mode, &dentry->d_name, old_cred,
+					attr->mode, &dentry->d_name,
+					old_cred ? old_cred : current_cred(),
 					override_cred);
 			if (err) {
 				put_cred(override_cred);
@@ -579,7 +580,7 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 			err = ovl_create_over_whiteout(dentry, inode, attr);
 	}
 out_revert_creds:
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return err;
 }
 
@@ -655,7 +656,7 @@ static int ovl_set_link_redirect(struct dentry *dentry)
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	err = ovl_set_redirect(dentry, false);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
@@ -851,7 +852,7 @@ static int ovl_do_remove(struct dentry *dentry, bool is_dir)
 		err = ovl_remove_upper(dentry, is_dir, &list);
 	else
 		err = ovl_remove_and_whiteout(dentry, &list);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (!err) {
 		if (is_dir)
 			clear_nlink(dentry->d_inode);
@@ -1221,7 +1222,7 @@ static int ovl_rename(struct inode *olddir, struct dentry *old,
 out_unlock:
 	unlock_rename(new_upperdir, old_upperdir);
 out_revert_creds:
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (update_nlink)
 		ovl_nlink_end(new);
 out_drop_write:
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index e235a635d9ec..39a50fad9f7f 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -32,7 +32,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 	old_cred = ovl_override_creds(inode->i_sb);
 	realfile = open_with_fake_path(&file->f_path, flags, realinode,
 				       current_cred());
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
 		 file, file, ovl_whatisit(inode, realinode), file->f_flags,
@@ -176,7 +176,7 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 
 	old_cred = ovl_override_creds(inode->i_sb);
 	ret = vfs_llseek(real.file, offset, whence);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	file->f_pos = real.file->f_pos;
 	inode_unlock(inode);
@@ -242,7 +242,7 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_iter_read(real.file, iter, &iocb->ki_pos,
 			    ovl_iocb_to_rwf(iocb));
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	ovl_file_accessed(file);
 
@@ -278,7 +278,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	ret = vfs_iter_write(real.file, iter, &iocb->ki_pos,
 			     ovl_iocb_to_rwf(iocb));
 	file_end_write(real.file);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	/* Update size */
 	ovl_copyattr(ovl_inode_real(inode), inode);
@@ -305,7 +305,7 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	if (file_inode(real.file) == ovl_inode_upper(file_inode(file))) {
 		old_cred = ovl_override_creds(file_inode(file)->i_sb);
 		ret = vfs_fsync_range(real.file, start, end, datasync);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 	}
 
 	fdput(real);
@@ -329,7 +329,7 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = call_mmap(vma->vm_file, vma);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	if (ret) {
 		/* Drop reference count from new vm_file value */
@@ -357,7 +357,7 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_fallocate(real.file, mode, offset, len);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	/* Update size */
 	ovl_copyattr(ovl_inode_real(inode), inode);
@@ -379,7 +379,7 @@ static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_fadvise(real.file, offset, len, advice);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	fdput(real);
 
@@ -399,7 +399,7 @@ static long ovl_real_ioctl(struct file *file, unsigned int cmd,
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_ioctl(real.file, cmd, arg);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	fdput(real);
 
@@ -589,7 +589,7 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 						flags);
 		break;
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	/* Update size */
 	ovl_copyattr(ovl_inode_real(inode_out), inode_out);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index d3b53849615c..6c11c7af5157 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -61,7 +61,7 @@ int ovl_setattr(struct dentry *dentry, struct iattr *attr)
 		inode_lock(upperdentry->d_inode);
 		old_cred = ovl_override_creds(dentry->d_sb);
 		err = notify_change(upperdentry, attr, NULL);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 		if (!err)
 			ovl_copyattr(upperdentry->d_inode, dentry->d_inode);
 		inode_unlock(upperdentry->d_inode);
@@ -257,7 +257,7 @@ int ovl_getattr(const struct path *path, struct kstat *stat,
 		stat->nlink = dentry->d_inode->i_nlink;
 
 out:
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
@@ -291,7 +291,7 @@ int ovl_permission(struct inode *inode, int mask)
 		mask |= MAY_READ;
 	}
 	err = inode_permission(realinode, mask);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
@@ -308,7 +308,7 @@ static const char *ovl_get_link(struct dentry *dentry,
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	p = vfs_get_link(ovl_dentry_real(dentry), done);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return p;
 }
 
@@ -351,7 +351,7 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 		WARN_ON(flags != XATTR_REPLACE);
 		err = vfs_removexattr(realdentry, name);
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	/* copy c/mtime */
 	ovl_copyattr(d_inode(realdentry), inode);
@@ -387,7 +387,7 @@ int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	res = vfs_getxattr(realdentry, name, value, size);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return res;
 }
 
@@ -411,7 +411,7 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	res = vfs_listxattr(realdentry, list, size);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (res <= 0 || size == 0)
 		return res;
 
@@ -446,7 +446,7 @@ struct posix_acl *ovl_get_acl(struct inode *inode, int type)
 
 	old_cred = ovl_override_creds(inode->i_sb);
 	acl = get_acl(realinode, type);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return acl;
 }
@@ -484,7 +484,7 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		filemap_write_and_wait(realinode->i_mapping);
 
 	err = realinode->i_op->fiemap(realinode, fieinfo, start, len);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index fb6c0cd7b65f..12627018b00a 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1079,7 +1079,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			goto out_free_oe;
 	}
 
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (origin_path) {
 		dput(origin_path->dentry);
 		kfree(origin_path);
@@ -1106,7 +1106,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	kfree(upperredirect);
 out:
 	kfree(d.redirect);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return ERR_PTR(err);
 }
 
@@ -1160,7 +1160,7 @@ bool ovl_lower_positive(struct dentry *dentry)
 			dput(this);
 		}
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return positive;
 }
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 82574684a9b6..cdbdb533d3bd 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -205,6 +205,7 @@ int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
 struct dentry *ovl_workdir(struct dentry *dentry);
 const struct cred *ovl_override_creds(struct super_block *sb);
+void ovl_revert_creds(const struct cred *oldcred);
 ssize_t ovl_vfs_getxattr(struct dentry *dentry, const char *name, void *buf,
 			 size_t size);
 struct super_block *ovl_same_sb(struct super_block *sb);
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 28a2d12a1029..2637c5aadf7f 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -17,6 +17,7 @@ struct ovl_config {
 	bool nfs_export;
 	int xino;
 	bool metacopy;
+	bool override_creds;
 };
 
 struct ovl_sb {
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 47a91c9733a5..f31ef39e5afa 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -286,7 +286,7 @@ static int ovl_check_whiteouts(struct dentry *dir, struct ovl_readdir_data *rdd)
 		}
 		inode_unlock(dir->d_inode);
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
@@ -918,7 +918,7 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	err = ovl_dir_read_merged(dentry, list, &root);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (err)
 		return err;
 
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 82e1130de206..c2ddce5d488c 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -53,6 +53,11 @@ module_param_named(xino_auto, ovl_xino_auto_def, bool, 0644);
 MODULE_PARM_DESC(xino_auto,
 		 "Auto enable xino feature");
 
+static bool __read_mostly ovl_override_creds_def = true;
+module_param_named(override_creds, ovl_override_creds_def, bool, 0644);
+MODULE_PARM_DESC(ovl_override_creds_def,
+		 "Use mounter's credentials for accesses");
+
 static void ovl_entry_stack_free(struct ovl_entry *oe)
 {
 	unsigned int i;
@@ -362,6 +367,9 @@ static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 	if (ofs->config.metacopy != ovl_metacopy_def)
 		seq_printf(m, ",metacopy=%s",
 			   ofs->config.metacopy ? "on" : "off");
+	if (ofs->config.override_creds != ovl_override_creds_def)
+		seq_show_option(m, "override_creds",
+				ofs->config.override_creds ? "on" : "off");
 	return 0;
 }
 
@@ -402,6 +410,8 @@ enum {
 	OPT_XINO_AUTO,
 	OPT_METACOPY_ON,
 	OPT_METACOPY_OFF,
+	OPT_OVERRIDE_CREDS_ON,
+	OPT_OVERRIDE_CREDS_OFF,
 	OPT_ERR,
 };
 
@@ -420,6 +430,8 @@ static const match_table_t ovl_tokens = {
 	{OPT_XINO_AUTO,			"xino=auto"},
 	{OPT_METACOPY_ON,		"metacopy=on"},
 	{OPT_METACOPY_OFF,		"metacopy=off"},
+	{OPT_OVERRIDE_CREDS_ON,		"override_creds=on"},
+	{OPT_OVERRIDE_CREDS_OFF,	"override_creds=off"},
 	{OPT_ERR,			NULL}
 };
 
@@ -478,6 +490,7 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 	config->redirect_mode = kstrdup(ovl_redirect_mode_def(), GFP_KERNEL);
 	if (!config->redirect_mode)
 		return -ENOMEM;
+	config->override_creds = ovl_override_creds_def;
 
 	while ((p = ovl_next_opt(&opt)) != NULL) {
 		int token;
@@ -558,6 +571,14 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 			config->metacopy = false;
 			break;
 
+		case OPT_OVERRIDE_CREDS_ON:
+			config->override_creds = true;
+			break;
+
+		case OPT_OVERRIDE_CREDS_OFF:
+			config->override_creds = false;
+			break;
+
 		default:
 			pr_err("overlayfs: unrecognized mount option \"%s\" or missing value\n", p);
 			return -EINVAL;
@@ -1690,7 +1711,6 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 		       ovl_dentry_lower(root_dentry), NULL);
 
 	sb->s_root = root_dentry;
-
 	return 0;
 
 out_free_oe:
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 672459c3cff7..320aad599bcd 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -37,9 +37,17 @@ const struct cred *ovl_override_creds(struct super_block *sb)
 {
 	struct ovl_fs *ofs = sb->s_fs_info;
 
+	if (!ofs->config.override_creds)
+		return NULL;
 	return override_creds(ofs->creator_cred);
 }
 
+void ovl_revert_creds(const struct cred *old_cred)
+{
+	if (old_cred)
+		revert_creds(old_cred);
+}
+
 ssize_t ovl_vfs_getxattr(struct dentry *dentry, const char *name, void *buf,
 			 size_t size)
 {
@@ -797,7 +805,7 @@ int ovl_nlink_start(struct dentry *dentry)
 	 * value relative to the upper inode nlink in an upper inode xattr.
 	 */
 	err = ovl_set_nlink_upper(dentry);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 out:
 	if (err)
@@ -815,7 +823,7 @@ void ovl_nlink_end(struct dentry *dentry)
 
 		old_cred = ovl_override_creds(dentry->d_sb);
 		ovl_cleanup_index(dentry);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 	}
 
 	ovl_inode_unlock(inode);
-- 
2.22.0.657.g960e92d24f-goog

