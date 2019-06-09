Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9113A6B9
	for <lists+linux-unionfs@lfdr.de>; Sun,  9 Jun 2019 18:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbfFIQDx (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 9 Jun 2019 12:03:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54903 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbfFIQDx (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 9 Jun 2019 12:03:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id g135so6270786wme.4
        for <linux-unionfs@vger.kernel.org>; Sun, 09 Jun 2019 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DQAqhd6yW8/oZ54nlbb6TgMDCHKIsaX596//5UCpuGc=;
        b=Nc5Lo1xXQIXfmWPOxA9bJpGnfQeqTAR61GY9G6TdpkCTE1yKg5EGXUZyEu+aDbawjp
         mM4jVZ72z+vjO9pYjAlSDEC/j7dGvsRVyL14IICXsEVE8m4MfPVFzhKleG948yMijl6t
         I6m/ZCtqvLplQwl7Nuy+0o+ZJ92sCv3ZuAPRfUYH8te0uDNoSP4ohovQnu68mYP37KSo
         4KE3lRxkwqtNbdrSKV0EATwqzOjP6YHYjV4zpuS5ju/ysbZaEdgbhuAX/vT41DQhyuA8
         fA0FHngWjsOuGRNidY6e2zAaYkmip1mISad9qTGzhelwSbPm9140i+SoPvGUYKLVbixF
         QOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DQAqhd6yW8/oZ54nlbb6TgMDCHKIsaX596//5UCpuGc=;
        b=A+j5XNalidT0STZFJApRpnS9ah+4Zove7vwY4l7fQKhKKj86veNFVUJnEWsIpOWVmX
         GaNqKqWNWlvjDq/MW+WHLjsWx8U9EYS40WTJBL54LEX+HIn9dSClAk+/pWgWjiRjHD4D
         pEp9jbYJSBaWk1qfHWofuQYLUBKMkmJu+mcpb9YJcG2PgqFvU+QKoWnd8CTIc+ZiGVhx
         Pl5zyKo69kWtaj6Zmk1HgtMhVjZbbazaIlDTzMd9WMgvctuMfgOSyyeY22A5ezZf1KbI
         BpQrddXWxS/PSUUOJPNxcrxSjv0XbcTMUVeCFu0Mu//0k6klRknbpLuhT50BvK29fxPY
         Pvdg==
X-Gm-Message-State: APjAAAWtcZFUtOXgInnpP/uGB7X58eCPoEBWIXW/cmAGoJ2CkdNmX33H
        J8UDk4Q7Ic7wdDfnDT6awq4=
X-Google-Smtp-Source: APXvYqwvx6Gv2cWnP6IpazH/Nx2a9BW4DBolmiLIp7E1h/mCPI2VRkFG1efiINjUMqj6hRisOh48vw==
X-Received: by 2002:a1c:b604:: with SMTP id g4mr10882899wmf.111.1560096230988;
        Sun, 09 Jun 2019 09:03:50 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id j189sm3276549wmb.48.2019.06.09.09.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 09:03:49 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org
Subject: [PATCH] ovl: make i_ino consistent with st_ino in more cases
Date:   Sun,  9 Jun 2019 19:03:44 +0300
Message-Id: <20190609160344.24979-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Relax the condition that overlayfs supports nfs export, to require
that i_ino is consistent with st_ino/d_ino.

It is enough to require that st_ino and d_ino are consistent.

This fixes the failure of xfstest generic/504, due to mismatch of
st_ino to inode number in the output of /proc/locks.

Fixes: 12574a9f4c9c ("ovl: consistent i_ino for non-samefs with xino")
Cc: <stable@vger.kernel.org> # v4.19
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Miklos,

TBH, I can't remember why I put the s_export_op condition in the
first place (can you?), expect for the fact the original bug fix
was reported on nfsd readdirplus.

Thanks,
Amir.

 fs/overlayfs/inode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index f7eba21effa5..f0389849fd80 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -553,15 +553,15 @@ static void ovl_fill_inode(struct inode *inode, umode_t mode, dev_t rdev,
 	int xinobits = ovl_xino_bits(inode->i_sb);
 
 	/*
-	 * When NFS export is enabled and d_ino is consistent with st_ino
-	 * (samefs or i_ino has enough bits to encode layer), set the same
-	 * value used for d_ino to i_ino, because nfsd readdirplus compares
-	 * d_ino values to i_ino values of child entries. When called from
+	 * When d_ino is consistent with st_ino (samefs or i_ino has enough
+	 * bits to encode layer), set the same value used for st_ino to i_ino,
+	 * so inode number exposed via /proc/locks and a like will be
+	 * consistent with d_ino and st_ino values. An i_ino value inconsistent
+	 * with d_ino also causes nfsd readdirplus to fail.  When called from
 	 * ovl_new_inode(), ino arg is 0, so i_ino will be updated to real
 	 * upper inode i_ino on ovl_inode_init() or ovl_inode_update().
 	 */
-	if (inode->i_sb->s_export_op &&
-	    (ovl_same_sb(inode->i_sb) || xinobits)) {
+	if (ovl_same_sb(inode->i_sb) || xinobits) {
 		inode->i_ino = ino;
 		if (xinobits && fsid && !(ino >> (64 - xinobits)))
 			inode->i_ino |= (unsigned long)fsid << (64 - xinobits);
-- 
2.17.1

