Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29547798456
	for <lists+linux-unionfs@lfdr.de>; Fri,  8 Sep 2023 10:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjIHIon (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 8 Sep 2023 04:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjIHIon (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 8 Sep 2023 04:44:43 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A3E1BC8
        for <linux-unionfs@vger.kernel.org>; Fri,  8 Sep 2023 01:44:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vrc0U8P_1694162674;
Received: from 30.97.49.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vrc0U8P_1694162674)
          by smtp.aliyun-inc.com;
          Fri, 08 Sep 2023 16:44:36 +0800
Message-ID: <dd432c83-3731-ce3a-a8f5-6175b3643fd7@linux.alibaba.com>
Date:   Fri, 8 Sep 2023 16:44:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/5] ovl: Support creation of whiteout files on
 overlayfs
To:     Alexander Larsson <alexl@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
References: <cover.1692270188.git.alexl@redhat.com>
 <f140fd46c2f61e69630c14a6b3fb8ed5e3c62307.1692270188.git.alexl@redhat.com>
 <CAJfpeguHCVFpcGVWdP5-j+7-+4cqjvd+-40UM=+vL1OFwS7rZA@mail.gmail.com>
 <CAL7ro1HMZxXZDyJG9yikx+KCd3HsYPZdgk7SJBLAGWBKVrYD6g@mail.gmail.com>
 <CAJfpeguerGOWAELyd7oY=z8Y-1sGG6OY9MurhCB7-kegxZ-wmQ@mail.gmail.com>
 <CAL7ro1Hr43u7CoyHwVOzxp+pcN2MHEf18B7+CZk=HFw=viGz8A@mail.gmail.com>
 <CAL7ro1FagGOZZg9yeWvWDov6L3prrjJE-+Yre1CJuViT7idNYw@mail.gmail.com>
 <CAOQ4uxhVXrNfhWc-EsunfyWyrJDFCjYu8GeAtvN0__QTfjtV5A@mail.gmail.com>
 <CAL7ro1HyGrwdH7B8C4-uWsfK4XTA=LF6GSS+4+LwT_iosdO2wQ@mail.gmail.com>
 <CAOQ4uxjhVR656cME=G-wOu_zrpqPS1M=sx32ogiUtrSxLsaBsw@mail.gmail.com>
 <CAJfpegsLDi-V_0GYW=9qu3RE16Oh9Wc8-bmMX=3q3EfdSn-iQw@mail.gmail.com>
 <CAOQ4uxioDBiKH267ijR5VOXzStwkOvYGrjMGtP26x0LJR0oWAg@mail.gmail.com>
 <3e5c0260-53fe-4955-b77e-ab79282556d3@linux.alibaba.com>
 <CAL7ro1EsjzNeYAbjPN3HnB7Sq4D48my3PGhPG5L+4DTXzA9xFw@mail.gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAL7ro1EsjzNeYAbjPN3HnB7Sq4D48my3PGhPG5L+4DTXzA9xFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi Alexander,

On 2023/9/8 16:30, Alexander Larsson wrote:
> 
> 
> On Fri, Sep 8, 2023 at 4:21 AM Gao Xiang <hsiangkao@linux.alibaba.com <mailto:hsiangkao@linux.alibaba.com>> wrote:
> 

..

>      > I hope I got the use case correctly?
>     Sorry for the dumb questions below.  I'm interested in the use cases:
>     after checking the previous github issue and emails (sorry if I'm
>     still missing something), I'm curious about this too.
> 
>     I totally understand how it plans to work and how it works (by using
>     escape xattr prefixes) but I'm not sure if I'm quite understand the
>     original issue:
> 
>     Do composefs use cases store overlayfs xattrs in the meta-only layer?
>     if so, such layer is actually hand-crafted by mkfs.  Why do we need
>     a way to keep escape xattrs on the underlay overlayfs?  Does the
>     other layer are data-only layers (do we keep some overlay xattrs in
>     these data-only layers)?
> 
> 
> Here is the problem statement:
> 
> I use composefs for my rootfs. I want to be able to store any kind of files in it and have them be visible in the final rootfs. In particular I want it to contain a whiteout file, because I want to mount an additional overlayfs where the lowerdir is stored on the rootfs (i.e. in the composefs mount).
> 
> The naive way to accomplish this is to just put a chardev(0,0) file in the erofs image that is the metadata layer in the rootfs overlayfs. I mean, that is what we do with all other file types.
> 
> However, if you were to do this, then the overlayfs that composefs uses will interpret the whiteout as masking out a file from the data-only layer in the composefs mount. This means the whiteout file we wanted is not visible in the final rootfs.

Thanks for your explanation.  That is helpful for me to
know what was happening here.

Okay, I got the point, so basically I think the original
use case is to have a way to "make such whiteouts in the
meta-only layer that overlayfs doesn't interpret/drop in
the composefs mount" (yes, a special whiteout is a
workable solution. )

Personally, there could be several ways to resolve this.
I have no more questions, thanks for the reply :)

Thanks,
Gao Xiang

> 
> -- 
> =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
>   Alexander Larsson                                Red Hat, Inc
> alexl@redhat.com <mailto:alexl@redhat.com>alexander.larsson@gmail.com <mailto:alexander.larsson@gmail.com>
