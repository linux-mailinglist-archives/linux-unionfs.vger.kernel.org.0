Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 621917ACDD
	for <lists+linux-unionfs@lfdr.de>; Tue, 30 Jul 2019 17:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732696AbfG3Pws (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 30 Jul 2019 11:52:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44763 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732694AbfG3Pwr (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 30 Jul 2019 11:52:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so30277997pgl.11
        for <linux-unionfs@vger.kernel.org>; Tue, 30 Jul 2019 08:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U+j9CzEG9lQx0+dPXqoAr9eU3hAssz2Pq88sxP9lXN0=;
        b=RgXgC31mVlPltT4DXYboby9z3Lee1ksKN31H1uhh33k0HHynvD6Vt/KnZuuaAeRWgJ
         L4iPARTTW72AlGfBpDkF4shbElluiwFvnCCaliGLLbkOOfyHoiSqUQ7vlahAhowkyMEX
         eJ1aBSaYUqL3nw5Xnu1rdtLqqsoJwx33LecBJvd01g1qRXHczFXFf549tx8pwBnteKsU
         TpP79WS4zoRAoiLShi+peBRFPyuV+rL5YabsjUkBhsrntSmkBDoQgJGKH4IQNfFJjOft
         ab68WIAUsdHQ4zfqcqxgMbsJeOlJBEzyCBpZSWEzNMLs9a8EpMBlidwkpE7vSCYjz7l3
         ZEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U+j9CzEG9lQx0+dPXqoAr9eU3hAssz2Pq88sxP9lXN0=;
        b=YMfbrpa4XTg6OImQuzyHSH4CaOt2ZxLTtH1HN57SPAs1lYSp6LuZ8eqzmobZZoJhsQ
         xWSYhXCoF8JTGdJA2nll79pGfGMlbazpQBE+6RHKAivYqqH8Q7HJE5AC2vr61tPHvSMo
         GGoAYw1RwA+cgeBdc8BhVVDRMExGJUYWbCKjDO3fGwIEEBXFE1ELHzekjcQFaX3g5MhT
         bEjeqaEmAWE2qR7iKUxNju002SZKF687WcEokSqHjXEZiqXcAAiJ58LT+SKfImZsHCfR
         nRC3tUrfSCnpjIo+JDDO44mrSJ/7R2+BnPOGo+SLKXlh/XkKhXzFu4gpEgNsSNEdGz3O
         pipw==
X-Gm-Message-State: APjAAAWIHGorKCJwb4lUfhOoJXC/bXj5sKLRuYHiVVFgFhQE62k7O0JF
        LH/hkMWNyztQDhgaE7YJgVc=
X-Google-Smtp-Source: APXvYqxqUlimO7PO6jCXUW02MD4rG1hv2yKPHPIV3FRiSRsiXlPyrxl4ujk3wka94wdpG1uRalsGKg==
X-Received: by 2002:aa7:91cc:: with SMTP id z12mr42473947pfa.76.1564501966384;
        Tue, 30 Jul 2019 08:52:46 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id q1sm76758814pfg.84.2019.07.30.08.52.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 08:52:45 -0700 (PDT)
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
Subject: [PATCH v11 3/4] overlayfs: internal getxattr operations without sepolicy checking
Date:   Tue, 30 Jul 2019 08:52:24 -0700
Message-Id: <20190730155227.41468-4-salyzyn@android.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190730155227.41468-1-salyzyn@android.com>
References: <20190730155227.41468-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Check impure, opaque, origin & meta xattr with no sepolicy audit
(using __vfs_getxattr) since these operations are internal to
overlayfs operations and do not disclose any data.  This became
an issue for credential override off since sys_admin would have
been required by the caller; whereas would have been inherently
present for the creator since it performed the mount.

This is a change in operations since we do not check in the new
ovl_do_vfs_getxattr function if the credential override is off or
not.  Reasoning is that the sepolicy check is unnecessary overhead,
especially since the check can be expensive.

Because for override credentials off, this affects _everyone_ that
underneath performs private xattr calls without the appropriate
sepolicy permissions and sys_admin capability.  Providing blanket
support for sys_admin would be bad for all possible callers.

For the override credentials on, this will affect only the mounter,
should it lack sepolicy permissions. Not considered a security
problem since mounting by definition has sys_admin capabilities,
but sepolicy contexts would still need to be crafted.

It should be noted that there is precedence, __vfs_getxattr is used
in other filesystems for their own internal trusted xattr management.

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
v11 - Switch name to ovl_do_vfs_getxattr, fortify comment.

v10 - Added to patch series.
---
 fs/overlayfs/namei.c     | 12 +++++++-----
 fs/overlayfs/overlayfs.h |  2 ++
 fs/overlayfs/util.c      | 24 +++++++++++++++---------
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 9702f0d5309d..a4a452c489fa 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -106,10 +106,11 @@ int ovl_check_fh_len(struct ovl_fh *fh, int fh_len)
 
 static struct ovl_fh *ovl_get_fh(struct dentry *dentry, const char *name)
 {
-	int res, err;
+	ssize_t res;
+	int err;
 	struct ovl_fh *fh = NULL;
 
-	res = vfs_getxattr(dentry, name, NULL, 0);
+	res = ovl_do_vfs_getxattr(dentry, name, NULL, 0);
 	if (res < 0) {
 		if (res == -ENODATA || res == -EOPNOTSUPP)
 			return NULL;
@@ -123,7 +124,7 @@ static struct ovl_fh *ovl_get_fh(struct dentry *dentry, const char *name)
 	if (!fh)
 		return ERR_PTR(-ENOMEM);
 
-	res = vfs_getxattr(dentry, name, fh, res);
+	res = ovl_do_vfs_getxattr(dentry, name, fh, res);
 	if (res < 0)
 		goto fail;
 
@@ -141,10 +142,11 @@ static struct ovl_fh *ovl_get_fh(struct dentry *dentry, const char *name)
 	return NULL;
 
 fail:
-	pr_warn_ratelimited("overlayfs: failed to get origin (%i)\n", res);
+	pr_warn_ratelimited("overlayfs: failed to get origin (%zi)\n", res);
 	goto out;
 invalid:
-	pr_warn_ratelimited("overlayfs: invalid origin (%*phN)\n", res, fh);
+	pr_warn_ratelimited("overlayfs: invalid origin (%*phN)\n",
+			    (int)res, fh);
 	goto out;
 }
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 6934bcf030f0..9c7c72af1550 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -205,6 +205,8 @@ int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
 struct dentry *ovl_workdir(struct dentry *dentry);
 const struct cred *ovl_override_creds(struct super_block *sb);
+ssize_t ovl_do_vfs_getxattr(struct dentry *dentry, const char *name, void *buf,
+			    size_t size);
 struct super_block *ovl_same_sb(struct super_block *sb);
 int ovl_can_decode_fh(struct super_block *sb);
 struct dentry *ovl_indexdir(struct super_block *sb);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index f5678a3f8350..f80b95423043 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -40,6 +40,12 @@ const struct cred *ovl_override_creds(struct super_block *sb)
 	return override_creds(ofs->creator_cred);
 }
 
+ssize_t ovl_do_vfs_getxattr(struct dentry *dentry, const char *name, void *buf,
+			    size_t size)
+{
+	return __vfs_getxattr(dentry, d_inode(dentry), name, buf, size);
+}
+
 struct super_block *ovl_same_sb(struct super_block *sb)
 {
 	struct ovl_fs *ofs = sb->s_fs_info;
@@ -537,9 +543,9 @@ void ovl_copy_up_end(struct dentry *dentry)
 
 bool ovl_check_origin_xattr(struct dentry *dentry)
 {
-	int res;
+	ssize_t res;
 
-	res = vfs_getxattr(dentry, OVL_XATTR_ORIGIN, NULL, 0);
+	res = ovl_do_vfs_getxattr(dentry, OVL_XATTR_ORIGIN, NULL, 0);
 
 	/* Zero size value means "copied up but origin unknown" */
 	if (res >= 0)
@@ -550,13 +556,13 @@ bool ovl_check_origin_xattr(struct dentry *dentry)
 
 bool ovl_check_dir_xattr(struct dentry *dentry, const char *name)
 {
-	int res;
+	ssize_t res;
 	char val;
 
 	if (!d_is_dir(dentry))
 		return false;
 
-	res = vfs_getxattr(dentry, name, &val, 1);
+	res = ovl_do_vfs_getxattr(dentry, name, &val, 1);
 	if (res == 1 && val == 'y')
 		return true;
 
@@ -837,13 +843,13 @@ int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *upperdir)
 /* err < 0, 0 if no metacopy xattr, 1 if metacopy xattr found */
 int ovl_check_metacopy_xattr(struct dentry *dentry)
 {
-	int res;
+	ssize_t res;
 
 	/* Only regular files can have metacopy xattr */
 	if (!S_ISREG(d_inode(dentry)->i_mode))
 		return 0;
 
-	res = vfs_getxattr(dentry, OVL_XATTR_METACOPY, NULL, 0);
+	res = ovl_do_vfs_getxattr(dentry, OVL_XATTR_METACOPY, NULL, 0);
 	if (res < 0) {
 		if (res == -ENODATA || res == -EOPNOTSUPP)
 			return 0;
@@ -852,7 +858,7 @@ int ovl_check_metacopy_xattr(struct dentry *dentry)
 
 	return 1;
 out:
-	pr_warn_ratelimited("overlayfs: failed to get metacopy (%i)\n", res);
+	pr_warn_ratelimited("overlayfs: failed to get metacopy (%zi)\n", res);
 	return res;
 }
 
@@ -878,7 +884,7 @@ ssize_t ovl_getxattr(struct dentry *dentry, char *name, char **value,
 	ssize_t res;
 	char *buf = NULL;
 
-	res = vfs_getxattr(dentry, name, NULL, 0);
+	res = ovl_do_vfs_getxattr(dentry, name, NULL, 0);
 	if (res < 0) {
 		if (res == -ENODATA || res == -EOPNOTSUPP)
 			return -ENODATA;
@@ -890,7 +896,7 @@ ssize_t ovl_getxattr(struct dentry *dentry, char *name, char **value,
 		if (!buf)
 			return -ENOMEM;
 
-		res = vfs_getxattr(dentry, name, buf, res);
+		res = ovl_do_vfs_getxattr(dentry, name, buf, res);
 		if (res < 0)
 			goto fail;
 	}
-- 
2.22.0.770.g0f2c4a37fd-goog

