Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF0A10904C
	for <lists+linux-unionfs@lfdr.de>; Mon, 25 Nov 2019 15:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfKYOpe (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 25 Nov 2019 09:45:34 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43619 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbfKYOpd (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 25 Nov 2019 09:45:33 -0500
Received: by mail-yb1-f194.google.com with SMTP id r201so6041729ybc.10
        for <linux-unionfs@vger.kernel.org>; Mon, 25 Nov 2019 06:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQDJSszF3tzKMcbxMKZd5w9nWR5CY3aYO54+CDh+wHU=;
        b=QCHa7FXTvsm2W8nGaqfCtTFNcVlGXw7mxKN7aunAkS5Yt4yuBtfqBJvtprmj2hvz7h
         TyE1In/ciYU3e3RIMeIHOYRMqGjzCvABzs/Nqt8wEB6ExBKWUIzn8zvc7P4JZO7P/D/z
         h4fZc3TOiXlasiIAtvyMDbouGQQ1hR1p0uyWh5zjp6y3qrBEUY9Q1JQnEdz2/yC+69wt
         YqkjIRuA4fP/0a9w6yutwU3JUtdbL4NrSWRiWapdtR8G8rrKke5c3U7CcY9n7ZcKOu4M
         M6xo2iqZaiArYUdQeodpkqdnaNHCttkigPSQGgURCPQxauM33zENmpZNc74MGlM9Za6h
         SuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQDJSszF3tzKMcbxMKZd5w9nWR5CY3aYO54+CDh+wHU=;
        b=qvF/pwLA++i7FzCPU7elS2MC4LtpmqsQWufR3aNuvuG1uxDcvQLUczFvKI+BDrVUXJ
         20O3gW0f3RicFkLubos8sctT7sdlJ2tDPCtekL+JbeUDUG03n9KcfY0j3uD/f9TWdEEE
         NPWbemkTX4b/Hw4gVnMsUbY8n83V3L5bitgPqolFQunydADTfWxbqElgfsL1td/e+TiD
         LgcDTdGB8OkV1982S5h52CorjwqnOnCR3aO86Hi3hnGKYtXfbdP852sigKwR7GuqMoc5
         QFF+w7E8HqxP2DvD8dk9+hF2gGdhjxAtaZaqAnyMPt00ezHWm5LgmAtqNWaYgtOx2rM9
         6EpA==
X-Gm-Message-State: APjAAAX/w6VC0Tn1Rqv7VT1hZUlzyddcXgUTYWpzX1A8PrtIKkxTDto+
        pWLamgaNtEwCdTfYBc4vUGfmUTmmf11Jau06V3s=
X-Google-Smtp-Source: APXvYqxofBsvSGqwd9NxlUnE14V1dP3muoD6EHRwOsnHTdDjLuvoHgJZ0Fl7eTBtPDn0fKH/cMm3uhSwii8a7tIwJtM=
X-Received: by 2002:a25:dc86:: with SMTP id y128mr22554947ybe.126.1574693132857;
 Mon, 25 Nov 2019 06:45:32 -0800 (PST)
MIME-Version: 1.0
References: <20191117154349.28695-1-amir73il@gmail.com> <CAOQ4uxjMbNVf9-1YjUpDzyaM_aV7OD0hi4m_AMbUvH3vUVn4sQ@mail.gmail.com>
 <CAOQ4uxjMsv2vE5Nn5D8TNCFxaz8b4duyOLOiPpy4qd1bs3bdwQ@mail.gmail.com> <CAOQ4uxi5QoV-WyY2rXhGpFoOfvcKh0Pm0tfU1vPvyk+rj0zCNQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxi5QoV-WyY2rXhGpFoOfvcKh0Pm0tfU1vPvyk+rj0zCNQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 25 Nov 2019 16:45:21 +0200
Message-ID: <CAOQ4uxi_p8u4=0xZuwY=ieU=6Lgj=D4fibGfHX1kWCcVqPkRaw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Sort out overlay layers and fs arrays
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Colin Ian King <colin.king@canonical.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Fri, Nov 22, 2019 at 11:31 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > > > I was also considering setting xino=on by default if xino_auto
> > > > is enabled, because what have we got to loose?
> > > >
> > > > The inodes whose st_ino fit in lower bits (by far more common) will
> > > > use overlay st_dev and the inodes whose st_ino overflow the lower bits
> > > > will use pseudo_dev. Seems like a win-win situation, but I wanted to
> > > > get your feedback on this before sending out a patch.
> > > >
> > >
> > > Arrr.. yes, there is a catch.
> > > Overflowing lower bits has a price beyond just using pseudo_dev.
> > > It introduces the possibility of inode number conflicts on directories,
> > > because directories never use pseudo_dev.
> > >
> >
> > But we could mitigate that problem if we reserve an fsid for volatile
> > directory inode numbers. get_next_ino is 32bit anyway.
> > I am going to take a swing at having xino=auto always enabling xino.
> >
>
> FWIW, pushed WIP branch to:
> https://github.com/amir73il/linux/commits/ovl-ino
>
> It is based on an updated ovl-layers branch of the $SUBJECT series.
>
> During cleanup, I've found several corner cases bugs of setting
> i_ino value and fixed them.
> None of those bugs are critical.
> AFAIK, the only user that complained on inconsistent i_ino is
> an xfstest that is checking ino in /proc/locks.
>
> However, I do think that the cleanup I made simplifies the code
> which was a bit spaghetti in that area and with some more TLC
> we can get to enabling xino from xino=auto even for filesystems
> that have seldom high ino bits.
>
> That could be a real benefit, because it is unlikely that users
> will have enough knowledge or certainty about underlying fs
> to declare xino=on.
>
> I need to clear up some time to test i_ino changes and
> the collision avoidance code, but for now, at least the ovl-ino branch
> passes the existing regression tests.
>

Documenting all this in words has become too complex for me,
so I resorted to visual aids [1].

The table doesn't mention this explicitly, but xino=auto can now
(code in ovl-ino) provide all desired features for any non-samefs setup.

Tests are still WIP. Will post the work when they are done.
I am using a nested overlay [2] as a way to test xino overflow behavior.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/blob/ovl-ino/Documentation/filesystems/overlayfs.rst#inode-properties
[2] https://github.com/amir73il/unionmount-testsuite/commits/ovl-nested
