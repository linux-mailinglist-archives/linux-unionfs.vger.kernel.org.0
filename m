Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A31271393B4
	for <lists+linux-unionfs@lfdr.de>; Mon, 13 Jan 2020 15:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgAMOby (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 13 Jan 2020 09:31:54 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:40522 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgAMObx (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 13 Jan 2020 09:31:53 -0500
Received: by mail-il1-f193.google.com with SMTP id c4so8317530ilo.7
        for <linux-unionfs@vger.kernel.org>; Mon, 13 Jan 2020 06:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w8oNA38HPPNhhnf0bICo9NhafLoOZXTrigGpozHndX0=;
        b=UsOc+OnZtFrGh856uDwJbpkZanYLxk9Dm4Ttp8g3wrPyidk37nK8sBP9XufTFXjcw1
         cf2ES5fuEP123k5/vC0BYC8olxk7T/yYaiJ6AQSIML8wb5PjEWLCvnPYiwcEdb+0Duxd
         PGw6Wl2rp8gMCJkzQfrGK+tWcZ7L0DkVF7AduKocxEkCp7iuFuS4ibYzE9+KswXflGue
         ewg9+V8jgTmUPZXjR+LIH8QMrEWzsMqurKNiH2J2o1Tn9aP381F90V5RYRfjc/KNmrXN
         tlrRSw8AL01CsauY0wQbSyC1zIQ0ZSOdnmp6ImmtC942OkX4qHFHF65rYGakybIOYQ17
         TP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w8oNA38HPPNhhnf0bICo9NhafLoOZXTrigGpozHndX0=;
        b=CA5CzfbJCOhZNwlJBQybFilMmsYEgruLtkWgmIscvUjPlkK4vh6J2VDfiOCdx3mG51
         edkXo29VUYoh/ioRj18WYaSahsYeD+08jZQly0riIKHfu5Vo1c9T9T+Bp+P7QkWhX6sQ
         dIdXfKERWxAoPxQI0Vw0fADM1WdKnx6nH8SkhzxpRIwl3tgYeyV0nR9GRP5sIPlAbMCr
         5NF2eLWNKMI19zthjF7Eg7Q0PLYLF+0RbGRFPq5Axi2SRnQ+ygf8wXuDHxqEzgGDKy4e
         NOYRE9ihi3o/IjNkC3jrKkbL9zX9t1jhZWMvdx92nfHRVbtoWgxp2hegw0TVn99mQ0oW
         VQag==
X-Gm-Message-State: APjAAAV5VV4iV/t4rpIwu4Ad93NZiY7ijni21W+5NF0n5AwcDJkri6Pe
        T+WznE+akqHDPVSMJJv4uXy6S3ZKeM2/RgFky34=
X-Google-Smtp-Source: APXvYqz2JEOjvycRX9sISDDnOzPEcdMc7WP2L5Bcu1bClNWOBZH0nzI3lpLil+dYiZEVVE25g0ViImBLLHfDWvzT/U8=
X-Received: by 2002:a92:5c8a:: with SMTP id d10mr15812189ilg.137.1578925913222;
 Mon, 13 Jan 2020 06:31:53 -0800 (PST)
MIME-Version: 1.0
References: <20191222080759.32035-1-amir73il@gmail.com> <20191222080759.32035-3-amir73il@gmail.com>
 <CAJfpeguNywFLtpETg1oVpLnjkMP=DPZU3Fjvvb9aumRvTXBwtw@mail.gmail.com>
In-Reply-To: <CAJfpeguNywFLtpETg1oVpLnjkMP=DPZU3Fjvvb9aumRvTXBwtw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 13 Jan 2020 16:31:42 +0200
Message-ID: <CAOQ4uxj8yewBzot0_Hu2OwNWMH=M_yGf_wtsCJn9UkwJARs0SA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] ovl: simplify ovl_same_sb() helper
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Jan 13, 2020 at 1:37 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Sun, Dec 22, 2019 at 9:08 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > No code uses the sb returned from this helper, so make it retrun
> > a boolean and rename it to ovl_same_fs().
> >
> > The xino mode is irrelevant when all layers are on same fs, so
> > instead of describing samefs with mode OVL_XINO_OFF, use a new mode
> > OVL_XINO_SAME_FS, which is different than the case of non-samefs
> > with xino=off.
> >
> > Create a new helper ovl_same_dev(), to use instead of the common check
> > for (ovl_same_fs() || xinobits).
>
> What about OVL_XINO_AUTO: in this case xinobits would be zero but
> ovl_same_dev() would return true, no?
>

Yes, I missed it.

> More comments inline.
>
> > @@ -358,7 +352,8 @@ static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
> >         if (ofs->config.nfs_export != ovl_nfs_export_def)
> >                 seq_printf(m, ",nfs_export=%s", ofs->config.nfs_export ?
> >                                                 "on" : "off");
> > -       if (ofs->config.xino != ovl_xino_def())
> > +       if (ofs->config.xino != ovl_xino_def() &&
> > +           ofs->config.xino != OVL_XINO_SAME_FS)
>
> I'm not sure I like this, although it doesn't contradict the policy of
> repeatability of mounts.   Could we instead have a separate
> ofs->xino_state, that defaults to config.xino but can take the value
> of OVL_XINO_SAME_FS?
>

OK, I understand why you don't like it and I think is makes sense to
have an xino_state.
However, xino_state and xino_bits are quite redundant.

If we change:
unsigned int xino_bits;
to:
int xino_mode;

It can take the values:
-1 /* not same dev */
0 /* same fs */
1..32 /* xino_bits */

And:

static inline unsigned int ovl_xino_bits(struct super_block *sb)
{
        return OVL_FS(sb)->xino_mode > 0 : OVL_FS(sb)->xino_mode : 0;
}

Thanks,
Amir.
