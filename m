Return-Path: <linux-unionfs+bounces-779-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E11B927F9B
	for <lists+linux-unionfs@lfdr.de>; Fri,  5 Jul 2024 03:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB83283EA3
	for <lists+linux-unionfs@lfdr.de>; Fri,  5 Jul 2024 01:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88795E54D;
	Fri,  5 Jul 2024 01:17:07 +0000 (UTC)
X-Original-To: linux-unionfs@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A603FEC
	for <linux-unionfs@vger.kernel.org>; Fri,  5 Jul 2024 01:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720142227; cv=none; b=GkURbdgxH06hfehvziDgFp3cN3sN38sqIdMuUj5CLRDGNsP0IQyg2yWr9y/1VhkZHF0PhFgLUdmuVClljz6SDsi/IuHepK+v7XGoM54ZHkyw24cjMq7FyiVkz9UNxmr5qjb51eFLWnfB7I7biy4GaLmQn5Tx67ixuB3CLoArVfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720142227; c=relaxed/simple;
	bh=d1RfOw5f8V1dSmyW5gx5AYxZnT8RZLBeiSfVpvXfwa4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZb8GSrXSVU/RsxjmA+QwGFtV9gKxXSXRCJl0i457WPGYV2awVeKe3SvPSeUjzFyWx+CJd3SniITinmzCwDQiqH8m7kePdvXa8R08jJ86qrJcq62tH6ILoPe113czzg5Vo08aFlCQp61Xc4cEzHtEakLzrdBqGklM+UZdBhdiFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WFb8p2Zxtz1T4xP;
	Fri,  5 Jul 2024 09:12:26 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id C334A180085;
	Fri,  5 Jul 2024 09:17:01 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 5 Jul
 2024 09:17:01 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <miklos@szeredi.hu>, <amir73il@gmail.com>
CC: <linux-unionfs@vger.kernel.org>, <brauner@kernel.org>
Subject: [PATCH v3 1/3] ovl: pass string to ovl_parse_layer()
Date: Fri, 5 Jul 2024 09:15:08 +0800
Message-ID: <20240705011510.794025-2-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705011510.794025-1-chengzhihao1@huawei.com>
References: <20240705011510.794025-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000013.china.huawei.com (7.193.23.81)

From: Christian Brauner <brauner@kernel.org>

So it can be used for parsing the Opt_lowerdir.

Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/overlayfs/params.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 4860fcc4611b..52e3860973b7 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -365,10 +365,9 @@ static void ovl_add_layer(struct fs_context *fc, enum ovl_opt layer,
 	}
 }
 
-static int ovl_parse_layer(struct fs_context *fc, struct fs_parameter *param,
-			   enum ovl_opt layer)
+static int ovl_parse_layer(struct fs_context *fc, const char *layer_name, enum ovl_opt layer)
 {
-	char *name = kstrdup(param->string, GFP_KERNEL);
+	char *name = kstrdup(layer_name, GFP_KERNEL);
 	bool upper = (layer == Opt_upperdir || layer == Opt_workdir);
 	struct path path;
 	int err;
@@ -582,7 +581,7 @@ static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_datadir_add:
 	case Opt_upperdir:
 	case Opt_workdir:
-		err = ovl_parse_layer(fc, param, opt);
+		err = ovl_parse_layer(fc, param->string, opt);
 		break;
 	case Opt_default_permissions:
 		config->default_permissions = true;
-- 
2.39.2


