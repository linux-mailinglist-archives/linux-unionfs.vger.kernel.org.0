Return-Path: <linux-unionfs+bounces-611-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DC68910C1
	for <lists+linux-unionfs@lfdr.de>; Fri, 29 Mar 2024 02:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8F328C391
	for <lists+linux-unionfs@lfdr.de>; Fri, 29 Mar 2024 01:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4EA3D0BD;
	Fri, 29 Mar 2024 01:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i64Bjem3"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAFB3BBDB
	for <linux-unionfs@vger.kernel.org>; Fri, 29 Mar 2024 01:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677261; cv=none; b=e4Clwm4/gYFNG/ops7ltDqK6Peb/F99sC9+6JiZSgBAlcYEumrmAqKX2uheerLUAJZ+Le4MxWZKcUoQ32aFNo6s7UR+JUmMpmEvB3t5mw1dVHMOqxfSUZnuOBdAmQ6xBU5Vfo9Lq77FnDGHyp/UPPCoYfxOwI3bWsVVv88yvDvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677261; c=relaxed/simple;
	bh=RyIro3EkoiY+3HAsIMRPzlL5mpldX3bcrAieK2dC6yw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gdgjE4YOzft07gZqr2qy/4Er5FSsVIXPG+yL23uDK8lhyf00hhw4KgGjPxCzR8qlI2pbmFrE6m+Ksyg+LO15PBs6cZ7XG27Q1cGquAFsmHByiONYJlfKTLnzaXZZKMXmjpxwoUBq2YQACfJGXWG5qnAyKFCAtjN4yNk649m089c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i64Bjem3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60ccc3cfa39so27854877b3.2
        for <linux-unionfs@vger.kernel.org>; Thu, 28 Mar 2024 18:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677259; x=1712282059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4H9jwrEyVjW9lQYUifpGpfprHrYEWKE7Hq9AeQThRu4=;
        b=i64Bjem3CrihJB5MnEEFDFEKjBnVT6kPurADrx8f43QYYKq/YiQFIdj1mmDh/0y9gx
         ZeM8bnDDopH1gW58sVeb7oD8pFwOSxZ3j0MZpNe+r2YH+y9shqGzlzeX/8UJt87CQ2nH
         i7Qta8Np3iarl+wZ+nYFmY0e5jUHyHyd1W0CUMwcZD7o1JmfghCpeBdoWIjLh3vovi3Z
         CgEN0VyYcMEDFFcTFZPLVvAKqHan62U4c5eeeLW7iy1I02JrUK9i2bkNXjAitlZkrSW7
         iLAgZ+Bvu0ZNXZsu7ZaO1uCl/gs2qELUyW6LpUbwuNIxLU0N1DMNMCwrviLIv835Kn5j
         1pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677259; x=1712282059;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4H9jwrEyVjW9lQYUifpGpfprHrYEWKE7Hq9AeQThRu4=;
        b=bNUwTz/efrlG3Qxd+UsYl9SDG4jERxTSKVJ7vqZS/HvmkTQj9c3w7iTj1AdBAspT9z
         CS5mPynlzOWbhhfHvX9+4A9aYjLZi9z4fv9G4rZT6cMRuC7DnZWHxK3E00OLanSS3n8b
         Xg3Zj2qTKWVMmnYnOlI3ueDK5SS52/Kg5+MFFI0eZgfjjdO1p7Aio9D1+tFAsAlgSecv
         liVfOu/NrJIUzdror+NdcLqRqZqL2UlXpCBxB26Bb3PX18MYFP/cCzCRkeoyaPgKP6t6
         FeNwi3EZcMcHbG7zS+M2n/GrO2dOP7yVPVfT3RGhRV4UqA5HP4eUdtJhlve8uUqqXAfi
         3HLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp18I6OTiAr3r9NL2aFN5VBrDHSOo5fJbIuk6hDaZZowEYjoZkyDP/XCXT5ZpJY8sCXk3qBgLiDJBFhUdTUC6wazGVAhM6y+T2KYwqTA==
X-Gm-Message-State: AOJu0YwYD+y/lWeaM9/UevGTg0Xjk4qrXtbbhUZ/9I/AaxFis2CWXqpn
	NsUWg5YGYfotGEgWnQsqzlR4YXEMe0Vr8GB+HlGCoK+EdcxnoGB6s2LKAaOGcAVMXrv5xZ/I4nO
	ezw==
