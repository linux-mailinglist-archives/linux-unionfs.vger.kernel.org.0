Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B026202A70
	for <lists+linux-unionfs@lfdr.de>; Sun, 21 Jun 2020 14:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgFUM2M (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 21 Jun 2020 08:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729965AbgFUM2M (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 21 Jun 2020 08:28:12 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CABC061794
        for <linux-unionfs@vger.kernel.org>; Sun, 21 Jun 2020 05:28:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x22so7018941pfn.3
        for <linux-unionfs@vger.kernel.org>; Sun, 21 Jun 2020 05:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MZnDktK31XZ3cHCzYWTCqoYe8polQyugNedOJdBTNaI=;
        b=UBjLWd6D2Zxlqm/uyDALlDaq4025v6NkAiPlfzWihWyZWZbNISmxq/bmxck+oWZeGn
         VwE1tAYoWO9i7CxOOaD2kOPTMNEzWyMavLNtKG3wuXM/JomTg3wFalGhS/E5ASLqLE4+
         /Zg8cQ+m7vUN3qhwFYa3exLgA8KYMs0g9ZGSIM38kagshUYYovvoUpSKE3975TdsCPwr
         0boDsANFci0wTOOhVCjMyZvfnqDUvYJN1lkykAT1syP4qH7TwjER5xxSdc+5CoI5vzPq
         Zoh5wcdZkw2srYi1gfZTmmnARja1eNH3AdF1r8x3q93YvbFSQJP6QHvvDGgxtHZC9uk9
         Rf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MZnDktK31XZ3cHCzYWTCqoYe8polQyugNedOJdBTNaI=;
        b=KbC6xwSTzhRi75x0ZsZpZqDyoftsantHBZCnMXVcg1WqUvAvq3BokROarn00C1+B42
         tmgicclFPlBgCnH8wQ3V8dCtE5PxC942w0v3nz0zjgWPbVFA6KHu78cacg7w2jf77QwM
         RumNxXfZt1/UogFwl0Pa8xgAYA1qeIFu2NRGG4Co/cNpBN6fYoO6cFUtDgdChAgMcBEA
         VErKZAmK9TF6+GG/AvvNpSmDHQCwGC3Mv9OWFz1Pehgwd1xpC/gslK9s/vXdBTWn0f5o
         p+MVWNzwijhwtivGJ9kpYg0A/H7f2+rKe+u0wxp7Q9MTrt4TKVHROiI53p2GkNTe1xsq
         BuDw==
X-Gm-Message-State: AOAM531NjxC0MH6JQ54OhbUvew2o33NPEvj5lfhyUDVZNwVtmUtkxFXl
        oyGAouMAGeI1HrZ6z6zjILbrcJQS2Vc=
X-Google-Smtp-Source: ABdhPJwjjsJlBmH3KwjMYrCE8gczslmGlcxsI4PfQd4tenx4mbX5veUpCpgaWCxHQmxrVqCuKXuKmw==
X-Received: by 2002:a65:4807:: with SMTP id h7mr9470906pgs.123.1592742490769;
        Sun, 21 Jun 2020 05:28:10 -0700 (PDT)
Received: from ubuntu.localdomain ([220.116.27.194])
        by smtp.gmail.com with ESMTPSA id u128sm10940107pfu.148.2020.06.21.05.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 05:28:10 -0700 (PDT)
From:   youngjun <her0gyugyu@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org, youngjun <her0gyugyu@gmail.com>
Subject: [PATCH] ovl: null dereference possibility fixup
Date:   Sun, 21 Jun 2020 05:27:47 -0700
Message-Id: <20200621122747.58787-1-her0gyugyu@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

lowerdentry could be NULL, and dereferenced by calling d_inode.
code flow which described below
shows possibility of null dereference in ovl_get_inode.

(export.c) ovl_lower_fh_to_d
|_(export.c) ovl_get_dentry(sb, upper, NULL, NULL);
 |_(export.c) ovl_obtain_alias (sb, upper, NULL, NULL);
  |_(inode.c) ovl_get_inode(sb, &oip);
   |_(in ovl_get_inode) realinode = d_inode(lowerdentry);

Fixes: 09d8b586731bf("ovl: move __upperdentry to ovl_inode")
Signed-off-by: youngjun <her0gyugyu@gmail.com>
---
 fs/overlayfs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 8be6cd264f66..53d82ef68ba8 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -958,8 +958,10 @@ struct inode *ovl_get_inode(struct super_block *sb,
 	unsigned long ino = 0;
 	int err = oip->newinode ? -EEXIST : -ENOMEM;
 
-	if (!realinode)
+	if (!realinode && lowerdentry)
 		realinode = d_inode(lowerdentry);
+	else
+		return ERR_PTR(-EINVAL);
 
 	/*
 	 * Copy up origin (lower) may exist for non-indexed upper, but we must
-- 
2.17.1

