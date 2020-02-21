Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5466167FD9
	for <lists+linux-unionfs@lfdr.de>; Fri, 21 Feb 2020 15:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgBUOM5 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 21 Feb 2020 09:12:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55740 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgBUOM5 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 21 Feb 2020 09:12:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so1939558wmj.5
        for <linux-unionfs@vger.kernel.org>; Fri, 21 Feb 2020 06:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZPs5fPBZprJxfDg788Lxbjm1LMN1R51tsrnCUtbYnNA=;
        b=ZPDN6fTOlp4E7u4saJ4iUTqEtrJ8HiNvySPObqq0QBpCl6zOLAgMy37le7NakYPbKe
         W+7WxB0WEP48Z68zTS9wTLoeVjEAOhPHY90jcnQ/j3FOydCWd1JdPqnOpcXuNAgascjh
         xxpCsMankNNgwqn5p4UWMMKhtQbrM4vlJOct298sBSQMles+Gm8kWOKs3lKOEKIlRta/
         7bZOv/PuLyi/Cd7uCqFRPyRXr1pLKPfRxZquPAZLHjr2kZQ9EZZQiD14eksIN1rqtnzi
         M0RXsjivi3MISnTlcyAYSDFHGmwBkAxVSJtj6IqnlQVbyYCMMZDMYi2NnS7POq/M2UPd
         0M9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZPs5fPBZprJxfDg788Lxbjm1LMN1R51tsrnCUtbYnNA=;
        b=V2AZvd2GXnmjSbDAKMUVyJjgB5ZlTexwJDqpkjGup8hdYQ0H5QyYgwW1xJypH9gOW0
         mwyDsywfcT5A0TKI4svHTW29GBAw3Y5I4ST9YhkltTdEQRD/yJWvVWexYihUSLtODej+
         VbKjyl+atzRdoShbk5O8hY0WeYrnENdBP3/XKsGQ7CfWyy4/wzh5KlkzdqTiCQZLnGED
         zsD/TbKhbDLXKTaMWt6O/1ffgZVCLHNAsxAOdEaBQ4ZQaRo7GFWrdN6eGha5cvB/J1zP
         yknt06BmBns+TrKBDuOwaQ7rMotl89ES0Bv1jw4T4SLS/aed1KgyKhYx6fAvncyv84d1
         /GWA==
X-Gm-Message-State: APjAAAU3ee+nHnaPaC+XmD7H/+H191e+J28HW/fqmVQbtwi6zfRlrm/S
        QDr/ilDmWXozAU9kkebYj/o=
X-Google-Smtp-Source: APXvYqzODdaA9oPdO1h+REC5T61lBOQn/GKX8rhUhAxmJWxPv17m1er9o9BPOTTmOM0zW6PT5c3M0g==
X-Received: by 2002:a1c:9646:: with SMTP id y67mr4076628wmd.42.1582294373635;
        Fri, 21 Feb 2020 06:12:53 -0800 (PST)
Received: from localhost.localdomain ([141.226.9.174])
        by smtp.gmail.com with ESMTPSA id y12sm4104916wrw.88.2020.02.21.06.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 06:12:53 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-unionfs@vger.kernel.org
Subject: [PATCH 2/3] ovl: check if upper fs supports RENAME_WHITEOUT
Date:   Fri, 21 Feb 2020 16:12:44 +0200
Message-Id: <20200221141245.6773-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200221141245.6773-1-amir73il@gmail.com>
References: <20200221141245.6773-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

As with other required upper fs features, we only warn if support
is missing to avoid breaking existing sub-optimal setups.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/dir.c       |  2 +-
 fs/overlayfs/overlayfs.h |  1 +
 fs/overlayfs/super.c     | 69 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index b3471ef51440..c91b5aae8e32 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -42,7 +42,7 @@ int ovl_cleanup(struct inode *wdir, struct dentry *wdentry)
 	return err;
 }
 
-static struct dentry *ovl_lookup_temp(struct dentry *workdir)
+struct dentry *ovl_lookup_temp(struct dentry *workdir)
 {
 	struct dentry *temp;
 	char name[20];
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 8d67dc7c1c04..68df20512dca 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -448,6 +448,7 @@ struct ovl_cattr {
 struct dentry *ovl_create_real(struct inode *dir, struct dentry *newdentry,
 			       struct ovl_cattr *attr);
 int ovl_cleanup(struct inode *dir, struct dentry *dentry);
+struct dentry *ovl_lookup_temp(struct dentry *workdir);
 struct dentry *ovl_create_temp(struct dentry *workdir, struct ovl_cattr *attr);
 
 /* file.c */
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 19c79619529b..7322cf8faea4 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1071,6 +1071,66 @@ static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
 	return err;
 }
 
+/*
+ * Returns 1 if RENAME_WHITEOUT is supported, 0 if not supported and
+ * negative values if error is encountered.
+ */
+static int ovl_check_rename_whiteout(struct dentry *workdir)
+{
+	struct inode *dir = d_inode(workdir);
+	struct dentry *temp;
+	struct dentry *dest;
+	struct dentry *whiteout;
+	struct name_snapshot name;
+	int err;
+
+	inode_lock_nested(dir, I_MUTEX_PARENT);
+
+	temp = ovl_create_temp(workdir, OVL_CATTR(S_IFREG | 0));
+	err = PTR_ERR(temp);
+	if (IS_ERR(temp))
+		goto out_unlock;
+
+	dest = ovl_lookup_temp(workdir);
+	err = PTR_ERR(dest);
+	if (IS_ERR(dest)) {
+		dput(temp);
+		goto out_unlock;
+	}
+
+	/* Name is inline and stable - using snapshot as a copy helper */
+	take_dentry_name_snapshot(&name, temp);
+	err = ovl_do_rename(dir, temp, dir, dest, RENAME_WHITEOUT);
+	if (err) {
+		if (err == -EINVAL)
+			err = 0;
+		goto cleanup_temp;
+	}
+
+	whiteout = lookup_one_len(name.name.name, workdir, name.name.len);
+	err = PTR_ERR(whiteout);
+	if (IS_ERR(whiteout))
+		goto cleanup_temp;
+
+	err = ovl_is_whiteout(whiteout);
+
+	/* Best effort cleanup of whiteout and temp file */
+	if (err)
+		ovl_cleanup(dir, whiteout);
+	dput(whiteout);
+
+cleanup_temp:
+	ovl_cleanup(dir, temp);
+	release_dentry_name_snapshot(&name);
+	dput(temp);
+	dput(dest);
+
+out_unlock:
+	inode_unlock(dir);
+
+	return err;
+}
+
 static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 			    struct path *workpath)
 {
@@ -1116,6 +1176,15 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 	else
 		pr_warn("upper fs does not support tmpfile.\n");
 
+
+	/* Check if upper/work fs supports RENAME_WHITEOUT */
+	err = ovl_check_rename_whiteout(ofs->workdir);
+	if (err < 0)
+		goto out;
+
+	if (!err)
+		pr_warn("upper fs does not support RENAME_WHITEOUT.\n");
+
 	/*
 	 * Check if upper/work fs supports trusted.overlay.* xattr
 	 */
-- 
2.17.1

