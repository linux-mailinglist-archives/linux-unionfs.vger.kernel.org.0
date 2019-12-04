Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4F31113688
	for <lists+linux-unionfs@lfdr.de>; Wed,  4 Dec 2019 21:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfLDUhI (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 4 Dec 2019 15:37:08 -0500
Received: from mail-il1-f176.google.com ([209.85.166.176]:33187 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbfLDUhH (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 4 Dec 2019 15:37:07 -0500
Received: by mail-il1-f176.google.com with SMTP id r81so828010ilk.0
        for <linux-unionfs@vger.kernel.org>; Wed, 04 Dec 2019 12:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kxriC3EieV58F1mLQjsdvdcRY+irLGaaJudbBJHPPNo=;
        b=jsTtiXSDilUqZXyPs6clEk2RWJCl+LvM7POF9yTS+EEdmO2Y3+r4FirkC3g9BuHeUp
         e4obNxcRPxCXOlX4pcna3wDfEMm7bo1kwHv5LVOj0bwxer1v3e5uADnjlh0etl2xbuPo
         LiX1uq/mrY5kfXJ6VEXXM/OUlShMSCwed7NiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kxriC3EieV58F1mLQjsdvdcRY+irLGaaJudbBJHPPNo=;
        b=B5rTUYXYzjKF/rVgIQcztsGDruWj8BLJy3j+XupbQlY5rXm2irg0bOFogxJeeF/edw
         Ls6H3p4K3MpDETrN/KyCApDLl61QIOLd43lZJk8+tuZal5ztQX6ggI+MN+cPUW7uQ+1H
         nHFjHzHHuzqub6jmgqwkFSnPv4zWIB7t8uYQSlvjvLC0Jr73eNvqh7ocZt/reF9xF0VZ
         MzfhMOGlzThO+oYmJOJXbYvMF3+FTC0/lEaMvAvFAcXaCp4W7Fc6Cml8nIUSYou72cH2
         zHgiyXFan6Njz6J6lpHiecss5sW4XUta4V7ul0vCk4zj054d+FJ2PVy1KpnfXTBIcUoP
         vUUg==
X-Gm-Message-State: APjAAAVnEkmQuUn3B67ufcZxK/8WtScHBZhe0A3RvihDwOiZfufYi4sx
        UOYx45AWYejB6jBbMkxI0WoYHHfepFqxYs0U2k+L7w==
X-Google-Smtp-Source: APXvYqxf1zklmzBhVmBql/l6yuCo6YnKfsxefdzf+OS4KMmJZghhn2Y893MLpr0R7KNmcedZzVyQNIs2GP2wQDBrioE=
X-Received: by 2002:a92:3bd3:: with SMTP id n80mr5436241ilh.174.1575491827217;
 Wed, 04 Dec 2019 12:37:07 -0800 (PST)
MIME-Version: 1.0
References: <7817498.QaoxCVBQX0@linux-e202.suse.de> <CAJfpeguBxP7QPSr9UO6yzPpWHJ+fAckozQ823u5hPY76kqYjSQ@mail.gmail.com>
 <9499302.rauRU9GSnF@linux-e202.suse.de>
In-Reply-To: <9499302.rauRU9GSnF@linux-e202.suse.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 4 Dec 2019 21:36:55 +0100
Message-ID: <CAJfpeguo9qYMLwsj3yfNfGdJsfA9RDYj1gvyDKhQzUe86=AfxQ@mail.gmail.com>
Subject: Re: overlayfs does not pin underlying layers
To:     Fabian Vogt <fvogt@suse.de>
Cc:     linux-unionfs <linux-unionfs@vger.kernel.org>,
        Ignaz Forster <iforster@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Dec 4, 2019 at 6:05 PM Fabian Vogt <fvogt@suse.de> wrote:
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
> order. Currently we work around that by adding the systemd specific
> "x-systemd.requires-mounts-for=foo-lower.mount" option in /etc/fstab.
> If for some reason the order is wrong, this behaviour of overlayfs might lead
> to the system shutting down without the actual unmount happening properly,
> as it's equivalent to "umount -l" on lower/upper FSs.
> I'm not sure whether there's a scenario in which this could even lead to data
> loss if something relies on umount succeeding to mean that the attached device
> is unused.

IDGI: what is the right order?  Why would it lead to corruption if the
shutdown of the underlying fs is delayed until the shutdown of
overlayfs?

Thanks,
Miklos
