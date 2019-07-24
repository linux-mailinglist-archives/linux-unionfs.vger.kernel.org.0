Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 049B373B2F
	for <lists+linux-unionfs@lfdr.de>; Wed, 24 Jul 2019 21:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392052AbfGXT5k (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 24 Jul 2019 15:57:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46501 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392050AbfGXT5k (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 24 Jul 2019 15:57:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id k189so2698348pgk.13
        for <linux-unionfs@vger.kernel.org>; Wed, 24 Jul 2019 12:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L1oMJfrLOhz58HDhVH6CDl46g8rPXC84FR3jYEnwlGc=;
        b=GJbaZyZrN284EZaMgoaqSAtkOaiXvAl2Jzk1NdlCcJt1i+MCIStLfk4VLsZ2eWeOwL
         aSM/E1tfLEiFAK3NdeyIcFcVvjWjGQQ+uWIHDhmkk8M/SBs1ETRAFe+LkroYUjhXTbx0
         SkMLhttcCwzaCdxowZTuk5Ud6qZm6p8qg32R93rtYmLzltdBctyeCSeLDBsi9u5+AWER
         AV37Ol3qJnqTXl7pm5LrCVzP3JTx6e+lFViT2UYI+qcEHJtGCnuRImT8Uk41RoR0AH0M
         s96Qe7uf+LFZFOV7uPbHX2OtrfWq4tbzx0fZ8BaY8r6/+WWWq9K6m7m/ZjrazNSZSFZT
         6e/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L1oMJfrLOhz58HDhVH6CDl46g8rPXC84FR3jYEnwlGc=;
        b=f0H8dio1CICd0q7O+Cs4N1NtXVyVBzfI3dswTrxikoGGMFfq/M7ZykMGORMoKuQJO8
         FWdWwOuJO1jLYHe/4WhoN2JlM5yDndQSX3pKPoIX5IFq2DynD4pqFFYakg/YDPS7J7Q6
         yFo8Dc7d+IhaCSYl0M4srDRutvUcV1OfuuMSTGi70dy6d65LStBmi/64m84UzVPbSc/E
         DLHvYywmF2SeKHjdOXwHlV9rFNelvaKa/QGlUQwrALQE6wfMgacnYCftAA7vHFXSGnzP
         FXg4sR150lVlHGnwukfLHNJdn45jITOerPMPoX+MXdQ+D+rN6Yb+Teup9jApeRuKOcYh
         XxvQ==
X-Gm-Message-State: APjAAAVKGEuYTQtXsXH2w6+7pPb/lvcY/pDWLBqFsvJS52T7DO2xEAS4
        sGh6EyGAJYo9R2gfq9w7UTk=
X-Google-Smtp-Source: APXvYqy7X7TyygDWC4aF4AtmXyrL0XzYUXo6uIcdD2u7K60Xp3HzR54ZYiPqDmuME7OVT8NPmFC2Nw==
X-Received: by 2002:a63:3147:: with SMTP id x68mr19151426pgx.212.1563998258943;
        Wed, 24 Jul 2019 12:57:38 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id f88sm46307394pjg.5.2019.07.24.12.57.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 12:57:38 -0700 (PDT)
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
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mark Salyzyn <salyzyn@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v10 2/5] Add optional __get xattr method paired to __vfs_getxattr
Date:   Wed, 24 Jul 2019 12:57:13 -0700
Message-Id: <20190724195719.218307-3-salyzyn@android.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190724195719.218307-1-salyzyn@android.com>
References: <20190724195719.218307-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Add an optional __get xattr method that would be called, if set, only
in __vfs_getxattr instead of the regular get xattr method.

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
v10 - added to patch series
---
 fs/xattr.c            | 11 ++++++++++-
 include/linux/xattr.h |  7 +++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 90dd78f0eb27..b8f4734e222f 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -306,6 +306,9 @@ __vfs_getxattr(struct dentry *dentry, struct inode *inode, const char *name,
 	handler = xattr_resolve_name(inode, &name);
 	if (IS_ERR(handler))
 		return PTR_ERR(handler);
+	if (unlikely(handler->__get))
+		return handler->__get(handler, dentry, inode, name, value,
+				      size);
 	if (!handler->get)
 		return -EOPNOTSUPP;
 	return handler->get(handler, dentry, inode, name, value, size);
@@ -317,6 +320,7 @@ vfs_getxattr(struct dentry *dentry, const char *name, void *value, size_t size)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
+	const struct xattr_handler *handler;
 
 	error = xattr_permission(inode, name, MAY_READ);
 	if (error)
@@ -339,7 +343,12 @@ vfs_getxattr(struct dentry *dentry, const char *name, void *value, size_t size)
 		return ret;
 	}
 nolsm:
-	return __vfs_getxattr(dentry, inode, name, value, size);
+	handler = xattr_resolve_name(inode, &name);
+	if (IS_ERR(handler))
+		return PTR_ERR(handler);
+	if (!handler->get)
+		return -EOPNOTSUPP;
+	return handler->get(handler, dentry, inode, name, value, size);
 }
 EXPORT_SYMBOL_GPL(vfs_getxattr);
 
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 6dad031be3c2..30f25e1ac571 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -30,10 +30,13 @@ struct xattr_handler {
 	const char *prefix;
 	int flags;      /* fs private flags */
 	bool (*list)(struct dentry *dentry);
-	int (*get)(const struct xattr_handler *, struct dentry *dentry,
+	int (*get)(const struct xattr_handler *handler, struct dentry *dentry,
 		   struct inode *inode, const char *name, void *buffer,
 		   size_t size);
-	int (*set)(const struct xattr_handler *, struct dentry *dentry,
+	int (*__get)(const struct xattr_handler *handler, struct dentry *dentry,
+		     struct inode *inode, const char *name, void *buffer,
+		     size_t size);
+	int (*set)(const struct xattr_handler *handler, struct dentry *dentry,
 		   struct inode *inode, const char *name, const void *buffer,
 		   size_t size, int flags);
 };
-- 
2.22.0.657.g960e92d24f-goog

