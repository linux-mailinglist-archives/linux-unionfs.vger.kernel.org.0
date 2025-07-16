Return-Path: <linux-unionfs+bounces-1788-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D92FEB06AC6
	for <lists+linux-unionfs@lfdr.de>; Wed, 16 Jul 2025 02:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312E816EF56
	for <lists+linux-unionfs@lfdr.de>; Wed, 16 Jul 2025 00:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C85A19AD5C;
	Wed, 16 Jul 2025 00:47:36 +0000 (UTC)
X-Original-To: linux-unionfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921967261D;
	Wed, 16 Jul 2025 00:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626856; cv=none; b=eVkIiuwCyQBioMHE/NIfJd/b33mjepovofAgEwUsmeHg0pUGxJ6TOS0e/4r2z0ZL9UFzOmZG+Iwwa2r27CAbj2kb9UTddO27qA5a17ZE+qr+b6KWuhZHh1nDpFMUVlda6Jk/kbQbfser5tNBHhmePwz1kjCjzGEmi8M1QntXNkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626856; c=relaxed/simple;
	bh=a+X5gwaGcdzFzOfkFRzl86qGXQFGN/C1DEPJ3AOq9yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oARwPl0lXduOUauqJb70k5XdMwWITQgjk0qInr9m25GsPXuoJamDw4kk/fSey7GVcgPsoiyoKtIxZKCljjrru0BglcTThHQ/7UAUDMPfn+UJWPCJX2IbWDmK6UDql2BV7w0p5pQRNgXrif8qzkxB/FYvhNn7ogXfduicoJnfcE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqJ1-002AAZ-5j;
	Wed, 16 Jul 2025 00:47:32 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 05/21] ovl: narrow locking in ovl_create_upper()
Date: Wed, 16 Jul 2025 10:44:16 +1000
Message-ID: <20250716004725.1206467-6-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250716004725.1206467-1-neil@brown.name>
References: <20250716004725.1206467-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the directory lock immediately after the ovl_create_real() call and
take a separate lock later for cleanup in ovl_cleanup_unlocked() - if
needed.

This makes way for future changes where locks are taken on individual
dentries rather than the whole directory.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/dir.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 373335e420fd..1a146a71993a 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -326,9 +326,9 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 				    ovl_lookup_upper(ofs, dentry->d_name.name,
 						     upperdir, dentry->d_name.len),
 				    attr);
-	err = PTR_ERR(newdentry);
+	inode_unlock(udir);
 	if (IS_ERR(newdentry))
-		goto out_unlock;
+		return PTR_ERR(newdentry);
 
 	if (ovl_type_merge(dentry->d_parent) && d_is_dir(newdentry) &&
 	    !ovl_allow_offline_changes(ofs)) {
@@ -340,14 +340,12 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 	err = ovl_instantiate(dentry, inode, newdentry, !!attr->hardlink, NULL);
 	if (err)
 		goto out_cleanup;
-out_unlock:
-	inode_unlock(udir);
-	return err;
+	return 0;
 
 out_cleanup:
-	ovl_cleanup(ofs, udir, newdentry);
+	ovl_cleanup_unlocked(ofs, upperdir, newdentry);
 	dput(newdentry);
-	goto out_unlock;
+	return err;
 }
 
 static struct dentry *ovl_clear_empty(struct dentry *dentry,
-- 
2.49.0


