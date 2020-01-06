Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D528913178E
	for <lists+linux-unionfs@lfdr.de>; Mon,  6 Jan 2020 19:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgAFSfJ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 6 Jan 2020 13:35:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45284 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726569AbgAFSfI (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 6 Jan 2020 13:35:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578335707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1j8TuP+/xGqwxQ12t6Y+SryoZpNk3WPLpksOGE7sVBI=;
        b=AHiY4RElzj4EPNUI3rTO+ero26ylW+BWHyy7Ut0GMLWxqOgbxdK1lbUt/LmwjgRggGG3EN
        qxWlwMKdo4FbvPuGxH1lsBboKYkKUouEgEjFFsUBJ1rDWlkaMEjAM/bS/672uWtsHAfZa0
        Ksxlfst/jpGksZuPgyzPh/kh2EATJkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-GgGX0fosN7ar9PHf7TAMHA-1; Mon, 06 Jan 2020 13:35:05 -0500
X-MC-Unique: GgGX0fosN7ar9PHf7TAMHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE846477;
        Mon,  6 Jan 2020 18:35:03 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE0367BFA5;
        Mon,  6 Jan 2020 18:35:00 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7FD1A2202E9; Mon,  6 Jan 2020 13:35:00 -0500 (EST)
Date:   Mon, 6 Jan 2020 13:35:00 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     "Ernst, Eric" <eric.ernst@intel.com>
Cc:     "mszeredi@redhat.com" <mszeredi@redhat.com>,
        "kata-dev@lists.katacontainers.io" <kata-dev@lists.katacontainers.io>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-unionfs@vger.kernel.org
Subject: Re: Virtio-fs as upper layer for overlayfs
Message-ID: <20200106183500.GA14619@redhat.com>
References: <7904C889-F0AC-4473-8C02-887EF6593564@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7904C889-F0AC-4473-8C02-887EF6593564@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Jan 06, 2020 at 05:27:05PM +0000, Ernst, Eric wrote:

[CC linux-unionfs@vger.kernel.org and amir]

> Hi Miklos,
> 
> One of the popular use cases for Kata Containers is running docker-in-docker.  That is, a container image is run which in turn will make use of a container runtime to do a container build.
> 
> When combined with virtio-fs, we end up with a configuration like:
> xfs/ext4 -> overlayfs -> virtio-fs -> overlayfs 
> 
> As discussed in [1], per overlayfs spec: 
> "The upper filesystem will normally be writable and if it is it must support the creation of trusted.* extended attributes, and must provide valid d_type in readdir responses, so NFS is not suitable."
> 

I don't know exaactly the reasons why NFS is not supported as upper. Are
above only two reasons? These might work with virtio-fs depending on
underlying filesystem. If yes, should we check for these properties
at mount time (instead of relying on dentry flags only,
ovl_dentry_remote()).

I feel there is more to it. Just that I don't know. Miklos and Amir
will probably have more thoughts on this.

Vivek

> At this point, with virtio-fs this, [2], check fails.  
> 
> Vivek mentioned that bypassing this check *may* be feasible, [3].  Can you help identify if this is feasible, and rationale for NFS not being available as an upper (though, more importantly, understanding what needs to be done to add proper support for virtio-fs as upper layer).
> 
> Thanks,
> Eric 
> 
> [1] - https://github.com/kata-containers/runtime/issues/1888
> [2] - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/overlayfs/super.c#n753
> [3] - https://github.com/kata-containers/runtime/issues/1888#issuecomment-518259095
> 

