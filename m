Return-Path: <linux-unionfs+bounces-616-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3658910D8
	for <lists+linux-unionfs@lfdr.de>; Fri, 29 Mar 2024 02:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128C628BFB9
	for <lists+linux-unionfs@lfdr.de>; Fri, 29 Mar 2024 01:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E350244C8D;
	Fri, 29 Mar 2024 01:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="umdU8kKN"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C2721373
	for <linux-unionfs@vger.kernel.org>; Fri, 29 Mar 2024 01:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677272; cv=none; b=JalFBLNS3EPEhtYco+xdCFgD47jdABh3Jhcc8n0vYZev69kP2ZuTyH+u6IU9ep0b62IDHj1629l/x4pqS5PTh41bzeaxpbyobUtpUcse5/vqrP3Lg73Nis0V/BQKwYF1tMX7dh+T6URlPmDi+R58ooRXLqbMNImxPtuVtV4HXok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677272; c=relaxed/simple;
	bh=6SSatiKOQPv2797ukkf5H5el6HcxXqvKZ4hc3ZglMjM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KFoRSQuVLYnejxia4d40iphBOJthyLcNtj/461CIKa/qgEXXrbtaMD+OmuKX8ydYAF/9EhEn/eN90IP3pDBdG+nHdYifEmVruMvkRayhMYNjclz8+Jq54yrf1a/kEP0j7WzIA7GDaV3FD9k3EVb9QudF29r/VZXtMTWPNGMZi+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=umdU8kKN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc05887ee9so2112928276.1
        for <linux-unionfs@vger.kernel.org>; Thu, 28 Mar 2024 18:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677270; x=1712282070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jC8NburpJ0gtA38yoeQoqc6ho+qO84rwoWBCmC/NNxg=;
        b=umdU8kKNdDEYQlPari+AHAKgh9RMcDZANNe5jlbScNPHEInszqxpAouo5u4l6Pdj8K
         uNq3kY9TBRMHdnyGujp5rYamBIaHlpTHf0PEYp8IcodZ3N4YBSVzJ8cQ6r9jUXG22+QJ
         ydNu08vkn8phta/LqumOpmexjHG8MavdOTRPjSyhNqm+Ez6xmnhkvIij01VUsjiCywnJ
         d5XEyD5QV9kQXY3w+UpavVJ9ESF6c9Pgk1H5SENpnuNMfe4Uqs6x3F724Od6x2uQH2Zp
         lYFtIiSa4SIirEon1EQqCm5VcpATEGyl5G1/i4cNYtL1i6UTp0p4Z3i/9RliiIecusJf
         WuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677270; x=1712282070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jC8NburpJ0gtA38yoeQoqc6ho+qO84rwoWBCmC/NNxg=;
        b=hYl7HTkZRf4UmdToYCAFWhbb+a4pc1zo1SE6Cnuc66E8kzE0BPlBNFbx8S584xiCJx
         k+P2DoklEEKv44A8/6AxXJL+i9KB5hgN/AMMmu4l4lwm9OupxPKLmaUXynBpEdtJ4rGo
         EH/ayoDyxeYNWG0WgOOmf72OySVXS4cuv4mvkiijzhRFql0h5ros8oczIs7YlzkjDSSa
         gmOdzV0a8mM4bdQVhfi0dJ3ACyjOXqW+qaH9S3ZJjYZNvpSFVEg5cWWqytOgK7gQ+/Ln
         3JVvaCXKy9CST7ojanSva43SP/+KMsxv2C+88NUn8iVFEKt8kBKjtDlvNBITaVi6p9Xa
         h/aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCdVbNGe6PdAo9+CuVJVb+BOR0y+AIsONSuTXqE4UJh03uieWT4wHyKVWmaJMdKXgbqloACdYT49oZkh4y9+41Q2CeJFx6anxZfxSeSg==
X-Gm-Message-State: AOJu0YykFvvuYrdL1F551pz5ZOOuml3cRHXXUuMfNPndcaj0NGfpSA/o
	itYdugQzS3Lm1JcVlEN4oirHvDr6q0H59MxWt0r8DIqcGd26ldmVl6JRiMCsvcWiXo/Jv2oeIK3
	ocg==
X-Google-Smtp-Source: AGHT+IGEkW92c6/qNS6PQZSAUYSkJgtaRBGyOZKgtytd6KAjgIrWIvmFBTD9B8z/JDA+ppvDRSBxFXfRGi0=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a05:6902:160f:b0:dc6:ebd4:cca2 with SMTP id
 bw15-20020a056902160f00b00dc6ebd4cca2mr72791ybb.11.1711677270016; Thu, 28 Mar
 2024 18:54:30 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:29 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-15-drosen@google.com>
