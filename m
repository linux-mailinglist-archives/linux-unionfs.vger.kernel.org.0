Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F647EF390
	for <lists+linux-unionfs@lfdr.de>; Fri, 17 Nov 2023 14:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjKQNN1 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 17 Nov 2023 08:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjKQNN0 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 17 Nov 2023 08:13:26 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F28126;
        Fri, 17 Nov 2023 05:13:23 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c50906f941so27552291fa.2;
        Fri, 17 Nov 2023 05:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700226801; x=1700831601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4f1MVztdhj5IN7r1ek1X1T1ZJLkJj98esTqsJzAdItM=;
        b=U09qKu1g0F9c30+h2lrgo0iSFQJjh2GH57p7sU69GIAyPadeJZcLAEKYcaNrXVUKl2
         S0X50tQ5Y84GU3pSL8pqCXjL/hGZgajXo4u3vnGOO2j/DlZMu/A8zDpmV80NfoWimsNT
         qL9iXtsaz3SvUBXFL/Cule9RdwebK+o5k5YOTfDkXP2eyzr74AcBhx4ntYJvUBG9GbNr
         Z7R0CeoT1TySillTmPY45a0eb62MPs5TNQNqNJVo1CrQYe5CXSMVsKeKq9qZQeglTdmP
         YROZP0MvXkKXq2u1bB6zVJXjtUfSK4E3hDHC27XwanbrUJHlf8h3APGemWCTphA1IYSN
         yi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700226801; x=1700831601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4f1MVztdhj5IN7r1ek1X1T1ZJLkJj98esTqsJzAdItM=;
        b=M2RJY2L6OcTehXIHa9/J0zPn4gcMcS+CxKwD4IfUI2QCGoXr4eqUYTRegZyWW5xBiX
         mrb2qlHEha5YokMPXlYPgvBFLO/xpHzZQpPbncoDvNQg4o80qKHg9TDU3Aq1l6ROw57k
         4wuuARvoAMwHcLCX9yJzSzkk28OH+2+ZXVkf4si7Ptyd1p8ks3yZJCj7A7pKV8UvObHo
         AwxRdyoI5/iXQyi+87bAPG0VVQEQXA4ddBreZd4T3WaLAhj4Q2hTC9/xhLI5wOuOeRQF
         q1oqT0Pxz4A9fsskvOp/YCv3EVbue+rRMBdcJkJjLi0RrVmrR3ISg0D/3zyZB1mJbq3t
         GkZA==
X-Gm-Message-State: AOJu0Yxg8F2dMn4P9Tzj6FywfxynlP09nOeDU4PpWEtregOVHdkcO1At
        IFwo3n/17UNmvuggkOKwY1KNOuVz0pM=
X-Google-Smtp-Source: AGHT+IHxlGCKLzcATW6yFBuFwEWtMrDHD+iYV1a11WAGkDxnDimYKmIB4j0vw+z/p1NZ8ccFLvlIiw==
X-Received: by 2002:a2e:2e06:0:b0:2bc:d634:2210 with SMTP id u6-20020a2e2e06000000b002bcd6342210mr8264608lju.16.1700226801041;
        Fri, 17 Nov 2023 05:13:21 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id z17-20020a1c4c11000000b0040a44179a88sm6889598wmf.42.2023.11.17.05.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 05:13:20 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 6.7-rc2
Date:   Fri, 17 Nov 2023 15:13:15 +0200
Message-Id: <20231117131315.1927413-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi Linus,

Please pull a fix to overlayfs param parsing bug from v6.7-rc1.

This branch has been sitting in linux-next for a few days and
it has gone through the usual overlayfs test routines.

The branch merges cleanly with master branch of the moment.

Thanks,
Amir.

----------------------------------------------------------------
The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.7-rc2

for you to fetch changes up to 37f32f52643869131ec01bb69bdf9f404f6109fb:

  ovl: fix memory leak in ovl_parse_param() (2023-11-14 08:09:36 +0200)

----------------------------------------------------------------
overlayfs fixes for 6.7-rc2

----------------------------------------------------------------
Amir Goldstein (2):
      ovl: fix misformatted comment
      ovl: fix memory leak in ovl_parse_param()

 fs/overlayfs/params.c | 11 +++++------
 fs/overlayfs/util.c   |  2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)
