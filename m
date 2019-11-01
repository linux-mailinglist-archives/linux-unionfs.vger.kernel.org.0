Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2DDBEC4A7
	for <lists+linux-unionfs@lfdr.de>; Fri,  1 Nov 2019 15:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfKAOZy (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 1 Nov 2019 10:25:54 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44042 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfKAOZx (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 1 Nov 2019 10:25:53 -0400
Received: by mail-yb1-f196.google.com with SMTP id g38so3592038ybe.11
        for <linux-unionfs@vger.kernel.org>; Fri, 01 Nov 2019 07:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQNA3hcQoNrFzJCvWaPyFe24Cc1c3vBx2QCwIYQIi9Y=;
        b=IcUNYEkS9wzKT3Es8lCUvJADHCt+vU1RDtvC/jcowgsIYG8olkCJtSjV0Z26s2F4FE
         AAWbsY3FY19jbYNq5DQtfLnithTfJEyGyjd5Yu6MqDSzbsw/f2T0fy3xhkoloI2ltggL
         W8oJbxPf7TpL0F3s3BCZVTCJcz4VzVPh5+fVrm+/vv4+L3eS5B5o3WVD3cWkYCdIQgRm
         5lHysMr6lNMa/RzZjZa9pwXvTsxtnkFF02BQyHITmbBjmMvDHRrBZoj7d8svC/aOvAPO
         0+RUGSt5vuq7T2taaOzPZZBKxRcvQG5DmwSIGS/FWHHF4x2qjss375D0tpZ77nmltYBi
         Lu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQNA3hcQoNrFzJCvWaPyFe24Cc1c3vBx2QCwIYQIi9Y=;
        b=L95PTevqi/aKS27Q1AFIYsrgnyHrdOV6s66LQCC338CovOdk65smQxuyyk45ws6e+u
         j7aTdSv2T4uOZd3DvdpBEE4f+gTfFPvmX5q6qD+mjDkIO3/q3aNfbb8mkXwhh2rPYdFi
         f3OgoAly8DJrhIafNmQcoW1/IJFaF00wsnBjXLc5PhnZn7IPZlM2KjtNC6RazCvGnvVI
         KTEkdx57J+5myP1Zn+G1ljva8HwWl2me5APfcyU8sNVmQDd5pXKtAR43sXpsf8qjQGyg
         dV/gK2RhPYUnCqkzOi4tNg7s3Lga9J7HM7qiDrZSCtVmejaaTPEsA6a2eYMFEkj0sjX9
         2kLQ==
X-Gm-Message-State: APjAAAXoQTorvcQ+iQsQfnOd3Hds95s7Fxmt02Xciw4P48X2tXJ2G60E
        pJHBTmDmvLUdhIcFwjak+55ibr01Dd1xrUbhPeI=
X-Google-Smtp-Source: APXvYqzws/o7FUzGQH3oAr34zcwF0i5fG6EFeKldi6OqsjPF/Z0mv4g9+QKWYpo+95KXZTe0HlGxT7P/RsSA8aSuwZE=
X-Received: by 2002:a25:cf8c:: with SMTP id f134mr9503349ybg.45.1572618352279;
 Fri, 01 Nov 2019 07:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <ae928bd7-001a-061e-01f0-43b53a0adcd1@linux.alibaba.com> <88f09a1e-2481-ac16-9754-77e21296b03a@gmail.com>
In-Reply-To: <88f09a1e-2481-ac16-9754-77e21296b03a@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 1 Nov 2019 16:25:40 +0200
Message-ID: <CAOQ4uxgHrtbCk+FMi5VOmQ+XUxGKmb5y--zgOQAz5_jx0ZuG8Q@mail.gmail.com>
Subject: Re: Performance regression caused by stack operation of regular file
To:     Joseph Qi <jiangqi903@gmail.com>
Cc:     JeffleXu <jefflexu@linux.alibaba.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Fri, Nov 1, 2019 at 9:27 AM Joseph Qi <jiangqi903@gmail.com> wrote:
>
> Hi Miklos & Amir,
> Could you please take a look at this?
> It behaves different between the latest kernel and an old one, e.g. 4.9.

Not surprisingly.
Stacked file operations in 4.19 shuffled the cards.
See below.

>
> Thanks,
> Joseph
>
> On 19/10/28 14:21, JeffleXu wrote:
> > Hi, Miklos,
> >
> > I noticed a performance regression of reading/writing files in mergeddir caused by commit a6518f73e60e5044656d1ba587e7463479a9381a (vfs: don't open real), using unixbench fstime.
> >
> >
> > Reproduce Steps:
> >
> > 1. cd /mnt/lower/ && git clone https://github.com/kdlucas/byte-unixbench.git
> >
> > 2. mount -t overlay overlay -olowerdir=/mnt/lower,upperdir=/mnt/upper,workdir=/mnt/work /mnt/merge
> >
> > 3. cd /mnt/merge/byte-unixbench/UnixBench && ./Run -c 1 -i 1 fstime
> >
> >
> > The score is 2870 before applying the patch, while it is 1780 after applying the patch, causing a 40% performance regression.
> >
> > The testcase repeatedly reads 1024 bytes from one file and writes the readed data into another file, while both these two files
> >
> > are created under /mnt/merge/tmp.  I have testsed the latest kernel 5.4.0-rc4+, same results.
> >

Is this really a workload that you are interested in or just a random
micro benchmark?
If kernel changes behavior for the better in some workloads and for the worst
in other workloads, it is important to distinguish between the case of real
life workloads and less meaningful micro benchmarks that do not really have
that much effect on real world.

> >
> > The perf shows that there's extra one call of file_remove_privs(), override_creds() and revert_creds() every write() syscall,
> >
> > among which file_remove_privs() is pretty expensive.
> >

Interesting.
If this is indeed the reasons for the perf regression
then it boils down to performance vs. security, because if kernel
4.9 is truly faster due to skipped file_remove_privs() and override_creds()
then it is not really enforcing security in a consistent manner.
It's true that in the common case, mounter credentials are a super set of
user credentials, so file_remove_privs() and  security_file_permission()
with user credentials are most of the time practically enough, but that is
not universally true.

If the workload is truly important to you, please try to figure out
why the extra calls are so expensive.
Do you have any LSMs enabled?

Thanks,
Amir.
