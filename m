Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B31081409F6
	for <lists+linux-unionfs@lfdr.de>; Fri, 17 Jan 2020 13:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgAQMti (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 17 Jan 2020 07:49:38 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36950 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQMth (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 17 Jan 2020 07:49:37 -0500
Received: by mail-pg1-f194.google.com with SMTP id q127so11642751pga.4
        for <linux-unionfs@vger.kernel.org>; Fri, 17 Jan 2020 04:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=cLDU0mKMAeDqbr76LDh2P3u56D0txgAGJuEW/3m0I0o=;
        b=IrdZJL2CQ/KX2x34ihm9zrEGbqvHxi3p/TfjIB1zq4m0pSMAz0XLpaumj7EwQkybuw
         E+NJu/SsHUP+R+oRqMcw4GIKb3JR+WzoA1+NHqMF3vTJoFtmZ5IoCVVCzUpIkNaAchw5
         T5kmfwmC1fVJZUItxn/cwDUEuVvYukTwtr2FKHpD/GUk46WNYrGXvjgptq2nIVmGIF7j
         y+Ppqpl6U4yURjykNrN7eLBLcBjLpD1W1bPlBcGic8vJhpVxlfKbdd1Lug/sKFAJvEE8
         GBbJvyfuheG4jFBSbAZGY9CMwYoIeaPdCGMJioe7M2G6jXyE5/um+5WC+0cWFfwB8iRr
         o30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=cLDU0mKMAeDqbr76LDh2P3u56D0txgAGJuEW/3m0I0o=;
        b=VlcPtMZFwu4FF29VQYNEnrXY4C1gzjr4ZvMEEtgMwuRyesBPrvh4eBIhtaCZuNR/I5
         m11pNQfTPZt53Hxx17jIB8b+UDmjS+4Hp5VTT99jSeEnMyTkTN4j5aCkIt98sQFXqcYX
         OjszulsAfTzdYP4J7XkSdrWPdgF10Mgwu7hjeTZ4xHo+t71DFCnJW9XwkYYsxT2gHk+l
         Y8nJtplMYJZU4dTVkvnamC5oSMXpm/DM7DpqlHvcnt8Y1Blkg8fMVkGzecvznLn4988M
         m/q/rypL5eQE60top6pO1UUYviWKuhq68Gb4wyxcTwIoxqhlX2fKKf+/hFkdKHtqg1v1
         RF6A==
X-Gm-Message-State: APjAAAW1ge2HCYDHo0IKoKljPeLhhyvv6ZR8x2v+/R5b61CN+Yl+BSBd
        xXblNAjP/DTzQ+JRBSN8po/LcqLh
X-Google-Smtp-Source: APXvYqyGxQynLd2wd4Ckzs/X3kvNG6Me4HWNsU7lQnWB+/WaPiqJLRPKWfbl+lskhRFvNYvm0IXX8g==
X-Received: by 2002:a63:130a:: with SMTP id i10mr41471887pgl.199.1579265377099;
        Fri, 17 Jan 2020 04:49:37 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d23sm28592350pfo.176.2020.01.17.04.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 04:49:36 -0800 (PST)
Date:   Fri, 17 Jan 2020 20:49:29 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org
Subject: [PATCH] fs/overlayfs: add splice file read write helper
Message-ID: <20200117124929.6nhgpd7mgcbwae5z@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Now overlayfs falls back to use default file splice read
and write, which is not compatiple with overlayfs, returning
EFAULT. xfstests generic/591 can reproduce part of this.

Tested this patch with xfstests auto group tests.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 fs/overlayfs/file.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index e235a63..0546e9f 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -9,6 +9,9 @@
 #include <linux/xattr.h>
 #include <linux/uio.h>
 #include <linux/uaccess.h>
+#include <linux/splice.h>
+#include <linux/mm.h>
+#include <linux/fs.h>
 #include "overlayfs.h"
 
 static char ovl_whatisit(struct inode *inode, struct inode *realinode)
@@ -291,6 +294,48 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	return ret;
 }
 
+static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
+			 struct pipe_inode_info *pipe, size_t len,
+			 unsigned int flags)
+{
+	ssize_t ret;
+	struct fd real;
+	const struct cred *old_cred;
+
+	ret = ovl_real_fdget(in, &real);
+	if (ret)
+		return ret;
+
+	old_cred = ovl_override_creds(file_inode(in)->i_sb);
+	ret = generic_file_splice_read(real.file, ppos, pipe, len, flags);
+	revert_creds(old_cred);
+
+	ovl_file_accessed(in);
+	fdput(real);
+	return ret;
+}
+
+static ssize_t
+ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
+			  loff_t *ppos, size_t len, unsigned int flags)
+{
+	struct fd real;
+	const struct cred *old_cred;
+	ssize_t ret;
+
+	ret = ovl_real_fdget(out, &real);
+	if (ret)
+		return ret;
+
+	old_cred = ovl_override_creds(file_inode(out)->i_sb);
+	ret = iter_file_splice_write(pipe, real.file, ppos, len, flags);
+	revert_creds(old_cred);
+
+	ovl_file_accessed(out);
+	fdput(real);
+	return ret;
+}
+
 static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	struct fd real;
@@ -647,6 +692,8 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
 	.fadvise	= ovl_fadvise,
 	.unlocked_ioctl	= ovl_ioctl,
 	.compat_ioctl	= ovl_compat_ioctl,
+	.splice_read    = ovl_splice_read,
+	.splice_write   = ovl_splice_write,
 
 	.copy_file_range	= ovl_copy_file_range,
 	.remap_file_range	= ovl_remap_file_range,
-- 
1.8.3.1


