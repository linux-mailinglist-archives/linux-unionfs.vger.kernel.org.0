Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBD0817666
	for <lists+linux-unionfs@lfdr.de>; Wed,  8 May 2019 13:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfEHLDa (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 8 May 2019 07:03:30 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44303 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfEHLDa (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 8 May 2019 07:03:30 -0400
Received: by mail-yw1-f66.google.com with SMTP id j4so15867616ywk.11
        for <linux-unionfs@vger.kernel.org>; Wed, 08 May 2019 04:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ktzz+Jj6GTe7K1QWnIqwKiGqHymai6sSk+L1WXj9oWw=;
        b=r8Xj1y5PVcmfBE4W6IDZa6SBU53O+Rhf5GufdZozDnJc9uAWM0TeDxzLNQgORI72cT
         RLwo6rq7xnkCBGR0VlP5kwnvODStkY7XQd5G1w+FtVec8xn1ZqOaC2gHWf/HrJ0XyeUo
         3Oy6+gFlVids81cOOnMesdzmBHvAahAFFdGsZ2PGXGW1TnCgvL58IjBDK9zDN1AY/qZi
         jHK5vi6gRkzKO2ZeSpcePF0l6cxiGUNTGEbju9ZpeQsKYJNtibKTfjnA12tSFtHI6nxu
         rH/jhlb2N3Qm88OeuV2FOgoUIsEzagb07a3RkeoTnU0jwcXmR37G6PN4ZfZZ1WA4MGpT
         fR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ktzz+Jj6GTe7K1QWnIqwKiGqHymai6sSk+L1WXj9oWw=;
        b=JSDhXRTsGV5eMPSlBe1+bnJLKbB5JzyuG2CbIJbrczx2zGMMN/Ey8i5a97lVaDHkTE
         Ls+dM6Lwtt0ZKq026YTdWj3hlNkJNmOqjlM/fWPM0/CcMitFsgWbn+Ub5nhHYeKwlhGf
         A2pJYqlFdQbfKSZ1NXUBzvFV2H8mx1G465qtWQwq/eXk+rEmRwA8VfS+SO+k9rfLrphD
         pIGuIRikyUUBXlQwIEwBF7k8FpkUOenH/9xBkbJhUCDLM/aBjVvfIXwegIrm7Hc06Vw+
         AnW2hQ3Bx8ecBgk8I+p22uHGKfNx35YBAKXdw6nnehwnLlKJMLaFIZeBPcNT/Gj1JJ/r
         uFng==
X-Gm-Message-State: APjAAAVKuYM458C88hGcWIW1VfF48sJpi2zlGS+dpIzWojedFlufeDpL
        uLcj9EwuGVF+ZIscr+YSHRxhNgWSszxvy5PpDZc4kw==
X-Google-Smtp-Source: APXvYqyW6GkT4Oz/UfvWGUH/IrmiD5t1r4cBb7idf5VoUXkM4VQ7ae8mjul44vGinkHFjUvll2iHfI7rOT3fHkgEaSQ=
X-Received: by 2002:a81:63c3:: with SMTP id x186mr15818695ywb.248.1557313409466;
 Wed, 08 May 2019 04:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190328153829.729-1-amir73il@gmail.com> <CAJfpegt08nTeDs4+3svOjGAF+mQEP+Dm-amLz9nDWOACqtAUMQ@mail.gmail.com>
In-Reply-To: <CAJfpegt08nTeDs4+3svOjGAF+mQEP+Dm-amLz9nDWOACqtAUMQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 8 May 2019 14:03:18 +0300
Message-ID: <CAOQ4uxgfuENW7gqsr_Q=Ne8u=PR-oyJ5N6Te9C+L2-14UDK4Cg@mail.gmail.com>
Subject: Re: [PATCH] ovl: relax WARN_ON() for overlapping layers use case
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Sat, Mar 30, 2019 at 10:45 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Thu, Mar 28, 2019 at 4:38 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > This nasty little syzbot repro:
> > https://syzkaller.appspot.com/x/repro.syz?x=12c7a94f400000
> >
> > Creates overlay mounts where the same directory is both in upper
> > and lower layers. Simplified example:
> >
> >   mkdir foo work
> >   mount -t overlay none foo -o"lowerdir=.,upperdir=foo,workdir=work"
>
> Shouldn't the mount fail in this case?
>
> Does it make any sense to allow overlapping layers?
>
> If doing the check the dumb way, the number of d_ancestor() calls
> would increase quadratically with the number of layers, but I think
> it's possible to do it in linear time if necessary.
>

Miklos,

I saw you did not pick this one for next.
IMO, regardless of preventing mount with overlapping layers,
the WARN_ON() is inappropriate and this patch that replaces it with
pr_warn_reatelimited() has merit on its own.

WARN_ON() should reflect a case that we don't think is possible
in current code and as API constrain assertion.
Neither is the case here.
We know that it *is* possible to hit this case, even with checking overlapping
layers on mount and user does get an error when we hit the case.

Thanks,
Amir.
