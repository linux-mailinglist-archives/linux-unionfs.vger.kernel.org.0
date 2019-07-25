Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 576387539C
	for <lists+linux-unionfs@lfdr.de>; Thu, 25 Jul 2019 18:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389374AbfGYQMg (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 25 Jul 2019 12:12:36 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43914 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389184AbfGYQMg (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 25 Jul 2019 12:12:36 -0400
Received: by mail-yb1-f196.google.com with SMTP id y123so15634538yby.10
        for <linux-unionfs@vger.kernel.org>; Thu, 25 Jul 2019 09:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBnHGF6HXMOX/5LSl7dC8ezm+mGlHqv8X21lq6WD2lA=;
        b=cMn/alnHpYV3rRHMCUFoZ+KMA+dHLfGCw2RGJa1wzNLmBU6LxQW+8dq/K/Q+ADw2NM
         T1Es/yuc1dzJWbvUV2y1WBl3KNjr80n0nGRl9uGoLUX6mHvRleRP7ST2QWu3wbigvneu
         sYWnmg47HJx2818Nq5DihM1V0xA+e1e08Er8Bo/5Lv4x0R+dEfHjH6PxswUSWsfpXmTG
         0PDpAQqzANdCVcyG54F+5yHD6KBPS2Qvfu/AjuuyxCEZEE6kegXqQZAdYNfZnwhRIJA0
         cCKNbOBTQkGr1ffkQb91octpnWXWkcWvPjABNZKS2jP3azsRX3dnTjXwr9fgip9VKw2G
         uiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBnHGF6HXMOX/5LSl7dC8ezm+mGlHqv8X21lq6WD2lA=;
        b=qxYpZK6CZtS6xjmax7PpdDdVxvTQ1DM/4FiQCbnQLC8o3aMs8OsxCA/t67aKFghXmF
         bywSm6CMRgTYxxnGFg/4je0erNBUrYN80cCXnUxaDlL08JjvLuksAzDBxQcVVf9PRJsV
         6Qn4MS6J41tklQf7ID6ecG8MdXDRebbb788esAE7Z78ss1Ra3ILiaVEZX+J8krf2tKsE
         zbsG3DbgkHQVmUfodLnBW0RZtIyryQg2yJEyihHRuqsVAWy70HScqhp4L6YcGlpMlt8+
         aOZ3XNocKhQU5JDkEB0sqefIhcVpMUAgqI6Y914zRY6oTD6kXA+96VW08hHV96nWttm2
         WVrA==
X-Gm-Message-State: APjAAAX6IfnplgvjdfUvTjTija0ebtJ+FPt4v84jooxQFDioDDQqd40J
        WCE5gD3nnUFdu6qEdExYqJZK7w2iEKHHKUc0/ho=
X-Google-Smtp-Source: APXvYqyeJJXnvactTWL0eCr3YuihvP0ZY0PiUrfdrtNx8VK6guaz1BhHo8VqTUGiT9SKpVoA4dPCHhq10uGcOPnYsdQ=
X-Received: by 2002:a25:7683:: with SMTP id r125mr54223449ybc.144.1564071155582;
 Thu, 25 Jul 2019 09:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190724195719.218307-1-salyzyn@android.com> <20190724195719.218307-6-salyzyn@android.com>
 <CAOQ4uxim8zZN5YHZs2OJz5A=3B0U10wyf371yadpe2B7hA8pZw@mail.gmail.com> <9acceab1-86af-758a-ec00-8f6d33f3da87@android.com>
In-Reply-To: <9acceab1-86af-758a-ec00-8f6d33f3da87@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 25 Jul 2019 19:12:24 +0300
Message-ID: <CAOQ4uxhLQGpG0=K46hAgPFgQ3KrDipUCqNs_=L6xNwG-dS_jtw@mail.gmail.com>
Subject: Re: [PATCH v10 5/5] overlayfs: override_creds=off option bypass creator_cred
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     kernel-team@android.com, Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

[reduce CC list]

>
> >
> > I am fine with this patch, but would like to request that you add @sb arg
> > to the ovl_revert_creds() helper, so it is more useful for other things in the
> > future that scope the underlying layers access (like shutdown).
>
> Will respin and retest.
>

Apropos testing, I wanted to bring up this issue.
I noticed that the test coverage I have for unprivileged user access to
overlayfs is lacking.

xfstests has several generic tests that use _runas and run on overlayfs,
but that's only for pure upper files.

unionmount-testsuite is always run as root, because it needs to
mount/umount/etc.
I am working on a new mode ./run --ov --runas=1
to seteuid(1);setegid(1) before every test (after set_up and mount)
That's fine for basic UNIX permission and capability checks, but does not cover
more complex setups like with sepolicy.

I was thinking maybe to execute "./run --ov --set-up" with mounter process
credentials (e.g. initd) and then add a new mode "./run --ov --no-set-up"
which uses the mount prepared by the mounter and runs the tests.

I wanted to get feedback on the ideas above if they are useful for
your use cases? Is that enough or is there more functionality required
to cover more use cases?

Thanks,
Amir.
