Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04062484B8
	for <lists+linux-unionfs@lfdr.de>; Mon, 17 Jun 2019 15:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfFQN6v (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 17 Jun 2019 09:58:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53413 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFQN6v (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 17 Jun 2019 09:58:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so9405492wmj.3;
        Mon, 17 Jun 2019 06:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LXMcVfGduW54PXBtMvhHr1AmqEkWJ/apYKsh/cp+L+E=;
        b=nxV1v/7VX0EO10FfCy7NXKeYGS8Rgv87ylYDXltBZxRSSWLioGQeAXdZQY/tvUiHDe
         9QrxiUW9z1fb7yJSGN8xOsqJTiBquqzgHqmwBnc0CQ7xCXoNGZGelzYrMvhPtWVH1HXU
         K+pbL6+zzZ+h83at9CsrtPGfZ0D9C4PtfsY+LvZ4XgdNrNpqFqQ4vm4mjVLTdnfDFBXC
         uYTmk1Xmn0KqdJiMioNgo6RDQGFBFpZrBb8/zjdeTBMsi6lD2tCfEeT9ni8lDF0/wX0K
         bc152WrIU1jnrW6I8ZqJGfuDuzqd+GYORc9aPlbvkbs5jTNNtLQIJjPbzboNU0G1MWIK
         AYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LXMcVfGduW54PXBtMvhHr1AmqEkWJ/apYKsh/cp+L+E=;
        b=UlQsP7lKpnxERMKK5lPeS34ER8cSsEDafvZtMz9/yC8Ae764YWiLQ8hZONZ9Ukcm9F
         5oB6IjoClOKzh2PJgqHCgM8cFRbTPtdN0F8EraGxfoMiX7dKUcEwJkA6Dqctcgwoh6iZ
         /yxK/DQyaI3SvglYSpnmmfUOHO1eDKAgKKeB+EXeyigT+eqyqlev0+/YpkutbLEgKFQU
         OWQhlP+K1I3GYWf+7A/dlkmiT5j7x9kcQIXENIULeIo36MMY3mysdRZL1Zfnk7wuyhYd
         kFxuHWQtxsgrnji3tlCaoihCbLlJqvJxw7piMNpQ72YzuVXD0QWF7DFzczlOIr7qXHEL
         2DRQ==
X-Gm-Message-State: APjAAAUVLstlZu77TUoABiF4El5bKPnHFQy0OqLu2OWRuHUXtG2+SnRg
        ctXd/+dcrVC8YDRKCFMxvUc=
X-Google-Smtp-Source: APXvYqyqm2n0pjwzyl9+VEe7Clkgrlqb0QsTtHkUrRFsCZ3auFcjmVJK/rkjFzbo8nnHrrnKJ3z99g==
X-Received: by 2002:a1c:4054:: with SMTP id n81mr19414273wma.78.1560779929359;
        Mon, 17 Jun 2019 06:58:49 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id v67sm15512710wme.24.2019.06.17.06.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 06:58:48 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] overlay: fix _scratch_remount with xfs_info 5.0.0
Date:   Mon, 17 Jun 2019 16:58:43 +0300
Message-Id: <20190617135843.12659-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

xfs_info version 5.0.0 started using findmnt to find the
filesystem to query. This change resulted in a regression
of _scratch_remount when testing overlay over xfs.
For example, test overlay/035, started to report:
[not run] overlay/035 -- upper fs needs to support d_type

Internally, '_overlay_scratch_mount -o remount' calls
'_supports_filetype $OVL_BASE_SCRATCH_MNT -o remount'
and with the following example mounts:

/dev/vdf /vdf xfs rw,relatime,attr2,inode64,noquota 0 0
/vdf /vdf/ovl-mnt overlay rw,lowerdir=/vdf/lower,upperdir=/vdf/upper...

'_supports_filetype /vdf' returns false and reports:
"/vdf/ovl-mnt: Not on a mounted XFS filesystem".

Regardless of the change in xfs_info, which I proposed a fix
for, there is no reason to test d_type support on remount.
Therefore, fix the regression by skipping unneeded overlayfs
mount logic on remount.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Eryu,

I think this fix is desired regardless of the proposed
xfs_info fix [1].

Thanks,
Amir.

[1] https://marc.info/?l=linux-xfs&m=156077152313826&w=2

 common/overlay | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/overlay b/common/overlay
index 00946a94..65c639e9 100644
--- a/common/overlay
+++ b/common/overlay
@@ -105,6 +105,11 @@ _overlay_base_scratch_mount()
 
 _overlay_scratch_mount()
 {
+	if echo "$*" | grep -q remount; then
+		$MOUNT_PROG $SCRATCH_MNT $*
+		return
+	fi
+
 	_overlay_base_scratch_mount && \
 		_overlay_mount $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT $*
 }
-- 
2.17.1

