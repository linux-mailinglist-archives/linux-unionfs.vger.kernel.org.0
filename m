Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08C11D8DB5
	for <lists+linux-unionfs@lfdr.de>; Wed, 16 Oct 2019 12:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfJPKUC (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 16 Oct 2019 06:20:02 -0400
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25918 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388969AbfJPKUC (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 16 Oct 2019 06:20:02 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571221188; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=YUb/p8ybjCU2Zkx0UPz9VpgMafrDoztePeBtFlbtI0FfpJL4Isbaa3wRIyZpCo7N7s3w5fW5U2Sxw4HSoh+y1+FkKWLfrenzmE/OomLTA0Jj2YCYu8Lljs8HZrRXJI3iC1/BH0TuBZemvFmGS1ekmw2utSivuZIylkXemo0EIZ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1571221188; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To:ARC-Authentication-Results; 
        bh=TR/jH2FmlaTocdCdBPgcSFq4X9EBSfTWdUe0BcYnBLs=; 
        b=OwNANUF7m+lCSMLBJkDGmK+BbtoSsWgiLzQLntu3jrew4IaWq4OcGkMjgXFo7YqPuIyel+y5dItG3H4tTmXaWzVgGwijO97UZIHpOYp59I8HjVqtZRZr4d+xbDXjwirynxoHwrQ+C0yH8zDjHWvLDBGRGA6ueHleJzW/ky2nP24=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571221188;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=4475; bh=TR/jH2FmlaTocdCdBPgcSFq4X9EBSfTWdUe0BcYnBLs=;
        b=X4Oprlg42WbWFAgnEj5mX0mhdJEaS0HAHUKkbYAbphkk0Fu/EbcdjeR6Voa2E28n
        2UBIcOcpJfamV2mnjHCCDnDmaeb8XZq/cel6Ym8/r7zkRnGYp7OcqFMEfntuzPWIIyy
        3f059wtaV3zdUG3pQbOIh+8RgVSE5UuBDxUj/igI=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 157122118667832.99223130558778; Wed, 16 Oct 2019 18:19:46 +0800 (CST)
Date:   Wed, 16 Oct 2019 18:19:46 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "miklos" <miklos@szeredi.hu>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>
Message-ID: <16dd414a872.c6d655bf12069.3408525011845835340@mykernel.net>
In-Reply-To: <CAOQ4uxjBNTY4d6VPDRSHy3didY502dVCDnvRfBy_fkRND2UVvw@mail.gmail.com>
References: <20191004132030.28353-1-cgxu519@mykernel.net> <16dcef48c44.e916644e10200.8337178254202425670@mykernel.net> <CAOQ4uxjBNTY4d6VPDRSHy3didY502dVCDnvRfBy_fkRND2UVvw@mail.gmail.com>
Subject: Re: [PATCH] ovl: improving copy-up efficiency for sparse file
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Priority: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2019-10-15 22:26:35 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > On Tue, Oct 15, 2019 at 2:38 PM Chengguang Xu <cgxu519@mykernel.net> wro=
te:
 > >
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2019-10-04 21:20:30 Cheng=
guang Xu <cgxu519@mykernel.net> =E6=92=B0=E5=86=99 ----
 > >  > Current copy-up is not efficient for sparse file,
 > >  > It's not only slow but also wasting more disk space
 > >  > when the target lower file has huge hole inside.
 > >  > This patch tries to recognize file hole and skip it
 > >  > during copy-up.
 > >  >
 > >  > In detail, this optimization checks the hole according
 > >  > to copy-up chunk size so it may not recognize all kind
 > >  > of holes in the file. However, it is easy to implement
 > >  > and will be enough for most of the time.
 >=20
 > I must say I do not see how aligning to copy-up chunk size
 > simplifies the change. Why is that more complicated?

Hi Amir,

Thanks for your feedback.=20
I would like to say if we do not align to copy-up chunk size then we have t=
o recognize exact size of=20
every hole in the lower file and that may need relying on both SEEK_HOLE an=
d SEEK_DATA methods.=20
However, currently SEEK_HOLE implementation seems not so reliable. Look dee=
p into the code,
generic_file_llseek() could not work correctly for SEEK_HOLE in our check, =
so it means for filesystems
which don't have their own version of  f_op->llseek function will get probl=
em.


 >=20
 > if (old_next_data_pos >=3D old_pos) {
 >       hole_len =3D old_next_data_pos - old_pos;
 > ...
 >=20
 > It can still copy hole up to this_len, because there is no
 > SEEK_HOLE, so you can document that.

I'll do.

 >=20
 > >  >
 > >  > Additionally, this optimization relies on lseek(2)
 > >  > SEEK_DATA implementation, so for some specific
 > >  > filesystems which do not support this feature
 > >  > will behave as before on copy-up.
 > >  >
 >=20
 > I am not sure if we support any lower fs with no f_op->llseek
 > in that case, copy up will not behave as before - it will return
 > -ESPIPE and will be a regression.

We need adding a check for lower fs llseek support and catching
llseek error for safety. If we notice the optimization could not work
then we back to original copy-up behavior.


 >=20
 > >  > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > >  > ---
 > >
 > > Any better idea or suggestion for this?
 >=20
 > This change should be accompanied with proper xfstests examining
 > all sorts of sparse files.
 > See overlay/001 and _run_seek_sanity_test for inspiration.
 >=20
 > Perhaps you can run all _run_seek_sanity_test tests on
 > lower fs, then mount overlay. copy up all the sanity test
 > files and then check something???
 >=20

Yeah, thanks for your suggestion, I'll do more work on testing.

Thanks,
Chengguang

 >=20
 >=20
 > >
 > >
 > >  >  fs/overlayfs/copy_up.c | 15 ++++++++++++++-
 > >  >  1 file changed, 14 insertions(+), 1 deletion(-)
 > >  >
 > >  > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
 > >  > index b801c6353100..028033c9f021 100644
 > >  > --- a/fs/overlayfs/copy_up.c
 > >  > +++ b/fs/overlayfs/copy_up.c
 > >  > @@ -144,10 +144,11 @@ static int ovl_copy_up_data(struct path *old,=
 struct path *new, loff_t len)
 > >  >          goto out;
 > >  >      /* Couldn't clone, so now we try to copy the data */
 > >  >
 > >  > -    /* FIXME: copy up sparse files efficiently */
 > >  >      while (len) {
 > >  >          size_t this_len =3D OVL_COPY_UP_CHUNK_SIZE;
 > >  >          long bytes;
 > >  > +        loff_t old_next_data_pos;
 > >  > +        loff_t hole_len;
 > >  >
 > >  >          if (len < this_len)
 > >  >              this_len =3D len;
 > >  > @@ -157,6 +158,18 @@ static int ovl_copy_up_data(struct path *old, =
struct path *new, loff_t len)
 > >  >              break;
 > >  >          }
 > >  >
 > >  > +        old_next_data_pos =3D vfs_llseek(old_file, old_pos, SEEK_D=
ATA);
 > >  > +        if (old_next_data_pos >=3D old_pos + OVL_COPY_UP_CHUNK_SIZ=
E) {
 > >  > +            hole_len =3D (old_next_data_pos - old_pos) /
 > >  > +                OVL_COPY_UP_CHUNK_SIZE * OVL_COPY_UP_CHUNK_SIZE;
 > >  > +            old_pos +=3D hole_len;
 > >  > +            new_pos +=3D hole_len;
 > >  > +            len -=3D hole_len;
 > >  > +            continue;
 > >  > +        } else if (old_next_data_pos =3D=3D -ENXIO) {
 > >  > +            break;
 > >  > +        }
 > >  > +
 > >  >          bytes =3D do_splice_direct(old_file, &old_pos,
 > >  >                       new_file, &new_pos,
 > >  >                       this_len, SPLICE_F_MOVE);
 > >  > --
 >

