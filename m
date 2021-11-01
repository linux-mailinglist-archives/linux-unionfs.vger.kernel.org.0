Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475134412A5
	for <lists+linux-unionfs@lfdr.de>; Mon,  1 Nov 2021 05:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhKAEF0 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 1 Nov 2021 00:05:26 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:30887 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhKAEF0 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 1 Nov 2021 00:05:26 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HjK4v4NkZzcZxg;
        Mon,  1 Nov 2021 11:58:07 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Mon, 1 Nov 2021 12:02:31 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Mon, 1 Nov 2021 12:02:31 +0800
Subject: Re: [PATCH 2/2] ovl: fix UAF for ovl_aio_req
To:     Miklos Szeredi <miklos@szeredi.hu>
CC:     Amir Goldstein <amir73il@gmail.com>,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        overlayfs <linux-unionfs@vger.kernel.org>, <yukuai3@huawei.com>
References: <20210930032228.3199690-1-yangerkun@huawei.com>
 <20210930032228.3199690-3-yangerkun@huawei.com>
 <CAJfpeguSczH6E6AA+gL1ZVd37H-h4Nekw-e-FW=g6+S5qsKztQ@mail.gmail.com>
 <5617bd21-7495-98b6-d2c9-4fec23f1411d@huawei.com>
 <401efae5-da00-b398-5895-fe6201e93096@huawei.com>
 <YXvdq5LjJ363a3hM@miu.piliscsaba.redhat.com>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <fe0408e2-eeb7-17c2-6c21-9c66adafcf38@huawei.com>
Date:   Mon, 1 Nov 2021 12:02:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YXvdq5LjJ363a3hM@miu.piliscsaba.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org