Subject: [RFC PATCH v4 14/36] fuse-bpf: support readdir
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

This adds backing support for FUSE_READDIR

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c         | 202 ++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h          |   6 ++
 fs/fuse/readdir.c         |   5 +
 include/uapi/linux/fuse.h |   6 ++
 4 files changed, 219 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index c813237b6599..0182236c2735 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -1657,6 +1657,208 @@ int fuse_bpf_unlink(int *out, struct inode *dir, struct dentry *entry)
 				dir, entry);
 }
 
+struct fuse_read_args {
+	struct fuse_read_in in;
+	struct fuse_read_out out;
+	struct fuse_buffer buffer;
+};
+
+static int fuse_readdir_initialize_in(struct bpf_fuse_args *fa, struct fuse_read_args *args,
+				      struct file *file, struct dir_context *ctx,
+				      bool *force_again, bool *allow_force, bool is_continued)
+{
+	struct fuse_file *ff = file->private_data;
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.nodeid = ff->nodeid,
+			.opcode = FUSE_READDIR,
+		},
+		.in_numargs = 1,
+		.in_args[0] = (struct bpf_fuse_arg) {
+			.size = sizeof(args->in),
+			.value = &args->in,
+		},
+	};
+
+	args->in = (struct fuse_read_in) {
+		.fh = ff->fh,
+		.offset = ctx->pos,
+		.size = PAGE_SIZE,
+	};
+
+	*force_again = false;
+	*allow_force = true;
+	return 0;
+}
+
+static int fuse_readdir_initialize_out(struct bpf_fuse_args *fa, struct fuse_read_args *args,
+				       struct file *file, struct dir_context *ctx,
+				       bool *force_again, bool *allow_force, bool is_continued)
+{
+	u8 *page = (u8 *)__get_free_page(GFP_KERNEL);
+
+	if (!page)
+		return -ENOMEM;
+
+	fa->flags = FUSE_BPF_OUT_ARGVAR;
+	fa->out_numargs = 2;
+	fa->out_args[0] = (struct bpf_fuse_arg) {
+		.size = sizeof(args->out),
+		.value = &args->out,
+	};
+	fa->out_args[1] = (struct bpf_fuse_arg) {
+		.is_buffer = true,
+		.buffer = &args->buffer,
+	};
+	args->out = (struct fuse_read_out) {
+		.again = 0,
+		.offset = 0,
+	};
+	args->buffer = (struct fuse_buffer) {
+		.data = page,
+		.size = PAGE_SIZE,
+		.alloc_size = PAGE_SIZE,
+		.max_size = PAGE_SIZE,
+		.flags = BPF_FUSE_VARIABLE_SIZE,
+	};
+
+	return 0;
+}
+
+struct fusebpf_ctx {
+	struct dir_context ctx;
+	u8 *addr;
+	size_t offset;
+};
+
+static bool filldir(struct dir_context *ctx, const char *name, int namelen,
+		   loff_t offset, u64 ino, unsigned int d_type)
+{
+	struct fusebpf_ctx *ec = container_of(ctx, struct fusebpf_ctx, ctx);
+	struct fuse_dirent *fd = (struct fuse_dirent *)(ec->addr + ec->offset);
+
+	if (ec->offset + sizeof(struct fuse_dirent) + namelen > PAGE_SIZE)
+		return false;
+
+	*fd = (struct fuse_dirent) {
+		.ino = ino,
+		.off = offset,
+		.namelen = namelen,
+		.type = d_type,
+	};
+
+	memcpy(fd->name, name, namelen);
+	ec->offset += FUSE_DIRENT_SIZE(fd);
+
+	return true;
+}
+
+static int parse_dirfile(char *buf, size_t nbytes, struct dir_context *ctx,
+		loff_t next_offset)
+{
+	char *buf_start = buf;
+
+	while (nbytes >= FUSE_NAME_OFFSET) {
+		struct fuse_dirent *dirent = (struct fuse_dirent *) buf;
+		size_t reclen = FUSE_DIRENT_SIZE(dirent);
+
+		if (!dirent->namelen || dirent->namelen > FUSE_NAME_MAX)
+			return -EIO;
+		if (reclen > nbytes)
+			break;
+		if (memchr(dirent->name, '/', dirent->namelen) != NULL)
+			return -EIO;
+
+		ctx->pos = dirent->off;
+		if (!dir_emit(ctx, dirent->name, dirent->namelen, dirent->ino,
+				dirent->type)) {
+			// If we can't make any progress, user buffer is too small
+			if (buf == buf_start)
+				return -EINVAL;
+			else
+				return 0;
+		}
+
+		buf += reclen;
+		nbytes -= reclen;
+	}
+	ctx->pos = next_offset;
+
+	return 0;
+}
+
+static int fuse_readdir_backing(struct bpf_fuse_args *fa, int *out,
+				struct file *file, struct dir_context *ctx,
+				bool *force_again, bool *allow_force, bool is_continued)
+{
+	struct fuse_file *ff = file->private_data;
+	struct file *backing_dir = ff->backing_file;
+	struct fuse_read_out *fro = fa->out_args[0].value;
+	struct fusebpf_ctx ec;
+
+	ec = (struct fusebpf_ctx) {
+		.ctx.actor = filldir,
+		.ctx.pos = ctx->pos,
+		.addr = fa->out_args[1].buffer->data,
+	};
+
+	if (!ec.addr)
+		return -ENOMEM;
+
+	if (!is_continued)
+		backing_dir->f_pos = file->f_pos;
+
+	*out = iterate_dir(backing_dir, &ec.ctx);
+	if (ec.offset == 0)
+		*allow_force = false;
+	fa->out_args[1].buffer->size = ec.offset;
+
+	fro->offset = ec.ctx.pos;
+	fro->again = false;
+
+	return *out;
+}
+
+static int fuse_readdir_finalize(struct bpf_fuse_args *fa, int *out,
+				 struct file *file, struct dir_context *ctx,
+				 bool *force_again, bool *allow_force, bool is_continued)
+{
+	struct fuse_read_out *fro = fa->out_args[0].value;
+	struct fuse_file *ff = file->private_data;
+	struct file *backing_dir = ff->backing_file;
+
+	*out = parse_dirfile(fa->out_args[1].buffer->data, fa->out_args[1].buffer->size, ctx, fro->offset);
+	*force_again = !!fro->again;
+	if (*force_again && !*allow_force)
+		*out = -EINVAL;
+
+	backing_dir->f_pos = ctx->pos;
+
+	free_page((unsigned long)fa->out_args[1].buffer->data);
+	return *out;
+}
+
+int fuse_bpf_readdir(int *out, struct inode *inode, struct file *file, struct dir_context *ctx)
+{
+	int ret;
+	bool allow_force;
+	bool force_again = false;
+	bool is_continued = false;
+
+again:
+	ret = bpf_fuse_backing(inode, struct fuse_read_args, out,
+			       fuse_readdir_initialize_in, fuse_readdir_initialize_out,
+			       fuse_readdir_backing, fuse_readdir_finalize,
+			       file, ctx, &force_again, &allow_force, is_continued);
+	if (force_again && *out >= 0) {
+		is_continued = true;
+		goto again;
+	}
+
+	return ret;
+}
+
 static int fuse_access_initialize_in(struct bpf_fuse_args *fa, struct fuse_access_in *in,
 				     struct inode *inode, int mask)
 {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index bd187dbf20b2..ab52003de194 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1452,6 +1452,7 @@ int fuse_bpf_file_read_iter(ssize_t *out, struct inode *inode, struct kiocb *ioc
 int fuse_bpf_file_write_iter(ssize_t *out, struct inode *inode, struct kiocb *iocb, struct iov_iter *from);
 int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length);
 int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags);
