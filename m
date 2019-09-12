Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFDBB0839
	for <lists+linux-unionfs@lfdr.de>; Thu, 12 Sep 2019 07:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfILFTG (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 12 Sep 2019 01:19:06 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3068 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfILFTG (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 12 Sep 2019 01:19:06 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35d79d533104-04883; Thu, 12 Sep 2019 13:18:47 +0800 (CST)
X-RM-TRANSID: 2ee35d79d533104-04883
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65d79d536400-208ae;
        Thu, 12 Sep 2019 13:18:47 +0800 (CST)
X-RM-TRANSID: 2ee65d79d536400-208ae
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     miklos@szeredi.hu, linux-unionfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sfr@canb.auug.org.au
Subject: [PATCH V2] ovl: Fix dereferencing possible ERR_PTR()
Date:   Thu, 12 Sep 2019 13:18:31 +0800
Message-Id: <1568265511-1622-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

if ovl_encode_real_fh() fails, no memory was allocated
and the error in the error-valued pointer should be returned.

V1->V2: fix SHA1 length problem

Fixes: 9b6faee07470 ("ovl: check ERR_PTR() return value from ovl_encode_fh()")
Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 fs/overlayfs/export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index cb8ec1f..50ade19 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -229,7 +229,7 @@ static int ovl_d_to_fh(struct dentry *dentry, char *buf, int buflen)
 				ovl_dentry_upper(dentry), !enc_lower);
 	err = PTR_ERR(fh);
 	if (IS_ERR(fh))
-		goto fail;
+		return err;
 
 	err = -EOVERFLOW;
 	if (fh->len > buflen)
-- 
1.9.1



