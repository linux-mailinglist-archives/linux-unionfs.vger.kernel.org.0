Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 176331318ED
	for <lists+linux-unionfs@lfdr.de>; Mon,  6 Jan 2020 20:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgAFT6f (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 6 Jan 2020 14:58:35 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44146 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAFT6f (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 6 Jan 2020 14:58:35 -0500
Received: by mail-io1-f65.google.com with SMTP id b10so49886363iof.11
        for <linux-unionfs@vger.kernel.org>; Mon, 06 Jan 2020 11:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GXqXFlDPphoFQYXEAeWiUFrGnL90kxH7QfJ+YUCvZ/s=;
        b=GumnTwE/U6ZJHhQZx2f5XffTewIcR5LD3MMu9a1SxxpmGlmhxFLjfIK6Hq3W4dDBRr
         hPGB+SP9tW+SXtyyqJ67+l799TqvD4AcW/N2glPCc2atHNyFfKx5wm9CY5B3/S/LN3Pu
         8yTisnAJhqvsW0I+vy/4aX9563m5azZ+SKjNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GXqXFlDPphoFQYXEAeWiUFrGnL90kxH7QfJ+YUCvZ/s=;
        b=QSFcmmKVbzc4yapDZskdcy9NOgUlEHYod1L6I3q2w/ayZBcuzvg0nefznnxpqyd9kJ
         6aX/UK/f7vTzxXm2EwROgb75pg43xIyaN2mc8/ytpElyE4PcJCnjQhcjK3zh+TWDslpA
         w6pWBfZYiddO6BQV80uMWeLRrqPf4RKJ46rB2p2VKUAmd370Srps9J6d8Z2mWJ4lK5bW
         Zt0p7QUw/1/wyrvil43CRXvvkUUGMb4+goM6lag972CK7fAOqgpJP5tRw5KGWGh5KMTm
         2gB1fCcrv5ogvifi5winxQRIb5+GpDmfTYweXneQyBau3CGwRz9eHoE9f3Rqj0Yj5DiZ
         il/w==
X-Gm-Message-State: APjAAAUS+I8Xge8engfAa+671JsiyrUWkBWytIxITztzUR8BskRlJu+i
        DG6LRylSPQCi9aNcs5RkjP36GBCI17J8+nhYQ8UPsA==
X-Google-Smtp-Source: APXvYqyYiOBVjsJF/FK9uXbaJdBsl1E00GSpdRWIZauYAL8UTKu3PzXrAY7SfcwEuDesY010lCrkwu7IsaiVM2/hc2U=
X-Received: by 2002:a6b:c9c6:: with SMTP id z189mr66760682iof.285.1578340714426;
 Mon, 06 Jan 2020 11:58:34 -0800 (PST)
MIME-Version: 1.0
References: <7904C889-F0AC-4473-8C02-887EF6593564@intel.com> <20200106183500.GA14619@redhat.com>
In-Reply-To: <20200106183500.GA14619@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 6 Jan 2020 20:58:23 +0100
Message-ID: <CAJfpegszhftUxkhaAaF3Gj4u+S5M74RwCrXLTptW=zcKz+_xug@mail.gmail.com>
Subject: Re: Virtio-fs as upper layer for overlayfs
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     "Ernst, Eric" <eric.ernst@intel.com>,
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

On Mon, Jan 6, 2020 at 7:35 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, Jan 06, 2020 at 05:27:05PM +0000, Ernst, Eric wrote:
>
> [CC linux-unionfs@vger.kernel.org and amir]
>
> > Hi Miklos,
> >
> > One of the popular use cases for Kata Containers is running docker-in-docker.  That is, a container image is run which in turn will make use of a container runtime to do a container build.
> >
> > When combined with virtio-fs, we end up with a configuration like:
> > xfs/ext4 -> overlayfs -> virtio-fs -> overlayfs
> >
> > As discussed in [1], per overlayfs spec:
> > "The upper filesystem will normally be writable and if it is it must support the creation of trusted.* extended attributes, and must provide valid d_type in readdir responses, so NFS is not suitable."
> >
>
> I don't know exaactly the reasons why NFS is not supported as upper. Are
> above only two reasons? These might work with virtio-fs depending on
> underlying filesystem. If yes, should we check for these properties
> at mount time (instead of relying on dentry flags only,
> ovl_dentry_remote()).
>
> I feel there is more to it.

NFS also has these automount points, that we currently can't cope with
in overlayfs.  And there's revalidation, which we reject on upper
simply because overlayfs currently doesn't call ->revalidate() on
upper.   Not that we would not be able to, it's just something that
probably needs some thought.

Virtio-fs does not yet have the magic automount thing (which would be
useful to resolve inode number conflicts), but it does have
revalidate. In the virtio-fs case, not calling ->revalidate() should
not be a problem, so it's safe to try out this configuration by adding
a hack to disable the remote check in case of a virtio-fs upper.

Thanks,
Miklos
