Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3467139A69
	for <lists+linux-unionfs@lfdr.de>; Mon, 13 Jan 2020 20:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgAMT6G (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 13 Jan 2020 14:58:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49419 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726494AbgAMT6F (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 13 Jan 2020 14:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578945484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dQ5VT8mWPUnDCs1MW1HUnv8ocw4H5Be5D9E+Q923TZo=;
        b=HHPCxwj/c1OO+euKV0C1BUV/FoTJtztOBP2/rRbwoiaS4X2ak179nPku0XDPv7551Ug/cy
        40IuQ4pHD3SHwZ+EUAccX2+lEb4kibKIhWwhrb/0DaAXxKAxrBTkXhS8sY3egGvU9Ck3/x
        fFNuM2o+POdROLzRz/i4OgO+3ndG+HE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63--68OPlyHNPmExKCeDdbw2g-1; Mon, 13 Jan 2020 14:56:55 -0500
X-MC-Unique: -68OPlyHNPmExKCeDdbw2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67D01DB88;
        Mon, 13 Jan 2020 19:56:54 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83EC660C87;
        Mon, 13 Jan 2020 19:56:51 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 13BCB220A24; Mon, 13 Jan 2020 14:56:51 -0500 (EST)
Date:   Mon, 13 Jan 2020 14:56:51 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        "Ernst, Eric" <eric.ernst@intel.com>
Cc:     "mszeredi@redhat.com" <mszeredi@redhat.com>,
        "kata-dev@lists.katacontainers.io" <kata-dev@lists.katacontainers.io>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: Virtio-fs as upper layer for overlayfs
Message-ID: <20200113195651.GA9780@redhat.com>
References: <7904C889-F0AC-4473-8C02-887EF6593564@intel.com>
 <20200106183500.GA14619@redhat.com>
 <CAJfpegszhftUxkhaAaF3Gj4u+S5M74RwCrXLTptW=zcKz+_xug@mail.gmail.com>
 <20200107160918.GB15920@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107160918.GB15920@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Jan 07, 2020 at 11:09:18AM -0500, Vivek Goyal wrote:
> On Mon, Jan 06, 2020 at 08:58:23PM +0100, Miklos Szeredi wrote:
> > On Mon, Jan 6, 2020 at 7:35 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Mon, Jan 06, 2020 at 05:27:05PM +0000, Ernst, Eric wrote:
> > >
> > > [CC linux-unionfs@vger.kernel.org and amir]
> > >
> > > > Hi Miklos,
> > > >
> > > > One of the popular use cases for Kata Containers is running docker-in-docker.  That is, a container image is run which in turn will make use of a container runtime to do a container build.
> > > >
> > > > When combined with virtio-fs, we end up with a configuration like:
> > > > xfs/ext4 -> overlayfs -> virtio-fs -> overlayfs
> > > >
> > > > As discussed in [1], per overlayfs spec:
> > > > "The upper filesystem will normally be writable and if it is it must support the creation of trusted.* extended attributes, and must provide valid d_type in readdir responses, so NFS is not suitable."
> > > >
> > >
> > > I don't know exaactly the reasons why NFS is not supported as upper. Are
> > > above only two reasons? These might work with virtio-fs depending on
> > > underlying filesystem. If yes, should we check for these properties
> > > at mount time (instead of relying on dentry flags only,
> > > ovl_dentry_remote()).
> > >
> > > I feel there is more to it.
> > 
> > NFS also has these automount points, that we currently can't cope with
> > in overlayfs.  And there's revalidation, which we reject on upper
> > simply because overlayfs currently doesn't call ->revalidate() on
> > upper.   Not that we would not be able to, it's just something that
> > probably needs some thought.
> > 
> > Virtio-fs does not yet have the magic automount thing (which would be
> > useful to resolve inode number conflicts), but it does have
> > revalidate. In the virtio-fs case, not calling ->revalidate() should
> > not be a problem, so it's safe to try out this configuration by adding
> > a hack to disable the remote check in case of a virtio-fs upper.
> 
> Here is a hack patch to provide an exception to allow virtiofs as upper
> filesystem for overlayfs. 
> 
> I can mount now but I get warning that upper does not support xattr, hence
> disabling index and metaocopy. Still need to test why that's the case. I
> thought xattr are supported on virtiofs.

I have pushed this patch on a branch in my repo for testing.

https://github.com/rhvgoyal/linux/commit/0a0c0e2d9986ecf445e1fdff45b51f37b98ac1e6

I can now mount overlayfs on top of virtiofs with this patch. It needs to
run virtiofsd with option "-o xattr" and also needs following patch for it
to work.

https://www.redhat.com/archives/virtio-fs/2020-January/msg00047.html

Thanks
Vivek

