Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05B4EF8E86
	for <lists+linux-unionfs@lfdr.de>; Tue, 12 Nov 2019 12:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfKLLYP (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 12 Nov 2019 06:24:15 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36365 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfKLLYP (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 12 Nov 2019 06:24:15 -0500
Received: by mail-io1-f68.google.com with SMTP id s3so18296686ioe.3
        for <linux-unionfs@vger.kernel.org>; Tue, 12 Nov 2019 03:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ESFLv56J4qu+v0iAoQ3Lic2jHdK8C56XbwMM0ChCsf0=;
        b=Ebzq0KiDlinNBSMFVj2wgjWcC9ifYyqTsu52C5HNndMbMgHa3FEenSO4NXTXj1w0gu
         yGRlWMM3F16pLcPQ/fK8swX3uNnsCHD5IEiwElvZRM9ljvZjWEkeWNztmarXdSOw7i4x
         rPQzJs5siyW0TK0q1Njq4nS6t+ktlhysHfWgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ESFLv56J4qu+v0iAoQ3Lic2jHdK8C56XbwMM0ChCsf0=;
        b=di4lNJTVJkL8RiD6PHIA22IcCEmZYRJ22nqb/PolEYgD9ysS4uBJPEbMnH8cbuEmRH
         8YicWK7WyUjLRpm3NjiXgPbwRcdqa7M8kM02uLKPyUa2nBG9b9UuGCrNQmhnqo6g92UM
         +Z1P+3+bozr4vfXiPGJtXGFKEjr0hyx0kn+ISD9qUMCcvJmJG1hyyujDOvL4l1FkN2Ld
         mma4erR+PyV6zExtFfN2yrBO2OTM/QsUFYCsa4cI90ISVjLvNAE+PPnazDl32OLVNOyw
         3ubLu5OGlv5UGeO7/C2Ppw/5wy0+bMapGoM+BNMqGgvw26zWzW+bf8SH12J3kI7CPQze
         WC5w==
X-Gm-Message-State: APjAAAUKzVnj0CIKy0yAWox4M23Oz8RvXgHxKcEjKqcm1cfwuvO39Km7
        AfX42KphLHnPruvZNqtr81IJprGrXgAOugBnlMwPgg==
X-Google-Smtp-Source: APXvYqwZCiwSTC+uWp2CwHrVrq2KjcjE1PyB2T7+6OKsPgVseOHTD/JVvbRSVd/MUPoADpEB3mqjX9wKtPJKTC2oPnM=
X-Received: by 2002:a5d:9a82:: with SMTP id c2mr3270318iom.212.1573557854294;
 Tue, 12 Nov 2019 03:24:14 -0800 (PST)
MIME-Version: 1.0
References: <1086cadc-53c3-effd-5ba3-797a015944b5@linux.alibaba.com>
 <CAJfpegu0CkBUTnkgv+C-cXopoj7oPjqsbFwN49EMhTw7=Pv+Tw@mail.gmail.com> <CAOQ4uxhKSjubpEnRCDLEYjS77DzT9g6KsXjWv9Sirq-mbQMvHA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhKSjubpEnRCDLEYjS77DzT9g6KsXjWv9Sirq-mbQMvHA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 12 Nov 2019 12:24:04 +0100
Message-ID: <CAJfpegth4jy24iUm9puJTTmRVZ=fLKw5gfR=qC8QjC4j5zUduQ@mail.gmail.com>
Subject: Re: [Regression] performance regression since v4.19
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Nov 12, 2019 at 11:48 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Nov 12, 2019 at 11:15 AM Miklos Szeredi <miklos@szeredi.hu> wrote=
:
> >
> > On Tue, Nov 12, 2019 at 8:53 AM Jiufei Xue <jiufei.xue@linux.alibaba.co=
m> wrote:
> > >
> > > Hi Miklos,
> > >
> > > A performance regression is observed since linux v4.19 when we do aio
> > > test using fio with iodepth 128 on overlayfs. And we found that queue
> > > depth of the device is always 1 which is unexpected.
> > >
> > > After investigation, it is found that commit 16914e6fc7
> > > (=E2=80=9Covl: add ovl_read_iter()=E2=80=9D) and commit 2a92e07edc
> > > (=E2=80=9Covl: add ovl_write_iter()=E2=80=9D) use do_iter_readv_write=
v() to submit
> > > requests to real filesystem. Async IOs are converted to sync IOs here
> > > and cause performance regression.
> > >
> > > I wondered that is this a design flaw or supposed to be.
> >
> > It's not theoretically difficult to fix.   The challenge is to do it
> > without too much complexity or code duplication.
> >
> > Maybe best would be to introduce VFS helpers specially for stacked
> > operation such as:
> >
> >   ssize_t vfs_read_iter_on_file(struct file *file, struct kiocb
> > *orig_iocb, struct iov_iter *iter);
> >   ssize_t vfs_write_iter_on_file(struct file *file, struct kiocb
> > *orig_iocb, struct iov_iter *iter);
> >
> > Implementation-wise I'm quite sure we need to allocate a new kiocb and
> > initialize it from the old one, adding our own completion callback.
> >
>
> Isn't it "just" a matter of implementing ovl-aops and
> generic_file_read/write_iter() will have done the aio properly?

Not quite.  First of all, generally only direct I/O can be async.
Which means ovl_direct_IO needs to handle async iocbs.  But, like the
stacked versions of read/write_iter, ovl_direct_IO just calls
vfs_iter_*() at the moment.

Also the generic_fille_read/write_iter() functions are called only if
the file has been copied up.   For lower files we want to retain the
stacked read implementation for page cache sharing.

Thanks,
Miklos
