Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432AB5469A6
	for <lists+linux-unionfs@lfdr.de>; Fri, 10 Jun 2022 17:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiFJPnm (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 10 Jun 2022 11:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238346AbiFJPnO (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 10 Jun 2022 11:43:14 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAC640E5D
        for <linux-unionfs@vger.kernel.org>; Fri, 10 Jun 2022 08:42:54 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p128so6201481iof.1
        for <linux-unionfs@vger.kernel.org>; Fri, 10 Jun 2022 08:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=ustad4Oit1LbdSHBANPMFYdxqbyRopb/4kSjojaTPVc=;
        b=jDYzoOLovophfbABYbXrwbWu5GmvQXlNBDb/GjRVThdnkLVGNDOE7YpxHQQK90g8tW
         1fAzW8ixiR8iliuayQTtZb4Rkk3JDyQgnFCbv3Yt869eq7BE86Vi5OQ2D0fTZ9TsBLpe
         laJj4T1GRxyruLdoWMI6hnRjvPgjujT4KrLXmPNGCxumAeKwnFjW+jy4hdqz83LSJVnt
         aH5B6agJH/Ow3ngyAPDT6FdUbsVE7XHva2HdqHy7X64triPUtFBpxATLHOkJxDH1dF3I
         RSdI+w39qTgdjalliunAn5AWBTwqHkzxkGS2tvbur7hkvLdTOhVn4QJZ5xcRJo+ZXnjR
         2i7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=ustad4Oit1LbdSHBANPMFYdxqbyRopb/4kSjojaTPVc=;
        b=K+8un1CuPiiqVe38s63YcW87gR4aZRKaBO0EqkuJc58JOfRT/LgyZkPF5ZVGaYjgUN
         ewMeP4iaOr3eu85UKOh47aiCyoDWiXxGMrH3qsg6Krgf1NXK+t0aFtSw8obanVzOBlG+
         qRh4i3F69ULWFthOyCIkpswy25I1aQ/+2reINfUzvEct2rTsoE3mSJ3ayIqE1I/ojLCF
         4h0tPatSvrDTSwfSAwGDnxsvIHWhv47/Ngn9jVvx6BGmMTeA8SuNcmvwAk/XoqJIb2Xe
         rThBssxwb/pXg4febh1/V+NcMUE+2vKKM+NWnpSc+uN5deCPgPxrGrTYczV3lSyzAq9v
         /qhg==
X-Gm-Message-State: AOAM530/2uNw6dpcGOmb9GsGCnTd98pIsySelZb6DulM6sYPI2E03PQ8
        ZFjkg+bGEwVVYSLJS74zLc9VCROt3VGDvB9VaY8=
X-Google-Smtp-Source: ABdhPJyiVMNvYORF57AlK4LeaYCuOMVhgsdHetF5VnSEs77wfG77p1aJu1bUa+mzQLZAYqFmriT+gAjSXUQ1gUH/66E=
X-Received: by 2002:a05:6638:4705:b0:331:7c49:7048 with SMTP id
 cs5-20020a056638470500b003317c497048mr19462641jab.182.1654875773961; Fri, 10
 Jun 2022 08:42:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:a709:0:0:0:0:0 with HTTP; Fri, 10 Jun 2022 08:42:53
 -0700 (PDT)
Reply-To: rl715537@gmail.com
From:   Rebecca Lawrence <angel.corrin2015@gmail.com>
Date:   Fri, 10 Jun 2022 15:42:53 +0000
Message-ID: <CANUTHVhiNF5VARKnERR=r-zHShz1rSvMhH=jyKwNGUZZcwaZrA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hello Dear,
My name is Rebecca, I am a United States and a military woman who has
never married with no kids yet. I came across your profile, and I
personally took interest in being your friend. For confidential
matters, please contact me back through my private email
rl715537@gmail.com to enable me to send you my pictures and give you
more details about me. I Hope to hear from you soon.
Regards
Rebecca.
