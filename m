Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA6F3970F
	for <lists+linux-unionfs@lfdr.de>; Fri,  7 Jun 2019 22:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfFGUvP (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 7 Jun 2019 16:51:15 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:33194 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729891AbfFGUvO (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 7 Jun 2019 16:51:14 -0400
Received: by mail-it1-f193.google.com with SMTP id v193so5413963itc.0
        for <linux-unionfs@vger.kernel.org>; Fri, 07 Jun 2019 13:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2CwCEFOmyvhnKGb58cWpZqD/xADUBRbWvczUkr6VhlQ=;
        b=LzsROlqi3bx2HJv+galFfoko0rceb2uyLkzOIsDaJw6KgCQ85hmkhXmzaGSsvZOT19
         9yVCAgQ1TfoXl0fMKWcYntDlf2QDB/rvI1x9LqBKN8CzIE9BcYoqAKDNFwWw4p91cs5L
         cpJqQ5cb307AXmZ9fIytp5j7BdUM8/znIEzm8KtuqlDzI6O/7tzxfh7CRPvHh7iUdfkv
         Y9DNp7oRnZErka1T4MNhL+C5jfAnAAaaFuzKsu24S00auznz1jr8SgiUgJEmDJl+qYAP
         rsVDAMQof/xz8vJWG40dP2BGaXhTZBQYQQI9f0ZCO1rxzfheJg+CNlFBbnSrUk0kfX+I
         BkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2CwCEFOmyvhnKGb58cWpZqD/xADUBRbWvczUkr6VhlQ=;
        b=fn8bV7nbMZowAL8DhFxzQRY2Gva5biqDH1U7qmegzEV6sbsjo3dztfRewNglJRxQgI
         gAcQ10nvsR+gfa2n1VOfFNHpAGjWM5wDRvSp92qvE/7wZDVMftldJ6BJpqFOm3owDVnX
         XE7Aejj/ouNU4+3rbctdLnfzr6yJdsSsIRMFVJBRofmzuPUiTmJvxb0vfDWcI60NqqXi
         Pdg+9aiYPwFz7NI2AM7X/L5yhyTZBEo3kI0I+QEWUtWwq/+XP2qrqXh3d6NrIqxmGqAp
         DpaTK9+O+CkUOQqzPrrZur0elEqAcm4cf5YRf5AYDzhOpgyo28jGEMYc9RTeigRcdr3B
         qwhQ==
X-Gm-Message-State: APjAAAVhGMXNLWHbY0G4v6LGKb9TRTpCmhfYUg4tTLeD2pWviklw915A
        B/PHRwkdhf7rzqJ6BAa49OE70BQo3lCT/g==
X-Google-Smtp-Source: APXvYqy9afc7LTC/ih4um3dPKL08mwFNpSqFzqAvpJrqIX9dh51c722oyVP5TZyz+GSqMcq/Jknwsw==
X-Received: by 2002:a24:7454:: with SMTP id o81mr5803461itc.162.1559940673330;
        Fri, 07 Jun 2019 13:51:13 -0700 (PDT)
Received: from localhost.localdomain ([2602:47:da8f:c200:f24d:a2ff:fedd:b812])
        by smtp.gmail.com with ESMTPSA id 203sm1480945ite.4.2019.06.07.13.51.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 13:51:12 -0700 (PDT)
From:   Matt Coffin <mcoffin13@gmail.com>
To:     linux-unionfs@vger.kernel.org
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Matt Coffin <mcoffin13@gmail.com>
Subject: [PATCH v2] overlay: allow config override of metacopy/redirect defaults
Date:   Fri,  7 Jun 2019 14:51:05 -0600
Message-Id: <20190607205105.21858-1-mcoffin13@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607010431.11868-1-mcoffin13@gmail.com>
References: <20190607010431.11868-1-mcoffin13@gmail.com>
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

[v2]
Clean up some formatting on lines that were too long
---
 fs/overlayfs/super.c | 49 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 5ec4fc2f5d7e..bd1a1329aa70 100644
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
@@ -310,7 +322,7 @@ static bool ovl_force_readonly(struct ovl_fs *ofs)
 
 static const char *ovl_redirect_mode_def(void)
 {
-	return ovl_redirect_dir_def ? "on" : "off";
+	return ovl_redirect_dir_param ? "on" : "off";
 }
 
 enum {
@@ -357,7 +369,7 @@ static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 						"on" : "off");
 	if (ofs->config.xino != ovl_xino_def())
 		seq_printf(m, ",xino=%s", ovl_xino_str[ofs->config.xino]);
-	if (ofs->config.metacopy != ovl_metacopy_def)
+	if (ofs->config.metacopy != ovl_metacopy_param)
 		seq_printf(m, ",metacopy=%s",
 			   ofs->config.metacopy ? "on" : "off");
 	return 0;
@@ -456,6 +468,7 @@ static int ovl_parse_redirect_mode(struct ovl_config *config, const char *mode)
 	} else if (strcmp(mode, "follow") == 0) {
 		config->redirect_follow = true;
 	} else if (strcmp(mode, "off") == 0) {
+		config->redirect_dir = false;
 		if (ovl_redirect_always_follow)
 			config->redirect_follow = true;
 	} else if (strcmp(mode, "nofollow") != 0) {
@@ -472,6 +485,8 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 	char *p;
 	int err;
 	bool metacopy_opt = false, redirect_opt = false;
+	bool metacopy_override = ovl_metacopy_module_overrides_kernel();
+	bool redirect_override = ovl_redirect_dir_module_overrides_kernel();
 
 	config->redirect_mode = kstrdup(ovl_redirect_mode_def(), GFP_KERNEL);
 	if (!config->redirect_mode)
@@ -597,8 +612,24 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
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
+				 * There was an explicit redirect_dir=...
+				 * that resulted in this conflict (module param)
+				 */
+				pr_info("overlayfs: disabling metacopy due to module param redirect_dir=%s\n",
+					config->redirect_mode);
+				config->metacopy = false;
+			} else {
+				/* Automatically enable redirect otherwise. */
+				config->redirect_follow =
+					config->redirect_dir = true;
+			}
 		}
 	}
 
@@ -1438,7 +1469,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
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

