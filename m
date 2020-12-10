Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A122D5760
	for <lists+linux-unionfs@lfdr.de>; Thu, 10 Dec 2020 10:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732663AbgLJJki (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 10 Dec 2020 04:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbgLJJkg (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 10 Dec 2020 04:40:36 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF82C061793
        for <linux-unionfs@vger.kernel.org>; Thu, 10 Dec 2020 01:39:55 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id b23so2501108vsp.9
        for <linux-unionfs@vger.kernel.org>; Thu, 10 Dec 2020 01:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lv1NfgTb7QIF3AXa/c4X8+rTmIE6V/EqKtuPGFR6zg8=;
        b=S7Pkm4cCLEf4W4nwx8c7uks4lJK8p3/l3GOZ1ira+Vv19bt2HnmTD4QjI4tfkEzNIj
         rAcSOaVsaZUwp3dwaYi12HGVGQIo/DJKFgNGpYZpWmlf7Z3oT7XRlTBL3jNn61FgQgQP
         A1SW+/t+IAi+hS2p1U4fvyLHgRh05nhpeoxv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lv1NfgTb7QIF3AXa/c4X8+rTmIE6V/EqKtuPGFR6zg8=;
        b=AwH/oZkbIDb7UCI662iEyHY2m6wRZNo9Dz/y3QTiOxkhaz7V0JzqBiPnS64OEnX8vg
         s7w4yrqpf5+5PaxeA9Gu0o/D2rTs31iSkFTj/gEaM/vW8v8n6lgxsJ6pTtXPZUZatxd7
         mnC08Do6xKwTU/8DGsGJm7tZ7CSnYJp23hHgal8r3pqJf1dLj8cDi8des0Vu7wz18D9u
         Xr/qXzgw8P7lgY0NFHvKrrtSaF+kfDCdJrgdGGcMvtvGXcQmYMf3h2Lsd1LEbnA3slL8
         gd7HkC/3dzLTag1jjmJ8awrbvVO9O21E9KtuAbphE54bURN2kouJrJxG/2mAwJTqxENh
         yNNg==
X-Gm-Message-State: AOAM533NBQNXKYVLCeyB3mVSrU54xyQADW+pDQj+FstRPnV+/5MbgxBp
        CApXiG2L04ZTwQwYsT7s/sBo9v60vb+6EMDm0tRXNg==
X-Google-Smtp-Source: ABdhPJxC25gs9iKjXNoeKLvSyprubfFJKB9elMWP9JJu4yk22W5JJYzGK+qDK5LYzdi+9eQj0J0q5TCPHorI5NHeZYk=
X-Received: by 2002:a05:6102:2:: with SMTP id j2mr6462091vsp.47.1607593195047;
 Thu, 10 Dec 2020 01:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20201207163255.564116-1-mszeredi@redhat.com> <1725e01a-4d4d-aecb-bad6-54aa220b4cd2@i-love.sakura.ne.jp>
 <7a64acab-dd05-765f-df2c-4896eb6a29df@canonical.com>
In-Reply-To: <7a64acab-dd05-765f-df2c-4896eb6a29df@canonical.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 10 Dec 2020 10:39:44 +0100
Message-ID: <CAJfpegsiuf8ib5cvVrr=zHZ+Xu7BMMTT2eYapsEUdmPcRBUiwQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] allow unprivileged overlay mounts
To:     John Johansen <john.johansen@canonical.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Miklos Szeredi <mszeredi@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, Dec 10, 2020 at 10:00 AM John Johansen
<john.johansen@canonical.com> wrote:
>
> On 12/8/20 2:27 AM, Tetsuo Handa wrote:
> > On 2020/12/08 1:32, Miklos Szeredi wrote:
> >> A general observation is that overlayfs does not call security_path_*()
> >> hooks on the underlying fs.  I don't see this as a problem, because a
> >> simple bind mount done inside a private mount namespace also defeats the
> >> path based security checks.  Maybe I'm missing something here, so I'm
> >> interested in comments from AppArmor and Tomoyo developers.
> >
> > Regarding TOMOYO, I don't want overlayfs to call security_path_*() hooks on the
> > underlying fs, but the reason is different. It is not because a simple bind mount
> > done inside a private mount namespace defeats the path based security checks.
> > TOMOYO does want to check what device/filesystem is mounted on which location. But
> > currently TOMOYO is failing to check it due to fsopen()/fsmount()/move_mount() API.
> >
>
> Regardless of TOMOYO's approach I would say that overlays should call the
> security_path_*() hooks, making it possible for an LSM to do something based off of
> them when needed.
>
> The current state of private mounts with regard to path based mediation is broken.
> I just haven't had time to try and come up with an acceptable fix for it. overlayfs
> is actually broken under apparmor mediation, and accesses to the lower layer end up
> getting denied but there is no way to properly allow them. So policy that hits this
> needs a flag set that allows for it in a very hacky way (its on the list of things
> to fix).
>
> Path based mediation has to carefully control mounts otherwise policy can be
> circumvented as Miklos rightly points out. Ideally path based LSM wouldn't allow
> you to do the simple bind mount inside a private mount namespace (at least not
> unless policy allowed for it). AppArmor does mediate the mount hooks and bind
> mounts in a private mount namespace (if they go through the LSM mount hooks) will
> be denied. Again the problem is how to allow them, and this is broken.

Okay, so what does that mean for overlayfs?

AA can deny the overlay mount just as well as the bind mount, and it
can allow it just as well as the bind mount.  Policy could be the
same.

Also all the security_path_ hooks will still get called for each
access on overlayfs itself.  They won't be called for the accesses
which overlayfs does on underlying layers, but is that needed?

Overlay could call those hooks itself (since the vfs_ helpers don't)
but the big question is whether that makes any sense.  AFAICS it might
make sense, but only if AA would correctly handle bind mounts, and
especially detached bind mounts (which is what overlayfs technically
uses).

Thanks,
Miklos

Tja
