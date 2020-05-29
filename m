Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3701E8A0D
	for <lists+linux-unionfs@lfdr.de>; Fri, 29 May 2020 23:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgE2VaV (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 29 May 2020 17:30:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50073 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727947AbgE2VaU (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 29 May 2020 17:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590787819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ga5N740DrSo80jQ8GWP7FH77fQr1Afwl4yzqnHo00vY=;
        b=i3AkKt838p/5g6ag8xTFdVIwMfww97Q6CW5F30HnCg/+q5XnIpXCvCgp6lnYWgggECSB7q
        uzy9cqFdul1p5OqqfPpyNCWTJcsekc+V0FbjDyLjS+YpGV/AVuicYyuZb2w4mTkRI1LQnH
        +SoE47nPGfnDKXE92kIBeWHdEi6dn74=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-hzSBi5uSMHKyCU5nsWI_3w-1; Fri, 29 May 2020 17:30:16 -0400
X-MC-Unique: hzSBi5uSMHKyCU5nsWI_3w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB285800D24;
        Fri, 29 May 2020 21:30:15 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-93.rdu2.redhat.com [10.10.115.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 968437A8D2;
        Fri, 29 May 2020 21:30:15 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id F2B1622066E; Fri, 29 May 2020 17:30:14 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     amir73il@gmail.com
Cc:     miklos@szeredi.hu, yangerkun@huawei.com,
        linux-unionfs@vger.kernel.org
Subject: [PATCH 3/3] overlayfs: Initialize OVL_UPPERDATA in ovl_lookup()
Date:   Fri, 29 May 2020 17:29:52 -0400
Message-Id: <20200529212952.214175-4-vgoyal@redhat.com>
In-Reply-To: <20200529212952.214175-1-vgoyal@redhat.com>
References: <20200529212952.214175-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Currently ovl_get_inode() initializes OVL_UPPERDATA flag and for that it
has to call ovl_check_metacopy_xattr() and check if metacopy xattr is
present or not.

yangerkun reported sometimes underlying filesystem might return -EIO
and in that case error handling path does not cleanup properly leading
to various warnings.

Run generic/461 with ext4 upper/lower layer sometimes may trigger the
bug as below(linux 4.19):

[  551.001349] overlayfs: failed to get metacopy (-5)
[  551.003464] overlayfs: failed to get inode (-5)
[  551.004243] overlayfs: cleanup of 'd44/fd51' failed (-5)
[  551.004941] overlayfs: failed to get origin (-5)
[  551.005199] ------------[ cut here ]------------
[  551.006697] WARNING: CPU: 3 PID: 24674 at fs/inode.c:1528 iput+0x33b/0x400
...
[  551.027219] Call Trace:
[  551.027623]  ovl_create_object+0x13f/0x170
[  551.028268]  ovl_create+0x27/0x30
[  551.028799]  path_openat+0x1a35/0x1ea0
[  551.029377]  do_filp_open+0xad/0x160
[  551.029944]  ? vfs_writev+0xe9/0x170
[  551.030499]  ? page_counter_try_charge+0x77/0x120
[  551.031245]  ? __alloc_fd+0x160/0x2a0
[  551.031832]  ? do_sys_open+0x189/0x340
[  551.032417]  ? get_unused_fd_flags+0x34/0x40
[  551.033081]  do_sys_open+0x189/0x340
[  551.033632]  __x64_sys_creat+0x24/0x30
[  551.034219]  do_syscall_64+0xd5/0x430
[  551.034800]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

One solution is to improve error handling and call iget_failed() if error
is encountered. Amir thinks that this path is little intricate and there
is not real need to check and initialize OVL_UPPERDATA in ovl_get_inode().
Instead caller of ovl_get_inode() can initialize this state. And this
will avoid double checking of metacopy xattr lookup in ovl_lookup()
and ovl_get_inode().

OVL_UPPERDATA is inode flag. So I was little concerned that initializing
it outside ovl_get_inode() might have some races. But this is one way
transition. That is once a file has been fully copied up, it can't go
back to metacopy file again. And that seems to help avoid races. So
as of now I can't see any races w.r.t OVL_UPPERDATA being set wrongly. So
move settingof OVL_UPPERDATA inside the callers of ovl_get_inode().
ovl_obtain_alias() already does it. So only two callers now left
are ovl_lookup() and ovl_instantiate().

Reported-by: yangerkun <yangerkun@huawei.com>
Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/overlayfs/dir.c   |  2 ++
 fs/overlayfs/inode.c | 11 +----------
 fs/overlayfs/namei.c |  2 ++
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 279009dee366..a7cac2ce0fad 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -262,6 +262,8 @@ static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
 		inode = ovl_get_inode(dentry->d_sb, &oip);
 		if (IS_ERR(inode))
 			return PTR_ERR(inode);
+		if (inode == oip.newinode)
+			ovl_set_flag(OVL_UPPERDATA, inode);
 	} else {
 		WARN_ON(ovl_inode_real(inode) != d_inode(newdentry));
 		dput(newdentry);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 981f11ec51bc..f2aaf00821c0 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -957,7 +957,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
 	bool bylower = ovl_hash_bylower(sb, upperdentry, lowerdentry,
 					oip->index);
 	int fsid = bylower ? lowerpath->layer->fsid : 0;
-	bool is_dir, metacopy = false;
+	bool is_dir;
 	unsigned long ino = 0;
 	int err = oip->newinode ? -EEXIST : -ENOMEM;
 
@@ -1018,15 +1018,6 @@ struct inode *ovl_get_inode(struct super_block *sb,
 	if (oip->index)
 		ovl_set_flag(OVL_INDEX, inode);
 
-	if (upperdentry) {
-		err = ovl_check_metacopy_xattr(upperdentry);
-		if (err < 0)
-			goto out_err;
-		metacopy = err;
-		if (!metacopy)
-			ovl_set_flag(OVL_UPPERDATA, inode);
-	}
-
 	OVL_I(inode)->redirect = oip->redirect;
 
 	if (bylower)
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index a1889a160708..36e2b88a2fd1 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1078,6 +1078,8 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		err = PTR_ERR(inode);
 		if (IS_ERR(inode))
 			goto out_free_oe;
+		if (upperdentry && !uppermetacopy)
+			ovl_set_flag(OVL_UPPERDATA, inode);
 	}
 
 	ovl_dentry_update_reval(dentry, upperdentry,
-- 
2.25.4

