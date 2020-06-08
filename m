Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F081F140D
	for <lists+linux-unionfs@lfdr.de>; Mon,  8 Jun 2020 09:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgFHH6E (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 8 Jun 2020 03:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbgFHH6D (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 8 Jun 2020 03:58:03 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0D1C08C5C3
        for <linux-unionfs@vger.kernel.org>; Mon,  8 Jun 2020 00:58:03 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q19so17180265eja.7
        for <linux-unionfs@vger.kernel.org>; Mon, 08 Jun 2020 00:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FnYXOarcP1xioN7l4ot1AhdtG4JNoUpeWg/XNLd3npE=;
        b=f5yQijiB7OowIorlImy3UsKTTNlGwNW8asfpmQeSJSpDOgsCQfZzpWPG2Sz7dqu2Wn
         DlCOiXMwFuIkrEDfutgWaW/ibdyNhBIoR9RfMMurf+TsX8JZxCQ7Md8H42cCOXPQkDlF
         dYoMSvAjAMlln3QQxq8PirkAWlSDGhjysCJ6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FnYXOarcP1xioN7l4ot1AhdtG4JNoUpeWg/XNLd3npE=;
        b=WEq/Y1jG5UNSuqSgcyClWVKlq91UPU4a5n2LvryDz0XlsNIOyDG/ZWnuj/BUaL9bOw
         EDNi4tAYTMnptysCJk/xqOMIFzlhAS0jke6xSmUDQJW6zQpwrYEACvAk8mVjMNT2clfS
         FViLnYj4Ht7drmej4h6YtXAxaFpSL+4te87PUjdObqzFhKJyhOjtrAPr6zdSZ5n5CAv0
         L0YMN/Tym6L5M+aViYeAvCFG8rcBGWBL/7X7QIrY+hhTf7SEFOP8745QFsMWppOnPdC6
         4JhZizsPiSVVqB4L70k+VCKKs0Wtv0LALxb88ngMQSGV2fNxLfJvtrMf8Y2QNx8BGZCz
         LHKw==
X-Gm-Message-State: AOAM530gxHBpNyAzkrh4b8ePTAFhSrXgp3WnJpLnEef6Weazd3/55P41
        G2IFe8fQ0HtrrsKAwuR3/aT4wvRDVSIKocVFnCUOFjeDyto=
X-Google-Smtp-Source: ABdhPJyCnIgBCEDCoNBHqGYQYEaBdJkbGGZWn1i7zhoiyk6/vMeI0WdL99LC26+sCX/39e5gIGKyvz/Q0eJ828xDpGI=
X-Received: by 2002:a17:906:1947:: with SMTP id b7mr19043161eje.320.1591603082179;
 Mon, 08 Jun 2020 00:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200607090406.129012-1-her0gyugyu@gmail.com>
In-Reply-To: <20200607090406.129012-1-her0gyugyu@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 8 Jun 2020 09:57:51 +0200
Message-ID: <CAJfpegtQ03eDpK-=0v18hat9Dbmt779YoHuBQ=dt7n=ariZqeA@mail.gmail.com>
Subject: Re: [PATCH] overlay: remove not necessary lock check.
To:     youngjun <her0gyugyu@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Sun, Jun 7, 2020 at 11:04 AM youngjun <her0gyugyu@gmail.com> wrote:
>
> dir is always locked until "out_unlock" label.
> So lock check is not needed.

Thanks, applied.

Miklos
