Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E403D0F47
	for <lists+linux-unionfs@lfdr.de>; Wed, 21 Jul 2021 15:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhGUMaz (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 21 Jul 2021 08:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbhGUMaz (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 21 Jul 2021 08:30:55 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210F2C061574
        for <linux-unionfs@vger.kernel.org>; Wed, 21 Jul 2021 06:11:32 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id e9so1369387vsk.13
        for <linux-unionfs@vger.kernel.org>; Wed, 21 Jul 2021 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R2ZEJQZQbiFr/7zUKjwe6Kz2aT8bBlcDHf06DIysZZ0=;
        b=lfTvwbJTeDA0hFKI5gdv7GJKcufMvQDW31X51ux7VJETV0YT+gjGV8yUfJr6DhzDv4
         CjHVk7DIVJjN3R6OCvZneFIFiLRfmaHpbki6OAvFK1eVuJkDuoR3awGAklP+3dlevt3o
         +mN3oDcgglBI9xueG/N+qChlwNatKgmJkMdFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R2ZEJQZQbiFr/7zUKjwe6Kz2aT8bBlcDHf06DIysZZ0=;
        b=DqBr21mH34ebnOKw8cKabqASxxpcNTSSjdYUbyvZaIji6MjDxqLrncs2QgU2DRhwgn
         F5ApzEEx/RX0oWkgA+U0jhgU6EYB97IZIy4aWWP5Q1ezJQa8+VVluUT97Mp8rUewJr8q
         2uOMi+p09gX7LwvpJKk77EWP1v3P7ZGpA+nuOlH8TXAQbeVdJWvHGItmIlF0Lzf3VHNb
         sQVM9qgsJbhvuobmm3yXH7qgj220x5Vzdr9L4kEA/MRU02U+lQ1Ayew2z1RSOzWo85m7
         stTt3bDU+MPVoLcTUZ5lFsinuABjca3NjeU4jQUEptBbMUPvsUnSnWsPvAY7FETsj2/P
         gs9g==
X-Gm-Message-State: AOAM531Qs8rK/gOPD7YvRksWaqfGuDFU0xfmPqlJUwkXdB5dAFAP+R4Z
        +mWTRNvI4R9OsWrLdIfixrNQ3wOnyGIHNuSVMNVQcA==
X-Google-Smtp-Source: ABdhPJw+n/OhSDoKFt/26aQrLN19b4I1LPSJzssYkINDgmXFXi/48uSVhMNc12BPzSkB8xMb5VfUrfphPQxHq9jobDI=
X-Received: by 2002:a05:6102:2ca:: with SMTP id h10mr35482255vsh.7.1626873091266;
 Wed, 21 Jul 2021 06:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210310020925.2441670-1-cgxu519@mykernel.net>
In-Reply-To: <20210310020925.2441670-1-cgxu519@mykernel.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 21 Jul 2021 15:11:20 +0200
Message-ID: <CAJfpegvvPoVpWLBTC-caM9EJp4kAbCTf=drgeSWbVQa1XWHRXA@mail.gmail.com>
Subject: Re: [PATCH] ovl: update ctime when changing file attribution
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, 10 Mar 2021 at 03:09, Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> Currently we keep size, mode and times of overlay inode
> as the same as upper inode, so should update ctime when
> changing file attribution as well.

Updated and pushed.

Thanks,
Miklos

>
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
>  fs/overlayfs/file.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index dbfb35fb0ff7..49b73a2e92a7 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -546,6 +546,8 @@ static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
>         ret = ovl_real_ioctl(file, cmd, arg);
>
>         ovl_copyflags(ovl_inode_real(inode), inode);
> +       /* Update ctime */
> +       ovl_copyattr(ovl_inode_real(inode), inode);
>  unlock:
>         inode_unlock(inode);
>
> --
> 2.27.0
>
>
