Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC2711D13A
	for <lists+linux-unionfs@lfdr.de>; Thu, 12 Dec 2019 16:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfLLPnF (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 12 Dec 2019 10:43:05 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38771 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbfLLPnF (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 12 Dec 2019 10:43:05 -0500
Received: by mail-yb1-f195.google.com with SMTP id l129so548452ybf.5
        for <linux-unionfs@vger.kernel.org>; Thu, 12 Dec 2019 07:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqV2vlCh1Fa3quWxno2mYE77AlEFYJyhEO3Zyf4Q/eo=;
        b=al0w26zYCtL/vFnhcggZJKMA2afJ4OdkKZoKHDZnmB01TkGHUcN8j7L2qwrY/j8er7
         z1w4CZjRPb5HhQGNHCWg3tJ4hT9lmxkwCaQEUi/iJuHcmB7DVTUp9xIgjrRIZ36eaZ+b
         2EU1VT4BU3zfX0aSVXn2WpXbrc59rBHGHY4baoytSIJVmHWj+nJRa39MBefnGif4gEG2
         FVx2Jyqi3/MDu5gc2RLc31pHklxAEY9mFH0KeAXQ2EkaMJ4R5PV8kE4nYetN950SB+WR
         QuDK35Hr/33OHwpcAMd+4r9mRMjedYOW4IJsGNlq+GTPnSmTZKDxjrNbk60weafI3d+G
         CaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqV2vlCh1Fa3quWxno2mYE77AlEFYJyhEO3Zyf4Q/eo=;
        b=iagSl1egVyikLjB9qvlyntqbvR5VrEZB2s/0WOd06PgH0fccvC1I/VcD/KWbQ8woeE
         PvbF0e+KGavERrCWYAe4zDckBT81xTiE8aq4GIwOPSw8BktfjZZ6WNlYvdBq6uM3Y75m
         3uy/RI0quze4qeGUlgkQwtmTE9qADwyoVhDPyMtYcZ3Bghen1uAPloreF5YZtQInbgdQ
         ZswChrsGcQ9q82N2tJ2jgvSnhxJLWazm6j/dwcTfPKAM+MDgkEV/OLU1HdJ6AciYLs9r
         zYqnZpHuKacxrE6pjUXAJik//2f9A4D/u9WGazJwvcmQYuQpSrbDvtgA6y0Jl06JZxNV
         QG6g==
X-Gm-Message-State: APjAAAV/NLQ9XipzVDxGBswzwSw9ByyfDOgnCKtj/YUOp3L6Vz6R16ck
        K8HJHt24F4PN7m577t5pZPEDqDsWjh37prLo0HcRMCNf
X-Google-Smtp-Source: APXvYqyci2mpFi/Oc+AumlVcR+L/5MjHPdiYc2XU5iesAcLw5VoQzmeoL3qSg7D7TlYwUkJAw46RkhR0nmDqxNwmIQM=
X-Received: by 2002:a25:1506:: with SMTP id 6mr4466830ybv.126.1576165383877;
 Thu, 12 Dec 2019 07:43:03 -0800 (PST)
MIME-Version: 1.0
References: <20191101123551.8849-1-cgxu519@mykernel.net>
In-Reply-To: <20191101123551.8849-1-cgxu519@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 12 Dec 2019 17:42:52 +0200
Message-ID: <CAOQ4uxi6g=UmfCjtZiyfgPhHc9+NCOQBQ++YeBTWmJaXjDNX_g@mail.gmail.com>
Subject: Re: [PATCH v4] ovl: improving copy-up efficiency for big sparse file
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Fri, Nov 1, 2019 at 2:36 PM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> Current copy-up is not efficient for big sparse file,
> It's not only slow but also wasting more disk space
> when the target lower file has huge hole inside.
> This patch tries to recognize file hole and skip it
> during copy-up.
>
> Detail logic of hole detection as below:
> When we detect next data position is larger than current
> position we will skip that hole, otherwise we copy
> data in the size of OVL_COPY_UP_CHUNK_SIZE. Actually,
> it may not recognize all kind of holes and sometimes
> only skips partial of hole area. However, it will be
> enough for most of the use cases.
>
> Additionally, this optimization relies on lseek(2)
> SEEK_DATA implementation, so for some specific
> filesystems which do not support this feature
> will behave as before on copy-up.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
> v1->v2:
> - Set file size when the hole is in the end of the file.
> - Add a code comment for hole copy-up improvement.
> - Check SEEK_DATA support before doing hole skip.
> - Back to original copy-up when seek data fails(in error case).
>
> v2->v3:
> - Detect big continuous holes in an effective way.
> - Modify changelog and code comment.
> - Set file size in the end of ovl_copy_up_inode().
>
> v3->v4:
> - Truncate var name of old_next_data_pos to data_pos.
> - Check hole only when data_pos < old_pos.
>
>  fs/overlayfs/copy_up.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index b801c6353100..55f1e81507ca 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -123,6 +123,9 @@ static int ovl_copy_up_data(struct path *old, struct path *new, loff_t len)
>         loff_t old_pos = 0;
>         loff_t new_pos = 0;
>         loff_t cloned;
> +       loff_t data_pos = -1;
> +       loff_t hole_len;
> +       bool skip_hole = false;
>         int error = 0;
>
>         if (len == 0)
> @@ -144,7 +147,11 @@ static int ovl_copy_up_data(struct path *old, struct path *new, loff_t len)
>                 goto out;
>         /* Couldn't clone, so now we try to copy the data */
>
> -       /* FIXME: copy up sparse files efficiently */
> +       /* Check if lower fs supports seek operation */
> +       if (old_file->f_mode & FMODE_LSEEK &&
> +           old_file->f_op->llseek)
> +               skip_hole = true;
> +
>         while (len) {
>                 size_t this_len = OVL_COPY_UP_CHUNK_SIZE;
>                 long bytes;
> @@ -157,6 +164,36 @@ static int ovl_copy_up_data(struct path *old, struct path *new, loff_t len)
>                         break;
>                 }
>
> +               /*
> +                * Fill zero for hole will cost unnecessary disk space
> +                * and meanwhile slow down the copy-up speed, so we do
> +                * an optimization for hole during copy-up, it relies
> +                * on SEEK_DATA implementation in lower fs so if lower
> +                * fs does not support it, copy-up will behave as before.
> +                *
> +                * Detail logic of hole detection as below:
> +                * When we detect next data position is larger than current
> +                * position we will skip that hole, otherwise we copy
> +                * data in the size of OVL_COPY_UP_CHUNK_SIZE. Actually,
> +                * it may not recognize all kind of holes and sometimes
> +                * only skips partial of hole area. However, it will be
> +                * enough for most of the use cases.
> +                */
> +
> +               if (skip_hole && data_pos < old_pos) {
> +                       data_pos = vfs_llseek(old_file, old_pos, SEEK_DATA);


Miklos,

Now that this change is on overlayfs-next, I realize that it triggers a new
lockdep warning on on of my nested overlay tests.

It's the same old story that was fixed in commit:
6d0a8a90a5bb ovl: take lower dir inode mutex outside upper sb_writers lock

The lower overlay inode mutex is taken inside ovl_llseek() while upper fs
sb_writers is held since ovl_maybe_copy_up() of nested overlay.

Since the lower overlay uses same real fs as nested overlay upper,
this could really deadlock if the lower overlay inode is being modified
(took inode mutex and trying to take real fs sb_writers).

Not a very common case, but still a possible deadlock.

The only way to avoid this deadlock is probably a bit too hacky for your taste:

        /* Skip copy hole optimization for nested overlay */
        if (old->mnt->mnt_sb->s_stack_depth)
                skip_hole = false;

The other way is to use ovl_inode_lock() in ovl_llseek().

Have any preference? Something else?

Should we maybe use ovl_inode_lock() also in ovl_write_iter() and
ovl_ioctl_set_flags()? In all those cases, we are not protecting the overlay
inode members, but the real inode members from concurrent modification
through overlay.

Thanks,
Amir.
