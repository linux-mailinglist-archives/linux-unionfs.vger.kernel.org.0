Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E67C4A26A
	for <lists+linux-unionfs@lfdr.de>; Tue, 18 Jun 2019 15:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbfFRNgf (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 18 Jun 2019 09:36:35 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43519 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729552AbfFRNga (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 18 Jun 2019 09:36:30 -0400
Received: by mail-yw1-f68.google.com with SMTP id t2so6707681ywe.10
        for <linux-unionfs@vger.kernel.org>; Tue, 18 Jun 2019 06:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sD5fXTT12jECXW04NsW+5gjGQW+RPfY7fMbBzQisftA=;
        b=cLeAUMgJI9tzJP56cXtri+fsiFO+ikwszidYTv1L3MYSQbRXzH+QSFqJv840oow98U
         1Ow257Z38+st8zeSl/RQO2UPI4TRhWoyouPWLVfISq/enzOas3pDPKD7DC2+pnRxWW48
         9/7o37Njhc2ITINw74iCByLvCvMwD1xsPWAp8aaLmP9YqUGP8hR8uoAXTaQR4uCunEp8
         8jiI3wl8ElPF04DLe8PmfPYRSAaQu+RVw+4dTc5dSi8MBS1EiKFgqWBfuQcHCPnwsEV7
         GX2CXM1dPrt7eSXwj0wxHHBsKWnpSSFfJG9V85hF0txvjUKUm/CikTzkowKWnT97CCzM
         Z7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sD5fXTT12jECXW04NsW+5gjGQW+RPfY7fMbBzQisftA=;
        b=eKIGoc9cGbdUcQAlRU5Et1O0XbxM8LunzGwXbWsig0MjBFk4h7FQ7pmQVJtG2xISJR
         bPMdkznO7l5qPViakB/xRxHs8qoMF/uui8cCnyggTE+9WMaAjdOSvVhaz+br8TPCOmTN
         6b2jU96HWw3lCsIdO3RQN93OZDwctu1sjPBZC91yjPFfdLts1WqBfn7VHuoOqMAWfMWB
         WRQZzWKMOfQFLISjC+8yTOj87UaSyJQnKQNHpZ/NcjYUb/5Uu8wNP4ceswjfY918J+Ko
         f9kOjgpNr0XqGF5w41zD9L1UmZTX3rQpBtfi1tHvH2gMzwZFjLjJEyEjhHYmdAwg/h6F
         lBsA==
X-Gm-Message-State: APjAAAVcgAoAhSOhubKKJ8ygKicJMJP7Ugrbuj6wejSY52FUgdVEpy+T
        inySs5IJt8skX6OoDgEA/UpupkDORTejDFTn0yc=
X-Google-Smtp-Source: APXvYqzmonPPn93rsJeaKIwaOyNFYxhH7hYR2gBQI5c3h4Wg84QYFRVHvY7WOLr7UAJ+3TBnOSlmaima4FRO6K+Dak4=
X-Received: by 2002:a81:3956:: with SMTP id g83mr64431835ywa.183.1560864989393;
 Tue, 18 Jun 2019 06:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190609160344.24979-1-amir73il@gmail.com> <CAJfpegt4QXGC0-y_sug7kuFo2q28c6DFJQnQ-UHe1bmCGC0jag@mail.gmail.com>
In-Reply-To: <CAJfpegt4QXGC0-y_sug7kuFo2q28c6DFJQnQ-UHe1bmCGC0jag@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 18 Jun 2019 16:36:18 +0300
Message-ID: <CAOQ4uxi2HANUnep5JQV5=kTTPFmCgnqgBMYcLdvgFPnC9Z3Osg@mail.gmail.com>
Subject: Re: [PATCH] ovl: make i_ino consistent with st_ino in more cases
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Jun 11, 2019 at 4:58 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Sun, Jun 9, 2019 at 6:03 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Relax the condition that overlayfs supports nfs export, to require
> > that i_ino is consistent with st_ino/d_ino.
> >
> > It is enough to require that st_ino and d_ino are consistent.
>
> Yes.
>
> >
> > This fixes the failure of xfstest generic/504, due to mismatch of
> > st_ino to inode number in the output of /proc/locks.
> >
> > Fixes: 12574a9f4c9c ("ovl: consistent i_ino for non-samefs with xino")
> > Cc: <stable@vger.kernel.org> # v4.19
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Miklos,
> >
> > TBH, I can't remember why I put the s_export_op condition in the
> > first place (can you?), expect for the fact the original bug fix
> > was reported on nfsd readdirplus.
>
> I have no recollection of any issue that would require nfs export.
>
> I've applied the patch.
>

Forgot to apply to overlayfs-next or intentionally left for 5.3?

Thanks,
Amir.
