Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A507ED361
	for <lists+linux-unionfs@lfdr.de>; Sun,  3 Nov 2019 13:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfKCMoP (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 3 Nov 2019 07:44:15 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25321 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727377AbfKCMoP (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 3 Nov 2019 07:44:15 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1572785020; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=ih5/8WfNLA2B0EeB10lSJDqoObP2fJ1Lub/ckGVoCU6Mskjcj55ylVgyw1BDkjhNZtH2Q3QVum4AgqdBPuoOtygsZauB1idSXtcSCmSK4Jld/XS0ExOVWEKEP1rXlsTPv7fkPkso1WxDMwpamO1cnsCvUfeuhyoi3Y9QYSLFncI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1572785020; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=cBOTJo2cyZAe351P8Ghz322+6nCIrnSK/ZZ8QCl9FEg=; 
        b=egceoMueJ4cjXM0Paay2Y8cLCF9BNTBFNU07HnouYflg0q85nx/hC1pfuU5iBWGExvMeyMP6nRazJ/95yV8R0M7GcVIbRRAVkoENwGnGJrgBj6PJnNnhYJNA7q14QYzF5DgHHYmeTpWsq8evGkuivF3eF8rYH9RZcXJ5Rku3Q6I=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1572785020;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=900; bh=cBOTJo2cyZAe351P8Ghz322+6nCIrnSK/ZZ8QCl9FEg=;
        b=fTqtYB11qOoP1Zzj2NsQhs71C33aPo07Vp9HIMstaN5LPiIEjZR2katSKJ8cSUJC
        +MJKN045EbTzaGrtZ+VZjZq1wDk+C77Lo8Z5aWArdNlV0jyiOYWUKcUyaxPbtriUH0G
        TOm7ji8zgDUGgTOAgZg9YpayK18kdUD7e6gAVheg=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1572785017791525.9372538069861; Sun, 3 Nov 2019 20:43:37 +0800 (CST)
Date:   Sun, 03 Nov 2019 20:43:37 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "Miklos Szeredi" <miklos@szeredi.hu>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "Vivek Goyal" <vgoyal@redhat.com>
Message-ID: <16e314ad3bc.f4c363d96385.3761437052169638038@mykernel.net>
In-Reply-To: <CAOQ4uxhdSXAvFQfhzZpBC=Xmmo9y+3AOU1o-tOWsLtr2ntU6Ag@mail.gmail.com>
References: <20191030124431.11242-1-cgxu519@mykernel.net> <CAOQ4uxh670WFhwpQyPFTB2nUCSc9n1VmuyPOfdqiBSsq6GxLpQ@mail.gmail.com>
 <16e204de70e.cefd69461771.2205150443916624303@mykernel.net> <CAOQ4uxhdSXAvFQfhzZpBC=Xmmo9y+3AOU1o-tOWsLtr2ntU6Ag@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: improving copy-up efficiency for big sparse
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2019-10-31 14:53:15 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > >  > Yes, overlayfs does not comply with this "posix"' test.
 > >  > This is why it was removed from the auto and quick groups.
 > >
 > > So I'm curious what is the purpose for the test?
 > >
 >=20
 > This is a POSIX compliance test.
 > It is meant to "remind" us that this behavior is not POSIX compliant
 > and that we should fix it one day...
 > A bit controversial to have a test like this without a roadmap
 > when it is going to be fixed in xfstests, but it's there.

I haven't checked carefully for the detail but It seems  feasible if we cop=
y-up lower file  during mmap regardless of ro/rw mode.
Is it acceptable  by slightly changing copy-up assumption to fulfill POSIX =
compliance? Or we just wait for a better solution?

Thanks,
Chengguang


