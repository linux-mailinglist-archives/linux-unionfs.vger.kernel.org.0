Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E11612DFD9
	for <lists+linux-unionfs@lfdr.de>; Wed,  1 Jan 2020 18:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgAAR62 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 1 Jan 2020 12:58:28 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54351 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbgAAR62 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 1 Jan 2020 12:58:28 -0500
Received: by mail-wm1-f67.google.com with SMTP id b19so3900110wmj.4
        for <linux-unionfs@vger.kernel.org>; Wed, 01 Jan 2020 09:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nKlrJ82kaJx6+z75PaZZqGHBM7RUEcClPil767eHqVA=;
        b=haKkosyxQpxqNh6X9lM16PXMkP4Bgkde4K+GB2Y4AWyHjJL7OQhFNlSj2LuoNov874
         XTCxAr8a+x12YuKA42Ic7j588uIf1lQcXczp364WI/uDRVYdjJL4HxL8FmHIeLq2rb0W
         WXDDhGmhMJvC0VzQmjwRVeuKc3L2X156vPIzLPuKGQb3r91QKaGqJ5H98azSgaPx+eBO
         f94SU3KEAkB4lXTgq9U51Ytap+FhPWroc3PPRC3RG+MzTdzs5ZRzcx/6B9t4UjqSIc2J
         uNCCOm8CLzqq466tUvlzADV8IP6s5dw3l2hx0KCfPY+/VQ+MfaEsOa4HOJcLEBcYEpNz
         IBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nKlrJ82kaJx6+z75PaZZqGHBM7RUEcClPil767eHqVA=;
        b=bYLiGTvv5CF+66DwBGEcdaJJ7a6AD8/R+CK3nOUPdSYl2Jd5P5lH8FF+ylSw3fUKxb
         pnK/sy2M3e9//d244VqAqeUxlwc7NQXkj9m88XmMHG1ZM7iNg3mPyilIIo+pU064o3ts
         ZH93suoF0hICPywnqk8OaaMtfQ2A3fjZwd4iE//K0Mu3icrVmLWaYRtkNnwDqbRaFNWl
         oEAbzsxSNhYSv6eB5kPvQiIbrBwSIkTXFaJihESuGUcS59TJURZ3gtY+3MziDdKJNyOF
         oJcPusAEpxDRefkkCY/5lWrESfvrV8NjbQQfS0spZ+UXl/tQASDx0xxD7aXoHc0CcqG1
         sXig==
X-Gm-Message-State: APjAAAV2E0hBTaaefTVf7vNPHDwwHPhovejkwLuGVMTYYWqf2tYWGdyH
        2Lwk82zNJD2MG/r6smPYDmOd9RiP
X-Google-Smtp-Source: APXvYqycZVOhsq5b6ZDNo6AkibOJmVLWhEYY/VcdAtYFQiNgIXyxHcrJLfgiGzpjOieIkT5EIB/kCg==
X-Received: by 2002:a1c:7d8b:: with SMTP id y133mr10001316wmc.165.1577901506526;
        Wed, 01 Jan 2020 09:58:26 -0800 (PST)
Received: from localhost.localdomain ([141.226.169.66])
        by smtp.gmail.com with ESMTPSA id z3sm53274778wrs.94.2020.01.01.09.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 09:58:26 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org
Subject: [PATCH 2/7] ovl: fix out of date comment and unreachable code
Date:   Wed,  1 Jan 2020 19:58:09 +0200
Message-Id: <20200101175814.14144-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200101175814.14144-1-amir73il@gmail.com>
References: <20200101175814.14144-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

ovl_inode_update() is no longer called from create object code path.

Fixes: 01b39dcc9568 ("ovl: use inode_insert5() to hash a newly...")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/inode.c | 8 +++++---
 fs/overlayfs/util.c  | 2 --
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 9d2fff7d747d..9ed94c70e3cb 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -571,9 +571,11 @@ static void ovl_fill_inode(struct inode *inode, umode_t mode, dev_t rdev,
 	 * bits to encode layer), set the same value used for st_ino to i_ino,
 	 * so inode number exposed via /proc/locks and a like will be
 	 * consistent with d_ino and st_ino values. An i_ino value inconsistent
-	 * with d_ino also causes nfsd readdirplus to fail.  When called from
-	 * ovl_new_inode(), ino arg is 0, so i_ino will be updated to real
-	 * upper inode i_ino on ovl_inode_init() or ovl_inode_update().
+	 * with d_ino also causes nfsd readdirplus to fail.
+	 *
+	 * When called from ovl_create_object() => ovl_new_inode(), with
+	 * ino = 0, i_ino will be updated to consistent value later on in
+	 * ovl_get_inode() => ovl_fill_inode().
 	 */
 	if (ovl_same_dev(inode->i_sb)) {
 		inode->i_ino = ino;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 256f166b4a17..b28ccede1da9 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -418,8 +418,6 @@ void ovl_inode_update(struct inode *inode, struct dentry *upperdentry)
 	smp_wmb();
 	OVL_I(inode)->__upperdentry = upperdentry;
 	if (inode_unhashed(inode)) {
-		if (!inode->i_ino)
-			inode->i_ino = upperinode->i_ino;
 		inode->i_private = upperinode;
 		__insert_inode_hash(inode, (unsigned long) upperinode);
 	}
-- 
2.17.1

