Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0933654CD1B
	for <lists+linux-unionfs@lfdr.de>; Wed, 15 Jun 2022 17:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348775AbiFOPeD (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 15 Jun 2022 11:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347900AbiFOPdy (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 15 Jun 2022 11:33:54 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E082019D
        for <linux-unionfs@vger.kernel.org>; Wed, 15 Jun 2022 08:33:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id x6-20020a1c7c06000000b003972dfca96cso1332662wmc.4
        for <linux-unionfs@vger.kernel.org>; Wed, 15 Jun 2022 08:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J5eKPAN5lqKWqHRVMFEt8bECLi2YfU3n/Xvj8y2gEBE=;
        b=Zv2JhKlV+WgmpireahD92+ZSg2KnCdRZZvKLhjp5oxI5lNh/Plc3RXY+mQgK5+7Vg0
         YcEbwmKcYO+eUdZVm8cnx1XTn3jFZkr+/y958BJAt6RHw6tO4gb/qGpriKZF4237xYW8
         XdcUnlcVAybauV76RUaKKOU+9Jk1HAP8Ybq8jFsO4UP/QfChfQnRT6ZMjB1JSUkSG5A+
         eeKIxvMjnfgD/uvv36ColBnfjqbtL+d7YJ45Q6RgQZkCXiULCPAF4BJO7j+EvyygfMPL
         eLCZ6VWgFpV+KubW52X0faomk4hEuBQnOj14ASkrNV4X772O83FKpX8IgKteHTah4Jpx
         0t5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5eKPAN5lqKWqHRVMFEt8bECLi2YfU3n/Xvj8y2gEBE=;
        b=p/mqroSxTyeagJIq8RKiPEN/tBVMybGsX8ASSYW0aZsR5aBGa7Si9ntcFtgzN2SZGt
         OQD03XgivO1mbpR50laKRYZOXDKGrFyLsJmc58GsMc1ylg4zfg/qHbcafXbdGlYFPo7V
         eUhyZISTxVPy7r2AybFwmgjGgsVdQ5Ce1h1YZX7E6NvAAzBoOsDk6NNUc84bE2zUaMa+
         orKctBnEtmDf3G7tzLod+Y1BA+ScCmhjPoZHGZoi3ET63S2sRu2hZg9eg57as2vwxXun
         kXAf51dkliNL6vL5uvnwPE0vlfavu/f1n1octNGFxfIId2zWuyyyl2gU5v2AIM+fnVyP
         Bveg==
X-Gm-Message-State: AJIora8JatLorfo97C/j+dmEdrxbCpQvmfKJ8wmqK6ewHhbBM8eH/Z31
        4ynewpDwsPsMkjg5jLzEkopalmHqdIJoyAySDZUt
X-Google-Smtp-Source: AGRyM1tbSXhyojX0sdqJuy36Y8CiIJerDEBwNNO0en1/SGp4CFCRbzqu86TVD3k4/Lh2/5SBr3CWSXHz2TZ3Gh292cQ=
X-Received: by 2002:a05:600c:1d91:b0:39c:544b:abdd with SMTP id
 p17-20020a05600c1d9100b0039c544babddmr20003wms.70.1655307229181; Wed, 15 Jun
 2022 08:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220608150942.776446-1-fred@cloudflare.com> <87tu8oze94.fsf@email.froward.int.ebiederm.org>
 <e1b62234-9b8a-e7c2-2946-5ef9f6f23a08@cloudflare.com> <87y1xzyhub.fsf@email.froward.int.ebiederm.org>
 <859cb593-9e96-5846-2191-6613677b07c5@cloudflare.com> <87o7yvxl4x.fsf@email.froward.int.ebiederm.org>
 <9ed91f15-420c-3db6-8b3b-85438b02bf97@cloudflare.com> <20220615103031.qkzae4xr34wysj4b@wittgenstein>
 <CAHC9VhR8yPHZb2sCu4JGgXOSs7rudm=9opB+-LsG6_Lta9466A@mail.gmail.com> <CALrw=nGZtrNYn+CV+Q_w-2=Va_9m3C8PDvvPtd01d0tS=2NMWQ@mail.gmail.com>
In-Reply-To: <CALrw=nGZtrNYn+CV+Q_w-2=Va_9m3C8PDvvPtd01d0tS=2NMWQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 15 Jun 2022 11:33:38 -0400
Message-ID: <CAHC9VhRSzXeAZmBdNSAFEh=6XR57ecO7Ov+6BV9b0xVN1YR_Qw@mail.gmail.com>
Subject: Re: [PATCH v3] cred: Propagate security_prepare_creds() error code
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederick Lawler <fred@cloudflare.com>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, serge@hallyn.com, amir73il@gmail.com,
        kernel-team <kernel-team@cloudflare.com>,
        Jeff Moyer <jmoyer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Jun 15, 2022 at 11:06 AM Ignat Korchagin <ignat@cloudflare.com> wrote:
> On Wed, Jun 15, 2022 at 3:14 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Jun 15, 2022 at 6:30 AM Christian Brauner <brauner@kernel.org> wrote:

...

> > > Fwiw, from this commit it wasn't very clear what you wanted to achieve
> > > with this. It might be worth considering adding a new security hook for
> > > this. Within msft it recently came up SELinux might have an interest in
> > > something like this as well.
> >
> > Just to clarify things a bit, I believe SELinux would have an interest
> > in a LSM hook capable of implementing an access control point for user
> > namespaces regardless of Microsoft's current needs.  I suspect due to
> > the security relevant nature of user namespaces most other LSMs would
> > be interested as well; it seems like a well crafted hook would be
> > welcome by most folks I think.
>
> Just to get the full picture: is there actually a good reason not to
> make this hook support this scenario? I understand it was not
> originally intended for this, but it is well positioned in the code,
> covers multiple subsystems (not only user namespaces), doesn't require
> changing the LSM interface and it already does the job - just the
> kernel internals need to respect the error code better. What bad
> things can happen if we extend its use case to not only allocate
> resources in LSMs?

My concern is that the security_prepare_creds() hook, while only
called from two different functions, ends up being called for a
variety of different uses (look at the prepare_creds() and
perpare_kernel_cred() callers) and I think it would be a challenge to
identify the proper calling context in the LSM hook implementation
given the current hook parameters.  One might be able to modify the
hook to pass the necessary information, but I don't think that would
be any cleaner than adding a userns specific hook.  I'm also guessing
that the modified security_prepare_creds() hook implementations would
also be more likely to encounter future maintenance issues as
overriding credentials in the kernel seems only to be increasing, and
each future caller would risk using the modified hook wrong by passing
the wrong context and triggering the wrong behavior in the LSM.

-- 
paul-moore.com
