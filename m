Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFBBF2E1C0
	for <lists+linux-unionfs@lfdr.de>; Wed, 29 May 2019 17:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfE2P5I (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 29 May 2019 11:57:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17609 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbfE2P5I (ORCPT <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 29 May 2019 11:57:08 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 10196E5BFF748E09291A;
        Wed, 29 May 2019 23:57:06 +0800 (CST)
Received: from [127.0.0.1] (10.177.244.145) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 29 May 2019
 23:57:02 +0800
Subject: Re: [PATCH v3 1/4] fstests: define constants for fsck exit codes
To:     Amir Goldstein <amir73il@gmail.com>, Eryu Guan <guaneryu@gmail.com>
References: <20190528151723.12525-1-amir73il@gmail.com>
 <20190528151723.12525-2-amir73il@gmail.com>
CC:     Miklos Szeredi <miklos@szeredi.hu>,
        <linux-unionfs@vger.kernel.org>, <fstests@vger.kernel.org>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <8070e26a-b46e-e161-0376-76c88177199a@huawei.com>
Date:   Wed, 29 May 2019 23:57:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20190528151723.12525-2-amir73il@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.244.145]
X-CFilter-Loop: Reflected
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On 2019/5/28 23:17, Amir Goldstein Wrote:
> Define the constants for hard coded values used in _repair_scratch_fs()
> to check fsck exit code.
> 
> Suggested-by: zhangyi (F) <yi.zhang@huawei.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good to me.
Reviewed-by: zhangyi (F) <yi.zhang@huawei.com>

Thanks,
Yi.

> ---
>  common/config | 11 +++++++++++
>  common/rc     |  2 +-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/common/config b/common/config
> index 364432bb..bd64be62 100644
> --- a/common/config
> +++ b/common/config
> @@ -69,6 +69,17 @@ export OVL_WORK="ovl-work"
>  # overlay mount point parent must be the base fs root
>  export OVL_MNT="ovl-mnt"
>  
> +# From e2fsprogs/e2fsck/e2fsck.h:
> +# Exit code used by fsck-type programs
> +export FSCK_OK=0
> +export FSCK_NONDESTRUCT=1
> +export FSCK_REBOOT=2
> +export FSCK_UNCORRECTED=4
> +export FSCK_ERROR=8
> +export FSCK_USAGE=16
> +export FSCK_CANCELED=32
> +export FSCK_LIBRARY=128
> +
>  export PWD=`pwd`
>  #export DEBUG=${DEBUG:=...} # arbitrary CFLAGS really.
>  export MALLOCLIB=${MALLOCLIB:=/usr/lib/libefence.a}
> diff --git a/common/rc b/common/rc
> index e78e0920..cedc1cfa 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1116,7 +1116,7 @@ _repair_scratch_fs()
>          fsck -t $FSTYP -y $SCRATCH_DEV 2>&1
>  	local res=$?
>  	case $res in
> -	0|1|2)
> +	$FSCK_OK|$FSCK_NONDESTRUCT|$FSCK_REBOOT)
>  		res=0
>  		;;
>  	*)
> 

