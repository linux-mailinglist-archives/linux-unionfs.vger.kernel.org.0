Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D56121393C1
	for <lists+linux-unionfs@lfdr.de>; Mon, 13 Jan 2020 15:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgAMOfR (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 13 Jan 2020 09:35:17 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44743 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgAMOfQ (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 13 Jan 2020 09:35:16 -0500
Received: by mail-io1-f67.google.com with SMTP id b10so9974404iof.11
        for <linux-unionfs@vger.kernel.org>; Mon, 13 Jan 2020 06:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d3VbmXmP7PCzYxXtGO0DEPiWKgqYYa7a7L19AGsPTuA=;
        b=k88oO47piEIGwpIIdq+IfToKlmclXD2ndmFRmT7iElKmSAoXJzi0PcTpaicQy8Aw6h
         80EgDgmyvTyhBa0Q7oG7E+t8ZoykvEAFYWgjAmpbxV/k2TVPA/4I686B72RYucWvoGtk
         K0fRdakkK0tymRT5djXjqjP5D3spLwmNV8eqplj5S+D58o2Fsb0vY6F5IGxcXQnKWEy8
         D13tvgqLmL6J+P59IwpaziCXF31HSRfjqBntGhsT2RPPf5of9dBH0TCAOQiU9V4UIryp
         Ebk/0VY7Td44Xkg9ANJ1rDPuo4vjFAlg4zwJwAkwZsd9P/c/lbOLizxlnw4ZeSBx22cl
         wW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d3VbmXmP7PCzYxXtGO0DEPiWKgqYYa7a7L19AGsPTuA=;
        b=I5yoAX52bq5C4BPPHX+s2K5P7pVcLvYDoUEUaNEPk4rXhNIFyHoyQ550OOZPW75Z3Q
         vsdWosc2887HbOsLCx5Dl5UStwcJP/xi/cwHUNXJNZxroov8VV/zHUZ+26Ve141KMEOj
         a4W4lNeD+wl+6z/5aEitviTCdKKMefkOMpwb3XIPL8/ePNPjKGLNURGr1GrAXyevULw/
         WLdY696liLXWzdnaNytCxnLchOOM97w5s58oZu1y7Zab2KGf+wTup1y2tFew55rqqrE0
         rzwCDvJLoEcaOUwpUsw0GH/WkCtQx7wEgPjgwS6PY9pMNtZeEp8GBNmVeVHv5FXhfc91
         BdoA==
X-Gm-Message-State: APjAAAWtZBhNQ8OVhOEbe7krdfcw5GX8uD2yrp2wZbtciEf1cmL7rA/E
        OKXdPoqGfJb3Wa2XhhLpqKpfwh1/ojFdS/qCZCxvvg==
X-Google-Smtp-Source: APXvYqzEmG8TrXC3MYQCerDiE0oonHEzJSWCnpxrIaKi34kgVLBw0j4BXwMy5PLSp2m23obEufBL6TVXx9oL49oogHY=
X-Received: by 2002:a5e:9907:: with SMTP id t7mr12965901ioj.72.1578926116023;
 Mon, 13 Jan 2020 06:35:16 -0800 (PST)
MIME-Version: 1.0
References: <20191222080759.32035-1-amir73il@gmail.com> <20191222080759.32035-4-amir73il@gmail.com>
 <CAJfpegvqXAc2gH2zeAU3V+cNPujdT4h9gJ8f1m=NaAxUL5iXCw@mail.gmail.com>
In-Reply-To: <CAJfpegvqXAc2gH2zeAU3V+cNPujdT4h9gJ8f1m=NaAxUL5iXCw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 13 Jan 2020 16:35:05 +0200
Message-ID: <CAOQ4uxgsuv47D5oZe69cG2VYKZ-D6dC9h1qNo8z8ssL+qr0aMQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ovl: generalize the lower_fs[] array
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Jan 13, 2020 at 4:30 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Sun, Dec 22, 2019 at 9:08 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Rename lower_fs[] array to fs[], extend its size by one and use
> > index fsid (instead of fsid-1) to access the fs[] array.
> >
> > Initialize fs[0] with upper fs values. fsid 0 is reserved even with
> > lower only overlay, so fs[0] remains null in this case.
> >
> > This gets rid of special casing upper layer in ovl_map_dev_ino().
>
> Okay, but shouldn't this last one (which changes behavior) be split
> into a separate patch?
>

Right.
I should probably mention change of behavior in commit message
anyway...

Thanks,
Amir.