On 2021/10/29 19:40, Miklos Szeredi wrote:
> On Thu, Oct 28, 2021 at 08:41:28PM +0800, yangerkun wrote:
>>
>>
>> 在 2021/10/18 22:26, yangerkun 写道:
>>>
>>>
>>> 在 2021/10/8 23:13, Miklos Szeredi 写道:
>>>> On Thu, 30 Sept 2021 at 05:12, yangerkun <yangerkun@huawei.com> wrote:
>>>>>
>>>>> Our testcase trigger follow UAF:
>>>>>
>>>>> [  153.939147]
>>>>> ==================================================================
>>>>> [  153.942199] BUG: KASAN: use-after-free in
>>>>> ext4_dio_read_iter+0xcc/0x1a0
>>>>> [  153.943331] Read of size 8 at addr ffff88803b7f1500 by task
>>>>> fsstress/726
>>>>> [  153.948182] Call Trace:
>>>>> [  153.948628]  ? dump_stack_lvl+0x73/0x9f
>>>>> [  153.950255]  ? ext4_dio_read_iter+0xcc/0x1a0
>>>>> [  153.950972]  ? ext4_dio_read_iter+0xcc/0x1a0
>>>>> [  153.951693]  ? kasan_report.cold+0x81/0x165
>>>>> [  153.952429]  ? ext4_dio_read_iter+0xcc/0x1a0
>>>>> [  153.953190]  ? __asan_load8+0x74/0x110
>>>>> [  153.953856]  ? ext4_dio_read_iter+0xcc/0x1a0
>>>>> [  153.954612]  ? ext4_file_read_iter+0x1df/0x2a0
>>>>> [  153.955394]  ? ext4_dio_read_iter+0x1a0/0x1a0
>>>>> [  153.956159]  ? vfs_iocb_iter_read+0xd5/0x330
>>>>> [  153.956916]  ? ovl_read_iter+0x15f/0x270
>>>>> [  153.957605]  ? ovl_aio_cleanup_handler+0x2a0/0x2a0
>>>>> [  153.958436]  ? aio_setup_rw+0xbf/0xe0
>>>>> [  153.959101]  ? aio_read+0x190/0x2d0
>>>>> [  153.959750]  ? aio_write+0x3e0/0x3e0
>>>>> [  153.960404]  ? __kasan_check_read+0x1d/0x30
>>>>> [  153.961167]  ? ext4_file_getattr+0x116/0x1b0
>>>>> [  153.961978]  ? __put_user_ns+0x40/0x40
>>>>> [  153.962714]  ? kasan_poison+0x40/0x90
>>>>> [  153.963384]  ? set_alloc_info+0x46/0x70
>>>>> [  153.964102]  ? __kasan_check_write+0x20/0x30
>>>>> [  153.964856]  ? __fget_files+0x106/0x180
>>>>> [  153.965571]  ? io_submit_one+0xaa7/0x1480
>>>>> [  153.966325]  ? aio_poll_complete_work+0x590/0x590
>>>>> [  153.967713]  ? ioctl_file_clone+0x110/0x110
>>>>> [  153.969008]  ? vfs_getattr_nosec+0x14a/0x190
>>>>> [  153.970539]  ? __do_sys_newfstat+0xd6/0xf0
>>>>> [  153.971713]  ? __ia32_compat_sys_newfstat+0x40/0x40
>>>>> [  153.973005]  ? __x64_sys_io_submit+0x125/0x3b0
>>>>> [  153.974282]  ? __ia32_sys_io_submit+0x390/0x390
>>>>> [  153.975575]  ? __kasan_check_read+0x1d/0x30
>>>>> [  153.976749]  ? do_syscall_64+0x35/0x80
>>>>> [  153.978034]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>>> [  153.979436]
>>>>> [  153.979738] Allocated by task 726:
>>>>> [  153.980352]  kasan_save_stack+0x23/0x60
>>>>> [  153.981054]  set_alloc_info+0x46/0x70
>>>>> [  153.981745]  __kasan_slab_alloc+0x4c/0x90
>>>>> [  153.982492]  kmem_cache_alloc+0x153/0x750
>>>>> [  153.983953]  ovl_read_iter+0x13b/0x270
>>>>> [  153.984689]  aio_read+0x190/0x2d0
>>>>> [  153.985332]  io_submit_one+0xaa7/0x1480
>>>>> [  153.986060]  __x64_sys_io_submit+0x125/0x3b0
>>>>> [  153.986878]  do_syscall_64+0x35/0x80
>>>>> [  153.987590]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>>> [  153.988516]
>>>>> [  153.988824] Freed by task 750:
>>>>> [  153.989417]  kasan_save_stack+0x23/0x60
>>>>> [  153.990140]  kasan_set_track+0x24/0x40
>>>>> [  153.990871]  kasan_set_free_info+0x30/0x60
>>>>> [  153.991639]  __kasan_slab_free+0x137/0x210
>>>>> [  153.992390]  kmem_cache_free+0xf8/0x590
>>>>> [  153.993303]  ovl_aio_cleanup_handler+0x1ae/0x2a0
>>>>> [  153.994205]  ovl_aio_rw_complete+0x31/0x60
>>>>> [  153.995043]  iomap_dio_complete_work+0x4b/0x60
>>>>> [  153.995898]  iomap_dio_bio_end_io+0x23d/0x270
>>>>> [  153.996742]  bio_endio+0x40d/0x440
>>>>> [  153.997376]  blk_update_request+0x38f/0x820
>>>>> [  153.998160]  scsi_end_request+0x56/0x320
>>>>> [  153.998872]  scsi_io_completion+0x10a/0xb60
>>>>> [  153.999655]  scsi_finish_command+0x194/0x2b0
>>>>> [  154.000464]  scsi_complete+0xd7/0x1f0
>>>>> [  154.001184]  blk_complete_reqs+0x92/0xb0
>>>>> [  154.001930]  blk_done_softirq+0x29/0x40
>>>>> [  154.002696]  __do_softirq+0x133/0x57f
>>>>>
>>>>> ext4_dio_read_iter
>>>>>     ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL, 0)
>>>>>     file_accessed(iocb->ki_filp) <== this trigger UAF
>>>>>
>>>>> Ret can be -EIOCBQUEUED which means we will not wait for io
>>>>> completion in
>>>>> iomap_dio_rw. So the release for ovl_aio_req will be done when io
>>>>> completion routine call ovl_aio_rw_complete(or ovl_aio_cleanup_handler
>>>>> in ovl_read_iter will do this). But once io finish soon, we may already
>>>>> release ovl_aio_req before we call file_access in ext4_dio_read_iter.
>>>>> This can trigger the upper UAF.
>>>>>
>>>>> Fix it by introduce refcount in ovl_aio_req like what aio_kiocb has did.
>>>>
>>>> Looks good at a glance.   Will review more fully.
>>>
>>> Hi,
>>>
>>> Any comments for this patch? :)
> 
> Thanks for the patch.  I found one issue: the fdput() needs to be moved to the
> destruction as well, since the iocb->ki_filp reference comes from aio_req->fd.

Hi, it seems we will only use aio_req->iocb in ovl_aio_cleanup_handler 
before we call fdput(aio_req->fd):

