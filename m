Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2244A1224A2
	for <lists+linux-unionfs@lfdr.de>; Tue, 17 Dec 2019 07:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfLQG1P (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 17 Dec 2019 01:27:15 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43643 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfLQG1P (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 17 Dec 2019 01:27:15 -0500
Received: by mail-io1-f66.google.com with SMTP id s2so9727821iog.10
        for <linux-unionfs@vger.kernel.org>; Mon, 16 Dec 2019 22:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rXyM2/SEH8O9YHXNS16UWLhaRRcLGXGQT4kvRxu4Hh4=;
        b=c5BcS84PRmoCt35+pPBOdcbABYVwE/vKnPlgeqKM86NzCsPnh2BVevYiAjdyg6DR3J
         8x4XS9iFJbTgickndr/E4WOK9m+ZnVEHv5InAE4ufZBqU3nXL+SM7cwzUnChXQufLj5i
         t6EdQmc3HrN1l8YAixqHJASW713HH6Uixkohw+IA65opdEg0P0sg6gaphVqI6pQXke4+
         Eg3ldWP6p6qESfzto7Hg7ZbJKP7oyIcSJ2ns3qIwvr88QIi/IaOggsN/3T1Z/epr0HTg
         Rtj5KIDrzZIC7vqa88WlUoMrsTP5tFO+69LxX79dP7PkTL3d7arvAwXse8mAI/3CopmB
         UdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rXyM2/SEH8O9YHXNS16UWLhaRRcLGXGQT4kvRxu4Hh4=;
        b=KuafKDdzDoLRpuP3x2QLVnkppWawQwUcVdRazRa1fKjvKbqiNt4LEy6KE4gwKGgPmG
         +1pAPxeMevQcyuCTRG7BGK06SiViUGYx+wK0SRT9xuQQ9htIW2Y+TFnFkAxYmo2cuIcl
         7apDIOqp2yvJFJYdjM+AwgiFiM/rgJkGb9rToFDnvwxw07c/ZL1N8rat1N2zHsDdfeXN
         xjRxz4NCU7Oknv0fAT9GPCe/hhBtqA3YYM2mHoORQ6hU+1luZrEAXVlToz+5bVSoEojQ
         2HOTAHZ0GYgRUo4Y1NIH+qO42N9GzCnREcb5ZzAshTjutWaJWqwsbsAoDzQ7jqO0wGjl
         4DnA==
X-Gm-Message-State: APjAAAW0Z8W7ufJpFLO2URuQ6QBA7i2jd5oRgxkFiyeimTVQaYFMCZm9
        s6JKJ4ZCZrh1uDDsWA6fH8xM2HDnCVAEmrTp1oUJ2Jdx
X-Google-Smtp-Source: APXvYqyJtBybjiNyoAq6CCjN3sXPIYfh7O/goAPRzYnL/JL33M5Bn4D03/IxXmgwZiZU/hLwrQG7qvPzFI094EN6K/8=
X-Received: by 2002:a02:81cc:: with SMTP id r12mr15148400jag.93.1576564034447;
 Mon, 16 Dec 2019 22:27:14 -0800 (PST)
MIME-Version: 1.0
References: <20191101123551.8849-1-cgxu519@mykernel.net> <CAOQ4uxi6g=UmfCjtZiyfgPhHc9+NCOQBQ++YeBTWmJaXjDNX_g@mail.gmail.com>
 <CAJfpegv39gDaVwLXx4+Vzb75Bv2fOfCHX8-bjS0N9QRkXo=G1Q@mail.gmail.com> <CAOQ4uxg59CxKaT_knYNf1YoX1fYXZ6tGHzEPLJMCe9ACip-SGw@mail.gmail.com>
In-Reply-To: <CAOQ4uxg59CxKaT_knYNf1YoX1fYXZ6tGHzEPLJMCe9ACip-SGw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 17 Dec 2019 08:27:03 +0200
Message-ID: <CAOQ4uxia14EUn=5HFNGL5AyydU=JUcLBS-sYbc9UM_i_-F_EyQ@mail.gmail.com>
Subject: Re: [PATCH v4] ovl: improving copy-up efficiency for big sparse file
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Chengguang Xu <cgxu519@mykernel.net>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Dec 16, 2019 at 4:03 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Dec 16, 2019 at 1:58 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Thu, Dec 12, 2019 at 4:43 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > It's the same old story that was fixed in commit:
> > > 6d0a8a90a5bb ovl: take lower dir inode mutex outside upper sb_writers lock
> > >
> > > The lower overlay inode mutex is taken inside ovl_llseek() while upper fs
> > > sb_writers is held since ovl_maybe_copy_up() of nested overlay.
> > >
> > > Since the lower overlay uses same real fs as nested overlay upper,
> > > this could really deadlock if the lower overlay inode is being modified
> > > (took inode mutex and trying to take real fs sb_writers).
> > >
> > > Not a very common case, but still a possible deadlock.
> > >
> > > The only way to avoid this deadlock is probably a bit too hacky for your taste:
> > >
> > >         /* Skip copy hole optimization for nested overlay */
> > >         if (old->mnt->mnt_sb->s_stack_depth)
> > >                 skip_hole = false;
> > >
> > > The other way is to use ovl_inode_lock() in ovl_llseek().
> > >
> > > Have any preference? Something else?
> > >
> > > Should we maybe use ovl_inode_lock() also in ovl_write_iter() and
> > > ovl_ioctl_set_flags()? In all those cases, we are not protecting the overlay
> > > inode members, but the real inode members from concurrent modification
> > > through overlay.
> >
> > Possibly.   I think this whole thing needs a good analysis of i_rwsem
> > use in overlayfs.
> >
>
> From what I can find, besides those 3 instances in file.c, there are
> two places I know of that access vfs_ functions on the overlay inode:
>
> 1. ovl_lookup_real_one(connected, ...), which takes the inode_lock itself
> 2. ovl_cache_update_ino(path, ...), which is called with inode_lock held
>
> In those places the locking is intentional and looks correct.
>
> And 3 more places that take inode_lock of overlay dir inode:
> 1. ovl_dir_llseek() - synchronize modifications to od->cache
>     and synchronize modifications to real f_pos
> 2. ovl_dir_fsync() - synchronize modifications to od->upperfile.
> 3. ovl_dir_release() - synchronize modifications to od->cache.
>
> Those 3 places were written before ovl_inode_lock existed.
>
> real f_pos could be protected by ovl_inode_lock same as ovl_llseek().
>
> od->upperfile could be protected by ovl_inode_lock same as copy up.
>
> od->cache is created/accessed from ovl_iterate() with inode_lock
> protection from vfs - I don't know if we want to change that to also take
> ovl_inode_lock, so not sure if we have a good reason to change locking
> in ovl dir operations.
>

On second thought, we can convert to protecting modifications of
od->cache and OVL_I(inode)->cache with ovl_inode_lock and then switch
to ->iterate_shared().

ovl_iterate() and ovl_seek_cursor() would walk on an elevated reference of
ovl_dir_cache instead of on od->cache directly.
impure dir cache would have to be refcounted as well.

Am I missing something?

I actually have one use case which may involve many concurrent readdirs
on a large directory, so this could be interesting for me to benchmark.

Thanks,
Amir.
