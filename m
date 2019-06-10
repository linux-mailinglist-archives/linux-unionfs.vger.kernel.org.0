Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B824F3BBD8
	for <lists+linux-unionfs@lfdr.de>; Mon, 10 Jun 2019 20:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfFJSa5 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 10 Jun 2019 14:30:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfFJSa4 (ORCPT <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 10 Jun 2019 14:30:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6AB0D307D965;
        Mon, 10 Jun 2019 18:30:56 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03A545DA9B;
        Mon, 10 Jun 2019 18:30:54 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 93ADF223AE7; Mon, 10 Jun 2019 14:30:53 -0400 (EDT)
Date:   Mon, 10 Jun 2019 14:30:53 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Matt Coffin <mcoffin13@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v2] overlay: allow config override of metacopy/redirect
 defaults
Message-ID: <20190610183053.GA29869@redhat.com>
References: <20190607010431.11868-1-mcoffin13@gmail.com>
 <20190607205105.21858-1-mcoffin13@gmail.com>
 <CAOQ4uximPqsNivkqD36LdNfT4g41v2rtDm+OB6t2z40dpWs_og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uximPqsNivkqD36LdNfT4g41v2rtDm+OB6t2z40dpWs_og@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 10 Jun 2019 18:30:56 +0000 (UTC)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Sat, Jun 08, 2019 at 12:04:54PM +0300, Amir Goldstein wrote:
> Hi Matt,
> 
> Thank you for trying to address this, but I see problems both in Why and
> How you did it.
> 
> On Fri, Jun 7, 2019 at 11:51 PM Matt Coffin <mcoffin13@gmail.com> wrote:
> >
> > [Why]
> > Currently, if the redirect_dir option is set as a kernel or module
> > parameter, then even if metacopy is only enabled config, then both
> > metacopy and redirect_dir will be enabled when one creates a mount
> > point. This is not desirable because /sys/module/overlay/parameters will
> > still report that redirect_dir is not enabled
> 
> /sys/module/overlay/parameters reports that redirect_dir is not enabled
> *by default* not per mount.
> 
> > and there will be no redirect_dir=on line in the mount options in /proc/mounts.
> 
> That is a bug. This code:
> /* Automatically enable redirect otherwise. */
> config->redirect_follow = config->redirect_dir = true;
> 
> Needs to update of config->redirect_mode.

Hi Amir,

It took me a while to understand what's the problem. So IIUC, issue is
that kernel has enabled redirect_dir by default. But it was disabled
using module parameter. But it was enabled again as a side affect because
metacopy=on was passed as mount option. And /proc/self/mountinfo does
not show redirect_dir=on and hence the confusion.

IIRC, once you mentioned that we only show those options which needs
to be specified if same mount has to be reproduced on different machine
with same kernel/module options. If yes, then setting
config->redirect_dir=on is not needed because passing metacopy=on will
ensure that.

To me problem is that sometimes I want to know what options are enabled
on a particular mount. And in this case user can't figure that out by
parsing /proc/self/mountinfo.

And that's the reason apps create a overlay mount point, do bunch of
file operations and analyze xattrs to figure out what options are enabled.

It will be nice if there was an interface to query all that. And if there
is one, then this should go in there.

Otherwise given the current interface, it does not sound like a bug to
me. Current interface does not tell you what all features are enabled.
It only tells you what you need to provide as mount option to create
similar mount point.

Thanks
Vivek
