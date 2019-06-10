Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F05BA3BBF6
	for <lists+linux-unionfs@lfdr.de>; Mon, 10 Jun 2019 20:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbfFJSpy (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 10 Jun 2019 14:45:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387643AbfFJSpy (ORCPT <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 10 Jun 2019 14:45:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 744482F8BCE;
        Mon, 10 Jun 2019 18:45:54 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55AB4608CD;
        Mon, 10 Jun 2019 18:45:54 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E47A8223AE7; Mon, 10 Jun 2019 14:45:53 -0400 (EDT)
Date:   Mon, 10 Jun 2019 14:45:53 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Matt Coffin <mcoffin13@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH v2] overlay: allow config override of metacopy/redirect
 defaults
Message-ID: <20190610184553.GE25290@redhat.com>
References: <20190607010431.11868-1-mcoffin13@gmail.com>
 <20190607205105.21858-1-mcoffin13@gmail.com>
 <CAOQ4uximPqsNivkqD36LdNfT4g41v2rtDm+OB6t2z40dpWs_og@mail.gmail.com>
 <f5b0bddd-678b-bdd9-6fc7-cc9e5b3211e5@gmail.com>
 <CAOQ4uxjQQcrcpxhtu3kAJvGaK+xd5TfNB=7_UnNciGj990DN6Q@mail.gmail.com>
 <CAJfpegvy-Vfc6AEP7+=VfUtfL4izY8AzgoUdvqP4PHnLDEQhNg@mail.gmail.com>
 <20190610184043.GD25290@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610184043.GD25290@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 10 Jun 2019 18:45:54 +0000 (UTC)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Jun 10, 2019 at 02:40:43PM -0400, Vivek Goyal wrote:
> On Sun, Jun 09, 2019 at 09:14:38PM +0200, Miklos Szeredi wrote:
> > On Sat, Jun 8, 2019 at 8:47 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > 
> > > And then every time that a feature needs to be turned off for some reason
> > > that also needs to be taken into account.
> > > IOW, I advise against diving into this mess. You have been warned ;-)
> > 
> > Also a much more productive direction would be to optimize building
> > the docker image based on the specific format used by overlayfs for
> > readirect_dir/metacopy.
> > 
> > To me it seems like a no-brainer, but I don't know much about docker, so...
> 
> [ cc Daniel Walsh]
> 
> Hi Miklos,
> 
> Can you elaborate a bit more on what docker/container-storoage and do
> here to expedite image generation with redirect_dir/metacopy enabled.
> 
> They can't pack these xattrs in image because image will not be portable.
> It will be overlayfs specific and can't be made to work on target without
> overlayfs.

Are you referring to apps being able to traverse lower layers and do
the redirect_dir and metacopy resoltion as kernel does. To me that process
is not trivial. Having a library might help with adoption though.

Vivek
