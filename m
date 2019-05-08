Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03AF2176CC
	for <lists+linux-unionfs@lfdr.de>; Wed,  8 May 2019 13:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfEHL1C (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 8 May 2019 07:27:02 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35828 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfEHL1C (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 8 May 2019 07:27:02 -0400
Received: by mail-it1-f196.google.com with SMTP id u186so3268633ith.0
        for <linux-unionfs@vger.kernel.org>; Wed, 08 May 2019 04:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m4TEm2skSj4947XMPfB6vnL2eENK8AcN/WhnnQcwm58=;
        b=Is96315/VY3hTi2tKBVQYbu9MwWfcLQ0EtsUVG6WmwK1fqcGNVy0ShzEqPg64scLmd
         0p4EletYzpj3KZJX0RQf4MT6h/91M0l2iVX8XgzfgNrhBd60Zg3ijQS3TvT1MRVOIinO
         Dbj3qDNWx0jJ1F+kIncCPTMZBAUi8DEu02Q28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4TEm2skSj4947XMPfB6vnL2eENK8AcN/WhnnQcwm58=;
        b=XHjSJaIDHMfXyzywZWUy1tTVZ46R/uX6LsupGzBHEiUerJdjWPBa5RAIG7aKJg9da8
         jQW7sPyIC4oCcarl7hlU6a78/teii2r+YdIaJXmySzJOy0BZLkyxhZxZhEkL9k3lgN2d
         TYB6aPtTiGD0OdXSWq+7yLvy2BR88fIbOYINcWDbQve1LfU58ccpdqht7upZZ2j8MrH/
         NBH98cF/UUVK7OGnywFnEEuHjkMkTxxCWf3r1OHJb0oEW/BLIB+1s0LDEXx/433WDKjY
         tjqcubJbmK1H0VA8DZHOAvJACWH6wn9sC0aUV9VJ18+VBIcuqZvQuuRRtff0hMcVmdkn
         zpfQ==
X-Gm-Message-State: APjAAAVBNujt0KlDxDpCcZXcTY+1Plm/QbeXUDeg8FxNUf/Rwxd2PU9Z
        Xappz+5vgMf8dKhnRK0Jn6IjsD+s9suyuFZnEcQFZw==
X-Google-Smtp-Source: APXvYqw0XJOCSaCItdGDHrLBZXXYQmQGvOQvJavfyBntffU62/f9I88IvMRSR9wbo8OtCOOQYHCkbgyPyV1r7ZZ8o4o=
X-Received: by 2002:a24:b342:: with SMTP id z2mr2788991iti.121.1557314821381;
 Wed, 08 May 2019 04:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190328153829.729-1-amir73il@gmail.com> <CAJfpegt08nTeDs4+3svOjGAF+mQEP+Dm-amLz9nDWOACqtAUMQ@mail.gmail.com>
 <CAOQ4uxgfuENW7gqsr_Q=Ne8u=PR-oyJ5N6Te9C+L2-14UDK4Cg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgfuENW7gqsr_Q=Ne8u=PR-oyJ5N6Te9C+L2-14UDK4Cg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 8 May 2019 13:26:49 +0200
Message-ID: <CAJfpegvdJqpHyGnqyBq7ayyOj2qe4xoXxPMoNHaEEN5d77pACw@mail.gmail.com>
Subject: Re: [PATCH] ovl: relax WARN_ON() for overlapping layers use case
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, May 8, 2019 at 1:03 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Sat, Mar 30, 2019 at 10:45 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Thu, Mar 28, 2019 at 4:38 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > This nasty little syzbot repro:
> > > https://syzkaller.appspot.com/x/repro.syz?x=12c7a94f400000
> > >
> > > Creates overlay mounts where the same directory is both in upper
> > > and lower layers. Simplified example:
> > >
> > >   mkdir foo work
> > >   mount -t overlay none foo -o"lowerdir=.,upperdir=foo,workdir=work"
> >
> > Shouldn't the mount fail in this case?
> >
> > Does it make any sense to allow overlapping layers?
> >
> > If doing the check the dumb way, the number of d_ancestor() calls
> > would increase quadratically with the number of layers, but I think
> > it's possible to do it in linear time if necessary.
> >
>
> Miklos,
>
> I saw you did not pick this one for next.
> IMO, regardless of preventing mount with overlapping layers,
> the WARN_ON() is inappropriate and this patch that replaces it with
> pr_warn_reatelimited() has merit on its own.
>
> WARN_ON() should reflect a case that we don't think is possible
> in current code and as API constrain assertion.
> Neither is the case here.
> We know that it *is* possible to hit this case, even with checking overlapping
> layers on mount and user does get an error when we hit the case.

Okay.  Picked up this one too.

Thanks,
Miklos
