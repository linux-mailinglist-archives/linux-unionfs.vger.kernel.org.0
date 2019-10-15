Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 157CAD7867
	for <lists+linux-unionfs@lfdr.de>; Tue, 15 Oct 2019 16:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbfJOO0s (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 15 Oct 2019 10:26:48 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37500 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732050AbfJOO0s (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 15 Oct 2019 10:26:48 -0400
Received: by mail-yw1-f65.google.com with SMTP id m7so7404428ywe.4
        for <linux-unionfs@vger.kernel.org>; Tue, 15 Oct 2019 07:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zHujadyLI2o0RpLZHGpshhSzrQynr8CR/B6yTmxIu4s=;
        b=f2ZTKAyXrZmqpODaS68rnpDUd2urmhNE/GgyqOiqObdCTfNXC23CJfikSxx6jTcGkG
         P/oec2dGZHOjZ7CqZ7RDvGKBqBrIG+95GNgt+apn7P17j/pdG10VGCZ1f+tv6t+GG7Cb
         L0LoMDGy7Okjrr8sx4Mw6vIocPdSEFr6Cf81v+p1RczydQk8s2WIWK8BD1DF+VJOAVgw
         h39xzJPLlhoT3Ltn5hLRe+8OXZuVg/PXpbS63GicPgUVgTiYDMGOieGDEeO6VY9NdXMz
         TcvdrCxlPIaMSnPXuzyKK+yYeC21HbZzSxEPxa8VSGJKrPICdPiJGO+00v+jyS4GR0+W
         7GWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zHujadyLI2o0RpLZHGpshhSzrQynr8CR/B6yTmxIu4s=;
        b=ZWBAePVZMwveBedFu2EtgFnJrstxSE20CggfCaxqo1vgzN0+EQSmKW39i+oC6VCe6x
         G/64pM7kas1RMJWuvqew4W6OEUvGsofEeg49H9si1/Xz9wkwQ4zGFqkJdSwtNgwECc5w
         IfDPszvR1IDUEJY6ygEW0UFLB7PV6K2QU0sGDO9r1xtFF2JdS5qswymHtgHtH4/geG0M
         nzGlpnBpan6+ULXFg4cu+MSAXlzkWdF9mESY2kXwBZSr6oPLVIT3dwiWKbETZ7kfMsw5
         ipbx+ZeFaEci1f6bLM08nr5Hw/daoBiqzFh5s3JcPn/BMVSRO3P3W1K4BD4igqkwsT0o
         rI4A==
X-Gm-Message-State: APjAAAU6BiY8vUiiKBGUbOm+w1G3COHzq3xy4hextniN4dC4K6LtWvFG
        GCX2xmXYucKyeT2u+shEWYSe/LNvI1uLNE3O4yKzfRAk
X-Google-Smtp-Source: APXvYqzcWDBHqPzZZaHzJrThYiPGDOhAZMnJYz1LpgiFodalkX5fi7UFzvAiXwMW2vjZQk0rF9j0DIIzS5IrjK87EE4=
X-Received: by 2002:a81:83c7:: with SMTP id t190mr16115012ywf.88.1571149606074;
 Tue, 15 Oct 2019 07:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191004132030.28353-1-cgxu519@mykernel.net> <16dcef48c44.e916644e10200.8337178254202425670@mykernel.net>
In-Reply-To: <16dcef48c44.e916644e10200.8337178254202425670@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 15 Oct 2019 17:26:35 +0300
Message-ID: <CAOQ4uxjBNTY4d6VPDRSHy3didY502dVCDnvRfBy_fkRND2UVvw@mail.gmail.com>
Subject: Re: [PATCH] ovl: improving copy-up efficiency for sparse file
To:     cgxu519@mykernel.net
Cc:     miklos <miklos@szeredi.hu>,
        linux-unionfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Oct 15, 2019 at 2:38 PM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2019-10-04 21:20:30 Chenggua=
ng Xu <cgxu519@mykernel.net> =E6=92=B0=E5=86=99 ----
>  > Current copy-up is not efficient for sparse file,
>  > It's not only slow but also wasting more disk space
>  > when the target lower file has huge hole inside.
>  > This patch tries to recognize file hole and skip it
>  > during copy-up.
>  >
>  > In detail, this optimization checks the hole according
>  > to copy-up chunk size so it may not recognize all kind
>  > of holes in the file. However, it is easy to implement
>  > and will be enough for most of the time.

I must say I do not see how aligning to copy-up chunk size
simplifies the change. Why is that more complicated?

if (old_next_data_pos >=3D old_pos) {
      hole_len =3D old_next_data_pos - old_pos;
...

It can still copy hole up to this_len, because there is no
SEEK_HOLE, so you can document that.

>  >
>  > Additionally, this optimization relies on lseek(2)
>  > SEEK_DATA implementation, so for some specific
>  > filesystems which do not support this feature
>  > will behave as before on copy-up.
>  >

I am not sure if we support any lower fs with no f_op->llseek
in that case, copy up will not behave as before - it will return
-ESPIPE and will be a regression.

>  > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>  > ---
>
> Any better idea or suggestion for this?

This change should be accompanied with proper xfstests examining
all sorts of sparse files.
See overlay/001 and _run_seek_sanity_test for inspiration.

Perhaps you can run all _run_seek_sanity_test tests on
lower fs, then mount overlay. copy up all the sanity test
files and then check something???

Thanks,
Amir.


>
>
>  >  fs/overlayfs/copy_up.c | 15 ++++++++++++++-
>  >  1 file changed, 14 insertions(+), 1 deletion(-)
>  >
>  > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
>  > index b801c6353100..028033c9f021 100644
>  > --- a/fs/overlayfs/copy_up.c
>  > +++ b/fs/overlayfs/copy_up.c
>  > @@ -144,10 +144,11 @@ static int ovl_copy_up_data(struct path *old, st=
ruct path *new, loff_t len)
>  >          goto out;
>  >      /* Couldn't clone, so now we try to copy the data */
>  >
>  > -    /* FIXME: copy up sparse files efficiently */
>  >      while (len) {
>  >          size_t this_len =3D OVL_COPY_UP_CHUNK_SIZE;
>  >          long bytes;
>  > +        loff_t old_next_data_pos;
>  > +        loff_t hole_len;
>  >
>  >          if (len < this_len)
>  >              this_len =3D len;
>  > @@ -157,6 +158,18 @@ static int ovl_copy_up_data(struct path *old, str=
uct path *new, loff_t len)
>  >              break;
>  >          }
>  >
>  > +        old_next_data_pos =3D vfs_llseek(old_file, old_pos, SEEK_DATA=
);
>  > +        if (old_next_data_pos >=3D old_pos + OVL_COPY_UP_CHUNK_SIZE) =
{
>  > +            hole_len =3D (old_next_data_pos - old_pos) /
>  > +                OVL_COPY_UP_CHUNK_SIZE * OVL_COPY_UP_CHUNK_SIZE;
>  > +            old_pos +=3D hole_len;
>  > +            new_pos +=3D hole_len;
>  > +            len -=3D hole_len;
>  > +            continue;
>  > +        } else if (old_next_data_pos =3D=3D -ENXIO) {
>  > +            break;
>  > +        }
>  > +
>  >          bytes =3D do_splice_direct(old_file, &old_pos,
>  >                       new_file, &new_pos,
>  >                       this_len, SPLICE_F_MOVE);
>  > --
