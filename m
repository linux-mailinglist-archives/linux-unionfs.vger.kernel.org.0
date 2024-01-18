Return-Path: <linux-unionfs+bounces-203-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16C88316C1
	for <lists+linux-unionfs@lfdr.de>; Thu, 18 Jan 2024 11:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D4D1C22048
	for <lists+linux-unionfs@lfdr.de>; Thu, 18 Jan 2024 10:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388D9224C1;
	Thu, 18 Jan 2024 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzMsOvf3"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8163522336
	for <linux-unionfs@vger.kernel.org>; Thu, 18 Jan 2024 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705574513; cv=none; b=la5EqxcYDUK1QekwAQMLF6bMUulm6Dms0HnJG+Ze40PN3exZY9KCZXSonXMgL4psmWtgGweEOTjLyGtbZ7ozzD7hAYlX+3bVuF69/HoaQAEte7qWARBCL0pZQoQ2ifgP3waXoLWmla5goyOJfYrwFoWiCONAT3BY1LI3mA7Phbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705574513; c=relaxed/simple;
	bh=BMMcxk5CvVEIMezGrY2WgL+UzNwGmc5hbcrTuntDYLE=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding; b=SPSep0xw6SnEa6EKPPCG3LT3k/AYllgCNksIjXBEH5GEUvYd9IN72sRCRwHr7vX4yDay4G6LBj0gXDzIYsUitePNYArgOUyRRBlBzmhdid00nlGMDmdGAvaznJ+gr+zO9OpbqwAjVT8gahvwQBzNdlzFY5oN6rBlQMbCCgvFUI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZzMsOvf3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705574510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2EqGGKd17lUXk2wVDIBU7VuyLBwm/9zE6uT64RJyRhc=;
	b=ZzMsOvf3g7etcDge6Wr8gJKDFJ/mh2Lslu2JbKuxbrOP9Q3D8J1E69iv2IxoaKUQpM0O+y
	p3wjGHOM23oD8jLHamvKmvYSdom7OJ4LZa9/wz2UXA4ZUHTs3TJ7J3FVTiCJRAZ2HQAGuJ
	UwNKLSoCMqvuu7CRo7QxwvbwE/6q4qo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-izUawAPVMXeqSM6t_sf-AQ-1; Thu, 18 Jan 2024 05:41:48 -0500
X-MC-Unique: izUawAPVMXeqSM6t_sf-AQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-559391de41bso2356929a12.3
        for <linux-unionfs@vger.kernel.org>; Thu, 18 Jan 2024 02:41:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705574507; x=1706179307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2EqGGKd17lUXk2wVDIBU7VuyLBwm/9zE6uT64RJyRhc=;
        b=cxkGCm8KDp++OxfFADGBA0I31JrWpUoBPLK2f/DMyFWq1qWrFh13DvuKh4yP/Tj/Yz
         YugCQDopDAD0R0NfUxA9bs0O2N2KEbBLNe4H5o5x9uJdEMx3uK1+TCu0gGUgsq3X2vFC
         6zVrnx85Mx2q4Ajnmg1SrfKlN2k0JCMBg+vGanD2DkIyFDEbrV0A3a9+6rbFWPwtXWlf
         VKjf/AOtnL/rvnVrI8AjzRiFTgvyQJYOImWZIqRt1yLcLrAhs66uCklfj3iSlux9IRyW
         jelhlL8HITpfxjnl9uSLSNJsF6GQiIZV3AU7YP62zRocdBwXdKFG0DLyZu5YbDKJQJVO
         oong==
X-Gm-Message-State: AOJu0YzH18r0l/vUla8L6PvG4eCQBNt56/VMijx+DvtFH+IXJZtzs3r1
	z+t7VcHdMZFLbBIa/+zaD77J7TKwbnpwT9fg+IXbPFebofKjkUDZVZNygj+OigDuyUKR4Wjk5Ys
	/ErmTcsZn4coXX2ZUxxu1oRAMEMLnu/srGtz5cXbdbyaf2wDIfFSYEuuWwx6DICILTpNphHE6A8
	FFfHiKbsgFLm90I6QIOm9oNpw2QseHqHIllAGt6qj4+EmBAMk=
X-Received: by 2002:aa7:d890:0:b0:55a:780:2d8f with SMTP id u16-20020aa7d890000000b0055a07802d8fmr348130edq.56.1705574506866;
        Thu, 18 Jan 2024 02:41:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkho3/Ip5launwmY4VziprZ6rh9zT/WsRSct+xk2YHylOwjqHH91k1fu63xSEZlgOZqn9Rjw==
X-Received: by 2002:aa7:d890:0:b0:55a:780:2d8f with SMTP id u16-20020aa7d890000000b0055a07802d8fmr348123edq.56.1705574506504;
        Thu, 18 Jan 2024 02:41:46 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (213-197-79-37.pool.digikabel.hu. [213.197.79.37])
        by smtp.gmail.com with ESMTPSA id h26-20020aa7c95a000000b005590dc6a4f6sm6814402edt.80.2024.01.18.02.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 02:41:45 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Alexander Larsson <alexl@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ovl: require xwhiteout feature flag on layer roots
