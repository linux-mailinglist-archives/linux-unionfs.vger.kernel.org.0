Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9156F143A61
	for <lists+linux-unionfs@lfdr.de>; Tue, 21 Jan 2020 11:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgAUKE3 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 21 Jan 2020 05:04:29 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:45187 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729429AbgAUKE3 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 21 Jan 2020 05:04:29 -0500
Received: by mail-il1-f195.google.com with SMTP id p8so1879361iln.12
        for <linux-unionfs@vger.kernel.org>; Tue, 21 Jan 2020 02:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RLXBHAiHNAu8azvyXTV+09a0bz3r8JrjYniYiKIAJIk=;
        b=XE3IXmVaBH0xT15J4inhfCaaJNjvrEcAPZxpVGLNnbhhgn/YRXcJwiE/8gQ6+frNF1
         CEnKpEnm2+nK0k6YFOSR+igDWtvGEx/s5bhTAWVxpZMFlU6Gstihw+0hVsPZ+zdl/4dB
         Vmjxboy/5EZ5c02MOXR1IslX0C/kmETHiEM5oorxbkMjWHafNVJvgkK8ehwCZ8tUFEbQ
         CdU9E2PIfyqN6BgI4iKQkDujbX2rQDdNfyyTYxNR/IaJ131zVe9GtMlfC9KrPAi7Y68s
         QOBgdgglm9LHpH0QtUbjgFubJ4NhbUt4VHnA+YBwlpivEK1L5P0jxtNisccqzMiG7RlM
         7PsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RLXBHAiHNAu8azvyXTV+09a0bz3r8JrjYniYiKIAJIk=;
        b=mRbCVNSE0An6xHyfl5H/+JMwsoi55BgpifNVPa1/bNm06+j1RuI8ouufYkzbIJOPlm
         9mLIQpCvRbUP5eyLVDokpbZ7WC3aLMVsqUpJbfveOJTjCxQ+xYKi8ueawuYVIZ/laOMD
         1ISWRiiC7Jbuop0qi2zc/7wkJEUUC1DP0mSDY8e/oCkT+8Oi3WX9CN2BJB0Qn6tt9yJb
         /LZesh70VWDhwqK6jFMkl/4/BWMnlserwp03PtqSrSx5YAVEX57M5elsu17cYH0URy/D
         GtTxsFKCyOBrG1r+SwZ9CodTRV3zOYe+lot8GSTEpWKV1FFo4knnBhoqRenGD3eW8Wv/
         EVbQ==
X-Gm-Message-State: APjAAAXT7p2IoJLnfyFAddhGsRpLRsbEf0ZOXyCWhnIf+7SKKek2IzzA
        BmOma+LR/BXZALPEM1Rk0KrOrW36HmpnGfdRFgI=
X-Google-Smtp-Source: APXvYqyNT/IL2Z8mtlgfD/E0sPm23H9z3hrnTTVishsz2XjXq3Cwvvez68TSSVlYME1UI1iSmccTZBc6h0lo85/Jn3k=
X-Received: by 2002:a92:9c8c:: with SMTP id x12mr2907679ill.275.1579601068199;
 Tue, 21 Jan 2020 02:04:28 -0800 (PST)
MIME-Version: 1.0
References: <20191223064025.23801-1-amir73il@gmail.com> <CAOQ4uxh4NygFUFvUp3xs8rZRUkc3SDxO1DL6YrNhx3j0SBgAJg@mail.gmail.com>
In-Reply-To: <CAOQ4uxh4NygFUFvUp3xs8rZRUkc3SDxO1DL6YrNhx3j0SBgAJg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 21 Jan 2020 12:04:17 +0200
Message-ID: <CAOQ4uxjsiQ5PKYSPLmgk5b5O_e5255+QK8Obgs9K--cTi3z=7w@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix wrong WARN_ON() in ovl_cache_update_ino()
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Jan 6, 2020 at 8:35 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Dec 23, 2019 at 8:40 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > The WARN_ON() that child entry is always on overlay st_dev became wrong
> > when we allowed this function to update d_ino in non-samefs setup with
> > xino enabled.
> >
> > It is not true in case of xino bits overflow on a non-dir inode.
> > Leave the WARN_ON() only for directories, where assertion is still true.
> >
> > Fixes: adbf4f7ea834 ("ovl: consistent d_ino for non-samefs with xino")
> > Cc: <stable@vger.kernel.org> # v4.17+
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
>
> Miklos,
>
> If you have time, please send this one to Linus for v5.5.
> It is a simple fix and the only one causing failure in the new xfstests [1]
> that I posted.
>

Gentle nudge..

Thanks,
Amir.
