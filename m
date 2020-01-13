Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 836F81394CA
	for <lists+linux-unionfs@lfdr.de>; Mon, 13 Jan 2020 16:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgAMP2b (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 13 Jan 2020 10:28:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35045 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726163AbgAMP2a (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 13 Jan 2020 10:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578929309;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=V4dOn9ukwekILXf3NzzX/sd4dO08qCr0efthzvtzTPw=;
        b=NrkaMhG9/gRFFD4YJG2hwinqM8+2ceEeCUMJdsBgaHIGBh8c+8qKqdF2dtcC9qZZ8nnU02
        0sRi2XODRIhexJpuLLEcW6j4d2AFFa48ede27XNk2E5XZw8m/pvvdyKq/OYq4uD3H1bU79
        dYAZzSeIFCnlIoqvPo/cDcA210QwcF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-1RFOhhcwMAWzWGFvaZ-WBg-1; Mon, 13 Jan 2020 10:28:28 -0500
X-MC-Unique: 1RFOhhcwMAWzWGFvaZ-WBg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 599A68024F0;
        Mon, 13 Jan 2020 15:28:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.18.25.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA70960BF1;
        Mon, 13 Jan 2020 15:28:24 +0000 (UTC)
Reply-To: dwalsh@redhat.com
Subject: Re: OverlaysFS offline tools
To:     Vivek Goyal <vgoyal@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        StuartIanNaylor <rolyantrauts@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        kmxz <kxzkxz7139@gmail.com>, "zhangyi (F)" <yi.zhang@huawei.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <CAOQ4uxjFC81hikgg0WaF0Z3Mxkk3iDakKx2Ttuhp_L_2Tnc6xQ@mail.gmail.com>
 <20200108140611.GA1995@redhat.com>
From:   Daniel Walsh <dwalsh@redhat.com>
Autocrypt: addr=dwalsh@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFsaqOEBCADBSnZCZpi262vX8m7iL/OdHKP9G9dhS28FR60cjd8nMPqHDNhQJBjLMZra
 66L2cCIEhc4HEItail7KU1BckrMc4laFaxL8tLoVTKHZwb74n2OcAJ4FtgzkNNlB1XJvSwC/
 909uwt7cpDqwXpJvyP3t17iuklB1OY0EEjTDt9aU4+0QjHzV18L4Cpd9iQ4ksu+EHT+pjlBk
 DdQB+hKoAjxPl11Eh6pZfrAcrNWpYBBk0A3XE9Jb6ghbmHWltNgVOsCa9GcswJHUEeFiOup6
 J5DTv6Xzwt0t6QB8nIs+wDJH+VxqAXcrxscnAhViIfGGS2AtxzjnVOz/J+UZPaauIGXTABEB
 AAG0LERhbmllbCBKIFdhbHNoIChGb3IgR2l0KSA8ZHdhbHNoQHJlZGhhdC5jb20+iQE4BBMB
 AgAiBQJbGqjhAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCi35Adq+LAKHuJB/98
 nZB5RmNjMWua4Ms8q5a1R9XWlDAb3mrST6JeL+uV/M0fa18e2Aw4/hi/WZHjAjoypLmcuaRx
 GeCbC8iYdpfRDUG79Y956Qq+Vs8c6VfNDMY1mvtfb00eeTaYoOCu0Aa9LDeR9iLKh2g0RI+N
 Zr3EU45RxZdacIs1v6mU8pGpyUq/FvuTGK9GzR9d1YeVCuSpQKN4ckHNZHJUXyk0vOZft1oO
 nSgLqM9EDWA+yz1JLmRYwbNsim7IvfVOav5mCgnKzHcL2mLv8qCnMFZjoQV8aGny/W739Z3a
 YJo1CdOg6zSu5SOvmq9idYrBRkwEtyLXss2oceTVBs0MxqQ/9mLPuQENBFsaqOEBCADDl2hl
 bUpqJGgwt2eQvs0Z0DCx/7nn0hlLfEn4WAv2HqP25AjIRXUX31Mzu68C4QnsvNtY4zN+FGRC
 EfUpYsjiL7vBYlRePhIohyMYU4RLp5eXFQKahHO/9Xlhe8mwueQNwYxNBPfMQ65U2AuqxpcS
 scx4s5w208mhqHoKz6IB2LuKeflhYfH5Y1FNAtVGHfhg22xlcAdupPPcxGuS4fBEW6PD/SDf
 Y4HT5iUHsyksQKjM0IFalqZ7YuLfXBl07OD2zU7WI9c3W0dwkvwIRjt3aD4iAah544uOLff+
 BzfxWghXeo80S2a1WCL0S/2qR0NVct/ExaDWboYr/bKpTa/1ABEBAAGJAR8EGAECAAkFAlsa
 qOECGwwACgkQot+QHaviwCi2hgf/XRvrt+VBmp1ZFxQAR9E6S7AtRT8KSytjFiqEC7TpOx3r
 2OZ4gZ3ZiW4TMW8hS7aYRgF1uYpLzl7BbrCfCHfAWEcXZ+uG8vayg8G/mLAcNlLY+JE76ATs
 53ziEY9R2Vb/wLMFd2nNBdqfwGcRH9N9VOej9vP76nCP01ZolY8Nms2hE383/+1Quxp5EedU
 BN5W5l7x9riBJyqCA63hr4u8wNsTuQgrDyhm/U1IvYeLtMopgotjnIR3KiTKOElbppLeXW3w
 EO/sQTPk+vQ4vcsJYY9Dnf1NlvHE4klj60GHjtjitsBEHzdE7s+J9FOxPmt8l+gMogGumKpN
 Y4lO0pfTyg==
Organization: Red Hat
Message-ID: <70a7e65d-40a5-7940-0d4d-14cdbfef39bd@redhat.com>
Date:   Mon, 13 Jan 2020 10:28:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200108140611.GA1995@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On 1/8/20 9:06 AM, Vivek Goyal wrote:
> On Wed, Jan 08, 2020 at 09:27:12AM +0200, Amir Goldstein wrote:
>> [-fsdevel,+containers]
>>
>>> On Thu, Apr 18, 2019 at 1:58 PM StuartIanNaylor <rolyantrauts@gmail.c=
om> wrote:
>>>> Apols to ask here but are there any tools for overlayFS?
>>>>
>>>> https://github.com/kmxz/overlayfs-tools is just about the only thing=
 I
>>>> can find.
>>> There is also https://github.com/hisilicon/overlayfs-progs which
>>> can check and fix overlay layers, but it hasn't been updated in a whi=
le.
>>>
>> Hi Vivek (and containers folks),
>>
>> Stuart has pinged me on https://github.com/StuartIanNaylor/zram-config=
/issues/4
>> to ask about the status of overlayfs offline tools.
>>
>> Quoting my answer here for visibility to more container developers:
>>
>> I have been involved with implementing many overlayfs features in the
>> kernel in the
>> past couple of years (redirect_dir,index,nfs_export,xino,metacopy).
>> All of these features bring benefits to end users, but AFAIK, they are=

>> all still disabled
>> by default in containers runtimes (?) because lack of tools support
>> (e.g. migration
>> /import/export). I cannot force anyone to use the new overlayfs
>> features nor to write
>> offline tools support for them.
>>
>> So how can we improve this situation?
>>
>> If the problem is development resources then I've had great experience=

>> in the past
>> with OSS internship programs like Google summer of code (GSoC):
>> Organizations, such as Redhat or mobyproject.org, can participate in t=
he program
>> by posting proposals for open source projects.
>> Developers, such as myself, volunteer to mentors projects and students=
 apply
>> to work on them.
>>
>> IIRC, the timeline for GSoC for project proposals in around April. App=
lying as
>> an organization could be before that.
>>
>> Vivek, since you are the only developer I know involved in containers =
runtime
>> projects I am asking you, but really its a question for all container =
developers
>> out there.
>>
>> Are you aware of missing features in containers that could be met by f=
illing the
>> gaps with overlayfs offline tools?
> CCing Dan Walsh as he is taking care of podman and often I hear some of=

> the the complaints from him w.r.t what he thinks is missing. This is
> not necessarily related to overlayfs offline tools.
>
> - Unpriviliged mounting of overlayfs.
> =20
>   He wants to launch containers unpriviliged and hence wants to be able=

>   to mount overlayfs without being root in init_user_ns. I think Miklos=

>   posted some patches for that but not much progress after that.
>
>   https://patchwork.kernel.org/cover/11212091/
>
> - shiftfs
>
>   As of now they are relying on doing chown of the image but will reall=
y
>   like to see the ability to shift uid/gids using shiftfs or using
>   VFS layer solution.
>
> - Overlayfs redirect_dir is not compatible with image building
>
>   redirect_dir is not compatible with image building and I think that's=

>   one reason that its not used by default. And as metacopy is dependent=

>   on redirect_dir, its not used by default as well. It can be used for
>   running containers though, but one needs to know that in advacnce.
>
>   So it will be good if that's fixed with redirect_dir and metacopy
>   features and then there is higher chance that these features are
>   enabled by default.
>
>   Miklos had some ides on how to tackle the issue of getting diff
>   correctly with redirect_dir enabled.
>
>   https://www.spinics.net/lists/linux-unionfs/msg06969.html
>
>   Having said that, I think Dan Walsh has enabled metacopy by default
>   in podman in certain configurations (for running containers and not
>   for building images).
>
> Thanks
> Vivek

Amir, Vivek did an excellent job of describing what we are attempting to
do with OverlayFS in container tools.=C2=A0 My work centers around
github.com/containers Specifically in podman(libpod), buildah, CRI-O,
Skopeo, containers/storage and containers/image.

The Podman tool is our most popular tool and runs containers with
metacopyup turned on by default, in at least Fedora and soon in RHEL8.=C2=
=A0
Not sure if it is turned on by default in Debian and Ubuntu releases, as
well as OpenSUSE and other distros.

On of the biggest features of these container engines (runtimes) is that
podman & Buildah can run rootless, using the user namespace. But sadly
we can not use overlayfs for this, since mounting of overlayfs requires
CAP_SYS_ADMIN.=C2=A0 As Vivek points out, Miklos is working to fix this.=C2=
=A0 For
now we use a FUSE version of overlay called fuse_overlayfs, which can
run rootless, but might not give us as good of performance as kernel
overlayfs.=C2=A0

The biggest feature I want to push for in container technologies is
better support for User Namespace.=C2=A0 I want to use it for container
separation, IE Each container would run with a different User
Namespace.=C2=A0 This means that root in one container would be a differe=
nt
UID then Root is a different container.=C2=A0 Currently almost no one use=
s
User Namespace for this kind of separation.=C2=A0 The difficulty is that =
the
kernel does not support a shifting file system, so if I want to share
the same base image image, (Lower directory) between multiple containers
in different User Namespaces, the UIDs end up wrong.=C2=A0 We have hoped =
for
a shifting file system for many years, but Overlay FS has never
developed it, (Fuse-overlay has some support for it).=C2=A0 There is an
effort in the kernel now to add a shifting file system, but I would bet
this will take a long time to get implemented.=C2=A0=C2=A0

The other option that we have built into our container engines is a
"chowing" image.=C2=A0 Basically when a new container is started, in a ne=
w
User Namespace, the container engine chowns the lower level to match the
new user namespace and then sets up an overlay mount.=C2=A0 If the same i=
mage
is used a second time, the container engine is smart enough to use the
"chowned" image.=C2=A0 This chowning causes two problems on traditional
Overlay systems.=C2=A0 One it is slow, since it is copying up all of the
lower files to a new upper.=C2=A0 The second problem is now the kernel se=
es
each executable/shared library as being different so process/memory
sharing is broken in the kernel.=C2=A0 This means I get less containers
running on a system do to memory.=C2=A0 The metacopyup feature of overlay=

solves both of these issues.=C2=A0 This is why we turn it on by default i=
n
Podman.=C2=A0 If I run podman in a new user namespace, in stead of it tak=
ing
30 seconds to chown the file system, it now takes < 2 seconds.

Sadly still almost no one is using User Namespace separated containers,
because they are not on by default.=C2=A0 The issue is users need to pick=
 out
unigue ranges of UIDs for each container they create/launch, and almost
no one does.=C2=A0 I would propose that we fix this by making Podman do i=
t by
default. The idea would be to allocate 2 Billion UIDs on a system and
then have podman pick a range of 65K uids for each root running
container that it creates.=C2=A0 Container/storage would keep track of th=
e
selection.=C2=A0

This would cause the chowning to happen every time a container was
launched.=C2=A0 So I would like to continue to focus on the speed of
chowning.=C2=A0 https://github.com/rhatdan/tools/chown.go is an effort to=

create a better tool for chowning that takes advantage of multi
threading.=C2=A0 I would like to get this functionality into
containers/storage to get container start times < 1 second, if possible.=C2=
=A0

These features are currently back burnered and could be a good use of a
GSOC student.

>
>> Are you a part of an organization that could consider posting this sor=
t of
>> project proposals to GSoC or other internship programs?
>>
>> Thanks,
>> Amir.
>>


