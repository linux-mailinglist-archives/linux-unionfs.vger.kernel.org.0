Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15C921A5E4D
	for <lists+linux-unionfs@lfdr.de>; Sun, 12 Apr 2020 13:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDLLew (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 12 Apr 2020 07:34:52 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:42751 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgDLLew (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 12 Apr 2020 07:34:52 -0400
Received: by mail-il1-f195.google.com with SMTP id f16so6172541ilj.9;
        Sun, 12 Apr 2020 04:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k85lsoZxrKI7X1GQbhUuLjzhwO6EQeDfAtO+iJWs5mY=;
        b=Is3CWc1hS6neTfYDwTCEJNdLsh4+R1D2vWEbBd9INA06uIu638/q0qNz4fluUoPtuY
         YoLNEW+zqcWLWQX3/btgLTjHIeJMoeW7u+skAE9ByxnIWLyb+Yo2eV28HOzV6nfsNZI/
         1zHU3yvf60Pk3cCobt3+JVs46UGps7BrvWPl+MUqITdjfjxPeXJbs7rjkXehTwLfYEz0
         7VVwGQsGbpE3UlAww7rI7HTIPwILJS/Z63VclyF1MK0xCaeI7jS9INN04osg0gacGuJs
         bZmXtcvlvgepxeXYrqU7PyVIyLnrWqjW6gozWGo/qLcG62hJDg/zWOtS/1Dmi/F00+ec
         xPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k85lsoZxrKI7X1GQbhUuLjzhwO6EQeDfAtO+iJWs5mY=;
        b=cG/9SQYiMCZHC+jJPHhfLw4o4vv9QeTpHK7+m4zGsePjdr59B6M5dia0Q0iot90gBv
         XAkdkWg2Fgctuztcun6sSGdJcgM8ibZY6eWrehNt9kRIllxWs/FHI/9x+FbFLlPH8g/Z
         oQrPXOdJAlTDHbfj3uaophZgUEX0oW4mm3uDgr4WgykzDiQW68uajZV85FMPo+mgmVWz
         B6TgoPBTbF8DNiA9ujCw3keIN7PljYo7KnjVi7Zcr4AinxABiD9Xx1TDjX1WMTjkrrbq
         730bv99D4GBaX5xpDQVrDWBUXcWeFX54zh43qPSIdCyfOOG1+XAzIGTyUM+kzkBBg0/v
         raSQ==
X-Gm-Message-State: AGi0PuYVAMZO0Nnlz7KRs1BqQuxxgamwyXQh6FBktyvLbs2646wBrXpw
        xQHRo7su3SuT+MeUWv0tWydwz5NU4bMHukG3sbg=
X-Google-Smtp-Source: APiQypJen/cawU9GJs/C6MIFJC+O+VnUGCQDYePeA2UjG3MdmofLbmQUCw0eWgG2WtfjPRfRniwzLtxZgOCYHnNjkf4=
X-Received: by 2002:a92:394d:: with SMTP id g74mr12653730ila.250.1586691292037;
 Sun, 12 Apr 2020 04:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200410012059.27210-1-cgxu519@mykernel.net> <20200410012059.27210-2-cgxu519@mykernel.net>
 <20200412112734.GC3923113@desktop>
In-Reply-To: <20200412112734.GC3923113@desktop>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 12 Apr 2020 14:34:41 +0300
Message-ID: <CAOQ4uxgcogXOjT9VGTttkrrbHk3tWm88Qa-MeZ88-kt8uwRmYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] overlay/072: test for sharing inode with whiteout files
To:     Eryu Guan <guan@eryu.me>
Cc:     Chengguang Xu <cgxu519@mykernel.net>,
        Eryu Guan <guaneryu@gmail.com>,
        fstests <fstests@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Sun, Apr 12, 2020 at 2:26 PM Eryu Guan <guan@eryu.me> wrote:
>
> On Fri, Apr 10, 2020 at 09:20:59AM +0800, Chengguang Xu wrote:
> > This is a test for whiteout inode sharing feature.
> >
> > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> > ---
> > Hi Eryu,
> >
> > Kernel patch of this feature is still in review but I hope to merge
>
> If this case tests a new & unmerged feature, I'd wait for the kernel
> patch land in first, or at least the maintainer of the subsystem of the
> kernel acks that the feature will be in kernel, just that the patch
> itself needs some improvements at the moment.
>
> As there were cases that I merged a case that aimed to test a new
> feature or a new behavior, but the kernel patch was dropped eventually,
> and the case became broken.
>
> > test case first, so that we can check the correctness in a convenient
> > way. The test case will carefully check new module param and skip the
> > test if the param does not exist.
>
> Or you could provide a personal repo that contains the case, so kernel
> maintainers & reviewers could verify the feature with that repo?
>

FWIW, I am glad the test was posted early for review as a proof of
what was tested, but no reason to merge it before the kernel patch.
A personal repo link and/or the test in a single patch with the helper
should be good enough for reviewers.

Thanks,
Amir.
