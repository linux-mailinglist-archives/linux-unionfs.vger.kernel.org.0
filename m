Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6DB1A4382
	for <lists+linux-unionfs@lfdr.de>; Fri, 10 Apr 2020 10:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgDJIZt (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 10 Apr 2020 04:25:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52991 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgDJIZt (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 10 Apr 2020 04:25:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id t203so1743668wmt.2
        for <linux-unionfs@vger.kernel.org>; Fri, 10 Apr 2020 01:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xqcSPxD8oSDDetR+Hf3G3uv9flvQS4ZYlqGjqwfekMU=;
        b=WQ6JS8Y0udfciuLR7nQ/yQwqvClReMbdQujde0fxEncgb3oo86KBWycyfzzK9bJlEl
         hMP/kHehwj8yuYoXmmW+iraO8k3hvBx12d88lyVcfbT32P8vBgQnUcDxSuqhGx06F6nH
         UjYBKpKFbH/WHj5XF+QO0kQCqqcd2DQxI7qPV7sOOlVDpja58ce4Yf77zce/tdBDrvWM
         W2LwhReeNSlih9vgHVf/ts4tz1RVkKcxa5iplXyDLw3ju33QEn7lrsBX7Aa9bu7Cb6v+
         8iVvrfR4qR/bGuznDxu4aeua7RSMYjUO7IsWYRD4NOH6PBq2oB/Zv8sbSnZa0iRilgJH
         g3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xqcSPxD8oSDDetR+Hf3G3uv9flvQS4ZYlqGjqwfekMU=;
        b=qIGuqCcsbhH9YxB8NAFMSuQaekEXevuJzKhrf5nu3ZDNGUQobPPqLrO/6Xw6MBGt/M
         hjeFVkxMkRtdST2AGneBCBgeoZ1E45gMiMvH8VYY+fcQXWS3WN72PYgZ48GRiMVcaafQ
         tqdHAQ4QHfWb7BmvHrwPFttQgzjFjJYyiAhnlQpXk9P6Z+dodAc3gacP6LUcEUWbCe4o
         SHyLnv2vsKjclsmbP9gtXmAjN6CLt7d9Kb9NQju7IgKcMq9ABJhvtYOnBqJ/GLyBIZiv
         zysn6OhosWCeML3/U51dLBMTzOJjrT4eZ96t8aAAG+3QyTFGdU0guky3yAVJL+t8UYOn
         MAvg==
X-Gm-Message-State: AGi0PuY7qIcvKhaqM3JwllaoDb9rCPGQ2Nm2MWhZfpjpAep8b0j8I5sy
        2rlxqnAgcVN+QGjDBsJx8k2FELsq
X-Google-Smtp-Source: APiQypKED1CAaAPU9P+GHU+bBZ+hUTthCKLOXIhC0X1cNeWE/+WJ7Lo1Wo0vMfKDZiT8jDB0id+Hgw==
X-Received: by 2002:a1c:bd54:: with SMTP id n81mr3872364wmf.141.1586507146072;
        Fri, 10 Apr 2020 01:25:46 -0700 (PDT)
Received: from localhost.localdomain ([141.226.12.123])
        by smtp.gmail.com with ESMTPSA id b7sm1710327wrn.67.2020.04.10.01.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 01:25:45 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org
Subject: [PATCH 0/3] Overlayfs use index dir as work dir
Date:   Fri, 10 Apr 2020 11:25:36 +0300
Message-Id: <20200410082539.23627-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Miklos,

I know its a bit early in the cycle for patches, but those are
needed for the whiteout sharing patch by Chengguang Xu and they are
quite trivial, so I figured I'll just post them early to see if there
are any comments.

Thanks,
Amir.

Amir Goldstein (3):
  ovl: cleanup non-empty directories in ovl_indexdir_cleanup()
  ovl: prepare to copy up without workdir
  ovl: index dir act as work dir

 fs/overlayfs/copy_up.c   |  8 ++++++--
 fs/overlayfs/overlayfs.h |  4 ++--
 fs/overlayfs/readdir.c   | 13 +++++++------
 fs/overlayfs/super.c     | 14 +++++++++-----
 4 files changed, 24 insertions(+), 15 deletions(-)

-- 
2.17.1

