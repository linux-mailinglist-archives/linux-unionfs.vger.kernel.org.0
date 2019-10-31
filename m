Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1CEFEACAE
	for <lists+linux-unionfs@lfdr.de>; Thu, 31 Oct 2019 10:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfJaJmF (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 31 Oct 2019 05:42:05 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45900 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfJaJmE (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 31 Oct 2019 05:42:04 -0400
Received: by mail-yb1-f195.google.com with SMTP id q143so2073993ybg.12
        for <linux-unionfs@vger.kernel.org>; Thu, 31 Oct 2019 02:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xB4VR4wdPigq0Chnswlsj+7YBFKPewG5hAolQOBRmII=;
        b=Uq3Won4tfIdDwFcDKkzoyyQrlbvIIMwwxRlRk4YoLjI7GKfEB2ymHoPiXazaV2qXOI
         LcUf/4b/IlKKWU7De54OWxHg6qNgjMAiJSMsm2VILrpPnt8FhQkLHyibiVc03c3rIo2O
         Xb4mkoH7d0SPNxDTOJrXQUnzQJUq2qQrrXAeyAm/l7QgK0D1ACOcLLRZItQshzC1Anoa
         teRLb6reqgUckevUJzKlNiXVtbthCxjdgI5nff/asH0fVeMkUCigLxk45ryJC58pOZje
         zCIilQOMYv8/x1O4JgrfKK2i0CTguk9d61bIGFCmxV+YPJDk2uNWFcBaTl9BRhVuYcfL
         J6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xB4VR4wdPigq0Chnswlsj+7YBFKPewG5hAolQOBRmII=;
        b=NE2RyMLrX6sZR5AkInwR9TsPpnpy1WKh57m72At99Z8lRuCx+n6Jz3wd+dwDOpj6zK
         EPWJf1ovei1tQdYHO/0x0mt+h2r96Kmd+UDV+mNJd000CcS+A3/VTobDbEBBpWABjSYq
         Od32HjTsF774MGqwFRCQD8idlg8sabucVtG9z12qzFpwLO1E2Feb7sg2fw+PcATBfDY3
         wIOJmAqZSV1V8+0FI8zTcngCES+xYs976yBdPOn2zEh7JE8LwNwkA1qX9MhcJrLvMsre
         Bc2g2JQttIhm7Nf4tP+8L9OMtyxSnEPSetOd5T5AgtjO1MZdGcHM1IVZKx9OQuiGrurv
         tJEA==
X-Gm-Message-State: APjAAAVNGZjguiZ2TAfZOZS+O0ooTezV2XcT+OrnUUhDcZ4tOPQ/FKHd
        +JDv7uoRMcC5iSA8bpRRPFpmoiue413ug2/+EzE=
X-Google-Smtp-Source: APXvYqzTgJuZzuQ0Md/I0cvMWp6HmrpZ6kP6Z2nF1FlroACVOYmQnX3rfd34S6wsPvd4Gby3zk7Rn6uKt9si2iicyTM=
X-Received: by 2002:a25:3886:: with SMTP id f128mr3351650yba.14.1572514923794;
 Thu, 31 Oct 2019 02:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191030124431.11242-1-cgxu519@mykernel.net> <CAOQ4uxh670WFhwpQyPFTB2nUCSc9n1VmuyPOfdqiBSsq6GxLpQ@mail.gmail.com>
 <16e204de70e.cefd69461771.2205150443916624303@mykernel.net>
 <CAOQ4uxhdSXAvFQfhzZpBC=Xmmo9y+3AOU1o-tOWsLtr2ntU6Ag@mail.gmail.com>
 <16e20ebaea1.e98a5dc22147.7820959102365222617@mykernel.net>
 <CAOQ4uxihFu+ObkUxrZ3kzM1G5NrRauhgGxupuBarbAJaXSS_Zg@mail.gmail.com> <16e211d1b09.13a4295c32260.2957618455193007862@mykernel.net>
In-Reply-To: <16e211d1b09.13a4295c32260.2957618455193007862@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 31 Oct 2019 11:41:52 +0200
Message-ID: <CAOQ4uxi0BK7D10pRBnTPZYeXFKp81sUDOT=O=-tL5x=sJK4bNA@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: improving copy-up efficiency for big sparse file
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, Oct 31, 2019 at 11:20 AM Chengguang Xu <cgxu519@mykernel.net> wrote=
:
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2019-10-31 17:06:24 Amir Gol=
dstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
>  > >  > I did not explain myself well.
>  > >  >
>  > >  > This should be enough IMO:
>  > >  >
>  > >  > @@ -483,7 +483,7 @@ static int ovl_copy_up_inode(struct
>  > >  > ovl_copy_up_ctx *c, struct dentry *temp)
>  > >  >         }
>  > >  >
>  > >  >         inode_lock(temp->d_inode);
>  > >  > -       if (c->metacopy)
>  > >  > +       if (S_ISREG(c->stat.mode))
>  > >  >                 err =3D ovl_set_size(temp, &c->stat);
>  > >  >         if (!err)
>  > >  >                 err =3D ovl_set_attr(temp, &c->stat);
>  > >  >
>  > >  > There is no special reason IMO to try to spare an unneeded ovl_se=
t_size
>  > >  > if it simplifies the code a bit.
>  > >
>  > > We can try this but I'm afraid that someone could complain
>  > > we do unnecessary ovl_set_size() in the case of full copy-up
>  > > or data-end file's copy-up.
>  > >
>  > >
>  >
>  > There is no one to complain.
>  > The cost of ovl_set_size() is insignificant compared to the cost of
>  > copying data (unless I am missing something).
>  > Please post a version as above and if Miklos finds it a problem,
>  > we can add a boolean c->should_set_size to the copy up context, initia=
lize
>  > it: c->should_set_size =3D (S_ISREG(c->stat.mode) && c->stat.size)
>  > and set it to false in case all data was copied.
>  > I think that won't be necessary though.
>  >
>
> I forgot to mention that there are two callers of  ovl_copy_up_data()
> and ovl_copy_up_meta_inode_data() even don't have logic to set size.

Because set_size was already done during meta copy up and
"data copy up" does not need to change the size again.

> So do you still think set size in ovl_copy_up_inode() is simpler than
> set size inside ovl_copy_up_data()?
>

Yes. One line change is simpler.

Thanks,
Amir.
