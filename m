Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82C9A17702B
	for <lists+linux-unionfs@lfdr.de>; Tue,  3 Mar 2020 08:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgCCHey (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 3 Mar 2020 02:34:54 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46541 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCCHey (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 3 Mar 2020 02:34:54 -0500
Received: by mail-io1-f68.google.com with SMTP id x21so2415620iox.13;
        Mon, 02 Mar 2020 23:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I2FEL9sQcv0x9Gydvjc+t8/7BMJFW+pQaU8k7YuMPK8=;
        b=SIG69EDlcXBIFV5DAJ0C6WbcspRCSYmaS06UybyO0sJ16FT1duUxJ3VtH7ZQhE3nML
         uAbiOUINC9RlHLHkZR4UwwBMBNz2aNg2qvMZJCktwLqNMKhM48HpSfJXH0B9azGxFoKT
         rna+GuDcBe/6gEBTa7+9lNoUDMVwE9hAWuR/IVfRhiDUVb+8SGyohAUsv4p0ztm3T0Lg
         q+CfF4rsy0/yg5L7G5meqm2zTQyDIvXRvUQBCvMmCsk8Awbeaw8/EeaMpvFfvBpWREOf
         vXGd7jcgwrwZq5RWNr9T8TDOFjlbv0GeEI4ldsVZEiIt83AgyQ898Du6UJ2TLTIvROUs
         7WTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I2FEL9sQcv0x9Gydvjc+t8/7BMJFW+pQaU8k7YuMPK8=;
        b=IhabJWb8MD8r9qVh5saFMbgIOVk4waAjUT+PJ8GOgsNYa1R5vRAweMqfFp6vjYQQc1
         9SaiWpB3X+J69JSade6h6Md5JIxrTtl6SRPVP539V21ay+AV71zD43U2uxkxm2kM4fkO
         iRgFbFkJj4foRswM9vot5PhZXZPjFAG+LSoKMyKB6+JZ5aWsrSZ5IcbZsd6V2uRotOYf
         mZgmdE5kLNFcMj2yPKIPJ9IfEAvHK8IkYXureiE5UX3HWCr4BWIe7S9Q5rUA+oRMDlYA
         rIP+Ja57OXPkGw3JZyh92UB4w5xHVdP8bTRs8brdNLep8AslWQNa+6d3Fy8XgzekF5mS
         6YqA==
X-Gm-Message-State: ANhLgQ1l3IaW3lPbQovEiuvQXgbUdfr9+BQCIAfxGLmPHcQYZa4eEJWh
        NcopLz52ssR26SIjGVmpgf1ZEZn/GCMWhESMZlU=
X-Google-Smtp-Source: ADFU+vtaVZqKosVXnyOcg99NaXgDrLDAi9nCuNxJrzactIEMZTykwelHmbd4d7KOQhmANK3ZBfdKC9vEkoExHZz8/f0=
X-Received: by 2002:a6b:dc05:: with SMTP id s5mr3011160ioc.72.1583220893844;
 Mon, 02 Mar 2020 23:34:53 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d3e319059fcfdc98@google.com> <CAOQ4uxh=tLw1p8vsbzTTqrTzLSqr33WtVHek+Jhbi5C2HKQLTA@mail.gmail.com>
 <CAJfpeguB7v8OBAuJoiPKv6FbfXP6wV2H8a9ceUUuPk4Aca3NRA@mail.gmail.com> <CAOQ4uxhb422zv4wEXKnvMTZkbmPcp8ZL_EMjV=qnUsGj0m1WhA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhb422zv4wEXKnvMTZkbmPcp8ZL_EMjV=qnUsGj0m1WhA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 3 Mar 2020 09:34:42 +0200
Message-ID: <CAOQ4uxirc1WwQOzE4Qq=k2R0ntGNTGYsot1b63DPkwCbUYjyZA@mail.gmail.com>
Subject: Re: WARNING: bad unlock balance in ovl_llseek
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     syzbot <syzbot+66a9752fa927f745385e@syzkaller.appspotmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Mar 2, 2020 at 2:19 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Mar 2, 2020 at 1:17 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, Mar 2, 2020 at 12:10 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > > =====================================
> > > > WARNING: bad unlock balance detected!
> > > > 5.6.0-rc3-syzkaller #0 Not tainted
> > > > -------------------------------------
> > > > syz-executor194/8947 is trying to release lock (&ovl_i_lock_key[depth]) at:
> > > > [<ffffffff828b7835>] ovl_inode_unlock fs/overlayfs/overlayfs.h:328 [inline]
> > > > [<ffffffff828b7835>] ovl_llseek+0x215/0x2c0 fs/overlayfs/file.c:193
> > > > but there are no more locks to release!
> > > >
> > >
> > > This is strange. I don't see how that can happen nor how my change would
> > > have caused this regression. If anything, the lock chance may have brought
> > > a bug in stack file ops to light, but don't see the bug.
> >
> > The bug is that ovl_inode_lock() is interruptible and that the caller
> > doesn't check for error.
> >
> > I think the fix is to make this lock uninterruptible (probably rename
> > the current helper to _interruptible and use the current name as the
> > uninterruptible version).
> >
>

Miklos,

Added the patch to ovl-fixes along with another ovl fix for fast track 5.6.

#syz test: https://github.com/amir73il/linux.git ovl-fixes

Thanks,
Amir.
