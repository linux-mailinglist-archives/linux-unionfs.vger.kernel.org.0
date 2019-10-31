Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE09EAC49
	for <lists+linux-unionfs@lfdr.de>; Thu, 31 Oct 2019 10:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfJaJGg (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 31 Oct 2019 05:06:36 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41583 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfJaJGg (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 31 Oct 2019 05:06:36 -0400
Received: by mail-yw1-f68.google.com with SMTP id j131so1867240ywa.8
        for <linux-unionfs@vger.kernel.org>; Thu, 31 Oct 2019 02:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7qjlGQufn8PuCwFhODy0xhcBgQWeEQlHFeYFI15FROE=;
        b=dWTWYf+iDAeOzKujdVqLvYdlDe00xt50kpBpA1bPN0VrwGqM4g29qOgoDzvMoSu5Fh
         yS/rwjHIPLAi7jfCz5OsTA4QY4K60Q52Np22d9rSXFBPTuT1ZeH4u+qrsJmucogp05gS
         dBrsZH8r2n5RGSXD4d37nKnemSjrzmhvIIAZweOaUBHhy7IyGgaF0NwIdceuCyTzdzIb
         9H0BGUwIenDVyDiOYwFQexZxMtOAdsekZD8/XX3OvC+3/bKCLQzoMgzpdpgh69iXIe9H
         Uj6WV123JZFjCrKMs1ZVZ0nKb7KViJdqdD4kOcuGbV5m+4vhQRL9ddEMuaS2wEkRNfrB
         FMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7qjlGQufn8PuCwFhODy0xhcBgQWeEQlHFeYFI15FROE=;
        b=VuxQMzFLPyPzt3wmSTWqz6d1tcaFDbeEXLnbBgTXbsgNkNH1g6hag102t6CakHUnuM
         pzGQefO3b1pdJ9ogr7ByGHgM91FMWYEgBvvrO1G107+h6ghnEXoCu35tTlWG7unJZKOX
         sQffi8u0aJ+08TTw0Edot5OQFOZxyDeUaEvLBBlI8wltgQNSGnl0pYFPzRW4BWsPjQWe
         0imEQc0LMaOyrgSGQxjtzfkrEAFs3nmMdwy+5+DazetHwNTWPz0X91dSaFAtn9VN64Ku
         agwtv4O+ZglFeMiP2Abc13jejujFSYzQj3r4JeH8sFcF5RWKIQzWY89F6OZ6ODC/3NQr
         eNJw==
X-Gm-Message-State: APjAAAXfJgSevFYgIoZy4cMiKsjQVdlXKDJqerTTzeZwYamtnKW7o+bk
        ntQ+kZ2LIr920/4X48TlVTXoQlLnRYBZ5bwINXI=
X-Google-Smtp-Source: APXvYqwddnb1ijkoGbkS+sVWqb0K+zKnVw7DIpSXAUxL8WbyQM3Q7LLd2afBZDNaCygCLbf90ur9TsNiqBwjgvbNNcA=
X-Received: by 2002:a81:6c58:: with SMTP id h85mr3018229ywc.88.1572512795475;
 Thu, 31 Oct 2019 02:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191030124431.11242-1-cgxu519@mykernel.net> <CAOQ4uxh670WFhwpQyPFTB2nUCSc9n1VmuyPOfdqiBSsq6GxLpQ@mail.gmail.com>
 <16e204de70e.cefd69461771.2205150443916624303@mykernel.net>
 <CAOQ4uxhdSXAvFQfhzZpBC=Xmmo9y+3AOU1o-tOWsLtr2ntU6Ag@mail.gmail.com> <16e20ebaea1.e98a5dc22147.7820959102365222617@mykernel.net>
In-Reply-To: <16e20ebaea1.e98a5dc22147.7820959102365222617@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 31 Oct 2019 11:06:24 +0200
Message-ID: <CAOQ4uxihFu+ObkUxrZ3kzM1G5NrRauhgGxupuBarbAJaXSS_Zg@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: improving copy-up efficiency for big sparse file
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

>  > I did not explain myself well.
>  >
>  > This should be enough IMO:
>  >
>  > @@ -483,7 +483,7 @@ static int ovl_copy_up_inode(struct
>  > ovl_copy_up_ctx *c, struct dentry *temp)
>  >         }
>  >
>  >         inode_lock(temp->d_inode);
>  > -       if (c->metacopy)
>  > +       if (S_ISREG(c->stat.mode))
>  >                 err = ovl_set_size(temp, &c->stat);
>  >         if (!err)
>  >                 err = ovl_set_attr(temp, &c->stat);
>  >
>  > There is no special reason IMO to try to spare an unneeded ovl_set_size
>  > if it simplifies the code a bit.
>
> We can try this but I'm afraid that someone could complain
> we do unnecessary ovl_set_size() in the case of full copy-up
> or data-end file's copy-up.
>
>

There is no one to complain.
The cost of ovl_set_size() is insignificant compared to the cost of
copying data (unless I am missing something).
Please post a version as above and if Miklos finds it a problem,
we can add a boolean c->should_set_size to the copy up context, initialize
it: c->should_set_size = (S_ISREG(c->stat.mode) && c->stat.size)
and set it to false in case all data was copied.
I think that won't be necessary though.

Thanks,
Amir.
