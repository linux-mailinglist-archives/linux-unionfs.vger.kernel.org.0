Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB4C0F42D1
	for <lists+linux-unionfs@lfdr.de>; Fri,  8 Nov 2019 10:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbfKHJCi (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 8 Nov 2019 04:02:38 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37568 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbfKHJCi (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 8 Nov 2019 04:02:38 -0500
Received: by mail-io1-f66.google.com with SMTP id 1so5567151iou.4
        for <linux-unionfs@vger.kernel.org>; Fri, 08 Nov 2019 01:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FfJKRFxBA/jr6AHQGLbkSnPgy7Ot2oIUyOqLYII6K4w=;
        b=lKic9z/lFSs0g7U3pnoc1ffXgIJ2viM0ipf2iwXMsArKjbRaUX4gEvc33kjoWVGD6W
         KqX4y7v8ipU2Z9ehzrsmgfXDwtwOnTF9gWGF+c6RvQ6lUzuzLI3PXWCfnxTknv4VrW9m
         BRHf4Fwld4nPszFKt0qNmZWctSt8InvgVKk8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FfJKRFxBA/jr6AHQGLbkSnPgy7Ot2oIUyOqLYII6K4w=;
        b=FbQfXVpiDqzryOeIJ8zQJrzuXjuvMQxo9bizUep/+UfC593y6FtfFTuJ1mNML98oC1
         NO+scWV75hsfiyi55C4tWab3jCTXWmVBh5boEsVWaoL8fakuLNG8SOEnRoO5PGygprwh
         0WiGQtM7Thgg7OvD+UZgR0dkTepHIjHxLcLJxGHeXkjBPbjapODwHR0Cwg8zyjlILNj2
         Fg/RdPLfNW7q+nIHFGSE/rq2XWR0WocZf/nC4MXIc0X3ZWWsVCw74ElC4Qv786wj8321
         j30+rbhK4sQVh0gCsh5bI8uGEYThpyDqR96BZTd7GHH8+466DrK7knkVXvtbJGjefAsD
         ZmSA==
X-Gm-Message-State: APjAAAUzryV1a62A/tmkKSeM4QbPs9DLjczJ53vSFtf+rPJx2tRv+Ko/
        xV1WEjdxkR6DrXj21V3zDplnzHXLd8ZDBUpKnRa4+oJF9Ls=
X-Google-Smtp-Source: APXvYqwxaeZ3OCvyqMLN0h5rV0bUoYKh7y1cno+c0kwclUwS2KVaY6M9MLZmv/Q8yDjcTl2v8pB7W2gm54kgOCeM3GI=
X-Received: by 2002:a6b:3bca:: with SMTP id i193mr8736332ioa.285.1573203757378;
 Fri, 08 Nov 2019 01:02:37 -0800 (PST)
MIME-Version: 1.0
References: <1573202522019.97305@axis.com>
In-Reply-To: <1573202522019.97305@axis.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 8 Nov 2019 10:02:26 +0100
Message-ID: <CAJfpegs2Hj9rqUiF+jmi5VK2XT_BV1+nNzKv140kLPPMaQgv2g@mail.gmail.com>
Subject: Re: [Help] Problem when using overlayfs with LoadPin
To:     Anders Dellien <anders.dellien@axis.com>
Cc:     "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Fri, Nov 8, 2019 at 9:42 AM Anders Dellien <anders.dellien@axis.com> wrote:
>
> Hi all,
>
> I have previously successfully used LoadPin [https://www.kernel.org/doc/html/latest/admin-guide/LSM/LoadPin.html]
> together with overlayfs, however commit a6518f "vfs: don't open real" introduces a regression.
>
> (from loadpin.c):
>
>         /* file_dentry sees through overlays */
>         load_root = file_dentry(file)->d_sb;  (here, load_root->s_bdev is NULL and not the actual block device from the lower layer)

Umm, where does the above line come from?

Mainline looks like this:

    load_root = file->f_path.mnt->mnt_sb;

What is the expected behavior?   Should loadpin see through overlayfs or not?

Thanks.
Miklos
