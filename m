Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 635541327D4
	for <lists+linux-unionfs@lfdr.de>; Tue,  7 Jan 2020 14:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgAGNiF (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 7 Jan 2020 08:38:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39893 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728039AbgAGNiE (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 7 Jan 2020 08:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578404283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1T0a8RSwdl1+fpQZb8tJZNEDAIbBh3fkrylefjmBOYg=;
        b=NaEEb1dJ7lPr6gjOWMi8hQHQfD+aAE94NnOzRVPY379BIUZdqod+SF3mKTENGJxJc2l8NY
        co1DQ3tO5jV+Ta6XQTwScRJpU+slh7RBJN5t2gMtLTfBLtZtASOm8vyy5IIcXV6uQDU7Li
        XuH8+Y8eZ1hIp9gTlavVy19q/1Jt2ls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225--wRW7TYKNGC1AMnRtWrrnw-1; Tue, 07 Jan 2020 08:38:03 -0500
X-MC-Unique: -wRW7TYKNGC1AMnRtWrrnw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BE1A801E76;
        Tue,  7 Jan 2020 13:38:01 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1C8184672;
        Tue,  7 Jan 2020 13:37:58 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 5497F2202E9; Tue,  7 Jan 2020 08:37:58 -0500 (EST)
Date:   Tue, 7 Jan 2020 08:37:58 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     "Ernst, Eric" <eric.ernst@intel.com>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>,
        "kata-dev@lists.katacontainers.io" <kata-dev@lists.katacontainers.io>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: Virtio-fs as upper layer for overlayfs
Message-ID: <20200107133758.GA15920@redhat.com>
References: <7904C889-F0AC-4473-8C02-887EF6593564@intel.com>
 <20200106183500.GA14619@redhat.com>
 <CAJfpegszhftUxkhaAaF3Gj4u+S5M74RwCrXLTptW=zcKz+_xug@mail.gmail.com>
 <20200106222437.GA141177@eernstworkstation>
 <CAJfpegt0pB-jJUBEmewRgH6MMmj3__MNzZ9ScitgcEehr51awQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegt0pB-jJUBEmewRgH6MMmj3__MNzZ9ScitgcEehr51awQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Jan 07, 2020 at 10:48:37AM +0100, Miklos Szeredi wrote:
> On Mon, Jan 6, 2020 at 11:18 PM <eric.ernst@intel.com> wrote:
> 
> > Miklos, I'm still learning a bit more about fs implementations, so my
> > apologies if this should be obvious. For virtio-fs, one of the use cases
> > that is described is sharing memory between two guests (not necessarily
> > the Kata use case). I was guessing the dcache would be within the guest,
> > and that in at least the shared memory case, there's potential that a
> > revalidate may be neccesary, in case any changes are made by the second guest?
> 
> Exactly.
> 
> > (I could be mixing up the intended use for revalidate, though).
> >
> > Can you clarify that "not calling ->revalidate() should not be a
> > problem?"
> 
> I was referring specifically to the overlayfs case.  Overlayfs stacks
> on top of some other filesystems, i.e. when ->d_revalidate() is called
> on overlayfs it calls ->d_revalidate() on underlying fs.  This only
> happens for the lower (read-only) layers, not the upper (read-write)
> layer.  So if the underlying upper fs is modified from another guest,
> than that modification is not going to be reflected on the overlayfs.
> However, overlayfs documents any changes to underlying layers as
> resulting in undefined behavior.  It would be strange if docker was
> relying on undefined behavior of overlayfs, so not doing the
> revalidation should not make a difference.

Hi Miklos,

Thanks for the explanation. I had the same question as Eric. So we will
basically rely on assumption that overlayfs upper (virtio-fs in this
case) is not shared and will not be modified underneath. Which probably
is true in this specific case. In fact I think even overlayfs lower will
not be modified as well because once docker prepares a rootfs for a 
container, it is not shared by any other container. IOW, following
seems to be the setup.

xfs/ext4 --> overlayfs1 --> virtiofs --->overlayfs2

Docker on host will prepare container root overlayfs1 on host and export
that into container using virtiofs. IIUC, overlayfs1 mount point will
not be shared with any other container. Only overlayfs1/lower will be
shared with other overlayfs mount point to enable container image
sharing. 

Given overlayfs1 will not be shared with other containers, that means
virtiofs is not changing outside this container. And docker will prepare
overlayfs2 inside contiainer for nested container. There also upper will
not be shared by other nested containers so even if we don't call
revalidate on upper, it should be fine for this configuration.

This is now all dependent on whether user has done the configuration right
and kernel can't enforce correct configuration.

Thanks
Vivek

