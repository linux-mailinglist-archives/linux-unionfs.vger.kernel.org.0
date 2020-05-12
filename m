Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC461CF1A1
	for <lists+linux-unionfs@lfdr.de>; Tue, 12 May 2020 11:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbgELJa6 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 12 May 2020 05:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726193AbgELJa5 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 12 May 2020 05:30:57 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCA7C061A0C
        for <linux-unionfs@vger.kernel.org>; Tue, 12 May 2020 02:30:56 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id s3so10430907eji.6
        for <linux-unionfs@vger.kernel.org>; Tue, 12 May 2020 02:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7DRU6YPQdNe34vZ3ypovyXSKXraDY9YNCbFCjsK8WL4=;
        b=eTzfJEXd/zdaa+flumlrEsVDwebay7nkWlkA4jYbLl+qijwq/gU+4PMO45tTA1Ar6l
         xFECI8R6Ym2riHmoTAKo+XTBktQJA0YhPzBaU3RTcacwWpYmsaFPRIaD7fMSRUGHcx71
         gubdM6PjLg1/+1UUo5U4APewGv+OjjKT49x5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7DRU6YPQdNe34vZ3ypovyXSKXraDY9YNCbFCjsK8WL4=;
        b=ATkPN1dopTyT8P1zvorlLfZa1Nes9qJFGrwLi3EDYTKQN0uO/eKGxLUl9wpSwYILOy
         olpGSJeoN6Fry3Yq4TA+P92YUctWakhhnC8A98chMIEyMwVMl3Xeh6bdCY8zOHNTCrLc
         xgw9Ch+qGJvZwmpedGOJcdZI6hjaktKt70Z4EY1BS6iAkJJCPjloyH5mqM51sS6Biyfc
         R62HlbCbw0z2V7mpMVGIwTYIEJlSM4JnJEiEk3n93xTOZbxYIPn9Y2USO6a0ABNFmDkT
         hzzzpkKVRoLAuOIOqdm4uDbfmdUaizFEZJRu268zPbo5aFO3D4itC6tgrnCB2pwqWdFb
         Utqw==
X-Gm-Message-State: AGi0PuarWBfsrIkSlsoGWXAGJ+hNLv2XCMPXE/svlXECg5cSE6YXzQL+
        RW2IFGD7J7wUV3APJwlfr4bKKSufd7AnrO1LKs2qxQ==
X-Google-Smtp-Source: APiQypI4N5wbqrK4kWr3aIZ8ZXXInlBO7Sp/HPEsbwPF9g5O7bMLZsKdWo7n2LLtHQI7U4l9bDEJJ+hhIuIBl0uyAqc=
X-Received: by 2002:a17:906:1a06:: with SMTP id i6mr16603759ejf.90.1589275855027;
 Tue, 12 May 2020 02:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200512071313.4525-1-cgxu519@mykernel.net> <CAOQ4uxiA_Er_VA=m8ORovGyvHDFuGBS4Ss_ef5un5VJbrev3jw@mail.gmail.com>
 <20200512083217.GC13131@miu.piliscsaba.redhat.com> <CAOQ4uxgfPVvFh3cQNoKzL6Y3k1HWF9hWXXutuDCON0dCzmapwA@mail.gmail.com>
In-Reply-To: <CAOQ4uxgfPVvFh3cQNoKzL6Y3k1HWF9hWXXutuDCON0dCzmapwA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 12 May 2020 11:30:43 +0200
Message-ID: <CAJfpegsUVirkfovV+FJPpBWW0dWcnX_HWP-YoYf8vs=-kNjmgg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] ovl: suppress negative dentry in lookup
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Chengguang Xu <cgxu519@mykernel.net>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, May 12, 2020 at 10:55 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, May 12, 2020 at 11:32 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Tue, May 12, 2020 at 10:50:31AM +0300, Amir Goldstein wrote:

> > diff --git a/include/linux/namei.h b/include/linux/namei.h
> > index a4bb992623c4..4896eeeeea46 100644
> > --- a/include/linux/namei.h
> > +++ b/include/linux/namei.h
> > @@ -49,6 +49,8 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
> >  /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
> >  #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
> >
> > +#define LOOKUP_NO_NEGATIVE     0x200000 /* Hint: don't cache negative */
> > +
>
> The language lawyers will call this double negative, but I do
> prefer this over LOOKUP_POSITIVE :-)

Maybe LOOKUP_NOCACHE_NEGATIVE...

And yeah, LOOKUP_POSITIVE and LOOKUP_CACHE_POSITIVE are sort of
meaningless, since we cache everything by default.

Thanks,
Miklos
