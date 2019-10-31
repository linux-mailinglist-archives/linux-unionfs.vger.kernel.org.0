Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A200EB16B
	for <lists+linux-unionfs@lfdr.de>; Thu, 31 Oct 2019 14:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfJaNo4 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 31 Oct 2019 09:44:56 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:33327 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbfJaNo4 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 31 Oct 2019 09:44:56 -0400
Received: by mail-il1-f195.google.com with SMTP id s6so5451189iln.0
        for <linux-unionfs@vger.kernel.org>; Thu, 31 Oct 2019 06:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=15DL4EL4AaSlWxugAWuS2I+sC+wiUn4BfwaBIkyXE7c=;
        b=IYLkxBJXGcvZUXSgDwdC5a/heELN2qYh5jnf2k3cTFT8TlreCPOjIAyxWb3P7qpzBY
         Vcdm53oZzNpRFIzcorFqg1xM7SbotmnULkXhJp8T0stUXwtl50WLvq5sDkkdf80JJ2tI
         ejsgG7kh7UF1tLtOvrGqj/hJw6w0EcQm8QocA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=15DL4EL4AaSlWxugAWuS2I+sC+wiUn4BfwaBIkyXE7c=;
        b=D7EDOJS0UAmIC7u8cNnoiqX1QcVXXtmi0Pr2H3dgLJftTIImRmbQQ9CbxKGOVcKZFc
         Wc+xMsULY4iNmLQ1SwkUJVPP4w+TJn43pipOr0P98rUY833sePOYX5DuGU0Nivi/oTps
         slms6T6PNkpDGla9TSyepHKdlughj2Lw2KG/p5S4UgpDDLmaJDstldHVaGJepKY6kdsj
         6Nh3J0GyBExNigZ0ZfZWQ0HgWapdlUkFKHPrxoihbhOmqICOqRmgyQ2t6DgfQ1OBPomH
         avcFuGHLoeixnG1j1C/Zw1PmOHaW57r2bteXoc3Jrtjh3+J+s6O0B/xwyUiYLagszbCK
         VF3Q==
X-Gm-Message-State: APjAAAX/H4/rwHXNVEtp9i7YLWpRwqU0na2MODw+fjduW0EWRHyUJWYg
        YdW5cIDx4jJ6AqFFlnlD5TT8f8HVNMjGOkGbUXb8uQ==
X-Google-Smtp-Source: APXvYqzT7xhCM4Cbby0FBGOkRJx/9fuO/Ntbma0NmDt2IKOz7LDQXHZBLnn9N4Pd8ZKuX87fNoj2wFx/ND1DsE+8/xs=
X-Received: by 2002:a92:2c0a:: with SMTP id t10mr6035309ile.285.1572529495685;
 Thu, 31 Oct 2019 06:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191030124431.11242-1-cgxu519@mykernel.net> <CAOQ4uxh670WFhwpQyPFTB2nUCSc9n1VmuyPOfdqiBSsq6GxLpQ@mail.gmail.com>
 <16e204de70e.cefd69461771.2205150443916624303@mykernel.net>
 <CAOQ4uxhdSXAvFQfhzZpBC=Xmmo9y+3AOU1o-tOWsLtr2ntU6Ag@mail.gmail.com> <20191031132017.GA7308@redhat.com>
In-Reply-To: <20191031132017.GA7308@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 31 Oct 2019 14:44:44 +0100
Message-ID: <CAJfpegtsnmBjK5XVUNOU5CU8Ux71y8uN1d4hHYmjVMmYPLJD4g@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: improving copy-up efficiency for big sparse file
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Chengguang Xu <cgxu519@mykernel.net>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, Oct 31, 2019 at 2:20 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Thu, Oct 31, 2019 at 08:53:15AM +0200, Amir Goldstein wrote:

> >
> > @@ -483,7 +483,7 @@ static int ovl_copy_up_inode(struct
> > ovl_copy_up_ctx *c, struct dentry *temp)
> >         }
> >
> >         inode_lock(temp->d_inode);
> > -       if (c->metacopy)
> > +       if (S_ISREG(c->stat.mode))
> >                 err = ovl_set_size(temp, &c->stat);
>
> Hi Amir,
>
> Why do we need this change. c->metacopy is set only for regular files.
>
> ovl_need_meta_copy_up() {
>         if (!S_ISREG(mode))
>                 return false;
> }
>
> Even if there is a reason, this change should be part of a separate patch.
> What connection does it have to skip holes while copying up.

That's a fix only if the copied-up file ends in a hole, which was not
the case before this patch.   But harmless, and makes sense generally
(i.e. file is truncated to final size *before* data is copied up).

Thanks,
Miklos
