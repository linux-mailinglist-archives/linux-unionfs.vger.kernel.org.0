Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EED09130D97
	for <lists+linux-unionfs@lfdr.de>; Mon,  6 Jan 2020 07:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgAFGfi (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 6 Jan 2020 01:35:38 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38787 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgAFGfi (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 6 Jan 2020 01:35:38 -0500
Received: by mail-io1-f68.google.com with SMTP id v3so47553645ioj.5
        for <linux-unionfs@vger.kernel.org>; Sun, 05 Jan 2020 22:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tNbCTMK5hFr53U0AeXQqZ1eRJkRA78RQ1Kwbs3jUxFQ=;
        b=ovBcn9JrXNgzB68BfJwXeX60GnU7gMgMv5jJsp9p380us93/F6+rsKpY42buZZYYQ9
         vQR1UgSibyyc72vXle0WlKxQ0bU9hXI/tDqv5XjHGeQGB5yE+BMuRGaiv9gOIrpcWLK3
         UOw+8Wd0nFVUunzMDM+3lysmNoQULqO+RCBdbOFykLWWaPjP/ogiMr6bvGhv3AoKv7xJ
         85IetCPSTKak1MDadMkrAxTbJrbfepu8T+V9OC8ZSt9vAIbZYekz3GIqsKkQkma/ORUv
         uuMQsaOZ4RlFnqE6Jkup/ohnfsHM2MJ8XdNdSDq9nCso4NB2c4eT6gWompZ53K3Zqbye
         DzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tNbCTMK5hFr53U0AeXQqZ1eRJkRA78RQ1Kwbs3jUxFQ=;
        b=MEb+5cE7lyqOyb2qNJnN8X0MSHxo2dZKz9XuJ0qHldfNq+6NafOSzQWVYZnhE32slT
         rNa6CJsbx4H8175sc6k0OvVT8oxkSnbOstEUB2gVRvTEavCQm6Gr5rszqEPSTwTV8QMY
         sxg8lMqi7c8Sx0O29FSOf7NTi/rITW8n2QIDeApVQGTOeTWXMbQ9j8F+PsQeG4BFCvk6
         AZuxTtxhU+CCgOizf+z3oD0xmdU6Tq0IDCVlVjbZLfVgO8dFNbEBU2hr28zBn9kP55IE
         8OHV1fqBFqLDqb1+jWLmJrrBy9nlJt7OXRlvZSkCzjpIZrw6rSlmCVKxdiEZl3dOn6nP
         yXVw==
X-Gm-Message-State: APjAAAUSzutDTa5/UYBLUhzedsVUdzhqnVA+LOdneeg0+XALN6URAN58
        VjsZwYvgYzl+lMKMjx8dfByL08g0FdevYhdXdgG8QrWw
X-Google-Smtp-Source: APXvYqwAY0GRaqGsCUJ/Z/YOut2l6tqmYGZrzXHGd9LLC5CwR4u7z2uOmTxMo9uRqxRQRwUG/qCzNiGkDXal2nWVXgc=
X-Received: by 2002:a5d:814f:: with SMTP id f15mr66428395ioo.275.1578292537372;
 Sun, 05 Jan 2020 22:35:37 -0800 (PST)
MIME-Version: 1.0
References: <20191223064025.23801-1-amir73il@gmail.com>
In-Reply-To: <20191223064025.23801-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 6 Jan 2020 08:35:25 +0200
Message-ID: <CAOQ4uxh4NygFUFvUp3xs8rZRUkc3SDxO1DL6YrNhx3j0SBgAJg@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix wrong WARN_ON() in ovl_cache_update_ino()
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Dec 23, 2019 at 8:40 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> The WARN_ON() that child entry is always on overlay st_dev became wrong
> when we allowed this function to update d_ino in non-samefs setup with
> xino enabled.
>
> It is not true in case of xino bits overflow on a non-dir inode.
> Leave the WARN_ON() only for directories, where assertion is still true.
>
> Fixes: adbf4f7ea834 ("ovl: consistent d_ino for non-samefs with xino")
> Cc: <stable@vger.kernel.org> # v4.17+
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>

Miklos,

If you have time, please send this one to Linus for v5.5.
It is a simple fix and the only one causing failure in the new xfstests [1]
that I posted.

Thanks,
Amir.

[1] https://lore.kernel.org/fstests/20191230141423.31695-1-amir73il@gmail.com/

>
>  fs/overlayfs/readdir.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 47a91c9733a5..7255e6a5838f 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -504,7 +504,13 @@ static int ovl_cache_update_ino(struct path *path, struct ovl_cache_entry *p)
>                 if (err)
>                         goto fail;
>
> -               WARN_ON_ONCE(dir->d_sb->s_dev != stat.dev);
> +               /*
> +                * Directory inode is always on overlay st_dev.
> +                * Non-dir with ovl_same_dev() could be on pseudo st_dev in case
> +                * of xino bits overflow.
> +                */
> +               WARN_ON_ONCE(S_ISDIR(stat.mode) &&
> +                            dir->d_sb->s_dev != stat.dev);
>                 ino = stat.ino;
>         } else if (xinobits && !OVL_TYPE_UPPER(type)) {
>                 ino = ovl_remap_lower_ino(ino, xinobits,
> --
> 2.17.1
>
