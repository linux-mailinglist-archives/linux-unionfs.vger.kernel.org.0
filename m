Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343F772B3B4
	for <lists+linux-unionfs@lfdr.de>; Sun, 11 Jun 2023 21:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjFKThQ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 11 Jun 2023 15:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjFKThP (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 11 Jun 2023 15:37:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DDFEE
        for <linux-unionfs@vger.kernel.org>; Sun, 11 Jun 2023 12:37:14 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9745baf7c13so527822166b.1
        for <linux-unionfs@vger.kernel.org>; Sun, 11 Jun 2023 12:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1686512233; x=1689104233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t53JaZQiA5kvc2UsfPRnIjKanstp7CpQK0e3h3rebXw=;
        b=pO+zErFXvUdqeIlRDqBXFoYkofdje3Ddh+WYCdNVBNhSfYqYyIaIEjxsVQvD4Q+jct
         9n/9LXYjyJMRtDfKw4FcU0oAKZrfNTQqoTMRKVHWUHuSfrSodD00LoAX+/c3ZcCh3ToV
         0G7NG1lvuMUyaIkD8+dswATodhjq9W4isytg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686512233; x=1689104233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t53JaZQiA5kvc2UsfPRnIjKanstp7CpQK0e3h3rebXw=;
        b=XUghiY9PB8kfUZqqyss3n0WdMl7Ij5yxSNMnsfw8LHx55Dd7/CYVnNE0jEuEPAH9TO
         gePevObucToYyIsf+IfLM9C4B9zdVQiz+CVwqfnC5BwIGVVRb9a6AZ2sbDmRk1/ab7uv
         NXkJUo7U3jyFBvO0n9EY0WUt0JE8aG8Zr2TmWKEm8NhO6is5ri+3OPNU5XD7iGX0dJqD
         7lK7156Ahos63ppDnjQaIyhYBgLz8nCBz05EOLjTDh6ou1fA6Jc7mis8XvnhvR4erFG3
         Al7YifstMRNMCSjNkOga8JJc/pUPtPP/GkGMUd3GGcll9lEirxprlnVuJwv+AVu5Rd3w
         c/+w==
X-Gm-Message-State: AC+VfDywZ6e+iwf9UgRQf202jqfapcdvfiFEad969WWE8uClYvLdTrhe
        dEkrRlSe1R8lREDv9Uo3iYgo6Pu1Kznj8vKtLz6/nOKtdZQGKUw8
X-Google-Smtp-Source: ACHHUZ5gn4mgbBGusibGRfBYjdC4JSEfnJRLz2fn+8jyQQmfpVTtcfUYyIR2mGwB10EyfM/GUHE2hlZR+Vpjv8acxWU=
X-Received: by 2002:a17:907:3181:b0:974:326b:3362 with SMTP id
 xe1-20020a170907318100b00974326b3362mr6917556ejb.44.1686512232809; Sun, 11
 Jun 2023 12:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230611132732.1502040-1-amir73il@gmail.com> <CAJfpegugmTqJ5rWycxxeQpVBmGTxSHucnQjP7ZwT3K3jMXNcnA@mail.gmail.com>
 <CAOQ4uxgA9=-gTngiiFjBc5E1M==qP4T0aeiD5608nJxhQuqp+Q@mail.gmail.com>
 <CAOQ4uxiDL+u3SS-=HsNaHwPLz2CAV=8oDCED5RtzPhmFwQmkZw@mail.gmail.com>
 <CAJfpegu2CAvrqGfACuc+ux4430wwDrSeuXPEeUy0FE=fDrW6FA@mail.gmail.com> <CAOQ4uxiX3joJ7P1wJZMmLb6jsmzhAeLDXD0aZzf5-5Brop1C3Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxiX3joJ7P1wJZMmLb6jsmzhAeLDXD0aZzf5-5Brop1C3Q@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Sun, 11 Jun 2023 21:37:01 +0200
Message-ID: <CAJfpeguTNtLmrnvTiqe1KqWEOOLPF7wM_vOWwb+ifP28aynFnA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Handle notifications on overlayfs fake path files
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Sun, 11 Jun 2023 at 21:25, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Sun, Jun 11, 2023 at 10:12=E2=80=AFPM Miklos Szeredi <miklos@szeredi.h=
u> wrote:
> >
> > On Sun, 11 Jun 2023 at 19:52, Amir Goldstein <amir73il@gmail.com> wrote=
:
> >
> > > Is it because getting f_real_path() and file_dentry() via d_real()
> > > is more expensive?
> > > and caching this information in file_fake container would be
> > > more efficient?
> > >
> > > I will restore the file_fake container and post v3.
> >
> > I simply dislike the fact that ->d_real() is getting more complex.
> > I'd prefer d_real to die, which is unfortunately not so easy, as
> > you've explained.
> >
> > But if we can make it somewhat less complex (remove the inode
> > parameter) instead of more complex (add a vfsmount * parameter) then
> > that's already a big win in my eyes.
> >
>
> OK, I can relate to that.
>
> Here is file_fake restored, now with fsnotify fix also tested:
>
> https://github.com/amir73il/linux/commits/ovl_fake_path
>
> IIUC, you would now want to change file_dentry(f) to using
> f_real_file(f)->dentry and get rid of the inode argument to d_real().
>
> Do you want that change also in v3 or should we save some fun for later
> and just fix fsnotify for now?

Can do that later.  Small steps are good.

Thanks,
Miklos
