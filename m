Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552EB67E967
	for <lists+linux-unionfs@lfdr.de>; Fri, 27 Jan 2023 16:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjA0P0g (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 27 Jan 2023 10:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbjA0P0f (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 27 Jan 2023 10:26:35 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8277C331
        for <linux-unionfs@vger.kernel.org>; Fri, 27 Jan 2023 07:26:32 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id v6so14667455ejg.6
        for <linux-unionfs@vger.kernel.org>; Fri, 27 Jan 2023 07:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9lCm2tMGNVKG6SWJp8e+YHP+g7R9bSQ20DL1jjRz9r0=;
        b=bbjGC6z9OVURgKt9VG4FKQztxD1j00SaCwSLpdaFsCfe20fjvGBgYkKNYV6QnSvb5U
         mmMjeNscAdpiKrqEuEotSNiPB7c7sAExKvVpYBbUuZZUmZsfwtNVtXVqXNbDj4fvNjmY
         MdG+81V/FPZXqhHnAP8sdtMbLPIsHS1gd4WuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9lCm2tMGNVKG6SWJp8e+YHP+g7R9bSQ20DL1jjRz9r0=;
        b=nZVlBEWjB/VJyFBkPJwsPNuXncRWQ5CRxNok6oLfe8pjYPa7eAuAp9FULPmS1cRx2m
         styZnpoOiTNm6RAoAjUR6cR0m6nMvmB/iAE3FNU3oOkTzGMSge2AKwgzwd1EtjqtcE/B
         v3oZVz9Llp1UQUCC2jRG54OhfcCewsWh13rRqALYwXiDjVJR/LqPz+YJgi7b5NglCAQt
         RB7pgClaMMXLbwdob1eWsNrvp3NVuWTEAaq9DEv3a8GJjzbbKzD8rc2V6PbwxhSbptDE
         R0FfrWkCbU5SRbzdkFGZRdum9HML3tGOchSoUIQ8urJphRe3ecAfZ1eEBsudS08u2DNl
         xdjQ==
X-Gm-Message-State: AFqh2kp3AYkviQcittdIwB37VFr0tSwI/r4X7Q+Px2Ric5xkmUWae7Md
        Nl8rGQyNsmD4k5bOBXMOHJJO5wW5F8h7aF8AcXyzlA==
X-Google-Smtp-Source: AMrXdXsTaQwz9TAD4rVJPOzzyithzlpBYYsLgWwxH4XVWPutH94i7xmf530C53weISltIhZ9TNtMoQ7rNydz0nbu+IE=
X-Received: by 2002:a17:906:2e94:b0:84d:ac8:ec37 with SMTP id
 o20-20020a1709062e9400b0084d0ac8ec37mr6058289eji.138.1674833190571; Fri, 27
 Jan 2023 07:26:30 -0800 (PST)
MIME-Version: 1.0
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 27 Jan 2023 16:26:19 +0100
Message-ID: <CAJfpeguv6BpewqDjDLqQv2yaR+nPLmmAp++JWNquWpXt7eiepQ@mail.gmail.com>
Subject: [GIT PULL] overlayfs fixes for 6.2-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
tags/ovl-fixes-6.2-rc6

Fix two bugs, a recent one introduced in the last cycle, and an older
one from v5.11.

Thanks,
Miklos

---
Miklos Szeredi (2):
      ovl: fix tmpfile leak
      ovl: fail on invalid uid/gid mapping at copy up

---
 fs/overlayfs/copy_up.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
