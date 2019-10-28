Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD27E70F3
	for <lists+linux-unionfs@lfdr.de>; Mon, 28 Oct 2019 13:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfJ1MJQ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 28 Oct 2019 08:09:16 -0400
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25962 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730055AbfJ1MJP (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 28 Oct 2019 08:09:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572264535; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=J2joaeQ02OiWRZNjw7rOWrtxcPLiehedFILB6Ap2MtdXW5UMC8xtlK7o8caerljQ15Nx9S8/ZVsce9vT3s2jJlpfRS5nyphF+T8tPW+CVFSpyQRnEjqR//rO8xewLJNESl8LgbTZ+8daVUz68gEi/dXHR3sDhXMoSWJxIUexk/E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1572264535; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To:ARC-Authentication-Results; 
        bh=0VgGO60u7XzUqXCZqziE99CPo1wN56hiR1Uf6p/WOTI=; 
        b=I44wDFdY7/H7WHnpcKePhLo0mFsWv3f/i1O2RYIXqGslyMlvvTGZ2rY7v78xH7JE2yhlk9ZoLI/QkHsu7ZQWKMVEtnmDRBuTrErT1iDkSZcaIbYYf6lNpw8bnyMjAl+o3mtYLMLkYnPM2jyYmkN8jMk7thKeC1aMrSLqtIacYD8=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1572264535;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=4622; bh=0VgGO60u7XzUqXCZqziE99CPo1wN56hiR1Uf6p/WOTI=;
        b=ZW8ZTDyhPuI2cQZSZmqbUDMZqvGpQD35SJUQoRhzqQo2rmrQ2VX81+zhTuPplcJ/
        oHYdfzxAXzu2Sqg3+KUNxAETU/Sj4kYjhu8EgK3lwartCZzeHDFELvl8t0JtE39hnti
        EP9PVxiuvLxUmpQa3PZT8XFc85UIFZq6fJ9WMqi8=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1572264534481895.6922176473067; Mon, 28 Oct 2019 20:08:54 +0800 (CST)
Date:   Mon, 28 Oct 2019 20:08:54 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "fstests" <fstests@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "Eryu Guan" <guaneryu@gmail.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>
Message-ID: <16e1244e1c9.ccaa038637864.8395134351025208019@mykernel.net>
In-Reply-To: <CAOQ4uxgZDKnMGB3pbCJpyH_RxWzbEHLQMB2Mpc10PK=7=xYLOg@mail.gmail.com>
References: <20191024122923.24689-1-cgxu519@mykernel.net> <CAOQ4uxidZ=g29hGmKxinRA4Gp6CiWbOB9RqLWPPFXwtCB4DWog@mail.gmail.com>
 <16e007f78f9.12a9e815231850.7849365151361114799@mykernel.net> <CAOQ4uxgZDKnMGB3pbCJpyH_RxWzbEHLQMB2Mpc10PK=7=xYLOg@mail.gmail.com>
Subject: Re: [PATCH v3] overlay/066: copy-up test for variant sparse files
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E6=97=A5, 2019-10-27 21:59:36 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > On Fri, Oct 25, 2019 at 4:19 AM Chengguang Xu <cgxu519@mykernel.net> wro=
te:
 > >
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2019-10-25 05:02:07 Amir =
Goldstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > >  > On Thu, Oct 24, 2019 at 3:29 PM Chengguang Xu <cgxu519@mykernel.net=
> wrote:
 > >  > >
 > >  > > This is intensive copy-up test for sparse files,
 > >  > > these cases will be mainly used for regression test
 > >  > > of copy-up improvement for sparse files.
 > >  > >
 > >  > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
 > >  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > >  > >
 > >  > > ---
 > >  > > v1->v2:
 > >  > > - Call _get_block_size to get fs block size.
 > >  > > - Add comment for test space requirement.
 > >  > > - Print meaningful error message when copy-up fail.
 > >  > > - Adjust random hole range to 1M~5M.
 > >  > > - Fix typo.
 > >  > >
 > >  > > v2->v3:
 > >  > > - Fix space requiremnt for test.
 > >  > > - Add more descriptions for test files and hole patterns.
 > >  > > - Define well named variables to replace unexplained numbers.
 > >  > > - Fix random hole algorithm to what Amir suggested.
 > >  > > - Adjust iosize to start from 1K.
 >=20
 > Chengguang,
 >=20
 > Sorry, I did't notice that you did that. Why?
 > As you can see below, this change has a very bad impact on test run time=
.
 > Any reason not to use _get_block_size?

Use _get_block_size cannot mitigate the effect perfectly,=20
in the worst case that we formatted fs with blocksize=3D1K,
the test will  take long time and also test time is not fixed.

 >=20
 >=20
 > >  > > - Remove from quick test group.
 > >  >
 > >  > Why? you said it takes 7s without the kernel patch.
 > >  > The test overlay/001 is in quick group and it copies up 2*4GB
 > >  > sparse files.
 > >
 > > I noticed that after changed to start from 1K iosize the test took abo=
ut 23s.
 > > I'm afraid maybe it will take more time on low performance VM env.
 > >
 > > The test overlay/001 took 8s/1s with/without kernel patch, so mainly t=
est time
 > > wasted on creating test files on test overlay/066.
 >=20
 > You are correct about the time spent on creating the files, but...
 >=20
 > On my low perf VM, the test runs 95s with overlay over xfs+reflink
 >=20
 > But if I set start iosize=3D4 (which what my fs block size is) the test
 > runs only 30s.
 >=20
 > IOW, most of the test time is spent on creating the files with small ios=
ize
 > below fs block size, which doesn't test copy up of holes at all.
 >=20
 > If I further change file size to be a multiply of iosize (x10),
 > test run time drops to 6s!
 > I don't think we loose too much test coverage if we do that?
 > If anything we gain testing different file sizes.

hmm, for small iosize the file size is even smaller than
copy-up CHUNK SIZE(1M),  so that all contents(data+hole)
will be passed at once, I'm not very sure is it helpful for
hole copy-up logic in kernel patch. What do you think?=20


 >=20
 > The disk space requirement formula for ${iosize}K_holefiles becomes:
 > 10*(2^0 + 2^11)K*12/2 =3D~ 10 * 1024 * 12

That's the mean of 12/2 ?

 > same as before, just needs explaining.
 > (the formula assumes the worst case of min_iosize=3D1)
 >=20
 > -------------
 >  #
 >  # |-- hole --|-- data --| ... |-- data --|-- hole --|
 >=20
 > -iosize=3D1
 > +min_iosize=3D$(($(_get_block_size "${lowerdir}") / 1024 ))
 > +iosize=3D$min_iosize
 >  max_iosize=3D2048
 > -file_size=3D10240
 > -max_pos=3D`expr $file_size - $max_iosize`
 >=20
 >  while [ $iosize -le $max_iosize ]; do
 > +       file_size=3D$((10*$iosize))
 > +       max_pos=3D`expr $file_size - $iosize`
 > +       date >>$seqres.full

That's the purpose for putting data info here?

 > +       echo "Creating ${testfile}_iosize${iosize}K_holefile..." >>$seqr=
es.full
 >         pos=3D$iosize
 >         $XFS_IO_PROG -fc "truncate ${file_size}K" \
 >                 "${lowerdir}/${testfile}_iosize${iosize}K_holefile"
 > >>$seqres.full
 > -----------
 >=20
 >=20
 > >
 > >  >
 > >  > Tests that are not in quick group are far less likely to be run
 > >  > regularly by developers.
 > >
 > > hmm...well, lets add 'quick' group again and remove it  if anyone comp=
lains later.
 > >
 >=20
 > I am now complaining ;-), but after fixes above, test is really quick
 >=20
 > Please send a fix patch (to already merged test) to fir test runtime
 > and possibly use _get_block_size.
 >=20
 > Thanks,
 > Amir.
 >

