Return-Path: <linux-unionfs+bounces-1195-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B27769F9A82
	for <lists+linux-unionfs@lfdr.de>; Fri, 20 Dec 2024 20:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149511642F5
	for <lists+linux-unionfs@lfdr.de>; Fri, 20 Dec 2024 19:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E1F21D5A8;
	Fri, 20 Dec 2024 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ey9PbPXt"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FB821D5AA
	for <linux-unionfs@vger.kernel.org>; Fri, 20 Dec 2024 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734723024; cv=none; b=LJRfJr/UdyrzUvntun+5d+ktVq/jQCJ7fl9BWnvaFiXDDqitGqqob18Nz13eQLnjuArd6xtnjpOgDzo2ITq7G2pbHyJCukBS1zIMsj2P3l/23j+gELaeMnpH6Wi+BJFgWM32SSgQ/NLbSwfbbFy1PgKxdzvrrpIx/40Lc97CTBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734723024; c=relaxed/simple;
	bh=/GQqeRU7X4VYGm5rsd2laeRMG/XWtb8DserF4nGqSVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ccL3PVybSAs6MSgbhg3Jdx2gQJr5R1EUDsJ0iSFr2LYDZ8ZEJEfzaaqdnhuqZI+YumWVqSrRZsW3y+vq0YbMKKKzlib9/Fn+oAGbaL3TvnTuDCucQ7du/HK7QKCHJ2mEFp58zTgWz9gt3Dven+5qm8RWrQ3hGR3ntpz5AfpFOiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ey9PbPXt; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734723020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HtvsAGPSRdKu4Y7Op/U5CVJDzFW2JHc65EwHQPm9ygw=;
	b=ey9PbPXtjoRDHPgO1/7mbMyPIcDuwnJ/Qzi6cCRID0oWn6qF3SAYBWoJXBQf0wRCyfu95E
	EEVX0PajiKcXwzHs9prBupLa2Tm9jpIjNC7PxCI4dDrs4juQB3t2z1ag8ZNm0TUcRCb3+2
	YL9DEeZstxCIDhXmw2pI4CMkQhQfTco=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] ovl: Use str_on_off() helper in ovl_show_options()
Date: Fri, 20 Dec 2024 20:29:42 +0100
Message-ID: <20241220192941.2367-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_on_off() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/overlayfs/params.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 1115c22deca0..8a8bb336b40f 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -1053,17 +1053,16 @@ int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 		seq_printf(m, ",redirect_dir=%s",
 			   ovl_redirect_mode(&ofs->config));
 	if (ofs->config.index != ovl_index_def)
-		seq_printf(m, ",index=%s", ofs->config.index ? "on" : "off");
+		seq_printf(m, ",index=%s", str_on_off(ofs->config.index));
 	if (ofs->config.uuid != ovl_uuid_def())
 		seq_printf(m, ",uuid=%s", ovl_uuid_mode(&ofs->config));
 	if (ofs->config.nfs_export != ovl_nfs_export_def)
-		seq_printf(m, ",nfs_export=%s", ofs->config.nfs_export ?
-						"on" : "off");
+		seq_printf(m, ",nfs_export=%s",
+			   str_on_off(ofs->config.nfs_export));
 	if (ofs->config.xino != ovl_xino_def() && !ovl_same_fs(ofs))
 		seq_printf(m, ",xino=%s", ovl_xino_mode(&ofs->config));
 	if (ofs->config.metacopy != ovl_metacopy_def)
-		seq_printf(m, ",metacopy=%s",
-			   ofs->config.metacopy ? "on" : "off");
+		seq_printf(m, ",metacopy=%s", str_on_off(ofs->config.metacopy));
 	if (ofs->config.ovl_volatile)
 		seq_puts(m, ",volatile");
 	if (ofs->config.userxattr)
-- 
2.47.1


