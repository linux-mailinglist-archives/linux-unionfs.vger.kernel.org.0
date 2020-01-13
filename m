Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8294139307
	for <lists+linux-unionfs@lfdr.de>; Mon, 13 Jan 2020 15:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgAMOEL (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 13 Jan 2020 09:04:11 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:42346 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbgAMOEL (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 13 Jan 2020 09:04:11 -0500
Received: by mail-il1-f195.google.com with SMTP id t2so8228273ilq.9
        for <linux-unionfs@vger.kernel.org>; Mon, 13 Jan 2020 06:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=931cnZcNZgRqM2jlEooTNxwDL4dT4Ia4KTgvtEJlb+Q=;
        b=kbFVdkcq4BnlpfUbxg3E8gUu4r4y7OOqUIo2hwQ2HERNHE+c+IH8rGPO1IDhSi/E1H
         GSMyhIChaW9gn3YlGzmutH/evxs3A/ReKoYQ1uBHnFQ6tAdBduz7iz5GFmY/4AFKvY6o
         WVF2zfDV9EML5rUnQUb4rUZ+OTBDIjHNQ/69xdRtrzos7MtnzDw7IYer3d+ZV/IN9aME
         heN/G9dOikd7ShF0YIhcDSX50wAAVZvCYz7Gl/2oObPQIHZfT92Vusecm4nMDBa/iEMC
         ZbQoKMO7ep6E1/7rZtwiwYK1KZ1ReQ1r58jdWsnEAhU3832OeD1EMYqJvhD6UMz7+ZL4
         0kVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=931cnZcNZgRqM2jlEooTNxwDL4dT4Ia4KTgvtEJlb+Q=;
        b=B5o0vbfrbFL4/qy33qrmdl9Za/qJBHYOmbDE8zSH7XuKmV2Xz4pnH+jkQ2Jw5p6MiR
         A6X9hMgWI5/LKkDd8zFx+E0bfLrnTPM+aKWvBbhDxJoqalCbqV5pFGT7F6LFMIkh2mLF
         ddwK0Zq/TJdHck+jJSlgi17X/wYnZUozkGefdr0V66LMsnOzNWXyCCYPCzZmh329oCOK
         TVdGugR4kCmh5WPt8FUWO47rksWjrK0LyND3SMas/D62CRVDpWahzIn3k9gU6q7tsJRz
         BEaLeQzTJSTF/cHcfNGE8Bl7knSTzlXRNA0RMl4gqoFD8rQal9LD0BKCaFgzomQT1hR4
         ycwA==
X-Gm-Message-State: APjAAAVW8iTRpiWL1mY/15RrQXV58e6M6iRDGbV/zLxiCGynBnZg1oqZ
        5apA9cej2UMDZShXEDD3OQ53wreeH2GOCJnyumk=
X-Google-Smtp-Source: APXvYqyeHH0IMyCDk99KVKxT8wlu/ZIZUZAT7iG4zAHbO8ipZaVMdVs2ST/HSF9hWmk5yaPuWrfMQ2aAaMKYo6OEWHI=
X-Received: by 2002:a92:5c8a:: with SMTP id d10mr15660132ilg.137.1578924241095;
 Mon, 13 Jan 2020 06:04:01 -0800 (PST)
MIME-Version: 1.0
References: <20191222080759.32035-1-amir73il@gmail.com> <20191222080759.32035-2-amir73il@gmail.com>
 <CAJfpegsuNXzS8giOcA=0oKe3Qz9R=50d+9guNSaWvNZxCrksPQ@mail.gmail.com>
In-Reply-To: <CAJfpegsuNXzS8giOcA=0oKe3Qz9R=50d+9guNSaWvNZxCrksPQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 13 Jan 2020 16:03:49 +0200
Message-ID: <CAOQ4uxgf_zY5bk9Vzqjh6iRZqPVA63S8aVt-YmQ-4v7CAP3AYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] ovl: generalize the lower_layers[] array
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Jan 13, 2020 at 12:05 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Sun, Dec 22, 2019 at 9:08 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Rename lower_layers[] array to layers[], extend its size by one
> > and initialize layers[0] with upper layer values.
> > Lower layers are now addressed with index 1..numlower.
> > layers[0] is reserved even with lower only overlay.
> >
> > This gets rid of special casing upper layer in ovl_iterate_real().
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---

> > -                               lower_layer = ovl_layer_lower(dentry);
> > +                               lower_layer = ovl_dentry_layer(dentry);
>
> I find this confusing.   I expected ovl_dentry_layer() to be an
> analogue of ovl_dentry_real(), but it's not: it will return upper
> layer if there's no lower layer, not the other way round.
>
> How about keeping the ovl_layer_lower() helper and open code the new
> behavior at the single point where it would be used?  I can make that
> change if you ACK that I didn't miss anything.

I agree. I noticed this myself and had a mental note to get back to this,
but the mental note got lost.

Thanks,
Amir.
