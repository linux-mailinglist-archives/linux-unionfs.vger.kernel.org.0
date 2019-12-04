Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 494CC113078
	for <lists+linux-unionfs@lfdr.de>; Wed,  4 Dec 2019 18:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbfLDRF4 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 4 Dec 2019 12:05:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:37736 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728784AbfLDRFz (ORCPT <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 4 Dec 2019 12:05:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C049FAFB5;
        Wed,  4 Dec 2019 17:05:54 +0000 (UTC)
From:   Fabian Vogt <fvogt@suse.de>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs <linux-unionfs@vger.kernel.org>,
        Ignaz Forster <iforster@suse.de>
Subject: Re: overlayfs does not pin underlying layers
Date:   Wed, 04 Dec 2019 18:05:54 +0100
Message-ID: <9499302.rauRU9GSnF@linux-e202.suse.de>
In-Reply-To: <CAJfpeguBxP7QPSr9UO6yzPpWHJ+fAckozQ823u5hPY76kqYjSQ@mail.gmail.com>
References: <7817498.QaoxCVBQX0@linux-e202.suse.de> <CAJfpeguBxP7QPSr9UO6yzPpWHJ+fAckozQ823u5hPY76kqYjSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi,

Am Dienstag, 3. Dezember 2019, 15:19:28 CET schrieb Miklos Szeredi:
> On Tue, Dec 3, 2019 at 2:49 PM Fabian Vogt <fvogt@suse.de> wrote:
> >
> > Hi,
> >
> > I noticed that you can still unmount the lower/upper/work layers, even if
> > they're currently part of an active overlay mount. This is the case even when
> > files in the overlay mount are currently open. After unmounting, the usual
> > effects of a lazy umount can be observed, like still active loop devices.
> >
> > Is this intentional?
> 
> It's a known feature.  Not sure how much thought was given to this,
> but nobody took notice up till now.
> 
> Do you have a good reason for wanting the underlying mounts pinned, or
> you are just surprised by this behavior?  In the latter case we can
> just add a paragraph to the documentation and be done with it.

Both. It's obviously very inconsistent that it's possible to unmount something
which you still have unrestricted access to.

The specific issue we're facing here is system shutdown - if there's an active
overlayfs mount, it's not guaranteed that the unmounts happen in the right
order. Currently we work around that by adding the systemd specific
"x-systemd.requires-mounts-for=foo-lower.mount" option in /etc/fstab.
If for some reason the order is wrong, this behaviour of overlayfs might lead
to the system shutting down without the actual unmount happening properly,
as it's equivalent to "umount -l" on lower/upper FSs.
I'm not sure whether there's a scenario in which this could even lead to data
loss if something relies on umount succeeding to mean that the attached device
is unused.

Cheers,
Fabian

> Thanks,
> Miklos



