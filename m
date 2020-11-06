Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4362A9E3C
	for <lists+linux-unionfs@lfdr.de>; Fri,  6 Nov 2020 20:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgKFTnE (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 6 Nov 2020 14:43:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728115AbgKFTnE (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 6 Nov 2020 14:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604691783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hmHRXn1ak8zZ+HJUGeINQuX1LbrSbCrxVwvKOn5kExM=;
        b=MFrv7G27+Gf4AUcaghZa8dEWTk35dIgG9h1bftLmBupAKSzHm8goCZbKN+lbaXkoAUn8kz
        7OeVRMDcKi9IluBuzxu2bZWqTWv/wY7jM7FEBvZbKVsPOZG725fjCH07MKAgNTn1+pYZWp
        x3tZzaTvsuZkL7wbZCfVHoYVwW9Fehg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-ydMGxGWyPVGIb3fQzMbJVg-1; Fri, 06 Nov 2020 14:42:59 -0500
X-MC-Unique: ydMGxGWyPVGIb3fQzMbJVg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21C271006C81;
        Fri,  6 Nov 2020 19:42:58 +0000 (UTC)
Received: from localhost (ovpn-112-27.ams2.redhat.com [10.36.112.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A52336198D;
        Fri,  6 Nov 2020 19:42:57 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH v7] overlayfs: Provide a mount option "volatile" to skip
 sync
References: <20200831181529.GA1193654@redhat.com>
        <CAMp4zn9dF-umZF-LP=f6qWekyupsXTB6B8CeH6km7=9oVYV+NA@mail.gmail.com>
        <20201106190325.GB1445528@redhat.com>
Date:   Fri, 06 Nov 2020 20:42:55 +0100
In-Reply-To: <20201106190325.GB1445528@redhat.com> (Vivek Goyal's message of
        "Fri, 6 Nov 2020 14:03:25 -0500")
Message-ID: <87o8kamfuo.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:

> On Fri, Nov 06, 2020 at 09:58:39AM -0800, Sargun Dhillon wrote:
>
> [..]
>> There is some slightly confusing behaviour here [I realize this
>> behaviour is as intended]:
>> 
>> (root) ~ # mount -t overlay -o
>> volatile,index=off,lowerdir=/root/lowerdir,upperdir=/root/upperdir,workdir=/root/workdir
>> none /mnt/foo
>> (root) ~ # umount /mnt/foo
>> (root) ~ # mount -t overlay -o
>> volatile,index=off,lowerdir=/root/lowerdir,upperdir=/root/upperdir,workdir=/root/workdir
>> none /mnt/foo
>> mount: /mnt/foo: wrong fs type, bad option, bad superblock on none,
>> missing codepage or helper program, or other error.
>> 
>> From my understanding, the dirty flag should only be a problem if the
>> existing overlayfs is unmounted uncleanly. Docker does
>> this (mount, and re-mounts) during startup time because it writes some
>> files to the overlayfs. I think that we should harden
>> the volatile check slightly, and make it so that within the same boot,
>> it's not a problem, and having to have the user clear
>> the workdir every time is a pain. In addition, the semantics of the
>> volatile patch itself do not appear to be such that they
>> would break mounts during the same boot / mount of upperdir -- as
>> overlayfs does not defer any writes in itself, and it's
>> only that it's short-circuiting writes to the upperdir.
>
> umount does a sync normally and with "volatile" overlayfs skips that
> sync. So a successful unmount does not mean that file got synced
> to backing store. It is possible, after umount, system crashed
> and after reboot, user tried to mount upper which is corrupted
> now and overlay will not detect it.
>
> You seem to be asking for an alternate option where we disable
> fsync() but not syncfs. In that case sync on umount will still
> be done. And that means a successful umount should mean upper
> is fine and it could automatically remove incomapt dir upon
> umount.

could this be handled in user space?  It should still be possible to do
the equivalent of:

# sync -f /root/upperdir
# rm -rf /root/workdir/incompat/volatile

Regards,
Giuseppe

