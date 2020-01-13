Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24B5C13903B
	for <lists+linux-unionfs@lfdr.de>; Mon, 13 Jan 2020 12:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgAMLhz (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 13 Jan 2020 06:37:55 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41564 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgAMLhz (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 13 Jan 2020 06:37:55 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so9416894ioo.8
        for <linux-unionfs@vger.kernel.org>; Mon, 13 Jan 2020 03:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tURM4BYk7bVIlenKvR6FfzhBZsfyW+L4w0pa64kz3d0=;
        b=QCuP6kBE5AI10RGn5auYpq+Zg0RpKJ2VouSfmfRYj5eabZ9lPcD6KnWTTr+PSWgehZ
         xhT/0R4QtoTO1g234ILhfrdI1MbHQ09Q0yTcs5hR5guEbbQu6PVPCkJ2d8icoq/Zkig7
         qRgzi0NfhEQIetVl/5IlS/B7VMtbObGW2sVDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tURM4BYk7bVIlenKvR6FfzhBZsfyW+L4w0pa64kz3d0=;
        b=WRzt3yCfLONyWLuZtG3js1bgDnPqWbnEXsmOxkFAFUbI0mXbElM39gr113LVXEpPag
         j6IpMfhcP/mpd9ePGnL+womUG8yW4l4jW+KtH0LgdC94AKktV3zjAbrMtk6hEq2YUutv
         9+gnKwoDBnGg9NcCgH2+HNUlq2nSBkx/0MVNMXTYwSKgZfQhY3ebGAaovXtAOem2irmb
         INjblzaJ+ydNSGzNH2V1dgeF1LslugNmpJiUaH9wB2NwD6hOtUtdaruw3zWVOQ8Gi6NV
         ATDf3JHESAY6c4wXw8EDMq1UGfT5Fm+4c+iQamo/JI0UkJGJiSZHKfmfcoD+wh7aB0Or
         7RxA==
X-Gm-Message-State: APjAAAUPqEf/bvsDjmzrxZdhLjIBEqL+YP3jywT/hAlBIInDthKpSZ3g
        h5DVl/k0RGOwFEtwCPa/2KAsA/aNPnapA2BDdT6AEA==
X-Google-Smtp-Source: APXvYqyqGJu2ISbX6YcBa2vj1eVENNr9WS/9Eq9hXvYEmf88ZCS1pQz9Hpz/q+H2tZn6nERCb0nbHpKRM118/PtGGRQ=
X-Received: by 2002:a02:9988:: with SMTP id a8mr14001657jal.33.1578915474922;
 Mon, 13 Jan 2020 03:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20191222080759.32035-1-amir73il@gmail.com> <20191222080759.32035-3-amir73il@gmail.com>
In-Reply-To: <20191222080759.32035-3-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 13 Jan 2020 12:37:44 +0100
Message-ID: <CAJfpeguNywFLtpETg1oVpLnjkMP=DPZU3Fjvvb9aumRvTXBwtw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] ovl: simplify ovl_same_sb() helper
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Sun, Dec 22, 2019 at 9:08 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> No code uses the sb returned from this helper, so make it retrun
> a boolean and rename it to ovl_same_fs().
>
> The xino mode is irrelevant when all layers are on same fs, so
> instead of describing samefs with mode OVL_XINO_OFF, use a new mode
> OVL_XINO_SAME_FS, which is different than the case of non-samefs
> with xino=off.
>
> Create a new helper ovl_same_dev(), to use instead of the common check
> for (ovl_same_fs() || xinobits).

What about OVL_XINO_AUTO: in this case xinobits would be zero but
ovl_same_dev() would return true, no?

More comments inline.

> @@ -358,7 +352,8 @@ static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
>         if (ofs->config.nfs_export != ovl_nfs_export_def)
>                 seq_printf(m, ",nfs_export=%s", ofs->config.nfs_export ?
>                                                 "on" : "off");
> -       if (ofs->config.xino != ovl_xino_def())
> +       if (ofs->config.xino != ovl_xino_def() &&
> +           ofs->config.xino != OVL_XINO_SAME_FS)

I'm not sure I like this, although it doesn't contradict the policy of
repeatability of mounts.   Could we instead have a separate
ofs->xino_state, that defaults to config.xino but can take the value
of OVL_XINO_SAME_FS?

Thanks,
Miklos
