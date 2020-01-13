Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 152C813984B
	for <lists+linux-unionfs@lfdr.de>; Mon, 13 Jan 2020 19:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgAMSCs (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 13 Jan 2020 13:02:48 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:44562 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbgAMSCs (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 13 Jan 2020 13:02:48 -0500
Received: by mail-il1-f195.google.com with SMTP id z12so8907109iln.11
        for <linux-unionfs@vger.kernel.org>; Mon, 13 Jan 2020 10:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJ9NUqY++AewQi+rfW8T0iqebkmKiWrNe2dTXrV9NaA=;
        b=pUCkhuk5euNqu2Ye13ZMA5H7kybPtPh++XDK5LSRNEjTl7YTp9eRDvzRIc7C7vE6uz
         pw9Esm+Gvx0FkvRc/ZeiW/B7yIIGIpy8PpDOrxBentzSLNSbi42nbg4ysGKzrpohnHsO
         OftiBgNbq5W5RTRm4tugbSuxy+grFJVjULfg3/aCvSGFTTOD0VIRF46/V4xgPJi1kzZt
         Y+2+14z11wa3IRrMGq8WquoVKp0sF0k4Eiz3oJ3hYGUnnqTf1BmrQKZjx+3RsmMyFOnv
         ETDuoBE4xhEDihsK7gnhcIRHFAFiiYTe8ltQ8NHCuqGKKEElbtHKwLMeVPpJ+e1ocprK
         ipdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJ9NUqY++AewQi+rfW8T0iqebkmKiWrNe2dTXrV9NaA=;
        b=svIAhy+MSIhWGAda6Gy71oJ8qdi4ZiGBX8JfM42OiuTbPbRrdhkbHNu5GZuCC8GdUq
         p7qbhtc3hdsXF2xWDoapDeSwAo5zfdP+r1ZCCGXEyc35l/Ma7UPabAOIKiOkT8/0NnyQ
         05tHDUbcaBnGXSVo8B2WA1BPPUzpzki6f/POmAauv6E4p58BrGcRN7toj8VqmcnjUyDn
         uNqIg0s+bk6BlCcIC0rVvLp6DnltjtH0zd2uTDBVkRN7dYnCIdOiuTnt963xLaanSy4e
         F6/ifj18X4QpbJfJ9vPhtQl0CyIHSo4zSBRMDpW3b3WK2tFDcqKqBE/sw/xaUKX1x94H
         iRxg==
X-Gm-Message-State: APjAAAVhT5nbPhDAzSFJKyVw1xFHaiamRHWURgf8EVhRdNDA5anOjwCJ
        a/5aAOpqr/Tk/rs7J05qiea3LUguFvlEUyXQNPI=
X-Google-Smtp-Source: APXvYqyWyDwcqUtG6S15pwNxs1VO8674tNP+g/Hac0CQ6Gaau6ZC64LsduqE+esWgDanDldBDYKuAezy73fiRiQ1Zjk=
X-Received: by 2002:a92:9c8c:: with SMTP id x12mr9897275ill.275.1578938567162;
 Mon, 13 Jan 2020 10:02:47 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxjFC81hikgg0WaF0Z3Mxkk3iDakKx2Ttuhp_L_2Tnc6xQ@mail.gmail.com>
 <20200108140611.GA1995@redhat.com> <70a7e65d-40a5-7940-0d4d-14cdbfef39bd@redhat.com>
In-Reply-To: <70a7e65d-40a5-7940-0d4d-14cdbfef39bd@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 13 Jan 2020 20:02:36 +0200
Message-ID: <CAOQ4uxhf4t5cd7+A=CCPCO3cwsyWwG3h_CROhoa7P+4ejToktQ@mail.gmail.com>
Subject: Re: OverlaysFS offline tools
To:     Daniel J Walsh <dwalsh@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        StuartIanNaylor <rolyantrauts@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        kmxz <kxzkxz7139@gmail.com>, "zhangyi (F)" <yi.zhang@huawei.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

> Amir, Vivek did an excellent job of describing what we are attempting to
> do with OverlayFS in container tools.  My work centers around
> github.com/containers Specifically in podman(libpod), buildah, CRI-O,
> Skopeo, containers/storage and containers/image.
>
> The Podman tool is our most popular tool and runs containers with
> metacopyup turned on by default, in at least Fedora and soon in RHEL8.
> Not sure if it is turned on by default in Debian and Ubuntu releases, as
> well as OpenSUSE and other distros.
>
> On of the biggest features of these container engines (runtimes) is that
> podman & Buildah can run rootless, using the user namespace. But sadly
> we can not use overlayfs for this, since mounting of overlayfs requires
> CAP_SYS_ADMIN.  As Vivek points out, Miklos is working to fix this.  For
> now we use a FUSE version of overlay called fuse_overlayfs, which can
> run rootless, but might not give us as good of performance as kernel
> overlayfs.
>
> The biggest feature I want to push for in container technologies is
> better support for User Namespace.  I want to use it for container
> separation, IE Each container would run with a different User
> Namespace.  This means that root in one container would be a different
> UID then Root is a different container.  Currently almost no one uses
> User Namespace for this kind of separation.  The difficulty is that the
> kernel does not support a shifting file system, so if I want to share
> the same base image image, (Lower directory) between multiple containers
> in different User Namespaces, the UIDs end up wrong.  We have hoped for
> a shifting file system for many years, but Overlay FS has never
> developed it, (Fuse-overlay has some support for it).  There is an
> effort in the kernel now to add a shifting file system, but I would bet
> this will take a long time to get implemented.
>
> The other option that we have built into our container engines is a
> "chowing" image.  Basically when a new container is started, in a new
> User Namespace, the container engine chowns the lower level to match the
> new user namespace and then sets up an overlay mount.  If the same image
> is used a second time, the container engine is smart enough to use the
> "chowned" image.  This chowning causes two problems on traditional
> Overlay systems.  One it is slow, since it is copying up all of the
> lower files to a new upper.  The second problem is now the kernel sees
> each executable/shared library as being different so process/memory
> sharing is broken in the kernel.  This means I get less containers
> running on a system do to memory.  The metacopyup feature of overlay
> solves both of these issues.  This is why we turn it on by default in
> Podman.  If I run podman in a new user namespace, in stead of it taking
> 30 seconds to chown the file system, it now takes < 2 seconds.
>
> Sadly still almost no one is using User Namespace separated containers,
> because they are not on by default.  The issue is users need to pick out
> unigue ranges of UIDs for each container they create/launch, and almost
> no one does.  I would propose that we fix this by making Podman do it by
> default. The idea would be to allocate 2 Billion UIDs on a system and
> then have podman pick a range of 65K uids for each root running
> container that it creates.  Container/storage would keep track of the
> selection.
>
> This would cause the chowning to happen every time a container was
> launched.  So I would like to continue to focus on the speed of
> chowning.  https://github.com/rhatdan/tools/chown.go is an effort to
> create a better tool for chowning that takes advantage of multi
> threading.  I would like to get this functionality into
> containers/storage to get container start times < 1 second, if possible.
>

Just to be clear, is Podman chowning all the files to a one specific
uig/gid? Or does it "shift" the values for each file for chown?

In any case, I imagine that integrating shiftfs logic into overlayfs should
be not that hard. If someone would do the work and the demand from
users exists I see nothing stopping that feature from getting upstream.
But seems that James and other shitfs developers need shifting to work
not only with overlayfs, so the way for shiftfs upstream is not yet paved.

Thanks,
Amir.
