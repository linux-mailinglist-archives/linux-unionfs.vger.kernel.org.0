Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3252B11E382
	for <lists+linux-unionfs@lfdr.de>; Fri, 13 Dec 2019 13:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfLMMWW (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 13 Dec 2019 07:22:22 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37977 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfLMMWW (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 13 Dec 2019 07:22:22 -0500
Received: by mail-io1-f68.google.com with SMTP id v3so2179715ioj.5
        for <linux-unionfs@vger.kernel.org>; Fri, 13 Dec 2019 04:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ugml9R3pTYs1nOTw8xYTHmo6lAm55LLcCMUAAF7tFLE=;
        b=p2/YhJubD8CdjVhjVrdUplleek6QXtF8Tlb3o/yNfSu9vW1oJJmM/sdBt5T+Njx2I3
         83k1vA9ssd6EfCc4FCy6+3YCx5Kt2dR8jSPVGT14Xm0M8pQK32Tna8j6Zhig/a7kF1fW
         tqmQq223VCyMy/PhNmJNJQV2rZSmEwLu1Ddy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ugml9R3pTYs1nOTw8xYTHmo6lAm55LLcCMUAAF7tFLE=;
        b=GDshuUNdgOpurPanVQ9gTZXo4tirY8TY34NBWFv+K0TaIP9Z1t8R35qFRk6jMegUul
         KhPYeWlH83w/3Z93reTXHL6y6uPvsEquJ+NJ0ahIPJxE76v0MyEQPXzZn8DR0Zwx9Yac
         5GuL6O/QB+D2uAJ0mP5QDiSm1k0LI/axJgVTtAb+R2JCytwGZrfn08jN9ZsxxM2PHK1E
         Zs990HOjvnt9igsk3GEX2fkemN+9fzH3K4kn6z33ulV/QJK2XitZapV36Ahbb1mHK4C7
         SIATJJUgJNkX4jhyJNZwprpf+NBfrpmP8RtWoOjQi1F0LQIJi0YgmxnUo/aK2VdnPwhA
         mTxg==
X-Gm-Message-State: APjAAAXKE2O5akN25wWWXggKiaBcT4q7dPW4EH05co+t/HHMIk+QpoB1
        e8T1+bIKfcDt3FNd1CeN46aQJ/JOIbjg6r0GElZ0mhBVGPQ=
X-Google-Smtp-Source: APXvYqzsp3/8dXsSLanSdtpI2m6y2H2XbzcVrbotMmPaWac97Y9BoJqlp0F7L8w777TNA8667k3Dv10x8Sv7Q4OCsCE=
X-Received: by 2002:a05:6638:762:: with SMTP id y2mr12116503jad.78.1576239741720;
 Fri, 13 Dec 2019 04:22:21 -0800 (PST)
MIME-Version: 1.0
References: <20191213103705.iurz35cawvp6w46w@kili.mountain>
In-Reply-To: <20191213103705.iurz35cawvp6w46w@kili.mountain>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 13 Dec 2019 13:22:10 +0100
Message-ID: <CAJfpegv1d=XRcqD0yJpobP2j3F+gBbKhmJ2mUzwq33s=4gD4Bw@mail.gmail.com>
Subject: Re: [bug report] ovl: make sure that real fid is 32bit aligned in memory
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Fri, Dec 13, 2019 at 11:38 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Amir Goldstein,
>
> This is a semi-automatic email about new static checker warnings.
>
> The patch cbe7fba8edfc: "ovl: make sure that real fid is 32bit
> aligned in memory" from Nov 15, 2019, leads to the following Smatch
> complaint:
>
>     fs/overlayfs/copy_up.c:338 ovl_set_origin()
>      warn: variable dereferenced before check 'fh' (see line 337)
>
> fs/overlayfs/copy_up.c
>    336           */
>    337          err = ovl_check_setxattr(dentry, upper, OVL_XATTR_ORIGIN, fh->buf,
>                                                                           ^^^^^^^
> The patch adds an unconditional dereference

But in fact fh->buf is not a dereference:

struct ovl_fh {
    u8 padding[3];    /* make sure fb.fid is 32bit aligned */
    union {
        struct ovl_fb fb;
        u8 buf[0];
    };
} __packed;

Subsequent code will also not dereference fh->buf, because the
supplied size is zero.

Thanks,
Miklos
