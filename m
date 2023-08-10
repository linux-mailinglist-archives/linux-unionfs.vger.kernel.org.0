Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE127777CF
	for <lists+linux-unionfs@lfdr.de>; Thu, 10 Aug 2023 14:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjHJMFO (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 10 Aug 2023 08:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjHJMFO (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 10 Aug 2023 08:05:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BB81BD
        for <linux-unionfs@vger.kernel.org>; Thu, 10 Aug 2023 05:05:13 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RM5D14Wp4zTmbb
        for <linux-unionfs@vger.kernel.org>; Thu, 10 Aug 2023 20:03:13 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 20:05:10 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <miklos@szeredi.hu>, <amir73il@gmail.com>
CC:     <linux-unionfs@vger.kernel.org>
Subject: [PATCH -next] ovl: Remove duplicated include
Date:   Thu, 10 Aug 2023 20:04:45 +0800
Message-ID: <20230810120445.27174-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Remove duplicated include for linux/posix_acl.h and resolves
checkincludes message.

Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 fs/overlayfs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index c1c9ff62caad..d01a31ad8aa8 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -8,7 +8,6 @@
 #include <linux/slab.h>
 #include <linux/cred.h>
 #include <linux/xattr.h>
-#include <linux/posix_acl.h>
 #include <linux/ratelimit.h>
 #include <linux/fiemap.h>
 #include <linux/fileattr.h>
-- 
2.17.1

