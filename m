Return-Path: <linux-unionfs+bounces-617-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE118910E0
	for <lists+linux-unionfs@lfdr.de>; Fri, 29 Mar 2024 03:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0FE1C27A25
	for <lists+linux-unionfs@lfdr.de>; Fri, 29 Mar 2024 02:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E6B4CE05;
	Fri, 29 Mar 2024 01:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GQm3uyRA"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E0C47F53
	for <linux-unionfs@vger.kernel.org>; Fri, 29 Mar 2024 01:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677276; cv=none; b=BdLz18A7ubgRsjszIfa1GkaZ5l0TEIBylqWf1ama1aGOHm8/PggBN166cydLAbZ1T02UJv6HsTCM+vx36Vsc8V/Om4VPP2qcIMzX0SUmHPruakyybJVOVtTMKN0ZtK87ztu+qYKLs9RNH6G80jvT3oz1rGU5+Fpq/Kk2XuiWWAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677276; c=relaxed/simple;
	bh=d6XQ8+/DWf1czNCtAiutzGlVADJoXHinAhM0DHxR/QA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gTXaQWwgcw/832vRfYVk5Nj4NAy6sOwggubQH96OY3bT4o7FCG6tSo3gxGejumiU0SbU18yY8uUCMgDygYkg14jn+k7hMyQXTywwzSoU/W5pDd93wRqN/8mrwf3RydtrSxu575ol7Q9CufKlY07UwNm9eJFKBV7u4bBB9QSU5N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GQm3uyRA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60ff1816749so27309217b3.3
        for <linux-unionfs@vger.kernel.org>; Thu, 28 Mar 2024 18:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677273; x=1712282073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3+lkznFfF063HHzwkoJDdJMsZxmqXbX6KWo4G9DjKXc=;
        b=GQm3uyRAKoMVVUSLsUYQj91y4SKhc5ya3owuo3Vc5YV/YAhw6ipAiGZCcCw6vzC8FE
         Q7cZb6A/ZoPSrJdqElMgV3jgSJKFLZHPV0DXdrOqoHiRcbeL+z5DppldRkctA3naGYJU
         bVcNjKhE4Mw5LU3ESFLbiGd3AeBlhWnqmrxDjUVpaKqB++BCnpISvww+U7YMEp/i+wTF
         FEuQgSb7VvuZCsUX+9v/Twcy/k+M7IlOnJlQS4l7q3OR8mDYo1nY9yU9F2fCwb4a525V
         LXWsTnkuNklbWuNIriRo60KwK31gvWpUzeRuehT3NDTID4zVp00HI5XgJzJQFsDqYtZi
         Y2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677273; x=1712282073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+lkznFfF063HHzwkoJDdJMsZxmqXbX6KWo4G9DjKXc=;
        b=t/kRXsf/dbXVRUBzDVBttwlCRMse2iv294rv5CHzkdNxSGl4wYlFtxsklYcz8tGmsC
         e6YoSqy9Ep6Gw2t1qoFqSU72y/4LyZaOrZlTLXMpRxkhfaxhoYMLQiMlhuqL1LDAwQxJ
         rmXCFSdKg70Xg9/WESXDSRbcImxWC1WUHlAiMUzO1yKzvTQL1vFWNdvFiB6hc261nlTo
         t6JKwr8qeoVNDzgSzwNEQCZYjbJFSRzcUpDfMlkDuJ3uDVbwD+I+qqdNneVxowCTvLxE
         sOU/38sLFyOdHjtB+bUazZwA73lzib0we0VNatz12BQ6dwLiH4GHV+R5Hr33CA6TFGhY
         xbDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvcq4+0fYpaDrnoWmGQW0cEkioZ8xhaNgV+i9gAuJQxuxbnkDEIIddKMjpLFojFgOe4/SWGsTo+JxpdMGVoVHb+72+v89fYL49sr85DA==
X-Gm-Message-State: AOJu0YwlXwSHebCp/ogc68cc12cVO0TL7EAfYoTcQuDa5MoSR80hNzB9
	dLK9J1hx5ftLdMai9CS8NCJt7EEhz5Wc48TIU4wU1x0CrRwK9j+cWKcz9IDq6fpe/sU7ZUDBvRa
	AHg==
