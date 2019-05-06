Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5779414942
	for <lists+linux-unionfs@lfdr.de>; Mon,  6 May 2019 14:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfEFMCQ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 6 May 2019 08:02:16 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51517 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfEFMCQ (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 6 May 2019 08:02:16 -0400
Received: by mail-it1-f195.google.com with SMTP id s3so7546466itk.1
        for <linux-unionfs@vger.kernel.org>; Mon, 06 May 2019 05:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ju2njUwLYfTV/wUdh7vLcq4P1BVfeVuepgG/32ySqj4=;
        b=O23cxSfw0896HVQFi1gZjAEGcGSFPjvYiSr3EpLR5EQpzzf5xfPh6DpGlgvsvdLVwI
         YMQ3ocHSDGUOvkT/i127ou6mtCIngmZGL+dUU9G8amqEGepCCAywz9BupqbFx5mXotTK
         /823fngBvhH3Iks4FPz+mPamom2J82JS23ddE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ju2njUwLYfTV/wUdh7vLcq4P1BVfeVuepgG/32ySqj4=;
        b=WWWBgVP2jQY3pVMZXmn+Gn38SMzwgziyzw0et+A8OQrPY45Yp8tJnTBCDQzumM0MCl
         n6lp6g7tHiq2moBpOF0KX1yBpaAVgxRgAA7k7eYpiZYGghc6l9PHY453uLnXw8k7UJTL
         bKwwV4/r2cp7PuZ+KC3j0e+bFb+2xhQ3YkWc3bli2Fy/FlYQj5quwAiZ9uzECS0bFwY+
         HM5QzepCEYGHhNtorueW9aq3yFG/0C8d0/hE2cKe7/koDtwmS6QQZcPK3uG+xwqbc8PK
         WXfSrLumNLd+wJmm+J21NjPfaxHhXOHt2m7LkCUlI/mCsoVZSEkg51ptM+Ouq4Sl6qEr
         e5iQ==
X-Gm-Message-State: APjAAAWcXrCg4cN1g4aXXh4YetcClWrQwayxTO5DQsLkRYNNfptZXbyt
        H2OrFW5O580haxwd575kScgOCVP5NEMT7qf36uBKwQ82
X-Google-Smtp-Source: APXvYqwBk3eIz9WG0zraDx1Dl6bvQfOGw1l52MHbONdFPKzNeZXhlJnX8K7KHzgd+rJeriQid1moX+5DHr52+f9v1w4=
X-Received: by 2002:a24:b342:: with SMTP id z2mr15994962iti.121.1557144135662;
 Mon, 06 May 2019 05:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190506115719.123863-1-jiufei.xue@linux.alibaba.com>
In-Reply-To: <20190506115719.123863-1-jiufei.xue@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 6 May 2019 08:02:04 -0400
Message-ID: <CAJfpegs=a0m8reKeMb7EFH+UgpsZ-RJeMWzshRUBOO5-j_rA-w@mail.gmail.com>
Subject: Re: [PATCH v2] overlayfs: check the capability before cred overridden
To:     Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        joseph.qi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, May 6, 2019 at 7:57 AM Jiufei Xue <jiufei.xue@linux.alibaba.com> wrote:
>
> We found that it return success when we set IMMUTABLE_FL flag to a
> file in docker even though the docker didn't have the capability
> CAP_LINUX_IMMUTABLE.
>
> The commit d1d04ef8572b ("ovl: stack file ops") and
> dab5ca8fd9dd ("ovl: add lsattr/chattr support") implemented chattr
> operations on a regular overlay file. ovl_real_ioctl() overridden the
> current process's subjective credentials with ofs->creator_cred which
> have the capability CAP_LINUX_IMMUTABLE so that it will return success
> in vfs_ioctl()->cap_capable().
>
> Fix this by checking the capability before cred overriden. And here we
> only care about APPEND_FL and IMMUTABLE_FL, so get these information from
> inode.
>
> Changes since v1:
>  - remove S_DIRSYNC since ovl_copyflags() does not copy FS_DIRSYNC_FL,
>    pointed out by Amir Goldstein.
>
> Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>

Thanks.  Applied with modification, please see my vfs.git#overlayfs-next tree.

Miklos
