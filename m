Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0A9156DE2
	for <lists+linux-unionfs@lfdr.de>; Mon, 10 Feb 2020 04:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgBJD0a (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 9 Feb 2020 22:26:30 -0500
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21134 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726944AbgBJD0a (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 9 Feb 2020 22:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1581304279;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=Ji/gTV3HUo3Lb13s2kX6vhSvrEKRi61SKbg9cok+WMY=;
        b=IUlML98EHBpBijagmtNjeXpXUlKm9f5v5bvIShUbCofrqJqSiwL9s6i3A66rjoK+
        pHra4eNzt3tHulP6wPq8Er4TtgnT09zwFRUj4N4UFMA0iAASDPTa2iY+5Qa/OfjDYKY
        AlgaTZehw5zyeoylpakoEJv9xNahZIspsBhyuiyE=
Received: from localhost.localdomain.localdomain (113.88.132.74 [113.88.132.74]) by mx.zoho.com.cn
        with SMTPS id 1581304278433798.6948831862219; Mon, 10 Feb 2020 11:11:18 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu
Cc:     linux-unionfs@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200210031114.61314-1-cgxu519@mykernel.net>
Subject: [PATCH] ovl: fix a typo in comment
Date:   Mon, 10 Feb 2020 11:11:14 +0800
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Fix a typo in comment. (annonate -> annotate)

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 79e8994e3bc1..69ad31d75bb9 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -504,7 +504,7 @@ static const struct address_space_operations ovl_aops =
=3D {
=20
 /*
  * It is possible to stack overlayfs instance on top of another
- * overlayfs instance as lower layer. We need to annonate the
+ * overlayfs instance as lower layer. We need to annotate the
  * stackable i_mutex locks according to stack level of the super
  * block instance. An overlayfs instance can never be in stack
  * depth 0 (there is always a real fs below it).  An overlayfs
--=20
2.21.1



