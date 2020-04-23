Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A586E1B5DEE
	for <lists+linux-unionfs@lfdr.de>; Thu, 23 Apr 2020 16:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgDWOgf (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 23 Apr 2020 10:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726060AbgDWOgf (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 23 Apr 2020 10:36:35 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BF9C08E934
        for <linux-unionfs@vger.kernel.org>; Thu, 23 Apr 2020 07:36:35 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id j20so4510672edj.0
        for <linux-unionfs@vger.kernel.org>; Thu, 23 Apr 2020 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q0Xt3e1XCVb+//36sqK4sr8mPAyvt9DXXNQwpqA1RbM=;
        b=lUsgHBjrnDsHOzmUNXeqQEixD0/z/JN5MMqUPd4uWwKbZECxnKYhoypiKg+OI1AC8+
         nsZR6jR9pEXBkmsLkAWbqgzVLrVxsbGUGm650NyC5Pm5eIhEpeMXdqVXWOrhgN4EyvPZ
         zF/hVjSHk8LvU6Vgqu8Fqy0jA6BBnMMy2fbNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q0Xt3e1XCVb+//36sqK4sr8mPAyvt9DXXNQwpqA1RbM=;
        b=m4vAf0HzQ522VcRVyUTyF6vKKFsPF9Vkn4CnutXShgdzbD4wjekGqVhHnvUWsNQaZ8
         Pt8IGCKsdtVdUOOVD98CbWSMOIbm2qS/HscovdyDelxXk4zjk4jfXlGjJtYLwdrCtmt7
         o1auWe4BAmCn/sUfl2yFAtNAkqzclKKzNR5vdBjlIJwmDPclCPpPzBlx5+RpjT4b2RBB
         Dqz2zOidaUjnVy8QP+bSSIRZLSwh/8LRjA8btCDwBTuLXPtwsaHvgZNGYdMkz6rHNStp
         MfGsQzKLPuKfn/TYBHMDp0O+9Fbl/Dudk2ItkesyHfsT2WX8NTrRDYg5hhLvGhGx+snV
         fSug==
X-Gm-Message-State: AGi0PuYiLpO2/tex1yMOCgTDOQfVpYftIj+skSH5Qenn/hrYhY63mFhi
        +n3HzTbYgdqraeAKFXMXMthDoGMLm2q9/IGuKj2R8Zf2EMo=
X-Google-Smtp-Source: APiQypKSfJl2hJ3neY85gE5dONUpKOWjT8PUeVK//Xs9fVYW5IOfh4ZCaMnZMV+on42HHSRq3CIwB2VP0VhPXcxBw0Q=
X-Received: by 2002:a50:bb07:: with SMTP id y7mr2898757ede.358.1587652594034;
 Thu, 23 Apr 2020 07:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <1587640015-117044-1-git-send-email-jefflexu@linux.alibaba.com>
In-Reply-To: <1587640015-117044-1-git-send-email-jefflexu@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 23 Apr 2020 16:36:22 +0200
Message-ID: <CAJfpegshdwRuivjp=in=XN2AwWCHPk5HJZyCffQSrpW3SNsECQ@mail.gmail.com>
Subject: Re: [PATCH v2] overlayfs: inherit SB_NOSEC flag from upperdir
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, Apr 23, 2020 at 1:06 PM Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
>
> Since the stacking of regular file operations [1], the overlayfs
> edition of write_iter() is called when writing regular files.
>
> Since then, xattr lookup is needed on every write since file_remove_privs()
> is called from ovl_write_iter(), which would become the performance
> bottleneck when writing small chunks of data. In my test case,
> file_remove_privs() would consume ~15% CPU when running fstime of
> unixbench (the workload is repeadly writing 1 KB to the same file) [2].
>
> Inherit the SB_NOSEC flag from upperdir.

Yes, I think this is safe if we assume no changes to the upper while
it is part of overlay; which is a documented assumption.   Once we
relax that no-change rule things become tricky, since it's difficult
to propagate the removal of S_NOSEC on upper to the overlay...

> Since then xattr lookup would be
> done only once on the first write. Unixbench fstime gets a ~20% performance
> gain with this patch.

I'll apply this, with an additional comment on the effect of changes to upper.

Thanks,
Miklos
