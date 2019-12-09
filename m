Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0EB7117219
	for <lists+linux-unionfs@lfdr.de>; Mon,  9 Dec 2019 17:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfLIQrZ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 9 Dec 2019 11:47:25 -0500
Received: from mail-yb1-f181.google.com ([209.85.219.181]:37051 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIQrZ (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 9 Dec 2019 11:47:25 -0500
Received: by mail-yb1-f181.google.com with SMTP id x139so6373355ybe.4
        for <linux-unionfs@vger.kernel.org>; Mon, 09 Dec 2019 08:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PAnzjF99bokYDYnkHeI9d+39/H2eh9Ynn+lRcscNLuQ=;
        b=WAT1WRyRklQrbbkI0yZINdehI5TGGiPwDkQeuJw7WVJo2xjRZ+JQP4ftcl/42Xg4U+
         bFe/ma76mMQpEbH072k3EPkqPco4sr566ch9yYmcAQLy5Xgk07qoKa5TQtBbynKor8vQ
         JULU1plPt/nVciLi9uwS5eVEB7lrT4Pu98i+8zcjjovYHk/rJoyrcy++3WyszQgV9m6l
         A3BjF2jHqDzvzXLX50JaPIxE7OAMiesdoS3tx0j6G3u3odhSdSA80jJAB6hrM6BGW4+F
         ZM4BO372wCph/u3rY1OdwKPReeGC9ixrOwR1iV5fXCrDFe2OgvsGZ/ST67KoGhTt3hj7
         Frrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PAnzjF99bokYDYnkHeI9d+39/H2eh9Ynn+lRcscNLuQ=;
        b=XPJh53s0oTnMWsJ0+bWeFCPHjW5NcxXW+0beCadp6Tz5QIIpQhPs4T/VMmmW/lbknc
         N4k6dzo5pq23xQMACw1UaMvMF8/mkkzCqvf3uE2WzBPv7XRB0rXiVCfAGlsQLrFCLws3
         dspJ61ZA+axNLvuOGQUZobCCmYd4MN3KjZvZkd0E1g/rMjUyTWAuyNiZtEFtsrTSFnkU
         trPlAeOp+KDrbwW1BVC8/OYqKyflycas+LADsJd7PfSS6geepDLiniAqPYRFiThIOe4b
         mBOMBRZqXqE6m3AyZjtWXjQTKWHd22jp6Nmn5Ya0Fi5nzjcj9iP6mViI7xkZBIkhboYQ
         trgg==
X-Gm-Message-State: APjAAAXJY9pObgEPcU846PbStyjSPN9QPJbMoAQF5mfAeK/DB9Bl1XKr
        PwyQMGARcN3aAX+cLIm7t0gk9zgu+UiFIaITuWb1YBeo
X-Google-Smtp-Source: APXvYqxRbsVutFKaikr2yzZn71OFzCZ9Z4pB8SsTHXzA6cYavVEF/gSMu7ALlieoddhPs5TfBN3+28lN7euBwh1zap8=
X-Received: by 2002:a25:240a:: with SMTP id k10mr19568683ybk.132.1575910044139;
 Mon, 09 Dec 2019 08:47:24 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxh7fszXGXV0U5K4yz4o3WwDk40LmOi+dH2Nwi+yq_5+Pw@mail.gmail.com>
 <CAJfpegv8sN=XB5ePnEiz3KfVhHhyNmYWW8C-bckaxeYiQ0Ee-g@mail.gmail.com>
In-Reply-To: <CAJfpegv8sN=XB5ePnEiz3KfVhHhyNmYWW8C-bckaxeYiQ0Ee-g@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 9 Dec 2019 18:47:12 +0200
Message-ID: <CAOQ4uxir4WC_atq6r-zpRr+m7+c3t7HcVBsaMYM+5xWbKzUXrw@mail.gmail.com>
Subject: Re: Overlayfs fixes queue
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Dec 9, 2019 at 4:57 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, Dec 2, 2019 at 7:32 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Hi Miklos,
> >
> > Will you have time to queue some of the queued fixed [1] and docs .rst
> > conversion [2] for 5.5, maybe rc2?
> >
> > The timestamp limits issue is also being addressed by Deepa in vfs as
> > you suggested, so not critical but nice to have.
> >
> > I posted an xfstest [3] that demonstrates the corner case of
> > non-unique st_dev;st_ino (v4.17 regression).
>
> Hi Amir,
>
> I'm going though your queue, hoping to finish it for -rc2.
>

OK. for the record, following patch was added to branch
since I posted the summary:

* 4d85701cda95 - ovl: relax WARN_ON() on rename to self

Thanks,
Amir.
