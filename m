Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3E9512106
	for <lists+linux-unionfs@lfdr.de>; Wed, 27 Apr 2022 20:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244291AbiD0Roh (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 27 Apr 2022 13:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244797AbiD0Ro1 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 27 Apr 2022 13:44:27 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559A9888CB
        for <linux-unionfs@vger.kernel.org>; Wed, 27 Apr 2022 10:41:11 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2f7ca2ce255so27184837b3.7
        for <linux-unionfs@vger.kernel.org>; Wed, 27 Apr 2022 10:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=3EFWB19a1Chh2SjnoysoX6/VQoqNb6piiPOAPnA2gVg=;
        b=dAv8KZ6MvIxj6XnmgMVYNXAprswpLSuJ5a2ia3x8ovWEuQ55L46cLg73JqmmbTTLMU
         m7SXhSXjQCS8EhQIgpEUXZOksFIYse90UXxhCfZM78+RUOdbyn4LLITxz2JXgV07dM8q
         zlf35E7Q5ZKH33CFN0uV2gnSJQfPNHXQi9/bizPS2FLieuesrtG02wRr96bm1qCSk4uB
         dEbGPn5qN4sckCqIA2GF1nXO0zcz1rvYT1zlUnzJ2eSf40MOG6/CJWF6YSa1UyIct3mk
         PukuGDiZ8QTlIkVJoXDJwtyyOUb23/+PKofuuGmfjMFAIj1lO+z2J4XE3ZszVLYiA2Hf
         1frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=3EFWB19a1Chh2SjnoysoX6/VQoqNb6piiPOAPnA2gVg=;
        b=53KHSaSR720ZwOkf30LnNjTmPgfWOFl7M0hPiBcGRNtG6bp9um/cM9gAPmdJKp0gWN
         PRMuZ+YkXXbNEr+IXkuFl75VXxvxF30gsDD+4D3cWskYYl00uLCznEzOhLmyyBsOaOPZ
         ZTCbycgzAJCpJgwCmCY5+obgGIjDrnaoBOc4LDEAG47YUivWJhgyChSy7FMfXWDBX8vG
         /L7hqXdd3l1HAk11aNgXpO0ycyhW9i7IXXQ2bakmuhw64u4NrRVoeRx4K68nIrng0vAO
         5PUGu0p/vSBrctz0h/JHeldGCPOnSG44gE4KB4T3HX/dO59xu24aUKqYymD/UmtsOaZE
         L0EA==
X-Gm-Message-State: AOAM531Pkif7RtmIormNgBWMPY0w5O3XJ8qc2HnjDKag6qQMkK+T9lod
        wqp3nzULwJ9W8reqpaM6yKudmdi6cQyWuOd5TyE=
X-Google-Smtp-Source: ABdhPJwhZ5YokfBVJVoUB+1S5nUHEyBuvvLmvSUDPgxj+NqtPnrwvRHlveMqiGqFNlljYsMLmjZkvjkkMcuEsjfOH38=
X-Received: by 2002:a81:1a4a:0:b0:2f7:da21:ec5c with SMTP id
 a71-20020a811a4a000000b002f7da21ec5cmr17428972ywa.312.1651081269016; Wed, 27
 Apr 2022 10:41:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:2049:b0:170:285b:5d9 with HTTP; Wed, 27 Apr 2022
 10:41:08 -0700 (PDT)
Reply-To: awoonorpatrick301@gmail.com
From:   Dr Patrick Awoonor <colleyking04@gmail.com>
Date:   Wed, 27 Apr 2022 17:41:08 +0000
Message-ID: <CALJPoxqDJuEcpxOQMjag708b8eaoM9rRVUtXGg5E8C6J3c4aaA@mail.gmail.com>
Subject: c
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Did you receive my previous email?

Dr Patrick Awoonor