static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
{
         struct kiocb *iocb = &aio_req->iocb;
         struct kiocb *orig_iocb = aio_req->orig_iocb;

         if (iocb->ki_flags & IOCB_WRITE) {
                 struct inode *inode = file_inode(orig_iocb->ki_filp);

                 /* Actually acquired in ovl_write_iter() */
                 __sb_writers_acquired(file_inode(iocb->ki_filp)->i_sb,
                                       SB_FREEZE_WRITE);
                 file_end_write(iocb->ki_filp);
                 <=== use iocb
                 ovl_copyattr(ovl_inode_real(inode), inode);
         }

         orig_iocb->ki_pos = iocb->ki_pos;
         fdput(aio_req->fd); <=== release aio_req->fd
         kmem_cache_free(ovl_aio_request_cachep, aio_req);
}

So call fdput(aio_req->fd) in ovl_aio_cleanup_handler or ovl_aio_put
seems all ok for me.

> 
> Other than that, it looks good.
> 
> Minor things:
> 
> - instead of setting refcount to 1 and incrementing it, just initialize it to 2
> 
> - code deduplication can come after the fix (if at all), this helps backporting

Agree.

> 
> - cleaned up header comment
> 
> Here's the updated patch, can you please verify that I didn't break anything?

Thanks! This patch can help pass the test!

> 
> Thanks,
> Miklos
> ---
> 
> From: yangerkun <yangerkun@huawei.com>
> Subject: ovl: fix use after free in struct ovl_aio_req
> Date: Thu, 30 Sep 2021 11:22:28 +0800
> 
> Example for triggering use after free in a overlay on ext4 setup:
> 
> aio_read
>    ovl_read_iter
>      vfs_iter_read
>        ext4_file_read_iter
>          ext4_dio_read_iter
>            iomap_dio_rw -> -EIOCBQUEUED
>            /*
> 	   * Here IO is completed in a separate thread,
> 	   * ovl_aio_cleanup_handler() frees aio_req which has iocb embedded
> 	   */
>            file_accessed(iocb->ki_filp); /**BOOM**/
> 
> Fix by introducing a refcount in ovl_aio_req similarly to aio_kiocb.  This
> guarantees that iocb is only freed after vfs_read/write_iter() returns on
> underlying fs.
> 
> Fixes: 2406a307ac7d ("ovl: implement async IO routines")
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> Link: https://lore.kernel.org/r/20210930032228.3199690-3-yangerkun@huawei.com/
> Cc: <stable@vger.kernel.org> # v5.6
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>   fs/overlayfs/file.c |   16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -17,6 +17,7 @@
>   
>   struct ovl_aio_req {
>   	struct kiocb iocb;
> +	refcount_t ref;
>   	struct kiocb *orig_iocb;
>   	struct fd fd;
>   };
> @@ -252,6 +253,14 @@ static rwf_t ovl_iocb_to_rwf(int ifl)
>   	return flags;
>   }
>   
> +static inline void ovl_aio_put(struct ovl_aio_req *aio_req)
> +{
> +	if (refcount_dec_and_test(&aio_req->ref)) {
> +		fdput(aio_req->fd);
> +		kmem_cache_free(ovl_aio_request_cachep, aio_req);
> +	}
> +}
> +
>   static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
>   {
>   	struct kiocb *iocb = &aio_req->iocb;
> @@ -268,8 +277,7 @@ static void ovl_aio_cleanup_handler(stru
>   	}
>   
>   	orig_iocb->ki_pos = iocb->ki_pos;
> -	fdput(aio_req->fd);
> -	kmem_cache_free(ovl_aio_request_cachep, aio_req);
> +	ovl_aio_put(aio_req);
>   }
>   
>   static void ovl_aio_rw_complete(struct kiocb *iocb, long res, long res2)
> @@ -319,7 +327,9 @@ static ssize_t ovl_read_iter(struct kioc
>   		aio_req->orig_iocb = iocb;
>   		kiocb_clone(&aio_req->iocb, iocb, real.file);
>   		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
> +		refcount_set(&aio_req->ref, 2);
>   		ret = vfs_iocb_iter_read(real.file, &aio_req->iocb, iter);
> +		ovl_aio_put(aio_req);
>   		if (ret != -EIOCBQUEUED)
>   			ovl_aio_cleanup_handler(aio_req);
>   	}
> @@ -390,7 +400,9 @@ static ssize_t ovl_write_iter(struct kio
>   		kiocb_clone(&aio_req->iocb, iocb, real.file);
>   		aio_req->iocb.ki_flags = ifl;
>   		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
> +		refcount_set(&aio_req->ref, 2);
>   		ret = vfs_iocb_iter_write(real.file, &aio_req->iocb, iter);
> +		ovl_aio_put(aio_req);
>   		if (ret != -EIOCBQUEUED)
>   			ovl_aio_cleanup_handler(aio_req);
>   	}
> .
> 
