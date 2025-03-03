Return-Path: <linux-unionfs+bounces-1297-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3255AA486FE
	for <lists+linux-unionfs@lfdr.de>; Thu, 27 Feb 2025 18:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCC171884FC3
	for <lists+linux-unionfs@lfdr.de>; Thu, 27 Feb 2025 17:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319021E5212;
	Thu, 27 Feb 2025 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ooIuQeV/"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9B51DE4E7
	for <linux-unionfs@vger.kernel.org>; Thu, 27 Feb 2025 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678591; cv=none; b=U1bYyNLd8884r33d1txr78uP9prY9KdmQPckJnZ2eWnDtszCY0akEJxt4TnpVl7BezeppSZK2cmBH2Nnxt2KbKgV1AQC+DVjChz+IQkblhrvZGIHej2VPjeQrnq03OSfIGZxr73l8D1ok2AYjwOwAGTcxwIi6recx7xzbnei7Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678591; c=relaxed/simple;
	bh=Krp0hRcnkmO9FVzzmnUG7JaNepHi3MNQIk7r1KS5hT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uX+0F9SiwydDihZtwCEzG/rUXF3kAzWIh5qudm9WkYOdLV9uhoK/jheASq4W3rAPaeXcHJHUcWRcsHHnlol/wKJK8XF/3wyjMb3Ov9UWPkCd3urRpRK0JiGvq527qT2Sr5LaVw3Ad9NgBLa0IK0mYqnIVT2bLCS5lg63EqLPVJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ooIuQeV/; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740678585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hwQtXwdz+nRfwMkoG537Y+tMlAkJ6gBqNuVsZ/4bXk8=;
	b=ooIuQeV/o8Waang5wjBnKHn8WmD5JPDz3r+XUOH6i4zQHuNiY0rFLq4oMlq3+atWxf18/C
	YY+wdUcojtHWPY2Z5vgjkUctvSNpP0yO9c11ExMLIV+7RrIIOhkhBNUbn4rX0+mKZlDQtY
	fUDRQ/lnDTQLkJaBhvf4pBUvQ/zBL1M=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] ovl: Use str_on_off() helper in ovl_show_options()
Date: Thu, 27 Feb 2025 18:49:30 +0100
Message-ID: <20250227174929.8262-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_on_off() helper function.

Acked-by: Amir Goldstein <amir73il@gmail.com>
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
2.48.1


