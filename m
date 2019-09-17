Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611B8B4F87
	for <lists+linux-unionfs@lfdr.de>; Tue, 17 Sep 2019 15:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfIQNmY (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 17 Sep 2019 09:42:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41312 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfIQNmY (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 17 Sep 2019 09:42:24 -0400
Received: by mail-io1-f67.google.com with SMTP id r26so7620786ioh.8
        for <linux-unionfs@vger.kernel.org>; Tue, 17 Sep 2019 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U2rVr6WUs6V+4kaxR2xM83AS/PtuDBPgg9TdhRKOFnk=;
        b=K34636yX4u6n6PkQXaPFqIdmGB8JhjIsaEdgbIcy0Db0H2RYuK14nv9YTsBMKrqbGR
         uJOOBdsOqJVb4vEynQZOYLtGcxw5b9KGlD7l2k3c68EJyEnyZGyFkhTMXGNspoUkPKpD
         nSLe4miSXDuSAkYZx1V45MoRKaetzC2oPgXmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2rVr6WUs6V+4kaxR2xM83AS/PtuDBPgg9TdhRKOFnk=;
        b=uGVZhX4LjaL4WbqjOLWouwhuXQ6fbslKiFF7y1De2QSAdDZHXjlTikCH578V4s9Bty
         dEkIZ9mds5c1I7VDfBCEbNb97hCe+TzrjGLWBcCsJ9AYPg6FVBSs7ifaWMUOz0vPsHa2
         lkYIvNXEUQl+Va6COOEe7DYGrNtdDG7XAOFKWuvXZBqNxB+xfaZe7rAVjeawsJY/BJO1
         +SPE+UDxdC9uEQJRO7Hmb1Qg0HEdNB1kgt4UZiBdMiR8pVlTtktlpYaBvteUTep63aKC
         Kg/SI/fOrm9mS8334TS+E4uWZpHLfm5hWEzPReI5U3UMDJgxExsPSMK9HznAL+15Zlzh
         b1mg==
X-Gm-Message-State: APjAAAXqg3rkCQmasIQ/KG9eH/rXx+Hlt+sEICLaxt2/KsArF9bYtgJ7
        BO4ez1ymEx74sZNq2umK5l0VCdISUI2pZjJSBGE4mOix470=
X-Google-Smtp-Source: APXvYqwWdMGwvZ/4hC7Jp4+UiwvgLigIhk0KJHIlGiAThbI/m4MCiDE4KcSMznoKe9rRwcMr8Wvaw5akl1oPdqF219E=
X-Received: by 2002:a02:6a22:: with SMTP id l34mr4465696jac.33.1568727742465;
 Tue, 17 Sep 2019 06:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <23935.36189.612024.342204@informatik.uni-koeln.de>
 <CAJfpegsk30wCJY1WaQWJOibfw35TGYxUuPBYx8v7xObJBSgTAw@mail.gmail.com>
 <23936.43370.127198.222503@informatik.uni-koeln.de> <CAJfpegu0FprqEkgU2rDCiu-2nr=jwzS3wNZAj6oV-DEdv+v=eQ@mail.gmail.com>
In-Reply-To: <CAJfpegu0FprqEkgU2rDCiu-2nr=jwzS3wNZAj6oV-DEdv+v=eQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Sep 2019 15:42:11 +0200
Message-ID: <CAJfpegvQGQs0CF-EqJM2DLi2EHpw_n5RXt=U4=i2h-TYELQ=HA@mail.gmail.com>
Subject: Re: can overlayfs work wit NFS v4 as lower fs?
To:     Thomas Lange <lange@informatik.uni-koeln.de>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Sep 17, 2019 at 3:26 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, Sep 17, 2019 at 11:37 AM Thomas Lange
> <lange@informatik.uni-koeln.de> wrote:
> >
> > >>>>> On Tue, 17 Sep 2019 10:10:11 +0200, Miklos Szeredi <miklos@szeredi.hu> said:
> >
> >     > This is most probably about nfs4 acl support.   Does "noacl" export
> >     > option fix it?
> > Unfortunately it's not possible to disable acl support for NFS v4 (only in Debian?).
> > That's what I read in some articles.
> >
> > I've added no_acl to the exports line:
> > # exportfs -v
> > /files/scratch  134.95.9.128/25(ro,async,wdelay,no_root_squash,no_subtree_check,no_acl,sec=sys,ro,secure,no_root_squash,no_all_squash)
> >
> > But this command does not show the no_acl option:
> >
> > # cat /proc/fs/nfs/exports
> > # Version 1.1
> > # Path Client(Flags) # IPs
> > /files  134.95.9.128/25(ro,no_root_squash,sync,no_wdelay,no_subtree_check,v4root,uuid=9d4520b3:676a426f:92251f2f:b0e40f3b,sec=390003:390004:390005:1)
> > /       134.95.9.128/25(ro,no_root_squash,sync,no_wdelay,no_subtree_check,v4root,fsid=0,uuid=9d4520b3:676a426f:92251f2f:b0e40f3b,sec=390003:390004:390005:1)
> > /files/scratch  134.95.9.128/25(ro,no_root_squash,async,wdelay,no_subtree_check,uuid=9d4520b3:676a426f:92251f2f:b0e40f3b,sec=1)
> >
> >
> > I've also added -onoacl the the mount command on client side. Still the
> > same results, when I want to write to a file in overlayfs
> >
> > 13415 openat(AT_FDCWD, "/b/merged/etc/test1", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EOPNOTSUPP (Operation not supported)
> >
> >
> > I've checked the access to the  "original" file in the lower (NFS v4
> > mounted) directory, by checking the results of getfacl and nfs4_getfacl.
> >
> >
> > NFS v3, exportfs with no_acl
> > ============================
> > + strace -etrace=getxattr getfacl /b/lower/etc/test1
> > getxattr("/b/lower/etc/test1", "system.posix_acl_access", 0x7ffcb6b56160, 132) = -1 EOPNOTSUPP (Operation not supported)
> > getfacl: Removing leading '/' from absolute path names
> >
> > suenner[~]# strace -etrace=getxattr nfs4_getfacl /b/lower/etc/test1
> > getxattr("/b/lower/etc/test1", "system.nfs4_acl", NULL, 0) = -1 EOPNOTSUPP (Operation not supported)
> >
> >
> >
> > NFS v4 using mount -onoacl, exportfs with no_acl
> > ================================================
> >
> > + strace -etrace=getxattr getfacl /b/lower/etc/test1
> > getxattr("/b/lower/etc/test1", "system.posix_acl_access", 0x7fff39fd9cd0, 132) = -1 EOPNOTSUPP (Operation not supported)
> >
> >
> > + strace -etrace=getxattr nfs4_getfacl /b/lower/etc/test1
> > getxattr("/b/lower/etc/test1", "system.nfs4_acl", NULL, 0) = 80
> > getxattr("/b/lower/etc/test1", "system.nfs4_acl", "\0\0\0\3\0\0\0\0\0\0\0\0\0\26\1\207\0\0\0\6OWNER@\0\0\0\0\0", 80) = 80
> >
> >
> > This shows that disabling ACL in NFS v4 does not work.
> > Does this disturb the behaviour of overlayfs?
>
> The problem is that overlayfs tries to copy-up the system.nfs4_acl,
> but fails (no other filesystem supports this xattr).  Similar thing
> happens with "cp --preserv=xattr".
>
> Looking back...
>
>   https://lore.kernel.org/linux-fsdevel/CAHpGcMKHjic6L+J0qvMYNG9hVCcDO1hEpx4BiEk0ZCKDV39BmA@mail.gmail.com/

The other thread discussing this issue:

https://lore.kernel.org/linux-nfs/f74fae81-d1bc-1c0e-7b41-69502bd7c489@suse.de/

Thanks,
Miklos
