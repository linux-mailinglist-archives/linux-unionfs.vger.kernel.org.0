Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9174FB0B62
	for <lists+linux-unionfs@lfdr.de>; Thu, 12 Sep 2019 11:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbfILJ2w (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 12 Sep 2019 05:28:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36878 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730268AbfILJ2v (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 12 Sep 2019 05:28:51 -0400
Received: by mail-io1-f68.google.com with SMTP id r4so52872790iop.4
        for <linux-unionfs@vger.kernel.org>; Thu, 12 Sep 2019 02:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ySusEsEvIA1p7Ok5MeAC6hgYTUozA4I6kAXqI82zhqE=;
        b=ejjO79R3dG15jay2GvSB7zkWjnzn7JGpb2WokQ8V16v5w8JmDpD1ugMmEJijAjND7j
         Xymg+XPaHSscKaMChl399p9WZvVn+txz6OSLwbpTgQlls2BVfXXh6Swc1cAkR1QK1g/K
         WJtGq95B0KvPHNpdCwhvk+SNR1BNJw80XxtaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ySusEsEvIA1p7Ok5MeAC6hgYTUozA4I6kAXqI82zhqE=;
        b=G6jbG4XpiNakmdQEKvUum+oJ1MzCFDf8DtHZKXGEpjHkxNNjxGeM9qnrYqmlfP30k0
         rJLY2St7dRAmbUXwLHR1VVaw7YB+0svemg+DFdyQrP+ff4qaYqduX66jQXib/WqbKvhz
         pwKCGawN+FSDFLZ1V7b0amYjDOHVQwTmh0hv7rMt3UfPVtBYLMN6YWm+2BwSfs5cGNWv
         NuWuLHgOH9ugHKJQXwtzKlZpNK9w8tTIR/b+uB4xIrMeFyNl0ntl3oMSVSPdeu5gW7Vb
         Zf61Bvxtq+uGPacS/ri4olFNOEphGFwKSIGRZhqx5tO9End9UwZLfZBAXbqI6v6FtjLr
         KI/A==
X-Gm-Message-State: APjAAAUHItF6kd16/4efsHT+KinvP1pAAaJ0T0u15D9d4Qy8iouqMhMA
        4G6W2W46hQmeNTTe/A4NbBaXODbcpPXoiQ/EIrYRNw==
X-Google-Smtp-Source: APXvYqwKtyjoNjSXdno7ZVe7FfQu1Nx0FJSMjH78DCZyjeB4BZrHt6OOPtbuFZl7IsH3X/FMzz9J645srsCQV3vf1JU=
X-Received: by 2002:a6b:6602:: with SMTP id a2mr3022334ioc.63.1568280530746;
 Thu, 12 Sep 2019 02:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <1568265511-1622-1-git-send-email-dingxiang@cmss.chinamobile.com> <CAOQ4uxjNK9BQxmNqbx8Hix0yd5op-i17BiqvOmmEmr=3bHtm_A@mail.gmail.com>
In-Reply-To: <CAOQ4uxjNK9BQxmNqbx8Hix0yd5op-i17BiqvOmmEmr=3bHtm_A@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 12 Sep 2019 11:28:39 +0200
Message-ID: <CAJfpeguVGk7Fpusx83YDstBgNtFZbVwP61aDin6kvA1f5CKCcA@mail.gmail.com>
Subject: Re: [PATCH V2] ovl: Fix dereferencing possible ERR_PTR()
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Ding Xiang <dingxiang@cmss.chinamobile.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, Sep 12, 2019 at 8:02 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Sep 12, 2019 at 8:24 AM Ding Xiang
> <dingxiang@cmss.chinamobile.com> wrote:
> >
> > if ovl_encode_real_fh() fails, no memory was allocated
> > and the error in the error-valued pointer should be returned.
> >
> > V1->V2: fix SHA1 length problem
> >
> > Fixes: 9b6faee07470 ("ovl: check ERR_PTR() return value from ovl_encode_fh()")
> > Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> > ---
> >  fs/overlayfs/export.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> > index cb8ec1f..50ade19 100644
> > --- a/fs/overlayfs/export.c
> > +++ b/fs/overlayfs/export.c
> > @@ -229,7 +229,7 @@ static int ovl_d_to_fh(struct dentry *dentry, char *buf, int buflen)
> >                                 ovl_dentry_upper(dentry), !enc_lower);
> >         err = PTR_ERR(fh);
> >         if (IS_ERR(fh))
> > -               goto fail;
> > +               return err;
> >
>
> Please fix the code in warning message instead of skipping the warning.

Not sure that makes sense.   ovl_encode_real_fh() will either return
-EIO in case of an internal error with WARN_ON() or it will return
-ENOMEM on memory allocation failure, which doesn't warrant a debug
message.

Thanks,
Miklos
