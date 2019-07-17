Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8490E6C24E
	for <lists+linux-unionfs@lfdr.de>; Wed, 17 Jul 2019 22:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfGQUtA (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 17 Jul 2019 16:49:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43819 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfGQUtA (ORCPT <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 17 Jul 2019 16:49:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42D63883BA;
        Wed, 17 Jul 2019 20:49:00 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2574419D7D;
        Wed, 17 Jul 2019 20:49:00 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id B2D6E2238A7; Wed, 17 Jul 2019 16:48:59 -0400 (EDT)
Date:   Wed, 17 Jul 2019 16:48:59 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: [PATCH] ovl: fix regression caused by overlapping layers
 detection
Message-ID: <20190717204859.GB31226@redhat.com>
References: <20190712122434.14809-1-amir73il@gmail.com>
 <20190717184031.GA31226@redhat.com>
 <CAOQ4uxivNhDT3XS3Se8hNe54wRJM4KfSu-jNig-CMqU726jweg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxivNhDT3XS3Se8hNe54wRJM4KfSu-jNig-CMqU726jweg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 17 Jul 2019 20:49:00 +0000 (UTC)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Jul 17, 2019 at 11:22:00PM +0300, Amir Goldstein wrote:
> On Wed, Jul 17, 2019 at 9:40 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Fri, Jul 12, 2019 at 03:24:34PM +0300, Amir Goldstein wrote:
> > > Once upon a time, commit 2cac0c00a6cd ("ovl: get exclusive ownership on
> > > upper/work dirs") in v4.13 added some sanity checks on overlayfs layers.
> > > This change caused a docker regression. The root cause was mount leaks
> > > by docker, which as far as I know, still exist.
> > >
> > > To mitigate the regression, commit 85fdee1eef1a ("ovl: fix regression
> > > caused by exclusive upper/work dir protection") in v4.14 turned the
> > > mount errors into warnings for the default index=off configuration.
> > >
> > > Recently, commit 146d62e5a586 ("ovl: detect overlapping layers") in
> > > v5.2, re-introduced exclusive upper/work dir checks regardless of
> > > index=off configuration.
> > >
> > > This changes the status quo and mount leak related bug reports have
> > > started to re-surface. Restore the status quo to fix the regressions.
> > > To clarify, index=off does NOT relax overlapping layers check for this
> > > ovelayfs mount. index=off only relaxes exclusive upper/work dir checks
> > > with another overlayfs mount.
> > >
> > > To cover the part of overlapping layers detection that used the
> > > exclusive upper/work dir checks to detect overlap with self upper/work
> > > dir, add a trap also on the work base dir.
> >
> > Adding a trap for work base dir, seems as if should be a separate patch.
> > IIUC, its nice to have but is not must for stable backport.
> 
> Not accurate. The two changes are dependent.
> When removing the in-use check for lowerdir, it regresses the case
> of lowerdir=work,upperdir=upper,workdir=work
> The trap on work base dir is needed to not regress this case.
> 
> The only reason stable tree picked up "detect overlap layers"
> was that it stops syzbot from mutating those overlapping layers repros,
> so we don't want to go back to that state.

Aha.. Thanks for the explanation. For a while I was thinking that how
trap is related in above example because we check all ancestors of
a layer root for traps (and not layer root itself). And then I tried above
example, and it pointed ovl_setup_trap() returning error as it already
found a trap. 

Makes sense.

Thanks
Vivek
