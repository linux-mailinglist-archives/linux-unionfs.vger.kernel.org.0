Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78F301068DE
	for <lists+linux-unionfs@lfdr.de>; Fri, 22 Nov 2019 10:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfKVJcJ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 22 Nov 2019 04:32:09 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41470 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfKVJcJ (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 22 Nov 2019 04:32:09 -0500
Received: by mail-yw1-f67.google.com with SMTP id j190so2240039ywf.8
        for <linux-unionfs@vger.kernel.org>; Fri, 22 Nov 2019 01:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q9GjCuANRvoppzwTQZmx08jCm74GBbxt6WJj6IHcE1k=;
        b=pKkIYFlz0Hq0s5Hd2Geq3fWu7g0bNn3ocxLo7vEYPWW4vn7aZpbnTpCebeBoSQMDkc
         w8t1gUy70pSWHGm7qPQezmzNavsKDkR7+sXlOt0lLm2XIUCS2dNHwnWoV82M208WSeHk
         NC2OloDGGmioX685Z0A33wEigS8tsTLJoduk+UIYPwIPaWjzU3JwgKyEyjavNU1zFKZP
         22Q95mpqBl98pB8WFrgZvhL9BwTITC5ftBOMp3uq1c5quZcQw4Zr/2u5Ea6o1ohEY+zy
         qDgyRwr5e6SloC7sESt1zTGE2HteJ+TKC/JYzt1ZOwAd6SO0sIpuJucVumu+CWUgUWId
         q4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q9GjCuANRvoppzwTQZmx08jCm74GBbxt6WJj6IHcE1k=;
        b=ub8mIhwf+gB9kaMaAXJkUgHC8hHNMzEHQctj7zgWEs7o967SdRYxCmkSHLE4ykDSix
         HFv7rSHXAWhTKU9tqUR6RwG6/IRCqOVoIW+nuRwZ/OKJ7HnN7vnKr0pwT/hQ4uuXNx/m
         Z2HNdJhUgr+Fp1/RL6d5FDCZJQkNLIWknoEjZiYdOWHcRJHVelsT6VxyGZ2hRk9dPbXU
         VwDe8/W6YVCbQj8amo04+0wOKhyPWvQmhIOINct/TjytiMWlBr+WzZY7BN0Ipaa0TBuH
         zxoQlYmWGt+5YseX2oSg7ljW5g0eBxQbwMHPlImsCrXenAjI7fk7Zsx+ZRruqywLWR2Y
         mLGA==
X-Gm-Message-State: APjAAAWa1lKl8vx4ccKXYE2KDpk5aSi2pO+eU/li+Jfa0gc4frp5+bmm
        URi5iZxKeWEIDfPZNM3Wf7BfsZ+vQViycMT1v7Y=
X-Google-Smtp-Source: APXvYqzuZx6LDEUp4DSyabyfHCJPugCB0dLM2r21vByensLDAuZT9oLA0In/J34pcNWhigi5xG4BQcpCfyN4GAcTjMM=
X-Received: by 2002:a81:234c:: with SMTP id j73mr8538495ywj.181.1574415126222;
 Fri, 22 Nov 2019 01:32:06 -0800 (PST)
MIME-Version: 1.0
References: <20191117154349.28695-1-amir73il@gmail.com> <CAOQ4uxjMbNVf9-1YjUpDzyaM_aV7OD0hi4m_AMbUvH3vUVn4sQ@mail.gmail.com>
 <CAOQ4uxjMsv2vE5Nn5D8TNCFxaz8b4duyOLOiPpy4qd1bs3bdwQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjMsv2vE5Nn5D8TNCFxaz8b4duyOLOiPpy4qd1bs3bdwQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 22 Nov 2019 11:31:55 +0200
Message-ID: <CAOQ4uxi5QoV-WyY2rXhGpFoOfvcKh0Pm0tfU1vPvyk+rj0zCNQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Sort out overlay layers and fs arrays
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Colin Ian King <colin.king@canonical.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

> > > I was also considering setting xino=on by default if xino_auto
> > > is enabled, because what have we got to loose?
> > >
> > > The inodes whose st_ino fit in lower bits (by far more common) will
> > > use overlay st_dev and the inodes whose st_ino overflow the lower bits
> > > will use pseudo_dev. Seems like a win-win situation, but I wanted to
> > > get your feedback on this before sending out a patch.
> > >
> >
> > Arrr.. yes, there is a catch.
> > Overflowing lower bits has a price beyond just using pseudo_dev.
> > It introduces the possibility of inode number conflicts on directories,
> > because directories never use pseudo_dev.
> >
>
> But we could mitigate that problem if we reserve an fsid for volatile
> directory inode numbers. get_next_ino is 32bit anyway.
> I am going to take a swing at having xino=auto always enabling xino.
>

FWIW, pushed WIP branch to:
https://github.com/amir73il/linux/commits/ovl-ino

It is based on an updated ovl-layers branch of the $SUBJECT series.

During cleanup, I've found several corner cases bugs of setting
i_ino value and fixed them.
None of those bugs are critical.
AFAIK, the only user that complained on inconsistent i_ino is
an xfstest that is checking ino in /proc/locks.

However, I do think that the cleanup I made simplifies the code
which was a bit spaghetti in that area and with some more TLC
we can get to enabling xino from xino=auto even for filesystems
that have seldom high ino bits.

That could be a real benefit, because it is unlikely that users
will have enough knowledge or certainty about underlying fs
to declare xino=on.

I need to clear up some time to test i_ino changes and
the collision avoidance code, but for now, at least the ovl-ino branch
passes the existing regression tests.

Thanks,
Amir.
