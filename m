Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B672C1214D
	for <lists+linux-unionfs@lfdr.de>; Thu,  2 May 2019 19:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfEBRx3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-unionfs@lfdr.de>); Thu, 2 May 2019 13:53:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43173 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBRxZ (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 2 May 2019 13:53:25 -0400
Received: by mail-ot1-f65.google.com with SMTP id e108so2880432ote.10
        for <linux-unionfs@vger.kernel.org>; Thu, 02 May 2019 10:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GBDNR7dZoJr86zYykorTJ/IjzJwi83xXzsZS+RvPfCM=;
        b=I9IlSz8Tk2kHN3vdlU0NF63y5SKolHVxX9YxlIxxvHNae7ehMeDT3hAm4ijfWrdK74
         9x+vHpFJncc3kMFPtLZ8buk9LNK4x9KuoS6W/lKKMiq5zh1MgmhBLi1a+k7P/gOLhJ9e
         nLFVdNhRBICFYLiDoz3vtwDPAIIepUqqYvEEMl5k3SLT92M5OZSjXBMTFWzzwRgdNmuE
         bZoBcj9SWDizgiWsbY8ynJuF4IhjWNfAympBk54lvTAy0UekPAWETwKZ88rOUo1zE+vi
         Z8vR660w4JybCyQGuGeTB0Lzp/dOBH9ywo8vsosvdobqFLbSRMmrHOaKrWDSufdHuqKc
         K5EA==
X-Gm-Message-State: APjAAAVgYLhRZ+ce+b7A/lANfAcNCj1Apei9V+z1381AEd18YlE/yfDM
        Yqyi3dmVyZxc9ANq7BopwUpg8C4ad+Iu4Y4+98ZbwQ==
X-Google-Smtp-Source: APXvYqzST1Dup9n2jNMYyXmGV8wykLPR0kBeWfOpX/RmNcI7EMUp4H3q7uEXhTXI757a8zkKf8qMd/e6iIelmwu8cxc=
X-Received: by 2002:a9d:61c6:: with SMTP id h6mr3337115otk.316.1556819604755;
 Thu, 02 May 2019 10:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com>
 <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com>
 <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com>
 <20161206185806.GC31197@fieldses.org> <87bm0l4nra.fsf@notabene.neil.brown.name>
 <CAOQ4uxjYEjqbLcVYoUaPzp-jqY_3tpPBhO7cE7kbq63XrPRQLQ@mail.gmail.com>
 <875zqt4igg.fsf@notabene.neil.brown.name> <CAHc6FU52OCCGUnHXOCFTv1diP_5i4yZvF6fAth9=aynwS+twQg@mail.gmail.com>
 <CAJfpegsthQn_=3AQJf7ojxoQBpHMA3dz1fCBjNZXsCA1E0oqnw@mail.gmail.com>
 <CAHpGcML0KuoGSyXyyDnXHkSp3nDnSjJPeZeWEmt8CXxQeojxwg@mail.gmail.com> <20190502171603.GA1778@fieldses.org>
In-Reply-To: <20190502171603.GA1778@fieldses.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 2 May 2019 19:53:13 +0200
Message-ID: <CAHc6FU5fBorvOCkxvX58hEKmDgwu+-m_RDwEWDY36XpH1F03Hw@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>, NeilBrown <neilb@suse.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Patrick Plagwitz <Patrick_Plagwitz@web.de>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, 2 May 2019 at 19:16, J. Bruce Fields <bfields@fieldses.org> wrote:
> On Thu, May 02, 2019 at 05:08:14PM +0200, Andreas Grünbacher wrote:
> > You'll still see permissions that differ from what the filesystem
> > enforces, and copy-up would change that behavior.
>
> That's always true, and this issue isn't really specific to NFSv4 ACLs
> (or ACLs at all), it already exists with just mode bits.  The client
> doesn't know how principals may be mapped on the server, doesn't know
> group membership, etc.
>
> That's the usual model, anyway.  Permissions are almost entirely the
> server's responsibility, and we just provide a few attributes to set/get
> those server-side permissions.

Sure, if the client and server don't share the same user and group
databases, ACLs can get a very different meaning.

Andreas

> The overlayfs/NFS case is different, I think: the nfs filesystem may be
> just a static read-only template for a filesystem that's only ever used
> by clients, and for all I know maybe permissions should only be
> interpreted on the client side in that case.
>
> --b.
