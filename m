Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8A17FFE34
	for <lists+linux-unionfs@lfdr.de>; Mon, 18 Nov 2019 07:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfKRGDN (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 18 Nov 2019 01:03:13 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45557 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfKRGDN (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 18 Nov 2019 01:03:13 -0500
Received: by mail-yw1-f66.google.com with SMTP id j137so5468907ywa.12
        for <linux-unionfs@vger.kernel.org>; Sun, 17 Nov 2019 22:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bj/2cV8lMz1M7rYLqmFTxEuP+jO7oygUIQqpl/tFo1k=;
        b=L73ZRkF1YXGqk4YPw8RUe7wpkytdPa22NgtRyp6qmGY5E86Z9u2QddXZpS8iZChQ/t
         g87gpsXjSGnoO9QttSwfoqfpUkH84Q8/9sKqs6qH6E48Mx89UBlOxaMPmkD6GdzXYO2e
         WJLzWOUeQWw/DXs/sZz5h45ah3c9ZHUtspoKjf86j9No8IKx7vo3ATNfOcT3F+9ziGqI
         wI6eGp+Q0tJWRtTAPCXMyeRRIISVhRect0HpZ+AYH45vNOBtQxaqx3kfCdp4NVnH02OT
         tNYAx4Co9xVAM0n/NELqFPFpOkouuHxrFCsz0sIimH42XbraFsy9zym14h+IEGhMWgXU
         /4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bj/2cV8lMz1M7rYLqmFTxEuP+jO7oygUIQqpl/tFo1k=;
        b=sKDOZyco5CJnps03BwHgN8p2Tn3MfmLKc3T80B6oRw4sLVSAGQCA6JT2TXxTbfvpOB
         btm6CcZp+fDhC5FiYS93/2EEfZsa+9Zh+91wnP7Hhfqm28DjW1EDYA8igDYRRvAUNQcf
         rg5nHBq2PNL0cA8Azngjf9NvjsOZrYRfONAxnciEb0iNA2gdeFrwO0ZApJHsujdrK9cI
         uqwN0s1tHhWI+gftjLT5wiNT8BI/4cwblLIQXbRPvNigAg8eoYi2EL9VUj6xSVhsCM3T
         2bWtTwJbpBVujsnTcalFzXRcI4p2RcuDn6Io9H+TJJ1qfuv6vVq/gXps7wOrjITXGUuO
         jWrw==
X-Gm-Message-State: APjAAAUHXcVxpqa/RsnLmERLmwWGl+A1mJi1xglRgYxVxKr1po+w9kHk
        HA5KGWSNGvXuNmXPjwmM8FZhkPRKnCSK44uZjDqRvPPF
X-Google-Smtp-Source: APXvYqxjKY+O8ZPw8V+qGBuP4j3pKjgWd6CuxZeMA+2Iu90jJGRozCjXPHWjbEv9DtvmIQ9eMS84S3vApyNnJMF+Tc4=
X-Received: by 2002:a0d:f305:: with SMTP id c5mr18801711ywf.31.1574056992151;
 Sun, 17 Nov 2019 22:03:12 -0800 (PST)
MIME-Version: 1.0
References: <20191117154349.28695-1-amir73il@gmail.com>
In-Reply-To: <20191117154349.28695-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 18 Nov 2019 08:03:00 +0200
Message-ID: <CAOQ4uxjMbNVf9-1YjUpDzyaM_aV7OD0hi4m_AMbUvH3vUVn4sQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Sort out overlay layers and fs arrays
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Colin Ian King <colin.king@canonical.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Sun, Nov 17, 2019 at 5:43 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Miklos,
>
> When I started generalizing the lower_layers/lower_fs arrays
> I noticed a bug that was introduced in v4.17 with xino.
>
> In the case of lower layer on upper fs, we do not have a pseudo_dev
> assigned to lower layer and we expose the real lower st_dev;st_ino.
> This happens on non-samefs when xino is disabled (default).
> This is a very real bug, not really a corner case and I have an
> an xfstest [1] for it that I will post later.
>
> In the mean while, I also pushed a fix to unionmount-testsuite devel
> branch [2] to demonstrate the issue.
>
> With upstream kernel, this test ends up with a copied up file
> from middle layer, whose on same fs as upper and its exposed
> st_dev;st_ino are invalid:
>
>  ./run --ov=1 --verify hard-link
>  ...
>  /mnt/a/no_foo110: File unexpectedly on upper layer
>
> Patch 1 in the series is a small fix for stable that fixes the
> v4.17 regression in favor of a different, less severe regression.
> The new regression can be demonstrated with:
>
>  ./run --ov=1 --verify --xino hard-link
>  ...
>  /mnt/a/no_foo110: inode number/layer changed on copy up
>  (got 39:24707, was 39:24700)
>
> Patches 2-4 generalize the lower_{layer/fs} arrays to layer/fs arrays
> and get rid of some special casing of upper layer.
>
> Patches 5-6 use the cleanup to solve the corner case that you pointed
> out with bas_uuid [3] and to fix the regression introduced by patch 1.
>
> After patch 6, both unionmount-testsuite configurations
> above pass the test st_dev;st_ino verifications.
>
> I doubt if patches 2-6 are stable material, because not sure the
> corner cases they fix are worth the trouble.
>
> The series depends on the bad_uuid patch v5 that I posted on Thursday.
>
> I was also considering setting xino=on by default if xino_auto
> is enabled, because what have we got to loose?
>
> The inodes whose st_ino fit in lower bits (by far more common) will
> use overlay st_dev and the inodes whose st_ino overflow the lower bits
> will use pseudo_dev. Seems like a win-win situation, but I wanted to
> get your feedback on this before sending out a patch.
>

Arrr.. yes, there is a catch.
Overflowing lower bits has a price beyond just using pseudo_dev.
It introduces the possibility of inode number conflicts on directories,
because directories never use pseudo_dev.

Thanks,
Amir.
