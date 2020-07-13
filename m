Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E58218E62
	for <lists+linux-unionfs@lfdr.de>; Wed,  8 Jul 2020 19:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgGHRgH (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 8 Jul 2020 13:36:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56837 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726962AbgGHRgH (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 8 Jul 2020 13:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594229765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A2GAZhlzi1OcEq3c6GQ9TLuLpWeKfIzx8NscN+kmKl4=;
        b=GGg7l1rLu4A4IMywH3sKZnXuDVpM2O/b6JocE9//xTpPCz589j7PQyoqgPo56Vmxzhf+Ee
        9GglakvJXULn7Zr1fxc8K6vcw8Qc9foD9LTNKaHx9vRSHnf2TWXuBJGfOTKneW83GPXyKd
        aFL4OoYulYHhexrEvdfqBhlL4muuRwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-cxQEdveDPJ2go1x7WHFeTQ-1; Wed, 08 Jul 2020 13:36:03 -0400
X-MC-Unique: cxQEdveDPJ2go1x7WHFeTQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B40F119253C3;
        Wed,  8 Jul 2020 17:36:01 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-128.rdu2.redhat.com [10.10.115.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94BDA724A6;
        Wed,  8 Jul 2020 17:36:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 2024E223B92; Wed,  8 Jul 2020 13:36:01 -0400 (EDT)
Date:   Wed, 8 Jul 2020 13:36:01 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Fabian <godi.beat@gmx.net>
Subject: Re: overlayfs: issue with a replaced lower squashfs with export-table
Message-ID: <20200708173601.GD103536@redhat.com>
References: <CAOQ4uxhMq_8xwCU2t+WveTGgc9MAWE2RD66q5UjQ1r09EoLzHA@mail.gmail.com>
 <20200707215309.GB48341@redhat.com>
 <CAOQ4uxhd+kYzaDmndCV5rgiswfHnyLjZokmUa+BVk9t31C=HWg@mail.gmail.com>
 <CAJfpegv9h7ubuGy_6K4OCdZd3R7Z4HGmCDB2L7mO5bVoGd6MSA@mail.gmail.com>
 <CAOQ4uxgaVD_DjU5DM+rXzkqpgVLWN-R+kj5ef2SBvvvCDL3d6w@mail.gmail.com>
 <CAJfpegur+DfoGA4e+R2okSmso59Kx0ArnkpJ03o9qM1KH5rLdg@mail.gmail.com>
 <CAOQ4uxiq7hkaew4LoFZkf4R73iH_pU7OHOriycLCnnywtA0O0w@mail.gmail.com>
 <20200708142353.GA103536@redhat.com>
 <20200708142653.GB103536@redhat.com>
 <CAOQ4uxhNqbtL_G+ZxB+UwK+c+P2fbvis1ZP7XXtO=R=N6Or_ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhNqbtL_G+ZxB+UwK+c+P2fbvis1ZP7XXtO=R=N6Or_ew@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Jul 08, 2020 at 08:26:19PM +0300, Amir Goldstein wrote:
> On Wed, Jul 8, 2020 at 5:27 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Wed, Jul 08, 2020 at 10:23:53AM -0400, Vivek Goyal wrote:
> > > On Wed, Jul 08, 2020 at 11:50:29AM +0300, Amir Goldstein wrote:
> > > > On Wed, Jul 8, 2020 at 11:37 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > >
> > > > > On Wed, Jul 8, 2020 at 10:31 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > >
> > > > > >
> > > > > > 1) is not problematic IMO and the simple patch I posted may be applied
> > > > > > for fixing the reported issue, but it only solved the special case of null uuid.
> > > > > > The problem still exists with re-creating lower on xfs/ext4, e.g. by
> > > > > > rm -rf and unpacking image tar.
> > > > >
> > > > > How so?  st_ino may be reused but the fh is guaranteed to be unique.
> > > > >
> > > >
> > > > Doh! You are right. I was talking nonsense.
> > > > The only problem would be with re-creating an xfs/ext4 lower image
> > > > with the same uuid maybe because a basic image is cloned.
> > > >
> > > > In any case, it's a corner of a corner of a corner.
> > > > I will post the patch to fix null uuid.
> > >
> > > It will also be good if we can bring some clarity to the documentation
> > > for future references in section "Sharing and copying layers".
> 
> I am very bad at documenting.
> Feel free to post a patch to add clarity.

Ok, I will send a patch and improve it based on feedback.

> 
> > >
> > > So if IIUC,
> > >
> > > - sharing layers should work with all features of overlayfs.
> > >
> > > - copying layers works only if index and nfs_export is not enabled. Even
> > >   if index is not enabled, copying layers will change inode number
> > >   reporting behavior (as origin verification will fail). We probably
> > >   say something about this.
> > >
> > > - Modifying/recreating lower layer only works when
> > >   metacopy/index/nfs_export are not enabled at any point of time. This
> > >   also will change inode number reporting behavior.
> >
> > Well, this is not entirely true. redirect might be broken if lower layers have
> > been modified/recreated and that will have issues with directories.
> >
> > /me is again wondering what's the use case of modifying lower layer
> > with an existing upper. Is it fair to say, no don't recreate/modify
> > lower layers and use with existing upper.
> >
> 
> It's fine by me to document that this is not supported.
> Only thing is that we usually do not want to break existing setups that
> used to work if we dont have to.

I will limit this case to "!redirect, !metacopy, !index, !export"
and that will make sure existing setups work and any of the new features
we added will not support this.

Thanks
Vivek

