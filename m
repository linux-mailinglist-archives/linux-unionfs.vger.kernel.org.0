Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253B9218A21
	for <lists+linux-unionfs@lfdr.de>; Wed,  8 Jul 2020 16:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgGHO1C (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 8 Jul 2020 10:27:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43122 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729468AbgGHO1C (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 8 Jul 2020 10:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594218420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KOVfaOphciy8vbgJGYYej3cFPI5a0So+QJK6ub8tUBM=;
        b=G3hM8ayuGJmBDdmdq4iPO2tUnPb0tbC1CDygZOX+jCa/s93PJlizCZVdQnNcQFGWCd6X2H
        T4s0kVyvQ9yeVPiKSrXFYTNb3m/36MpeyU8/t2nmFF20Y93y03jlNWa5wCi5OZbu5oGpyI
        HtyI78AGnvTN0W24EIN2SfChjRHQsxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-9rIrnC-zOk-hEs5L0-RzYg-1; Wed, 08 Jul 2020 10:26:55 -0400
X-MC-Unique: 9rIrnC-zOk-hEs5L0-RzYg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C3661005504;
        Wed,  8 Jul 2020 14:26:54 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-128.rdu2.redhat.com [10.10.115.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 036AC5C1B2;
        Wed,  8 Jul 2020 14:26:54 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8DF08223B92; Wed,  8 Jul 2020 10:26:53 -0400 (EDT)
Date:   Wed, 8 Jul 2020 10:26:53 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Fabian <godi.beat@gmx.net>
Subject: Re: overlayfs: issue with a replaced lower squashfs with export-table
Message-ID: <20200708142653.GB103536@redhat.com>
References: <CAOQ4uxgT_cmFPm_mnpQtjWqhd=3vOAiFLdw_z6Y_=FSxr+3nfg@mail.gmail.com>
 <20200707155159.GA48341@redhat.com>
 <CAOQ4uxhMq_8xwCU2t+WveTGgc9MAWE2RD66q5UjQ1r09EoLzHA@mail.gmail.com>
 <20200707215309.GB48341@redhat.com>
 <CAOQ4uxhd+kYzaDmndCV5rgiswfHnyLjZokmUa+BVk9t31C=HWg@mail.gmail.com>
 <CAJfpegv9h7ubuGy_6K4OCdZd3R7Z4HGmCDB2L7mO5bVoGd6MSA@mail.gmail.com>
 <CAOQ4uxgaVD_DjU5DM+rXzkqpgVLWN-R+kj5ef2SBvvvCDL3d6w@mail.gmail.com>
 <CAJfpegur+DfoGA4e+R2okSmso59Kx0ArnkpJ03o9qM1KH5rLdg@mail.gmail.com>
 <CAOQ4uxiq7hkaew4LoFZkf4R73iH_pU7OHOriycLCnnywtA0O0w@mail.gmail.com>
 <20200708142353.GA103536@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708142353.GA103536@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Jul 08, 2020 at 10:23:53AM -0400, Vivek Goyal wrote:
> On Wed, Jul 08, 2020 at 11:50:29AM +0300, Amir Goldstein wrote:
> > On Wed, Jul 8, 2020 at 11:37 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Wed, Jul 8, 2020 at 10:31 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > >
> > > > 1) is not problematic IMO and the simple patch I posted may be applied
> > > > for fixing the reported issue, but it only solved the special case of null uuid.
> > > > The problem still exists with re-creating lower on xfs/ext4, e.g. by
> > > > rm -rf and unpacking image tar.
> > >
> > > How so?  st_ino may be reused but the fh is guaranteed to be unique.
> > >
> > 
> > Doh! You are right. I was talking nonsense.
> > The only problem would be with re-creating an xfs/ext4 lower image
> > with the same uuid maybe because a basic image is cloned.
> > 
> > In any case, it's a corner of a corner of a corner.
> > I will post the patch to fix null uuid.
> 
> It will also be good if we can bring some clarity to the documentation
> for future references in section "Sharing and copying layers".
> 
> So if IIUC,
> 
> - sharing layers should work with all features of overlayfs.
> 
> - copying layers works only if index and nfs_export is not enabled. Even
>   if index is not enabled, copying layers will change inode number
>   reporting behavior (as origin verification will fail). We probably
>   say something about this.
> 
> - Modifying/recreating lower layer only works when
>   metacopy/index/nfs_export are not enabled at any point of time. This
>   also will change inode number reporting behavior.

Well, this is not entirely true. redirect might be broken if lower layers have
been modified/recreated and that will have issues with directories.

/me is again wondering what's the use case of modifying lower layer
with an existing upper. Is it fair to say, no don't recreate/modify
lower layers and use with existing upper.

Thanks
Vivek

