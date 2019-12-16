Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9281207DE
	for <lists+linux-unionfs@lfdr.de>; Mon, 16 Dec 2019 15:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfLPODY (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 16 Dec 2019 09:03:24 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36116 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfLPODY (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 16 Dec 2019 09:03:24 -0500
Received: by mail-io1-f66.google.com with SMTP id a22so7050109ios.3
        for <linux-unionfs@vger.kernel.org>; Mon, 16 Dec 2019 06:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PMCzY7FeGiejpj8yZ8O89EaFD1XZk8TnrbZG6B7+0CM=;
        b=cNEL2xuIkyIHePV5DYFAZm7hVP5Nj2K9HepRj1MbfSPU3NzIy2KOz/wn+KHIhOA4xu
         1MCPF2z6bKvTtTRJM2QIdUeq8ktlPNsVqMLyBer18RUEWncJWnXJwpYFuqpWMvelfZII
         CRWyuQQQFOs1LHdGVlrk1fs3Uy4pj9W31f4CZ9zn7Xa6WafdWh0iZL26gRjgE8f2ZbBs
         MdhG23GlKt6pKld93A5+nkAi9M3cgl4VukQlI5nIlx9zLLC01gAOy5ueLAbH4mJGXKmx
         4fT8rA/lpDj5D4v5wDRwcJ2K2W7JT+ZMrYTpUhiGQtBdKmBahkb6jy62jBWnEQMTQ7fw
         zzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PMCzY7FeGiejpj8yZ8O89EaFD1XZk8TnrbZG6B7+0CM=;
        b=Tuk17yg80YTQo24fJerZqnEsBV4+FRTO1e51RbcfGtK0JZ9tsX63j+UzzdgqMKL25O
         bU3Mk95qnOut41Mdm7A1JeNNjSwO8PeqrGVxbGZdZWJo/QtGp/YeSIV1uXRTif+u6/o4
         nmbPbYUXUuHw7A5fYriFute8Y9hYEpdSYVszHWl/t17vdMEKfgn9PhB//kTYLMg7Dv8t
         eOI3XOIH6BrBvH3PE/V3W7UET0BUCispxeSh33oTQWaItg3AvlpL5ZDKG6OKA6I+0LFv
         BYuIOPoAU9ppTP8PdNQJUPV6JILjzRhiJWLjzaGkvQ3WL6P+kiaYwK7qLCfOcgXlc1t9
         v5yw==
X-Gm-Message-State: APjAAAVKXtdrubTG+Y+6CD5NMXQUEQHX9E/6sRzcG82XzqCkrFNs1w2V
        4nOHi0453JhVto559KvrJZCHWpm7u+LoiN09GcI=
X-Google-Smtp-Source: APXvYqxDJzBep9ojd/Y3q3lWC7KrisxajNs0idsADjO24XRhcnyDTFXeNQSMUCB1qIa46lHdKaHGCdbUEVKwd18jJRo=
X-Received: by 2002:a5e:9907:: with SMTP id t7mr18557643ioj.72.1576505003872;
 Mon, 16 Dec 2019 06:03:23 -0800 (PST)
MIME-Version: 1.0
References: <20191101123551.8849-1-cgxu519@mykernel.net> <CAOQ4uxi6g=UmfCjtZiyfgPhHc9+NCOQBQ++YeBTWmJaXjDNX_g@mail.gmail.com>
 <CAJfpegv39gDaVwLXx4+Vzb75Bv2fOfCHX8-bjS0N9QRkXo=G1Q@mail.gmail.com>
In-Reply-To: <CAJfpegv39gDaVwLXx4+Vzb75Bv2fOfCHX8-bjS0N9QRkXo=G1Q@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 16 Dec 2019 16:03:12 +0200
Message-ID: <CAOQ4uxg59CxKaT_knYNf1YoX1fYXZ6tGHzEPLJMCe9ACip-SGw@mail.gmail.com>
Subject: Re: [PATCH v4] ovl: improving copy-up efficiency for big sparse file
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Chengguang Xu <cgxu519@mykernel.net>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Dec 16, 2019 at 1:58 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Thu, Dec 12, 2019 at 4:43 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > It's the same old story that was fixed in commit:
> > 6d0a8a90a5bb ovl: take lower dir inode mutex outside upper sb_writers lock
> >
> > The lower overlay inode mutex is taken inside ovl_llseek() while upper fs
> > sb_writers is held since ovl_maybe_copy_up() of nested overlay.
> >
> > Since the lower overlay uses same real fs as nested overlay upper,
> > this could really deadlock if the lower overlay inode is being modified
> > (took inode mutex and trying to take real fs sb_writers).
> >
> > Not a very common case, but still a possible deadlock.
> >
> > The only way to avoid this deadlock is probably a bit too hacky for your taste:
> >
> >         /* Skip copy hole optimization for nested overlay */
> >         if (old->mnt->mnt_sb->s_stack_depth)
> >                 skip_hole = false;
> >
> > The other way is to use ovl_inode_lock() in ovl_llseek().
> >
> > Have any preference? Something else?
> >
> > Should we maybe use ovl_inode_lock() also in ovl_write_iter() and
> > ovl_ioctl_set_flags()? In all those cases, we are not protecting the overlay
> > inode members, but the real inode members from concurrent modification
> > through overlay.
>
> Possibly.   I think this whole thing needs a good analysis of i_rwsem
> use in overlayfs.
>

From what I can find, besides those 3 instances in file.c, there are
two places I know of that access vfs_ functions on the overlay inode:

1. ovl_lookup_real_one(connected, ...), which takes the inode_lock itself
2. ovl_cache_update_ino(path, ...), which is called with inode_lock held

In those places the locking is intentional and looks correct.

And 3 more places that take inode_lock of overlay dir inode:
1. ovl_dir_llseek() - synchronize modifications to od->cache
    and synchronize modifications to real f_pos
2. ovl_dir_fsync() - synchronize modifications to od->upperfile.
3. ovl_dir_release() - synchronize modifications to od->cache.

Those 3 places were written before ovl_inode_lock existed.

real f_pos could be protected by ovl_inode_lock same as ovl_llseek().

od->upperfile could be protected by ovl_inode_lock same as copy up.

od->cache is created/accessed from ovl_iterate() with inode_lock
protection from vfs - I don't know if we want to change that to also take
ovl_inode_lock, so not sure if we have a good reason to change locking
in ovl dir operations.

Thanks,
Amir.
