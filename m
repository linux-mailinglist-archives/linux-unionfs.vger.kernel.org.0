Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1B3B1753C
	for <lists+linux-unionfs@lfdr.de>; Wed,  8 May 2019 11:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfEHJi6 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 8 May 2019 05:38:58 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:32930 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfEHJi6 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 8 May 2019 05:38:58 -0400
Received: by mail-yw1-f66.google.com with SMTP id q11so15744768ywb.0;
        Wed, 08 May 2019 02:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FLl6CvSJkaKOdNahaeyjV36GmXTkhFZEgish9AShuLw=;
        b=f9ZO3LTJq9srSRNYt60rZ1enYphyYNj4eeijWetKMpkZAhHL4iIkntx/dHNHD6ZwDn
         ALyCn/T5k1+bn++aG+ditOvobKwrrD5W7qVOkmRB4WlqHP2c53aZuvuJ7G41KoYx31HG
         2+BFDq+Hfs3YKd0pvSvpNlPJl8/SSib7v/Wa52qWR7fZsNgEQyd1so1S+LWGvyGfVSu2
         9tOpmzCm0CFTxSMyHZlAE/gr4E5ntxHu/35jMaz7iEZBMhmdOz+/mEXl0cTeb4L8MorP
         Cwf92doidTEfKTqL6OW479Iu3ezxw3dVBXJ12hU+evid7xVKSDyjJ5yoWNRz4/eeK47P
         u9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FLl6CvSJkaKOdNahaeyjV36GmXTkhFZEgish9AShuLw=;
        b=EuvBG1cXOqJt0DdGJfZ5uzRPKF0c1woeNig/tS9c1ORHiaIgIJizop9jrJ9WgByGBF
         vZzC2wOVIxj3WzWAseQqhj8muyH50zQvdZXLvj+rd7xhFe9d1/4apjhjoAcG7ULtDpPa
         WEaAMfeeoGRo3tANa0aoeuHDWJo3R5fu5LKii0caGCefaFrZGlpdSCAtUlXUNWYWCDZX
         D1w5ik1G74PjyC6iYZ2SL60/XJWcT5MlvmnFDTt7V1bM9y539NItedtx7Gb3kLY7oX+8
         i+Ry2PlMUvC3gMZQTKj0YqI8da4lSa+mc2yO4ciOH0QZImvu+0M6VS2Wuuf0HOhkjTuQ
         yqEw==
X-Gm-Message-State: APjAAAVxdV4jw7/M2ZYrIJcRXI2azs4f7KcDGFoBgPKnToR+VvW3b+Vx
        dukFwnlmAudT9rxu3bRi9+F9HQU142K5Z5FwCQg=
X-Google-Smtp-Source: APXvYqwKVuIGGTdz4K5AP1eHnJT9sMhwOSyjtstJm4QGfm4AmmVcjCCu568xIeLQcuED0f49WSBU29TrNCBzwaFSJgE=
X-Received: by 2002:a81:7dc5:: with SMTP id y188mr3707186ywc.34.1557308336611;
 Wed, 08 May 2019 02:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190508071000.99448-1-jiufei.xue@linux.alibaba.com>
In-Reply-To: <20190508071000.99448-1-jiufei.xue@linux.alibaba.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 8 May 2019 12:38:45 +0300
Message-ID: <CAOQ4uxjOzNzDAXLWdn+FXF1cMVBk29TAuTUzTtUPZh8o2OYG2Q@mail.gmail.com>
Subject: Re: [PATCH] generic: add a testcase to check the capability CAP_LINUX_IMMUTABLE
To:     Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc:     fstests <fstests@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>, joseph.qi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, May 8, 2019 at 10:10 AM Jiufei Xue <jiufei.xue@linux.alibaba.com> wrote:
>
> It should return error while changing IMMUTABLE_FL and APPEND_FL if the
> process has no capability CAP_LINUX_IMMUTABLE.
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

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> v2: add testcases for APPEND_FL and flags clearing. Suggested by
>     Amir Goldstein.
> v3: clear the flags on both the file in cleanup() in case test is
>     aborted.
>
>  common/config         |  1 +
>  tests/generic/545     | 73 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/545.out | 10 ++++++
>  tests/generic/group   |  1 +
>  4 files changed, 85 insertions(+)
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
> index 00000000..da2eac2e
> --- /dev/null
> +++ b/tests/generic/545
> @@ -0,0 +1,73 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Alibaba Group.  All Rights Reserved.
> +#
> +# FS QA Test No. 545
> +#
> +# Check that we can't set the FS_APPEND_FL and FS_IMMUTABLE_FL inode
> +# flags without capbility CAP_LINUX_IMMUTABLE
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
> +    # Cleanup of flags on both file in case test is aborted
> +    # (i.e. CTRL-C), so we have no immutable/append-only files
> +    $CHATTR_PROG -ia $testdir/file1 2>&1
> +    $CHATTR_PROG -ia $testdir/file2 2>&1
> +
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
> +_require_chattr a
> +_require_command "$CAPSH_PROG" "capsh"
> +
> +echo "Format and mount"
> +testdir="$TEST_DIR/test-$seq"
> +rm -rf $testdir
> +mkdir $testdir
> +
> +echo "Create the original files"
> +touch $testdir/file1
> +touch $testdir/file2
> +
> +do_filter_output()
> +{
> +    err_str=`_filter_test_dir | grep "Operation not permitted"`
> +    test -n "$err_str" && echo "Operation not permitted"
> +}
> +
> +echo "Try to chattr +ia with capabilities CAP_LINUX_IMMUTABLE"
> +$CHATTR_PROG +a $testdir/file1 2>&1
> +$CHATTR_PROG +i $testdir/file1 2>&1
> +
> +echo "Try to chattr +ia/-ia without capability CAP_LINUX_IMMUTABLE"
> +$CAPSH_PROG --drop=cap_linux_immutable -- -c "$CHATTR_PROG +a $testdir/file2" 2>&1 | do_filter_output
> +$CAPSH_PROG --drop=cap_linux_immutable -- -c "$CHATTR_PROG +i $testdir/file2" 2>&1 | do_filter_output
> +
> +$CAPSH_PROG --drop=cap_linux_immutable -- -c "$CHATTR_PROG -i $testdir/file1" 2>&1 | do_filter_output
> +$CAPSH_PROG --drop=cap_linux_immutable -- -c "$CHATTR_PROG -a $testdir/file1" 2>&1 | do_filter_output
> +
> +echo "Try to chattr -ia with capability CAP_LINUX_IMMUTABLE"
> +$CHATTR_PROG -i $testdir/file1 2>&1
> +$CHATTR_PROG -a $testdir/file1 2>&1
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/545.out b/tests/generic/545.out
> new file mode 100755
> index 00000000..8c6e4082
> --- /dev/null
> +++ b/tests/generic/545.out
> @@ -0,0 +1,10 @@
> +QA output created by 545
> +Format and mount
> +Create the original files
> +Try to chattr +ia with capabilities CAP_LINUX_IMMUTABLE
> +Try to chattr +ia/-ia without capability CAP_LINUX_IMMUTABLE
> +Operation not permitted
> +Operation not permitted
> +Operation not permitted
> +Operation not permitted
> +Try to chattr -ia with capability CAP_LINUX_IMMUTABLE
> diff --git a/tests/generic/group b/tests/generic/group
> index 40deb4d0..7a457e81 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -547,3 +547,4 @@
>  542 auto quick clone
>  543 auto quick clone
>  544 auto quick clone
> +545 auto quick cap
> --
> 2.19.1.856.g8858448bb
>
