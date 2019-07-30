Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD457AFEA
	for <lists+linux-unionfs@lfdr.de>; Tue, 30 Jul 2019 19:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbfG3R3q (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 30 Jul 2019 13:29:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44630 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbfG3R3p (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 30 Jul 2019 13:29:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so29138859plr.11
        for <linux-unionfs@vger.kernel.org>; Tue, 30 Jul 2019 10:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J96sCmcpv5jc6KXI+H8AgKlRuiuOdpzylGlevDua29k=;
        b=s7zFO4hvKE3r2wrXraLbuzIjInUrOpzkipMUT3MEmqlN+h91X7MEgsAq+VBYsWvwBe
         h5g0qyM68dayqk0sLwosm6cHa9EDQlu+jEC/SchSiub1IFkSS2NWv4FzxTUgkJs1UEsL
         kdDZSFkb1sK0KRb4ucuSDjUkEmTcekI/m6etEd7PFvYjctvkWJyRE7QU0E9/GFg16XWv
         SuiwdZ0DNSgr0HO1GLfaiaKuUQnyEFGGLOvOl3jzmq98nf5Y2MmCu1iA2sNBf57Ygrvr
         OGPKXTImFQE/Y0+2S+/PXF5EldZUGZHNfAnipp5muXtXtcui91lfhhCGJnuw4qn/D2sY
         d6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J96sCmcpv5jc6KXI+H8AgKlRuiuOdpzylGlevDua29k=;
        b=lEDMvnqcGfFAEWX5QUUPlv5kd8Uk9bLXpik6zPoHKdXLBsGtG0/szBswCLStvwEPIe
         A6UQWBF9OuWicmVIuyuBTldFdNyBCNzAS26RoiPs1Kd5JHMcucV53dqJA4/PyPejZHdJ
         Atvu3vRSb7hJdmRVkYfHwFTbczjlfXNkwiHGOow2UaBsMCSvyUnzKC8ncIJax5EVG/o2
         6yMJg5/Xfgi1ICXOCDYnMGdY9tXJZk5fFq9TNPOr8TMoahkd55cc+PhFOB2/LadJzsSx
         ZaJIv8vCoSxlUNQdAKlSFSpK7pNcqWJaud+2lrK0TGXLKZCYLW/mTL8x9X4/YIqnxiP7
         faow==
X-Gm-Message-State: APjAAAXd9uexqWoEns+ebV8TNZKmoDlPsvg+aKFQIz6jV2GxgzumIBeC
        MiJeLBOMLrQK7l06hDeHVcA=
X-Google-Smtp-Source: APXvYqw3rLwiqOBVdjj2dYubSN9LIjAXB+n2EItwx0IbUGp5imTckEBC33i4pBZebEUAH8i5f3+Z4A==
X-Received: by 2002:a17:902:e011:: with SMTP id ca17mr118509656plb.328.1564507784789;
        Tue, 30 Jul 2019 10:29:44 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id o129sm39856293pfg.1.2019.07.30.10.29.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 10:29:44 -0700 (PDT)
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
Subject: [PATCH v12 3/5] overlayfs: handle XATTR_NOSECURITY flag for get xattr method
Date:   Tue, 30 Jul 2019 10:29:00 -0700
Message-Id: <20190730172904.79146-4-salyzyn@android.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190730172904.79146-1-salyzyn@android.com>
References: <20190730172904.79146-1-salyzyn@android.com>
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

The path then would be security(dentry) -> __vfs_getxattr(dentry) ->
handler->get(dentry...XATTR_NOSECURITY) ->
__vfs_getxattr(realdentry) -> lower_handler->get(realdentry) which
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
---
v12 - Added back to patch series as get xattr with flag option.

v11 - Squashed out of patch series and replaced with per-thread flag
      solution.

v10 - Added to patch series as __get xattr method.
---
 fs/overlayfs/inode.c     | 8 ++++++--
 fs/overlayfs/overlayfs.h | 2 +-
 fs/overlayfs/super.c     | 7 ++++---
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 7663aeb85fa3..ce66f4050557 100644
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
@@ -371,7 +371,11 @@ int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 		ovl_i_dentry_upper(inode) ?: ovl_dentry_lower(dentry);
 
 	old_cred = ovl_override_creds(dentry->d_sb);
-	res = vfs_getxattr(realdentry, name, value, size);
+	if (flags & XATTR_NOSECURITY)
+		res = __vfs_getxattr(realdentry, d_inode(realdentry), name,
+				     value, size);
+	else
+		res = vfs_getxattr(realdentry, name, value, size);
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
index 57df03f3259f..6f041e1fceda 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -856,7 +856,7 @@ ovl_posix_acl_xattr_get(const struct xattr_handler *handler,
 			struct dentry *dentry, struct inode *inode,
 			const char *name, void *buffer, size_t size, int flags)
 {
-	return ovl_xattr_get(dentry, inode, handler->name, buffer, size);
+	return ovl_xattr_get(dentry, inode, handler->name, buffer, size, flags);
 }
 
 static int __maybe_unused
@@ -919,7 +919,8 @@ ovl_posix_acl_xattr_set(const struct xattr_handler *handler,
 
 static int ovl_own_xattr_get(const struct xattr_handler *handler,
 			     struct dentry *dentry, struct inode *inode,
-			     const char *name, void *buffer, size_t size)
+			     const char *name, void *buffer, size_t size,
+			     int flags)
 {
 	return -EOPNOTSUPP;
 }
@@ -937,7 +938,7 @@ static int ovl_other_xattr_get(const struct xattr_handler *handler,
 			       const char *name, void *buffer, size_t size,
 			       int flags)
 {
-	return ovl_xattr_get(dentry, inode, name, buffer, size);
+	return ovl_xattr_get(dentry, inode, name, buffer, size, flags);
 }
 
 static int ovl_other_xattr_set(const struct xattr_handler *handler,
-- 
2.22.0.770.g0f2c4a37fd-goog

