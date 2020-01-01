Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E4B12DFD8
	for <lists+linux-unionfs@lfdr.de>; Wed,  1 Jan 2020 18:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgAAR61 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 1 Jan 2020 12:58:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52731 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbgAAR61 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 1 Jan 2020 12:58:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so3926926wmc.2
        for <linux-unionfs@vger.kernel.org>; Wed, 01 Jan 2020 09:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0S2f1QioJc2ahOO0ShHgHdRoRKPLD69mMkoZ/cmU0b0=;
        b=md4LMcPhXKR7UkrbpEPkc2teMknLSs3err6nZyPPXhIUZsW+WNJujVSldZu+fTPZQB
         nKMZ7nFq/b1h7OGwVV3ZuqISEVLA//l2GTaxg9mcAGWIsjNxOF73puzOLHkpKVyR9Xrc
         aWodRnQiEPGD133MMq0U3J4gEehGnpPZugkI0lu/QjgHXB5YNgI2sFsU400J1et1SPUv
         SBWOMPifsfc+98LrIAdyQoDjtshpVyzmfFENa7TNvxiI8rWR8KLpuY9HNF9OmuE347Uq
         niz6CDLNefTBrwtQ2bdquj6p6CS3zyzpAjA+XTEUKOlcaYYYA58nojRsTQSnjQxRMNo5
         qhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0S2f1QioJc2ahOO0ShHgHdRoRKPLD69mMkoZ/cmU0b0=;
        b=YzDVo9fCapNtUzdLDZTnXl9Y8RDGJghJOJxNMsbD0s6oNk4Nmrs5VQGcFXmDa9lddW
         jTaSteu51kEoikKJ7o+m/UfviKgRHoMeJ563Ntwv4WKjrGa9oCRSwaDL7ssn8fSPX+Y6
         htVo45ZpKyTKeZFo37wxLHCninb0KS5o9ZnccL0ZMTX//hCxFWr8FNNK9yA1cnq9anjb
         VK2InUwce3K+eH9xmaUzDlZH0fMjZLuYlOQBUtC57dgScUjmufz8FPraqZb8kBoX4nAw
         mn3/A8BkiAhAKW8wxt7I/6qrLWOtPm4TCcXKIeDYyut+FvGeDQqujUZn5mdN+t4rZsTW
         G5pQ==
X-Gm-Message-State: APjAAAXYQMDXU27e/+7DPH5cmKzPmbk9GVoPhhGoR1QnoMn/gru3OWKT
        8gCQzYQ3qsZgi8x3F81Nir1dYYj1
X-Google-Smtp-Source: APXvYqyFA7hXqDaGUuT2YtlLNK4Av8qNRY4X9KtXqKi92yivAUQNMv+1tRmE9tBfBQZBSqLal4LxTQ==
X-Received: by 2002:a05:600c:54c:: with SMTP id k12mr10426528wmc.124.1577901505304;
        Wed, 01 Jan 2020 09:58:25 -0800 (PST)
Received: from localhost.localdomain ([141.226.169.66])
        by smtp.gmail.com with ESMTPSA id z3sm53274778wrs.94.2020.01.01.09.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 09:58:24 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org
Subject: [PATCH 1/7] ovl: fix value of i_ino for lower hardlink corner case
Date:   Wed,  1 Jan 2020 19:58:08 +0200
Message-Id: <20200101175814.14144-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200101175814.14144-1-amir73il@gmail.com>
References: <20200101175814.14144-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Commit 6dde1e42f497 ("ovl: make i_ino consistent with st_ino in more
cases"), relaxed the condition nfs_export=on in order to set the value
of i_ino to xino map of real ino.

Specifically, it also relaxed the pre-condition that index=on for
consistent i_ino. This opened the corner case of lower hardlink in
ovl_get_inode(), which calls ovl_fill_inode() with ino=0 and then
ovl_init_inode() is called to set i_ino to lower real ino without
the xino mapping.

Pass the correct values of ino;fsid in this case to ovl_fill_inode(),
so it can initialize i_ino correctly.

Fixes: 6dde1e42f497 ("ovl: make i_ino consistent with st_ino in more ...")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 3afae2e2d0ea..9d2fff7d747d 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -891,7 +891,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
 	struct dentry *lowerdentry = lowerpath ? lowerpath->dentry : NULL;
 	bool bylower = ovl_hash_bylower(sb, upperdentry, lowerdentry,
 					oip->index);
-	int fsid = bylower ? oip->lowerpath->layer->fsid : 0;
+	int fsid = bylower ? lowerpath->layer->fsid : 0;
 	bool is_dir, metacopy = false;
 	unsigned long ino = 0;
 	int err = oip->newinode ? -EEXIST : -ENOMEM;
@@ -941,6 +941,8 @@ struct inode *ovl_get_inode(struct super_block *sb,
 			err = -ENOMEM;
 			goto out_err;
 		}
+		ino = realinode->i_ino;
+		fsid = lowerpath->layer->fsid;
 	}
 	ovl_fill_inode(inode, realinode->i_mode, realinode->i_rdev, ino, fsid);
 	ovl_inode_init(inode, upperdentry, lowerdentry, oip->lowerdata);
-- 
2.17.1

