Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41ADC1B58ED
	for <lists+linux-unionfs@lfdr.de>; Thu, 23 Apr 2020 12:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgDWKRS (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 23 Apr 2020 06:17:18 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:33648 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726490AbgDWKRR (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 23 Apr 2020 06:17:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TwQ0QRh_1587637033;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0TwQ0QRh_1587637033)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Apr 2020 18:17:14 +0800
Subject: Re: [PATCH] overlayfs: set MS_NOSEC flag for overlayfs
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "joseph.qi" <joseph.qi@linux.alibaba.com>
References: <1587625038-55484-1-git-send-email-jefflexu@linux.alibaba.com>
 <4898364f-e6e9-72e2-9b28-9a3a8f297ad4@linux.alibaba.com>
 <CAOQ4uxjzOmg03mgOG9cyAygK-XhfiMVh3M3k25yN1ZmvO39ckA@mail.gmail.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <7297fa44-de3b-52ba-0b42-d136f672a301@linux.alibaba.com>
Date:   Thu, 23 Apr 2020 18:17:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxjzOmg03mgOG9cyAygK-XhfiMVh3M3k25yN1ZmvO39ckA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org


On 4/23/20 4:27 PM, Amir Goldstein wrote:
> On Thu, Apr 23, 2020 at 10:06 AM JeffleXu <jefflexu@linux.alibaba.com> wrote:
>> It seems that MS_NOSEC flag would be problematic for network filesystems.
>>
>>
>> @Amir, would you please give some suggestions on if this would break the
>>
>> permission control down when 'NFS export' feature enabled ?
>>
> I cannot think of anything specific to NFS export.
> I think you are confusing NFS server with NFS client permissions.
> I think network filesystems do not set SB_NOSEC, because client
> may not have an coherent state of the xattr on server and other clients.
>
> To reflect on overlayfs, I think overlayfs should inherit the SB_NOSEC
> flag from upper fs, which is most likelihood will be set.

Makes sense. So maybe the following patch would be more appropriate. If 
it is OK I will send a v2 patch then.

```

--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1052,6 +1052,10 @@ static int ovl_get_upper(struct super_block *sb, 
struct ovl_fs *ofs,
         upper_mnt->mnt_flags &= ~(MNT_NOATIME | MNT_NODIRATIME | 
MNT_RELATIME);
         ofs->upper_mnt = upper_mnt;

+       /* inherit SB_NOSEC flag from upperdir */
+       if (upper_mnt->mnt_sb->s_flags & SB_NOSEC)
+               sb->s_flags |= SB_NOSEC;
+
         if (ovl_inuse_trylock(ofs->upper_mnt->mnt_root)) {
                 ofs->upperdir_locked = true;
         } else {

```

> The only filesystem I can think of that is used for upper fs without
> SB_NOSEC is the recent feature of fuse as upper fs merged to
> v5.7-rc1.
>
> Thanks,
> Amir.
