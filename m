Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A21723D064
	for <lists+linux-unionfs@lfdr.de>; Tue, 11 Jun 2019 17:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404331AbfFKPJh (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 11 Jun 2019 11:09:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34011 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404180AbfFKPJg (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 11 Jun 2019 11:09:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id e16so13492045wrn.1
        for <linux-unionfs@vger.kernel.org>; Tue, 11 Jun 2019 08:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MtRfOawYn0l9ahtzJ814YJYmwK2h3Ea8TeoiTwrFXBo=;
        b=ZgsfaTHzdROYDzW6oS9kICOsv0kNLanvq5rVKT0RnwMOjphOfekLrHIAnUgnP/lICn
         FM9DyUcKyK/J2jpWRgomQwDtTQiRHW7KqOZQac1RM1bIHNGsIX2p5twDm9K89gIJroAU
         N6M2XRc7ndt55CxUrS+5B9VFAr2co8fQjvueuXnBoqnI73fGp/3BaEy6JrqyjdksEGao
         Jd5/H0+6/JZ7Nrk4WImjqBYSEQQwtsmab5QUjPwpD5W7r53n4lB7FwSFDQ748bAXRTB4
         uBGDBZb4TksszFttGVughPHf1rIhbF4x5azb1QVjFY5vCRUuspP201bioHeMBb32eW/n
         BKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MtRfOawYn0l9ahtzJ814YJYmwK2h3Ea8TeoiTwrFXBo=;
        b=dc8707jvenfcqAlyEctg+U3Gg007ypLLNv9FXjgd/lQIJg5WQxr+7urDEywzq2+fAi
         q/CmrbQB1GM2IETpxyI4fSWBCnU674nPaP/2SCRVdX0NoUvX+81kbGAHJgbhs147djOz
         oFJ67eF4mW/Ru1va6334dutCf2VjFBTVeKs02gj07yE69i55ponZN5vs/F54WyQZQh/F
         ixUMMrAhMf8coML6rFpXiANWmdg31pAkLNQjI6gzvdglvMaILvyTkanX7TYilSxvuzHK
         Bcep6ZXP3XbzAmntqwvFqLHmY48l+Hr/wQTmldK0xklqgMoApNnEmK7XXbzEU8p0KhL+
         zfsg==
X-Gm-Message-State: APjAAAXxOzlCP5a8fXqz5HUHQGz8BsZYQ3PMf0Ui8JZ12Hy/6wB/z0r4
        QDU+xW9iqHcnjJNgedQXu5k=
X-Google-Smtp-Source: APXvYqxjz4rau0GfjVOAQcj+jOdRrpDsz1sVMBI12gFefbrAiZMohuHrEX4OVDHcQzMbkd0mGGC4gA==
X-Received: by 2002:a5d:480c:: with SMTP id l12mr25895865wrq.1.1560265774834;
        Tue, 11 Jun 2019 08:09:34 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id y12sm13297217wrr.3.2019.06.11.08.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 08:09:33 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        linux-unionfs@vger.kernel.org
Subject: [PATCH] ovl: fix wrong flags check in FS_IOC_FS[SG]ETXATTR ioctls
Date:   Tue, 11 Jun 2019 18:09:28 +0300
Message-Id: <20190611150928.12175-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

The ioctl argument was parsed as the wrong type.

Fixes: b21d9c435f93 ("ovl: support the FS_IOC_FS[SG]ETXATTR ioctls")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Miklos,

Please take this braino fix through the "fast track".
I have now an xfstest to verify the fix is correct.
Will post it shortly.

Thanks,
Amir.

 fs/overlayfs/file.c | 91 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 26 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 340a6ad45914..75d8d00fa087 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -409,37 +409,16 @@ static long ovl_real_ioctl(struct file *file, unsigned int cmd,
 	return ret;
 }
 
-static unsigned int ovl_get_inode_flags(struct inode *inode)
-{
-	unsigned int flags = READ_ONCE(inode->i_flags);
-	unsigned int ovl_iflags = 0;
-
-	if (flags & S_SYNC)
-		ovl_iflags |= FS_SYNC_FL;
-	if (flags & S_APPEND)
-		ovl_iflags |= FS_APPEND_FL;
-	if (flags & S_IMMUTABLE)
-		ovl_iflags |= FS_IMMUTABLE_FL;
-	if (flags & S_NOATIME)
-		ovl_iflags |= FS_NOATIME_FL;
-
-	return ovl_iflags;
-}
-
 static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
-				unsigned long arg)
+				unsigned long arg, unsigned int iflags)
 {
 	long ret;
 	struct inode *inode = file_inode(file);
-	unsigned int flags;
-	unsigned int old_flags;
+	unsigned int old_iflags;
 
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
-	if (get_user(flags, (int __user *) arg))
-		return -EFAULT;
-
 	ret = mnt_want_write_file(file);
 	if (ret)
 		return ret;
@@ -448,8 +427,8 @@ static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
 
 	/* Check the capability before cred override */
 	ret = -EPERM;
-	old_flags = ovl_get_inode_flags(inode);
-	if (((flags ^ old_flags) & (FS_APPEND_FL | FS_IMMUTABLE_FL)) &&
+	old_iflags = READ_ONCE(inode->i_flags);
+	if (((iflags ^ old_iflags) & (S_APPEND | S_IMMUTABLE)) &&
 	    !capable(CAP_LINUX_IMMUTABLE))
 		goto unlock;
 
@@ -469,6 +448,63 @@ static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
 
 }
 
+static unsigned int ovl_fsflags_to_iflags(unsigned int flags)
+{
+	unsigned int iflags = 0;
+
+	if (flags & FS_SYNC_FL)
+		iflags |= S_SYNC;
+	if (flags & FS_APPEND_FL)
+		iflags |= S_APPEND;
+	if (flags & FS_IMMUTABLE_FL)
+		iflags |= S_IMMUTABLE;
+	if (flags & FS_NOATIME_FL)
+		iflags |= S_NOATIME;
+
+	return iflags;
+}
+
+static long ovl_ioctl_set_fsflags(struct file *file, unsigned int cmd,
+				  unsigned long arg)
+{
+	unsigned int flags;
+
+	if (get_user(flags, (int __user *) arg))
+		return -EFAULT;
+
+	return ovl_ioctl_set_flags(file, cmd, arg,
+				   ovl_fsflags_to_iflags(flags));
+}
+
+static unsigned int ovl_fsxflags_to_iflags(unsigned int xflags)
+{
+	unsigned int iflags = 0;
+
+	if (xflags & FS_XFLAG_SYNC)
+		iflags |= S_SYNC;
+	if (xflags & FS_XFLAG_APPEND)
+		iflags |= S_APPEND;
+	if (xflags & FS_XFLAG_IMMUTABLE)
+		iflags |= S_IMMUTABLE;
+	if (xflags & FS_XFLAG_NOATIME)
+		iflags |= S_NOATIME;
+
+	return iflags;
+}
+
+static long ovl_ioctl_set_fsxflags(struct file *file, unsigned int cmd,
+				   unsigned long arg)
+{
+	struct fsxattr fa;
+
+	memset(&fa, 0, sizeof(fa));
+	if (copy_from_user(&fa, (void __user *) arg, sizeof(fa)))
+		return -EFAULT;
+
+	return ovl_ioctl_set_flags(file, cmd, arg,
+				   ovl_fsxflags_to_iflags(fa.fsx_xflags));
+}
+
 static long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	long ret;
@@ -480,8 +516,11 @@ static long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		break;
 
 	case FS_IOC_SETFLAGS:
+		ret = ovl_ioctl_set_fsflags(file, cmd, arg);
+		break;
+
 	case FS_IOC_FSSETXATTR:
-		ret = ovl_ioctl_set_flags(file, cmd, arg);
+		ret = ovl_ioctl_set_fsxflags(file, cmd, arg);
 		break;
 
 	default:
-- 
2.17.1

