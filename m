Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF4C51A4383
	for <lists+linux-unionfs@lfdr.de>; Fri, 10 Apr 2020 10:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgDJIZt (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 10 Apr 2020 04:25:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51677 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgDJIZt (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 10 Apr 2020 04:25:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id x4so1750400wmj.1
        for <linux-unionfs@vger.kernel.org>; Fri, 10 Apr 2020 01:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/dTESdeJHsLC2wR33md5cRNIroAylddzGPOwSa6YmKI=;
        b=nz8/MHGDs8oxjcgVF3KXvITUPalXrAAHGriVDHrvM1PqwCiEvFTOJ0v463AbfG3FCC
         vLLfRdWiktkaU+O1adDbEbJCHilsEcUzdA5YiwNOdy/tZqopic2rbikMlLhvgKRU1XF0
         5Y3S0LSVfoLUflJUSgIQs7UiME++Nkkpp1LaWbWAUrB9ktKoO7DNIUTgsSdPQuiDtbwE
         T1RBnWrp7kk0u9d04YIoze3eH7bhN9cy58Nzea33RjI6PxYsj8Xas5eE04s6uQX8im94
         9fN7bEpc6sCK7a99wqtQKDBmP4Q/LYxMcOo1eLULGRhn2lVXlTCB0FenUk+d7rU2F+7x
         jbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/dTESdeJHsLC2wR33md5cRNIroAylddzGPOwSa6YmKI=;
        b=UEjfWJtuZ8nbCsX9tJXQbm+OGKe+OrYpjXWBit6uO8ODHMTnfDaa4UwD47f9FJtCHN
         Yat9zTSeUvNfo+zRsCkcmbpCvIacTHwWYvXAbk57rJY1gFhl4w9v75YIcCkysNRqZd6X
         qr+Me1LeYRrp60J9bbF6a60mqeCGxw7jXfYoT1bpucOaEdIKE/igN+MgJPM/hILNFgIX
         su52lvWxujDJoRoqSCGO8XxoUKRrCyVR+FDxARYrJDtfeJbXhBHnfSBDkHvdYHqzU4KH
         haBJiCVBqZSqvLsl0kqd4Lp5uM9qo+8ZhHWafydLepWV+SEf6yqhxDOmsKsCN7/FwpIz
         Mngw==
X-Gm-Message-State: AGi0Pua8Bz3ym2xtAvI84X0H2hCrDwlRZQOPtX9ev/VUMO74ADvrt2qH
        JkzcvdZeiKXgIE0QsEqbPno=
X-Google-Smtp-Source: APiQypJt9H5UPIRGOTetZX/rFR/mFkA1DKqpLMDMkWBwFjbY3HSsp63UssCO87j3eD5veav84G4pPg==
X-Received: by 2002:a1c:6241:: with SMTP id w62mr3928691wmb.27.1586507148678;
        Fri, 10 Apr 2020 01:25:48 -0700 (PDT)
Received: from localhost.localdomain ([141.226.12.123])
        by smtp.gmail.com with ESMTPSA id b7sm1710327wrn.67.2020.04.10.01.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 01:25:48 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org
Subject: [PATCH 2/3] ovl: prepare to copy up without workdir
Date:   Fri, 10 Apr 2020 11:25:38 +0300
Message-Id: <20200410082539.23627-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200410082539.23627-1-amir73il@gmail.com>
References: <20200410082539.23627-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

With index=on, we copy up lower hardlinks to work dir and move them
into index dir. Fix locking to allow work dir and index dir to be the
same directory.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 9709cf22cab3..e523e63f604f 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -576,7 +576,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	struct inode *udir = d_inode(c->destdir), *wdir = d_inode(c->workdir);
 	struct dentry *temp, *upper;
 	struct ovl_cu_creds cc;
-	int err;
+	int err = 0;
 	struct ovl_cattr cattr = {
 		/* Can't properly set mode on creation because of the umask */
 		.mode = c->stat.mode & S_IFMT,
@@ -584,7 +584,11 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 		.link = c->link
 	};
 
-	err = ovl_lock_rename_workdir(c->workdir, c->destdir);
+	/* Are we copying up to indexdir which is also workdir? */
+	if (c->indexed && c->workdir == c->destdir)
+		inode_lock_nested(wdir, I_MUTEX_PARENT);
+	else
+		err = ovl_lock_rename_workdir(c->workdir, c->destdir);
 	if (err)
 		return err;
 
-- 
2.17.1

