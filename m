Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E02C21F5D8
	for <lists+linux-unionfs@lfdr.de>; Tue, 14 Jul 2020 17:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgGNPJI (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 14 Jul 2020 11:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgGNPJH (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 14 Jul 2020 11:09:07 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98192C061755
        for <linux-unionfs@vger.kernel.org>; Tue, 14 Jul 2020 08:09:07 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id h28so17604032edz.0
        for <linux-unionfs@vger.kernel.org>; Tue, 14 Jul 2020 08:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KV1xFssAiiub0yfoqGaJskxNUVXvez/GbZOoZmrb+Iw=;
        b=KPDBCXkBoKRbTkRIaGTXZv9f0PWjOpwiZaYJQdbVCW93pbKg17nS/B/n4IVQmOLPFb
         LwRJJpTazkYkF6sVBw9Tkca1vyd6Gt7eICZ/rxF98jVAfwCgl2DoMz2ByabjnJDyWuSb
         jsWDoBkmQmiHKXeLj4v5Wo7PPBQOMivXHHe/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KV1xFssAiiub0yfoqGaJskxNUVXvez/GbZOoZmrb+Iw=;
        b=JZsQwkydsosbMb9bthR3jsDhuYk6ECHpDIlpwbt+yqVb+TZW/zkPiJt7rFLb0LXUrs
         slUmT8NUUo7dFcE1di1K9ROBXLJ5jzk84/tN69IL7h6K2FgObcJ3WdPDECfCImmQIzep
         W2cVT76vEEO7KjEm8NVbhQSBky90H8oWaS8499Vqals5HluI8FEsTlSLukpa/AhCmczN
         DUlocP7sSUOYyOQFEUCPKJTYlTWgcELoBkVAVibJOjetbqQ7pAj5ue8+DNQjpGMkLoia
         vL6vdRsJLKgIu4bsVcSIf2hrbomJuIHMwPXFNFavNTeCsNGBjOivKYyJRZhofCW6qkn3
         Bwpw==
X-Gm-Message-State: AOAM533A68+abnI0gBKd/J4MzmVt27br4T1+DdtwXa/m/8jaU/5be//y
        e4TwRO7gqHYVPobx00T3v7TzeERAjVZzzSLyNErg8Q==
X-Google-Smtp-Source: ABdhPJy1NHVnHbgcMrU19EgraJ5BI/88eVFcyM5ealkyimHQjbl21Ew93h+U0kSMtZrzCsTFAoAlDJFTCKvC2+/HV3M=
X-Received: by 2002:a05:6402:1687:: with SMTP id a7mr4953907edv.358.1594739346365;
 Tue, 14 Jul 2020 08:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200713141945.11719-1-amir73il@gmail.com> <20200713141945.11719-3-amir73il@gmail.com>
 <CAJfpegs46Mn_z_Gj9V_mE_nSvhkOySR7+R8m4_8Tv3g9F2TMSQ@mail.gmail.com> <CAOQ4uxj7MqtdRxX6CbJo6WhmqgT7yFA=1_QLDeiMZ-8Sqd-OXQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxj7MqtdRxX6CbJo6WhmqgT7yFA=1_QLDeiMZ-8Sqd-OXQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 14 Jul 2020 17:08:55 +0200
Message-ID: <CAJfpegtX=OXMM6CFcPddGFtO3w-guREfPisg9u63xSNLYRJ+uA@mail.gmail.com>
Subject: Re: [PATCH 2/3] ovl: fix mount option checks for nfs_export with no upperdir
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Jul 14, 2020 at 4:58 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Jul 14, 2020 at 5:52 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, Jul 13, 2020 at 4:19 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > Without upperdir mount option, there is no index dir and the dependency
> > > checks nfs_export => index for mount options parsing are incorrect.
> > >
> > > Allow the combination nfs_export=on,index=off with no upperdir and move
> > > the check for dependency redirect_dir=nofollow for non-upper mount case
> > > to mount options parsing.
> >
> > Okay, but does this combination make any sense?
>
> Do you mean configuration of non-upper exported to NFS?
> Why not? Anyway, we allowed it and regressed it.

Ah, right.  I was confused and thought we'd want to allow
nfs_eport=on,index=on with no upper dir.  But that's nonsense
obviously.

Thanks,
Miklos

>
> Thanks,
> Amir.
