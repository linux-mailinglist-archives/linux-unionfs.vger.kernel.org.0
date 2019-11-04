Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1022EEC2C
	for <lists+linux-unionfs@lfdr.de>; Mon,  4 Nov 2019 22:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387965AbfKDVyc (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 4 Nov 2019 16:54:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40150 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387958AbfKDVyc (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 4 Nov 2019 16:54:32 -0500
Received: by mail-pl1-f195.google.com with SMTP id e3so6170137plt.7
        for <linux-unionfs@vger.kernel.org>; Mon, 04 Nov 2019 13:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wxkk5ut6+s0cNxryvChWsZmwhMRnXWdBGWPKhZvNzYg=;
        b=Ta9OhILb7dafwoZE94wX59bg3IB8dDT9GlQC97tPh29z/3kSAXgrECiTfion0qsXcP
         Gb/+wmlpd0zXzoJ66PmkqCXLZcFsKU0mNNQX3YSN96bJIR8B+ULtpE+QE5Y38N6G2Fuh
         b3bfMG91+uQ/4ufFHpibcNlxYOE7zisRLzMjRKfTBzPIjfjcWXvtxEPpSqneDd9tBRYD
         8QCPOx9AAr6lFRCvNcVwtbcLmft+KdqJm2nW+a/ocAWInbniD+baUnOJJOdR1TMDX2yS
         DYcjutbwzqYc/2iK2IokKCFgaFBheyNKGzU0gk6d2seNa4PVR5jlQZHSqmGCvz8z4nZ8
         VINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wxkk5ut6+s0cNxryvChWsZmwhMRnXWdBGWPKhZvNzYg=;
        b=Q9N8XbDIQ2hMwAS2Kh2mSUcYQfFFZbz14fB3IfMW1u1vcTgdR88teARP4MWILl0dgG
         ro2D39xDQiB5u+wxdSPxkmcB36hV0SsSnuDFFyJbrqOkjnswxWLWCp7LxtefgAXfClIr
         Y1cydpTYwcxFKATt6rQnnJYxs0K3zSWwIsApWLOCrytOXPp/n8UsnSBHYj42nRVZUoGy
         0ajhne5TTktfjfHnrwhaIfzXNCGaTiiov8n1a3ymjlAMYvlW9kA3hs8vYDgstI30XZnU
         SjwHWhtTenzW8hbzEbOzR3DX/6o23ujiwokqx6MvNknrBqi1AK5P24vHiFj5xFN0VUI7
         QF9g==
X-Gm-Message-State: APjAAAWj3oxSRRk4j8HG/8XCYR/FKPrkF7WYBgG8ja7HB52dyIexh2+P
        cpw7x2e1egM055hmi1jYeuLCho6ZubJCRA==
X-Google-Smtp-Source: APXvYqzOlfhOuAcFE3PyPSu5cEFzLhnqc55aJlwnPcOx3PgwKCcUSt+zGdCYKQeCnDodouthnOblqw==
X-Received: by 2002:a17:902:6b47:: with SMTP id g7mr25942305plt.160.1572904471170;
        Mon, 04 Nov 2019 13:54:31 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id e198sm19231350pfh.83.2019.11.04.13.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 13:54:30 -0800 (PST)
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
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v15 2/4] overlayfs: handle XATTR_NOSECURITY flag for get xattr method
Date:   Mon,  4 Nov 2019 13:52:47 -0800
Message-Id: <20191104215253.141818-3-salyzyn@android.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191104215253.141818-1-salyzyn@android.com>
References: <20191104215253.141818-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Because of the overlayfs getxattr recursion, the incoming inode fails
to update the selinux sid resulting in avc denials being reported
against a target context of u:object_r:unlabeled:s0.

Solution is to respond to the XATTR_NOSECURITY flag in get xattr
method that calls the __vfs_getxattr handler instead so that the
context can be read in, rather than being denied with an -EACCES
when vfs_getxattr handler is called.

For the use case where access is to be blocked by the security layer.

The path then would be security(dentry) ->
__vfs_getxattr({dentry...XATTR_NOSECURITY}) ->
handler->get({dentry...XATTR_NOSECURITY}) ->
__vfs_getxattr({realdentry...XATTR_NOSECURITY}) ->
lower_handler->get({realdentry...XATTR_NOSECURITY}) which
would report back through the chain data and success as expected,
the logging security layer at the top would have the data to
determine the access permissions and report back to the logs and
the caller that the target context was blocked.

For selinux this would solve the cosmetic issue of the selinux log
and allow audit2allow to correctly report the rule needed to address
the access problem.

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
Cc: linux-security-module@vger.kernel.org

v15 - revert to v13 because xattr_gs_args rejected.

v14 - rebase to use xattr_gs_args.

v13 - rebase to use __vfs_getxattr flags option.

v12 - Added back to patch series as get xattr with flag option.

v11 - Squashed out of patch series and replaced with per-thread flag
      solution.

v10 - Added to patch series as __get xattr method.
---
 fs/overlayfs/inode.c     | 5 +++--
 fs/overlayfs/overlayfs.h | 2 +-
 fs/overlayfs/super.c     | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index bc14781886bf..c057e51057f7 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -363,7 +363,7 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 }
 
 int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
-		  void *value, size_t size)
+		  void *value, size_t size, int flags)
 {
 	ssize_t res;
 	const struct cred *old_cred;
@@ -371,7 +371,8 @@ int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 		ovl_i_dentry_upper(inode) ?: ovl_dentry_lower(dentry);
 
 	old_cred = ovl_override_creds(dentry->d_sb);
-	res = vfs_getxattr(realdentry, name, value, size);
+	res = __vfs_getxattr(realdentry, d_inode(realdentry), name,
+			     value, size, flags);
 	revert_creds(old_cred);
 	return res;
 }
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 6934bcf030f0..ab3d031c422b 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -356,7 +356,7 @@ int ovl_permission(struct inode *inode, int mask);
 int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 		  const void *value, size_t size, int flags);
 int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
-		  void *value, size_t size);
+		  void *value, size_t size, int flags);
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size);
 struct posix_acl *ovl_get_acl(struct inode *inode, int type);
 int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 57f5f948ae0a..c91e7b604631 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -857,7 +857,7 @@ ovl_posix_acl_xattr_get(const struct xattr_handler *handler,
 			struct dentry *dentry, struct inode *inode,
 			const char *name, void *buffer, size_t size, int flags)
 {
-	return ovl_xattr_get(dentry, inode, handler->name, buffer, size);
+	return ovl_xattr_get(dentry, inode, handler->name, buffer, size, flags);
 }
 
 static int __maybe_unused
@@ -939,7 +939,7 @@ static int ovl_other_xattr_get(const struct xattr_handler *handler,
 			       const char *name, void *buffer, size_t size,
 			       int flags)
 {
-	return ovl_xattr_get(dentry, inode, name, buffer, size);
+	return ovl_xattr_get(dentry, inode, name, buffer, size, flags);
 }
 
 static int ovl_other_xattr_set(const struct xattr_handler *handler,
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

