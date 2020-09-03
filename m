Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B824825C35A
	for <lists+linux-unionfs@lfdr.de>; Thu,  3 Sep 2020 16:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgICOts (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 3 Sep 2020 10:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41843 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729268AbgICOTD (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 3 Sep 2020 10:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599142735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T0B2Y+BN8BYQeEQOaIOAiTg3lA9vxxQDa2k6aCB+fy8=;
        b=dNEve+v78Zw461sgvIZ14XHSZGCyef1fJGLMR1Le6QEWs72RqzUVyS8ZC1tMCCgHux31R4
        KnresMb55fNmGdALbfZYNLR+RexCG42hpfph+9oPQVYaJqzxd2I36L+wzGKFZhOFMChqvW
        Mwdi9p2MkpvTIUMvaUClJKMhoLsPpGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-u39E_TJDNeyj8tk61cxJ6w-1; Thu, 03 Sep 2020 09:09:29 -0400
X-MC-Unique: u39E_TJDNeyj8tk61cxJ6w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F959805EE2;
        Thu,  3 Sep 2020 13:09:28 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-204.rdu2.redhat.com [10.10.115.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15AD27E400;
        Thu,  3 Sep 2020 13:09:27 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 70F792204D0; Thu,  3 Sep 2020 09:09:26 -0400 (EDT)
Date:   Thu, 3 Sep 2020 09:09:26 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Mauro Condarelli <mc5686@mclink.it>,
        Amir Goldstein <amir73il@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Mark Salyzyn <salyzyn@android.com>
Subject: Re: Frequent errors with OverlayFS on root
Message-ID: <20200903130926.GA9874@redhat.com>
References: <CAOQ4uxjk78aWc4rXd3_4Kr_Hy74AF4Yzk8Dur9VyadeyS33MGg@mail.gmail.com>
 <20200902132921.GA1263242@redhat.com>
 <7862cfc2-03e1-61b8-ae36-96ef5d28915e@mclink.it>
 <20200902202048.GD1263242@redhat.com>
 <8a5fb512-e430-40c1-2266-e90625385e62@mclink.it>
 <CAOQ4uxg9p2w-z9c+WzVjr5CO3xmf2gqK-VrhhUOcbA2uQJiseA@mail.gmail.com>
 <89bc9214-bb3c-49e9-16d1-c630b463c901@mclink.it>
 <CAOQ4uxjQW8YcagfLn+8Eh4NuQ-45R5HYbLdmNpZL=q4_k_vT3w@mail.gmail.com>
 <7b418869-b68d-fb34-af12-b70fd7877be5@mclink.it>
 <CAJfpegvFmHQmECkEq8Qffz-yaxPrKeabxftnYL8kExhhewyV1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvFmHQmECkEq8Qffz-yaxPrKeabxftnYL8kExhhewyV1Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, Sep 03, 2020 at 11:53:03AM +0200, Miklos Szeredi wrote:
> On Thu, Sep 3, 2020 at 11:24 AM Mauro Condarelli <mc5686@mclink.it> wrote:
> 
> > FYI: using OverlayFS this way and for this use-case was suggested
> > by SWUpdate maintainer (Stefano Babic) so I guess there are other
> > people relying on "correct" behavior around the world .
> 
> So my opinion is that this use case (modifying or even completely
> swapping out the lower layer while it is not mounted) should work
> perfectly fine with a "plain" configuration.
> 
> Doing this with redirect_dir, metacopy or index does sound somewhat
> scary and some of that obviously won't even work because of the broken
> origins.

Hi Miklos,

Shall we document that changing/swapping lower layers with existing
upper is not supported configuration with advanced features like
metacopy/redirect_dir/index.

This topic has come up now multiple times recently. It will be good
to make it very clear in documentation.

Thanks
Vivek

