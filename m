Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8526E1D042F
	for <lists+linux-unionfs@lfdr.de>; Wed, 13 May 2020 03:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbgEMBKd (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 12 May 2020 21:10:33 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:14955 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728131AbgEMBKc (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 12 May 2020 21:10:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TyNoN.S_1589332219;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0TyNoN.S_1589332219)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 May 2020 09:10:20 +0800
Date:   Wed, 13 May 2020 09:10:19 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Eryu Guan <guan@eryu.me>, Chengguang Xu <cgxu519@mykernel.net>,
        miklos <miklos@szeredi.hu>, fstests <fstests@vger.kernel.org>,
        linux-unionfs <linux-unionfs@vger.kernel.org>
Subject: Re: [PATCH v4] overlay: test for whiteout inode sharing
Message-ID: <20200513011019.GY47669@e18g06458.et15sqa>
References: <20200506101528.27359-1-cgxu519@mykernel.net>
 <20200510155037.GB9345@desktop>
 <172015c8691.108177c8110122.924760245390345571@mykernel.net>
 <20200512162532.GD9345@desktop>
 <CAOQ4uxiFPrMWrhqjPo3PcgKFiKwSKfh7p+f5hM5fZYKr51HEWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiFPrMWrhqjPo3PcgKFiKwSKfh7p+f5hM5fZYKr51HEWA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, May 12, 2020 at 07:56:35PM +0300, Amir Goldstein wrote:
> > >  > I see no feature detection logic, so test just fails on old kernels
> > >  > without this feature? I tried with v5.7-r4 kernel, test fails because
> > >  > each whiteout file has only one hardlink.
> > >
> > > That's true.
> >
> > I'd like to see it _notrun on old kernels where the feature is not
> > available. But that seems hard to do.. Do you have any better ideas?
> >
> 
> I've got a few.
> 1. LTP has the concept of require minimum kernel version.
>     This would mean that functionality will be not be tested if feature
>     is backported to old kernels.
> 2. We could add to overlayfs advertising of supported features, like
>      /sys/fs/ext4/features/, but it already does "advertise" the configurable
>      features at  /sys/module/overlay/parameters/, and we were already
>      asking the question during patch review:
>         /* Is there a reason anyone would want not to share whiteouts? */
>         ofs->share_whiteout = true;
>      and we left the answer to "later" time.
> 
> So a simple solution would be to add the module parameter (without adding
> a mount option), because:
> - It doesn't hurt (?)
> - Somebody may end up using it, for some reason we did not think of
> - We can use it in test to require the feature

Yeah, I think that works. And I see that ext4 and btrfs both have a
/sys/fs/<fs>/features directory and list supported features there, is
this something overlay could do? Or is this basically the same thing as
what you proposed?

Thanks,
Eryu

> 
> The one non-trivial thing that this will require is to add Documentation
> of the module parameter in the section about Whiteouts and opaque directories.
> 
> Thanks,
> Amir.
