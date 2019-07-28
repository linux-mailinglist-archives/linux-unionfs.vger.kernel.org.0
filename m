Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC1677EB5
	for <lists+linux-unionfs@lfdr.de>; Sun, 28 Jul 2019 11:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfG1JEr (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 28 Jul 2019 05:04:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38679 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfG1JEr (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 28 Jul 2019 05:04:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so26510788pfn.5;
        Sun, 28 Jul 2019 02:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Q0+6pzkLQw4u52nFIxuc3PZKjtYv3l/Ox8EnXG6K2o=;
        b=JXSA+teiM4NAScYD+Fz7UWCGZDU9ccMm8Zs3mWmsT72a/+GuociE97e+Ta7hcQ7BRC
         EnuBrQmSIECnod2pqwnY8JAjwxb+DsKZZ8b7Z+lw13eMjREZSBInS2FVV0JDRQpuPsWa
         eYD6Azdu8e7C7ss8Qxq3G5xkG3h6d80+mySTkEF2+RfLYOPD5DciqjqBxo8aPT+SNYec
         W+Sg6j51WTXJnEn756QpESkh2gavaNjitaz5q2ltnxscg6MT4fvTtOff1fpDE4QNXM4G
         u8juyDIZfO/1vgTeMC2Ep0VmYS6Sudb/0gdeNZtPdXQz4XRUQxf4EyCAov2oRMQ4w8bs
         PtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Q0+6pzkLQw4u52nFIxuc3PZKjtYv3l/Ox8EnXG6K2o=;
        b=lVmiRJxgBzeImhPQ17Judra04bXA3efDROGjWHqu5ufhvKyYGLt0V9uevDr5qS5vok
         uZ1GtBeWh+RsokcEdSWhTvT2qwWBAF9S+U97liInZziz9GJv9At9hYi1qcLhgWpE62yT
         W+uHeep7kKWdzyrTFJMPhmIBdVi+qow3eReW9iOyUg+o/KLxJrTm4mjLM19HUNkqA+tB
         tLaM7fg8tsI8LBF2vlTlAi/47v4fyqH/eF81es7/QrLD6nnI+Sq67Mq1jNNJrE0VQGH8
         vqIkyctMwiKuVFdvybyI2eDMnQnRkMo9U4I4YMgVyHKqBsE5VYczt9cwHQGe8s79yA58
         pTRQ==
X-Gm-Message-State: APjAAAWcxmTDBJK9GYgBor0oxU6UQS3UjTpEw4IBID7gtIWWR671lRvX
        y9JQWhDMmxK4Vc80IOaZ1ms=
X-Google-Smtp-Source: APXvYqyZOESXAxQg/JcIj72AUcFUPiQmqhMcnvSl+xXwsQl8MDf94sIUqKzPFv3jnRM+7RcEIDVS+g==
X-Received: by 2002:aa7:93a8:: with SMTP id x8mr31757921pff.49.1564304686516;
        Sun, 28 Jul 2019 02:04:46 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id d14sm70362925pfo.154.2019.07.28.02.04.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 02:04:45 -0700 (PDT)
Date:   Sun, 28 Jul 2019 17:04:40 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>, linux-unionfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH] overlay/065: adjust test to expect EBUSY only with
 index=on
Message-ID: <20190728090440.GL7943@desktop>
References: <20190722050227.24944-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722050227.24944-1-amir73il@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Jul 22, 2019 at 08:02:27AM +0300, Amir Goldstein wrote:
> This is needed to support the kernel regression fix commit 0be0bfd2de9d
> ("ovl: fix regression caused by overlapping layers detection").
> 
> Overlayfs mount is not supposed to fail due to upper/work dir in-use
> by other mount unless option index=on is enabled.

Sorry for the late review.. Looks like this patch only mount overlay
with "index=on" explicitly, but doesn't check that mount succeeds when
"index=off", which is really regressed. Do we need to add more
"index=off" tests to ensure we allow re-use upperdir?

Thanks,
Eryu

> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Eryu,
> 
> With this applied, test is expected to fail on upstream kernel,
> because upstream kernel has a regression.
> 
> The kernel fix commit is on Miklos' overlayfs-next branch.
> 
> Thanks,
> Amir.
> 
>  tests/overlay/065     | 26 ++++++++++++++++----------
>  tests/overlay/065.out |  4 ++--
>  2 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/tests/overlay/065 b/tests/overlay/065
> index abfc6737..a75a9a10 100755
> --- a/tests/overlay/065
> +++ b/tests/overlay/065
> @@ -13,9 +13,14 @@
>  #
>  # Overlapping layers on mount or lookup results in ELOOP.
>  # Overlapping lowerdir with other mount upperdir/workdir
> -# result in EBUSY.
> +# result in EBUSY (if index=on is used).
>  #
> -# Kernel patch "ovl: detect overlapping layers" is needed to pass the test.
> +# This is a regression test for kernel commit:
> +#
> +#    146d62e5a586 "ovl: detect overlapping layers"
> +#
> +# and its followup fix commit:
> +#    0be0bfd2de9d "ovl: fix regression caused by overlapping layers detection"
>  #
>  seq=`basename $0`
>  seqres=$RESULT_DIR/$seq
> @@ -46,6 +51,7 @@ _supported_os Linux
>  # Use non-default scratch underlying overlay dirs, we need to check
>  # them explicity after test.
>  _require_scratch_nocheck
> +_require_scratch_feature index
>  
>  # Remove all files from previous tests
>  _scratch_mkfs
> @@ -61,10 +67,10 @@ mnt2=$basedir/mnt.2
>  
>  mkdir -p $lowerdir/lower $upperdir $workdir
>  
> -# Try to mount an overlay with the same upperdir/lowerdir - expect EBUSY
> +# Try to mount an overlay with the same upperdir/lowerdir - expect ELOOP
>  echo Conflicting upperdir/lowerdir
>  _overlay_scratch_mount_dirs $upperdir $upperdir $workdir \
> -	2>&1 | _filter_busy_mount
> +	2>&1 | _filter_error_mount
>  $UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
>  
>  # Use new upper/work dirs for each test to avoid ESTALE errors
> @@ -72,11 +78,11 @@ $UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
>  rm -rf $upperdir $workdir
>  mkdir $upperdir $workdir
>  
> -# Try to mount an overlay with the same workdir/lowerdir - expect EBUSY
> +# Try to mount an overlay with the same workdir/lowerdir - expect ELOOP
>  # because $workdir/work overlaps with lowerdir
>  echo Conflicting workdir/lowerdir
>  _overlay_scratch_mount_dirs $workdir $upperdir $workdir \
> -	2>&1 | _filter_busy_mount
> +	-oindex=off 2>&1 | _filter_error_mount
>  $UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
>  
>  rm -rf $upperdir $workdir
> @@ -126,20 +132,20 @@ rm -rf $upperdir2 $workdir2
>  mkdir -p $upperdir2 $workdir2 $mnt2
>  
>  # Try to mount an overlay with layers overlapping with another overlayfs
> -# upperdir - expect EBUSY
> +# upperdir - expect EBUSY with index=on
>  echo Overlapping with upperdir of another instance
>  _overlay_scratch_mount_dirs $upperdir/upper $upperdir2 $workdir2 \
> -	2>&1 | _filter_busy_mount
> +	-oindex=on 2>&1 | _filter_busy_mount
>  $UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
>  
>  rm -rf $upperdir2 $workdir2
>  mkdir -p $upperdir2 $workdir2
>  
>  # Try to mount an overlay with layers overlapping with another overlayfs
> -# workdir - expect EBUSY
> +# workdir - expect EBUSY with index=on
>  echo Overlapping with workdir of another instance
>  _overlay_scratch_mount_dirs $workdir/work $upperdir2 $workdir2 \
> -	2>&1 | _filter_busy_mount
> +	-oindex=on 2>&1 | _filter_busy_mount
>  $UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
>  
>  # Move upper layer root into lower layer after mount
> diff --git a/tests/overlay/065.out b/tests/overlay/065.out
> index 0260327c..c63d4df8 100644
> --- a/tests/overlay/065.out
> +++ b/tests/overlay/065.out
> @@ -1,8 +1,8 @@
>  QA output created by 065
>  Conflicting upperdir/lowerdir
> -mount: device already mounted or mount point busy
> +mount: Too many levels of symbolic links
>  Conflicting workdir/lowerdir
> -mount: device already mounted or mount point busy
> +mount: Too many levels of symbolic links
>  Overlapping upperdir/lowerdir
>  mount: Too many levels of symbolic links
>  Conflicting lower layers
> -- 
> 2.17.1
> 
