Return-Path: <linux-unionfs+bounces-1742-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE01B00F8B
	for <lists+linux-unionfs@lfdr.de>; Fri, 11 Jul 2025 01:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F5856247A
	for <lists+linux-unionfs@lfdr.de>; Thu, 10 Jul 2025 23:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB482C1596;
	Thu, 10 Jul 2025 23:21:33 +0000 (UTC)
X-Original-To: linux-unionfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFFC2D0C73;
	Thu, 10 Jul 2025 23:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189693; cv=none; b=gdZPUzD/4G+1LTdbp0BEZcnmMn075eKgr8BFA+hMgO64yM8+F3KT+Vj30ggDcpPkl2I/I3u9uQEfjVC/NqZhovP1kBl7MFixM4ZnK+AVDQuuWKJAcNPi0GXg0Dj0sOKeO+HcJDErXrUUC7f4W/bE9QeRCnOLQAEeYHO/SmpbcqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189693; c=relaxed/simple;
	bh=33Dtj51zeqObE0uJi9cBwR1LK/sqCxadVpYR7oHLFYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p85BXRVAaV4S7maFn1OG1jiJHuiNENCdX3/uDmM3lKT6AdVLm+jblGUgm8VHlM1oK+DXIkZWBB5Me6Z+Z4Ih1N4/xfS3+T+C6LhK9hgQf3fOvsetuVlrInIKW4c6kGm0GmvNVgpJdDSdbmHm3mEwbfmvvh9ilepiBo0NbXgk7Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ua0Zu-001XGg-9x;
	Thu, 10 Jul 2025 23:21:24 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/20] ovl: narrow locking in ovl_workdir_create()
Date: Fri, 11 Jul 2025 09:03:41 +1000
Message-ID: <20250710232109.3014537-12-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710232109.3014537-1-neil@brown.name>
References: <20250710232109.3014537-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ovl_workdir_create() don't hold the dir lock for the whole time, but
only take it when needed.

It now gets taken separately for ovl_workdir_cleanup().  A subsequent
patch will move the locking into that function.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/super.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 9cce3251dd83..239ae1946edf 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -299,8 +299,8 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 	int err;
 	bool retried = false;
 
-	inode_lock_nested(dir, I_MUTEX_PARENT);
 retry:
+	inode_lock_nested(dir, I_MUTEX_PARENT);
 	work = ovl_lookup_upper(ofs, name, ofs->workbasedir, strlen(name));
 
 	if (!IS_ERR(work)) {
@@ -311,23 +311,27 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 
 		if (work->d_inode) {
 			err = -EEXIST;
+			inode_unlock(dir);
 			if (retried)
 				goto out_dput;
 
 			if (persist)
-				goto out_unlock;
+				goto out;
 
 			retried = true;
+			inode_lock_nested(dir, I_MUTEX_PARENT);
 			err = ovl_workdir_cleanup(ofs, dir, mnt, work, 0);
+			inode_unlock(dir);
 			dput(work);
 			if (err == -EINVAL) {
 				work = ERR_PTR(err);
-				goto out_unlock;
+				goto out;
 			}
 			goto retry;
 		}
 
 		work = ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
+		inode_unlock(dir);
 		err = PTR_ERR(work);
 		if (IS_ERR(work))
 			goto out_err;
@@ -365,11 +369,11 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 		if (err)
 			goto out_dput;
 	} else {
+		inode_unlock(dir);
 		err = PTR_ERR(work);
 		goto out_err;
 	}
-out_unlock:
-	inode_unlock(dir);
+out:
 	return work;
 
 out_dput:
@@ -378,7 +382,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 	pr_warn("failed to create directory %s/%s (errno: %i); mounting read-only\n",
 		ofs->config.workdir, name, -err);
 	work = NULL;
-	goto out_unlock;
+	goto out;
 }
 
 static int ovl_check_namelen(const struct path *path, struct ovl_fs *ofs,
-- 
2.49.0


