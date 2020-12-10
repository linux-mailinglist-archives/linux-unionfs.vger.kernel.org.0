Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAC72D5F7A
	for <lists+linux-unionfs@lfdr.de>; Thu, 10 Dec 2020 16:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389830AbgLJPUh (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 10 Dec 2020 10:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391680AbgLJPTX (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 10 Dec 2020 10:19:23 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA777C061794
        for <linux-unionfs@vger.kernel.org>; Thu, 10 Dec 2020 07:18:42 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id s23so1795364uaq.10
        for <linux-unionfs@vger.kernel.org>; Thu, 10 Dec 2020 07:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3HoxVeTcWA5htpeSp9SI0dpd34NYlZHs8NPHZQ2aqk=;
        b=T7Om6Dz30zjXwo1e3DzgDWXQhnNLsemk4NEGSyXJmQ5kiU3HRAbTfsV26RQ1UYys6W
         y/tqwGLAgNEebP63abkpvwOu2RYxIOPjqyyxuP2icvCDKprQz8lzYHv4pEegw4T/pSGk
         pv8LxMq6idiz77wBNzyo2zONXJtoQwzG+Hpxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3HoxVeTcWA5htpeSp9SI0dpd34NYlZHs8NPHZQ2aqk=;
        b=uoInIFrsajtTinJZviTjoKVJZY9/AaO7RyZScPJ9sBAw6Ekqa7h51sHIfRNYqThILc
         jfdLRhncxw4Ukqm64qIxOYcaBjMLPx2Y0O+TvKewLPHQ0GAs9aSbJVA2ByUGph6DmBc7
         MXAqUzUKI0SjEHyu3HpyCHfBVl+KBuT4Nb2ZKxDhKEoMfxNvN0yeJoxLatjR4jy0ndjG
         1U1oCUb2xaJbBF0i2EZh6ZwdhUSgmi/iqCzlJd9K1N3mCGKhwu5F0JLh7x6uG4KdWtFV
         jCXfcAIO0BebxTKDGi/6j4qqpv4eLIOEapuSrduj4OEMy5VZXdLmFXiNl3D5F+++ArkO
         ah7Q==
X-Gm-Message-State: AOAM531oH2CilxnY++TxESarLmO+mFBwtT5fFaIl+dcYefU2gTDabboj
        otWiHm2tn8vbZWWrnZlgGp+LktH8g35Je/Emmcfk+w==
X-Google-Smtp-Source: ABdhPJwnd+Q5OcwZ6kj3dLXkISS+sHMAcbDer9WLC1AifyTnZn7dV2SHai20UFYdvGjl9MbsKgdCtxhsvjEvdP+K1wY=
X-Received: by 2002:a9f:3012:: with SMTP id h18mr8283428uab.11.1607613521839;
 Thu, 10 Dec 2020 07:18:41 -0800 (PST)
MIME-Version: 1.0
References: <20201207163255.564116-1-mszeredi@redhat.com> <20201207163255.564116-5-mszeredi@redhat.com>
 <CAOQ4uxhv+33nVxNQmZtf-uzZN0gMXBaDoiJYm88cWwa1fRQTTg@mail.gmail.com>
In-Reply-To: <CAOQ4uxhv+33nVxNQmZtf-uzZN0gMXBaDoiJYm88cWwa1fRQTTg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 10 Dec 2020 16:18:30 +0100
Message-ID: <CAJfpegsxku5D+08F6SUixQUfF6eDVm+o2pu6feLooq==ye0GDg@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] ovl: make ioctl() safe
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Dec 8, 2020 at 12:15 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Dec 7, 2020 at 6:36 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
> >
> > ovl_ioctl_set_flags() does a capability check using flags, but then the
> > real ioctl double-fetches flags and uses potentially different value.
> >
> > The "Check the capability before cred override" comment misleading: user
> > can skip this check by presenting benign flags first and then overwriting
> > them to non-benign flags.
> >
> > Just remove the cred override for now, hoping this doesn't cause a
> > regression.
> >
> > The proper solution is to create a new setxflags i_op (patches are in the
> > works).
> >
> > Xfstests don't show a regression.
> >
> > Reported-by: Dmitry Vyukov <dvyukov@google.com>
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>
> Looks reasonable
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>
> > ---
> >  fs/overlayfs/file.c | 75 ++-------------------------------------------
> >  1 file changed, 3 insertions(+), 72 deletions(-)
> >
> > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > index efccb7c1f9bc..3cd1590f2030 100644
> > --- a/fs/overlayfs/file.c
> > +++ b/fs/overlayfs/file.c
> > @@ -541,46 +541,26 @@ static long ovl_real_ioctl(struct file *file, unsigned int cmd,
> >                            unsigned long arg)
> >  {
> >         struct fd real;
> > -       const struct cred *old_cred;
> >         long ret;
> >
> >         ret = ovl_real_fdget(file, &real);
> >         if (ret)
> >                 return ret;
> >
> > -       old_cred = ovl_override_creds(file_inode(file)->i_sb);
> >         ret = security_file_ioctl(real.file, cmd, arg);
> >         if (!ret)
> >                 ret = vfs_ioctl(real.file, cmd, arg);
> > -       revert_creds(old_cred);
> >
> >         fdput(real);
> >
> >         return ret;
> >  }
> >
>
>
> I wonder if we shouldn't leave a comment behind to explain
> that no override is intentional.

Comment added.

> I also wonder if "Permission model" sections shouldn't be saying
> something about ioctl() (current task checks only)? or we just treat
> this is a breakage of the permission model that needs to be fixed?

This is a breakage of the permission model.  But I don't think this is
a serious breakage, or one that actually matters.

Not sure which is better: adding exceptions to the model or applying
the model in situations where it's unnecessary.  I'd rather go with
the latter, but clearly in this case that was the wrong decision.

Thanks,
Miklos
