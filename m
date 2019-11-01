Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36F10EBBF2
	for <lists+linux-unionfs@lfdr.de>; Fri,  1 Nov 2019 03:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfKACTf (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 31 Oct 2019 22:19:35 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25316 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726540AbfKACTf (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 31 Oct 2019 22:19:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572574755; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=eOiKTWVIidCLr6CI1S3NMNr9g/gdKYi6LVavUS8ZtywBYyKDZqiRi44kwPva7kBY2q4x0vWlNdgNBNYbK79Fp+jWk4UTsjKQsa5QkAOizvrV1k5cOYZLzxVAJyHfj8u9yO5HPxtxnfKx41Urye8632VLJ+98AXZmrbE4fUDsM2A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1572574755; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=8begtgKQzyDGND11zhdf8X+KUPxcnFfDhdFS2qe0EOU=; 
        b=Zb9teMuN5twux2CVtHazMHBacA45nu2T3NQwVwDCWWAeQcySVs0Oq50lK8Armti5mdOjBszpeyFHdyEWYKb5lzp7fWIQqs0jYXctmgFq2ZGSNVTpO8E2WnWp7szQY13ph1byCXDyvpe31S0V+Q5oFY4Iis7gQ+o1tT1pygXk0HY=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1572574755;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=4636; bh=8begtgKQzyDGND11zhdf8X+KUPxcnFfDhdFS2qe0EOU=;
        b=CADEIWWSb/XWhuUvmkmX3nWKlcXJKi2x/ZMe9RLuJ7eTRQ2eunF5dGGMdiXdAwC2
        mkLKTPVnsL/xr507jQ6WacglqMGROHW0e7jlYsdXF+u8LHht+bQCst99Natanaac7Ad
        5yURfeNjzVTElCtco7lOCAg+isJCwlCkwKx2bFZ0=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1572574753505995.3577625788371; Fri, 1 Nov 2019 10:19:13 +0800 (CST)
Date:   Fri, 01 Nov 2019 10:19:13 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "Miklos Szeredi" <miklos@szeredi.hu>,
        "overlayfs" <linux-unionfs@vger.kernel.org>
Message-ID: <16e24c272dd.db4c4bd63079.5582642855306277071@mykernel.net>
In-Reply-To: <CAOQ4uxjsSx-sPHU_W7k1cQL4GLrtfjYjvkvZ8iT=QRKRpbFPhQ@mail.gmail.com>
References: <20191031104649.7177-1-cgxu519@mykernel.net> <CAOQ4uxjsSx-sPHU_W7k1cQL4GLrtfjYjvkvZ8iT=QRKRpbFPhQ@mail.gmail.com>
Subject: Re: [PATCH v3] ovl: improving copy-up efficiency for big sparse
 file
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2019-10-31 22:14:54 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > On Thu, Oct 31, 2019 at 12:47 PM Chengguang Xu <cgxu519@mykernel.net> wr=
ote:
 > >
 > > Current copy-up is not efficient for big sparse file,
 > > It's not only slow but also wasting more disk space
 > > when the target lower file has huge hole inside.
 > > This patch tries to recognize file hole and skip it
 > > during copy-up.
 > >
 > > Detail logic of hole detection as below:
 > > When we detect next data position is larger than current
 > > position we will skip that hole, otherwise we copy
 > > data in the size of OVL_COPY_UP_CHUNK_SIZE. Actually,
 > > it may not recognize all kind of holes and sometimes
 > > only skips partial of hole area. However, it will be
 > > enough for most of the use cases.
 > >
 > > Additionally, this optimization relies on lseek(2)
 > > SEEK_DATA implementation, so for some specific
 > > filesystems which do not support this feature
 > > will behave as before on copy-up.
 > >
 > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 >=20
 > Sorry for so many rounds.
 > With some nits fixed below you may add:
 > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
 >=20
 > > ---
 > > v1->v2:
 > > - Set file size when the hole is in the end of the file.
 > > - Add a code comment for hole copy-up improvement.
 > > - Check SEEK_DATA support before doing hole skip.
 > > - Back to original copy-up when seek data fails(in error case).
 > >
 > > v2->v3:
 > > - Detect big continuous holes in an effective way.
 > > - Modify changelog and code comment.
 > > - Set file size in the end of ovl_copy_up_inode().
 > >
 > >  fs/overlayfs/copy_up.c | 43 ++++++++++++++++++++++++++++++++++++++++-=
-
 > >  1 file changed, 41 insertions(+), 2 deletions(-)
 > >
 > > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
 > > index b801c6353100..10a2ae452393 100644
 > > --- a/fs/overlayfs/copy_up.c
 > > +++ b/fs/overlayfs/copy_up.c
 > > @@ -123,6 +123,9 @@ static int ovl_copy_up_data(struct path *old, stru=
ct path *new, loff_t len)
 > >         loff_t old_pos =3D 0;
 > >         loff_t new_pos =3D 0;
 > >         loff_t cloned;
 > > +       loff_t old_next_data_pos;
 >=20
 > If you initialize data_pos =3D -1 ....
 >=20
 > > +       loff_t hole_len;
 > > +       bool skip_hole =3D false;
 > >         int error =3D 0;
 > >
 > >         if (len =3D=3D 0)
 > > @@ -144,7 +147,11 @@ static int ovl_copy_up_data(struct path *old, str=
uct path *new, loff_t len)
 > >                 goto out;
 > >         /* Couldn't clone, so now we try to copy the data */
 > >
 > > -       /* FIXME: copy up sparse files efficiently */
 > > +       /* Check if lower fs supports seek operation */
 > > +       if (old_file->f_mode & FMODE_LSEEK &&
 > > +           old_file->f_op->llseek)
 > > +               skip_hole =3D true;
 > > +
 > >         while (len) {
 > >                 size_t this_len =3D OVL_COPY_UP_CHUNK_SIZE;
 > >                 long bytes;
 > > @@ -157,6 +164,38 @@ static int ovl_copy_up_data(struct path *old, str=
uct path *new, loff_t len)
 > >                         break;
 > >                 }
 > >
 > > +               /*
 > > +                * Fill zero for hole will cost unnecessary disk space
 > > +                * and meanwhile slow down the copy-up speed, so we do
 > > +                * an optimization for hole during copy-up, it relies
 > > +                * on SEEK_DATA implementation in lower fs so if lower
 > > +                * fs does not support it, copy-up will behave as befo=
re.
 > > +                *
 > > +                * Detail logic of hole detection as below:
 > > +                * When we detect next data position is larger than cu=
rrent
 > > +                * position we will skip that hole, otherwise we copy
 > > +                * data in the size of OVL_COPY_UP_CHUNK_SIZE. Actuall=
y,
 > > +                * it may not recognize all kind of holes and sometime=
s
 > > +                * only skips partial of hole area. However, it will b=
e
 > > +                * enough for most of the use cases.
 > > +                */
 > > +
 > > +               if (skip_hole) {
 >=20
 > ... you could test (skip_hole && old_pos !=3D data_pos) {
 >=20
 > because if (old_pos =3D=3D data_pos) then we just got here from
 > continue after skipping hole and there is no need to call llseek again.
 > Am I right?

Good point!
I'll check more precise condition like below.

if (skip_hole && data_pos < old_pos) {

Do llseek check

}


 >=20
 > > +                       old_next_data_pos =3D vfs_llseek(old_file,
 > > +                                               old_pos, SEEK_DATA);
 > > +                       if (old_next_data_pos > old_pos) {
 > > +                               hole_len =3D old_next_data_pos - old_p=
os;
 >=20
 > IMO, if you shorten var name to data_pos, it will not be any less
 > clear what it means and indentation will not be as messy.
 >=20
=20
Okay, let's truncate the var name.

Thanks,
Chengguang

