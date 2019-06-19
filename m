Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B859D4B671
	for <lists+linux-unionfs@lfdr.de>; Wed, 19 Jun 2019 12:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfFSKrN (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 19 Jun 2019 06:47:13 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46453 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfFSKrN (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 19 Jun 2019 06:47:13 -0400
Received: by mail-yb1-f194.google.com with SMTP id p8so7393545ybo.13;
        Wed, 19 Jun 2019 03:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IzPT7BaLr+o3GG3LZYVk6BTlcHp6ZzyDkbN4F9qcZ/o=;
        b=W3piUkBIYFlkFQGMet47EtAIv49iHPgGADK7212QqI3vAsK4KNNh+B0DQZq/NABx+e
         Qse26vXlcl8TSCiELpwVqxTUCckWG4Botq9pyvig/hxfcV2w0z2p0BsUFNj3xTbLwVLo
         NbPopxOK/tclr2Ke0HXNzcECdpE87H5aeRCFXFg2PlVZKFaEdCHNINKXPaw6U4q4LHB0
         MLYyH4ZnWkYWAl+AYMXmjMTi9Z+CixrL/nZwZJZSXzvBzT2/mT/Me4UMSJbu9F6qnl7g
         KDcibhDNaqGjAsjCKVLZYd3O0Tr+UQKaZAR3+la5lUasNrvU4d/PoXoCCQgxaIb3J+dX
         5AkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IzPT7BaLr+o3GG3LZYVk6BTlcHp6ZzyDkbN4F9qcZ/o=;
        b=Vw0wG5HEu8fmmUElb7kIYNBO9wDx+8/Aom5ja5ZkHERVnbr8VSPbjUUL5ToUfzRQrJ
         PWDeq+6agsmZvddH7w1RXFETQuM7fgFzt3FuWfHSd7BK2cs7/f6F9QsWYdMWqXrYrlZX
         OQwMk1cKR+kiF7KafqB2StbhPlAY0dLKuQxtXc3b8cpVkLl0XNw4ChEuAzOm+ulHI98x
         2+yxfJzfqUp7DzGIZMovktAZGEmp0r7wFkusk+UFuJUQR3gnR+A0me+slZWEx84VpscO
         qwEURoKMXJpezBDpo+jOCjYLS4ScVeMGzPL4rkPkNEz1XQZw7x502MrzbNLBpY5RZSJJ
         Bo9A==
X-Gm-Message-State: APjAAAURcTeEAq9ze03JBAwXrhrZV5Yv2xi4JQyv2kYA1vGuIIttTJ/Z
        9jaNeuNjCj9X3TMM6ijY2hA/u0yLEDYZX2dtNJ8=
X-Google-Smtp-Source: APXvYqzsVOrufjk/bpBWTEquUf03n+s6hD45L+u8uO2soFvUKwQSlbWpSlJvEodmlHhOKCVk4wV4+XgdUWSFlmrmjDY=
X-Received: by 2002:a25:dc88:: with SMTP id y130mr11892785ybe.14.1560941232479;
 Wed, 19 Jun 2019 03:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190618064355.29398-1-amir73il@gmail.com>
In-Reply-To: <20190618064355.29398-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 19 Jun 2019 13:47:01 +0300
Message-ID: <CAOQ4uxiDZjr2+EyjWtimjLxFHrMN13K4N5Aw+9BACPmx+2W6Kg@mail.gmail.com>
Subject: Re: [PATCH] overlay/061: remove from auto and quick groups
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

>
> I did not observe any regressing with check -overlay -g generic/quick
> compared to check -g generic/quick on xfs with recent kernel.
> I did not test all filesystems and -g generic/auto with recent kernel,
> but I am not aware of any expected failures specific for -overlay run
> on generic tests.
>

Oh! I was lying. I *did* notice two regressions with
check -overlay -g generic/quick (compared to xfs),
so I posted fixes for them:

1) generic/504 is failing with -overlay on master.

This kernel fix commit is on linux-next:
6ef048fd5955 locks: eliminate false positive conflicts for write lease

2) generic/555 (was just merged this week) is failing with
-overlay on master.

This kernel fix commit is on Miklos' overlayfs-next:
941d935ac763 ovl: fix wrong flags check in FS_IOC_FS[SG]ETXATTR ioctls

Thanks,
Amir.
