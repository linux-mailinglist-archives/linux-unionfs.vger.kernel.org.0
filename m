Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DD71B39FE
	for <lists+linux-unionfs@lfdr.de>; Wed, 22 Apr 2020 10:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgDVI00 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 22 Apr 2020 04:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725811AbgDVI00 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 22 Apr 2020 04:26:26 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD778C03C1A6
        for <linux-unionfs@vger.kernel.org>; Wed, 22 Apr 2020 01:26:25 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id rh22so1182395ejb.12
        for <linux-unionfs@vger.kernel.org>; Wed, 22 Apr 2020 01:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4LrzmEfDmYPqjsOFaHEn0OnO9/NfWVRHGF7viTuzENI=;
        b=BKQPv3HaDT1HLVSieV2gB4b7nmTumUmU9NxMdsg6musLt/3Xbc+LEJk5WdqlfJpGoK
         u0+sb+6i9g6mxfnC6Ka4/5LhOqukBYRAX99UekIzncQiidthVzQH8pcVaT8KUKkJe5+2
         v/IbKNxICewWMhe2Daz/67Gn7xosU2N5+aKTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4LrzmEfDmYPqjsOFaHEn0OnO9/NfWVRHGF7viTuzENI=;
        b=ABu0j+shoRF6EUbsoRcEr9Jt3DZFuTgV0p72CReS8/H15qLqjJDqSXiSNIuLPa1zOi
         rrSbzo2XqIguUpGbZEkb2R21w34+O+/gl9H6xqO/ZGboVPwrMjWvNn6UWqHUMvx/DrTy
         uunowx2aeg99PZ4/p4W+d99ZQcZ7UlQZ1jtLWqdE0YnGIiGaqC4TwKR2dlmx1UOaxyLk
         Hns/HaiErFCAfLhwusmERVFX5sy+B+E/5NMR25B2ASLmmhL6cE61h9oI5IN34ErvWeFy
         5nFRvIGJ4rkdyUNPPpBBLawEjzbpHk5kDcLYXAbR5Zkt4VJdsw/PV52opNIvShE2RfvD
         A9wg==
X-Gm-Message-State: AGi0PuYwIHzt643ROrkoVYw6VM6ls//JCD34foLQCrlfWSCzUf3nzVwt
        +J4LYademXuIUe0AbPX9hrcgaFK1Tf5MI1Hjpk0HJ8as
X-Google-Smtp-Source: APiQypIPIg/g1wzvncWk3txef4/7ZmEIWnR9SDsF1OjsiQ/hYvfTeJnEpkjAeQwugOJj+hT4Hbwx7tt4BFLUfJEMq1M=
X-Received: by 2002:a17:906:3399:: with SMTP id v25mr24182585eja.217.1587543983617;
 Wed, 22 Apr 2020 01:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200422042843.4881-1-cgxu519@mykernel.net> <CAJfpegu_t7Zdu2p64aJJ=W=+A6DTddszshk-ODiDjLqWqEwXaQ@mail.gmail.com>
 <171a0f2ccf8.efa2ca517201.9030529562121260568@mykernel.net>
In-Reply-To: <171a0f2ccf8.efa2ca517201.9030529562121260568@mykernel.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 22 Apr 2020 10:26:12 +0200
Message-ID: <CAJfpeguqT2Wxm5df36yaTh4JL1oz2qj4r-Eb9-rCCqRhq0OAXA@mail.gmail.com>
Subject: Re: [PATCH] ovl: sync dirty data when remounting to ro mode
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Apr 22, 2020 at 10:13 AM Chengguang Xu <cgxu519@mykernel.net> wrote=
:
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2020-04-22 15:29:33 Miklos S=
zeredi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
>  > On Wed, Apr 22, 2020 at 6:29 AM Chengguang Xu <cgxu519@mykernel.net> w=
rote:
>  > >
>  > > sync_filesystem() does not sync dirty data for readonly
>  > > filesystem during umount, so before changing to readonly
>  > > filesystem we should sync dirty data for data integrity.
>  >
>  > Isn't the same true for ->put_super()?
>  >
>
> Before getting into ->put_super(),  dirty data have been synced through b=
elow functions,
> so I think we don't have to worry about ->put_super().
>
> kill_anon_super()
>   generic_shutdown_super()
>      sync_filesystem()

Okay, makes sense.

Thanks,
Miklos
