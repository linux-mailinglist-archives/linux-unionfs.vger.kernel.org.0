Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D90C33A13E
	for <lists+linux-unionfs@lfdr.de>; Sat,  8 Jun 2019 20:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfFHSf7 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sat, 8 Jun 2019 14:35:59 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34636 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfFHSf6 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sat, 8 Jun 2019 14:35:58 -0400
Received: by mail-it1-f194.google.com with SMTP id c3so3896631itc.1
        for <linux-unionfs@vger.kernel.org>; Sat, 08 Jun 2019 11:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vwNbbXo4+LAGlsRrwD+tzK96bnNiKUdOE7NsCSx1yes=;
        b=hsBZsFTapUxr9xP6Gi4fpIK8maoxwbXX+EVubEK2IQpf3QLHcnSQ/Jc3CVecTJhrSY
         1TQb9zDaJaUCOzexVZsqKUQKh5x/+h5Oqi86umL+J9Tim48+R3RtzAkR3OPLUQUE1bYR
         g/vYo/YyDM/z0g7WwmXxBqhPNukQR29GcpkQnMv3SRv9rHc4uddjJ+kegPrbe+FrfwOB
         JkHEbpWSe2/J54ULeo1fY11zKZ9TDmZcRlMIo7GnIcoxKb2M3RZexMydXDg7kxiN/roz
         8t9LTw106hWjl7JT2UJIv3fKrOG1AT0GlP0faizW6erwLF+XkDKIGgx/3jqgCWO1BuSI
         LeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vwNbbXo4+LAGlsRrwD+tzK96bnNiKUdOE7NsCSx1yes=;
        b=ASZoZYIZ/rz6IRcmIbzfUz6s1ZlGQtpi3poDBz6SMAzrJBDtwmsYK5xVU4tcF2tN8N
         7eA6P6IJEdyi+VP4Ox7jAsxOZC2mbDtc38JQn3PpcHZyPSCNJOSUZ+53M0/ywXEBsKMN
         ybsIGLTm3ALVWwJklL4CxdrZ0P4NjXBGD1cg5PAWpqVNobmGQBswRPH+vbirPkC28wKT
         pA5Uuz8MfvgQ/1ptiVrWVMwJoyIMTzUXICsNZnckHJCi8vr+BT6zKx+Ewd735yw8aiEO
         J+OhXdKpIo8LU5s4CjLgQolzjFUSCTGB6aZh2IUrjrxYYNKkoU/jMbBLNBS3p/nPQLDq
         yNJg==
X-Gm-Message-State: APjAAAWVUm/H+7tY/bAL+VMhYi10qBseQO+s8+D/atUYRxn9vbRK/Go1
        lGa5G6i/hS6/l0Jq+hwmQMZ558OXjkuyLg==
X-Google-Smtp-Source: APXvYqzMEJlBkY4Nt1lgGG+Ek5HAke7Ca5zHs8obe46MXQpn7wRVbfKK5yHasdBISfXe27uKK//6qA==
X-Received: by 2002:a02:950a:: with SMTP id y10mr41527633jah.26.1560018957875;
        Sat, 08 Jun 2019 11:35:57 -0700 (PDT)
Received: from localhost.localdomain ([2602:47:da8f:c200:f24d:a2ff:fedd:b812])
        by smtp.gmail.com with ESMTPSA id d3sm62225itg.9.2019.06.08.11.35.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 11:35:57 -0700 (PDT)
From:   Matt Coffin <mcoffin13@gmail.com>
To:     linux-unionfs@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matt Coffin <mcoffin13@gmail.com>
Subject: [PATCH] overlay: Display redirect_dir mount option when it is set automatically
Date:   Sat,  8 Jun 2019 12:35:34 -0600
Message-Id: <20190608183534.2963-1-mcoffin13@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

[Why]
Currently, if metacopy is enabled via a module param/kernel config, then
the setting for redirect_dir is overriden, unless passed as a mount
option specifically. Despite this overriding, the redirect_dir option is
not printed when displaying the mount options (see /proc/mounts), so it
is hard for a user to know that it has happened.

[How]
A bit of code that does the overriding based on the mount options was
setting redirect_dir, but not updating the redirect_mode string. By
adding that update, the information is now printed (and the config
struct has the correct information in all places).
---
 fs/overlayfs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 5ec4fc2f5d7e..46fab4660bfe 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -598,6 +598,9 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 			config->metacopy = false;
 		} else {
 			/* Automatically enable redirect otherwise. */
+			pr_info("overlayfs: enabling redirect_dir due to implicit metacopy=%d\n",
+				config->metacopy);
+			config->redirect_mode = "on";
 			config->redirect_follow = config->redirect_dir = true;
 		}
 	}
-- 
2.21.0

