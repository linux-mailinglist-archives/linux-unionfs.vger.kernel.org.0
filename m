Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15C51175B1E
	for <lists+linux-unionfs@lfdr.de>; Mon,  2 Mar 2020 14:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgCBNDs (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 2 Mar 2020 08:03:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35659 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgCBNDs (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 2 Mar 2020 08:03:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id r7so12495373wro.2
        for <linux-unionfs@vger.kernel.org>; Mon, 02 Mar 2020 05:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gzSqJYExPEUvhaJVcLEftdgsBGr0QJMGlTlokhjRZxY=;
        b=kuON9TjNSWz7XQmVB5U9E0jfz4xO23vGzvIX4jeDc0nquDCO2aak5zVMOj8G9oYIbY
         lDjcF5MdHnvukwQbXwDMI40GusOjnXhAxY6yaqkvj3dgagLc+dSJvVRqK5uo85999nak
         aOeN0BYLhZJ6QjHegIth91m0akV8Pae6rvVOhqNV+mbZ5T38wBxZXQ5/AEiG/5XlInf3
         H8vteR6xu5vFydVCqUPTn+OSjDydQ2f/jWvePJfmim+KQKyEeiKqprVJkqjTzNhb+Czm
         s6aXzLP/tUR5CrNCmKNpuE6V7HhFDmwGb/wuJc/KgHe0hGebHUJQtOgG+E7EMF8JkFAe
         7Cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gzSqJYExPEUvhaJVcLEftdgsBGr0QJMGlTlokhjRZxY=;
        b=tUe4I7qWOSeg7q0N9rkRbYs6If5qvaBM+VCf0Dio1MMkmtZoOvE6l/PbXYnPW1d2EG
         jdf1CPHdtLxTevrnFciZ+bqMhshSm0zXNMSJ5kuWxKrSAikcJ1JqWNJz1muHtpB+jkbj
         ixNO4dcXkJiO/fD0wNtX40ZlFw6lkiDGmywRL/yRgFB00d9jdyWvwXQgvB90TqYPBM8e
         IWAm0kk90XNe7ZuX3vgu9R31hN/5DLqxAOLkc42OhWJJHsy8xIntUlB4/j/HXWqW1g1u
         +4qeRvoKjTKtJacrTdTgjKHbqr3fpM4jixUQOcDn8jZbSdWOG8PQJjKeA8XlH1l2D2fg
         CuHw==
X-Gm-Message-State: APjAAAUSRysBpL9Z43fnKfy/Sk/RUzYtMSVtWsXolHmwLAhfkQWUc0Sk
        FTJ8F3bxnqwQPDrSylAiYoQ=
X-Google-Smtp-Source: APXvYqzOfFOdRKUJjHtqnSoUAPby8rbtGfnFIrExWN03uCC4ofojYHXTEloOvweEBL9R+ZYYAJCQHw==
X-Received: by 2002:adf:f58c:: with SMTP id f12mr21548811wro.22.1583154226235;
        Mon, 02 Mar 2020 05:03:46 -0800 (PST)
Received: from localhost.localdomain ([141.226.9.174])
        by smtp.gmail.com with ESMTPSA id s14sm15650278wrv.44.2020.03.02.05.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 05:03:45 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: [PATCH] ovl: fix lock in ovl_llseek()
Date:   Mon,  2 Mar 2020 15:03:35 +0200
Message-Id: <20200302130335.6267-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

ovl_inode_lock() is interruptible. When inode_lock() in ovl_llseek()
was replaced with ovl_inode_lock(), we did not add a check for error.

Fix this by making ovl_inode_lock() uninterruptible and change the
existing call sites to use an _interruptible variant.

Reported-by: syzbot+66a9752fa927f745385e@syzkaller.appspotmail.com
Fixes: b1f9d3858f72 ("ovl: use ovl_inode_lock in ovl_llseek()")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/overlayfs.h | 7 ++++++-
 fs/overlayfs/util.c      | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 3623d28aa4fa..3d3f2b8bdae5 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -318,7 +318,12 @@ static inline unsigned int ovl_xino_bits(struct super_block *sb)
 	return ovl_same_dev(sb) ? OVL_FS(sb)->xino_mode : 0;
 }
 
-static inline int ovl_inode_lock(struct inode *inode)
+static inline void ovl_inode_lock(struct inode *inode)
+{
+	mutex_lock(&OVL_I(inode)->lock);
+}
+
+static inline int ovl_inode_lock_interruptible(struct inode *inode)
 {
 	return mutex_lock_interruptible(&OVL_I(inode)->lock);
 }
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index ea005085803f..042f7eb4f7f4 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -509,7 +509,7 @@ int ovl_copy_up_start(struct dentry *dentry, int flags)
 	struct inode *inode = d_inode(dentry);
 	int err;
 
-	err = ovl_inode_lock(inode);
+	err = ovl_inode_lock_interruptible(inode);
 	if (!err && ovl_already_copied_up_locked(dentry, flags)) {
 		err = 1; /* Already copied up */
 		ovl_inode_unlock(inode);
@@ -764,7 +764,7 @@ int ovl_nlink_start(struct dentry *dentry)
 			return err;
 	}
 
-	err = ovl_inode_lock(inode);
+	err = ovl_inode_lock_interruptible(inode);
 	if (err)
 		return err;
 
-- 
2.17.1

