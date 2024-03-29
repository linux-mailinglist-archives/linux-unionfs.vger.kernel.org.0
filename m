Return-Path: <linux-unionfs+bounces-604-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D273F8910A2
	for <lists+linux-unionfs@lfdr.de>; Fri, 29 Mar 2024 02:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E6B28C326
	for <lists+linux-unionfs@lfdr.de>; Fri, 29 Mar 2024 01:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5EA2261F;
	Fri, 29 Mar 2024 01:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VVRlV2AB"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FA9210EC
	for <linux-unionfs@vger.kernel.org>; Fri, 29 Mar 2024 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677246; cv=none; b=QYRMuTRcluHCQkUQ7uWI5AWvkpjhSgXHlAzxNqp78q4VoTtvVjz8qlHxybAxLMCqhrnd0BYe4Q/brdWWYt8pwPE0FqYadga9gAHEVBwV6JpHNao5SHOmNcvEnVI9OjbdyHO6I9y9b3MlvR5QFU/G9MW0BR+6iVS6CMZxVaIMPhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677246; c=relaxed/simple;
	bh=Wc6g5oUwOwJMcy8zr/T7dnynkvOgSwhcOrIXewXrDos=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=teO9D3AS3Gpn/wFqvZD3ZBVb0dRcp+qn47MR9VAovUX8EadTTuESYFmzkRrAqwDGrQi+I7zjQB8NptpD6azS0u9szu945tJHp/uXquw9MT602916tZvfYiGsMndsL7nfp6D6fpL4G3vw+6+VKJbF3dv/fYhq1uYvATWnLWIQwVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VVRlV2AB; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso2277442276.2
        for <linux-unionfs@vger.kernel.org>; Thu, 28 Mar 2024 18:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677244; x=1712282044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/zH4C1QJ9QRhJsDuWqk5xHws80AiBqqvhiaKJmoPnqo=;
        b=VVRlV2AB4xLteIv7NdqAcWA487whBLy522o5Uoqki3PBN2l1tVi7VZYIMv36wcWfIF
         2h6DavLDcwkX20y7dV3tKxoRF3V5gulrKAGtDonIc/bi/Y/IUO8H+dhjq9iMFgx/WafB
         o1DlV31/hO1e90foGbMyYrix1k9czDEXIN99mRV9RrZwcTvm2zbcQRYsasropiDwxwnq
         rM9+aVFAuwEZUFPySGXXQjrGOr4U9w2heyUYBc0kn48DWmWqLHD1JpZkElvBMDSHj8Iz
         8kIox+T7X/e2otUw1nqqODbYcx3+3jgEDe5Z6UGb0zVa4NUQLXSWBylVRYjnNDpEjPWq
         O/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677244; x=1712282044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zH4C1QJ9QRhJsDuWqk5xHws80AiBqqvhiaKJmoPnqo=;
        b=m07t/aLXVjByMzswOqfD5EzH4LXxfvRB4t9Cx9NpaWoz+6YC2F5Yow+cm0efmoH3sr
         9oVQhQrNSVsryivFSidpgd0gwRQ8y6uMyAisak5YeJwn+y22vtM9pGy2hd2J3yZIbPtD
         UMuMnuNrWzsN4WIvqLfkHtTiJDxOne/n53mBP8eaLPfDKnAQ1OU9Misb9bNAIz6079dn
         eZqk69pHta+L4UZMkiJoDvB9SYk1iRVjk3meY/UzqujkeNAUztrvDNkIp4jV3FVUsuFs
         hdE/120ZHMERsCwwafJFbDXosMXFvsbaV4XFWwmYdWC4n7Bp2NqUyHL/nPWxV4YvFzws
         nJSg==
X-Forwarded-Encrypted: i=1; AJvYcCWB7IdC8syFXh0JdZEOFbfAtkE8QEusbF6zR59kUvFmqP746uQ+X8V62dAx8hguy/Ssvox6ekQyKCkXRV2EiTfmcra92+RNwj4D7jDGFQ==
X-Gm-Message-State: AOJu0Yy1w8CiGKAmedFpP9efr05t/Xjl9p3tyZ67zojwplfC/UtFmaho
	LalmHo5NI7QQhhzEEd4xjfCAISSoQJNifZtCUxxND1vS3W3ohwsPiXxOge2tZjADP6iGvqKSYMV
	6jw==
