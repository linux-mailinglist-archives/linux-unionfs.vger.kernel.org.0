Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA65EB10B
	for <lists+linux-unionfs@lfdr.de>; Thu, 31 Oct 2019 14:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfJaNUY (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 31 Oct 2019 09:20:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40224 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726735AbfJaNUY (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 31 Oct 2019 09:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572528023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lu4puYQZ5egA/k4O8zS11Qn9Ge3Te9BBdeIVy8pCshY=;
        b=HPxQHOH5iDSWYf3uL37qCX73WTWaeGQ+EBX9CiysTQpcZxb7vN4tv299l7K70MDtoNG2hE
        o2PSSrC0cusizReW7oVwmt8Fb6hIP0oHi2wq6pTiLF6KqS90Ud7p3yxT5TrFFHY1cLCmB4
        Tc31Q3yYxIIeN3njjFQKh44paSFsYLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-Xl9Wzd9mOLiGshiIf88Sgw-1; Thu, 31 Oct 2019 09:20:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BF15107ACC0;
        Thu, 31 Oct 2019 13:20:18 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D4075C1BB;
        Thu, 31 Oct 2019 13:20:17 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 2E3DE2237B5; Thu, 31 Oct 2019 09:20:17 -0400 (EDT)
Date:   Thu, 31 Oct 2019 09:20:17 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Chengguang Xu <cgxu519@mykernel.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: [PATCH v2] ovl: improving copy-up efficiency for big sparse file
Message-ID: <20191031132017.GA7308@redhat.com>
References: <20191030124431.11242-1-cgxu519@mykernel.net>
 <CAOQ4uxh670WFhwpQyPFTB2nUCSc9n1VmuyPOfdqiBSsq6GxLpQ@mail.gmail.com>
 <16e204de70e.cefd69461771.2205150443916624303@mykernel.net>
 <CAOQ4uxhdSXAvFQfhzZpBC=Xmmo9y+3AOU1o-tOWsLtr2ntU6Ag@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxhdSXAvFQfhzZpBC=Xmmo9y+3AOU1o-tOWsLtr2ntU6Ag@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Xl9Wzd9mOLiGshiIf88Sgw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, Oct 31, 2019 at 08:53:15AM +0200, Amir Goldstein wrote:
[..]
> >  > > +
> >  > > +       if (!error && set_size) {
> >  > > +               inode_lock(new->dentry->d_inode);
> >  > > +               error =3D ovl_set_size(new->dentry, stat);
> >  > > +               inode_unlock(new->dentry->d_inode);
> >  > > +       }
> >  >
> >  > I see no reason to repeat this code here.
> >  > Two options:
> >  > 1. always set_size at the end of ovl_copy_up_inode()
> >  >     what's the harm in that?
> >
> > I think at least it's not suitable for directory.
> >
> >
> >  > 2. set boolean c->set_size here and check it at the end
> >  >     of ovl_copy_up_inode() instead of checking c->metacopy
> >  >
> >
> > I don't understand why 'c->set_size' can replace 'c->metacopy',
> >
>=20
> I did not explain myself well.
>=20
> This should be enough IMO:
>=20
> @@ -483,7 +483,7 @@ static int ovl_copy_up_inode(struct
> ovl_copy_up_ctx *c, struct dentry *temp)
>         }
>=20
>         inode_lock(temp->d_inode);
> -       if (c->metacopy)
> +       if (S_ISREG(c->stat.mode))
>                 err =3D ovl_set_size(temp, &c->stat);

Hi Amir,

Why do we need this change. c->metacopy is set only for regular files.

ovl_need_meta_copy_up() {
        if (!S_ISREG(mode))
                return false;
}

Even if there is a reason, this change should be part of a separate patch.
What connection does it have to skip holes while copying up.

Thanks
Vivek

