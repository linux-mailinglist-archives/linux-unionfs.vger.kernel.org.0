Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E137064BE33
	for <lists+linux-unionfs@lfdr.de>; Tue, 13 Dec 2022 22:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbiLMVGm (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 13 Dec 2022 16:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236719AbiLMVGT (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 13 Dec 2022 16:06:19 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7838321E16
        for <linux-unionfs@vger.kernel.org>; Tue, 13 Dec 2022 13:06:17 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id e1so452286qka.6
        for <linux-unionfs@vger.kernel.org>; Tue, 13 Dec 2022 13:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pGENH+jbzoJT1RmKoVt6qI6z9upLI95OLIGVFgRFmmw=;
        b=TF6U++llSwp4JNXMtXTkcDvc/5ShJCpSpzeIJmQHoWcCR3hocyh/J51E63JhgkfBR9
         q9h53Aaguu9NTzyVFs0/FNISY1sqGv+QBgnf42r14HrC+Eubj9mqJX/69XPToND99vx2
         5BkChMAVOF3y/kF5G4P6GBibVWzLjCLL/R7hamWWps3gw02JIx9RXfb8FSkucimk3cr6
         ajkiMoYSUNmt2qtBbukKXKvqBEs8NfcR1ft5m40SA/2u8BkPZIoyVnTlWvM8y+6b5jew
         nVPpELQ8r4XcrC/GMUKtncWbIdX2SGLhiDLDuidrxAB6X6mX7CFJfAK1o+BeLLdOxVI5
         qyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pGENH+jbzoJT1RmKoVt6qI6z9upLI95OLIGVFgRFmmw=;
        b=UX7CpUa6BYAKs3kpBq5t2a21ppPXreO9u8u0A5dtekIlPMTBjpJCmoMBCPoAqoE3wG
         oG0itJY+0C4EBcNB1ZVqrj7GFHESiI/WkbY78eab2apQf9+mNcDiFpfV3Dc1ReqTEgQW
         2azFspoUvbw/zsJecm1L3gOyP6aYrMPm7qfphIbW5QgrTgZ9gPAQOpyujnMRf4j+Cc7h
         HumpL/HdcWkP/B5q1RwE+nkfOJQEFi3IteX13YAgwo6jjCIOAfr4GMA4fX/iS4KuaHzF
         MGUkaexBk0LQVyBIsIsk37FFqnUoQ/FR3QCf7A+A66xruv7cPGYOyZXRKsjAwRe54DIV
         TGKA==
X-Gm-Message-State: ANoB5plwCtqx9SDHwrK7QwF8uQjhEY8J7PqER74MQnizCKr7PFvbQoZD
        jhB0tRb+s8tP+5+/l86lf1tUEkTeo8Yv2qS+lVE=
X-Google-Smtp-Source: AA0mqf7sCcngAhFN/qSTCbDklApRDjtnr97gE4w1dNAoZFmQ+b4Iwf0vo6JtGKV77pLyOpabkxSh09jnNoTCEAUN0so=
X-Received: by 2002:ae9:c302:0:b0:6fc:9e90:8c9a with SMTP id
 n2-20020ae9c302000000b006fc9e908c9amr30423351qkg.249.1670965576587; Tue, 13
 Dec 2022 13:06:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:622a:1a0b:b0:3a7:e2d9:5b0e with HTTP; Tue, 13 Dec 2022
 13:06:16 -0800 (PST)
From:   johnson50 mike <jm2175940@gmail.com>
Date:   Tue, 13 Dec 2022 13:06:16 -0800
Message-ID: <CAPotKQOPWTPumQ6=CGNwFC+U+xoy5EkE4KEs6H6H0Jf_mrmvHA@mail.gmail.com>
Subject: waiting transfer
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:732 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6300]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jm2175940[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jm2175940[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Valued Attention Sir!
Our recent record   indicates that you are eligible to receive an
optional repayment of cash fund!! $750,000.00 which has been found in
the security vault registered in your favor under your email account
waiting to be dispatch without claims.
the account is set up under your email address  can only be obtained
by you (receiver),all  you have to do is to provide
Your full Name.....................
Direct Telephone: ..............
And delivery address........... For immediate shipment
Thanks and anticipating your urgent respond
finaccial@citromail.hu
Yours faithfully,
Johnson Mike
Section assistance and   Verification committee
USAfro-Euro   Debit Reconciliation Office
ID 4475 UK London
