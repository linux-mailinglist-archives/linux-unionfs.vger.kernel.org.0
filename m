Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4EC3052E1
	for <lists+linux-unionfs@lfdr.de>; Wed, 27 Jan 2021 07:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbhA0GKK (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 27 Jan 2021 01:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbhA0FnX (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 27 Jan 2021 00:43:23 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4BFC06174A
        for <linux-unionfs@vger.kernel.org>; Tue, 26 Jan 2021 21:43:03 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id y17so678735ili.12
        for <linux-unionfs@vger.kernel.org>; Tue, 26 Jan 2021 21:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sy+6KftzNG4+3B7e/a/DqTGE7jAFc8oKf9UybNmLmwI=;
        b=tUgFv7C5cNRbw7ERgLO8JwTmnR8EHlhI0gqq5TGFR6MqmEt9CpPnkdlU4JHApaOSB9
         9N1o+IBaNos0nECWUbjvkd/N+BTFUZmuklMk4D2n+pIf89FhOX6Q29B0d9kl3NsIn+Bd
         75/82YuagYaX0G/cDpavo2VM/kBp5ZMJd8lJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sy+6KftzNG4+3B7e/a/DqTGE7jAFc8oKf9UybNmLmwI=;
        b=RP52dg6flceBbCo3f/YwQ1bTxY9/zybOOD07pBa6beZYSp/E9VPOVFl8aN/dm0oE1M
         CKggRzDWUexvTgLQ8iP1pG3j2vfBIrgr5Y/Ytqn4/CZBC/K3h52g65ppwOgcARHJi9cD
         gxrJWd9rE2IGD3WG2hjiYRCPgxjTyoQogIi+rg24kcvMTChKvypvW1S0p8RV2E16pm+i
         fmrLEuaDpU5j7XFLOD+XIhcqwRNTZjPKuQEW82XmSHYGWFWVfOS97JkK5BEDFUGRpcIC
         fbD4nb5JUNaVw02K8f6OMg0qRJkAk8Txee1rptMjjfvrMsTZPDxDbnbLXqD94Pj+cZWe
         iK9w==
X-Gm-Message-State: AOAM5307YuyAuJ+LYt8cdKU8/XvHlkf0K+Gp2hv3iBVptYfBrhZIS2Bm
        ml7gO+mPoy5jxz+t/dVzfsaOOufrtx6Z8G5lQg9PEg==
X-Google-Smtp-Source: ABdhPJzitlGURTduNT0Dm9ph/14v9F5SGNvKXYn7TaE5aO8BWOSgzUm7KzZK4r+u2Gup1GmIsUqHNXYgYCpjU9aDPq8=
X-Received: by 2002:a05:6e02:152f:: with SMTP id i15mr7637103ilu.277.1611726182228;
 Tue, 26 Jan 2021 21:43:02 -0800 (PST)
MIME-Version: 1.0
References: <20210126165102.1017787-1-amir73il@gmail.com>
In-Reply-To: <20210126165102.1017787-1-amir73il@gmail.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Tue, 26 Jan 2021 21:42:26 -0800
Message-ID: <CAMp4zn8_LL313MYQ0aJRPOgpTe1NZN1+Gg0a-QW4qHZ1M62czQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix fd leak in ovl_flush()
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Jan 26, 2021 at 8:58 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Miklos,
>
> This patch is against overlayfs-next which currently fails xfstests.
>
> Thanks,
> Amir.
>
>  fs/overlayfs/file.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 2ff818d5c2c9..6fa9ac682beb 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -693,12 +693,17 @@ static int ovl_flush(struct file *file, fl_owner_t id)
>         int err;
>
>         err = ovl_real_fdget(file, &real);
> -       if (!err && real.file->f_op->flush) {
> +       if (err)
> +               return err;
> +
> +       if (real.file->f_op->flush) {
>                 old_cred = ovl_override_creds(file_inode(file)->i_sb);
>                 err = real.file->f_op->flush(real.file, id);
>                 revert_creds(old_cred);
>         }
>
> +       fdput(real);
> +
>         return err;
>  }
>
> --
> 2.25.1
>
Thanks.

Reviewed-by: Sargun Dhillon <sargun@sargun.me>
