Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A17EB224
	for <lists+linux-unionfs@lfdr.de>; Thu, 31 Oct 2019 15:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfJaOHr (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 31 Oct 2019 10:07:47 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25329 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726506AbfJaOHr (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 31 Oct 2019 10:07:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572530853; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=dQkw08dkU5y0bHV2BOmJm1S82CeJW9xAzOrOfDC8E3uMfOM/6ni2gKD7a/gNB02Gg+KSoLJYX37r8g/NndNgzLdjAvTQYT7GsMAVNsNjF/jT0i/NeBiD8Zz6xZsGhYp2JvHk9szEppud8pkhUYC17xU9gqgXQQ6T8dIE1+cLksE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1572530853; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Reply-To:Subject:To; 
        bh=oqGaTg1OmFbzY9Su/tjznLvm0SWGOsnWqm6cpcLYu3Y=; 
        b=roaOHIgVJOgoQTX6d97Cxqy2qzUFI2CHxA5LsiixEm6dt2E7czvFo7cbrTfphKiYdaj6oKRiHajfBmbQqjeMKxaQfWCwb9VTHKDcrfuwW/MOIVujOWID+QRunjukj4/EDl1rmXToRKMOmsqyrUX1qibNEW6qdc7HyoUf45VT0YI=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1572530853;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=1078; bh=oqGaTg1OmFbzY9Su/tjznLvm0SWGOsnWqm6cpcLYu3Y=;
        b=Li+5o1+oG4XYEDW+1Ap/EY5lxBROfbHCqR6dKp5wMcf9iV7wgJ5hWa95DIfTFDC7
        xfLGF1Nz7DJHmrxpSDpeX6/IyG+bWSpS/eKn4NvWB9lc69FaoaHr0UA28DES5/mfKmW
        4X9pYYp3E63N2FZuiqfETIgXL2apF8fvEwnRZpYU=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1572530852095224.49225047282357; Thu, 31 Oct 2019 22:07:32 +0800 (CST)
Date:   Thu, 31 Oct 2019 22:07:32 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "yi.zhang" <yi.zhang@huawei.com>
Cc:     "linux-unionfs" <linux-unionfs@vger.kernel.org>
Message-ID: <16e222490fd.db7c32a41966.5777637250125026331@mykernel.net>
In-Reply-To: 
Subject: Compile error of fsck.overlay on Fedora30
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

Hi Zhangyi,

I found a compile error of fsck.overlay on my laptop(fedora 30), it looks l=
ike lacking of header in the check.c.
After manually added <sys/sysmacros.h> compile succeeded without error.

Detail info of compile error as below:

 [cgxu@localhost overlayfs-progs]$ make
gcc -Wall -g -c fsck.c
gcc -Wall -g -c common.c
gcc -Wall -g -c lib.c
gcc -Wall -g -c check.c
check.c: In function =E2=80=98ovl_create_whiteout=E2=80=99:
check.c:173:55: warning: implicit declaration of function =E2=80=98makedev=
=E2=80=99 [-Wimplicit-function-declaration]
  173 |  if (mknodat(dirfd, pathname, S_IFCHR | WHITEOUT_MOD, makedev(0, 0)=
)) {
      |                                                       ^~~~~~~
gcc -Wall -g -c mount.c
gcc -Wall -g -c path.c
gcc -Wall -g -c overlayfs.c
gcc -lm fsck.o common.o lib.o check.o mount.o path.o overlayfs.o -o fsck.ov=
erlay
/usr/bin/ld: check.o: in function `ovl_create_whiteout':
/home/cgxu/git/overlayfs-progs/check.c:173: undefined reference to `makedev=
'
collect2: error: ld returned 1 exit status
make: *** [Makefile:10: overlay] Error 1


Thanks,
Chengguang


