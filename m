Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F80713B3E2
	for <lists+linux-unionfs@lfdr.de>; Tue, 14 Jan 2020 21:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgANU6a (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 14 Jan 2020 15:58:30 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:37594 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANU6a (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 14 Jan 2020 15:58:30 -0500
Received: by mail-il1-f194.google.com with SMTP id t8so12828395iln.4
        for <linux-unionfs@vger.kernel.org>; Tue, 14 Jan 2020 12:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=19tezQhRdUSg//bY5O7UsENJOZxBmM0LSY+DqNSKgR8=;
        b=qA/kNkFLIzLfoS7MAKjv84Hm8u23ph/9iXJSmE+7RzsN/wNX87hBt++fYscUSiHHP2
         +JepssS+hF1leI5psA2LinhnwM6Sxwb81LhZijHAZbYPloi7MFDD9BXXSRbKsiNh4hGS
         Dtx31RwwlfhwPMyqPYla76jCV/DaYDL+9ZHYNs1u1C1LWhC9zvmYZ/dJ6DnPSEFuU2zl
         PNoXDH501w45B9z5ZHdYHbfIH75nmMdHtXDf7qC0Yf1VfdIyDXXnkVidrjMGNB6rqDOz
         mn7s6gNusJ7DuWrTt86ouRG4P9zkPmCh3rQTA7in6ulc9OXXCyysJSWkC8wfpUuboMDw
         2nxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19tezQhRdUSg//bY5O7UsENJOZxBmM0LSY+DqNSKgR8=;
        b=Mo5Ukj7H9nTIZS2LOUooDLD+Wm+sGmL3m7Z2u//h1zS+IaDk1O4x880iM+lsiSorty
         5Go2YCYrqUNpsK1oXwqJassVyXZU8TND6rYMKU/Pfh9JEYk3X5lHMhWv6BwiMGmn2d9z
         qRonRsgSHa5Ef6dHV1c3dXU8rdrQrBnhivZnX+z2Rl8ikwppZMgB0y+VWr2f7cYLbt2N
         BF+Kz/Lg07aimttP8tXslag3yqEmbXaP4wV7g+BbVN5WefFhNcuQ0dayqPMGr9/x9vRI
         ToiR9q6OT9UBtF3b2t6zZf2j3QpugxsjMVDE7/KcrjI74Mr1OYACzHSqPLpuK0yUfAL6
         NAbw==
X-Gm-Message-State: APjAAAXtyo3o3cucJPw4de2stFn/xuAwGIaqwE8ZQRwEy2AQBuu+TSAz
        4waVmcVNNYFoQd0Dky8Q8yPQazYPeVsf/EmDvEg=
X-Google-Smtp-Source: APXvYqzTliON9Pbi5fYbJ+9nATi+o4QKAFEphlHCKisTKdo+riNmYsC0PA9nDJ4mUTFDnrU/W+uOThtetlB7pdZCA6w=
X-Received: by 2002:a92:9c8c:: with SMTP id x12mr301009ill.275.1579035509569;
 Tue, 14 Jan 2020 12:58:29 -0800 (PST)
MIME-Version: 1.0
References: <20191222080759.32035-1-amir73il@gmail.com> <20191222080759.32035-4-amir73il@gmail.com>
 <CAJfpegvqXAc2gH2zeAU3V+cNPujdT4h9gJ8f1m=NaAxUL5iXCw@mail.gmail.com> <CAOQ4uxgsuv47D5oZe69cG2VYKZ-D6dC9h1qNo8z8ssL+qr0aMQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgsuv47D5oZe69cG2VYKZ-D6dC9h1qNo8z8ssL+qr0aMQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 14 Jan 2020 22:58:18 +0200
Message-ID: <CAOQ4uxi2n6TdGM1EbVdd5U1-gp_Gyx5YRuMs9VQjR+dDT8Capw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ovl: generalize the lower_fs[] array
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Jan 13, 2020 at 4:35 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Jan 13, 2020 at 4:30 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Sun, Dec 22, 2019 at 9:08 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > Rename lower_fs[] array to fs[], extend its size by one and use
> > > index fsid (instead of fsid-1) to access the fs[] array.
> > >
> > > Initialize fs[0] with upper fs values. fsid 0 is reserved even with
> > > lower only overlay, so fs[0] remains null in this case.
> > >
> > > This gets rid of special casing upper layer in ovl_map_dev_ino().
> >
> > Okay, but shouldn't this last one (which changes behavior) be split
> > into a separate patch?
> >
>
> Right.
> I should probably mention change of behavior in commit message
> anyway...
>

Turns out this change was a mid-series bug and not intentional.

ofs->fs[0].pseudo_dev was not even initialized at this point in the
series. The last patch in the series in the one changing behavior
of upper layer st_dev.
I fixed up this problem and the other review comments, tested and
and pushed to:

https://github.com/amir73il/linux/commits/ovl-layers-v3

Also rebased branch ovl-ino in case you were going to continue
on to review the next series.

Let me know if you want me to re-post.

Thanks,
Amir.