+int fuse_bpf_readdir(int *out, struct inode *inode, struct file *file, struct dir_context *ctx);
 int fuse_bpf_access(int *out, struct inode *inode, int mask);
 
 #else
@@ -1522,6 +1523,11 @@ static inline int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct
 	return 0;
 }
 
+static inline int fuse_bpf_readdir(int *out, struct inode *inode, struct file *file, struct dir_context *ctx)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_access(int *out, struct inode *inode, int mask)
 {
 	return 0;
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index c66a54d6c7d3..53a1fd756772 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -20,6 +20,8 @@ static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
 
 	if (!fc->do_readdirplus)
 		return false;
+	if (fi->nodeid == 0)
+		return false;
 	if (!fc->readdirplus_auto)
 		return true;
 	if (test_and_clear_bit(FUSE_I_ADVISE_RDPLUS, &fi->state))
@@ -592,6 +594,9 @@ int fuse_readdir(struct file *file, struct dir_context *ctx)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (fuse_bpf_readdir(&err, inode, file, ctx))
+		return err;
+
 	mutex_lock(&ff->readdir.lock);
 
 	err = UNCACHED;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 8efaa9eecc5f..3417717c1a55 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -811,6 +811,12 @@ struct fuse_read_in {
 	uint32_t	padding;
 };
 
+struct fuse_read_out {
+	uint64_t	offset;
+	uint32_t	again;
+	uint32_t	padding;
+};
+
 // This is likely not what we want
 struct fuse_read_iter_out {
 	uint64_t ret;
-- 
2.44.0.478.gd926399ef9-goog


