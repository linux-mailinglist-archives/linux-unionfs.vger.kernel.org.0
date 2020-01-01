Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8040412DFDA
	for <lists+linux-unionfs@lfdr.de>; Wed,  1 Jan 2020 18:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgAAR63 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 1 Jan 2020 12:58:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35161 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbgAAR63 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 1 Jan 2020 12:58:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so37375489wro.2
        for <linux-unionfs@vger.kernel.org>; Wed, 01 Jan 2020 09:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rgJtBuFRD6PCCgYaxVNdcp4VBLEzvb3aXsIZvo9Z+5g=;
        b=umllWvSN2uFY4gt/+k2tdV8/kfDY6MuyPT7DOF9pqMDjRLoIIhm0uQx658+bt1pkkZ
         fsVFuCZxWTL40KLw5cfZ1cRgCFvtgnT0Ap31/jpaVEA6ykCwbTuEHRXp5sd8XDyqX+Dz
         t1bBZQ+yDFmNxOYyx3u/ojPJeuh7St4DVq1Hkjv+Cte2I02fXr30I+pb7eHiAlPe8qtR
         5ZQSIhJlV6rcwl7a61ZWKPRS4UsmTd2HzZifghqTTlGeqCQIB5sEx0gzoZQ7T7nXGp4Y
         +ZSJa8IVByX7Z1zwzxVJepIz+Zph64sD0oic9iKMZrJ4QI+xFnhnbIPom4fbSMLf8kod
         qzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rgJtBuFRD6PCCgYaxVNdcp4VBLEzvb3aXsIZvo9Z+5g=;
        b=W7hPkVHy3ptDnZYMMmAF7U4tjeoLzWwE9HmU66/CM6ZmeF1qxf56lmTpY1cURATuhW
         m6jv86WpKT7Z0NsIwwlBAIOqC6UqFSmv4daMLC3mwVxCuCwE9Tht9LU0nhX0QCTh+cYx
         +Z1AaFCb+cpGCMiEkyRtmyoLhShSzcYBj7XCC08vjfi9tuwMD/YFSxsGmmfkRORhM0Y1
         +cjiURKtk4RpjjFiJZFvZyMUv4+6sEd2AY6zt6EjgsfEW+/HkKfwhu7PEu9J/gKoVFaa
         WYPWs9tYVPA8aS+iedqpeUTvqqfvcfWuobHGnWI5MZLXFRZvVNQi1B4nGs1v/trBAdiS
         xw2w==
X-Gm-Message-State: APjAAAWc0KHWemWmJMmoyE9Q2xcI2Oy2SJAVeDYhEWgO3VTDWpSN4Xes
        N3TVnpOikZ3A8+I6eOyhAcE=
X-Google-Smtp-Source: APXvYqyhomjcsmG6azU3yc+ISzPouGlfDz64tLMJk87c/zKOG3f6ev0S+MTChODFQ3u++6IvyW3/4w==
X-Received: by 2002:a05:6000:149:: with SMTP id r9mr69685141wrx.147.1577901507601;
        Wed, 01 Jan 2020 09:58:27 -0800 (PST)
Received: from localhost.localdomain ([141.226.169.66])
        by smtp.gmail.com with ESMTPSA id z3sm53274778wrs.94.2020.01.01.09.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 09:58:27 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org
Subject: [PATCH 3/7] ovl: factor out helper ovl_get_root()
Date:   Wed,  1 Jan 2020 19:58:10 +0200
Message-Id: <20200101175814.14144-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200101175814.14144-1-amir73il@gmail.com>
References: <20200101175814.14144-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Allocates and initializes the root dentry and inode.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/super.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 2afa60ab9133..18db065d73b3 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1581,6 +1581,34 @@ static int ovl_check_overlapping_layers(struct super_block *sb,
 	return 0;
 }
 
+static struct dentry *ovl_get_root(struct super_block *sb,
+				   struct dentry *upperdentry,
+				   struct ovl_entry *oe)
+{
+	struct dentry *root;
+
+	root = d_make_root(ovl_new_inode(sb, S_IFDIR, 0));
+	if (!root)
+		return NULL;
+
+	root->d_fsdata = oe;
+
+	if (upperdentry) {
+		ovl_dentry_set_upper_alias(root);
+		if (ovl_is_impuredir(upperdentry))
+			ovl_set_flag(OVL_IMPURE, d_inode(root));
+	}
+
+	/* Root is always merge -> can have whiteouts */
+	ovl_set_flag(OVL_WHITEOUTS, d_inode(root));
+	ovl_dentry_set_flag(OVL_E_CONNECTED, root);
+	ovl_set_upperdata(d_inode(root));
+	ovl_inode_init(d_inode(root), upperdentry, ovl_dentry_lower(root),
+		       NULL);
+
+	return root;
+}
+
 static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct path upperpath = { };
@@ -1697,25 +1725,11 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_flags |= SB_POSIXACL;
 
 	err = -ENOMEM;
-	root_dentry = d_make_root(ovl_new_inode(sb, S_IFDIR, 0));
+	root_dentry = ovl_get_root(sb, upperpath.dentry, oe);
 	if (!root_dentry)
 		goto out_free_oe;
 
-	root_dentry->d_fsdata = oe;
-
 	mntput(upperpath.mnt);
-	if (upperpath.dentry) {
-		ovl_dentry_set_upper_alias(root_dentry);
-		if (ovl_is_impuredir(upperpath.dentry))
-			ovl_set_flag(OVL_IMPURE, d_inode(root_dentry));
-	}
-
-	/* Root is always merge -> can have whiteouts */
-	ovl_set_flag(OVL_WHITEOUTS, d_inode(root_dentry));
-	ovl_dentry_set_flag(OVL_E_CONNECTED, root_dentry);
-	ovl_set_upperdata(d_inode(root_dentry));
-	ovl_inode_init(d_inode(root_dentry), upperpath.dentry,
-		       ovl_dentry_lower(root_dentry), NULL);
 
 	sb->s_root = root_dentry;
 
-- 
2.17.1

