Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9ED25B06DB
	for <lists+linux-unionfs@lfdr.de>; Wed,  7 Sep 2022 16:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIGOdC (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 7 Sep 2022 10:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiIGOcN (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 7 Sep 2022 10:32:13 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E290AFAF8
        for <linux-unionfs@vger.kernel.org>; Wed,  7 Sep 2022 07:32:11 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id z21so9964843edi.1
        for <linux-unionfs@vger.kernel.org>; Wed, 07 Sep 2022 07:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=UTPjlhWN0j/3cl0uibj9IdU3K9tIHCNTd74bAPWV+BQ=;
        b=F9yMmaIgSJ7x+iStBVtJEVNXfuHmNuRwH0oeGQZVEKjdO6DhdtNMd/isOm61Mbr/sg
         xfKr3XSywaIr4UtWLvFYPLTvFzJ7h/Hm2dTXLAIBAXs8GSUGrRcaGfrF44kItgvLNssI
         mdCrrU6xo0k06TKggYMVy8FOcAbkBgo1wC5PjqDsVEhsblNCO7wJZs+Uz3UyfKMq66jc
         LBZlB+02LZPjcLDn2rXew+EJosOoyYb0qI+DEdM9Q7gGpQpAuWFiAiGu2xaPJNPE8Z0z
         1dPz+Ukvd+R1N2c6VsiSc8mvEG74skD4zo8WmW09cr/Ve033R6BY3xgueFtUzfnE1WmC
         UQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UTPjlhWN0j/3cl0uibj9IdU3K9tIHCNTd74bAPWV+BQ=;
        b=4rsrV6TaBgkWiiH3dvqJxFXmKihcH/EFZfU5wcibu/lyG62RSm5mPzPqCA5B2FtBQV
         YO3+auFKHZ8OdxvFeei/m0yLFTBjCxwtaWMJfBLrYOWlgSPcny6UFTPAkhOURD9AONju
         wD/SS09YYadt0WqUMx+GpzkWzVpbedpOob3aUlx8ovenWUr+DMakDjQDSvoBxFYXZLyH
         DwN1wJrTw2hAeIfAgIv33hKv21fE4IR9IkgWkVi/VrVzy7Aqm3QV3e4Vg/mJAcdjm768
         puc3Nqlg/9+FzUIiIVLjOlzdmKvjZBeooZ7zqVCW+M2tgvYg3vMOx3iMJhnG3NrzddFy
         Izyg==
X-Gm-Message-State: ACgBeo2NxgvUcEjKUSzDACpCV4WQbLnUTimLxHwP4W4yi019paNPD/aQ
        20Jup5U2+AS1fNgkwLbrvL2Dg5PyCIB9+Qv6eXc=
X-Google-Smtp-Source: AA6agR4uPOOUp+ayJg7njU0xYMAyBPmGFYJGRdL33Bi7R249qZwUmqVQ08qkjiR05GuTGJWJL9HGuiFQ37xnsFlHbf4=
X-Received: by 2002:aa7:db8b:0:b0:44e:5ce1:f29a with SMTP id
 u11-20020aa7db8b000000b0044e5ce1f29amr3424831edt.109.1662561128989; Wed, 07
 Sep 2022 07:32:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:3fc4:0:0:0:0:0 with HTTP; Wed, 7 Sep 2022 07:32:07 -0700 (PDT)
Reply-To: lumar.casey@outlook.com
From:   LUMAR CASEY <miriankushrat@gmail.com>
Date:   Wed, 7 Sep 2022 16:32:07 +0200
Message-ID: <CAO4StN3iFKypeHLByNWR98VPw-8s6UHDJYgBRpLm-4kdPR=60w@mail.gmail.com>
Subject: ATTENTION/PROPOSAL
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.8 required=5.0 tests=ADVANCE_FEE_4_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY,UPPERCASE_75_100 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:541 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [miriankushrat[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 UPPERCASE_75_100 message body is 75-100% uppercase
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 ADVANCE_FEE_4_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

ATTENTION

BUSINESS PARTNER,

I AM LUMAR CASEY WORKING WITH AN INSURANCE FINANCIAL INSTITUTE, WITH
MY POSITION AND PRIVILEGES I WAS ABLE TO SOURCE OUT AN OVER DUE
PAYMENT OF 12.8 MILLION POUNDS THAT IS NOW SECURED WITH A SHIPPING
DIPLOMATIC OUTLET.

I AM SEEKING YOUR PARTNERSHIP TO RECEIVE THIS CONSIGNMENT AS AS MY
PARTNER TO INVEST THIS FUND INTO A PROSPEROUS INVESTMENT VENTURE IN
YOUR COUNTRY.

I AWAIT YOUR REPLY TO ENABLE US PROCEED WITH THIS BUSINESS PARTNERSHIP TOGETHER.

REGARDS,

LUMAR CASEY
