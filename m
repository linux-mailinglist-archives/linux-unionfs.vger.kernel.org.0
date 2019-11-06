Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58C5BF155A
	for <lists+linux-unionfs@lfdr.de>; Wed,  6 Nov 2019 12:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfKFLno (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 6 Nov 2019 06:43:44 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25316 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729894AbfKFLnn (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 6 Nov 2019 06:43:43 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573040604; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=hMJQoyzz1u5Rb8nGa4dZM/VkXjoVh56LaYKdAFXs/VAwuzlZSTKwYNEsVDoJy9mWJR4nFaUdjAAAWvQfT6bS6cOsAwHhAuxrgJ1uFw8ZbTotwU7pre7fkeLpe3n8I3mdExKlqmCRfC4Vf7U1L8fE9E+tjKeNs6L2Uk1VIBinZlo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1573040604; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=uzLOdjSuDx6gUraBqnx0Vtchm4I5d7gulLChkh/0+LQ=; 
        b=pD29I2447Vhvb/cJu46FNfwOIlFipIBd6i5NpNVyx1ovUZzZ/jhd9XPtu32GpWQSQYKMScHgo8d3XWtWgTKgCTEsLqOC9I3ep+XCKVdmOFw+Bj3yIANx6h7S+QHs0UmAk9dI4wE9HGUWPWqXEQxme2GqUDXAIAz97XF1lDR83s8=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1573040604;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=2102; bh=uzLOdjSuDx6gUraBqnx0Vtchm4I5d7gulLChkh/0+LQ=;
        b=GnZ2M0JkcZkkKaqeDMqu7C4E1xxtkaV1/twKm79guiDLUBvHv3w/u9QKWcbuzCGd
        dATa0my1De5Sbwql0z32OZ9TjB+B7QqiGkfFp7W/yj0Vp1sk9ZpipZyNMI7RfRhMZlk
        XHl61JETxhRooMN2414pMoSZbav+SKkJDld7FSp8=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1573040602786295.5835788917002; Wed, 6 Nov 2019 19:43:22 +0800 (CST)
Date:   Wed, 06 Nov 2019 19:43:22 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "fstests" <fstests@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "Eryu Guan" <guaneryu@gmail.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>
Message-ID: <16e4086be9e.fa912076579.8007843109982063857@mykernel.net>
In-Reply-To: <CAOQ4uxjWjjMw7o32JaG_nuqw4oXw_Qo+jWjhRXkQ9pd9o1QjmQ@mail.gmail.com>
References: <20191106073945.12015-1-cgxu519@mykernel.net> <CAOQ4uxgBO6zZVJsa2uor5kwa1jp05Xrte6fifZdOsX=yF=v0-g@mail.gmail.com>
 <16e403ebe86.e4a465d3522.6312283139717764767@mykernel.net> <CAOQ4uxjWjjMw7o32JaG_nuqw4oXw_Qo+jWjhRXkQ9pd9o1QjmQ@mail.gmail.com>
Subject: Re: [PATCH v3] overlay/066: adjust test file size && add more test
 patterns
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2019-11-06 19:26:07 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > On Wed, Nov 6, 2019 at 12:24 PM Chengguang Xu <cgxu519@mykernel.net> wro=
te:
 > >
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2019-11-06 18:01:54 Amir =
Goldstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > >  > On Wed, Nov 6, 2019 at 9:40 AM Chengguang Xu <cgxu519@mykernel.net>=
 wrote:
 > >  > >
 > >  > > Making many small holes in 10M test file seems not very
 > >  > > helpful for test coverage and it takes too much time on
 > >  > > creating test files. In order to improve test speed we
 > >  > > adjust test file size to (10 * iosize) for iosize aligned
 > >  > > hole files and meanwhile add more test patterns for small
 > >  > > random holes and small empty file.
 > >  > >
 > >  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > >  > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
 > >  >
 > >  > Please send me a plain text version of the patch so I can test it.
 > >  >
 > >
 > > Hi Amir,
 > >
 > > Sorry for that again but I really don't know what was wrong for this p=
atch.
 > > I sent using 'git send-email' and there was nothing broken or unusual =
compare
 > > to other normal patches. So I have to send this patch in attachment ag=
ain.
 > >
 >=20
 > Test runs fine, except big random file has a single chunk 32MB of data:
 >=20
 > Big random hole test write scenarios ---
 >=20
 > /root/xfstests/bin/xfs_io -i -fc "pwrite 1024K 30862K"
 > /vdf/ovl-lower/copyup_sparse_test_random_big
 > wrote 31602688/31602688 bytes at offset 1048576
 > 30 MiB, 7716 ops; 0.1295 sec (232.614 MiB/sec and 59553.1201 ops/sec)
 >=20
 > That is because of this typo:
 >=20
 > @@ -133,7 +133,7 @@ file_size=3D102400
 >  min_hole=3D1024
 >  max_hole=3D5120
 >  pos=3D$min_hole
 > -max_hole=3D$(($file_size - 2*$max_hole))
 > +max_pos=3D$(($file_size - 2*$max_hole))
 >=20
 > If you re-submit, please add my Reviewed-by tag.
 >=20

Thanks a lot for your test and review, I'll resend soon.

Thanks,
Chengguang



