Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF837919C1
	for <lists+linux-unionfs@lfdr.de>; Mon,  4 Sep 2023 16:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbjIDOiZ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 4 Sep 2023 10:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbjIDOiZ (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 4 Sep 2023 10:38:25 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C420ACFB
        for <linux-unionfs@vger.kernel.org>; Mon,  4 Sep 2023 07:38:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VrMPkpC_1693838294;
Received: from 30.25.202.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VrMPkpC_1693838294)
          by smtp.aliyun-inc.com;
          Mon, 04 Sep 2023 22:38:18 +0800
Message-ID: <6a43ee5c-cc25-ff9f-1198-7c2b445d3775@linux.alibaba.com>
Date:   Mon, 4 Sep 2023 22:38:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [potential issue, question] whiteout shows up in merged directory
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jingbo Xu <jefflexu@linux.alibaba.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Xiang Gao <xiang@kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <a05e13c7-2fc2-77d8-05b5-759a73d7f5e2@linux.alibaba.com>
 <CAOQ4uxj_gM1BBCUE6p=TfVketOZohLPZs3fbw0BLacQFKEsuGg@mail.gmail.com>
 <9a89150e-cd84-c541-8088-41c2dfe863ac@linux.alibaba.com>
 <fe799167-249b-8fe2-a6c8-b222ac9acaf0@linux.alibaba.com>
 <CAOQ4uxgAoxgjQV2R0CJr-9UpyMTwdbGMYKb+qApco1YjBzE2HA@mail.gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAOQ4uxgAoxgjQV2R0CJr-9UpyMTwdbGMYKb+qApco1YjBzE2HA@mail.gmail.com>
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

Hi Amir,

On 2023/9/4 22:07, Amir Goldstein wrote:
> On Mon, Sep 4, 2023 at 4:27 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2023/9/4 20:49, Jingbo Xu wrote:
>>
>> ...
>>
>>>
>>> Thanks for the reply and it's really helpful to me.
>>>
>>> I can understand in the normal use case, whiteout can not appear in
>>> non-merged directory without origin xattr, except it's hand crafted.
>>>
>>> But indeed we suffer from this issue in the tarfs for erofs-utils we are
>>> developing. As described previously, in tarfs mode erofs-utils can
>>> convert each tar layer into one separate erofs image, and then merge
>>> these erofs images into one merged erofs image in a overlayfs-like model.
>>>
>>> Suppose:
>>>
>>> layer 0 + layer 1   +        layer 2         -->  merged
>>>          /foo/bar   /foo/bar (whiteout)
>>>
>>>
>>> To speed the merging process, we may merge the two top-most layers
>>> (layer 1 and layer 2) first, and then make layer0 merged into the final
>>> merged image as:
>>>
>>>
>>>
>>>              layer 1   +        layer 2         -->  merged-intermediate
>>>          /foo/bar   /foo/bar (whiteout)
>>>
>>> layer0 + merged-intermediate                -->  merged
>>
>>
>> I could add some more background to this, assuming layer 0 is a
>> baseos layer (e.g. almost all images use this layer); and layer 1 +
>> layer 2 belongs to some specific workload images;
>>
>> since layer 1 + layer 2 are always used together, so we could merge
>> layer 1 + layer 2 as a new merged layer to avoid extra overhead of
>> too many overlay layer dirs (but to simplify, here we just illustrate
>> layer 1 and layer 2, there could be layer 3, 4, ...), but layer 1 +
>> layer 2 has no relationship with layer 0 in principle (in principle,
>> merge tool doesn't need to know if layer 0 or any underlay layer
>> exists).
>>
>> So if we merge layer 1 + layer 2 here first, and use layer0 together
>> with the merged layer, it could generate such whiteout cases
>> described before.
>>
> ...
>>>
>>> Then there comes the problem: when merging layer1 and layer2, I need to
>>> keep the whiteout in the intermediate merged image though the target of
>>> the whiteout has showed up in underlying layer (/foo/bar in layer 1),
>>> because I have no idea if "/foo/bar" exits in the following further
>>> underlying layer (layer 0).  Reusing this logic, the whiteout is kept
>>> there in the final merged image after merging layer0 and
>>> merged-intermediate.
>>>
>>> Then if "/foo" is not a merged directory, the "/foo/bar" whiteout will
>>> be exposed in the overlayfs unexpectedly.
>>>
>>> Currently we work around this in erofs-utils side.  Apart from setting
>>> origin xattr on the parent directory of the whiteout, I'm not sure if
>>> the above use case is reasonable enough to fix this in the kernel side.
>>>
>> Anyway, we could work around this in the merge tool, but I'm not
>> sure if it's a design constaint of overlayfs.
>>
> 
> Let me put it this way:
> If there was an official offline tool to merge overlayfs layers
> I would expect that tool to mark the offline merged directories
> with an empty "trusted.overlayfs.origin", to be able to distinguish
> them from pure non-merge directories.
> 
> I do not consider dealing with this in erofs-utils side a workaround
> I consider it crafting layers in expected overlayfs format.

Thanks for the hints.

Ok, marking impure makes sense as long as it's properly described.

Just tried to describe the background since the question I think
is not quite erofs-utils specific, btw, if there could be some
reference official offline tool, that would be great!

> 
> You should know that there are potential costs for marking a directory
> as merged directory - ovl_iterate() implementation for merged dirs
> that needs to filter out whiteouts is quite different than the
> ovl_iterate_real() case -
> The entire dirs needs to be read into cache before any response
> could be returned. For very large dirs this may matter.
> 
> So you may want your tool to be able to clear the unneeded whiteouts
> and unneeded origin xattr eventually.

Yes, I know there is some overhead though, so I tend to add
some option to the merge tool called "--keep-whiteout=0" to
formally drop unneeded whiteouts in the end, and I think we
also need to clear unneeded origin xattrs later.  Jingbo once
would like to confirm the best way to describe such situation
to work out the merge tool.

> 
> OTOH, ovl_dir_read_impure() with xino enabled on layers
> not from the same fs, has quite a similar impact.
> Not sure if this configuration is relevant for your use case.

Thanks for the reminder, we will check later (off work now..)

Thanks,
Gao Xiang

> 
> Thanks,
> Amir.
