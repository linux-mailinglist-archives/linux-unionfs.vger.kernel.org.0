Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AB2620E9D
	for <lists+linux-unionfs@lfdr.de>; Tue,  8 Nov 2022 12:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiKHLVC (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 8 Nov 2022 06:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiKHLU6 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 8 Nov 2022 06:20:58 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEDA2FC07
        for <linux-unionfs@vger.kernel.org>; Tue,  8 Nov 2022 03:20:56 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3704852322fso130536157b3.8
        for <linux-unionfs@vger.kernel.org>; Tue, 08 Nov 2022 03:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jD/YBCtOhOa1ipEyheDVa6geA3XolzkSqDbroMLmTEw=;
        b=GeOdQLywkqInDLMSCGIYr1HATLEXYswtxpWi2VoG03Vh2ZRDwjGwGkpHK/ryskFU35
         F//bzT9U++KCAV9dFAdFj8UxPLvWy9vIVTN6dVcBIdjfywKMqczsVYbodgHzeYHmiQZK
         teGJCKqeDB/LgbSQmerzAC1d8gvT+Jczw5UzcWJyIsW9tvlYMdgXF66CF0bxd2ZyUQbl
         jsS8oidWbXO3S/vRkFzZQ7/lxZO2osqYcz8D1RjleGKXcZAcibsGErhoezcSPOGdcUTl
         +dMicqaVDDUlhzuley5Tw3lmmWlzwHfhvpBt7cnrJ0a07ABCbr8IFS8QChbyup9Z97lN
         6NxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jD/YBCtOhOa1ipEyheDVa6geA3XolzkSqDbroMLmTEw=;
        b=mc8iRKO5WjHffbfXWgTkkme7W8wyEMNF0KQGjj+Q8zXsK7w+ol4sTIW1z4FUO4MAR/
         DVEU7neYeeKesgzs7ObCozm7eCCUfaaQ3/GbTK0CeE/jDIqk7x+bI0wztz9em8QRK5PR
         AUXrDVyC862SUzI7jjIabripgEE4miT9UwIUZnkBfg1h2oH7CrsVPw+t6AuxLteyyX1X
         WjYlxJ5++b4yzGKbuCdbxnCuu2Uu3JbwkxmWrTGJiXwLaAH8aklWmf7ztxIgLJ1Ct2XD
         LqRYK9i/QfsbyWFnDnSGSRrNH+knIKThISp8CHO/ODT1NbdFN81rybpPPSlExpyAt7x3
         8EXg==
X-Gm-Message-State: ACrzQf1OotOeZ+cm6ArEuov9SqTO0Qd5Q1jReNMq8ZFq1WRnLIt+alO6
        khHjxN2C6SzyM3LmXK/GZrxget2QrbYhq1MUGsM=
X-Google-Smtp-Source: AMsMyM6DFCY40TH31aG0F6eTomPF/Gekjtc8cIPb5CEMtO76PI/fKG8EYlN2x4+nTo9+r+J78FsIeFoiat1SBgqE0pk=
X-Received: by 2002:a81:8644:0:b0:349:1126:97a4 with SMTP id
 w65-20020a818644000000b00349112697a4mr50323039ywf.333.1667906455548; Tue, 08
 Nov 2022 03:20:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:a38a:b0:313:c983:1d7e with HTTP; Tue, 8 Nov 2022
 03:20:55 -0800 (PST)
Reply-To: mrinvest1010@gmail.com
From:   "K. A. Mr. Kairi" <ctocik2@gmail.com>
Date:   Tue, 8 Nov 2022 03:20:55 -0800
Message-ID: <CAC9COZd+CP91qtBZ4qVfYoNY3bSP8XNzO8wUyONsbrDtKXxqYw@mail.gmail.com>
Subject: Re: My Response..
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrinvest1010[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ctocik2[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ctocik2[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

-- 
Hi

How are you with your family, I have a serious client, whom will be
interested to invest in your country, I got your Details through the
Investment Network and world Global Business directory.

If you are interested for more details.....

Sincerely,
Kairi Andrew
