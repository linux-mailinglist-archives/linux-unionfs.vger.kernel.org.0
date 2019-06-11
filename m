Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71C1C3CBDD
	for <lists+linux-unionfs@lfdr.de>; Tue, 11 Jun 2019 14:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfFKMhr (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 11 Jun 2019 08:37:47 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35979 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfFKMhq (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 11 Jun 2019 08:37:46 -0400
Received: by mail-it1-f195.google.com with SMTP id r135so4449530ith.1
        for <linux-unionfs@vger.kernel.org>; Tue, 11 Jun 2019 05:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+AAca3nvs7dkTK7xSjupMi0Sz4k89iuWn08Vm4X0kgU=;
        b=XabvUwwbGq2n7oxanIO2OT/abwS3IMW1qLCEfBlM94I6tZ5GdJxJXqFam1PjgX6AnM
         FxvCQHUPCLY8HLEdL0YO5o+kJ3u4prBG8mWEWfKoWuubFVJV9t13WlSNTaELAaWBwq8m
         zlZXq08QX16nQip77wpxSJpGT5diPxchEQ5I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+AAca3nvs7dkTK7xSjupMi0Sz4k89iuWn08Vm4X0kgU=;
        b=PuET5MVJW6ZO41fU/Pqco44acpSkhEbczDFtJwiH3DGFC+nHUKp0Tv1IPwg/vvPwn8
         1c0KZsciil2R8zzLpfpIFhht3/bt6zh1wXlAys3nYJ6Tf1HPakMQPcK2MtIaJrZR1Z3T
         HgKi6Atsrq2NRR5TQcvI3p9cTFL3BrEY5VpB/GBFoVLxd5FyQLayyf0U8Yanq5vEOZ94
         Hu8MhMbv+vKLwzrXEsKkHc9ofnn9QDsPmifdHtM1LEFif5lT7RdsldygK0TUUYOjLNxo
         LvNQtvLweJlw8oMQk91Hjp1tu7VjyUVmaTdt4Anpov+JJQhe+FJ0v7p5qRBR4fM5b801
         GVXA==
X-Gm-Message-State: APjAAAVz0Ne8uhM6v64nhVgF4uBLpDlZ5437eGbEs4Zy/RkffHB5NNB5
        VB7RLmwt/S9MbM7L1yI9JWGaaHXQ6u0qhdm0sF7ozg==
X-Google-Smtp-Source: APXvYqxbXZl5+nsTDRdcM4pt11OJ1hYkePs86+nwT+0o1AXIqQg0rSIR+N+mroro4Z3fTTsBRxoiMMUbb6m1q9clM5Q=
X-Received: by 2002:a24:2846:: with SMTP id h67mr18440056ith.94.1560256666225;
 Tue, 11 Jun 2019 05:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190607010431.11868-1-mcoffin13@gmail.com> <20190607205105.21858-1-mcoffin13@gmail.com>
 <CAOQ4uximPqsNivkqD36LdNfT4g41v2rtDm+OB6t2z40dpWs_og@mail.gmail.com>
 <f5b0bddd-678b-bdd9-6fc7-cc9e5b3211e5@gmail.com> <CAOQ4uxjQQcrcpxhtu3kAJvGaK+xd5TfNB=7_UnNciGj990DN6Q@mail.gmail.com>
 <CAJfpegvy-Vfc6AEP7+=VfUtfL4izY8AzgoUdvqP4PHnLDEQhNg@mail.gmail.com>
 <20190610184043.GD25290@redhat.com> <20190610184553.GE25290@redhat.com>
In-Reply-To: <20190610184553.GE25290@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 11 Jun 2019 14:37:34 +0200
Message-ID: <CAJfpegvrOy3yBpu1AVBFyjdXBNM44k4gSqQ0F2npBG8wH8cUeg@mail.gmail.com>
Subject: Re: [PATCH v2] overlay: allow config override of metacopy/redirect defaults
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Matt Coffin <mcoffin13@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Jun 10, 2019 at 8:45 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, Jun 10, 2019 at 02:40:43PM -0400, Vivek Goyal wrote:
> > On Sun, Jun 09, 2019 at 09:14:38PM +0200, Miklos Szeredi wrote:
> > > On Sat, Jun 8, 2019 at 8:47 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > > And then every time that a feature needs to be turned off for some reason
> > > > that also needs to be taken into account.
> > > > IOW, I advise against diving into this mess. You have been warned ;-)
> > >
> > > Also a much more productive direction would be to optimize building
> > > the docker image based on the specific format used by overlayfs for
> > > readirect_dir/metacopy.
> > >
> > > To me it seems like a no-brainer, but I don't know much about docker, so...
> >
> > [ cc Daniel Walsh]
> >
> > Hi Miklos,
> >
> > Can you elaborate a bit more on what docker/container-storoage and do
> > here to expedite image generation with redirect_dir/metacopy enabled.
> >
> > They can't pack these xattrs in image because image will not be portable.
> > It will be overlayfs specific and can't be made to work on target without
> > overlayfs.
>
> Are you referring to apps being able to traverse lower layers and do
> the redirect_dir and metacopy resoltion as kernel does. To me that process
> is not trivial. Having a library might help with adoption though.

AFAICS what happens when generating a layer is to start with a clean
upper layer, do some operations, then save the contents of the upper
layer.  If redirect or metacopy is enabled, then the contents of the
upper layer won't be portable.  So need to do something like this:

traverse(overlay_dir, upper_dir, target_dir)
{
    iterate name for entries in $upper_dir {
        if ($name is non-directory) {
            copy($overlay_dir/$name, $target_dir/$name)
        } else if ($name is redirect) {
            copy-recursive($overlay_dir/$name, $target_dir/$name)
        } else {
            copy($overlay_dir/$name, $target_dir/$name)
            traverse($overlay_dir/$name, $upper_dir/$name, $target_dir/$name)
        }
    }
}

Basically: traverse the *upper layer* but copy files and directories
from the *overlay*.  Does that make sense?

Thanks,
Miklos
