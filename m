Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 490022E205
	for <lists+linux-unionfs@lfdr.de>; Wed, 29 May 2019 18:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfE2QKQ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 29 May 2019 12:10:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18044 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbfE2QKP (ORCPT <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 29 May 2019 12:10:15 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E1325142679B37F9D8D3;
        Thu, 30 May 2019 00:10:11 +0800 (CST)
Received: from [127.0.0.1] (10.177.244.145) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 30 May 2019
 00:10:07 +0800
Subject: Re: [PATCH v3 2/4] overlay: fix _repair_scratch_fs
To:     Amir Goldstein <amir73il@gmail.com>, Eryu Guan <guaneryu@gmail.com>
References: <20190528151723.12525-1-amir73il@gmail.com>
 <20190528151723.12525-3-amir73il@gmail.com>
CC:     Miklos Szeredi <miklos@szeredi.hu>,
        <linux-unionfs@vger.kernel.org>, <fstests@vger.kernel.org>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <7cf2a5b5-ab05-ecec-32ef-00c2a401aa12@huawei.com>
Date:   Thu, 30 May 2019 00:10:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20190528151723.12525-3-amir73il@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.244.145]
X-CFilter-Loop: Reflected
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On 2019/5/28 23:17, Amir Goldstein Wrote:
> _repair_scratch_fs did not do the right thing for overlay.
> Implement and call _repair_overlay_scratch_fs to repair
> overlay filesystem and then fall through to repair base filesystem.
> 
> The only tests currentrly calling _repair_scratch_fs on a
> ./check -overlay run are generic/330 generic/332 in case the
> base fs supports reflink. The rest of the tests calling
> _repair_scratch_fs require that $SCRATCH_DEV is a block device.
> 
> Suggested-by: zhangyi (F) <yi.zhang@huawei.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  common/overlay | 17 +++++++++++++++++
>  common/rc      | 13 +++++++++++--
>  2 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/common/overlay b/common/overlay
> index b526f24d..a71c2035 100644
> --- a/common/overlay
> +++ b/common/overlay
> @@ -320,3 +320,20 @@ _check_overlay_scratch_fs()
>  		"$OVL_BASE_SCRATCH_DEV" "$OVL_BASE_SCRATCH_MNT" \
>  		$OVL_BASE_MOUNT_OPTIONS $SELINUX_MOUNT_OPTIONS
>  }
> +
> +_repair_overlay_scratch_fs()
> +{
> +	_overlay_fsck_dirs $OVL_BASE_SCRATCH_MNT/$OVL_LOWER \
> +		$OVL_BASE_SCRATCH_MNT/$OVL_UPPER \
> +		$OVL_BASE_SCRATCH_MNT/$OVL_WORK -y
> +	local res=$?
> +	case $res in
> +	$FSCK_OK|$FSCK_NONDESTRUCT)
> +		res=0
> +		;;
> +	*)
> +		_dump_err2 "fsck.overlay failed, err=$res"
> +		;;
> +	esac
> +	return $res
> +}
> diff --git a/common/rc b/common/rc
> index cedc1cfa..d0aa36a0 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1112,8 +1112,17 @@ _repair_scratch_fs()
>  	return $res
>          ;;
>      *)
> -        # Let's hope fsck -y suffices...
> -        fsck -t $FSTYP -y $SCRATCH_DEV 2>&1
> +	local dev=$SCRATCH_DEV
> +	local fstyp=$FSTYP
> +	if [ $FSTYP = "overlay" -a -n "$OVL_BASE_SCRATCH_DEV" ]; then
> +		_repair_overlay_scratch_fs
> +		# Fall through to repair base fs
> +		dev=$OVL_BASE_SCRATCH_DEV
> +		fstyp=$OVL_BASE_FSTYP
> +		$UMOUNT_PROG $OVL_BASE_SCRATCH_MNT
> +	fi
> +	# Let's hope fsck -y suffices...
> +	fsck -t $fstyp -y $dev 2>&1
>  	local res=$?
>  	case $res in
>  	$FSCK_OK|$FSCK_NONDESTRUCT|$FSCK_REBOOT)
> 

It seems that maybe better to return the error code if one of the two repairs
failed. But the $res is not used now, so it's not a big deal.

Reviewed-by: zhangyi (F) <yi.zhang@huawei.com>

