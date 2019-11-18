Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E937FFFDE
	for <lists+linux-unionfs@lfdr.de>; Mon, 18 Nov 2019 08:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfKRH5p (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 18 Nov 2019 02:57:45 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43981 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfKRH5p (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 18 Nov 2019 02:57:45 -0500
Received: by mail-yb1-f194.google.com with SMTP id r201so6794655ybc.10
        for <linux-unionfs@vger.kernel.org>; Sun, 17 Nov 2019 23:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JrGCQd2ygUrB2Rg6W9CRRBw92HcM0R6j54QDqimnvLQ=;
        b=gENitYpL5W1Si/gsh8LsRLFoOC0GsxiAhcogHhYJLHL8hUnsbiPkFY5LOdrluUz6MO
         edQnKFM8I8T/FpPQDPzuwpUt8St8iJkFP04u0Zl5c9Q+azuqOywu1l3cXLXexs9hOCrM
         MBRkkuLwWP1q8RHu323hyRHddKhsSorQ0tDMz94KzTQ6OafaLZS3sa4iYxiLPbyoxCc2
         PjxIQe8PxWWwXJrLmTDFvXklpQ7Qi71Omjq0f1Fv4khIR4mw82KG4pA1G+JNbobT2mGs
         /JOCfz2tdgZv5ErS62J+A9y4VEc80yLIxEr1i86xtBCmx7N83h5MMIHvEKJxqKndUPgf
         yWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JrGCQd2ygUrB2Rg6W9CRRBw92HcM0R6j54QDqimnvLQ=;
        b=LorNCN+XMWL0OjZ8VKdn9Ry17Lx049ZR2DfsfABMfpdCWYrZqvhPwSISZuU/j9Ssyj
         g/lYZCEAWNO1RySPAA04BRtIKTnae6xd24F5k9ew9bd9eB2rGNZzQEb1llMUKcfpo+eo
         QrE1CGp6ct7U4wySS+d8W3+vmF3XHWs8goQJderoGmgMaid/PRl87cA/ZO7R1UMzHuCn
         Ktg0uTL+O7w5j0IGfcqRY1sD9cY00zgyQyp3LJqoiBCrMOzjClACMPXGS0ExiBGABB9h
         H4/DPHNmOaxS4ZchpYlujvoujuRgAm+D8qY3GOxoXf4mM6KzRbvjEuKIF7uEfTxFuePf
         Zc8g==
X-Gm-Message-State: APjAAAVvoHOkyXKgrdLkAJEoCiKNFRiIJPVcRcATV8Lj4q4QsRqPnNyN
        k82ut8pSP+I5Uxjn4r253eu54Glo5JJIIA3U4VY=
X-Google-Smtp-Source: APXvYqwqmrrJ75HU7wloXqqq212mCFNrA+DDa6yTzKrIyvPtxeH5SAr/QmEwSaAQdJ+8ghBcy4uIXd2F6+/3kJBfNFE=
X-Received: by 2002:a25:383:: with SMTP id 125mr22560215ybd.45.1574063864266;
 Sun, 17 Nov 2019 23:57:44 -0800 (PST)
MIME-Version: 1.0
References: <20191117154349.28695-1-amir73il@gmail.com> <CAOQ4uxjMbNVf9-1YjUpDzyaM_aV7OD0hi4m_AMbUvH3vUVn4sQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjMbNVf9-1YjUpDzyaM_aV7OD0hi4m_AMbUvH3vUVn4sQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 18 Nov 2019 09:57:33 +0200
Message-ID: <CAOQ4uxjMsv2vE5Nn5D8TNCFxaz8b4duyOLOiPpy4qd1bs3bdwQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Sort out overlay layers and fs arrays
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Colin Ian King <colin.king@canonical.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Nov 18, 2019 at 8:03 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Sun, Nov 17, 2019 at 5:43 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Miklos,
> >
> > When I started generalizing the lower_layers/lower_fs arrays
> > I noticed a bug that was introduced in v4.17 with xino.
> >
> > In the case of lower layer on upper fs, we do not have a pseudo_dev
> > assigned to lower layer and we expose the real lower st_dev;st_ino.
> > This happens on non-samefs when xino is disabled (default).
> > This is a very real bug, not really a corner case and I have an
> > an xfstest [1] for it that I will post later.
> >
> > In the mean while, I also pushed a fix to unionmount-testsuite devel
> > branch [2] to demonstrate the issue.
> >
> > With upstream kernel, this test ends up with a copied up file
> > from middle layer, whose on same fs as upper and its exposed
> > st_dev;st_ino are invalid:
> >
> >  ./run --ov=1 --verify hard-link
> >  ...
> >  /mnt/a/no_foo110: File unexpectedly on upper layer
> >
> > Patch 1 in the series is a small fix for stable that fixes the
> > v4.17 regression in favor of a different, less severe regression.
> > The new regression can be demonstrated with:
> >
> >  ./run --ov=1 --verify --xino hard-link
> >  ...
> >  /mnt/a/no_foo110: inode number/layer changed on copy up
> >  (got 39:24707, was 39:24700)
> >
> > Patches 2-4 generalize the lower_{layer/fs} arrays to layer/fs arrays
> > and get rid of some special casing of upper layer.
> >
> > Patches 5-6 use the cleanup to solve the corner case that you pointed
> > out with bas_uuid [3] and to fix the regression introduced by patch 1.
> >
> > After patch 6, both unionmount-testsuite configurations
> > above pass the test st_dev;st_ino verifications.
> >
> > I doubt if patches 2-6 are stable material, because not sure the
> > corner cases they fix are worth the trouble.
> >
> > The series depends on the bad_uuid patch v5 that I posted on Thursday.
> >
> > I was also considering setting xino=on by default if xino_auto
> > is enabled, because what have we got to loose?
> >
> > The inodes whose st_ino fit in lower bits (by far more common) will
> > use overlay st_dev and the inodes whose st_ino overflow the lower bits
> > will use pseudo_dev. Seems like a win-win situation, but I wanted to
> > get your feedback on this before sending out a patch.
> >
>
> Arrr.. yes, there is a catch.
> Overflowing lower bits has a price beyond just using pseudo_dev.
> It introduces the possibility of inode number conflicts on directories,
> because directories never use pseudo_dev.
>

But we could mitigate that problem if we reserve an fsid for volatile
directory inode numbers. get_next_ino is 32bit anyway.
I am going to take a swing at having xino=auto always enabling xino.

Thanks,
Amir.
