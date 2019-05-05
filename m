Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5D7413EA7
	for <lists+linux-unionfs@lfdr.de>; Sun,  5 May 2019 11:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfEEJ0v (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 5 May 2019 05:26:51 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:36127 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726636AbfEEJ0u (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 5 May 2019 05:26:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0TQvcZw3_1557048404;
Received: from ali-186590e05fa3.local(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0TQvcZw3_1557048404)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 05 May 2019 17:26:44 +0800
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
To:     miklos@szeredi.hu, linux-unionfs@vger.kernel.org
Subject: =?UTF-8?Q?=5bbug_report=5d_chattr_+i_succeed_in_docker_which_don?=
 =?UTF-8?Q?=e2=80=98t_have_the_capability_CAP=5fLINUX=5fIMMUTABLE?=
Message-ID: <3393f96c-e9a7-2882-f210-81a9c332a138@linux.alibaba.com>
Date:   Sun, 5 May 2019 17:26:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi,

We are using kernel v4.19.24 and have found that it can be successful
when we set IMMUTABLE_FL flag to a file in docker while the docker
didn't have the capability CAP_LINUX_IMMUTABLE.

# touch tmp
# chattr +i tmp
# lsattr tmp
----i--------e-- tmp

We have tested this case in older version such as 4.9 and it returned
-EPERM as expected.

We found that the commit d1d04ef8572b ("ovl: stack file ops") and
dab5ca8fd9dd ("ovl: add lsattr/chattr support") implemented chattr
operations on a regular overlay file. ovl_real_ioctl() overridden the
current process's subjective credentials with ofs->creator_cred which
have the capability CAP_LINUX_IMMUTABLE so that it will return success
in vfs_ioctl()->cap_capable().

I wondered is this kind of mechanism of overlayfs or a bug?

Thanks,
Jiufei


