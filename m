Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F04EBE29E2
	for <lists+linux-unionfs@lfdr.de>; Thu, 24 Oct 2019 07:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404021AbfJXF2f (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 24 Oct 2019 01:28:35 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44467 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfJXF2f (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 24 Oct 2019 01:28:35 -0400
Received: by mail-yb1-f196.google.com with SMTP id v1so7068284ybo.11
        for <linux-unionfs@vger.kernel.org>; Wed, 23 Oct 2019 22:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8oWd59M+L8fxoID4SWEv9bOaSdRGTVUJFSue5gy1fD8=;
        b=o6p+157RKkjbksuw4UI1wT8llsRNIOSvRC3Eyy4duDMNR5kDZx/w5qE8oT4xO/jt5Y
         TIBLTRPnzMz2YSeYTH9dQabeiTkRr232h1WhnWR9VgRfbr7As9Cu7PApnqbu2BbHhx2j
         wqv00DbWNJqWUJv++LiYT2iYZNBtYzosOcANJiFGgb5j5aVJOz54tAgQDbju5+fP6546
         rX5ZdM4eps3GMq5YJJGUu0cjqM7ibGs68ew8bC/CY1BNYQYQU+pG7/Cw4icssdvNrT55
         dW6Sy8nROYhFxP6H5Vvm4/pnSw2tWkUHEV24Zo7dW/Njp0hSOyiwFeTt4PuFAVmTk0ZT
         rXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8oWd59M+L8fxoID4SWEv9bOaSdRGTVUJFSue5gy1fD8=;
        b=QJItQWU80Hde7lnBYSX3sCPHqYQZzsoJKK1chBTGk7C6AnVVPg/K3HxhPYN4nm5BCW
         g1PBiXasdXuB2kUJQhkxGYrGVAYE91XY+9ZKeoo0w+qS+u1inRamHRiYZJ7LAsw/6+e7
         c+Osr/2rYHTuo9GyV2f7LokeodOpwRZxDXzpS6Q1VRo/VEnsrX9Yky1WOBOkEjCBVHca
         OvHBimObu5tCfp0PPgM69DW9WVPDSSuHdnf2AWwV3YA+1xGfKzxD9MQuDj9bZtg9doeZ
         wpjMD9Y/mlvpP68JIFEt8LXgYwjHyfgEyNI5qNnoX6c8QRQyRomLsGZV7Em/CCnj9RpY
         2mDA==
X-Gm-Message-State: APjAAAUV5dlBWlK4iVljkv2gbWAwrZg4eD76uFq7QfQzfyxBDWKGWYm2
        +exW74+mhKvmtjqJ0aKSAYcGXS5oIeTzuQBGF4A=
X-Google-Smtp-Source: APXvYqyKzuys5Rauj+fkBIve16rM5vew0VrdVVjzBkYoqmwTmgZwljiH2wzfPH2k5ru56zZLLMHqtkqQQTDB4ZRxbM0=
X-Received: by 2002:a25:3344:: with SMTP id z65mr624700ybz.439.1571894914264;
 Wed, 23 Oct 2019 22:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191022204453.97058-1-salyzyn@android.com> <CAOQ4uxjFqq0zA7V3A9s0h2om7AWY5AT-2sQ4z2G0Vk2gtf1M=w@mail.gmail.com>
 <c0eb1b6e-65f6-9d38-64b9-333f3e82905a@android.com>
In-Reply-To: <c0eb1b6e-65f6-9d38-64b9-333f3e82905a@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 24 Oct 2019 08:28:23 +0300
Message-ID: <CAOQ4uxj4Hy9E-rGyM9bihyoFhi9h2DunFWFBAyYMDef=XyrrEQ@mail.gmail.com>
Subject: Re: [PATCH v14 0/5] overlayfs override_creds=off & nested get xattr fix
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

> > I remember asking - don't remember the answer -
> > do you have any testing for this feature?
> Yes, on an unnamed 4.19-based and mainline-based Android and virtual
> cuttlefish product ... which was critically unworkable without this
> patch series.

Of course you *tested* it - I meant did you write any automated tests
that other developers can run to verify that feature won't break with future
changes.
Many people run xfstests with overlayfs, where most of the tests run
as root.
Few people run unionmount testsuite with overlayfs where most of
the tests run as root.
So none of those tests have coverage for override_creds=off.

> > I have a WIP branch to run unionmount-testsuite not as root,
> > which is a start, but I didn't get to finish the work.
> > Let me know if you want to take up this work.
> Please refer it in private email to me, no guarantees, my cycles are so
> sparse right now that it took a month to respin this patch series to
> upstream. If I can make it test on Android with overlayfs activated, big
> gain.

It's here:
https://github.com/amir73il/unionmount-testsuite/commits/run_as_bin

As far as I can tell, the test code in the branch is working, but it fails
on permissions in one of the early create file test cases and I did not
have time to look into it.

What it does is to drop capabilities to uid 1 before executing the test
cases. In between test cases, for the test setup it reverts back to uid 0.

For your Android use case, you may want to have uid's 0/1
configurable to different uid's? the first (setup) uid obviously needs to
be capable of mounting overlayfs.

Not sure how you would go about changing security context?
Probably, you would need to have the test setup code execute
"./run --ov --set-up" via init service command.

Cheat sheet for running the test:

pre requisite python3
sudo mkdir -p /lower /upper /mnt
sudo ./run --ov

Thanks,
Amir.
