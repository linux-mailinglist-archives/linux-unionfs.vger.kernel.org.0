Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49B611288DD
	for <lists+linux-unionfs@lfdr.de>; Sat, 21 Dec 2019 12:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfLULgx (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sat, 21 Dec 2019 06:36:53 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34545 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfLULgx (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sat, 21 Dec 2019 06:36:53 -0500
Received: by mail-io1-f68.google.com with SMTP id z193so11988873iof.1
        for <linux-unionfs@vger.kernel.org>; Sat, 21 Dec 2019 03:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8r8GJoDryJ4p25jXLVQXp2iTb6DyjIklU687DLICT64=;
        b=rbe0fZ8U8e+oTt/nOSiawNSsg32yK3ag831SufZF7bnaRo+OuNQYAtOapXPecNFob/
         lfRdN5yskKsO7dRJdUTS55kiuOkBxEeR2DRfnOK1IRWsKV+BwBxEHje9EarqIGe2kVbw
         MU9Z+hEdLbAa9oommeAKlFe81/8rkkvblMSzvbIdpmwabS196tHMi5cOHqTJwPXaimsK
         GGJZfyda5tGtfgb2lGfI1EFgjJ76BqoBRHtILbtNJn/CoObhyFikQeQ6lrurZmo0Xb3a
         wu1O40XxYkAq6dLkSPurjiLocL610QRjT6THPQqgFbtnAIkZ0K/7CcfZVQjD0LiWIJ11
         PhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8r8GJoDryJ4p25jXLVQXp2iTb6DyjIklU687DLICT64=;
        b=uijHPTFDc1dRtpGpx62brJ7n8CEvQ7JFXRp8deFhblwPLr8EuYDvkC6TuAkUl/Wgcm
         +ZLJJKfkrrztwtJylxQS5ej2MZkKbXafEgQ18YZl+w+Ya3zQkIT+fS8OPKubCEHn5Out
         yFvzOkKDJFumUo/RwV+W/w2qSfpg1BX2Utg6sXc1XgmNE8r9LzSXFuiEIa8JDOWNhzVr
         XYvMTWK6AQETIb7std06x0/RibAf4Cjoa+D0bPV9SjSXUmhpCHNx1n2/2Z824+/HvEZx
         OVBo9pPkteA0y+fKOdrz2ZPPL+JNMYy4Sz4ky6eT+N6fE/qViqgDlTPOAAvhc+JyVN2/
         ecpw==
X-Gm-Message-State: APjAAAW7cxUrvJ0nxru5Md81C42zskse99JZEKl1LqJdimxWC1+2lBhO
        6OQFY+hjPIzL5PgFFN4tHLNJ2UuNReZ7x135FlKB21xR
X-Google-Smtp-Source: APXvYqyTEBaQAgBwrOLrz81SkERCGqEqbfkHPPKowlz/2LXm62bileyoCCEc9aVpgHPxtrSifA6ykz01U8xFxtFjfsw=
X-Received: by 2002:a6b:6b19:: with SMTP id g25mr13985363ioc.137.1576928212871;
 Sat, 21 Dec 2019 03:36:52 -0800 (PST)
MIME-Version: 1.0
References: <20191101123551.8849-1-cgxu519@mykernel.net> <CAOQ4uxi6g=UmfCjtZiyfgPhHc9+NCOQBQ++YeBTWmJaXjDNX_g@mail.gmail.com>
 <CAJfpegv39gDaVwLXx4+Vzb75Bv2fOfCHX8-bjS0N9QRkXo=G1Q@mail.gmail.com>
In-Reply-To: <CAJfpegv39gDaVwLXx4+Vzb75Bv2fOfCHX8-bjS0N9QRkXo=G1Q@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 21 Dec 2019 13:36:41 +0200
Message-ID: <CAOQ4uxjyTe=T_U1Jhj+JciBwHYRhB_pD3FbLZ+0TXmEe300TNw@mail.gmail.com>
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

Using ovl_inode_lock() in ovl_write_iter() and ovl_ioctl_set_flags() is not
as simple as in ovl_llseek(). And it is less important because those call
can not be made on a lower overlay.

So I'll send patches to convert ovl_llseek() ovl_dir_llseek() and
ovl_dir_fsync()
to use ovl_inode_lock(), which seems simple and passes the tests.

Thanks,
Amir.
