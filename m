Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED2F3C9659
	for <lists+linux-unionfs@lfdr.de>; Thu, 15 Jul 2021 05:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbhGODTQ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 14 Jul 2021 23:19:16 -0400
Received: from foss.arm.com ([217.140.110.172]:46008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233989AbhGODTJ (ORCPT <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 14 Jul 2021 23:19:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 718951042;
        Wed, 14 Jul 2021 20:16:16 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 17AC33F7D8;
        Wed, 14 Jul 2021 20:16:13 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com,
        Jia He <justin.he@arm.com>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Subject: [PATCH RFC 06/13] ovl: remove the number postfix of '%pD' in format string
Date:   Thu, 15 Jul 2021 11:15:26 +0800
Message-Id: <20210715031533.9553-7-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715031533.9553-1-justin.he@arm.com>
References: <20210715031533.9553-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

After the behavior of '%pD' is changed to print the full path of file,
the previous number postfix is pointless.

Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jia He <justin.he@arm.com>
---
 fs/overlayfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 4d53d3b7e5fe..f073c32319cd 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -62,7 +62,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 	}
 	revert_creds(old_cred);
 
-	pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
+	pr_debug("open(%p[%pD/%c], 0%o) -> (%p, 0%o)\n",
 		 file, file, ovl_whatisit(inode, realinode), file->f_flags,
 		 realfile, IS_ERR(realfile) ? 0 : realfile->f_flags);
 
-- 
2.17.1