Date: Thu, 18 Jan 2024 11:41:42 +0100
Message-ID: <20240118104144.465158-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a check on each layer for the xwhiteout feature.  This prevents
unnecessary checking the overlay.whiteouts xattr when reading a
directory if this feature is not enabled, i.e. most of the time.

Fixes: bc8df7a3dc03 ("ovl: Add an alternative type of whiteout")
Cc: <stable@vger.kernel.org> # v6.7
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---

Hi Alex,

Can you please test this in your environment?

I xwhiteout test in xfstests needs this tweak:

--- a/tests/overlay/084
+++ b/tests/overlay/084
@@ -115,6 +115,7 @@ do_test_xwhiteout()
 
 	mkdir -p $basedir/lower $basedir/upper $basedir/work
 	touch $basedir/lower/regular $basedir/lower/hidden  $basedir/upper/hidden
+	setfattr -n $prefix.overlay.feature_xwhiteout -v "y" $basedir/upper
 	setfattr -n $prefix.overlay.whiteouts -v "y" $basedir/upper
 	setfattr -n $prefix.overlay.whiteout -v "y" $basedir/upper/hidden
 

Thanks,
Miklos

fs/overlayfs/namei.c     | 10 +++++++---
 fs/overlayfs/overlayfs.h |  8 ++++++--
 fs/overlayfs/ovl_entry.h |  2 ++
 fs/overlayfs/readdir.c   | 11 ++++++++---
 fs/overlayfs/super.c     | 13 ++++++++++++-
 fs/overlayfs/util.c      |  9 ++++++++-
 6 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 03bc8d5dfa31..583cf56df66e 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -863,7 +863,8 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
  * Returns next layer in stack starting from top.
  * Returns -1 if this is the last layer.
  */
-int ovl_path_next(int idx, struct dentry *dentry, struct path *path)
+int ovl_path_next(int idx, struct dentry *dentry, struct path *path,
+		  const struct ovl_layer **layer)
 {
 	struct ovl_entry *oe = OVL_E(dentry);
 	struct ovl_path *lowerstack = ovl_lowerstack(oe);
@@ -871,13 +872,16 @@ int ovl_path_next(int idx, struct dentry *dentry, struct path *path)
 	BUG_ON(idx < 0);
 	if (idx == 0) {
 		ovl_path_upper(dentry, path);
-		if (path->dentry)
+		if (path->dentry) {
+			*layer = &OVL_FS(dentry->d_sb)->layers[0];
 			return ovl_numlower(oe) ? 1 : -1;
+		}
 		idx++;
 	}
 	BUG_ON(idx > ovl_numlower(oe));
 	path->dentry = lowerstack[idx - 1].dentry;
-	path->mnt = lowerstack[idx - 1].layer->mnt;
+	*layer = lowerstack[idx - 1].layer;
+	path->mnt = (*layer)->mnt;
 
 	return (idx < ovl_numlower(oe)) ? idx + 1 : -1;
 }
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 05c3dd597fa8..991eb5d5c66c 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -51,6 +51,7 @@ enum ovl_xattr {
 	OVL_XATTR_PROTATTR,
 	OVL_XATTR_XWHITEOUT,
 	OVL_XATTR_XWHITEOUTS,
+	OVL_XATTR_FEATURE_XWHITEOUT,
 };
 
 enum ovl_inode_flag {
@@ -492,7 +493,9 @@ bool ovl_path_check_dir_xattr(struct ovl_fs *ofs, const struct path *path,
 			      enum ovl_xattr ox);
 bool ovl_path_check_origin_xattr(struct ovl_fs *ofs, const struct path *path);
 bool ovl_path_check_xwhiteout_xattr(struct ovl_fs *ofs, const struct path *path);
-bool ovl_path_check_xwhiteouts_xattr(struct ovl_fs *ofs, const struct path *path);
+bool ovl_path_check_xwhiteouts_xattr(struct ovl_fs *ofs,
+				     const struct ovl_layer *layer,
+				     const struct path *path);
 bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs,
 			 const struct path *upperpath);
 
@@ -674,7 +677,8 @@ int ovl_get_index_name(struct ovl_fs *ofs, struct dentry *origin,
 struct dentry *ovl_get_index_fh(struct ovl_fs *ofs, struct ovl_fh *fh);
 struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
 				struct dentry *origin, bool verify);
