Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51389108B79
	for <lists+linux-unionfs@lfdr.de>; Mon, 25 Nov 2019 11:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKYKQf (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 25 Nov 2019 05:16:35 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:45653 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfKYKQf (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 25 Nov 2019 05:16:35 -0500
Received: by mail-wr1-f52.google.com with SMTP id z10so17147252wrs.12;
        Mon, 25 Nov 2019 02:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YIaQiojiC3tAhRMu5v0SZYWP1SEx29Gw/+8o/0nCSZg=;
        b=ooA9TSdOYFNQOzgv7fGxyFhJYyDPznKLQX8rgAlTRK3KIyFSPo+ychi//9Ym1vI4zQ
         W71L31y1WMxFDQnd6m97GwuF7c7HAHccL8GvuBe2WNcJQmS/K4uaDQFqTRgn0fzXBPb/
         aNc6jEvj2hl5XybHgWpqOk+uvNkjtvOVvd1A79sH0V0j/ceggjOMlEfT+r/LAk9pgDM+
         KXR6O9oe/F8L8leIbCYvzaDDjkYJyMPCDTfpgrwkgfySvA3Oc/BEMK3NPLaHnTTN76WE
         BX6BYq0GdfKx10hH5jndnJ0Gi7ghukY0S9/IhFmSzqJUNEhWQy7kgQRwR44hN6b/fZ5v
         Lsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YIaQiojiC3tAhRMu5v0SZYWP1SEx29Gw/+8o/0nCSZg=;
        b=RFOF2sJWeA5437tchd82oaO1S6M6D2/Vgvv6/s1y0Nk8Vu9kkUcNJqR0ypZ9s9Luw+
         gxZDuvwpSWWtU7CUT96jQiXRCs7rQAul3GYvQVkaEHB/WrE8vpzuHNmygTeQhsLjiN2p
         ymIAd7uSGcTSoT3ep//mYumK0+lyazPEsPSmAV0P+yJaALkz0XOHQr6IzBLI0X2zAfQI
         XBUPJ91iQ1r0kPCBEnc2qAHSl6yUh+lV5qPMzae9DGB/MxntYt5NEXYd5l+5hvDG1wf9
         Vr43q/vD2u4Lg+co4WH84eGAdoFcsppAsnIe+G7nfx6BenB2/Bfax5BSUy9zi/BN5dkV
         IThA==
X-Gm-Message-State: APjAAAWQDMsqyLBDGnptqwcvx5mGKMQJLt8iPs25MCwBJ5wZKOywRHcl
        amk0iuH5GPGnfuXrWxkgaGsUu8wa
X-Google-Smtp-Source: APXvYqxr8KtdULUnM7SwhaE66DKuynjjjOfpn3Q4SwpXvJC4EdbhmjrkDA5myQeTwNOhIiyt+K7gDQ==
X-Received: by 2002:a05:6000:160d:: with SMTP id u13mr10006037wrb.209.1574676992966;
        Mon, 25 Nov 2019 02:16:32 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id d18sm10580471wrm.85.2019.11.25.02.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 02:16:32 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-doc@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [PATCH] docs: filesystems: overlayfs: Rename overlayfs.txt to .rst
Date:   Mon, 25 Nov 2019 12:16:26 +0200
Message-Id: <20191125101626.32722-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

It is already formatted as RST.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi John,

Not sure if this doc is up to standards, but it is already displayed
fairly well on github as .rst.

If you want me to make more changes to bring it into compliance, before
the rename please let me know what needs to be done.
Is there a script to check doc compliance?

Otherwise, you can just take this rename patch and leave it to other
devlopers to clean it up.

Thanks,
Amir.

 Documentation/filesystems/{overlayfs.txt => overlayfs.rst} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/filesystems/{overlayfs.txt => overlayfs.rst} (100%)

diff --git a/Documentation/filesystems/overlayfs.txt b/Documentation/filesystems/overlayfs.rst
similarity index 100%
rename from Documentation/filesystems/overlayfs.txt
rename to Documentation/filesystems/overlayfs.rst
-- 
2.17.1

