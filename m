Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB4A3B498C
	for <lists+linux-unionfs@lfdr.de>; Tue, 17 Sep 2019 10:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfIQIbp (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 17 Sep 2019 04:31:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50613 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfIQIbp (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 17 Sep 2019 04:31:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id 5so2228907wmg.0
        for <linux-unionfs@vger.kernel.org>; Tue, 17 Sep 2019 01:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Yvd80cqDC7g7H/3EGDdUC4+VFqTvhuXauCbBSXd4cKQ=;
        b=m9rM+oJUxhFcRzvtzjy/b03fyK0MatUXoMTP9FtAwjLXnD6dShihpi6S/onI1oOhV/
         Mx2RNhcstTmfbx+3xLB7tBwCGyi+TN360USzfuG9fWN/aiBGOMhXaUge5vW6rWYoIwsw
         RyoYVbM7aUjqBKmBi9RIMcf4EpOi2yHlMhMpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Yvd80cqDC7g7H/3EGDdUC4+VFqTvhuXauCbBSXd4cKQ=;
        b=MziVU6JKubtmIouDn++oo6SeDUP1K0V9yLaeBWF/PLwdchgDEuEY09vOFp/WDS+e6a
         Jz8F+nE6isu545FJx2y413/NlsHW9SapV3Gudfx+a+Lgu7vmpsyxlRv2WnPGuf6gV9ng
         2L2M/SEu+Gb+2Kqt7VFJsuKfEijWvaKyghDaCd/caALvfq7plzJE54BCGkKdmgim6oVh
         o3qysxTu/JbYwfS5qkrRJ9MQDoxzcSIX2Nr9PsoHnrRTFpIt9RitNuG0VKzpRKQQNxgN
         W2Q+YVelt4IWwmz2EPHo6uga1UvnLbdNP02jP+RvislYhh/Xns7ecvIgj4nv1Gkz/3th
         3Fxw==
X-Gm-Message-State: APjAAAXlEd/qd/pYB/YE4kHlvCxe2+loUbLZs9e2QcYy//eUIAcqXRgl
        zAI3F8Jb1gK2HLRuJQP28CKoxA==
X-Google-Smtp-Source: APXvYqxhY4IauqcE6+bMW3Vzuz9urpQh9TOpjOry2a1gYoCQgrUeWJVIoSvMOTh1Myigya4XWNS7LA==
X-Received: by 2002:a1c:f916:: with SMTP id x22mr2499436wmh.69.1568709103043;
        Tue, 17 Sep 2019 01:31:43 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id e20sm2405568wrc.34.2019.09.17.01.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 01:31:42 -0700 (PDT)
Date:   Tue, 17 Sep 2019 10:31:35 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 5.3
Message-ID: <20190917083135.GA19549@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.3

Fix a regression in docker introduced by overlayfs changes in 4.19.  Also
fix a couple of miscellaneous bugs.

Thanks,
Miklos

----------------------------------------------------------------
Amir Goldstein (1):
      ovl: fix regression caused by overlapping layers detection

Ding Xiang (1):
      ovl: Fix dereferencing possible ERR_PTR()

Mark Salyzyn (1):
      ovl: filter of trusted xattr results in audit

---
 Documentation/filesystems/overlayfs.txt |  2 +-
 fs/overlayfs/export.c                   |  3 +-
 fs/overlayfs/inode.c                    |  3 +-
 fs/overlayfs/ovl_entry.h                |  1 +
 fs/overlayfs/super.c                    | 73 +++++++++++++++++++++------------
 5 files changed, 52 insertions(+), 30 deletions(-)
