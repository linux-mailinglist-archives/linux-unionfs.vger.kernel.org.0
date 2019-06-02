Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66E1F322AF
	for <lists+linux-unionfs@lfdr.de>; Sun,  2 Jun 2019 10:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfFBIHN (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 2 Jun 2019 04:07:13 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35658 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfFBIHN (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 2 Jun 2019 04:07:13 -0400
Received: by mail-yw1-f67.google.com with SMTP id k128so6070842ywf.2;
        Sun, 02 Jun 2019 01:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xqk7EKL2SV95UZjmOddmWxOkIDexNhAp5jf3T3MFvW8=;
        b=V0JHpErnwFA1OOgIcLW3XJUX95RYObH08r7EKM7FFfXxq8lbnMcVYow+EJxDSpX3sf
         1bNgreOXYbZSHHo67d4TrfSmR07dsyBO69SmFgf7aYdlBBPUHpjbvwMqiOroipdMSwED
         w77jrnyuHrGZDr/rhOhArqP3vQSkh+KOoU0tqaLDabroHQGuwfr1wCISN424YcbynyBO
         4vQ8ZZwzoxIMP7j9MFfTFUM9QQqY2aZK/5oIpi8munjbtuy/6JmEJ6Up9L9jefXENx1K
         jtpKhY44f9SsCocbMCcFxI0uJd/daQuhFbTjmkKbC9mVVjy8zABNkz1c67rXgMQZoTMY
         diJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqk7EKL2SV95UZjmOddmWxOkIDexNhAp5jf3T3MFvW8=;
        b=Z0XUbmq7lTc/iekDFe6ltOPSGF7Hvg/vlj2bPfXB3d6ETls5Jnr3tQoJf+0a33XXaM
         Rt+PA6xPppwOQvkSd+9o84HJXcEPVWexxO+mW25zBJCqMc+TrWOmontX0LX7KcsRANDL
         RGeWzB7J8B6Ar7EUesogmqhqDu8rMxHUDWueGmS4MfPKcVQVVRoOfVUvDFzsAKWe4XDv
         Jvg6kZhmXSLAT6t0mZ0qttdcYSwExbaNGqE0xSqDeGLax279j8ms6Aj1QxOM+BenHNYu
         pgZDjboLeyufBxzxiYJkPtVNzfBXyo2wWwvwDrJGjsy7wQaWf12RDpbzeyOnza1oYDED
         gYhg==
X-Gm-Message-State: APjAAAUPeKitgBETeydWCOaAZ5KF5O6Wk3RV6P8M8MArPk6Nl7kfNSR+
        PB1WoAgJlk4xSDzKR77K6XhWKdSE3kiZzSGYMiU=
X-Google-Smtp-Source: APXvYqxI2uVWhBBewMgqlip/1feeE8+21jUEuHl4Uxb1kT+z886/t//Lk50F21hEZhjem78d5JoDM4bilVd+Np+MxM8=
X-Received: by 2002:a0d:f5c4:: with SMTP id e187mr652800ywf.88.1559462832493;
 Sun, 02 Jun 2019 01:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190528151723.12525-1-amir73il@gmail.com> <20190528151723.12525-4-amir73il@gmail.com>
 <20190602070949.GS15846@desktop>
In-Reply-To: <20190602070949.GS15846@desktop>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 2 Jun 2019 11:07:01 +0300
Message-ID: <CAOQ4uxgvajS+JzAc9NTNHF4XtYDp_mqV22dDZ73uEu72uQJP1g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] overlay: correct fsck.overlay exit code
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     zhangyi <yi.zhang@huawei.com>, Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Sun, Jun 2, 2019 at 10:26 AM Eryu Guan <guaneryu@gmail.com> wrote:
>
> On Tue, May 28, 2019 at 06:17:22PM +0300, Amir Goldstein wrote:
> > From: "zhangyi (F)" <yi.zhang@huawei.com>
> >
> > fsck.overlay should return correct exit code to show the file system
> > status after fsck, instead of return 0 means consistency and !0 means
> > inconsistency or something bad happened.
> >
> > Fix the following three exit code after running fsck.overlay:
> >
> > - Return FSCK_OK if the input file system is consistent,
> > - Return FSCK_NONDESTRUCT if the file system inconsistent errors
> >   corrected,
> > - Return FSCK_UNCORRECTED if the file system still have inconsistent
> >   errors.
> >
> > This patch also add a helper function to run fsck.overlay and check
> > the return value is expected or not.
> >
> > [amir] rename helper to _overlay_fsck_expect, split define of FSCK_*
> > to a seprate path.
> >
> > Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  common/overlay    | 19 +++++++++++++++++++
> >  tests/overlay/045 | 27 +++++++++------------------
> >  tests/overlay/046 | 36 ++++++++++++------------------------
> >  tests/overlay/056 |  9 +++------
> >  4 files changed, 43 insertions(+), 48 deletions(-)
> >
> > diff --git a/common/overlay b/common/overlay
> > index a71c2035..53e35caf 100644
> > --- a/common/overlay
> > +++ b/common/overlay
> > @@ -193,6 +193,25 @@ _overlay_fsck_dirs()
> >                          -o workdir=$workdir $*
> >  }
> >
> > +# Run fsck and check for expected return value
> > +_overlay_fsck_expect()
> > +{
> > +     # The first arguments is the expected fsck program exit code, the
> > +     # remaining arguments are the input parameters of the fsck program.
> > +     local expect_ret=$1
> > +     local lowerdir=$2
> > +     local upperdir=$3
> > +     local workdir=$4
> > +     shift 4
> > +
> > +     _overlay_fsck_dirs $lowerdir $upperdir $workdir $* >> \
> > +                     $seqres.full 2>&1
> > +     fsck_ret=$?
> > +
> > +     [[ "$fsck_ret" == "$expect_ret" ]] || \
> > +             echo "fsck return unexpected value:$expect_ret,$fsck_ret"
>
> This statement looks ambiguous, it's not that clear which return value
> is expected and which is unexpected. I'd like to change it to something
> like:
>
> "expect fsck.overlay to return $expect_ret, but got $fsck_ret"
>
> I can fix it on commit if you're OK with this change.
>

Fine by me.

Thanks,
Amir.
