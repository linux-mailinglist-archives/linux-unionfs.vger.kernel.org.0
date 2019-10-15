Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB64CD732F
	for <lists+linux-unionfs@lfdr.de>; Tue, 15 Oct 2019 12:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfJOK0p (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 15 Oct 2019 06:26:45 -0400
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25985 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730668AbfJOK0o (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 15 Oct 2019 06:26:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571135197; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=ECYqDQnhUPk4rSIhrci1glvlnAFbs4kA7Fa+yT+ESHnfe18aXrl4w7/wHJSyNggDHBKBYK7qtKzVN/1ZXsaF5c9+NVYPQvyFYUxr25x74lZ8nhStlY1EQGFUfTIjNzgLlgQX1Sku7fxoU1bg6ndjn017LGCWWUiaSB5cBOMwNS8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1571135197; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To:ARC-Authentication-Results; 
        bh=YHPKmJBO7N2BuBphg2YJKjRlNFGA/Y6OHT5xTOndyjM=; 
        b=C/ro3SXPPFh0jAHP7mi2qGSegly6M8nz4R9tyl3B+0KGGnsZcGPm6fFDey/pxZW4+QFHBjYhoCSGXTYpsNFnYlvq4cYvaxelFBpO5aibnu4Ry0JvkTfgkserkQiUcgNiliZq+NSsailEFQ/3Zk0szrgQqFdBPvhcdoSeHHAGXR8=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571135197;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=2347; bh=YHPKmJBO7N2BuBphg2YJKjRlNFGA/Y6OHT5xTOndyjM=;
        b=bnAnTad1zcKkixtYYNkrDNVqVjOYzaOcxG+3Aw2d6LlQvNDfRhyo84WYHbih0O72
        ha2r8hWtIdqNhVtkrqp6H9XRY7ZrJ9cd3ubZRr3q3dBOFF+5PWcctv7zNDjSBHWGU4r
        GgXvLtLx3C/DrrnPkNsyY5/Lh7+9Z70ZQTp3Brug=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1571135196230713.348723247547; Tue, 15 Oct 2019 18:26:36 +0800 (CST)
Date:   Tue, 15 Oct 2019 18:26:36 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "miklos" <miklos@szeredi.hu>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>
Cc:     "Chengguang Xu" <cgxu519@mykernel.net>
Message-ID: <16dcef48c44.e916644e10200.8337178254202425670@mykernel.net>
In-Reply-To: <20191004132030.28353-1-cgxu519@mykernel.net>
References: <20191004132030.28353-1-cgxu519@mykernel.net>
Subject: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D:[PATCH]_ovl:_improving_copy?=
 =?UTF-8?Q?-up_efficiency_for_sparse_file?=
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2019-10-04 21:20:30 Chengguang=
 Xu <cgxu519@mykernel.net> =E6=92=B0=E5=86=99 ----
 > Current copy-up is not efficient for sparse file,
 > It's not only slow but also wasting more disk space
 > when the target lower file has huge hole inside.
 > This patch tries to recognize file hole and skip it
 > during copy-up.
 >=20
 > In detail, this optimization checks the hole according
 > to copy-up chunk size so it may not recognize all kind
 > of holes in the file. However, it is easy to implement
 > and will be enough for most of the time.
 >=20
 > Additionally, this optimization relies on lseek(2)
 > SEEK_DATA implementation, so for some specific
 > filesystems which do not support this feature
 > will behave as before on copy-up.
 >=20
 > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > ---

Any better idea or suggestion for this?


Thanks,
Chengguang


 >  fs/overlayfs/copy_up.c | 15 ++++++++++++++-
 >  1 file changed, 14 insertions(+), 1 deletion(-)
 >=20
 > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
 > index b801c6353100..028033c9f021 100644
 > --- a/fs/overlayfs/copy_up.c
 > +++ b/fs/overlayfs/copy_up.c
 > @@ -144,10 +144,11 @@ static int ovl_copy_up_data(struct path *old, stru=
ct path *new, loff_t len)
 >          goto out;
 >      /* Couldn't clone, so now we try to copy the data */
 > =20
 > -    /* FIXME: copy up sparse files efficiently */
 >      while (len) {
 >          size_t this_len =3D OVL_COPY_UP_CHUNK_SIZE;
 >          long bytes;
 > +        loff_t old_next_data_pos;
 > +        loff_t hole_len;
 > =20
 >          if (len < this_len)
 >              this_len =3D len;
 > @@ -157,6 +158,18 @@ static int ovl_copy_up_data(struct path *old, struc=
t path *new, loff_t len)
 >              break;
 >          }
 > =20
 > +        old_next_data_pos =3D vfs_llseek(old_file, old_pos, SEEK_DATA);
 > +        if (old_next_data_pos >=3D old_pos + OVL_COPY_UP_CHUNK_SIZE) {
 > +            hole_len =3D (old_next_data_pos - old_pos) /
 > +                OVL_COPY_UP_CHUNK_SIZE * OVL_COPY_UP_CHUNK_SIZE;
 > +            old_pos +=3D hole_len;
 > +            new_pos +=3D hole_len;
 > +            len -=3D hole_len;
 > +            continue;
 > +        } else if (old_next_data_pos =3D=3D -ENXIO) {
 > +            break;
 > +        }
 > +
 >          bytes =3D do_splice_direct(old_file, &old_pos,
 >                       new_file, &new_pos,
 >                       this_len, SPLICE_F_MOVE);
 > --=20
 > 2.21.0
 >=20
 >=20
 >

