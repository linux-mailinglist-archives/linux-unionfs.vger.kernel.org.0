Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83B5412131
	for <lists+linux-unionfs@lfdr.de>; Thu,  2 May 2019 19:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfEBRoT (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 2 May 2019 13:44:19 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39650 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfEBRoT (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 2 May 2019 13:44:19 -0400
Received: by mail-oi1-f194.google.com with SMTP id w130so1968449oie.6
        for <linux-unionfs@vger.kernel.org>; Thu, 02 May 2019 10:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/BTpe1GCpx8WOaWkORwszZW4OhHJBOv4flBT0vFDKI=;
        b=qPWLV6Jni+nVwr77ktD35+bHfCVWUvaCfia8dd5rNaKtHaB429jHCzcB6TdMKtWyC0
         ODW5ZXH4AKncF+S2gODTMf+f5iJpkaqrb+zCdceM0FTYKlZf36JoaxvCwWusSqj+i1NU
         2byBgScbzYguVh0OBWLnhzSI/R287JRuWdzVLg+R/fwZaxa3rrQNTjqqKsi/hx0pPlkL
         ml2NUVzs2XTzPdDOusPVNPrefS6V+i2g0U0PehSFlULwvg4fXvykmoZAv2C5LVCmezqH
         X5wfSGIBnfyjmNbuZqNI42j/SxEUO2g2B0HsEpJ5+msmXf7lmd58jvUICdZKNMvn4rzH
         YILw==
X-Gm-Message-State: APjAAAXg1cBQPylKUP4dHtQt5HMJtxSvOToYHxQ8L4ALSpCrTkF2I5Yr
        B/8PX0QN4ry1pLq2hxOqRYnMmsRpUXVKB4SHdIVF/w==
X-Google-Smtp-Source: APXvYqzkCKVtwDFTAmTjZnr+9E8F6X9oBSJfpx707teMwX2ZIYfEr+1PfRcpNtXqB1Leic/fKOicG15VnaqrRwMWYU0=
X-Received: by 2002:aca:47c8:: with SMTP id u191mr1503973oia.72.1556819058630;
 Thu, 02 May 2019 10:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpeguwUtRWRGmNmimNp-FXzWqMCCQMb24iWPu0w_J0_rOnnw@mail.gmail.com>
 <20161205151933.GA17517@fieldses.org> <CAJfpegtpkavseTFLspaC7svbvHRq-0-7jvyh63+DK5iWHTGnaQ@mail.gmail.com>
 <20161205162559.GB17517@fieldses.org> <CAHpGcMKHjic6L+J0qvMYNG9hVCcDO1hEpx4BiEk0ZCKDV39BmA@mail.gmail.com>
 <266c571f-e4e2-7c61-5ee2-8ece0c2d06e9@web.de> <CAHpGcMKmtppfn7PVrGKEEtVphuLV=YQ2GDYKOqje4ZANhzSgDw@mail.gmail.com>
 <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com>
 <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com>
 <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com>
 <20161206185806.GC31197@fieldses.org> <87bm0l4nra.fsf@notabene.neil.brown.name>
 <CAOQ4uxjYEjqbLcVYoUaPzp-jqY_3tpPBhO7cE7kbq63XrPRQLQ@mail.gmail.com>
 <875zqt4igg.fsf@notabene.neil.brown.name> <8f3ba729-ed44-7bed-5ff8-b962547e5582@math.utexas.edu>
In-Reply-To: <8f3ba729-ed44-7bed-5ff8-b962547e5582@math.utexas.edu>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 2 May 2019 19:44:07 +0200
Message-ID: <CAHc6FU4czPQ8xxv5efvhkizU3obpV_05VEWYKydXDDDYcp8j=w@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
To:     "Goetz, Patrick G" <pgoetz@math.utexas.edu>
Cc:     NeilBrown <neilb@suse.com>, Amir Goldstein <amir73il@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Patrick Plagwitz <Patrick_Plagwitz@web.de>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, 2 May 2019 at 19:27, Goetz, Patrick G <pgoetz@math.utexas.edu> wrote:
> On 5/1/19 10:57 PM, NeilBrown wrote:
> > Support some day support for nfs4 acls were added to ext4 (not a totally
> > ridiculous suggestion).  We would then want NFS to allow it's ACLs to be
> > copied up.
>
> Is there some reason why there hasn't been a greater effort to add NFSv4
> ACL support to the mainstream linux filesystems?  I have to support a
> hybrid linux/windows environment and not having these ACLs on ext4 is a
> daily headache for me.

The patches for implementing that have been rejected over and over
again, and nobody is working on them anymore.

Andreas
