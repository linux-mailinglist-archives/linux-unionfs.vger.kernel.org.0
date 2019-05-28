Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69ADC2CA29
	for <lists+linux-unionfs@lfdr.de>; Tue, 28 May 2019 17:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfE1PRd (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 28 May 2019 11:17:33 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:54518 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfE1PRc (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 28 May 2019 11:17:32 -0400
Received: by mail-wm1-f52.google.com with SMTP id i3so3391664wml.4;
        Tue, 28 May 2019 08:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RYcsB7RfPQUTrwm4dZ7EPC8arPNg7MNEuTC82QFz4mk=;
        b=M/X2Ab8iHTQ5pa7wH0Mi0AnRl9gTBfqL0lspSEnQ8MwXgyMwBwIkA2u9jmazm2YtrL
         m6EpkpE6on50RUqMZQJGO77SzPvgaLMt9pueP9CemNm+k9rRPDl5orBMYgTUjYPoVfTP
         ixMrC+GtwH1Dng3s7oR1rT0GDZmkqvPAAvl8fPzGfPDnXrweMuudFiwHrhkihnZUYUuL
         WtFWHShy13f4VSl2CrL7HSqaw4INMseJsx7eiBzHZu3GD3qxQIrmCc2Ww9TRbxDnbcIH
         /A8FzFrvzcK2K1WrObMeI6c8jit4EcdtL1GDci3POmQAlZ+KLl4ISYhSOOri2XRRYAuT
         sKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RYcsB7RfPQUTrwm4dZ7EPC8arPNg7MNEuTC82QFz4mk=;
        b=N9TyCCdLOV/Fu7S4v6z0vaoxKNYXwFyg9QL7oynFsIIdTOI+8xdjwlkiqAWGnHFhvV
         hk9xIkE+xBJk1nBRMQavonPp3D/FRrFHNw6Or43+qweY/eyHGy7c0wDIYeGMqBFtA8ai
         67UBB1dv7J7s8MSWukaEFYQvZw7bdr1fqfqccg1/LH8/LDjXs1U4MpfrXITOHFE9HxEk
         feRxqVd2sSnXXHmMv0hEQ6/v4obJ62es0LOIvQNz1b5hyo+SAKqDMwDtF2ySpLy5WFef
         NHqKPl0bvd8g7GFRV4FEnPkU+VkVw22x2exccUx7ZAMCvupiPkR10OK9fcGaReh3rzuE
         qMpQ==
X-Gm-Message-State: APjAAAVebJeO/ods6WGUTtF6g+KEXmikekkUIiWR/h3La+0c+cFf6AU/
        QY9WwszuY4amdxV6814G08bpULPA
X-Google-Smtp-Source: APXvYqwtlFAMUl4R1Bhxq3zGI7h3BYJrVnHLNcGa14VpZ6SD8fzHl17rQ6+ktZnSP/6j/2L+sHcxtQ==
X-Received: by 2002:a1c:7511:: with SMTP id o17mr3549818wmc.39.1559056650416;
        Tue, 28 May 2019 08:17:30 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id z65sm5017010wme.37.2019.05.28.08.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 08:17:29 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     zhangyi <yi.zhang@huawei.com>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH v3 0/4] Misc. fsck.overlay test fixes
Date:   Tue, 28 May 2019 18:17:19 +0300
Message-Id: <20190528151723.12525-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Eryu,

This is a re-post for zhangyi's fsck.overlay test fixes from
October [1]. Based on my own code review of those patches, I have
made some minor modifications and added some more fixes.

I have been carrying the two patches by zhangyi in my dev branch
for a while. Without them running overlay tests with fsck.overlay
installed is failing some tests.

Zhangyi,

Please review my changes, some based on your suggestions.
Feel free to re-post "fsck.overlay stress test" and
"fsck.overlay exception tests". My goal with this posting
was just to fix failures of existing tests when fsck.overlay
is installed.

Thanks,
Amir.

Changes from v2:
- Dropped patches of new tests
- Move fsck exit code constants to common/config
- Fix _repair_scratch_fs

[1] https://marc.info/?l=fstests&m=153967515805435&w=2

Amir Goldstein (2):
  fstests: define constants for fsck exit codes
  overlay: fix _repair_scratch_fs

zhangyi (F) (2):
  overlay: correct fsck.overlay exit code
  overlay: fix exit code for some fsck.overlay valid cases

 common/config     | 11 +++++++++++
 common/overlay    | 36 ++++++++++++++++++++++++++++++++++
 common/rc         | 15 ++++++++++++---
 tests/overlay/045 | 46 ++++++++++++++++++++++++--------------------
 tests/overlay/046 | 49 ++++++++++++++++++++++++-----------------------
 tests/overlay/056 |  9 +++------
 6 files changed, 112 insertions(+), 54 deletions(-)

-- 
2.17.1

