Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5244BA811
	for <lists+linux-unionfs@lfdr.de>; Thu, 17 Feb 2022 19:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244200AbiBQSXQ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 17 Feb 2022 13:23:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244188AbiBQSXP (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 17 Feb 2022 13:23:15 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EF41CFC8
        for <linux-unionfs@vger.kernel.org>; Thu, 17 Feb 2022 10:23:00 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id l12-20020a0568302b0c00b005a4856ff4ceso309642otv.13
        for <linux-unionfs@vger.kernel.org>; Thu, 17 Feb 2022 10:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=GD9Xd5dWI7sJ3Pbd5RkpJQIUhjnU3aaZsmwDIRNYaQQ=;
        b=cYWXLok5orKyXaqQL3HqiGRLC4YgCbCRJR67XzVsQ4QrgCI97Q/erizlVPeUD6yXi9
         LqYvuFCONxXssC4uBEjKDbUpfqsVa4Fk1ITk+CRgVNJfdOLgnchjSDTz8voKWXBtNPTd
         K8MlPDYlPbpqNGDg7uKo8MgmA0m6tQ9I4r0zMF/jrQdpzkbIfEYMzY1mZzmhIbCc5AF1
         7fncHQAIc3A+A7Kr6bfhG+jMIIubkgtFd1cZ0Z+gCE7CTBkPMdSXZqS7bpzqm4XTddFI
         bFd/LS3JBtAuhIxKGN3LhrFA532hLIeCuDQR3SyIZUqCphXiy/6X1TQELRf21x7Emmr5
         G25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=GD9Xd5dWI7sJ3Pbd5RkpJQIUhjnU3aaZsmwDIRNYaQQ=;
        b=PCbiDujkVAB4tTzoa0xbcLj6aFJtCbREpMx+EC+sQvfyMcyLLxTo8TNtm1wHLHf3a3
         D8lj9jG62NA0Dk8tMddPEl4I3g0xId199vqpUy67IQcVBrH1prBtsodjAeaPDkAleB/c
         mweUgCZBG3GGfoZpZYOMSZI9DiXNVsobuhKMpVd+S6yeVDTNM/FHjhfA2IcJoyC3ByJo
         dxMhoTzX9OAhl92BqPAtVPevwVDA6sha9jwPBVSBJyVBqeHji3XBGquCbOm1MVeEfoEU
         J+tkGiOFwIdtVjaYxuOoKVtNDNdJyIq1Rm+J6/6XWz5hIEIZLa8m96ppoSFWBgvyKfYJ
         jznA==
X-Gm-Message-State: AOAM532CnivfvpnSmoF0GIakSf1ANfG3ER0eO237QrX5186EwZivCMZu
        K9FliIO2nUcaPBRPZPB9kHcDJ8okXtnFnd5E9MU=
X-Google-Smtp-Source: ABdhPJxp/rS0M7l3ds7ab3rZlo938CclzpZ+7NeZ4xPrytI3gKzikfZkN1t72H/zHbRvEfYQP7+8GtabYeGHgyrDa10=
X-Received: by 2002:a9d:4c16:0:b0:59f:7079:3d1b with SMTP id
 l22-20020a9d4c16000000b0059f70793d1bmr1308194otf.57.1645122179173; Thu, 17
 Feb 2022 10:22:59 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:ae04:0:0:0:0:0 with HTTP; Thu, 17 Feb 2022 10:22:58
 -0800 (PST)
Reply-To: wijh555@gmail.com
From:   "Mr. Ali Moses" <alimoses07@gmail.com>
Date:   Thu, 17 Feb 2022 10:22:58 -0800
Message-ID: <CADWzZe5-O+iUJ=4LcbVWTHXcyL28qpk1fiT_veS_nnKVgvfQcw@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

-- 
I'm Mr. Ali Moses, how are you doing hope you are in good health, the
Board director try to reach you on phone several times Meanwhile, your
number was not connecting. before he ask me to send you an email to
hear from you if you are fine. hoping to hear from you soonest.

Thanks
Mr. Ali Moses

Sincerely.
Dr. Irene Lam.
