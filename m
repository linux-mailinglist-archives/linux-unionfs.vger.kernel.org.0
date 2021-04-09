Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C3F359719
	for <lists+linux-unionfs@lfdr.de>; Fri,  9 Apr 2021 10:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhDIIFY (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 9 Apr 2021 04:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbhDIIFX (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 9 Apr 2021 04:05:23 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7246C061760
        for <linux-unionfs@vger.kernel.org>; Fri,  9 Apr 2021 01:05:09 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id o17so1080025vko.8
        for <linux-unionfs@vger.kernel.org>; Fri, 09 Apr 2021 01:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e8oZTg/s3HwJ09qlNL0/Du0S0UlUOjRCsp1WagPGxbg=;
        b=JpHTkn9dboWkuPytF1FgUZW9pi+e+KGCCVifCqQb3LdPvzNWUO1a7TQoIxI6UNoblB
         qdtx/NA+BYg5yaOk7cASPOE7aZl/dVH1aSMIG8TU7fzjvNyVUH8xCci7Gb2k7i6fK0P1
         0cmsVQU2emX9ib9jBjKRmkvJw5UK7ZOvADA0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e8oZTg/s3HwJ09qlNL0/Du0S0UlUOjRCsp1WagPGxbg=;
        b=HtLEGjVwRxEebofoIPoheF/+QkI7cUEaGwMwQuk7xVfmv+294Rd63Ao4w7bqG3xugz
         k9mLmc744fQd4Nka/AehPYI8TLPnudAPv+64Yy9MeaQHFpjhdzedcKye6heqyqkDPCAI
         5seSWLKgtM+pdL1J35an/q3s4Kpev5e1dTgniMv4ASQLu1B+z0g8YH6IPLvaj6lYPWIx
         EB/UJZLsrwN4wJ0NWgXwJSMXBKvBZgz3lUHjmdgcdzOt5sU5jNuQ3w2OEf1OpiJxt5Dz
         bgTzoizAnQURULF49de6nhAo++kEi1GjZStH63emsFOyla4HbBKT69tuuPGjTMkZfGlP
         zhFw==
X-Gm-Message-State: AOAM531evEV5X9Fk/BkUs22AdwFiQG45Yz0Bf5dVx/f2bunp5WrYWtWk
        VwBxwY4meRTCfLTI4apzeo0EtUDi/2SjsGkY3/eEh4dGx6GrOg==
X-Google-Smtp-Source: ABdhPJwmOzY6BsCEGnZ+JDGfMDNyIdBU1e3nsPCBu1+/uNz/+F+YcQUeFUE+W4Qk9NI3pFkfnbLCxgWIZASjvR93PFs=
X-Received: by 2002:a1f:a047:: with SMTP id j68mr9866472vke.14.1617955509098;
 Fri, 09 Apr 2021 01:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210408113020.1708212-1-amir73il@gmail.com>
In-Reply-To: <20210408113020.1708212-1-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 9 Apr 2021 10:04:58 +0200
Message-ID: <CAJfpegtwU5w9vWNYTcw19xUqPO50C5sn98wRXJdVMSvS9zWWtg@mail.gmail.com>
Subject: Re: [PATCH] ovl: check that upperdir path is not on a read-only mount
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, Apr 8, 2021 at 1:30 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> So far we only checked that sb is not read-only.

Makes sense, applied.

Thanks,
Miklos
