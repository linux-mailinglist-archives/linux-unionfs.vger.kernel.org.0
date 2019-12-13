Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0755711E296
	for <lists+linux-unionfs@lfdr.de>; Fri, 13 Dec 2019 12:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfLMLNl (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 13 Dec 2019 06:13:41 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:42219 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfLMLNl (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 13 Dec 2019 06:13:41 -0500
Received: by mail-pj1-f68.google.com with SMTP id o11so1057118pjp.9
        for <linux-unionfs@vger.kernel.org>; Fri, 13 Dec 2019 03:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JJ9aYFmTYaFJ7Xy2iv/B3kTRIND/DYBRBbjNC7lmdSE=;
        b=pv5Q+SLU2nhh4PzXAVGzTqRY+AUQjeI5X4B1gnERhhtZklW6YFawk+BYPqZjQsZQc/
         8R/VP1GDnaJqg+O5RwffspbIZpwMBBXHA/eTJCV01M+n2ja+PCgy/qQyp+qUgW2o8hQy
         o9FhTSoGICUJV8q/vU4lC7bFwdlABkvRFL/HoIDkdEYZTBHZdgsZ0K8jnc1c0t1BK9EY
         VBNyAWj0RDT+Df7XWT6nPStqCyq6DX75B+fBbTGO7/oV0Tf2rofE/35ldXpM02Ar6AZ/
         N/mZco5QYhDnKDvydMEJHAsXM4ei5hPdaom1VjOzOIshSTmxFLpaVnwGLGPsHfZA2EK5
         4nFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JJ9aYFmTYaFJ7Xy2iv/B3kTRIND/DYBRBbjNC7lmdSE=;
        b=tekhbQmGdd22Z+vOtnDqq91nuR4FUEHLPh9uFjX3xqmJUGWPNDPXYNxPPMM8L6v4eM
         QhMUCjtkrViXiQiwc5QOAPefejf0Yd0xVUYPPNETdY5R1h9BU5r4qEVbdMJfxZaPn5/c
         EyongAGlp9StZiJjzW+tuleEQrBFQyWBeb2kzUuCZHLbwp3THlHiMze9P9U2tMa5sIZK
         /lPFimJJZ5NJ8IOpFQytQ7vQg+HRA88E8s7EZ3+DNaCUyN4yKEphE68OKh1307wqD1DG
         nePcAAcxzI/ieKhdQZ0fP0YgzgANGMTQRUuXBgtoDQLr+9oSDYbipfEu2wzWlM6JumIt
         FXkg==
X-Gm-Message-State: APjAAAXzpuIoviubxGGTeEMzsQciwqcq0FjJAwrArbhmPml6f+Vyn0zW
        C3yLFMjAYlDlbITYofbX8l7J9XDl
X-Google-Smtp-Source: APXvYqx8ruym7g8Fydhlqk+4XAnDUM9rq4fdAZql/sZrqEO62iCFJ/n71q43MJeMQydhiBw/ai4hLw==
X-Received: by 2002:a17:902:968f:: with SMTP id n15mr15385521plp.12.1576235619350;
        Fri, 13 Dec 2019 03:13:39 -0800 (PST)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id m14sm9046083pjf.10.2019.12.13.03.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 03:13:38 -0800 (PST)
From:   lijiazi <jqqlijiazi@gmail.com>
X-Google-Original-From: lijiazi <lijiazi@xiaomi.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     lijiazi <lijiazi@xiaomi.com>, linux-unionfs@vger.kernel.org
Subject: [PATCH] ovl: use pr_fmt auto generate prefix
Date:   Fri, 13 Dec 2019 19:13:28 +0800
Message-Id: <1e61319cf6d1f3c8f313a01b0198be4745f9f460.1576208513.git.lijiazi@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Use pr_fmt auto generate "overlayfs: " prefix.

Signed-off-by: lijiazi <lijiazi@xiaomi.com>
---
 fs/overlayfs/Makefile    |  4 +--
 fs/overlayfs/copy_up.c   |  2 +-
 fs/overlayfs/dir.c       | 10 +++---
 fs/overlayfs/export.c    | 12 +++----
 fs/overlayfs/inode.c     |  6 ++--
 fs/overlayfs/namei.c     | 26 +++++++--------
 fs/overlayfs/overlayfs.h |  6 ++++
 fs/overlayfs/readdir.c   |  8 ++---
 fs/overlayfs/super.c     | 85 ++++++++++++++++++++++++------------------------
 fs/overlayfs/util.c      | 14 ++++----
 10 files changed, 90 insertions(+), 83 deletions(-)

diff --git a/fs/overlayfs/Makefile b/fs/overlayfs/Makefile
index 9164c58..73ba668 100644
--- a/fs/overlayfs/Makefile
+++ b/fs/overlayfs/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the overlay filesystem.
 #
 
-obj-$(CONFIG_OVERLAY_FS) += overlay.o
+obj-$(CONFIG_OVERLAY_FS) += overlayfs.o
 
-overlay-objs := super.o namei.o util.o inode.o file.o dir.o readdir.o \
+overlayfs-objs := super.o namei.o util.o inode.o file.o dir.o readdir.o \
 		copy_up.o export.o
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 1515ac8..9fc47c2 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -24,7 +24,7 @@
 
 static int ovl_ccup_set(const char *buf, const struct kernel_param *param)
 {
-	pr_warn("overlayfs: \"check_copy_up\" module option is obsolete\n");
+	pr_warn("\"check_copy_up\" module option is obsolete\n");
 	return 0;
 }
 
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 29abdb1..8e57d53 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -35,7 +35,7 @@ int ovl_cleanup(struct inode *wdir, struct dentry *wdentry)
 	dput(wdentry);
 
 	if (err) {
-		pr_err("overlayfs: cleanup of '%pd2' failed (%i)\n",
+		pr_err("cleanup of '%pd2' failed (%i)\n",
 		       wdentry, err);
 	}
 
@@ -53,7 +53,7 @@ static struct dentry *ovl_lookup_temp(struct dentry *workdir)
 
 	temp = lookup_one_len(name, workdir, strlen(name));
 	if (!IS_ERR(temp) && temp->d_inode) {
-		pr_err("overlayfs: workdir/%s already exists\n", name);
+		pr_err("workdir/%s already exists\n", name);
 		dput(temp);
 		temp = ERR_PTR(-EIO);
 	}
@@ -134,7 +134,7 @@ static int ovl_mkdir_real(struct inode *dir, struct dentry **newdentry,
 	d = lookup_one_len(dentry->d_name.name, dentry->d_parent,
 			   dentry->d_name.len);
 	if (IS_ERR(d)) {
-		pr_warn("overlayfs: failed lookup after mkdir (%pd2, err=%i).\n",
+		pr_warn("failed lookup after mkdir (%pd2, err=%i).\n",
 			dentry, err);
 		return PTR_ERR(d);
 	}
@@ -267,7 +267,7 @@ static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
 
 	d_instantiate(dentry, inode);
 	if (inode != oip.newinode) {
-		pr_warn_ratelimited("overlayfs: newly created inode found in cache (%pd2)\n",
+		pr_warn_ratelimited("newly created inode found in cache (%pd2)\n",
 				    dentry);
 	}
 
@@ -1009,7 +1009,7 @@ static int ovl_set_redirect(struct dentry *dentry, bool samedir)
 		spin_unlock(&dentry->d_lock);
 	} else {
 		kfree(redirect);
-		pr_warn_ratelimited("overlayfs: failed to set redirect (%i)\n",
+		pr_warn_ratelimited("failed to set redirect (%i)\n",
 				    err);
 		/* Fall back to userspace copy-up */
 		err = -EXDEV;
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 70e5558..2fe7242 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -30,7 +30,7 @@ static int ovl_encode_maybe_copy_up(struct dentry *dentry)
 	}
 
 	if (err) {
-		pr_warn_ratelimited("overlayfs: failed to copy up on encode (%pd2, err=%i)\n",
+		pr_warn_ratelimited("failed to copy up on encode (%pd2, err=%i)\n",
 				    dentry, err);
 	}
 
@@ -244,7 +244,7 @@ static int ovl_dentry_to_fid(struct dentry *dentry, u32 *fid, int buflen)
 	return err;
 
 fail:
-	pr_warn_ratelimited("overlayfs: failed to encode file handle (%pd2, err=%i, buflen=%d, len=%d, type=%d)\n",
+	pr_warn_ratelimited("failed to encode file handle (%pd2, err=%i, buflen=%d, len=%d, type=%d)\n",
 			    dentry, err, buflen, fh ? (int)fh->fb.len : 0,
 			    fh ? fh->fb.type : 0);
 	goto out;
@@ -406,7 +406,7 @@ static struct dentry *ovl_lookup_real_one(struct dentry *connected,
 	return this;
 
 fail:
-	pr_warn_ratelimited("overlayfs: failed to lookup one by real (%pd2, layer=%d, connected=%pd2, err=%i)\n",
+	pr_warn_ratelimited("failed to lookup one by real (%pd2, layer=%d, connected=%pd2, err=%i)\n",
 			    real, layer->idx, connected, err);
 	this = ERR_PTR(err);
 	goto out;
@@ -631,7 +631,7 @@ static struct dentry *ovl_lookup_real(struct super_block *sb,
 	return connected;
 
 fail:
-	pr_warn_ratelimited("overlayfs: failed to lookup by real (%pd2, layer=%d, connected=%pd2, err=%i)\n",
+	pr_warn_ratelimited("failed to lookup by real (%pd2, layer=%d, connected=%pd2, err=%i)\n",
 			    real, layer->idx, connected, err);
 	dput(connected);
 	return ERR_PTR(err);
@@ -822,7 +822,7 @@ static struct dentry *ovl_fh_to_dentry(struct super_block *sb, struct fid *fid,
 	return dentry;
 
 out_err:
-	pr_warn_ratelimited("overlayfs: failed to decode file handle (len=%d, type=%d, flags=%x, err=%i)\n",
+	pr_warn_ratelimited("failed to decode file handle (len=%d, type=%d, flags=%x, err=%i)\n",
 			    fh_len, fh_type, flags, err);
 	dentry = ERR_PTR(err);
 	goto out;
@@ -831,7 +831,7 @@ static struct dentry *ovl_fh_to_dentry(struct super_block *sb, struct fid *fid,
 static struct dentry *ovl_fh_to_parent(struct super_block *sb, struct fid *fid,
 				       int fh_len, int fh_type)
 {
-	pr_warn_ratelimited("overlayfs: connectable file handles not supported; use 'no_subtree_check' exportfs option.\n");
+	pr_warn_ratelimited("connectable file handles not supported; use 'no_subtree_check' exportfs option.\n");
 	return ERR_PTR(-EACCES);
 }
 
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index b045cf1..bfebef7 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -100,7 +100,7 @@ static int ovl_map_dev_ino(struct dentry *dentry, struct kstat *stat,
 		 * persistent for a given layer configuration.
 		 */
 		if (stat->ino >> shift) {
-			pr_warn_ratelimited("overlayfs: inode number too big (%pd2, ino=%llu, xinobits=%d)\n",
+			pr_warn_ratelimited("inode number too big (%pd2, ino=%llu, xinobits=%d)\n",
 					    dentry, stat->ino, xinobits);
 		} else {
 			if (lower_layer)
@@ -698,7 +698,7 @@ unsigned int ovl_get_nlink(struct dentry *lowerdentry,
 	return nlink;
 
 fail:
-	pr_warn_ratelimited("overlayfs: failed to get index nlink (%pd2, err=%i)\n",
+	pr_warn_ratelimited("failed to get index nlink (%pd2, err=%i)\n",
 			    upperdentry, err);
 	return fallback;
 }
@@ -969,7 +969,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
 	return inode;
 
 out_err:
-	pr_warn_ratelimited("overlayfs: failed to get inode (%i)\n", err);
+	pr_warn_ratelimited("failed to get inode (%i)\n", err);
 	inode = ERR_PTR(err);
 	goto out;
 }
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 76ff663..205163f 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -141,10 +141,10 @@ static struct ovl_fh *ovl_get_fh(struct dentry *dentry, const char *name)
 	return NULL;
 
 fail:
-	pr_warn_ratelimited("overlayfs: failed to get origin (%i)\n", res);
+	pr_warn_ratelimited("failed to get origin (%i)\n", res);
 	goto out;
 invalid:
-	pr_warn_ratelimited("overlayfs: invalid origin (%*phN)\n", res, fh);
+	pr_warn_ratelimited("invalid origin (%*phN)\n", res, fh);
 	goto out;
 }
 
@@ -360,7 +360,7 @@ int ovl_check_origin_fh(struct ovl_fs *ofs, struct ovl_fh *fh, bool connected,
 	return 0;
 
 invalid:
-	pr_warn_ratelimited("overlayfs: invalid origin (%pd2, ftype=%x, origin ftype=%x).\n",
+	pr_warn_ratelimited("invalid origin (%pd2, ftype=%x, origin ftype=%x).\n",
 			    upperdentry, d_inode(upperdentry)->i_mode & S_IFMT,
 			    d_inode(origin)->i_mode & S_IFMT);
 	dput(origin);
@@ -449,7 +449,7 @@ int ovl_verify_set_fh(struct dentry *dentry, const char *name,
 
 fail:
 	inode = d_inode(real);
-	pr_warn_ratelimited("overlayfs: failed to verify %s (%pd2, ino=%lu, err=%i)\n",
+	pr_warn_ratelimited("failed to verify %s (%pd2, ino=%lu, err=%i)\n",
 			    is_upper ? "upper" : "origin", real,
 			    inode ? inode->i_ino : 0, err);
 	goto out;
@@ -475,7 +475,7 @@ struct dentry *ovl_index_upper(struct ovl_fs *ofs, struct dentry *index)
 		return upper ?: ERR_PTR(-ESTALE);
 
 	if (!d_is_dir(upper)) {
-		pr_warn_ratelimited("overlayfs: invalid index upper (%pd2, upper=%pd2).\n",
+		pr_warn_ratelimited("invalid index upper (%pd2, upper=%pd2).\n",
 				    index, upper);
 		dput(upper);
 		return ERR_PTR(-EIO);
@@ -589,12 +589,12 @@ int ovl_verify_index(struct ovl_fs *ofs, struct dentry *index)
 	return err;
 
 fail:
-	pr_warn_ratelimited("overlayfs: failed to verify index (%pd2, ftype=%x, err=%i)\n",
+	pr_warn_ratelimited("failed to verify index (%pd2, ftype=%x, err=%i)\n",
 			    index, d_inode(index)->i_mode & S_IFMT, err);
 	goto out;
 
 orphan:
-	pr_warn_ratelimited("overlayfs: orphan index entry (%pd2, ftype=%x, nlink=%u)\n",
+	pr_warn_ratelimited("orphan index entry (%pd2, ftype=%x, nlink=%u)\n",
 			    index, d_inode(index)->i_mode & S_IFMT,
 			    d_inode(index)->i_nlink);
 	err = -ENOENT;
@@ -696,7 +696,7 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
 			index = NULL;
 			goto out;
 		}
-		pr_warn_ratelimited("overlayfs: failed inode index lookup (ino=%lu, key=%.*s, err=%i);\n"
+		pr_warn_ratelimited("failed inode index lookup (ino=%lu, key=%.*s, err=%i);\n"
 				    "overlayfs: mount with '-o index=off' to disable inodes index.\n",
 				    d_inode(origin)->i_ino, name.len, name.name,
 				    err);
@@ -723,13 +723,13 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
 		 * unlinked, which means that finding a lower origin on lookup
 		 * whose index is a whiteout should be treated as an error.
 		 */
-		pr_warn_ratelimited("overlayfs: bad index found (index=%pd2, ftype=%x, origin ftype=%x).\n",
+		pr_warn_ratelimited("bad index found (index=%pd2, ftype=%x, origin ftype=%x).\n",
 				    index, d_inode(index)->i_mode & S_IFMT,
 				    d_inode(origin)->i_mode & S_IFMT);
 		goto fail;
 	} else if (is_dir && verify) {
 		if (!upper) {
-			pr_warn_ratelimited("overlayfs: suspected uncovered redirected dir found (origin=%pd2, index=%pd2).\n",
+			pr_warn_ratelimited("suspected uncovered redirected dir found (origin=%pd2, index=%pd2).\n",
 					    origin, index);
 			goto fail;
 		}
@@ -738,7 +738,7 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
 		err = ovl_verify_upper(index, upper, false);
 		if (err) {
 			if (err == -ESTALE) {
-				pr_warn_ratelimited("overlayfs: suspected multiply redirected dir found (upper=%pd2, origin=%pd2, index=%pd2).\n",
+				pr_warn_ratelimited("suspected multiply redirected dir found (upper=%pd2, origin=%pd2, index=%pd2).\n",
 						    upper, origin, index);
 			}
 			goto fail;
@@ -967,7 +967,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		 */
 		err = -EPERM;
 		if (d.redirect && !ofs->config.redirect_follow) {
-			pr_warn_ratelimited("overlayfs: refusing to follow redirect for (%pd2)\n",
+			pr_warn_ratelimited("refusing to follow redirect for (%pd2)\n",
 					    dentry);
 			goto out_put;
 		}
@@ -994,7 +994,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 
 		err = -EPERM;
 		if (!ofs->config.metacopy) {
-			pr_warn_ratelimited("overlay: refusing to follow metacopy origin for (%pd2)\n",
+			pr_warn_ratelimited("refusing to follow metacopy origin for (%pd2)\n",
 					    dentry);
 			goto out_put;
 		}
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index f283b1d6..03aa567 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -4,6 +4,12 @@
  * Copyright (C) 2011 Novell Inc.
  */
 
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/uuid.h>
 #include <linux/fs.h>
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 47a91c9..36d27b5 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -441,7 +441,7 @@ static u64 ovl_remap_lower_ino(u64 ino, int xinobits, int fsid,
 			       const char *name, int namelen)
 {
 	if (ino >> (64 - xinobits)) {
-		pr_warn_ratelimited("overlayfs: d_ino too big (%.*s, ino=%llu, xinobits=%d)\n",
+		pr_warn_ratelimited("d_ino too big (%.*s, ino=%llu, xinobits=%d)\n",
 				    namelen, name, ino, xinobits);
 		return ino;
 	}
@@ -518,7 +518,7 @@ static int ovl_cache_update_ino(struct path *path, struct ovl_cache_entry *p)
 	return err;
 
 fail:
-	pr_warn_ratelimited("overlayfs: failed to look up (%s) for ino (%i)\n",
+	pr_warn_ratelimited("failed to look up (%s) for ino (%i)\n",
 			    p->name, err);
 	goto out;
 }
@@ -965,7 +965,7 @@ void ovl_cleanup_whiteouts(struct dentry *upper, struct list_head *list)
 
 		dentry = lookup_one_len(p->name, upper, p->len);
 		if (IS_ERR(dentry)) {
-			pr_err("overlayfs: lookup '%s/%.*s' failed (%i)\n",
+			pr_err("lookup '%s/%.*s' failed (%i)\n",
 			       upper->d_name.name, p->len, p->name,
 			       (int) PTR_ERR(dentry));
 			continue;
@@ -1147,6 +1147,6 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 out:
 	ovl_cache_free(&list);
 	if (err)
-		pr_err("overlayfs: failed index dir cleanup (%i)\n", err);
+		pr_err("failed index dir cleanup (%i)\n", err);
 	return err;
 }
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 7621ff1..cce483a 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -462,7 +462,7 @@ static int ovl_parse_redirect_mode(struct ovl_config *config, const char *mode)
 		if (ovl_redirect_always_follow)
 			config->redirect_follow = true;
 	} else if (strcmp(mode, "nofollow") != 0) {
-		pr_err("overlayfs: bad mount option \"redirect_dir=%s\"\n",
+		pr_err("bad mount option \"redirect_dir=%s\"\n",
 		       mode);
 		return -EINVAL;
 	}
@@ -560,14 +560,15 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 			break;
 
 		default:
-			pr_err("overlayfs: unrecognized mount option \"%s\" or missing value\n", p);
+			pr_err("unrecognized mount option \"%s\" or missing value\n",
+					p);
 			return -EINVAL;
 		}
 	}
 
 	/* Workdir is useless in non-upper mount */
 	if (!config->upperdir && config->workdir) {
-		pr_info("overlayfs: option \"workdir=%s\" is useless in a non-upper mount, ignore\n",
+		pr_info("option \"workdir=%s\" is useless in a non-upper mount, ignore\n",
 			config->workdir);
 		kfree(config->workdir);
 		config->workdir = NULL;
@@ -587,7 +588,7 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 	/* Resolve metacopy -> redirect_dir dependency */
 	if (config->metacopy && !config->redirect_dir) {
 		if (metacopy_opt && redirect_opt) {
-			pr_err("overlayfs: conflicting options: metacopy=on,redirect_dir=%s\n",
+			pr_err("conflicting options: metacopy=on,redirect_dir=%s\n",
 			       config->redirect_mode);
 			return -EINVAL;
 		}
@@ -596,7 +597,7 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 			 * There was an explicit redirect_dir=... that resulted
 			 * in this conflict.
 			 */
-			pr_info("overlayfs: disabling metacopy due to redirect_dir=%s\n",
+			pr_info("disabling metacopy due to redirect_dir=%s\n",
 				config->redirect_mode);
 			config->metacopy = false;
 		} else {
@@ -692,7 +693,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 out_dput:
 	dput(work);
 out_err:
-	pr_warn("overlayfs: failed to create directory %s/%s (errno: %i); mounting read-only\n",
+	pr_warn("failed to create directory %s/%s (errno: %i); mounting read-only\n",
 		ofs->config.workdir, name, -err);
 	work = NULL;
 	goto out_unlock;
@@ -716,21 +717,21 @@ static int ovl_mount_dir_noesc(const char *name, struct path *path)
 	int err = -EINVAL;
 
 	if (!*name) {
-		pr_err("overlayfs: empty lowerdir\n");
+		pr_err("empty lowerdir\n");
 		goto out;
 	}
 	err = kern_path(name, LOOKUP_FOLLOW, path);
 	if (err) {
-		pr_err("overlayfs: failed to resolve '%s': %i\n", name, err);
+		pr_err("failed to resolve '%s': %i\n", name, err);
 		goto out;
 	}
 	err = -EINVAL;
 	if (ovl_dentry_weird(path->dentry)) {
-		pr_err("overlayfs: filesystem on '%s' not supported\n", name);
+		pr_err("filesystem on '%s' not supported\n", name);
 		goto out_put;
 	}
 	if (!d_is_dir(path->dentry)) {
-		pr_err("overlayfs: '%s' not a directory\n", name);
+		pr_err("'%s' not a directory\n", name);
 		goto out_put;
 	}
 	return 0;
@@ -752,7 +753,7 @@ static int ovl_mount_dir(const char *name, struct path *path)
 
 		if (!err)
 			if (ovl_dentry_remote(path->dentry)) {
-				pr_err("overlayfs: filesystem on '%s' not supported as upperdir\n",
+				pr_err("filesystem on '%s' not supported as upperdir\n",
 				       tmp);
 				path_put_init(path);
 				err = -EINVAL;
@@ -769,7 +770,7 @@ static int ovl_check_namelen(struct path *path, struct ovl_fs *ofs,
 	int err = vfs_statfs(path, &statfs);
 
 	if (err)
-		pr_err("overlayfs: statfs failed on '%s'\n", name);
+		pr_err("statfs failed on '%s'\n", name);
 	else
 		ofs->namelen = max(ofs->namelen, statfs.f_namelen);
 
@@ -804,7 +805,7 @@ static int ovl_lower_dir(const char *name, struct path *path,
 	     (ofs->config.index && ofs->config.upperdir)) && !fh_type) {
 		ofs->config.index = false;
 		ofs->config.nfs_export = false;
-		pr_warn("overlayfs: fs on '%s' does not support file handles, falling back to index=off,nfs_export=off.\n",
+		pr_warn("fs on '%s' does not support file handles, falling back to index=off,nfs_export=off.\n",
 			name);
 	}
 
@@ -996,7 +997,7 @@ static int ovl_setup_trap(struct super_block *sb, struct dentry *dir,
 	err = PTR_ERR_OR_ZERO(trap);
 	if (err) {
 		if (err == -ELOOP)
-			pr_err("overlayfs: conflicting %s path\n", name);
+			pr_err("conflicting %s path\n", name);
 		return err;
 	}
 
@@ -1013,11 +1014,11 @@ static int ovl_setup_trap(struct super_block *sb, struct dentry *dir,
 static int ovl_report_in_use(struct ovl_fs *ofs, const char *name)
 {
 	if (ofs->config.index) {
-		pr_err("overlayfs: %s is in-use as upperdir/workdir of another mount, mount with '-o index=off' to override exclusive upperdir protection.\n",
+		pr_err("%s is in-use as upperdir/workdir of another mount, mount with '-o index=off' to override exclusive upperdir protection.\n",
 		       name);
 		return -EBUSY;
 	} else {
-		pr_warn("overlayfs: %s is in-use as upperdir/workdir of another mount, accessing files from both mounts will result in undefined behavior.\n",
+		pr_warn("%s is in-use as upperdir/workdir of another mount, accessing files from both mounts will result in undefined behavior.\n",
 			name);
 		return 0;
 	}
@@ -1035,7 +1036,7 @@ static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
 
 	/* Upper fs should not be r/o */
 	if (sb_rdonly(upperpath->mnt->mnt_sb)) {
-		pr_err("overlayfs: upper fs is r/o, try multi-lower layers mount\n");
+		pr_err("upper fs is r/o, try multi-lower layers mount\n");
 		err = -EINVAL;
 		goto out;
 	}
@@ -1052,7 +1053,7 @@ static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
 	upper_mnt = clone_private_mount(upperpath);
 	err = PTR_ERR(upper_mnt);
 	if (IS_ERR(upper_mnt)) {
-		pr_err("overlayfs: failed to clone upperpath\n");
+		pr_err("failed to clone upperpath\n");
 		goto out;
 	}
 
@@ -1108,7 +1109,7 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 	 * kernel upgrade. So warn instead of erroring out.
 	 */
 	if (!err)
-		pr_warn("overlayfs: upper fs needs to support d_type.\n");
+		pr_warn("upper fs needs to support d_type.\n");
 
 	/* Check if upper/work fs supports O_TMPFILE */
 	temp = ovl_do_tmpfile(ofs->workdir, S_IFREG | 0);
@@ -1116,7 +1117,7 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 	if (ofs->tmpfile)
 		dput(temp);
 	else
-		pr_warn("overlayfs: upper fs does not support tmpfile.\n");
+		pr_warn("upper fs does not support tmpfile.\n");
 
 	/*
 	 * Check if upper/work fs supports trusted.overlay.* xattr
@@ -1126,7 +1127,7 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 		ofs->noxattr = true;
 		ofs->config.index = false;
 		ofs->config.metacopy = false;
-		pr_warn("overlayfs: upper fs does not support xattr, falling back to index=off and metacopy=off.\n");
+		pr_warn("upper fs does not support xattr, falling back to index=off and metacopy=off.\n");
 		err = 0;
 	} else {
 		vfs_removexattr(ofs->workdir, OVL_XATTR_OPAQUE);
@@ -1136,7 +1137,7 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 	fh_type = ovl_can_decode_fh(ofs->workdir->d_sb);
 	if (ofs->config.index && !fh_type) {
 		ofs->config.index = false;
-		pr_warn("overlayfs: upper fs does not support file handles, falling back to index=off.\n");
+		pr_warn("upper fs does not support file handles, falling back to index=off.\n");
 	}
 
 	/* Check if upper fs has 32bit inode numbers */
@@ -1145,7 +1146,7 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 
 	/* NFS export of r/w mount depends on index */
 	if (ofs->config.nfs_export && !ofs->config.index) {
-		pr_warn("overlayfs: NFS export requires \"index=on\", falling back to nfs_export=off.\n");
+		pr_warn("NFS export requires \"index=on\", falling back to nfs_export=off.\n");
 		ofs->config.nfs_export = false;
 	}
 out:
@@ -1165,11 +1166,11 @@ static int ovl_get_workdir(struct super_block *sb, struct ovl_fs *ofs,
 
 	err = -EINVAL;
 	if (upperpath->mnt != workpath.mnt) {
-		pr_err("overlayfs: workdir and upperdir must reside under the same mount\n");
+		pr_err("workdir and upperdir must reside under the same mount\n");
 		goto out;
 	}
 	if (!ovl_workdir_ok(workpath.dentry, upperpath->dentry)) {
-		pr_err("overlayfs: workdir and upperdir must be separate subtrees\n");
+		pr_err("workdir and upperdir must be separate subtrees\n");
 		goto out;
 	}
 
@@ -1210,7 +1211,7 @@ static int ovl_get_indexdir(struct super_block *sb, struct ovl_fs *ofs,
 	err = ovl_verify_origin(upperpath->dentry, oe->lowerstack[0].dentry,
 				true);
 	if (err) {
-		pr_err("overlayfs: failed to verify upper root origin\n");
+		pr_err("failed to verify upper root origin\n");
 		goto out;
 	}
 
@@ -1233,18 +1234,18 @@ static int ovl_get_indexdir(struct super_block *sb, struct ovl_fs *ofs,
 			err = ovl_verify_set_fh(ofs->indexdir, OVL_XATTR_ORIGIN,
 						upperpath->dentry, true, false);
 			if (err)
-				pr_err("overlayfs: failed to verify index dir 'origin' xattr\n");
+				pr_err("failed to verify index dir 'origin' xattr\n");
 		}
 		err = ovl_verify_upper(ofs->indexdir, upperpath->dentry, true);
 		if (err)
-			pr_err("overlayfs: failed to verify index dir 'upper' xattr\n");
+			pr_err("failed to verify index dir 'upper' xattr\n");
 
 		/* Cleanup bad/stale/orphan index entries */
 		if (!err)
 			err = ovl_indexdir_cleanup(ofs);
 	}
 	if (err || !ofs->indexdir)
-		pr_warn("overlayfs: try deleting index dir or mounting with '-o index=off' to disable inodes index.\n");
+		pr_warn("try deleting index dir or mounting with '-o index=off' to disable inodes index.\n");
 
 out:
 	mnt_drop_write(mnt);
@@ -1297,7 +1298,7 @@ static int ovl_get_fsid(struct ovl_fs *ofs, const struct path *path)
 		if (ofs->config.index || ofs->config.nfs_export) {
 			ofs->config.index = false;
 			ofs->config.nfs_export = false;
-			pr_warn("overlayfs: %s uuid detected in lower fs '%pd2', falling back to index=off,nfs_export=off.\n",
+			pr_warn("%s uuid detected in lower fs '%pd2', falling back to index=off,nfs_export=off.\n",
 				uuid_is_null(&sb->s_uuid) ? "null" :
 							    "conflicting",
 				path->dentry);
@@ -1306,7 +1307,7 @@ static int ovl_get_fsid(struct ovl_fs *ofs, const struct path *path)
 
 	err = get_anon_bdev(&dev);
 	if (err) {
-		pr_err("overlayfs: failed to get anonymous bdev for lowerpath\n");
+		pr_err("failed to get anonymous bdev for lowerpath\n");
 		return err;
 	}
 
@@ -1357,7 +1358,7 @@ static int ovl_get_lower_layers(struct super_block *sb, struct ovl_fs *ofs,
 		mnt = clone_private_mount(&stack[i]);
 		err = PTR_ERR(mnt);
 		if (IS_ERR(mnt)) {
-			pr_err("overlayfs: failed to clone lowerpath\n");
+			pr_err("failed to clone lowerpath\n");
 			iput(trap);
 			goto out;
 		}
@@ -1401,7 +1402,7 @@ static int ovl_get_lower_layers(struct super_block *sb, struct ovl_fs *ofs,
 	}
 
 	if (ofs->xino_bits) {
-		pr_info("overlayfs: \"xino\" feature enabled using %d upper inode bits.\n",
+		pr_info("\"xino\" feature enabled using %d upper inode bits.\n",
 			ofs->xino_bits);
 	}
 
@@ -1428,15 +1429,15 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
 	err = -EINVAL;
 	stacklen = ovl_split_lowerdirs(lowertmp);
 	if (stacklen > OVL_MAX_STACK) {
-		pr_err("overlayfs: too many lower directories, limit is %d\n",
+		pr_err("too many lower directories, limit is %d\n",
 		       OVL_MAX_STACK);
 		goto out_err;
 	} else if (!ofs->config.upperdir && stacklen == 1) {
-		pr_err("overlayfs: at least 2 lowerdir are needed while upperdir nonexistent\n");
+		pr_err("at least 2 lowerdir are needed while upperdir nonexistent\n");
 		goto out_err;
 	} else if (!ofs->config.upperdir && ofs->config.nfs_export &&
 		   ofs->config.redirect_follow) {
-		pr_warn("overlayfs: NFS export requires \"redirect_dir=nofollow\" on non-upper mount, falling back to nfs_export=off.\n");
+		pr_warn("NFS export requires \"redirect_dir=nofollow\" on non-upper mount, falling back to nfs_export=off.\n");
 		ofs->config.nfs_export = false;
 	}
 
@@ -1459,7 +1460,7 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
 	err = -EINVAL;
 	sb->s_stack_depth++;
 	if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
-		pr_err("overlayfs: maximum fs stacking depth exceeded\n");
+		pr_err("maximum fs stacking depth exceeded\n");
 		goto out_err;
 	}
 
@@ -1515,7 +1516,7 @@ static int ovl_check_layer(struct super_block *sb, struct ovl_fs *ofs,
 	while (!err && parent != next) {
 		if (ovl_lookup_trap_inode(sb, parent)) {
 			err = -ELOOP;
-			pr_err("overlayfs: overlapping %s path\n", name);
+			pr_err("overlapping %s path\n", name);
 		} else if (ovl_is_inuse(parent)) {
 			err = ovl_report_in_use(ofs, name);
 		}
@@ -1595,7 +1596,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	err = -EINVAL;
 	if (!ofs->config.lowerdir) {
 		if (!silent)
-			pr_err("overlayfs: missing 'lowerdir'\n");
+			pr_err("missing 'lowerdir'\n");
 		goto out_err;
 	}
 
@@ -1610,7 +1611,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 
 	if (ofs->config.upperdir) {
 		if (!ofs->config.workdir) {
-			pr_err("overlayfs: missing 'workdir'\n");
+			pr_err("missing 'workdir'\n");
 			goto out_err;
 		}
 
@@ -1660,13 +1661,13 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	if (!ofs->indexdir) {
 		ofs->config.index = false;
 		if (ofs->upper_mnt && ofs->config.nfs_export) {
-			pr_warn("overlayfs: NFS export requires an index dir, falling back to nfs_export=off.\n");
+			pr_warn("NFS export requires an index dir, falling back to nfs_export=off.\n");
 			ofs->config.nfs_export = false;
 		}
 	}
 
 	if (ofs->config.metacopy && ofs->config.nfs_export) {
-		pr_warn("overlayfs: NFS export is not supported with metadata only copy up, falling back to nfs_export=off.\n");
+		pr_warn("NFS export is not supported with metadata only copy up, falling back to nfs_export=off.\n");
 		ofs->config.nfs_export = false;
 	}
 
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index f5678a3..cb4a5ea 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -576,7 +576,7 @@ int ovl_check_setxattr(struct dentry *dentry, struct dentry *upperdentry,
 	err = ovl_do_setxattr(upperdentry, name, value, size, 0);
 
 	if (err == -EOPNOTSUPP) {
-		pr_warn("overlayfs: cannot set %s xattr on upper\n", name);
+		pr_warn("cannot set %s xattr on upper\n", name);
 		ofs->noxattr = true;
 		return xerr;
 	}
@@ -700,7 +700,7 @@ static void ovl_cleanup_index(struct dentry *dentry)
 
 	inode = d_inode(upperdentry);
 	if (!S_ISDIR(inode->i_mode) && inode->i_nlink != 1) {
-		pr_warn_ratelimited("overlayfs: cleanup linked index (%pd2, ino=%lu, nlink=%u)\n",
+		pr_warn_ratelimited("cleanup linked index (%pd2, ino=%lu, nlink=%u)\n",
 				    upperdentry, inode->i_ino, inode->i_nlink);
 		/*
 		 * We either have a bug with persistent union nlink or a lower
@@ -739,7 +739,7 @@ static void ovl_cleanup_index(struct dentry *dentry)
 	return;
 
 fail:
-	pr_err("overlayfs: cleanup index of '%pd2' failed (%i)\n", dentry, err);
+	pr_err("cleanup index of '%pd2' failed (%i)\n", dentry, err);
 	goto out;
 }
 
@@ -830,7 +830,7 @@ int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *upperdir)
 err_unlock:
 	unlock_rename(workdir, upperdir);
 err:
-	pr_err("overlayfs: failed to lock workdir+upperdir\n");
+	pr_err("failed to lock workdir+upperdir\n");
 	return -EIO;
 }
 
@@ -852,7 +852,7 @@ int ovl_check_metacopy_xattr(struct dentry *dentry)
 
 	return 1;
 out:
-	pr_warn_ratelimited("overlayfs: failed to get metacopy (%i)\n", res);
+	pr_warn_ratelimited("failed to get metacopy (%i)\n", res);
 	return res;
 }
 
@@ -899,7 +899,7 @@ ssize_t ovl_getxattr(struct dentry *dentry, char *name, char **value,
 	return res;
 
 fail:
-	pr_warn_ratelimited("overlayfs: failed to get xattr %s: err=%zi)\n",
+	pr_warn_ratelimited("failed to get xattr %s: err=%zi)\n",
 			    name, res);
 	kfree(buf);
 	return res;
@@ -931,7 +931,7 @@ char *ovl_get_redirect_xattr(struct dentry *dentry, int padding)
 
 	return buf;
 invalid:
-	pr_warn_ratelimited("overlayfs: invalid redirect (%s)\n", buf);
+	pr_warn_ratelimited("invalid redirect (%s)\n", buf);
 	res = -EINVAL;
 	kfree(buf);
 	return ERR_PTR(res);
-- 
2.7.4

