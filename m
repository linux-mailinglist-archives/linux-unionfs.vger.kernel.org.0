Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E79D4B28E
	for <lists+linux-unionfs@lfdr.de>; Wed, 19 Jun 2019 09:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbfFSHDT (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 19 Jun 2019 03:03:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41092 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730826AbfFSHDS (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 19 Jun 2019 03:03:18 -0400
Received: by mail-io1-f66.google.com with SMTP id w25so35704358ioc.8
        for <linux-unionfs@vger.kernel.org>; Wed, 19 Jun 2019 00:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARuZEo6u7w+8GlCsjJmjBlF7JPwsvDeIzhN5j/K48V0=;
        b=hcWZtqtvEVZqlKAYxhEC/nXTYZ6IoePbeqAPOisO7ypFEV+bWD2C2v8saPijMbE5Ma
         eentYPTjPh6cQ7BcsQUumT8b/9+sDRPVNW6QQRyH9Rw+BvIujpgPyVVUcN5bglUHiDWD
         q/IUqRzdTRBlNGjy6q8vHMh0lsK6d98Azto9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARuZEo6u7w+8GlCsjJmjBlF7JPwsvDeIzhN5j/K48V0=;
        b=fNE/Nhs7zlNqLip2BQKbf5ohX45fhDVAms8TD+aIjd1mAQmR6a8+ITGTaspcBLxyd2
         3O5w813/dPcZrUy+re2W6dZ6Jz7Q4f4YnpuaPvuNGpfS71y8XZ6quKQ/gTXkFI1mtkeY
         FcoXu12vs5zD88pPVpSiYJf1kVJFdvlt2N89zO+Jo0pjRWUd8KYn9IzsVwyZbVknefPD
         FggnM2fEBLUCQWo5ZHYSWqBoEUjCAiljzsKgzjw+yh+kSOcj+oC3m2EAqSJDC8Ir2vh5
         tU8N1J7YfBLxpdnQv9yt2dgsQjU0VgY0SIpFUXYl4pN5Iy9kWw2mp6j2P+dH5cdSol8J
         A5Jg==
X-Gm-Message-State: APjAAAXL//scC8HbFkJ7zCEZmY+3sOX2PagSAinNVTIsFXuljfu2zAhx
        HrUei44HYomQhHKC9YhusTx3nYLV70+HJpUukDg+oQ==
X-Google-Smtp-Source: APXvYqxxll743jkU9T6Uphs2fuHWjnPwiax6mVi9MJjCMrHhg25ffsF2rB4Xvdlke6aFoBGxHwFmyYbY/CdiMB3Jryo=
X-Received: by 2002:a5e:8618:: with SMTP id z24mr10673126ioj.174.1560927798169;
 Wed, 19 Jun 2019 00:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190609160344.24979-1-amir73il@gmail.com> <CAJfpegt4QXGC0-y_sug7kuFo2q28c6DFJQnQ-UHe1bmCGC0jag@mail.gmail.com>
 <CAOQ4uxi2HANUnep5JQV5=kTTPFmCgnqgBMYcLdvgFPnC9Z3Osg@mail.gmail.com>
In-Reply-To: <CAOQ4uxi2HANUnep5JQV5=kTTPFmCgnqgBMYcLdvgFPnC9Z3Osg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 19 Jun 2019 09:03:07 +0200
Message-ID: <CAJfpegsrFJk3BjG2Jy4FeLY2=ykBNGz-Qnd=mdCBARYSxrz1vQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: make i_ino consistent with st_ino in more cases
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Jun 18, 2019 at 3:36 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Jun 11, 2019 at 4:58 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Sun, Jun 9, 2019 at 6:03 PM Amir Goldstein <amir73il@gmail.com> wrote:

> > > TBH, I can't remember why I put the s_export_op condition in the
> > > first place (can you?), expect for the fact the original bug fix
> > > was reported on nfsd readdirplus.
> >
> > I have no recollection of any issue that would require nfs export.
> >
> > I've applied the patch.
> >
>
> Forgot to apply to overlayfs-next or intentionally left for 5.3?

Safer to leave it to 5.3 since this is not a recent regression and the
only reporter is xfstests.

Thanks,
Miklos