X-Google-Smtp-Source: AGHT+IHrCCmpyf/OqCQ46h7LCN/Lnch/y2R023tiapJl1iefGq5MDaGFFeXGiwNx4r+71k0zAdiUn/mnDts=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a05:6902:160f:b0:dc6:ebd4:cca2 with SMTP id
 bw15-20020a056902160f00b00dc6ebd4cca2mr72793ybb.11.1711677272326; Thu, 28 Mar
 2024 18:54:32 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:30 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-16-drosen@google.com>
Subject: [RFC PATCH v4 15/36] fuse-bpf: Add support for sync operations
From: Daniel Rosenberg <drosen@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	Daniel Rosenberg <drosen@google.com>, Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"

This adds backing support for FUSE_FLUSH, FUSE_FSYNC, and FUSE_FSYNCDIR.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     |   3 +
 fs/fuse/file.c    |   6 ++
 fs/fuse/fuse_i.h  |  18 ++++++
 4 files changed, 174 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 0182236c2735..c2c5cb3d3d6e 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -636,6 +636,59 @@ int fuse_bpf_releasedir(int *out, struct inode *inode, struct fuse_file *ff)
 				fuse_release_backing, fuse_release_finalize, inode, ff);
 }
 
+static int fuse_flush_initialize_in(struct bpf_fuse_args *fa, struct fuse_flush_in *ffi,
+				    struct file *file, fl_owner_t id)
+{
+	struct fuse_file *fuse_file = file->private_data;
+
+	*ffi = (struct fuse_flush_in) {
+		.fh = fuse_file->fh,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(file->f_inode),
+			.opcode = FUSE_FLUSH,
+		},
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(*ffi),
+		.in_args[0].value = ffi,
+		.flags = FUSE_BPF_FORCE,
+	};
+
+	return 0;
+}
+
+static int fuse_flush_initialize_out(struct bpf_fuse_args *fa, struct fuse_flush_in *ffi,
+				     struct file *file, fl_owner_t id)
+{
+	return 0;
+}
+
+static int fuse_flush_backing(struct bpf_fuse_args *fa, int *out, struct file *file, fl_owner_t id)
+{
+	struct fuse_file *fuse_file = file->private_data;
+	struct file *backing_file = fuse_file->backing_file;
+
+	*out = 0;
+	if (backing_file->f_op->flush)
+		*out = backing_file->f_op->flush(backing_file, id);
+	return *out;
+}
+
+static int fuse_flush_finalize(struct bpf_fuse_args *fa, int *out, struct file *file, fl_owner_t id)
+{
+	return 0;
+}
+
+int fuse_bpf_flush(int *out, struct inode *inode, struct file *file, fl_owner_t id)
+{
+	return bpf_fuse_backing(inode, struct fuse_flush_in, out,
+				fuse_flush_initialize_in, fuse_flush_initialize_out,
+				fuse_flush_backing, fuse_flush_finalize,
+				file, id);
+}
+
 struct fuse_lseek_args {
 	struct fuse_lseek_in in;
 	struct fuse_lseek_out out;
@@ -725,6 +778,100 @@ int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t o
 				file, offset, whence);
 }
 