X-Google-Smtp-Source: AGHT+IHPJEbSa2A0quAGCXxs0y5QrngqO3/MgdqYF7v/sQ3XbarIyz8QwwSXUNDKGtp9jqGgm8cj8LL2bTA=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a05:6902:218b:b0:dcd:875:4c40 with SMTP id
 dl11-20020a056902218b00b00dcd08754c40mr305761ybb.10.1711677259230; Thu, 28
 Mar 2024 18:54:19 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:24 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-10-drosen@google.com>
Subject: [RFC PATCH v4 09/36] fuse-bpf: Add lseek support
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

This adds backing support for FUSE_LSEEK

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c    |  3 ++
 fs/fuse/fuse_i.h  |  6 ++++
 3 files changed, 98 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 331b3f23ef78..04cb0c0c10b0 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -210,6 +210,95 @@ static void fuse_stat_to_attr(struct fuse_conn *fc, struct inode *inode,
 	attr->blksize = 1 << blkbits;
 }
 
+struct fuse_lseek_args {
+	struct fuse_lseek_in in;
+	struct fuse_lseek_out out;
+};
+
+static int fuse_lseek_initialize_in(struct bpf_fuse_args *fa, struct fuse_lseek_args *args,
+				    struct file *file, loff_t offset, int whence)
+{
+	struct fuse_file *fuse_file = file->private_data;
+
+	args->in = (struct fuse_lseek_in) {
+		.fh = fuse_file->fh,
+		.offset = offset,
+		.whence = whence,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = get_node_id(file->f_inode),
+			.opcode = FUSE_LSEEK,
+		},
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(args->in),
+		.in_args[0].value = &args->in,
+	};
+
+	return 0;
+}
+
+static int fuse_lseek_initialize_out(struct bpf_fuse_args *fa, struct fuse_lseek_args *args,
+				     struct file *file, loff_t offset, int whence)
+{
+	fa->out_numargs = 1;
+	fa->out_args[0].size = sizeof(args->out);
+	fa->out_args[0].value = &args->out;
+
+	return 0;
+}
+
+static int fuse_lseek_backing(struct bpf_fuse_args *fa, loff_t *out,
+			      struct file *file, loff_t offset, int whence)
+{
+	const struct fuse_lseek_in *fli = fa->in_args[0].value;
+	struct fuse_lseek_out *flo = fa->out_args[0].value;
+	struct fuse_file *fuse_file = file->private_data;
+	struct file *backing_file = fuse_file->backing_file;
+
+	/* TODO: Handle changing of the file handle */
+	if (offset == 0) {
+		if (whence == SEEK_CUR) {
+			flo->offset = file->f_pos;
+			*out = flo->offset;
+			return 0;
+		}
+
+		if (whence == SEEK_SET) {
+			flo->offset = vfs_setpos(file, 0, 0);
+			*out = flo->offset;
+			return 0;
+		}
+	}
+
+	inode_lock(file->f_inode);
+	backing_file->f_pos = file->f_pos;
+	*out = vfs_llseek(backing_file, fli->offset, fli->whence);
+	flo->offset = *out;
+	inode_unlock(file->f_inode);
+	return 0;
+}
+
+static int fuse_lseek_finalize(struct bpf_fuse_args *fa, loff_t *out,
+			       struct file *file, loff_t offset, int whence)
+{
+	struct fuse_lseek_out *flo = fa->out_args[0].value;
+
+	if (!fa->info.error_in)
+		file->f_pos = flo->offset;
+	*out = flo->offset;
+	return 0;
+}
+
+int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence)
+{
+	return bpf_fuse_backing(inode, struct fuse_lseek_args, out,
+				fuse_lseek_initialize_in, fuse_lseek_initialize_out,
+				fuse_lseek_backing, fuse_lseek_finalize,
+				file, offset, whence);
+}
+
 ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	int ret;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b15a0c30fec8..b3cae6e677f8 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2740,6 +2740,9 @@ static loff_t fuse_file_llseek(struct file *file, loff_t offset, int whence)
 	loff_t retval;
 	struct inode *inode = file_inode(file);
 
+	if (fuse_bpf_lseek(&retval, inode, file, offset, whence))
+		return retval;
+
 	switch (whence) {
 	case SEEK_SET:
 	case SEEK_CUR:
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 5f76ba3c1e4b..24f453d162ae 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1438,11 +1438,17 @@ int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num_entries);
 
 #ifdef CONFIG_FUSE_BPF
 
+int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence);
 int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags);
 int fuse_bpf_access(int *out, struct inode *inode, int mask);
 
 #else
 
+static inline int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags)
 {
 	return 0;
-- 
2.44.0.478.gd926399ef9-goog


