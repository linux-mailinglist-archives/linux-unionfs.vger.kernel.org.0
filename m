Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD656378A
	for <lists+linux-unionfs@lfdr.de>; Tue,  9 Jul 2019 16:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfGIONL (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 9 Jul 2019 10:13:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfGIONL (ORCPT <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 9 Jul 2019 10:13:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE2B6307D88D;
        Tue,  9 Jul 2019 14:13:02 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5DC1A8454;
        Tue,  9 Jul 2019 14:13:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3FE48220937; Tue,  9 Jul 2019 10:13:02 -0400 (EDT)
Date:   Tue, 9 Jul 2019 10:13:02 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: [RFC] unionmount metacopy tests
Message-ID: <20190709141302.GA19084@redhat.com>
References: <CAOQ4uxhi63LPKdmkEJjnTEgy0VaX0qXML2Uz_258_B2iZcqd3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhi63LPKdmkEJjnTEgy0VaX0qXML2Uz_258_B2iZcqd3w@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 09 Jul 2019 14:13:11 +0000 (UTC)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, Jul 04, 2019 at 06:11:25PM +0300, Amir Goldstein wrote:
> Hi Vivek,
> 
> I was working on extending snapshot validation tests and got
> this as a by-product:
> 
> https://github.com/amir73il/unionmount-testsuite/commits/metacopy
> 
> ca566c3 Check that data was not copied up with metacopy=on
> 140d99c Reset dentry copy_up state on upper layer rotate
> 960a5ce Check that files were copied up as expected
> 1bfcc7d Record meta copy_up vs. data copy_up
> c3db453 Fix instantiation of hardlinked dentry
> 2104e51 Simplify initialization of __upper
> 1fc2eec Fix ./run --ov --verify --recycle
> 
> Would you be interested to review these changes,
> so I would merge them to master?

Hi Amir,

Glad to see more tests for metacopy feature. I will have a look at
these.

> 
> Would you or someone else be interested in running those tests
> regularly on pre release kernel?

I generally don't run tests regularly on latest kernel. Whenever I 
am fixing something, I run tests to make sure I have not broken
anything.

So I can't say I will run the tests regularly, but once in a while
I should be able to run it.


> 
> If anyone is running unionmount-testsuite on regular basis
> I would be happy to know which configurations are being tested,
> because the test matrix grew considerably since I took over the project -
> both Overlayfs config options and the testsuite config options.

For me, I think I am most interested in configuration used by
container runtimes (docker/podman). Docker seems to turn off
redirects as of now. podman is turning on metacopy (hence redirect)
by default now to see how do things go.

So for me (redirect=on/off and metacopy=on/off) are important
configurations as of now. Havind said that, I think I should talk
to container folks and encourage them to use "index" and "xino"
as well to be more posix like fs.

I think container folks still have not modified their code to
be able to generate an image layer properly if redirect is
enabled. Last time Miklos had some good ideas. I will poke them
again. It will be nice if they can use redirect (instead of
disabling it) and be able to generate image layer efficiently. 

Thanks
Vivek
