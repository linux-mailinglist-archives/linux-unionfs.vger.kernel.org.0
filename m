Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E918F8B71
	for <lists+linux-unionfs@lfdr.de>; Tue, 12 Nov 2019 10:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfKLJMk (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 12 Nov 2019 04:12:40 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:34897 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfKLJMk (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 12 Nov 2019 04:12:40 -0500
Received: by mail-il1-f195.google.com with SMTP id z12so14891703ilp.2
        for <linux-unionfs@vger.kernel.org>; Tue, 12 Nov 2019 01:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KvW43KPPGO7C61edpnbusU0/XYQmsKrIKFqdFCr7wyA=;
        b=KFjTh2MRj92LkTeXMQDmJTjScD/2MhgAccNGNlFoiZ3YSKwGeoyG6gDULUBz/W/+8c
         fSL5j+ydqB+PD/q3RI3mPAvtStLYenrFlETk7kWBtOq6IgCHIcx4VO7r2zDxll1FMX2d
         23R92nqVMZLoIRXe8K1UqbXxGIuDmnNTmS4A0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KvW43KPPGO7C61edpnbusU0/XYQmsKrIKFqdFCr7wyA=;
        b=J1NhYFHOlGvtHpb6Ww45/qBK0CIuPD5qQrwmDXJxi2N7NRgc+kwIIi2NLMkUSEZxR3
         XwPv6Vc3cqPw3Q0IrcC/IT5P/dNkaaABTukPDLklMqpv4zRBMkg7Tpcw0iZifJnPmDmD
         nD9395uoactunVEw7cIYpNRQPsy7UEG3k6iAHCmBjdD/EaCV7lpy3ahrrrSmkCgipg2n
         YM3RaTcf6dN1tosE02jBr69FTFdOtgOH4bPeA9kUguM9ecaWlTLYYz70gLHQzdMP8207
         ZSc0Co5jM+OXgoXza30JpDZAgnpbmk0OPk4H3GI2mvNo6YyD6a2PCsZJYRMIjW7BFR5C
         2n+w==
X-Gm-Message-State: APjAAAWLKjpnErlAf7IVGgILVVFWSaZufaPJuwKFbTnSaxsHjKhAuSIe
        va6S6CF9b0gvW813g8eAqgyIcwWaYjS4CJ7sITB/Fg==
X-Google-Smtp-Source: APXvYqxUv4PmRSXydXN1yuNIIOvCALNhE3djCI5unDjOk4SElxmuubTG7kXHumCbUynDpCGX4fNHb1GGoe/Wl2uDES0=
X-Received: by 2002:a92:ba98:: with SMTP id t24mr32207376ill.63.1573549957603;
 Tue, 12 Nov 2019 01:12:37 -0800 (PST)
MIME-Version: 1.0
References: <1086cadc-53c3-effd-5ba3-797a015944b5@linux.alibaba.com>
In-Reply-To: <1086cadc-53c3-effd-5ba3-797a015944b5@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 12 Nov 2019 10:12:28 +0100
Message-ID: <CAJfpegu0CkBUTnkgv+C-cXopoj7oPjqsbFwN49EMhTw7=Pv+Tw@mail.gmail.com>
Subject: Re: [Regression] performance regression since v4.19
To:     Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Nov 12, 2019 at 8:53 AM Jiufei Xue <jiufei.xue@linux.alibaba.com> w=
rote:
>
> Hi Miklos,
>
> A performance regression is observed since linux v4.19 when we do aio
> test using fio with iodepth 128 on overlayfs. And we found that queue
> depth of the device is always 1 which is unexpected.
>
> After investigation, it is found that commit 16914e6fc7
> (=E2=80=9Covl: add ovl_read_iter()=E2=80=9D) and commit 2a92e07edc
> (=E2=80=9Covl: add ovl_write_iter()=E2=80=9D) use do_iter_readv_writev() =
to submit
> requests to real filesystem. Async IOs are converted to sync IOs here
> and cause performance regression.
>
> I wondered that is this a design flaw or supposed to be.

It's not theoretically difficult to fix.   The challenge is to do it
without too much complexity or code duplication.

Maybe best would be to introduce VFS helpers specially for stacked
operation such as:

  ssize_t vfs_read_iter_on_file(struct file *file, struct kiocb
*orig_iocb, struct iov_iter *iter);
  ssize_t vfs_write_iter_on_file(struct file *file, struct kiocb
*orig_iocb, struct iov_iter *iter);

Implementation-wise I'm quite sure we need to allocate a new kiocb and
initialize it from the old one, adding our own completion callback.

Thanks,
Miklos
