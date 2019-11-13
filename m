Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40650FAA31
	for <lists+linux-unionfs@lfdr.de>; Wed, 13 Nov 2019 07:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfKMGbz (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 13 Nov 2019 01:31:55 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:52506 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725858AbfKMGbz (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 13 Nov 2019 01:31:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Thy7mUp_1573626712;
Received: from ali-186590e05fa3.local(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0Thy7mUp_1573626712)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Nov 2019 14:31:53 +0800
Subject: Re: [Regression] performance regression since v4.19
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
References: <1086cadc-53c3-effd-5ba3-797a015944b5@linux.alibaba.com>
 <CAJfpegu0CkBUTnkgv+C-cXopoj7oPjqsbFwN49EMhTw7=Pv+Tw@mail.gmail.com>
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
Message-ID: <6e97aa26-2aaf-d83d-c3a6-ce22ea888b5b@linux.alibaba.com>
Date:   Wed, 13 Nov 2019 14:31:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegu0CkBUTnkgv+C-cXopoj7oPjqsbFwN49EMhTw7=Pv+Tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org



On 2019/11/12 下午5:12, Miklos Szeredi wrote:
> On Tue, Nov 12, 2019 at 8:53 AM Jiufei Xue <jiufei.xue@linux.alibaba.com> wrote:
>>
>> Hi Miklos,
>>
>> A performance regression is observed since linux v4.19 when we do aio
>> test using fio with iodepth 128 on overlayfs. And we found that queue
>> depth of the device is always 1 which is unexpected.
>>
>> After investigation, it is found that commit 16914e6fc7
>> (“ovl: add ovl_read_iter()”) and commit 2a92e07edc
>> (“ovl: add ovl_write_iter()”) use do_iter_readv_writev() to submit
>> requests to real filesystem. Async IOs are converted to sync IOs here
>> and cause performance regression.
>>
>> I wondered that is this a design flaw or supposed to be.
> 
> It's not theoretically difficult to fix.   The challenge is to do it
> without too much complexity or code duplication.
> 
> Maybe best would be to introduce VFS helpers specially for stacked
> operation such as:
> 
>   ssize_t vfs_read_iter_on_file(struct file *file, struct kiocb
> *orig_iocb, struct iov_iter *iter);
>   ssize_t vfs_write_iter_on_file(struct file *file, struct kiocb
> *orig_iocb, struct iov_iter *iter);
> 
> Implementation-wise I'm quite sure we need to allocate a new kiocb and
> initialize it from the old one, adding our own completion callback.
>
Yes, I totally agree with you. I will try to fix this regression and send
the patch.

Thanks,
Jiufei

> Thanks,
> Miklos
> 
