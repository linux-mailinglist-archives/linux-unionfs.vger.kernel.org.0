Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B03114C5A
	for <lists+linux-unionfs@lfdr.de>; Fri,  6 Dec 2019 07:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfLFGds (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 6 Dec 2019 01:33:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34142 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfLFGdr (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 6 Dec 2019 01:33:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id f4so9012137wmj.1
        for <linux-unionfs@vger.kernel.org>; Thu, 05 Dec 2019 22:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WemESWTE/NmweCBVHfvOlsbnM44BUgX56VoY+3ISQ60=;
        b=NVs4fEu4n/hfAyNJPms8js4J2/WgjO7wctwriv6oPWzMwIQA/RJbjsqLUv66mQheRX
         mEFHYmXjhF9bFbGZUqf5nyboNVSfyBvzdE49OOGKwlhlUsE2jDSw9s1VLWWk7dyJ3sWB
         /8dDcuatRcx0mGvvBtF4Dl+1Ta0Y/pPJrwSskNOHxZC1qhxFhG3srokhgHlvXE0LRtT1
         5A6ubF5p9dKT9Rvzh2xE+35IzQZnvrvSHI3HLpSyuHI+it3D2krREzpSoR5eGFW9Gji6
         SiblETHP+gi6bztK5XDr1Ft6Yu7m1l0T5pDUr0NFMq4DNNT0ovo3e5Z7ScZ3XrjNMLoC
         XyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WemESWTE/NmweCBVHfvOlsbnM44BUgX56VoY+3ISQ60=;
        b=q9qu8hLUiVAOFFWLdf+n2eh0aQqyjkxWng/Zoeb/DH07Z9evzzAgzjxmX9lTttrTfQ
         SxDIA3LazgNtcaZLfGig5niYIq8PvXvWjetNsjYfYxuQWX9MxgYL+DrSiuaNrxtbUISp
         2tqP2yxLRSN3EG7tEH21q9rwg+xOT7JzULM0oVCnfrT+TZSRHjX8III69Glqs+24VCfw
         0JVikuCNc9qH8E/GGcYEufriFop1X0w8sPSWhSy/fn0S/9ZRRmraFE9tYRF1PAOd1aXT
         Re4v9ox+hPmb5ByCtqtPqBYgKUAe3feBpRHSBhT/6oMwu/FD8D9BG9q2AHC1+IDAhwbv
         Z0Vg==
X-Gm-Message-State: APjAAAXq/YHVXZ0CESdqAgfyWMrPcY+ZGVjRgaYr6+D/6fS5lA/21oyd
        wxRBbsXIpJuziw69aPGZzag=
X-Google-Smtp-Source: APXvYqwrm/sZOqjgY9rRri/3qNprf98I4RnzBUCwKuz6wSXfKfiqdVFFLFNNCZj7H3IBEXD1Uj2SsQ==
X-Received: by 2002:a05:600c:2549:: with SMTP id e9mr8950313wma.160.1575614025637;
        Thu, 05 Dec 2019 22:33:45 -0800 (PST)
Received: from localhost.localdomain ([141.226.162.223])
        by smtp.gmail.com with ESMTPSA id k4sm2461375wmk.26.2019.12.05.22.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 22:33:45 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: [PATCH] ovl: relax WARN_ON() on rename to self
Date:   Fri,  6 Dec 2019 08:33:36 +0200
Message-Id: <20191206063336.9722-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

In ovl_rename(), if new upper is hardlinked to old upper underneath
overlayfs before upper dirs are locked, user will get an ESTALE error
and a WARN_ON will be printed.

Changes to underlying layers while overlayfs is mounted may result in
unexpected behavior, but it shouldn't crash the kernel and it shouldn't
trigger WARN_ON() either, so relax this WARN_ON().

Reported-by: syzbot+bb1836a212e69f8e201a@syzkaller.appspotmail.com
Fixes: 804032fabb3b ("ovl: don't check rename to self")
Cc: <stable@vger.kernel.org> # v4.9+
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 702aa63f6774..29abdb1d3b5c 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1170,7 +1170,7 @@ static int ovl_rename(struct inode *olddir, struct dentry *old,
 	if (newdentry == trap)
 		goto out_dput;
 
-	if (WARN_ON(olddentry->d_inode == newdentry->d_inode))
+	if (olddentry->d_inode == newdentry->d_inode)
 		goto out_dput;
 
 	err = 0;
-- 
2.17.1

