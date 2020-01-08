Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2A8A13448F
	for <lists+linux-unionfs@lfdr.de>; Wed,  8 Jan 2020 15:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgAHOGV (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 8 Jan 2020 09:06:21 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42540 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726708AbgAHOGV (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 8 Jan 2020 09:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578492379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZI4rwrCVY3scRh2p0sxhdIZOPE/mYbnsSIBQYTjPK0A=;
        b=c6svQ3ruZ6IjylsfMZHW7MNqBRv4BbuANBh2kEQ5eDky3zy2ilG8/uqbESLY+Fwvrv8QU5
        x8Pcc1YC9sQGfRsSZeSEagVG2jq9Bv42I2OfFp3k3mVIYsNs7mK9DaepSuaY1ef+Iql1XK
        tMfM/ku7aQ8Btn1P66Yk9kpQ3TZPxWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-RiJutJWFMfWKQkn_MeLkhg-1; Wed, 08 Jan 2020 09:06:15 -0500
X-MC-Unique: RiJutJWFMfWKQkn_MeLkhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA02A10120C4;
        Wed,  8 Jan 2020 14:06:12 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9525D5D9E5;
        Wed,  8 Jan 2020 14:06:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 234BA220A24; Wed,  8 Jan 2020 09:06:11 -0500 (EST)
Date:   Wed, 8 Jan 2020 09:06:11 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        StuartIanNaylor <rolyantrauts@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        kmxz <kxzkxz7139@gmail.com>, "zhangyi (F)" <yi.zhang@huawei.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: OverlaysFS offline tools
Message-ID: <20200108140611.GA1995@redhat.com>
References: <CAOQ4uxjFC81hikgg0WaF0Z3Mxkk3iDakKx2Ttuhp_L_2Tnc6xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjFC81hikgg0WaF0Z3Mxkk3iDakKx2Ttuhp_L_2Tnc6xQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Jan 08, 2020 at 09:27:12AM +0200, Amir Goldstein wrote:
> [-fsdevel,+containers]
> 
> > On Thu, Apr 18, 2019 at 1:58 PM StuartIanNaylor <rolyantrauts@gmail.com> wrote:
> > >
> > > Apols to ask here but are there any tools for overlayFS?
> > >
> > > https://github.com/kmxz/overlayfs-tools is just about the only thing I
> > > can find.
> >
> > There is also https://github.com/hisilicon/overlayfs-progs which
> > can check and fix overlay layers, but it hasn't been updated in a while.
> >
> 
> Hi Vivek (and containers folks),
> 
> Stuart has pinged me on https://github.com/StuartIanNaylor/zram-config/issues/4
> to ask about the status of overlayfs offline tools.
> 
> Quoting my answer here for visibility to more container developers:
> 
> I have been involved with implementing many overlayfs features in the
> kernel in the
> past couple of years (redirect_dir,index,nfs_export,xino,metacopy).
> All of these features bring benefits to end users, but AFAIK, they are
> all still disabled
> by default in containers runtimes (?) because lack of tools support
> (e.g. migration
> /import/export). I cannot force anyone to use the new overlayfs
> features nor to write
> offline tools support for them.
> 
> So how can we improve this situation?
> 
> If the problem is development resources then I've had great experience
> in the past
> with OSS internship programs like Google summer of code (GSoC):
> Organizations, such as Redhat or mobyproject.org, can participate in the program
> by posting proposals for open source projects.
> Developers, such as myself, volunteer to mentors projects and students apply
> to work on them.
> 
> IIRC, the timeline for GSoC for project proposals in around April. Applying as
> an organization could be before that.
> 
> Vivek, since you are the only developer I know involved in containers runtime
> projects I am asking you, but really its a question for all container developers
> out there.
> 
> Are you aware of missing features in containers that could be met by filling the
> gaps with overlayfs offline tools?

CCing Dan Walsh as he is taking care of podman and often I hear some of
the the complaints from him w.r.t what he thinks is missing. This is
not necessarily related to overlayfs offline tools.

- Unpriviliged mounting of overlayfs.
 
  He wants to launch containers unpriviliged and hence wants to be able
  to mount overlayfs without being root in init_user_ns. I think Miklos
  posted some patches for that but not much progress after that.

  https://patchwork.kernel.org/cover/11212091/

- shiftfs

  As of now they are relying on doing chown of the image but will really
  like to see the ability to shift uid/gids using shiftfs or using
  VFS layer solution.

- Overlayfs redirect_dir is not compatible with image building

  redirect_dir is not compatible with image building and I think that's
  one reason that its not used by default. And as metacopy is dependent
  on redirect_dir, its not used by default as well. It can be used for
  running containers though, but one needs to know that in advacnce.

  So it will be good if that's fixed with redirect_dir and metacopy
  features and then there is higher chance that these features are
  enabled by default.

  Miklos had some ides on how to tackle the issue of getting diff
  correctly with redirect_dir enabled.

  https://www.spinics.net/lists/linux-unionfs/msg06969.html

  Having said that, I think Dan Walsh has enabled metacopy by default
  in podman in certain configurations (for running containers and not
  for building images).

Thanks
Vivek


> Are you a part of an organization that could consider posting this sort of
> project proposals to GSoC or other internship programs?
> 
> Thanks,
> Amir.
> 

