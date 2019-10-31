Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2D60EB25C
	for <lists+linux-unionfs@lfdr.de>; Thu, 31 Oct 2019 15:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfJaOU5 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 31 Oct 2019 10:20:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50388 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726793AbfJaOU5 (ORCPT <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 31 Oct 2019 10:20:57 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 28662FC56260F0E5DA07;
        Thu, 31 Oct 2019 22:20:50 +0800 (CST)
Received: from [127.0.0.1] (10.177.244.145) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 31 Oct 2019
 22:20:46 +0800
Subject: Re: Compile error of fsck.overlay on Fedora30
To:     <cgxu519@mykernel.net>
References: <16e222490fd.db7c32a41966.5777637250125026331@mykernel.net>
CC:     linux-unionfs <linux-unionfs@vger.kernel.org>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <0827d20f-6494-58b9-db2b-6536af803774@huawei.com>
Date:   Thu, 31 Oct 2019 22:20:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <16e222490fd.db7c32a41966.5777637250125026331@mykernel.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.244.145]
X-CFilter-Loop: Reflected
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi Chengguang,

Thanks for reporting, I will check and fix this soon.

Thanks,
Yi.

On 2019/10/31 22:07, Chengguang Xu Wrote:
> Hi Zhangyi,
> 
> I found a compile error of fsck.overlay on my laptop(fedora 30), it looks like lacking of header in the check.c.
> After manually added <sys/sysmacros.h> compile succeeded without error.
> 
> Detail info of compile error as below:
> 
>  [cgxu@localhost overlayfs-progs]$ make
> gcc -Wall -g -c fsck.c
> gcc -Wall -g -c common.c
> gcc -Wall -g -c lib.c
> gcc -Wall -g -c check.c
> check.c: In function ‘ovl_create_whiteout’:
> check.c:173:55: warning: implicit declaration of function ‘makedev’ [-Wimplicit-function-declaration]
>   173 |  if (mknodat(dirfd, pathname, S_IFCHR | WHITEOUT_MOD, makedev(0, 0))) {
>       |                                                       ^~~~~~~
> gcc -Wall -g -c mount.c
> gcc -Wall -g -c path.c
> gcc -Wall -g -c overlayfs.c
> gcc -lm fsck.o common.o lib.o check.o mount.o path.o overlayfs.o -o fsck.overlay
> /usr/bin/ld: check.o: in function `ovl_create_whiteout':
> /home/cgxu/git/overlayfs-progs/check.c:173: undefined reference to `makedev'
> collect2: error: ld returned 1 exit status
> make: *** [Makefile:10: overlay] Error 1
> 
> 
> Thanks,
> Chengguang
> 
> 
> 
> .
> 

