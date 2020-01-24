Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF8471487E3
	for <lists+linux-unionfs@lfdr.de>; Fri, 24 Jan 2020 15:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388095AbgAXOZY (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 24 Jan 2020 09:25:24 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:35410 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392237AbgAXOVu (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:21:50 -0500
Received: by mail-io1-f53.google.com with SMTP id h8so2111509iob.2
        for <linux-unionfs@vger.kernel.org>; Fri, 24 Jan 2020 06:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tngT/KiuTDoNCYSFhfNCEpcI5RfLQox8JGQztnGw/p0=;
        b=a4IzuptxU62Rjh4maj91igzs3PgrqVmb01UwKtcuEOrx8l3o3Xymh59WVLGPanysYO
         6I7a3aqlaLTx22LubQWvUHfmIbbFERCoi0g3e6JVMF7ionzpgg8GL7AnDPF6oaeaBoLc
         /J5RNf+zVGWw/lffTU5sFJvSxQ+iAUQMJWdUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tngT/KiuTDoNCYSFhfNCEpcI5RfLQox8JGQztnGw/p0=;
        b=EIItwobuj8gIE3cYYDIhzZk1rGwNjMt1hC48LcvSqG8Z9m7CSsBhO0YTRiZYanhU3C
         q5n3MbwOyTNOGSoB7fsZEEJH6ylYU5aG+EY8PrD0FlHCzVtInsSaxNQyt+ToMOtHyrzQ
         EmJU/hkfVC6iy7uix+JKCUtlWWNtS3oNBFB5+t2DDkzjPDIfqdhUzVQOsg/kX3REQXU3
         VWNoj+WWSagml/UTLEjirL2iHDs3xS0j75NNoC4BqkqYwolSRWag+yhvwT6NU0Bba1Ra
         ooUNRUZoGj/eB1JoNS2XeF6aL8JZw7Z6vmGF2FJcx/hvxznEZ42k70S40wVD+wnn16g6
         ZktA==
X-Gm-Message-State: APjAAAU/Xdzt3wKny3RtZdiBcnn1PrHFABgFxSOZ8wclToQyj/6+KYlR
        6DlLFOPlMwW/yBnG/rEw6vWou4NKHvUiVRrfLI6LvViSVOA=
X-Google-Smtp-Source: APXvYqyEnSfBuuv0JvdO/kkl1iTrBxGgHBjYf4Y1YIfRIa9G+ozg+or7Y/LtwTy1scwEwcY/+opDFJOCqEfithD/VpM=
X-Received: by 2002:a6b:c9c6:: with SMTP id z189mr2283669iof.285.1579875709841;
 Fri, 24 Jan 2020 06:21:49 -0800 (PST)
MIME-Version: 1.0
References: <16d7200e45c.1398c37e020790.5506577327176178828@zoho.com.cn>
In-Reply-To: <16d7200e45c.1398c37e020790.5506577327176178828@zoho.com.cn>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 24 Jan 2020 15:21:38 +0100
Message-ID: <CAJfpegv949oJAZQNjTsq5MQHz6LLkfihp4S_mWRuYsLRuPCgFg@mail.gmail.com>
Subject: Re: syncfs improvement for overlayfs
To:     cgxu519@zoho.com.cn
Cc:     linux-unionfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Fri, Sep 27, 2019 at 11:15 AM admin <cgxu519@zoho.com.cn> wrote:
>
> Hi Miklos,
>
> It's been a while since I posted my last version of syncfs improvement patch[1]
> and I noticed it isn't get merged yet. If you think this patch is still valuable then
> I would like to do rebase on latest overlayfs tree and resend for review.
> What do you think?


Hi,

Sorry, this has fallen off my radar.  Can you please rebase and resend?

Thanks,
Miklos
