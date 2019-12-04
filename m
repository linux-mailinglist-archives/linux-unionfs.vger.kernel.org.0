Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD5C9113134
	for <lists+linux-unionfs@lfdr.de>; Wed,  4 Dec 2019 18:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfLDR40 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 4 Dec 2019 12:56:26 -0500
Received: from mail-yw1-f45.google.com ([209.85.161.45]:46970 "EHLO
        mail-yw1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfLDR40 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 4 Dec 2019 12:56:26 -0500
Received: by mail-yw1-f45.google.com with SMTP id u139so37020ywf.13
        for <linux-unionfs@vger.kernel.org>; Wed, 04 Dec 2019 09:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t/LSSuRKBFL5brPIc4cvZ8RD9TACdfnub9xd340KSzE=;
        b=Mw6qYPPP61BD8ra0to7fPRlHfrfmQTWY78E3cDZ1ZZIWu/KDd4+wNw1z1JYFcfMk7M
         +jjFLQbXdEsCM1Wz0PhD3qWAwaza27sURzgsMT+3pE3T/gEQuzPjedRAsmjW1mMgC71v
         1u7PeC0zXICpBPIfbLmVS8gcJ6tFZxvaQfBVWr+lefEhuTuHHgVbv26dTgBP5JVToNOg
         UGN9LeqA0UBSYF2fL6aHFqrYFcWFCSiGzyVuZJ9HgDyZkzhN+W0ZxLvycd6AUE+IgNtP
         QfsqB7kaTQ0GUz/Y6YYxVCchB8gUGdgfW59BpLdPz32m4Zsbx3edGtVhQXV9aBROUA3z
         tKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/LSSuRKBFL5brPIc4cvZ8RD9TACdfnub9xd340KSzE=;
        b=qhQxmGtHV5dOa4HjrZuYxJ6nZQ4/V3o4fq4ZRcDtg1P4y0RuyusIRoW8mEN0QuLUWc
         /DTZmNbNhb9w5T/Oj1y90nT26eBHKDOvp98lSqngyy592D+Xcneb19tnaSc9M/PCa7Qb
         YTc28bwUqmljj92fdl2yVxEQARcS0PlUJWC6KuNNILMsHYilZEP86nSwhoFZJSe7NGIi
         AaXq1wXOn+npIfWwIcx6n68aXZzNCpGmIqsOlP/4TNOKTvqQ2ti3NU2rmYjH0LPujPBv
         fgc7xy57Qzju8vcOTSy5qAydquieKDvH0Te59gJeIcukWA6/p9kUimeprDLebe66/eAW
         5Tgg==
X-Gm-Message-State: APjAAAX7cOu1akspKpVMwEV2eRh36Rq0IoAr+hSMb9PiPwgdo6UOK1B4
        bKThE5YWAF8vILlHteopsUVYrtqVQ9uIrrqSXLY=
X-Google-Smtp-Source: APXvYqwhAgu3mZDkNWDTlxo6sVxkINRzDvJ/7Drhu5jRB26Dvv+gYGkzXO6BE65cOHdGbK8v4CQ02waqPnV3GoN7kP0=
X-Received: by 2002:a81:1887:: with SMTP id 129mr2842407ywy.25.1575482184631;
 Wed, 04 Dec 2019 09:56:24 -0800 (PST)
MIME-Version: 1.0
References: <7817498.QaoxCVBQX0@linux-e202.suse.de> <CAJfpeguBxP7QPSr9UO6yzPpWHJ+fAckozQ823u5hPY76kqYjSQ@mail.gmail.com>
 <9499302.rauRU9GSnF@linux-e202.suse.de>
In-Reply-To: <9499302.rauRU9GSnF@linux-e202.suse.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 4 Dec 2019 19:56:13 +0200
Message-ID: <CAOQ4uxjkz+hpfKZYuHLZkGHzx5-KzezcZe4X6-pu4uXwZwtK6g@mail.gmail.com>
Subject: Re: overlayfs does not pin underlying layers
To:     Fabian Vogt <fvogt@suse.de>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs <linux-unionfs@vger.kernel.org>,
        Ignaz Forster <iforster@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Dec 4, 2019 at 7:08 PM Fabian Vogt <fvogt@suse.de> wrote:
>
> Hi,
>
> Am Dienstag, 3. Dezember 2019, 15:19:28 CET schrieb Miklos Szeredi:
> > On Tue, Dec 3, 2019 at 2:49 PM Fabian Vogt <fvogt@suse.de> wrote:
> > >
> > > Hi,
> > >
> > > I noticed that you can still unmount the lower/upper/work layers, even if
> > > they're currently part of an active overlay mount. This is the case even when
> > > files in the overlay mount are currently open. After unmounting, the usual
> > > effects of a lazy umount can be observed, like still active loop devices.
> > >
> > > Is this intentional?
> >
> > It's a known feature.  Not sure how much thought was given to this,
> > but nobody took notice up till now.
> >
> > Do you have a good reason for wanting the underlying mounts pinned, or
> > you are just surprised by this behavior?  In the latter case we can
> > just add a paragraph to the documentation and be done with it.
>
> Both. It's obviously very inconsistent that it's possible to unmount something
> which you still have unrestricted access to.
>
> The specific issue we're facing here is system shutdown - if there's an active
> overlayfs mount, it's not guaranteed that the unmounts happen in the right
> order.

What do you mean by "right" order? Please explain the problem.
If overlay does not prevent mount of lower/upper then you can unmount
lower/upper/overlay in any order as long as you unmount all of them.
But you can also walk all mounts from /proc/mounts in reserve order.
It should do the right thing w.r.t dependencies.

> Currently we work around that by adding the systemd specific
> "x-systemd.requires-mounts-for=foo-lower.mount" option in /etc/fstab.
> If for some reason the order is wrong, this behaviour of overlayfs might lead
> to the system shutting down without the actual unmount happening properly,
> as it's equivalent to "umount -l" on lower/upper FSs.

I don't know what the systemd shutdown procedure is.
Is it trying to unmount all the blockdev filesystems before shutdown?
Is that the problem?

> I'm not sure whether there's a scenario in which this could even lead to data
> loss if something relies on umount succeeding to mean that the attached device
> is unused.
>

Basically, you cannot know that there is no other mount of that
specific blockdev,
maybe in another mount namespace, when you unmount a specific mount point.
In any case, with modern journalled blockdev filesystem, shutdown without clean
unmount should not result in data loss (of fsynced data).

Thanks,
Amir.
