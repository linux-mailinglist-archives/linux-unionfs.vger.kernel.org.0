Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEC13825E
	for <lists+linux-unionfs@lfdr.de>; Fri,  7 Jun 2019 03:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfFGBFN (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 6 Jun 2019 21:05:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46491 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGBFN (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 6 Jun 2019 21:05:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id 81so161517pfy.13
        for <linux-unionfs@vger.kernel.org>; Thu, 06 Jun 2019 18:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mNFOl2XvtWscGomaGXIFHgSNidIIHAYcSKhWSOmPlSs=;
        b=pR/SRCwOTIUpKzjaMxLFYk/JG+uUIfW2+XuOgpEeE4lS2sAEaRK3o7s5xGXMxEQBEo
         MF1Z1DKEfgFW3nooZbFTgKvJL6xQqqIErfKG2VlU/StQeF7CuCCioZ4x1ehA7TtxCjcN
         yT2CF9wvAxX9kG8pTy8IH/1Md6BnnSG8OJ/eN0KJkVMSngEgr/JLRhI5MD1I9W0vpF7W
         4KD1RkTOcZy4AWvFZW2AinbHoE/3AvS0t/MRNDPNsPW3B7HvgWXMXu6LTtuMfhuJeFtD
         iwFDMTTfQBEgoas3XqlRQzcvgGQHdxx38ViWb5huPHqvEoHz1lea97Zke0zjfnzpcEPq
         olHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mNFOl2XvtWscGomaGXIFHgSNidIIHAYcSKhWSOmPlSs=;
        b=mreElhfNcPjnWwlIEeDDgLDss4X5zkaz/t2UETXqngYDbgAIWwbcFaV/df+noIiQHS
         6RXa7YNzQZ64gVa6O/Knmq6FNpeu0WVMFw6X5efSNWBaqZnSBBN5aJwpibDwARGArngr
         F5wArGxJqdFQTmihUihiFaaGJzdWFDf9dVIHVoRjHM5ALf5NuZjyJXQPKbFX639msAwz
         vCxQ/mYSGhdb8IlP0/LXRMxqSybHVrzQXx0SaIfnswMrHv8yBb6eKe6E7Fq26a6uXR4+
         mcyzhdjlcIyxEk7fjNqXGTVmJGD8SQiYJEvOcDri4Cpia+Wih8nAHCXaLhAYrg2uhUV7
         WKNw==
X-Gm-Message-State: APjAAAWj1d5+XlFqFvyyO17jhNFsgmzprkLEv9YlbeaZ84Iey174os4d
        098rPy+XvvBb+SKmJargowxQn6CO
X-Google-Smtp-Source: APXvYqwhjg6fLBWrHUTRbcwmUaYSmw/lCBmnqvV+EoLRLxQu1XtOedk6jpjJ1HtupOExn/YBor1QUg==
X-Received: by 2002:a17:90a:5d09:: with SMTP id s9mr2649407pji.120.1559869512521;
        Thu, 06 Jun 2019 18:05:12 -0700 (PDT)
Received: from mcoffin-qw.localdomain ([64.124.233.100])
        by smtp.gmail.com with ESMTPSA id j2sm347485pfb.157.2019.06.06.18.05.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 18:05:11 -0700 (PDT)
From:   Matt Coffin <mcoffin13@gmail.com>
To:     linux-unionfs@vger.kernel.org
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Matt Coffin <mcoffin13@gmail.com>
Subject: [PATCH] overlay: allow config override of metacopy/redirect defaults
Date:   Thu,  6 Jun 2019 19:04:31 -0600
Message-Id: <20190607010431.11868-1-mcoffin13@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

[Why]
Currently, if the redirect_dir option is set as a kernel or module
parameter, then even if metacopy is only enabled config, then both
metacopy and redirect_dir will be enabled when one creates a mount
point. This is not desirable because /sys/module/overlay/parameters will
still report that redirect_dir is not enabled, and there will be no
redirect_dir=on line in the mount options in /proc/mounts. The behavior
of setting redirect_dir globally for overlay is likely a common pattern
on docker workstations, as redirect_dir makes for slower building of
docker images.

[How]
This patch adds similar logic to that already in place for parsing mount
parameters. If the user explicitly sets redirect_dir via a kernel or
module parameter, then metacopy will become disabled, unless it was also
specified that way. Obviously, mount options still take precedence over
this process, so this logic only kicks in when neither redirect_dir or
metacopy were specified in the mount options.

[Related]
This undesirable logic was introduced by the commit that introduced the
mount option handling logic: d47748e5ae5af6572e520cc9767bbe70c22ea498
---
 fs/overlayfs/super.c | 48 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 0116735cc321..456d48f57700 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -30,10 +30,16 @@ struct ovl_dir_cache;
 #define OVL_MAX_STACK 500
 
 static bool ovl_redirect_dir_def = IS_ENABLED(CONFIG_OVERLAY_FS_REDIRECT_DIR);
-module_param_named(redirect_dir, ovl_redirect_dir_def, bool, 0644);
-MODULE_PARM_DESC(ovl_redirect_dir_def,
+static bool ovl_redirect_dir_param = IS_ENABLED(CONFIG_OVERLAY_FS_REDIRECT_DIR);
+module_param_named(redirect_dir, ovl_redirect_dir_param, bool, 0644);
+MODULE_PARM_DESC(ovl_redirect_dir_param,
 		 "Default to on or off for the redirect_dir feature");
 
+static inline bool ovl_redirect_dir_module_overrides_kernel(void)
+{
+	return (ovl_redirect_dir_def != ovl_redirect_dir_param);
+}
+
 static bool ovl_redirect_always_follow =
 	IS_ENABLED(CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW);
 module_param_named(redirect_always_follow, ovl_redirect_always_follow,
@@ -65,10 +71,16 @@ static void ovl_entry_stack_free(struct ovl_entry *oe)
 }
 
 static bool ovl_metacopy_def = IS_ENABLED(CONFIG_OVERLAY_FS_METACOPY);
-module_param_named(metacopy, ovl_metacopy_def, bool, 0644);
-MODULE_PARM_DESC(ovl_metacopy_def,
+static bool ovl_metacopy_param = IS_ENABLED(CONFIG_OVERLAY_FS_METACOPY);
+module_param_named(metacopy, ovl_metacopy_param, bool, 0644);
+MODULE_PARM_DESC(ovl_metacopy_param,
 		 "Default to on or off for the metadata only copy up feature");
 
+static inline bool ovl_metacopy_module_overrides_kernel(void)
+{
+	return (ovl_metacopy_def != ovl_metacopy_param);
+}
+
 static void ovl_dentry_release(struct dentry *dentry)
 {
 	struct ovl_entry *oe = dentry->d_fsdata;
@@ -312,7 +324,7 @@ static bool ovl_force_readonly(struct ovl_fs *ofs)
 
 static const char *ovl_redirect_mode_def(void)
 {
-	return ovl_redirect_dir_def ? "on" : "off";
+	return ovl_redirect_dir_param ? "on" : "off";
 }
 
 enum {
@@ -359,7 +371,7 @@ static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 						"on" : "off");
 	if (ofs->config.xino != ovl_xino_def())
 		seq_printf(m, ",xino=%s", ovl_xino_str[ofs->config.xino]);
-	if (ofs->config.metacopy != ovl_metacopy_def)
+	if (ofs->config.metacopy != ovl_metacopy_param)
 		seq_printf(m, ",metacopy=%s",
 			   ofs->config.metacopy ? "on" : "off");
 	return 0;
@@ -457,6 +469,7 @@ static int ovl_parse_redirect_mode(struct ovl_config *config, const char *mode)
 	} else if (strcmp(mode, "follow") == 0) {
 		config->redirect_follow = true;
 	} else if (strcmp(mode, "off") == 0) {
+		config->redirect_dir = false;
 		if (ovl_redirect_always_follow)
 			config->redirect_follow = true;
 	} else if (strcmp(mode, "nofollow") != 0) {
@@ -473,6 +486,8 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 	char *p;
 	int err;
 	bool metacopy_opt = false, redirect_opt = false;
+	bool metacopy_override = ovl_metacopy_module_overrides_kernel();
+	bool redirect_override = ovl_redirect_dir_module_overrides_kernel();
 
 	config->redirect_mode = kstrdup(ovl_redirect_mode_def(), GFP_KERNEL);
 	if (!config->redirect_mode)
@@ -598,8 +613,23 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 				config->redirect_mode);
 			config->metacopy = false;
 		} else {
-			/* Automatically enable redirect otherwise. */
-			config->redirect_follow = config->redirect_dir = true;
+			if (metacopy_override && redirect_override) {
+				pr_err("overlayfs: conflicting module params: metacopy=on,redirect_dir=%s\n",
+					config->redirect_mode);
+				return -EINVAL;
+			}
+			if (redirect_override) {
+				/*
+				 * There was an explicit redirect_dir=... that resulted
+				 * in this conflict (module param)
+				 */
+				pr_info("overlayfs: disabling metacopy due to module param redirect_dir=%s\n",
+					config->redirect_mode);
+				config->metacopy = false;
+			} else {
+				/* Automatically enable redirect otherwise. */
+				config->redirect_follow = config->redirect_dir = true;
+			}
 		}
 	}
 
@@ -1439,7 +1469,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	ofs->config.index = ovl_index_def;
 	ofs->config.nfs_export = ovl_nfs_export_def;
 	ofs->config.xino = ovl_xino_def();
-	ofs->config.metacopy = ovl_metacopy_def;
+	ofs->config.metacopy = ovl_metacopy_param;
 	err = ovl_parse_opt((char *) data, &ofs->config);
 	if (err)
 		goto out_err;
-- 
2.21.0

