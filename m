Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1F7E8DB6
	for <lists+linux-unionfs@lfdr.de>; Tue, 29 Oct 2019 18:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390791AbfJ2RKQ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 29 Oct 2019 13:10:16 -0400
Received: from mail.hallyn.com ([178.63.66.53]:37718 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbfJ2RKQ (ORCPT <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 29 Oct 2019 13:10:16 -0400
X-Greylist: delayed 517 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Oct 2019 13:10:15 EDT
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 8C8129AD; Tue, 29 Oct 2019 12:01:37 -0500 (CDT)
Date:   Tue, 29 Oct 2019 12:01:37 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] allow unprivileged overlay mounts
Message-ID: <20191029170137.GA21633@mail.hallyn.com>
References: <20191025112917.22518-1-mszeredi@redhat.com>
 <CAJfpegv1SA7b45_2g-GFYrc7ZsOmcQ2qv602n=85L4RknkOvKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv1SA7b45_2g-GFYrc7ZsOmcQ2qv602n=85L4RknkOvKQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Fri, Oct 25, 2019 at 01:35:20PM +0200, Miklos Szeredi wrote:
> On Fri, Oct 25, 2019 at 1:30 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
> >
> > Hi Eric,
> >
> > Can you please have a look at this patchset?
> >
> > The most interesting one is the last oneliner adding FS_USERNS_MOUNT;
> > whether I'm correct in stating that this isn't going to introduce any
> > holes, or not...
> 
> Forgot the git tree:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#ovl-unpriv
> 
> Thanks,
> Miklos

I've looked through it, seemed sensible to me.

-serge