X-Google-Smtp-Source: AGHT+IECUo0Pk+Dy4BEAGGBe6rMjNQ00Kce7FlbJjQhechcikFYw4a3/fGgjQkC9x+edNOdwWHxstE0cb78=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a05:6902:e0f:b0:dc6:44d4:bee0 with SMTP id
 df15-20020a0569020e0f00b00dc644d4bee0mr85414ybb.7.1711677244476; Thu, 28 Mar
 2024 18:54:04 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:17 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-3-drosen@google.com>
Subject: [RFC PATCH v4 02/36] fuse-bpf: Add data structures for fuse-bpf
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
	Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"

These structures will be used to interact between the fuse bpf calls and
normal userspace calls

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 include/linux/bpf_fuse.h | 84 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 include/linux/bpf_fuse.h

diff --git a/include/linux/bpf_fuse.h b/include/linux/bpf_fuse.h
new file mode 100644
index 000000000000..ce8b1b347496
--- /dev/null
+++ b/include/linux/bpf_fuse.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2022 Google LLC.
+ */
+
+#ifndef _BPF_FUSE_H
+#define _BPF_FUSE_H
+
+#include <linux/types.h>
+#include <linux/fuse.h>
+
+struct fuse_buffer {
+	void *data;
+	unsigned size;
+	unsigned alloc_size;
+	unsigned max_size;
+	int flags;
+};
+
+/* These flags are used internally to track information about the fuse buffers.
+ * Fuse sets some of the flags in init. The helper functions sets others, depending on what
+ * was requested by the bpf program.
+ */
+// Flags set by FUSE
+#define BPF_FUSE_IMMUTABLE	(1 << 0) // Buffer may not be written to
+#define BPF_FUSE_VARIABLE_SIZE	(1 << 1) // Buffer length may be changed (growth requires alloc)
+#define BPF_FUSE_MUST_ALLOCATE	(1 << 2) // Buffer must be re allocated before allowing writes
+
+// Flags set by helper function
+#define BPF_FUSE_MODIFIED	(1 << 3) // The helper function allowed writes to the buffer
+#define BPF_FUSE_ALLOCATED	(1 << 4) // The helper function allocated the buffer
+
+/*
+ * BPF Fuse Args
+ *
+ * Used to translate between bpf program parameters and their userspace equivalent calls.
+ * Variable sized arguments are held in fuse_buffers. To access these, bpf programs must
+ * use kfuncs to access them as dynptrs.
+ *
+ */
+
+#define FUSE_MAX_ARGS_IN 3
+#define FUSE_MAX_ARGS_OUT 2
+
+struct bpf_fuse_arg {
+	union {
+		void *value;
+		struct fuse_buffer *buffer;
+	};
+	unsigned size;
+	bool is_buffer;
+};
+
+struct bpf_fuse_meta_info {
+	uint64_t nodeid;
+	uint32_t opcode;
+	uint32_t error_in;
+};
+
+struct bpf_fuse_args {
+	struct bpf_fuse_meta_info info;
+	uint32_t in_numargs;
+	uint32_t out_numargs;
+	uint32_t flags;
+	struct bpf_fuse_arg in_args[FUSE_MAX_ARGS_IN];
+	struct bpf_fuse_arg out_args[FUSE_MAX_ARGS_OUT];
+};
+
+// Mirrors for struct fuse_args flags
+#define FUSE_BPF_FORCE (1 << 0)
+#define FUSE_BPF_OUT_ARGVAR (1 << 6)
+#define FUSE_BPF_IS_LOOKUP (1 << 11)
+
+static inline void *bpf_fuse_arg_value(const struct bpf_fuse_arg *arg)
+{
+	return arg->is_buffer ? arg->buffer : arg->value;
+}
+
+static inline unsigned bpf_fuse_arg_size(const struct bpf_fuse_arg *arg)
+{
+	return arg->is_buffer ? arg->buffer->size : arg->size;
+}
+
+#endif /* _BPF_FUSE_H */
-- 
2.44.0.478.gd926399ef9-goog


