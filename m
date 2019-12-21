Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24B5E128A7E
	for <lists+linux-unionfs@lfdr.de>; Sat, 21 Dec 2019 17:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfLUQww (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sat, 21 Dec 2019 11:52:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45459 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfLUQww (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sat, 21 Dec 2019 11:52:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so12328922wrj.12
        for <linux-unionfs@vger.kernel.org>; Sat, 21 Dec 2019 08:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tFw4DNUP3TL91LBL7JRmX0IsmFr0EKAfMPojHm8Sdfw=;
        b=h15Q3RiSgJkLtVIh3HVDo17/rsHdTbOjYbakdHZNw8xduhRVdKGlrRgcBy/r+dHH3R
         N3fNBp/PCKIlegcWt8HyjTs+kCLhvRWZa3CFYHAVben+M+a7Fut82f8pPliUSEVoPMZz
         ZSw5548yfbx6KzutJg8RRFdy7Cq85tATu9peFUpXK1n0rAnYev008C1BfA5QX3f+EKzM
         wte3BHRX0vHKy7GAwDbBwhhp8WbZlHaWcNBi4GmWe4QCCCxxnxbfZp4WH343H0iGkN9L
         RpQiozS8LC6IfWBH7G9ZiKI68tiB5ATIhTtE2RB0JprxmZLVHBHKgwf85RPU+Yavmkmx
         9nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tFw4DNUP3TL91LBL7JRmX0IsmFr0EKAfMPojHm8Sdfw=;
        b=CT4QDkPd7XL0j6kiv3dXdS3uTc/hR/eQxcEYc97/jz43PIKhNwsC3tSxud7kOI/Qaq
         vs6AzN/B9F0cqi8yKvQ7EX4ZyemToq9Bnf7qFs/EwgtDxGxu4M0/tzsQzO1TMSjGjc89
         AFNl0cgfvpnNBEwn7SjpofXr0InFGgHzljnsJnWj4PyF5GNBHaX+Q+nwekyxapx3wL0m
         qM/ecDBE+7zPENHIrbdOsJ5iSfBbQyK8MpIKbtNR/xl2909jSCuoRNdkitRZh28Osibd
         0aw0BMV8m6weGJZhb8iy8Xk1UyrPXZzxyLL5idymp4WrPQC43QcpdavtSCZVcU7Gwj9G
         0XfA==
X-Gm-Message-State: APjAAAWj+8wPHVnrQuwyXUo+N+KCtU9pL4C3+PKT9RERPYzjle/uk3U3
        nECB4Vr7vT35nSW3Ut42SVQ=
X-Google-Smtp-Source: APXvYqyEm/Y7rwameHQx8hx0OXfBVuu7WRqOVfvwWJZd/zfFrL/wMIVE4b+aWavBhcOIn02eUT556Q==
X-Received: by 2002:a5d:4044:: with SMTP id w4mr21180989wrp.322.1576947169827;
        Sat, 21 Dec 2019 08:52:49 -0800 (PST)
Received: from localhost.localdomain ([141.226.162.223])
        by smtp.gmail.com with ESMTPSA id f1sm14148004wro.85.2019.12.21.08.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 08:52:49 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org
Subject: [PATCH] ovl: use ovl_inode_lock in ovl_llseek()
Date:   Sat, 21 Dec 2019 18:52:43 +0200
Message-Id: <20191221165243.13026-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

In ovl_llseek() we use the overlay inode rwsem to protect against
concurrent modifications to real file f_pos, because we copy the overlay
file f_pos to/from the real file f_pos.

This caused a lockdep warning of locking order violation when the
ovl_llseek() operation was called on a lower nested overlay layer while
the upper layer fs sb_writers is held (with patch improving copy-up
efficiency for big sparse file).

Use the internal ovl_inode_lock() instead of the overlay inode rwsem
in those cases. It is meant to be used for protecting against concurrent
changes to overlay inode internal state changes.

The locking order rules are documented to explain this case.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Miklos,

From all the potential cases to replace inode_lock with ovl_inode_lock,
this is the only one left with justification.

ovl_write_iter() and ovl_ioctl_set_flags() will require more changes and
they cannot be called on a lower overlay.

ovl_dir_llseek() needs to use the same lock used by ovl_iterate() when
modifying realfile->f_pos (i_rwsem).

ovl_dir_fsync() could use ovl_inode_lock insead of i_rwsem for
od->upperfile test&set, but there is no strong justification to make
that change now.

Thanks,
Amir.

 fs/overlayfs/file.c  |  4 ++--
 fs/overlayfs/inode.c | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index e235a635d9ec..859efeaaefab 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -171,7 +171,7 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 	 * limitations that are more strict than ->s_maxbytes for specific
 	 * files, so we use the real file to perform seeks.
 	 */
-	inode_lock(inode);
+	ovl_inode_lock(inode);
 	real.file->f_pos = file->f_pos;
 
 	old_cred = ovl_override_creds(inode->i_sb);
@@ -179,7 +179,7 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 	revert_creds(old_cred);
 
 	file->f_pos = real.file->f_pos;
-	inode_unlock(inode);
+	ovl_inode_unlock(inode);
 
 	fdput(real);
 
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index b045cf1826fc..481a19965dd1 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -527,6 +527,27 @@ static const struct address_space_operations ovl_aops = {
  * [...] &ovl_i_mutex_dir_key[depth]   (stack_depth=2)
  * [...] &ovl_i_mutex_dir_key[depth]#2 (stack_depth=1)
  * [...] &type->i_mutex_dir_key        (stack_depth=0)
+ *
+ * Locking order w.r.t ovl_want_write() is important for nested overlayfs.
+ *
+ * This chain is valid:
+ * - inode->i_rwsem			(inode_lock[2])
+ * - upper_mnt->mnt_sb->s_writers	(ovl_want_write[0])
+ * - OVL_I(inode)->lock			(ovl_inode_lock[2])
+ * - OVL_I(lowerinode)->lock		(ovl_inode_lock[1])
+ *
+ * And this chain is valid:
+ * - inode->i_rwsem			(inode_lock[2])
+ * - OVL_I(inode)->lock			(ovl_inode_lock[2])
+ * - lowerinode->i_rwsem		(inode_lock[1])
+ * - OVL_I(lowerinode)->lock		(ovl_inode_lock[1])
+ *
+ * But lowerinode->i_rwsem SHOULD NOT be acquired while ovl_want_write() is
+ * held, because it is in reverse order of the non-nested case using the same
+ * upper fs:
+ * - inode->i_rwsem			(inode_lock[1])
+ * - upper_mnt->mnt_sb->s_writers	(ovl_want_write[0])
+ * - OVL_I(inode)->lock			(ovl_inode_lock[1])
  */
 #define OVL_MAX_NESTING FILESYSTEM_MAX_STACK_DEPTH
 
-- 
2.17.1