+static int fuse_fsync_initialize_in(struct bpf_fuse_args *fa, struct fuse_fsync_in *in,
+				    struct file *file, loff_t start, loff_t end, int datasync)
+{
+	struct fuse_file *fuse_file = file->private_data;
+
+	*in = (struct fuse_fsync_in) {
+		.fh = fuse_file->fh,
+		.fsync_flags = datasync ? FUSE_FSYNC_FDATASYNC : 0,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_fuse_inode(file->f_inode)->nodeid,
+			.opcode = FUSE_FSYNC,
+		},
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(*in),
+		.in_args[0].value = in,
+		.flags = FUSE_BPF_FORCE,
+	};
+
+	return 0;
+}
+
+static int fuse_fsync_initialize_out(struct bpf_fuse_args *fa, struct fuse_fsync_in *ffi,
+				     struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return 0;
+}
+
+static int fuse_fsync_backing(struct bpf_fuse_args *fa, int *out,
+			      struct file *file, loff_t start, loff_t end, int datasync)
+{
+	struct fuse_file *fuse_file = file->private_data;
+	struct file *backing_file = fuse_file->backing_file;
+	const struct fuse_fsync_in *ffi = fa->in_args[0].value;
+	int new_datasync = (ffi->fsync_flags & FUSE_FSYNC_FDATASYNC) ? 1 : 0;
+
+	*out = vfs_fsync(backing_file, new_datasync);
+	return 0;
+}
+
+static int fuse_fsync_finalize(struct bpf_fuse_args *fa, int *out,
+			       struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return 0;
+}
+
+int fuse_bpf_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return bpf_fuse_backing(inode, struct fuse_fsync_in, out,
+				fuse_fsync_initialize_in, fuse_fsync_initialize_out,
+				fuse_fsync_backing, fuse_fsync_finalize,
+				file, start, end, datasync);
+}
+
+static int fuse_dir_fsync_initialize_in(struct bpf_fuse_args *fa, struct fuse_fsync_in *in,
+					struct file *file, loff_t start, loff_t end, int datasync)
+{
+	struct fuse_file *fuse_file = file->private_data;
+
+	*in = (struct fuse_fsync_in) {
+		.fh = fuse_file->fh,
+		.fsync_flags = datasync ? FUSE_FSYNC_FDATASYNC : 0,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_fuse_inode(file->f_inode)->nodeid,
+			.opcode = FUSE_FSYNCDIR,
+		},
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(*in),
+		.in_args[0].value = in,
+		.flags = FUSE_BPF_FORCE,
+	};
+
+	return 0;
+}
+
+static int fuse_dir_fsync_initialize_out(struct bpf_fuse_args *fa, struct fuse_fsync_in *ffi,
+					 struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return 0;
+}
+
+int fuse_bpf_dir_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return bpf_fuse_backing(inode, struct fuse_fsync_in, out,
+				fuse_dir_fsync_initialize_in, fuse_dir_fsync_initialize_out,
+				fuse_fsync_backing, fuse_fsync_finalize,
+				file, start, end, datasync);
+}
+
 static inline void fuse_bpf_aio_put(struct fuse_bpf_aio_req *aio_req)
 {
 	if (refcount_dec_and_test(&aio_req->ref))
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index a5b6aef788b2..7b661fcd5470 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1785,6 +1785,9 @@ static int fuse_dir_fsync(struct file *file, loff_t start, loff_t end,
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_bpf_dir_fsync(&err, inode, file, start, end, datasync))
+		return err;
+
 	if (fc->no_fsyncdir)
 		return 0;
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3443510027a5..5983faf59c1f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -510,6 +510,9 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_bpf_flush(&err, file_inode(file), file, id))
+		return err;
+
 	if (ff->open_flags & FOPEN_NOFLUSH && !fm->fc->writeback_cache)
 		return 0;
 
@@ -585,6 +588,9 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_bpf_fsync(&err, inode, file, start, end, datasync))
+		return err;
+
 	inode_lock(inode);
 
 	/*
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ab52003de194..256e217880c8 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1447,7 +1447,10 @@ int fuse_bpf_rmdir(int *out, struct inode *dir, struct dentry *entry);
 int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry);
 int fuse_bpf_release(int *out, struct inode *inode, struct fuse_file *ff);
 int fuse_bpf_releasedir(int *out, struct inode *inode, struct fuse_file *ff);
+int fuse_bpf_flush(int *out, struct inode *inode, struct file *file, fl_owner_t id);
 int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence);
+int fuse_bpf_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync);
+int fuse_bpf_dir_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync);
 int fuse_bpf_file_read_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *to);
 int fuse_bpf_file_write_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *from);
 int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length);
@@ -1498,11 +1501,26 @@ static inline int fuse_bpf_releasedir(int *out, struct inode *inode, struct file
 	return 0;
 }
 
+static inline int fuse_bpf_flush(int *out, struct inode *inode, struct file *file, fl_owner_t id)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence)
 {
 	return 0;
 }
 
+static inline int fuse_bpf_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return 0;
+}
+
+static inline int fuse_bpf_dir_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_file_read_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *to)
 {
 	return 0;
-- 
2.44.0.478.gd926399ef9-goog


