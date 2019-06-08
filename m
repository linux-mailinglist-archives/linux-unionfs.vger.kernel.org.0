Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF0C73A16C
	for <lists+linux-unionfs@lfdr.de>; Sat,  8 Jun 2019 21:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfFHTKz (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sat, 8 Jun 2019 15:10:55 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44747 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfFHTKy (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sat, 8 Jun 2019 15:10:54 -0400
Received: by mail-yb1-f195.google.com with SMTP id x187so2108780ybc.11
        for <linux-unionfs@vger.kernel.org>; Sat, 08 Jun 2019 12:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cmr5Mdaa4lskdiv3Ds0iI7Cy8C6s7IBfIJA3vTYhORE=;
        b=CJ/5JGDz4Id2h7chOM4MxNAPbBWoxftVnL3rAJFO/5LOPRObDV+NBnkGgpWMatX6i0
         QX5tSlYZxPuMgpq+Bw7Eg0TzFxWDtZrt5wJo1rpBxA5YcMAs54IuXTjbUzBEm4ixbzfN
         zdggcAPippxgS4CqyOFmgdEGo7oecnbWDiYq2IUoep1A9lGkL71c2xGr+5cWyDe8OU7F
         WBR7yFz7Xw3jMlZIoq6u65P+B0mZNpfwaPSOzHI+x1XrwJSPgwQ+yiw65jbX8mI1JRB4
         INwz8Dos9+CuSeZawAsU5ZFijkpFLB/nx0Ei9POjABXu0sfXQKLKKVYex6QMixBxWv/4
         yZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cmr5Mdaa4lskdiv3Ds0iI7Cy8C6s7IBfIJA3vTYhORE=;
        b=ME7EQylSsObM9iEDKYhE38YYabXY3nJNYwUfL7xr1V8Wyx+l1SIi06ehMIdVjMHN+/
         v03GStW+UCT+iNw/a1FFVbDQPuRcJREysf9na2WLLKRK77PbUF7t4iAjc8zbnkmaBkVr
         9/xt9BTL938ElBZWApUKY1aL+kvRxaQieN0+rMH1m1HSPJt+H5hyQIFvnaKZ+uhrMBp/
         +I3TItD9ef/U9oDl6aMCGoh3Xepz45Eo3Ek95VjQ5RERC3tpOfjxF8q047hRRppu5S+j
         06QHL6e+xfE8OE8uVVxA9Lpsf21+iiWcbxquarTOZie3R+9NpfD+vYMaia5evo0VQ8qP
         ttWg==
X-Gm-Message-State: APjAAAWkA8v5Srfqj5i563H6WrkjflSIuKTAC6SMY8vDYBCKlgTXIq3A
        uX8kYQH0ZjCKUjCJz6HLvomaDLRlDwZ1NljpPWI=
X-Google-Smtp-Source: APXvYqzKKgi3gqb3r5smoCNYJA+Zv2JRz3YcwjcTaD9a68Q+juWMLls0gZDMiUiKlMsKF2Q9Q07g7jOqcxWrxvHPtpM=
X-Received: by 2002:a25:8109:: with SMTP id o9mr26549620ybk.132.1560021053967;
 Sat, 08 Jun 2019 12:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190608183534.2963-1-mcoffin13@gmail.com>
In-Reply-To: <20190608183534.2963-1-mcoffin13@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 8 Jun 2019 22:10:42 +0300
Message-ID: <CAOQ4uxiX7Rh+46ydXYakKiZ+jP4=uyak8NjWOJK5WTcvuRcHSA@mail.gmail.com>
Subject: Re: [PATCH] overlay: Display redirect_dir mount option when it is set automatically
To:     Matt Coffin <mcoffin13@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Sat, Jun 8, 2019 at 9:35 PM Matt Coffin <mcoffin13@gmail.com> wrote:
>
> [Why]

The why and how are very important, but please loose the annotations.

> Currently, if metacopy is enabled via a module param/kernel config, then
> the setting for redirect_dir is overriden, unless passed as a mount
> option specifically. Despite this overriding, the redirect_dir option is
> not printed when displaying the mount options (see /proc/mounts), so it
> is hard for a user to know that it has happened.
>
> [How]
> A bit of code that does the overriding based on the mount options was
> setting redirect_dir, but not updating the redirect_mode string. By
> adding that update, the information is now printed (and the config
> struct has the correct information in all places).

You need to Sign-off your patch.
Please run ./scripts/checkpatch.pl before posting
It will tell you that and so will:
https://github.com/torvalds/linux/blob/master/Documentation/process/submitting-patches.rst

> ---
>  fs/overlayfs/super.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 5ec4fc2f5d7e..46fab4660bfe 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -598,6 +598,9 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
>                         config->metacopy = false;
>                 } else {
>                         /* Automatically enable redirect otherwise. */
> +                       pr_info("overlayfs: enabling redirect_dir due to implicit metacopy=%d\n",
...metacopy=on\n"

We know the value and better display to user in mount option format.

> +                               config->metacopy);
> +                       config->redirect_mode = "on";

I'm afraid that string is allocated:

                        kfree(config->redirect_mode);
                        config->redirect_mode = kstrdup("on", GFP_KERNEL);
                        if (!config->redirect_mode)
                                return -ENOMEM;

Better wrap that up in a helper ovl_set_redirect_mode("on").

Thanks,
Amir.