-int ovl_path_next(int idx, struct dentry *dentry, struct path *path);
+int ovl_path_next(int idx, struct dentry *dentry, struct path *path,
+		  const struct ovl_layer **layer);
 int ovl_verify_lowerdata(struct dentry *dentry);
 struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			  unsigned int flags);
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index d82d2a043da2..51729e614f5a 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -40,6 +40,8 @@ struct ovl_layer {
 	int idx;
 	/* One fsid per unique underlying sb (upper fsid == 0) */
 	int fsid;
+	/* xwhiteouts are enabled on this layer*/
+	bool feature_xwhiteout;
 };
 
 struct ovl_path {
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index a490fc47c3e7..c2597075e3f8 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -305,8 +305,6 @@ static inline int ovl_dir_read(const struct path *realpath,
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
 
-	rdd->in_xwhiteouts_dir = rdd->dentry &&
-		ovl_path_check_xwhiteouts_xattr(OVL_FS(rdd->dentry->d_sb), realpath);
 	rdd->first_maybe_whiteout = NULL;
 	rdd->ctx.pos = 0;
 	do {
@@ -359,10 +357,14 @@ static int ovl_dir_read_merged(struct dentry *dentry, struct list_head *list,
 		.is_lowest = false,
 	};
 	int idx, next;
+	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
+	const struct ovl_layer *layer;
 
 	for (idx = 0; idx != -1; idx = next) {
-		next = ovl_path_next(idx, dentry, &realpath);
+		next = ovl_path_next(idx, dentry, &realpath, &layer);
 		rdd.is_upper = ovl_dentry_upper(dentry) == realpath.dentry;
+		if (ovl_path_check_xwhiteouts_xattr(ofs, layer, &realpath))
+			rdd.in_xwhiteouts_dir = true;
 
 		if (next != -1) {
 			err = ovl_dir_read(&realpath, &rdd);
@@ -568,6 +570,7 @@ static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
 	int err;
 	struct path realpath;
 	struct ovl_cache_entry *p, *n;
+	struct ovl_fs *ofs = OVL_FS(path->dentry->d_sb);
 	struct ovl_readdir_data rdd = {
 		.ctx.actor = ovl_fill_plain,
 		.list = list,
@@ -577,6 +580,8 @@ static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
 	INIT_LIST_HEAD(list);
 	*root = RB_ROOT;
 	ovl_path_upper(path->dentry, &realpath);
+	if (ovl_path_check_xwhiteouts_xattr(ofs, &ofs->layers[0], &realpath))
+		rdd.in_xwhiteouts_dir = true;
 
 	err = ovl_dir_read(&realpath, &rdd);
 	if (err)
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index a0967bb25003..4e507ab780f3 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1291,7 +1291,7 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct ovl_entry *oe;
 	struct ovl_layer *layers;
 	struct cred *cred;
-	int err;
+	int err, i;
 
 	err = -EIO;
 	if (WARN_ON(fc->user_ns != current_user_ns()))
@@ -1414,6 +1414,17 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		goto out_free_oe;
 
+	for (i = 0; i < ofs->numlayer; i++) {
+		struct path path = { .mnt = layers[i].mnt };
+
+		if (path.mnt) {
+			path.dentry = path.mnt->mnt_root;
+			err = ovl_path_getxattr(ofs, &path, OVL_XATTR_FEATURE_XWHITEOUT, NULL, 0);
+			if (err >= 0)
+				layers[i].feature_xwhiteout = true;
+		}
+	}
+
 	/* Show index=off in /proc/mounts for forced r/o mount */
 	if (!ofs->indexdir) {
 		ofs->config.index = false;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index c3f020ca13a8..cae8219618e3 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -739,11 +739,16 @@ bool ovl_path_check_xwhiteout_xattr(struct ovl_fs *ofs, const struct path *path)
 	return res >= 0;
 }
 
-bool ovl_path_check_xwhiteouts_xattr(struct ovl_fs *ofs, const struct path *path)
+bool ovl_path_check_xwhiteouts_xattr(struct ovl_fs *ofs,
+				     const struct ovl_layer *layer,
+				     const struct path *path)
 {
 	struct dentry *dentry = path->dentry;
 	int res;
 
+	if (!layer->feature_xwhiteout)
+		return false;
+
 	/* xattr.whiteouts must be a directory */
 	if (!d_is_dir(dentry))
 		return false;
@@ -838,6 +843,7 @@ bool ovl_path_check_dir_xattr(struct ovl_fs *ofs, const struct path *path,
 #define OVL_XATTR_PROTATTR_POSTFIX	"protattr"
 #define OVL_XATTR_XWHITEOUT_POSTFIX	"whiteout"
 #define OVL_XATTR_XWHITEOUTS_POSTFIX	"whiteouts"
+#define OVL_XATTR_FEATURE_XWHITEOUT_POSTFIX	"feature_xwhiteout"
 
 #define OVL_XATTR_TAB_ENTRY(x) \
 	[x] = { [false] = OVL_XATTR_TRUSTED_PREFIX x ## _POSTFIX, \
@@ -855,6 +861,7 @@ const char *const ovl_xattr_table[][2] = {
 	OVL_XATTR_TAB_ENTRY(OVL_XATTR_PROTATTR),
 	OVL_XATTR_TAB_ENTRY(OVL_XATTR_XWHITEOUT),
 	OVL_XATTR_TAB_ENTRY(OVL_XATTR_XWHITEOUTS),
+	OVL_XATTR_TAB_ENTRY(OVL_XATTR_FEATURE_XWHITEOUT),
 };
 
 int ovl_check_setxattr(struct ovl_fs *ofs, struct dentry *upperdentry,
-- 
2.43.0


