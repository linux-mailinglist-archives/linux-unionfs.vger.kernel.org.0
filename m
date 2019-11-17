Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7603CFFA8C
	for <lists+linux-unionfs@lfdr.de>; Sun, 17 Nov 2019 16:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfKQPoC (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 17 Nov 2019 10:44:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33294 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfKQPoB (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 17 Nov 2019 10:44:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id w9so16573265wrr.0
        for <linux-unionfs@vger.kernel.org>; Sun, 17 Nov 2019 07:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tH6Xf4bkcff4I7pwfcsKj+dYrwZ3vnkBKxXSR9mPLWU=;
        b=BCXd4tQgOh9iXMOH33kvETi3QyZ/PQADhhjUUUrx/NLiIjUmUtpSaHNwjopkUswjR7
         O23C9taGTgAzgnnYWyp+LhFqCCOFfcPY3dfgK3GJXR4GqIeyzL4ASvvbOHcsx1Re9Gs+
         v1p62DB0iy+6F3ChVPqRjHpo6OVwOjr3IIqZyjQVmKuKbHv6HT1BYZJGd9jiCOfGMwbX
         oNiXRe6BT6YRiuZN3bKTCEIBhC/S1EuQ8vVzRNmdMIRZYGpoxyad9EECm0TJ7Zgb13Ts
         Fmy+dz4/OPksmZliGU/9ilo1tBSoyj2UB4SD6opK8ywyvyvsPXA9K9qpUT7OLuwtxSQD
         vCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tH6Xf4bkcff4I7pwfcsKj+dYrwZ3vnkBKxXSR9mPLWU=;
        b=tKgX2BZxlEmrcjFVjez/i48L7QInM6qRIcGrIY+/OlF0LBlO8x1wgunAjXWKHLNneB
         kfk3PKz8UNmNcsI6AH06r7JIcecVA1iCCoDijSTm0NaQxJOfcxJPDXX7b7lO5sXctsZY
         y6J3HDi0nyX9yGEtXOW/z2L18QDtu5WWIUcYWkzPKhG21Ooo1dqlIwaqEBYsAQxl0QbX
         tDJOlIp/FHjnwLPdKoQssiseKtJoDi6iV/NKIMq1k/NGwa3Vw5pwhnRBHXO+isUN4O/R
         qn5WZRkD/REaUmOlW40YYYnQSPx9Ktsu3tRMt8yqmxe7R9cvvJaFZ3+ZquZTeUqzrlQW
         RVLA==
X-Gm-Message-State: APjAAAUz0M05/v/nkI96O9NacylfoobOrDbPNgR+lqM6zZjdab3nBhEs
        dLxGgyRMe9s7m8MdNalMED0=
X-Google-Smtp-Source: APXvYqzhg42nJ4BH/6WhR1jJ2m4La2kUnsyJ5p3sN4Dtd9XhQxyQbW/uzSnrQ0Yy6HlxUCS8j/PPmA==
X-Received: by 2002:adf:ce05:: with SMTP id p5mr8060744wrn.48.1574005439642;
        Sun, 17 Nov 2019 07:43:59 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id z8sm19061613wrp.49.2019.11.17.07.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 07:43:59 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Colin Ian King <colin.king@canonical.com>,
        linux-unionfs@vger.kernel.org
Subject: [PATCH 1/6] ovl: fix corner case of non-unique st_dev;st_ino
Date:   Sun, 17 Nov 2019 17:43:44 +0200
Message-Id: <20191117154349.28695-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191117154349.28695-1-amir73il@gmail.com>
References: <20191117154349.28695-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On non-samefs overlay without xino, non pure upper inodes should use a
pseudo_dev assigned to each unique lower fs and pure upper inodes use
the real upper st_dev.

It is fine for an overlay pure upper inode to use the same st_dev;st_ino
values as the real upper inode, because the content of those two
different filesystem objects is always the same.

In this case, however:
- two filesystems, A and B
- upper layer is on A
- lower layer 1 is also on A
- lower layer 2 is on B

Non pure upper overlay inode, whose origin is in layer 1 will have the
same st_dev;st_ino values as the real lower inode. This may result with
a false positive results of 'diff' between the real lower and copied up
overlay inode.

Fix this by using the upper st_dev;st_ino values in this case.
This breaks the property of constant st_dev;st_ino across copy up
of this case. This breakage will be fixed by a later patch.

Fixes: 5148626b806a ("ovl: allocate anon bdev per unique lower fs")
Cc: stable@vger.kernel.org # v4.17+
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/inode.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index bc14781886bf..b045cf1826fc 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -200,8 +200,14 @@ int ovl_getattr(const struct path *path, struct kstat *stat,
 			if (ovl_test_flag(OVL_INDEX, d_inode(dentry)) ||
 			    (!ovl_verify_lower(dentry->d_sb) &&
 			     (is_dir || lowerstat.nlink == 1))) {
-				stat->ino = lowerstat.ino;
 				lower_layer = ovl_layer_lower(dentry);
+				/*
+				 * Cannot use origin st_dev;st_ino because
+				 * origin inode content may differ from overlay
+				 * inode content.
+				 */
+				if (samefs || lower_layer->fsid)
+					stat->ino = lowerstat.ino;
 			}
 
 			/*
-- 
2.17.1

