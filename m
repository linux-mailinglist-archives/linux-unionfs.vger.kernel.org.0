Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92BB70C025
	for <lists+linux-unionfs@lfdr.de>; Mon, 22 May 2023 15:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbjEVNwL (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 22 May 2023 09:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjEVNwF (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 22 May 2023 09:52:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83731A8
        for <linux-unionfs@vger.kernel.org>; Mon, 22 May 2023 06:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684763449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pM2ysDzppt/NTb8ZyH27IEzbM3T0VU0XmStR2DOq6rE=;
        b=SS7NsFASiIta7fo9ki72BUGPXIlM8RpvEJQsWk5fyELmuhKfz7tR3ipYp8FW0VGEcrGWXt
        F2+Ex1YwLecY/ID53kxoCuJCZ6okzfrVlbnpdJs+2hRQjZKq9MEA+afIq56TVWj3sIstMR
        Z/dy6IKe9SOlfiXUBSPfgpmEnvU7eEA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-qL7E6ESWO2O9-esN8xS6hw-1; Mon, 22 May 2023 09:50:45 -0400
X-MC-Unique: qL7E6ESWO2O9-esN8xS6hw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBA44101AA74;
        Mon, 22 May 2023 13:50:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 882EE40C6CD8;
        Mon, 22 May 2023 13:50:41 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-unionfs@vger.kernel.org
Subject: [PATCH v22 05/31] splice: Make do_splice_to() generic and export it
Date:   Mon, 22 May 2023 14:49:52 +0100
Message-Id: <20230522135018.2742245-6-dhowells@redhat.com>
In-Reply-To: <20230522135018.2742245-1-dhowells@redhat.com>
References: <20230522135018.2742245-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Rename do_splice_to() to vfs_splice_read() and export it so that it can be
used as a helper when calling down to a lower layer filesystem as it
performs all the necessary checks[1].

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: John Hubbard <jhubbard@nvidia.com>
cc: David Hildenbrand <david@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-unionfs@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/CAJfpeguGksS3sCigmRi9hJdUec8qtM9f+_9jC1rJhsXT+dV01w@mail.gmail.com/ [1]
---
 fs/splice.c            | 27 ++++++++++++++++++++-------
 include/linux/splice.h |  3 +++
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index f9a9be797b0c..d815a69f6589 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -867,12 +867,24 @@ static long do_splice_from(struct pipe_inode_info *pipe, struct file *out,
 	return out->f_op->splice_write(pipe, out, ppos, len, flags);
 }
 
-/*
- * Attempt to initiate a splice from a file to a pipe.
+/**
+ * vfs_splice_read - Read data from a file and splice it into a pipe
+ * @in:		File to splice from
+ * @ppos:	Input file offset
+ * @pipe:	Pipe to splice to
+ * @len:	Number of bytes to splice
+ * @flags:	Splice modifier flags (SPLICE_F_*)
+ *
+ * Splice the requested amount of data from the input file to the pipe.  This
+ * is synchronous as the caller must hold the pipe lock across the entire
+ * operation.
+ *
+ * If successful, it returns the amount of data spliced, 0 if it hit the EOF or
+ * a hole and a negative error code otherwise.
  */
-static long do_splice_to(struct file *in, loff_t *ppos,
-			 struct pipe_inode_info *pipe, size_t len,
-			 unsigned int flags)
+long vfs_splice_read(struct file *in, loff_t *ppos,
+		     struct pipe_inode_info *pipe, size_t len,
+		     unsigned int flags)
 {
 	unsigned int p_space;
 	int ret;
@@ -895,6 +907,7 @@ static long do_splice_to(struct file *in, loff_t *ppos,
 		return warn_unsupported(in, "read");
 	return in->f_op->splice_read(in, ppos, pipe, len, flags);
 }
+EXPORT_SYMBOL_GPL(vfs_splice_read);
 
 /**
  * splice_direct_to_actor - splices data directly between two non-pipes
@@ -964,7 +977,7 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 		size_t read_len;
 		loff_t pos = sd->pos, prev_pos = pos;
 
-		ret = do_splice_to(in, &pos, pipe, len, flags);
+		ret = vfs_splice_read(in, &pos, pipe, len, flags);
 		if (unlikely(ret <= 0))
 			goto out_release;
 
@@ -1112,7 +1125,7 @@ long splice_file_to_pipe(struct file *in,
 	pipe_lock(opipe);
 	ret = wait_for_space(opipe, flags);
 	if (!ret)
-		ret = do_splice_to(in, offset, opipe, len, flags);
+		ret = vfs_splice_read(in, offset, opipe, len, flags);
 	pipe_unlock(opipe);
 	if (ret > 0)
 		wakeup_pipe_readers(opipe);
diff --git a/include/linux/splice.h b/include/linux/splice.h
index a55179fd60fc..8f052c3dae95 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -76,6 +76,9 @@ extern ssize_t splice_to_pipe(struct pipe_inode_info *,
 			      struct splice_pipe_desc *);
 extern ssize_t add_to_pipe(struct pipe_inode_info *,
 			      struct pipe_buffer *);
+long vfs_splice_read(struct file *in, loff_t *ppos,
+		     struct pipe_inode_info *pipe, size_t len,
+		     unsigned int flags);
 extern ssize_t splice_direct_to_actor(struct file *, struct splice_desc *,
 				      splice_direct_actor *);
 extern long do_splice(struct file *in, loff_t *off_in,

