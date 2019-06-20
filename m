Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 615424DAF8
	for <lists+linux-unionfs@lfdr.de>; Thu, 20 Jun 2019 22:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfFTUMX (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 20 Jun 2019 16:12:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40359 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfFTUMX (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 20 Jun 2019 16:12:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so4288551wre.7
        for <linux-unionfs@vger.kernel.org>; Thu, 20 Jun 2019 13:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VdcQzV8hHMC+GRuwgzaDFOvFEcR/ZhcEtfsV1R6kHb8=;
        b=hGo7GNsl0HiAU1hbh21l1NCenJJkZ1nlyY5fyr0zbW26fbKOnDMzm57KcF5Xx3/Wnr
         ndluRH2IUzg5PONnj47mHCMA20HqhjLS+UVbGHhvarFPRGZ5FALySChqq1c7uxMeRDUl
         qsLXnFmUuxQc26hSXmwn/EPVDucDzwMuM6vVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VdcQzV8hHMC+GRuwgzaDFOvFEcR/ZhcEtfsV1R6kHb8=;
        b=PZCOE1qCkahlrkNMw0xDZQ0uz66LiUltj/Hwe7MARB6AEMQUfJtLasCBYQJiQuJu5S
         yFJBpbUa89JtN5Ldnyp+ED9Z2o5QUbjD8LVgfTl7FcGFViFieFGqaxJksh/XCmy6AudS
         lmttm19o9eSJRrQzSD2z/YZaLUkPTm50UOWuxKdgsET6g0Y2tTGjmgjT83waxlemt1CF
         wp1ybmCjloD+n6DCE192fD0T0mnjNYwZ5hs2Ff8rJFzb7CHnheE5Ivs1jWT/IvGA5y1Y
         F9/b3ppnQNhe4JZsaLrcir3f4ryKWOfg4wjp5QaAvQDToqm/VeaKAVucCknHVwe3rCs4
         nB3w==
X-Gm-Message-State: APjAAAWz+IR+VDMuXNVCdw46VAMA2gpWcxDn9Mh3bIw2PbZy4QRDFNBB
        ZhYSPMwj2YOcSwNw7squbyV2oA==
X-Google-Smtp-Source: APXvYqzXUHs9wonUOK9Hkbxxy7TRb1JC73kE59bmEu6hG9Wd4C7L5ywUm3wDVFja7kReKiD4gkaRZw==
X-Received: by 2002:a05:6000:c9:: with SMTP id q9mr27260078wrx.208.1561061541415;
        Thu, 20 Jun 2019 13:12:21 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id f204sm836104wme.18.2019.06.20.13.12.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 13:12:20 -0700 (PDT)
Date:   Thu, 20 Jun 2019 22:12:18 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 5.2-rc6
Message-ID: <20190620201218.GB10138@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.2-rc6

Fix two regressions in this cycle, and a couple of older bugs.

Thanks,
Miklos

----------------------------------------------------------------
Amir Goldstein (2):
      ovl: fix wrong flags check in FS_IOC_FS[SG]ETXATTR ioctls
      ovl: make i_ino consistent with st_ino in more cases

Arnd Bergmann (1):
      ovl: fix bogus -Wmaybe-unitialized warning

Miklos Szeredi (1):
      ovl: don't fail with disconnected lower NFS

Nicolas Schier (1):
      ovl: fix typo in MODULE_PARM_DESC

---
 fs/overlayfs/copy_up.c |  2 +-
 fs/overlayfs/dir.c     |  2 +-
 fs/overlayfs/file.c    | 91 +++++++++++++++++++++++++++++++++++---------------
 fs/overlayfs/inode.c   | 12 +++----
 fs/overlayfs/super.c   | 42 ++++++++++-------------
 5 files changed, 90 insertions(+), 59 deletions(-)
