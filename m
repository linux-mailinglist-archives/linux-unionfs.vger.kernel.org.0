Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52B52B5252
	for <lists+linux-unionfs@lfdr.de>; Mon, 16 Nov 2020 21:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgKPUSS (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 16 Nov 2020 15:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbgKPUSR (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 16 Nov 2020 15:18:17 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C090C0613CF;
        Mon, 16 Nov 2020 12:18:16 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id h6so12827084ilj.8;
        Mon, 16 Nov 2020 12:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y5tWyVQqyVOPnOnbKCKzBaCUixD0HHPocwip/42dsIc=;
        b=Xp/Jnh0Qrn4cKldL/3hsCP1XVq99BIBBI1I6GST2XcF9F534R29F/7KHEPIbD8fbLQ
         bLRA4NUMci+CGdK/a66oqkebK7y2uJ+bA6n848i2Xh3T0otHNhhzI/55hID+y0pXGx32
         RfYUeBlcndLzmR4DbWBEx1tviDYBUcbJ9WXQUI1j3FALl6d9V1qN7BE0SgRcfmFpz53v
         qfLTIl6dsl6jYR4r4A+AXd83oAQlKi6EJ/D7S1ZzZbLP+MUJtRN5mDPqJ7tx6jyQ0kkq
         4diyyzEahEz1PrMytrrMyTQCfP/P26VJ1S5IQzbxyxIjAHkuTSbXVo041THgly1TWvyC
         9Xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5tWyVQqyVOPnOnbKCKzBaCUixD0HHPocwip/42dsIc=;
        b=LO3TX8stXYPcicnyJ0RLx6kMddRKe50W34q4/eazcRrPkfEeTyNd3d8Eb6KVh4fd7j
         9wFQVEC5LWDjEnc+2c8Ro1Cv/iCRG4VVCowtl8dSUmITRcbjpm3YK1jgBulUl+VALnV5
         BXjunjWvHLjTMy6PxxkJTPwYDpzCdTx/mfY/8xRMqn5yHXLhFWG7+RTDFhUQd3989OPv
         K/k4GG8sZhG0lyHUk4vx4X7gScR3vK76vHBH6J8lciYAowk4h9peL2u0DTWIRPgnd81S
         dZiN+jYkG9PzDHuqH8pUjtwKPVflEfcVKfmHNjim9w0ayNdHieU109tgGjFNf3M2oEUP
         Ke9g==
X-Gm-Message-State: AOAM533H7ylC+TSocqrTyuIb2s2PUKmJlA6cm8cRB1y8zWDMIXNqlJhY
        auXYwul9YBJc+g1XH7O6GZZBtFCfzU6BwelUKMmmDO4V
X-Google-Smtp-Source: ABdhPJwN1DUWR9fjlvLzAAnRDb10aAPagg3wsxFP1tgMwwqjRPwz8kE0aVQnqwssOLqnyFRWFV/RIGhgjISa5pfNMAQ=
X-Received: by 2002:a92:bac5:: with SMTP id t66mr9736955ill.250.1605557895397;
 Mon, 16 Nov 2020 12:18:15 -0800 (PST)
MIME-Version: 1.0
References: <20201116045758.21774-1-sargun@sargun.me> <20201116045758.21774-4-sargun@sargun.me>
 <20201116144240.GA9190@redhat.com> <CAOQ4uxgMmxhT1fef9OtivDjxx7FYNpm7Y=o_C-zx5F+Do3kQSA@mail.gmail.com>
 <20201116163615.GA17680@redhat.com>
In-Reply-To: <20201116163615.GA17680@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 16 Nov 2020 22:18:03 +0200
Message-ID: <CAOQ4uxgTXHR3J6HueS_TO5La890bCfsWUeMXKgGnvUth26h29Q@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] overlay: Add the ability to remount volatile
 directories when safe
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chengguang Xu <cgxu519@mykernel.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Nov 16, 2020 at 6:36 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, Nov 16, 2020 at 05:20:04PM +0200, Amir Goldstein wrote:
> > On Mon, Nov 16, 2020 at 4:42 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Sun, Nov 15, 2020 at 08:57:58PM -0800, Sargun Dhillon wrote:
> > > > Overlayfs added the ability to setup mounts where all syncs could be
> > > > short-circuted in (2a99ddacee43: ovl: provide a mount option "volatile").
> > > >
> > > > A user might want to remount this fs, but we do not let the user because
> > > > of the "incompat" detection feature. In the case of volatile, it is safe
> > > > to do something like[1]:
> > > >
> > > > $ sync -f /root/upperdir
> > > > $ rm -rf /root/workdir/incompat/volatile
> > > >
> > > > There are two ways to go about this. You can call sync on the underlying
> > > > filesystem, check the error code, and delete the dirty file if everything
> > > > is clean. If you're running lots of containers on the same filesystem, or
> > > > you want to avoid all unnecessary I/O, this may be suboptimal.
> > > >
> > >
> > > Hi Sargun,
> > >
> > > I had asked bunch of questions in previous mail thread to be more
> > > clear on your requirements but never got any response. It would
> > > have helped understanding your requirements better.
> > >
> > > How about following patch set which seems to sync only dirty inodes of
> > > upper belonging to a particular overlayfs instance.
> > >
> > > https://lore.kernel.org/linux-unionfs/20201113065555.147276-1-cgxu519@mykernel.net/
> > >
> > > So if could implement a mount option which ignores fsync but upon
> > > syncfs, only syncs dirty inodes of that overlayfs instance, it will
> > > make sure we are not syncing whole of the upper fs. And we could
> > > do this syncing on unmount of overlayfs and remove dirty file upon
> > > successful sync.
> > >
> > > Looks like this will be much simpler method and should be able to
> > > meet your requirements (As long as you are fine with syncing dirty
> > > upper inodes of this overlay instance on unmount).
> > >
> >
> > Do note that the latest patch set by Chengguang not only syncs dirty
> > inodes of this overlay instance, but also waits for in-flight writeback on
> > all the upper fs inodes and I think that with !ovl_should_sync(ofs)
> > we will not re-dirty the ovl inodes and lose track of the list of dirty
> > inodes - maybe that can be fixed.
> >
> > Also, I am not sure anymore that we can safely remove the dirty file after
> > sync dirty inodes sync_fs and umount. If someone did sync_fs before us
> > and consumed the error, we may have a copied up file in upper whose
> > data is not on disk, but when we sync_fs on unmount we won't get an
> > error? not sure.
>
> May be we can save errseq_t when mounting overlay and compare with
> errseq_t stored in upper sb after unmount. That will tell us whether
> error has happened since we mounted overlay. (Similar to what Sargun
> is doing).
>

I suppose so.

> In fact, if this is a concern, we have this issue with user space
> "sync <upper>" too? Other sync might fail and this one succeeds
> and we will think upper is just fine. May be container tools can
> keep a file/dir open at the time of mount and call syncfs using
> that fd instead. (And that should catch errors since that fd
> was opened, I am assuming).
>

Did not understand the problem with userspace sync.

> >
> > I am less concerned about ways to allow re-mount of volatile
> > overlayfs than I am about turning volatile overlayfs into non-volatile.
>
> If we are not interested in converting volatile containers into
> non-volatile, then whole point of these patch series is to detect
> if any writeback error has happened or not. If writeback error has
> happened, then we detect that at remount and possibly throw away
> container.
>
> What happens today if writeback error has happened. Is that page thrown
> away from page cache and read back from disk? IOW, will user lose
> the data it had written in page cache because writeback failed. I am
> assuming we can't keep the dirty page around for very long otherwise
> it has potential to fill up all the available ram with dirty pages which
> can't be written back.
>

Right. the resulting data is undefined after error.

> Why is it important to detect writeback error only during remount. What
> happens if container overlay instance is already mounted and writeback
> error happens. We will not detct that, right?
>
> IOW, if capturing writeback error is important for volatile containers,
> then capturing it only during remount time is not enough. Normally
> fsync/syncfs should catch it and now we have skipped those, so in
> the process we lost mechanism to detect writeback errrors for
> volatile containers?
>

Yes, you are right.
It's an issue with volatile that we should probably document.

I think upper files data can "evaporate" even as the overlay is still mounted.

Thanks,
Amir.
