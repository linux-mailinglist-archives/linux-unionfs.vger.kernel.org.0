Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E64A8FCA08
	for <lists+linux-unionfs@lfdr.de>; Thu, 14 Nov 2019 16:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfKNPha (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 14 Nov 2019 10:37:30 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40799 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKNPha (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 14 Nov 2019 10:37:30 -0500
Received: by mail-io1-f68.google.com with SMTP id p6so7249499iod.7
        for <linux-unionfs@vger.kernel.org>; Thu, 14 Nov 2019 07:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ik2QPcY3BYCfa0MQAyReN6/fOyeG4H8aydWoIfeiFRY=;
        b=fTvqlHWsZQDIK2GyerKHBwgtfpQAKh/wtLVJoadFkpdZrIpkSrhlvd86vYCm18vs0z
         NpYjz+YByzIaXLXhpormeBpxb3hNbCirGsiKENMbJFYngesxR5NrA6tFcbrrOCpbkIwA
         1EEGVEgz+VUtog7y2BocnNUr0FAbrkzSiGbdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ik2QPcY3BYCfa0MQAyReN6/fOyeG4H8aydWoIfeiFRY=;
        b=AhgNnPIu2ODd+lhxuI9rerDXxHHTlS848zVCHMQoGXPSlDu9G03gLkgXCGysddx/lj
         H7F4Gu7OuOAfU22aAjCYM7uD52WmErPskIcfl0j5HoQYN7F09e1VmCpn4gfR9rxBxBb5
         AnHahDUVFlnDlIpW8HunzDF7148sY8+zLmH9ifEgoCSs2+vU3tKI+IbNCsqchBqVR4K4
         krZGlmklAgMyAONJvzBibfrxHL2If0cUZ5lukeO5NLEfx9WKy6I4ClDsJevoePARPr8u
         xqTXRcfibYfPdAxf4StAiJzShmXjlk/HvTT2CNWHtv8lKwpAzK7LwaeKMVJSeXsi4YBH
         Fyyw==
X-Gm-Message-State: APjAAAWmlHFbdXpkhARsQfuybhOvdMAl2EjvZSUpp1Tm+kbcqAMGFJnc
        6qWKRF/3Lzp0u3HpPEitjUbbwf8MBMCAx4kAJFraj4CK
X-Google-Smtp-Source: APXvYqyr8938NcGeqVTFkZxhcbLap8X2n5hHy/codIajFJc5Ys6sxBaAs35GhxBULIhoIzGlqj56jyyV7GU8KeVgW04=
X-Received: by 2002:a6b:3bca:: with SMTP id i193mr7568923ioa.285.1573745849024;
 Thu, 14 Nov 2019 07:37:29 -0800 (PST)
MIME-Version: 1.0
References: <20191113200651.114606-1-colin.king@canonical.com>
 <CAJfpegug-saOEigqDNKfwMR5qdzrbLnRBD=0eN5juGioFH_L_Q@mail.gmail.com> <CAOQ4uxgf5KAq7VoHVNVUD9QtA7Y++-_TdwOe6=icHLgJvyrg1A@mail.gmail.com>
In-Reply-To: <CAOQ4uxgf5KAq7VoHVNVUD9QtA7Y++-_TdwOe6=icHLgJvyrg1A@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 14 Nov 2019 16:37:17 +0100
Message-ID: <CAJfpegufS=OGcvFbWEVumNSCPO_JXyEuJNAbmO5ubscSarVtRQ@mail.gmail.com>
Subject: Re: [PATCH][V4] ovl: fix lookup failure on multi lower squashfs
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Colin King <colin.king@canonical.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, Nov 14, 2019 at 3:43 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Nov 14, 2019 at 12:30 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Wed, Nov 13, 2019 at 9:06 PM Colin King <colin.king@canonical.com> wrote:
> > >
> > > From: Amir Goldstein <amir73il@gmail.com>
> > >
> > > In the past, overlayfs required that lower fs have non null
> > > uuid in order to support nfs export and decode copy up origin file handles.
> > >
> > > Commit 9df085f3c9a2 ("ovl: relax requirement for non null uuid of
> > > lower fs") relaxed this requirement for nfs export support, as long
> > > as uuid (even if null) is unique among all lower fs.
> >
> > I see another corner case:
> >
> > n- two filesystems, A and B, both have null uuid
> >  - upper layer is on A
> >  - lower layer 1 is also on A
> >  - lower layer 2 is on B
> >
> > In this case bad_uuid won't be set for B, because the check only
> > involves the list of lower fs.  Hence we'll try to decode a layer 2
> > origin on layer 1 and fail.
>
> Right.
>
> >
> > Can we fix this without special casing lower layer fsid == 0 in
> > various places?  I guess that involves using lower_fs[0] for the
> > fsid=0 case (i.e. index lower_fs by fsid, rather than (fsid -1)).
> > Probably warrants a separate patch.
> >
>
> I guess we should.
> I do hate that special casing.
> I can work of that, but would you like to hold back this patch now?
> Or just fix that corner case later?

Okay, let's fix the main case first, then the corner case...

Thanks,
Miklos
