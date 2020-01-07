Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABA81322E7
	for <lists+linux-unionfs@lfdr.de>; Tue,  7 Jan 2020 10:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgAGJss (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 7 Jan 2020 04:48:48 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:43454 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAGJss (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 7 Jan 2020 04:48:48 -0500
Received: by mail-io1-f49.google.com with SMTP id n21so50372963ioo.10
        for <linux-unionfs@vger.kernel.org>; Tue, 07 Jan 2020 01:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vxsENtkttdrDlVFqy8451EmQmwOGREIRsafP+Y6d9Rw=;
        b=CQ2GEfoPljK4ACSdFqwqpW2bA7A7/7WL6m82kkyZoX1dW+I0QiVKmIBFPAjFGIBHSb
         ecbNx/a7fyIAH7YWXG9lWyR3yY7IEPpU1Hcm2MW844YGN/QTfKZ0Gl+Pr6IBTxOtQYMe
         x5/97HY83vFbGVoIDzsE7jQ1xXpRUq6MIzyu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vxsENtkttdrDlVFqy8451EmQmwOGREIRsafP+Y6d9Rw=;
        b=T2dRbziXC6LN3RG8mFMno/ak4mBLBqG9XLx6dexEP0Vlj5/5LyDj5ZamTwVv6ALtin
         t1+pDUxW0qK1qakRiVq8mDjNTvQk5snszU4tDdaqyMm4zwreM0zwk5n3UItiO1NUBfnL
         A/hWhAVygOpRgeU4jxUdzPF6mNNOGqXe4YMLZUHJ+/rt1RtOgC9xL96Q6bypPi3gNUg5
         ft4QMeiHQ5GMavUt0UMv5iv2PZ49CrZBqVeD5xNUERyUKTnkQ/Nqozz5aviQMuhdRi+M
         H+c5nrFaufgQncqJarLkD6sz9+UG6V5qznxzVoiacy59BrOtjpdVHAqQt68UlBIro3fV
         R6Jg==
X-Gm-Message-State: APjAAAUgyEgbTdh/s8QRHQ9dISHo+aOAWafv/UBHkYE5wnurtGdnsGQ4
        ybGqeaQulPyvVDJKpUTihrfdWHwEUOIBz9Tz/0HDqg==
X-Google-Smtp-Source: APXvYqw7bEHSjOfvRImKYJs5czVdJoHMh8j7w/OkuKyXFbkY9RBfhRDuYkiF/2sROKwO4yFIfDBomFWPTDD5mGRUyiU=
X-Received: by 2002:a02:9988:: with SMTP id a8mr84854131jal.33.1578390528072;
 Tue, 07 Jan 2020 01:48:48 -0800 (PST)
MIME-Version: 1.0
References: <7904C889-F0AC-4473-8C02-887EF6593564@intel.com>
 <20200106183500.GA14619@redhat.com> <CAJfpegszhftUxkhaAaF3Gj4u+S5M74RwCrXLTptW=zcKz+_xug@mail.gmail.com>
 <20200106222437.GA141177@eernstworkstation>
In-Reply-To: <20200106222437.GA141177@eernstworkstation>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 Jan 2020 10:48:37 +0100
Message-ID: <CAJfpegt0pB-jJUBEmewRgH6MMmj3__MNzZ9ScitgcEehr51awQ@mail.gmail.com>
Subject: Re: Virtio-fs as upper layer for overlayfs
To:     "Ernst, Eric" <eric.ernst@intel.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>,
        "kata-dev@lists.katacontainers.io" <kata-dev@lists.katacontainers.io>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Jan 6, 2020 at 11:18 PM <eric.ernst@intel.com> wrote:

> Miklos, I'm still learning a bit more about fs implementations, so my
> apologies if this should be obvious. For virtio-fs, one of the use cases
> that is described is sharing memory between two guests (not necessarily
> the Kata use case). I was guessing the dcache would be within the guest,
> and that in at least the shared memory case, there's potential that a
> revalidate may be neccesary, in case any changes are made by the second guest?

Exactly.

> (I could be mixing up the intended use for revalidate, though).
>
> Can you clarify that "not calling ->revalidate() should not be a
> problem?"

I was referring specifically to the overlayfs case.  Overlayfs stacks
on top of some other filesystems, i.e. when ->d_revalidate() is called
on overlayfs it calls ->d_revalidate() on underlying fs.  This only
happens for the lower (read-only) layers, not the upper (read-write)
layer.  So if the underlying upper fs is modified from another guest,
than that modification is not going to be reflected on the overlayfs.
However, overlayfs documents any changes to underlying layers as
resulting in undefined behavior.  It would be strange if docker was
relying on undefined behavior of overlayfs, so not doing the
revalidation should not make a difference.

Thanks,
Miklos
