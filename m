Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 458512967F
	for <lists+linux-unionfs@lfdr.de>; Fri, 24 May 2019 13:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390540AbfEXLDm (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 24 May 2019 07:03:42 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44116 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390374AbfEXLDm (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 24 May 2019 07:03:42 -0400
Received: by mail-yw1-f65.google.com with SMTP id e74so3465137ywe.11
        for <linux-unionfs@vger.kernel.org>; Fri, 24 May 2019 04:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CLTgj+oJJMQrR7FqN4Msv/qfsxP4CDwWBV4suZN4yVU=;
        b=QNQipI1CNnxYU2mm0CUU54/BgcDx2tBAQaJG9BT//jPcEwCaEdV4TWd9ssxXC9wQTf
         jniZOMMqzaQ4ugqAEZg8EH0R4vW7eLmL+yAHF3f+SZq1XRlWWIk+NfdzEL3xIre+w48c
         9QRPRCLZCMkskxzLUILnAvzmtEy713cL6YQPZtR146XyNAxAz+Jk43Wj9ktq+HBUckGx
         3FVLnDoGQteXE+EoO6mj9ULLiAhzWL7gIPNvDqf42dPAK/thVILuWv1zOfl8aVnq7apt
         sD8I1MbouunuLJAVjkQynljjhTWMas4v7CgwlvRCievpu71s0r2yPHJe2nUsqUPgMBDg
         rXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CLTgj+oJJMQrR7FqN4Msv/qfsxP4CDwWBV4suZN4yVU=;
        b=byewnxhUllyiqXrALZptuJ/A59I30MZTbCDVODEXa4ksvZ+Ax1Wsyxug2F1Xhvdwfn
         cnoM7r74plS0+LEhFrNv/4c7wJPFvkK7iTaII7IEcl+EV3QBKD6nImBQO66cCEj77SRT
         0usgf01/oBYHwADWDUTrK2WrZuAXsWkbp78omrKMNwkzuVPHJYvD/XXssvrOd1s/W85v
         UA8Ra/pWHzXNW4pJRXlWOAprp0iyNopKaWxDguCzbjuE9gF3/HvFRVdQRn/CjTlueByr
         5Ssej4rcK2bDip2CDEga/l5NNKeC3TiSvh6/CMCAOGWEadKK4FLIGntzx1XGztKVB5wK
         j+OA==
X-Gm-Message-State: APjAAAWB2DcwFge647k7KtjJNCtqW+dIbDU7fFQJ+qRQvecAtpW7HUTl
        my/u4bJJi692HKU6+oF3MlkVuge6OcUd6N1rsTtiQTtD
X-Google-Smtp-Source: APXvYqxTURix+nIP+PUOK55KnWNxBaHkAbA0X088QxUq9OtQQOwtFIwHaaLXkTYxezTIIglL+g8SW+tGNdZsFPsmUvY=
X-Received: by 2002:a81:9ac7:: with SMTP id r190mr34574631ywg.183.1558695821275;
 Fri, 24 May 2019 04:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190523134549.23103-1-chrubis@suse.cz> <CAOQ4uxhHVG9f1njmPgei8-QO4UEivXbxoHkqKi4f50XN6Gup9A@mail.gmail.com>
 <20190524085947.GA11508@rei.lan>
In-Reply-To: <20190524085947.GA11508@rei.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 24 May 2019 14:03:29 +0300
Message-ID: <CAOQ4uxj3X2Eh+RmzunW1Sb8PWrHWsS1_h-xEH2Bofcr+-S-tiA@mail.gmail.com>
Subject: Re: [LTP] [PATCH] [COMMITTED] syscalls/fcntl33: Fix typo overlapfs -> overlayfs
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     ltp@lists.linux.it, overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Petr Vorel <pvorel@suse.cz>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Fri, May 24, 2019 at 11:59 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
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
>
> Ah, right, I should have done git grep before commiting this. I will fix
> that right away.
>
> > If you ask me, silencing this error seems wrong.
> > While the error is *expected* it is still a broken interface.
> > It may be just a matter of terminology, but I am reading this message as:
> >
> > TEST PASSED: Overlayfs failed as expected
> >
> > While it really should be more along the lines of:
> >
> > TEST SKIPPED: Overlayfs doesn't support write leased
>
> Agreed, I'm always against working around kernel bugs/deficiencies in
> tests, unfortunately that usually conflicts with QA deparenments that
> wants to skip known problems and have everything green. So we usually
> end up somewhere in a middle ground.

But is everything green though?
Does QA department know that if you run samba inside a container
whose storage driver is overlayfs, if samba is configured with
"kernel oplock = yes"
Samba clients would never be able to acquire an oplock and
write performance would be horrible?

Sure, not everyone cares about this case, but seems to be that
silencing the error should be in the hands of the user and that LTP
project should just report the problems as they are.

Worse is the fact that this error will only trigger for people that
configured LTP to test overlayfs specifically, not all LTP users.
This group of users is even more likely to be interested in
bugs/deficiencies of overlayfs.

>
> Also as usuall, do you care enough to send a patch? :-)

No, not yet.
Give me a few days to cook.
When I get to caring enough I will fix the kernel ;-)

>
> > Besides, this problem looks quite easy to fix.
> > I think Bruce was already looking at changing the implementation of
> > check_conflicting_open(), so if the test is not failing, nobody is going to
> > nudge for a fix...
>
> Once it's fixed we can change that to a failure for new enough kernels,
> old ones should probably stay with SKIPPED/TCONF.
>

This too would be wrong practice IMO.
If stable kernel users see that the test passes on mainline and fails
on old kernel, somebody may get the idea to backport the fix to stable kernel
and fix the bug.
IOW, setting min_kver is a tool that should be reserved IMO to situations
where:
1. The interface/functionality does not exist -OR-
2. The maintainers have made it clear that the fix will not be backported

Anyway, just my POV.
I full understand the reasons for the "all green" methodology.

Thanks,
Amir.
