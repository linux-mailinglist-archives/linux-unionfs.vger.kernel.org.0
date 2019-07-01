Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE7E1668F
	for <lists+linux-unionfs@lfdr.de>; Tue,  7 May 2019 17:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfEGPXs (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 7 May 2019 11:23:48 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44791 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfEGPXs (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 7 May 2019 11:23:48 -0400
Received: by mail-yw1-f65.google.com with SMTP id j4so13507824ywk.11;
        Tue, 07 May 2019 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DzIvhLIWuXjEl4WB0tkpMqLu5tve5TZo5qvBTUeDUXQ=;
        b=FvNSU04NWa9JrOmyFr91mQG7WisI7eiLwIccY2jodbowNc+VmyEAPJiiBnz+tErpWR
         7H6vI6Blj7KBk3GessVteQ3JA/kG7+ASMZPfGQzxxl/7yjvD/cjg/xKjUVd18yo9cE5j
         q5azKCC2FlzyZcFjeLFfNQIlFrS4DC0g1QOq97g8tr3XDWvQKgfD1DpVFIXTSEN5dWiH
         5c7OguU0Gj2TEI3/UNjAF5NSGGC6oBCaYy9Zxg+6POqzGlTdlZg3RIs5jH0PTh710A2k
         R6e+Arlm+/NoKfLTp6F4DldA6TqByXz3m7phtg0QnbZNOlCWaRdqggvyzjPAnH8niWzT
         egXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DzIvhLIWuXjEl4WB0tkpMqLu5tve5TZo5qvBTUeDUXQ=;
        b=TWDggcY1hdQ+hyjRoSUhC3yPqcMLLZvym6T3BLY9tZ2VZ3fo7+SSaifDhg1GvP+qgq
         IBMQnxZwUundPZhvx1jMhNtFzMq4OGWvxtw5qnegf20rHKEPJj3fV/t9kdnVXnBIRzq8
         wswVb9PaA1FU6uBcHmWSp5AVJz4MSgYc3qv5l2RfeyWBCHURLzBidnMCpm+g0dgdqf+W
         9rC+so4/7IszFh/bUz6So8IITKY4iYSH14MHsjcd5+2UPwwA+uo+gpcV3+B9eGCkBQXc
         TDfT0Incy6Cr5R5n/IK3LXsbCyERc/VWNyvlNQ/IdedGYyLE/Qx9g+lkTARpKUVBKVV/
         mkig==
X-Gm-Message-State: APjAAAUIa3o7YSsu0SGvJIDWlzz+s/WopughXdKc9Yq04R8VaFD5g/eg
        CJoy5eR/DRuUuMh0Awr5DRPsvbmmOJOJv6vTDiTkX24F
X-Google-Smtp-Source: APXvYqzZQdvECVEn3JRpeA6AB+yaw123lNm2jt10GRrJb9WVGBZCCGp8XVXujJgGTvpp8q/WBSFxZsR1bEcMtWaq2Wc=
X-Received: by 2002:a25:b948:: with SMTP id s8mr2193375ybm.325.1557242626974;
 Tue, 07 May 2019 08:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190507112914.20856-1-jiufei.xue@linux.alibaba.com>
In-Reply-To: <20190507112914.20856-1-jiufei.xue@linux.alibaba.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 7 May 2019 18:23:36 +0300
Message-ID: <CAOQ4uxiQXcuDqQdVMXH6FQbDnHmd7QA-tsGsfiD5hFyOYx=YGQ@mail.gmail.com>
Subject: Re: [PATCH] generic: add a testcase to check the capability CAP_LINUX_IMMUTABLE
To:     Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc:     fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        joseph.qi@linux.alibaba.com,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, May 7, 2019 at 2:29 PM Jiufei Xue <jiufei.xue@linux.alibaba.com> wrote:
>
> It should return error while changing IMMUTABLE_FL flag if the process
> has no capability CAP_LINUX_IMMUTABLE.
>
> However, it's not true on overlayfs after kernel version v4.19 since
> the process's subjective cred is overridden with ofs->creator_cred
> before calling real vfs_ioctl.
>
> The following patch for ovl fix the problem:
>   "ovl: check the capability before cred overridden"
>
> Add this testcase to cover this bug.
>
> Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
> ---
>  common/config         |  1 +
>  tests/generic/545     | 61 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/545.out |  5 ++++
>  tests/generic/group   |  1 +
>  4 files changed, 68 insertions(+)
>  create mode 100755 tests/generic/545
>  create mode 100755 tests/generic/545.out
>
> diff --git a/common/config b/common/config
> index 64f87057..364432bb 100644
> --- a/common/config
> +++ b/common/config
> @@ -196,6 +196,7 @@ export SQLITE3_PROG="$(type -P sqlite3)"
>  export TIMEOUT_PROG="$(type -P timeout)"
>  export SETCAP_PROG="$(type -P setcap)"
>  export GETCAP_PROG="$(type -P getcap)"
> +export CAPSH_PROG="$(type -P capsh)"
>  export CHECKBASHISMS_PROG="$(type -P checkbashisms)"
>  export XFS_INFO_PROG="$(type -P xfs_info)"
>  export DUPEREMOVE_PROG="$(type -P duperemove)"
> diff --git a/tests/generic/545 b/tests/generic/545
> new file mode 100755
> index 00000000..89bdf885
> --- /dev/null
> +++ b/tests/generic/545
> @@ -0,0 +1,61 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2015, Oracle and/or its affiliates.  All Rights Reserved.

Wrongly copied.

> +#
> +# FS QA Test No. 545
> +#
> +# Check that we can't add IMMUTABLE_FL flag to file when the process has
> +# no capbility CAP_LINUX_IMMUTABLE

Better check APPEND_FL while at it. Trivial to add.
Another think worth testing is chattr -i, so for example you could

touch foo bar
chattr +ia foo
capsh...
chattr +a bar # fail
chattr +i bar # fail
chattr -i foo # fail
chattr -a foo # fail

Order matters, because after Darrick's patches
chattr -/+a on immutable file should fail regardless of capabilities.

> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1    # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +    $CHATTR_PROG -i $testdir/file 2>&1
> +    cd /
> +    rm -rf $tmp.* $testdir
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/attr
> +
> +# real QA test starts here
> +_supported_os Linux
> +_require_chattr i
> +_require_command "$CAPSH_PROG" "capsh"
> +
> +rm -f $seqres.full
> +
> +echo "Format and mount"
> +testdir="$TEST_DIR/test-$seq"
> +rm -rf $testdir
> +mkdir $testdir
> +
> +echo "Create the original files"
> +blksz="$(_get_block_size $testdir)"
> +blks=1000
> +sz=$((blksz * blks))
> +_pwrite_byte 0x61 0 $sz $testdir/file >> $seqres.full
> +sync

touch $testdir/file is plenty enough

> +
> +do_filter_output()
> +{
> +    err_str=`_filter_test_dir | grep "Operation not permitted"`
> +    test -n "$err_str" && echo "Operation not permitted"
> +}
> +
> +echo "Try to add IMMUTABLE_FL flag"
> +$CAPSH_PROG --drop=cap_linux_immutable -- -c "$CHATTR_PROG +i $testdir/file" 2>&1 | do_filter_output
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/545.out b/tests/generic/545.out
> new file mode 100755
> index 00000000..740bb980
> --- /dev/null
> +++ b/tests/generic/545.out
> @@ -0,0 +1,5 @@
> +QA output created by 545
> +Format and mount
> +Create the original files
> +Try to add IMMUTABLE_FL flag
> +Operation not permitted
> diff --git a/tests/generic/group b/tests/generic/group
> index 40deb4d0..2f60b4af 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -547,3 +547,4 @@
>  542 auto quick clone
>  543 auto quick clone
>  544 auto quick clone
> +545 auto quick clone

Not 'clone'. Perhaps 'cap', although from the 5 tests that use setcap,
only one uses this tag.
You may send another patch to amend that if you want.

Thanks,
Amir.
