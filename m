Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 533D6284E2
	for <lists+linux-unionfs@lfdr.de>; Thu, 23 May 2019 19:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731157AbfEWR0g (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 23 May 2019 13:26:36 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33586 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730957AbfEWR0g (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 23 May 2019 13:26:36 -0400
Received: by mail-yb1-f193.google.com with SMTP id w127so699657yba.0
        for <linux-unionfs@vger.kernel.org>; Thu, 23 May 2019 10:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8q2jzEsSc6uQ5CHLryd1rT2DjWt5/og5dmFsaEhKOBw=;
        b=dcJ1+9phmr9PR/7btyVYehTht4hX2r1J6NYNd33Dk0kkupkKvLqRWNbsoWy5iUlS4Q
         pmn6/VhwoFpokZNRDs1tKn2DL5g92ijv2tXTYfUoVlcL6Vxlf07uq9fdMiGgdX5kl8VQ
         m6kDjf6vMlfyvTo6ET29ItlvpDp78s9QY5WlMuDOgPwQRuUtna4iX5fOAITQxd/n66Nb
         X7MbMk0G7lMXK9GqoNadVIK8oXGhTYiUdgdjpzOo2RflQCHo+coUvMSfguwIyFd8IISH
         Llh6AJfwakwMC7OydsNhH3I9ZrD4i0Bu1+mRwIWCEImO91u8tWcsyo9KGyE/pITLT76i
         qvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8q2jzEsSc6uQ5CHLryd1rT2DjWt5/og5dmFsaEhKOBw=;
        b=eNIIAsXWxtsMVNknMEon1DEXe9+NKB5ZmpQLnU9bcSJEsXby7+ixG4EQGaIwKG+FwI
         zJJVIsu66QeTKrfZEHbjS7kWYWMSl3Tm+9WBIsvyRx8QKfqRAtNrAPz7D1ttEC0wqFMX
         9O0fDF8VPTUKYXB4w+IZPVS7zsXSPKu8QfFFQ3QdWViVVbN9qCaTMgX47HESZ3xfIY9v
         +2FakErSE8f+thnhm29wRv9vr2rHaYChEgQtUFvbFN+rUmPQe2Nz4Hi2EQDsh0sbGCz+
         qAUBLBQx2ksoSuoAJx0PCjHcaQ1g778QrnpxuEcqExEc+IHBBP4XRmCpcvYMEsq/NAdz
         O1eA==
X-Gm-Message-State: APjAAAX36q7cRkq6X+Z1zXFgNUlpPW1A6OOva0mrQ/IL063rWe8DAflQ
        HUXbUwiiGF1L6YuhBVvrrJ/fvyhE70p7nzD2CRY=
X-Google-Smtp-Source: APXvYqzOktYYoHGBS/jnm4SdrR+tJe4CKqq1u+qdn7AbncBOk0eNSqr0Z2WztK8RLAdiQS06VFcyYeVDO4lBQnp4Plw=
X-Received: by 2002:a25:a081:: with SMTP id y1mr19109446ybh.428.1558632395534;
 Thu, 23 May 2019 10:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190523134549.23103-1-chrubis@suse.cz> <CAOQ4uxhHVG9f1njmPgei8-QO4UEivXbxoHkqKi4f50XN6Gup9A@mail.gmail.com>
 <20190523164612.GA11083@fieldses.org>
In-Reply-To: <20190523164612.GA11083@fieldses.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 23 May 2019 20:26:24 +0300
Message-ID: <CAOQ4uxg04H6_3ZsoKZwiVFt3LatjWhT8XWJSiMfFK_tCu5G-ww@mail.gmail.com>
Subject: Re: [LTP] [PATCH] [COMMITTED] syscalls/fcntl33: Fix typo overlapfs -> overlayfs
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, May 23, 2019 at 7:46 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Thu, May 23, 2019 at 06:42:12PM +0300, Amir Goldstein wrote:
> > On Thu, May 23, 2019 at 4:45 PM Cyril Hrubis <chrubis@suse.cz> wrote:
> > >
> > > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > > ---
> > >  testcases/kernel/syscalls/fcntl/fcntl33.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/testcases/kernel/syscalls/fcntl/fcntl33.c b/testcases/kernel/syscalls/fcntl/fcntl33.c
> > > index 43dc5a2af..627823c5c 100644
> > > --- a/testcases/kernel/syscalls/fcntl/fcntl33.c
> > > +++ b/testcases/kernel/syscalls/fcntl/fcntl33.c
> > > @@ -117,7 +117,7 @@ static void do_test(unsigned int i)
> > >         if (TST_RET == -1) {
> > >                 if (type == TST_OVERLAYFS_MAGIC && TST_ERR == EAGAIN) {
> > >                         tst_res(TINFO | TTERRNO,
> > > -                               "fcntl(F_SETLEASE, F_WRLCK) failed on overlapfs as expected");
> > > +                               "fcntl(F_SETLEASE, F_WRLCK) failed on overlayfs as expected");
> >
> > You have 3 more of this typo in fcntl tests.
> >
> > If you ask me, silencing this error seems wrong.
> > While the error is *expected* it is still a broken interface.
> > It may be just a matter of terminology, but I am reading this message as:
> >
> > TEST PASSED: Overlayfs failed as expected
> >
> > While it really should be more along the lines of:
> >
> > TEST SKIPPED: Overlayfs doesn't support write leased
> >
> > Besides, this problem looks quite easy to fix.
> > I think Bruce was already looking at changing the implementation of
> > check_conflicting_open(), so if the test is not failing, nobody is going to
> > nudge for a fix...
>
> Um, I remember that discussion but I can't remember what the obstacles
> were in the end.  Trying to find that thread....
>

i_readcount exists, but its with #ifdef CONFIG_IMA and it counts
only O_RDONLY users.

It wouldn't increase struct inode if we always have i_readcount for
64bit arch.

I think F_WRLCK should require i_readcount == 0 && i_writecount == 1.

Can't remember if and why you needed the readers count?

Thanks,
Amir.
