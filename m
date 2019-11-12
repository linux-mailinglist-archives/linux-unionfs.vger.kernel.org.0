Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0101F8D2C
	for <lists+linux-unionfs@lfdr.de>; Tue, 12 Nov 2019 11:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKLKsM (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 12 Nov 2019 05:48:12 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41613 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfKLKsM (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 12 Nov 2019 05:48:12 -0500
Received: by mail-yb1-f195.google.com with SMTP id d95so6915691ybi.8
        for <linux-unionfs@vger.kernel.org>; Tue, 12 Nov 2019 02:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Scs4gOmMg1bAVzIkHMCVMCNuoInlEkcL36Ul4zVsXzQ=;
        b=GhOTJwCl5CRB00apW5eBJVxiGzgWTEqx6e+41ndRWFRR8WySsnW8Ra3PmhCxewfCQM
         9bifrU4THbzsAqlpJJ1uAkHtTiL5Jckx2mijuh8cE6XTMk/T3N+rgge5CyIX2A/HXzok
         LOfVtSBrwHXP+9OSSqIS6wcOrDDiWwB4vKVPiGf6+f63oV4njJTKwZGbzty2+kIZRZSv
         9R23o3nqT3f9Fx/PqGAiSUq/ck17vdfmXAWGj+kjTNli4Peu69wH91r7SgFftG6sAbg4
         PSgBSTxsXPC9IlQUcn3wVplkELPDCJYiDmbpjVacfVwah90ok8yJe9eGYxqRMfNP40s7
         79kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Scs4gOmMg1bAVzIkHMCVMCNuoInlEkcL36Ul4zVsXzQ=;
        b=pXDJGQSi7Yyu7qtqYs9YW1HcuVNqOdnzG2WY5AaGoTWG/sZO5nzekSao01w6N7znjR
         UtclyXab0W65+4bUDQR7WBX4qFR1R6XnGZBpiIQ/uMqJ4nijcfVLmasQAwYhW1wleaZx
         g4M+Ou3wYKU7EDgOY4qZTInXJkCk/Ys/tqDpscADwKEuaOlJuIQwNNKEi39cjH1laI/j
         xkqx8aACBnJ60KbnKkLZLfYCtuDRbJB6O3WRzfvpztlq2X1jXsW9IzOvua16WwA3Hwi7
         cmj9wQ+G2FKKjvLs8S0/BDSkKOvjDzyRcCfRTN1ssYlq/eZj+/cC+cxDxDpEW8YCQe2p
         FjOg==
X-Gm-Message-State: APjAAAX5wOPqSuNMw5YMbmxb75yOwiprvZIzPsMT5EuTfSJuldPIps02
        l1fZUc1+fgcjjvzeDSiM89ShPlHP6kYC1P2aR1S5xyem
X-Google-Smtp-Source: APXvYqwMAPzAGofM/vfdLmKwMPHIUGQKTR+2ES3FpKLPOQjTCpwJeKlnbUKiCZ9PO8wM1/v441ZGXVemF15hIbKmHzA=
X-Received: by 2002:a25:383:: with SMTP id 125mr22943584ybd.45.1573555690921;
 Tue, 12 Nov 2019 02:48:10 -0800 (PST)
MIME-Version: 1.0
References: <1086cadc-53c3-effd-5ba3-797a015944b5@linux.alibaba.com> <CAJfpegu0CkBUTnkgv+C-cXopoj7oPjqsbFwN49EMhTw7=Pv+Tw@mail.gmail.com>
In-Reply-To: <CAJfpegu0CkBUTnkgv+C-cXopoj7oPjqsbFwN49EMhTw7=Pv+Tw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 12 Nov 2019 12:48:00 +0200
Message-ID: <CAOQ4uxhKSjubpEnRCDLEYjS77DzT9g6KsXjWv9Sirq-mbQMvHA@mail.gmail.com>
Subject: Re: [Regression] performance regression since v4.19
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Nov 12, 2019 at 11:15 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, Nov 12, 2019 at 8:53 AM Jiufei Xue <jiufei.xue@linux.alibaba.com>=
 wrote:
> >
> > Hi Miklos,
> >
> > A performance regression is observed since linux v4.19 when we do aio
> > test using fio with iodepth 128 on overlayfs. And we found that queue
> > depth of the device is always 1 which is unexpected.
> >
> > After investigation, it is found that commit 16914e6fc7
> > (=E2=80=9Covl: add ovl_read_iter()=E2=80=9D) and commit 2a92e07edc
> > (=E2=80=9Covl: add ovl_write_iter()=E2=80=9D) use do_iter_readv_writev(=
) to submit
> > requests to real filesystem. Async IOs are converted to sync IOs here
> > and cause performance regression.
> >
> > I wondered that is this a design flaw or supposed to be.
>
> It's not theoretically difficult to fix.   The challenge is to do it
> without too much complexity or code duplication.
>
> Maybe best would be to introduce VFS helpers specially for stacked
> operation such as:
>
>   ssize_t vfs_read_iter_on_file(struct file *file, struct kiocb
> *orig_iocb, struct iov_iter *iter);
>   ssize_t vfs_write_iter_on_file(struct file *file, struct kiocb
> *orig_iocb, struct iov_iter *iter);
>
> Implementation-wise I'm quite sure we need to allocate a new kiocb and
> initialize it from the old one, adding our own completion callback.
>

Isn't it "just" a matter of implementing ovl-aops and
generic_file_read/write_iter() will have done the aio properly?

I don't remember at what state we left the ovl-aops experiment [1]
IIRC, it passed most xfstests, but had some more corner cases to
cover.

Jiufei,

If you are interested, you can try out the experimental code [2] to
see how it plays with aio, although since readpages/writepages
are not implemented, overall performance may not be better
(or even worse).

Thanks,
Amir.

[1] https://marc.info/?l=3Dlinux-unionfs&m=3D154995908004146&w=3D2
[2] https://github.com/amir73il/linux/commits/ovl-aops-wip
