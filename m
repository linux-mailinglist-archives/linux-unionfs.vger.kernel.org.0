Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5428011AC6
	for <lists+linux-unionfs@lfdr.de>; Thu,  2 May 2019 16:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfEBOFD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-unionfs@lfdr.de>); Thu, 2 May 2019 10:05:03 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44785 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfEBOFD (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 2 May 2019 10:05:03 -0400
Received: by mail-oi1-f193.google.com with SMTP id t184so1688097oie.11
        for <linux-unionfs@vger.kernel.org>; Thu, 02 May 2019 07:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4IqJbBFrVtTZ0oqzJ67Gm9A7iC2geeoklI44WKE5eEI=;
        b=j21ytCMkhXaO34G4KeuXtdDeduQw/vrAAttGDOtUhYtPxiVDZ5nw9reDrveTf8K3MV
         Ko+n/ybOZwlSPSvCG4v3JNiNVt0Zglmno8nzKy2magntrRdf7xckm9dpsx174uPMxfmR
         xixSC/pqqMEcLiPv1DiJX71MMzoWSrPq/fqkJuD9M5E6S0AY962YFLiV51m5jRMK/Gtm
         368btw0VapAYEo/NGEHl9Op10WFNlJP0KXWCbp4lDCH6XI1QuSmv4hfQHIeZGU0KNaBS
         kgvcsXhPxHymW4/1em9tR84A+CLmCBq5qPJJh4ymuq1+g0x6P0hnWYAkQzbTD91yF6fT
         VCEA==
X-Gm-Message-State: APjAAAUY06H22iBq/2IYhNEW35cEMkeh+0u7xHH/jy5yWBIU5vwyl2yZ
        2r9HbK7wZ+JqiJuDuHgC8axVY01RA5/YujdnbEvfjw==
X-Google-Smtp-Source: APXvYqxQaPoecIhQ0ywakL0+8rFGAnEtV+06xebpZjZ4MXPOOp6535GBw75TR32zAWw/jHJ5jS5EoUX8/OA/7dCk4P0=
X-Received: by 2002:aca:f086:: with SMTP id o128mr2371553oih.101.1556805901943;
 Thu, 02 May 2019 07:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpeguwUtRWRGmNmimNp-FXzWqMCCQMb24iWPu0w_J0_rOnnw@mail.gmail.com>
 <20161205151933.GA17517@fieldses.org> <CAJfpegtpkavseTFLspaC7svbvHRq-0-7jvyh63+DK5iWHTGnaQ@mail.gmail.com>
 <20161205162559.GB17517@fieldses.org> <CAHpGcMKHjic6L+J0qvMYNG9hVCcDO1hEpx4BiEk0ZCKDV39BmA@mail.gmail.com>
 <266c571f-e4e2-7c61-5ee2-8ece0c2d06e9@web.de> <CAHpGcMKmtppfn7PVrGKEEtVphuLV=YQ2GDYKOqje4ZANhzSgDw@mail.gmail.com>
 <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com>
 <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com>
 <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com>
 <20161206185806.GC31197@fieldses.org> <87bm0l4nra.fsf@notabene.neil.brown.name>
 <CAOQ4uxjYEjqbLcVYoUaPzp-jqY_3tpPBhO7cE7kbq63XrPRQLQ@mail.gmail.com> <875zqt4igg.fsf@notabene.neil.brown.name>
In-Reply-To: <875zqt4igg.fsf@notabene.neil.brown.name>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 2 May 2019 16:04:50 +0200
Message-ID: <CAHc6FU52OCCGUnHXOCFTv1diP_5i4yZvF6fAth9=aynwS+twQg@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
To:     NeilBrown <neilb@suse.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Patrick Plagwitz <Patrick_Plagwitz@web.de>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, 2 May 2019 at 05:57, NeilBrown <neilb@suse.com> wrote:
> On Wed, May 01 2019, Amir Goldstein wrote:
> > On Wed, May 1, 2019 at 10:03 PM NeilBrown <neilb@suse.com> wrote:
> >> On Tue, Dec 06 2016, J. Bruce Fields wrote:
> >> > On Tue, Dec 06, 2016 at 02:18:31PM +0100, Andreas Gruenbacher wrote:
> >> >> On Tue, Dec 6, 2016 at 11:08 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >> >> > On Tue, Dec 6, 2016 at 12:24 AM, Andreas Grünbacher
> >> >> > <andreas.gruenbacher@gmail.com> wrote:
> >> >> >> 2016-12-06 0:19 GMT+01:00 Andreas Grünbacher <andreas.gruenbacher@gmail.com>:
> >> >> >
> >> >> >>> It's not hard to come up with a heuristic that determines if a
> >> >> >>> system.nfs4_acl value is equivalent to a file mode, and to ignore the
> >> >> >>> attribute in that case. (The file mode is transmitted in its own
> >> >> >>> attribute already, so actually converting .) That way, overlayfs could
> >> >> >>> still fail copying up files that have an actual ACL. It's still an
> >> >> >>> ugly hack ...
> >> >> >>
> >> >> >> Actually, that kind of heuristic would make sense in the NFS client
> >> >> >> which could then hide the "system.nfs4_acl" attribute.

I still think the nfs client could make this problem mostly go away by
not exposing "system.nfs4_acl" xattrs when the acl is equivalent to
the file mode. The richacl patches contain a workable abgorithm for
that. The problem would remain for files that have an actual NFS4 ACL,
which just cannot be mapped to a file mode or to POSIX ACLs in the
general case, as well as for files that have a POSIX ACL. Mapping NFS4
ACL that used to be a POSIX ACL back to POSIX ACLs could be achieved
in many cases as well, but the code would be quite messy. A better way
seems to be to using a filesystem that doesn't support POSIX ACLs in
the first place. Unfortunately, xfs doesn't allow turning off POSIX
ACLs, for example.

Andreas

> >> >> > Even simpler would be if knfsd didn't send the attribute if not
> >> >> > necessary.  Looks like there's code actively creating the nfs4_acl on
> >> >> > the wire even if the filesystem had none:
> >> >> >
> >> >> >     pacl = get_acl(inode, ACL_TYPE_ACCESS);
> >> >> >     if (!pacl)
> >> >> >         pacl = posix_acl_from_mode(inode->i_mode, GFP_KERNEL);
> >> >> >
> >> >> > What's the point?
> >> >>
> >> >> That's how the protocol is specified.
> >> >
> >> > Yep, even if we could make that change to nfsd it wouldn't help the
> >> > client with the large number of other servers that are out there
> >> > (including older knfsd's).
> >> >
> >> > --b.
> >> >
> >> >> (I'm not saying that that's very helpful.)
> >> >>
> >> >> Andreas
> >>
> >> Hi everyone.....
> >>  I have a customer facing this problem, and so stumbled onto the email
> >>  thread.
> >>  Unfortunately it didn't resolve anything.  Maybe I can help kick things
> >>  along???
> >>
> >>  The core problem here is that NFSv4 and ext4 use different and largely
> >>  incompatible ACL implementations.  There is no way to accurately
> >>  translate from one to the other in general (common specific examples
> >>  can be converted).
> >>
> >>  This means that either:
> >>    1/ overlayfs cannot use ext4 for upper and NFS for lower (or vice
> >>       versa) or
> >>    2/ overlayfs need to accept that sometimes it cannot copy ACLs, and
> >>       that is OK.
> >>
> >>  Silently not copying the ACLs is probably not a good idea as it might
> >>  result in inappropriate permissions being given away.
> >
> > For example? permissions given away to do what?
> > Note that ovl_permission() only check permissions of *mounter*
> > to read the lower NFS file and ovl_open()/ovl_read_iter() access
> > the lower file with *mounter* credentials.
> >
> > I might be wrong, but seems to me that once admin mounted
> > overlayfs with lower NFS, NFS ACLs are not being enforced at all
> > even before copy up.
>
> I guess it is just as well that copy-up fails then - if the lower-level
> permission check is being ignored.
>
> >
> >> So if the
> >>  sysadmin wants this (and some clearly do), they need a way to
> >>  explicitly say "I accept the risk".  If only standard Unix permissions
> >>  are used, there is no risk, so this seems reasonable.
> >>
> >>  So I would like to propose a new option for overlayfs
> >>     nocopyupacl:   when overlayfs is copying a file (or directory etc)
> >>         from the lower filesystem to the upper filesystem, it does not
> >>         copy extended attributes with the "system." prefix.  These are
> >>         used for storing ACL information and this is sometimes not
> >>         compatible between different filesystem types (e.g. ext4 and
> >>         NFSv4).  Standard Unix ownership permission flags (rwx) *are*
> >>         copied so this option does not risk giving away inappropriate
> >>         permissions unless the lowerfs uses unusual ACLs.
> >>
> >>
> >
> > I am wondering if it would make more sense for nfs to register a
> > security_inode_copy_up_xattr() hook.
> > That is the mechanism that prevents copying up other security.*
> > xattrs?
>
> No, I don't think that would make sense.
> Support some day support for nfs4 acls were added to ext4 (not a totally
> ridiculous suggestion).  We would then want NFS to allow it's ACLs to be
> copied up.
>
> Thanks,
> NeilBrown
>
>
> >
> > Thanks,
> > Amir.
