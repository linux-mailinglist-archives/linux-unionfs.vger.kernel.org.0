Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA73A35C8A0
	for <lists+linux-unionfs@lfdr.de>; Mon, 12 Apr 2021 16:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241906AbhDLOWz (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 12 Apr 2021 10:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241296AbhDLOWz (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 12 Apr 2021 10:22:55 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C01C06174A
        for <linux-unionfs@vger.kernel.org>; Mon, 12 Apr 2021 07:22:37 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id x14so2016880vsc.5
        for <linux-unionfs@vger.kernel.org>; Mon, 12 Apr 2021 07:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MmDshLKsaE48dL8n2Lv7busYCP/JRDXfgccRaZ4aSQQ=;
        b=Ao7BPS+MPKptCfhony66jDGT9euXcPmNkLm7uNy02KX/Z3homldZUUlyRsDSzsl3ck
         bxuf1syZlt1c/bD4zUQnrat+Tc3KLbL4/d5KGR4r8y6mYchNSRh92GMUS5QSL1tTldKP
         ZJwzO7ide7exNjgUjsNEjI8tKvmkL+VXHe/X8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MmDshLKsaE48dL8n2Lv7busYCP/JRDXfgccRaZ4aSQQ=;
        b=LLcjG2DvbxYalkrTksvQ7hrh1q1bPFrJFMkUrflzx7g4IIpJOztCDWKmgdflm2xWOt
         mV7XxP4O6tPxBx8ln/uqVFtv0wDyinpQ1YLVwqKabnbpT+sToNieJixDJcSDG6IQWA/P
         ogENbE7UPPSqTGBdCwyDYN6Atmnf+yXE6lEqiowEICcECwNK0L/gqJlYD/SCpfynmluh
         RT6kKJMXSSq0TCoehWxMaOizxD068ggz5i+2cXLFppTTRp6rG3L0+PYnho0G7gD7itQF
         MI1dxbo5ifdkF0qOp1B2VYbqEwD8i4axFKn8oPthBq+9FA2a/gWTSup+AfcAwEJp5sfe
         Aeew==
X-Gm-Message-State: AOAM531l5PUsld8htB+wpIF8aqJZMYVpk0+hptKxDjVwnzPo63OWxmzV
        BWDe/MwTXSOLEHveFbibuM4oiMcpyn4yCKCWI04DGg==
X-Google-Smtp-Source: ABdhPJz2enjHwFAax8upkX0FyivRhIpYizN3FYM/otYY3J8/8ZYriu5E6MTIlMyyDDOWw/kImEP2BZd6rzHgKVnUBUg=
X-Received: by 2002:a67:f487:: with SMTP id o7mr20374917vsn.7.1618237356422;
 Mon, 12 Apr 2021 07:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201113065555.147276-1-cgxu519@mykernel.net> <20201113065555.147276-10-cgxu519@mykernel.net>
 <CAJfpegsoDL7maNtU7P=OwFy_XPgcyiBOGFzaKRbGnhfwz-HyYw@mail.gmail.com> <178c609f366.d091ec3b20881.6800515353355931740@mykernel.net>
In-Reply-To: <178c609f366.d091ec3b20881.6800515353355931740@mykernel.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 12 Apr 2021 16:22:24 +0200
Message-ID: <CAJfpegvWNWiuvMAW2gmeu39An-xmc5xv6BSMPXujQ7R8UsEtJA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 9/9] ovl: implement containerized syncfs for overlayfs
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Apr 12, 2021 at 2:24 PM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2021-04-09 21:51:26 Miklos S=
zeredi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
>  > On Fri, Nov 13, 2020 at 7:57 AM Chengguang Xu <cgxu519@mykernel.net> w=
rote:
>  > >
>  > > Now overlayfs can only sync dirty inode during syncfs,
>  > > so remove unnecessary sync_filesystem() on upper file
>  > > system.
>  > >
>  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>  > > ---
>  > >  fs/overlayfs/super.c | 11 ++++++++---
>  > >  1 file changed, 8 insertions(+), 3 deletions(-)
>  > >
>  > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
>  > > index 982b3954b47c..58507f1cd583 100644
>  > > --- a/fs/overlayfs/super.c
>  > > +++ b/fs/overlayfs/super.c
>  > > @@ -15,6 +15,8 @@
>  > >  #include <linux/seq_file.h>
>  > >  #include <linux/posix_acl_xattr.h>
>  > >  #include <linux/exportfs.h>
>  > > +#include <linux/blkdev.h>
>  > > +#include <linux/writeback.h>
>  > >  #include "overlayfs.h"
>  > >
>  > >  MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
>  > > @@ -270,8 +272,7 @@ static int ovl_sync_fs(struct super_block *sb, i=
nt wait)
>  > >          * Not called for sync(2) call or an emergency sync (SB_I_SK=
IP_SYNC).
>  > >          * All the super blocks will be iterated, including upper_sb=
.
>  > >          *
>  > > -        * If this is a syncfs(2) call, then we do need to call
>  > > -        * sync_filesystem() on upper_sb, but enough if we do it whe=
n being
>  > > +        * if this is a syncfs(2) call, it will be enough we do it w=
hen being
>  > >          * called with wait =3D=3D 1.
>  > >          */
>  > >         if (!wait)
>  > > @@ -280,7 +281,11 @@ static int ovl_sync_fs(struct super_block *sb, =
int wait)
>  > >         upper_sb =3D ovl_upper_mnt(ofs)->mnt_sb;
>  > >
>  > >         down_read(&upper_sb->s_umount);
>  > > -       ret =3D sync_filesystem(upper_sb);
>  > > +       wait_sb_inodes(upper_sb);
>  > > +       if (upper_sb->s_op->sync_fs)
>  > > +               ret =3D upper_sb->s_op->sync_fs(upper_sb, wait);
>  > > +       if (!ret)
>  > > +               ret =3D sync_blockdev(upper_sb->s_bdev);
>  >
>  > Should this instead be __sync_blockdev(..., wait)?
>
> I don't remember why we skipped the case of (wait =3D=3D 0) here, just gu=
ess it's not worth
> to export internal function __sync_blockdev() to modules, do you prefer t=
o call __sync_blockdev()
> and handle both nowait and wait cases?

Possibly it would make most sense to export the "->sync_fs() +
__sync_blockdev()" part of __sync_filesystem() as a separate helper.

Thanks,
Miklos
