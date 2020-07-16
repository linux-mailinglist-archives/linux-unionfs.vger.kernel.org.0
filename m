Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0ECB221BB8
	for <lists+linux-unionfs@lfdr.de>; Thu, 16 Jul 2020 07:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgGPFBA (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 16 Jul 2020 01:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgGPFBA (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 16 Jul 2020 01:01:00 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC02C061755
        for <linux-unionfs@vger.kernel.org>; Wed, 15 Jul 2020 22:01:00 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id a12so4675796ion.13
        for <linux-unionfs@vger.kernel.org>; Wed, 15 Jul 2020 22:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nywb/JnF+FFmI97dAm2KUbe0k7mzDPxA7A1OvkMH4OM=;
        b=Nuwi5yVNJwTsQa//c59IkvxBnD2oVpgxGa0P98DKf/CYbCvR9YIxLxEjKGs2L1v5/3
         6c7ig9F+rEicHGcWoe9dFAItTX1FzVz5U2EjqGOG5/l6znCh9nrticTfumn2xPDBXx2+
         /RxqnMlRRPrUsSOrEWJ+OqkhcKNvMfDNDXoc4r7ZBbTW0uAmxYfCTPM0kheaW0rwl0LU
         JTufMzdcOfIEZJhHRgS7Hu5Lm+ddzEZ79X171V+p2Kgs2kRS5eKGmg/6pfwr453glAT9
         YzpDbn5ZET3XX5Qxw3ToESg4RHoXbuGQ6yDApqBp+caq19/LbQcj2zhDVdnvQJEli0yP
         ST3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nywb/JnF+FFmI97dAm2KUbe0k7mzDPxA7A1OvkMH4OM=;
        b=WdjY1Y6YR0/fesTHzvyUjULFM8gEOwHlfc/KQBevvuPjoyg1ojO26dRHlLW+t1SOUZ
         JzgKjfVk/fz3qtpjb0rgkl/mt0dPAN1dwDm14MtVH7FoEItSXy0aWrKr6OaDIMOSXGSw
         0wUQdOZRQGC72MkKpq9TUKkhIgJURj3YvNtWVC1JLjd6MQ8dN2SNlqr0clfVG1u96THd
         h58j0i/N4Jorn3KACCiBexRVY/S+1eEpwg5heAUuFEUmIOSlt9asTd3kpMyIwyJKxodi
         MZa24Co8Gvuow1MQaFYb+OTVR86InEjrxrJ35A9cNDsdP+PhHfGI9JbqN3pAM2Zpjpix
         lOqw==
X-Gm-Message-State: AOAM533m9OVNtp586XJTXv09aHRrnMp3FQLi8fecMdMx7XyZiYtWOOEl
        XOWks6yvQoZ3BnQKDWk4oTYbvRozrUk8PQZ1pos=
X-Google-Smtp-Source: ABdhPJzAzLaWtPb3Iz4yIkgXtd7Nt+oOZ9yRBpdz4WyRo0slcogavfiiJAI1a2lPm7AQb5dvc0kPQH+RWpX+G75rrBg=
X-Received: by 2002:a05:6638:61b:: with SMTP id g27mr3138551jar.123.1594875659500;
 Wed, 15 Jul 2020 22:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200713141945.11719-1-amir73il@gmail.com> <20200713141945.11719-2-amir73il@gmail.com>
 <20200714181804.GF324688@redhat.com> <CAOQ4uxj_GMcWvSGSWkTQvKj2gPCP1=R9T-t=baDrH+V3Q1mPrQ@mail.gmail.com>
 <20200714183819.GH324688@redhat.com> <CAJfpegsW_FHO5He1VdKvE6KG02S=47-Nv=6O2Wh5xARUn40bfw@mail.gmail.com>
In-Reply-To: <CAJfpegsW_FHO5He1VdKvE6KG02S=47-Nv=6O2Wh5xARUn40bfw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 Jul 2020 08:00:48 +0300
Message-ID: <CAOQ4uxg4-zsCUKHzefr2jRhBnzW-=Di1_HnZroDa8RthitHPuw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ovl: force read-only sb on failure to create index dir
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

> > I dont see it here.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git/log/?h=overlayfs-next
> >
> > Is there another tree/branch miklos is maintaining which I should use? Or
> > you just happen to know that Miklos has committed this internally and
> > not published yet.
>
> Will push shortly to #overlayfs-next.
>

Miklos,

Thanks for the notice.
I think it is good practice to announce when #overlayfs-next is updated and
ask if anyone knows of a patch that fell under the chairs.
I see that other maintainers do that sometimes.

I am missing two of my patches that I wonder if you left out intentionally
or did not get to yet:

1. ovl: fix unneeded call to ovl_change_flags()

One month old posting, so maybe it skipped your radar.
Seems like an obvious fix and needed for stable too.

2. ovl: fix lookup of indexed hardlinks with metacopy

From yesterday, so perhaps you did not get to it yet.
v5.8-rc1 regression.

They are both pushed to my rebased ovl-fixes branch.

Thanks,
Amir.
