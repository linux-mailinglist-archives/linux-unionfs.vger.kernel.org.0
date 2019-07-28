Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A87177F09
	for <lists+linux-unionfs@lfdr.de>; Sun, 28 Jul 2019 12:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfG1KSM (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 28 Jul 2019 06:18:12 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46824 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfG1KSM (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 28 Jul 2019 06:18:12 -0400
Received: by mail-yw1-f66.google.com with SMTP id z197so21718833ywd.13;
        Sun, 28 Jul 2019 03:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=62jDGnY8hc3nhk5QSAC/u0qK/rfRnSg5aqPR8GX4jrk=;
        b=U+YNFDZV3p4LM85FEqMdJODAJ1tc5/RZ/FqClmDwDFwnekNQWUyw+T8kvCqrYXXmCe
         XkhVC/O2Zx7IZTIq2yQg9OmZvXFd9RAUSPzam7MQPYGX0inud9iuakzkVTvXF5HaXIOr
         RKdY76SZkRyWzYsiZYp2C9IF/xv70LBA0ZsJs6f04NYZdabdAgaQw4HEEZRxkr2KaaAo
         3/vM4ZRpvAPn5MESQ0QbP7e7DqqrWoFAOYnFIyqFh+HcCjMJO3j+t56LF2uTeGS5F6Jz
         P9iLI74iBS651S+RaSipCsoqRVQJ4KiltdAy5wvoN/CH8uIVunW1l+eqG5vO71iPo2D/
         ioPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=62jDGnY8hc3nhk5QSAC/u0qK/rfRnSg5aqPR8GX4jrk=;
        b=B8Ab589wMA/wROH1FsDzh6pI51Z1n0HDlPieLa2XVCvpRdX9BJmsy3uY8Byy+V0W5l
         kgLcq28dmxQJ59rYSdE2McmSZYJqe/FdHPIjELKbJsXIYDKgz0fatBOI09sCWXnUOHEJ
         kzo+kjRNPlC10hll8hBJ89PLXlluns5WXEDK3i93JTgWtRRUbSwpSO9z/yjcao9LL2XO
         j7/yck4A7cd8m7JKdOmaRTngEN7+bfz27Cyegw7eu8bzu5ndM+jtJ86jG81Z0YjLpcqA
         07KWWFB67vM75MHZJXYKQEV2bIiRYsW+HJRh+AvFnzcka8vG4/WnSwuNecX7hAJsswhy
         9qEA==
X-Gm-Message-State: APjAAAUnsTCaJD5V8brW+4VfSa78C9uI0eLUBesD/3ynWSbyullXWhgm
        m//P8mfhukURT9A3GQjBveNcOVJaSKaR8wdpsWM=
X-Google-Smtp-Source: APXvYqzjzsJ4WqVKHDIHjl3Cp9Hj0T1gzopY2FH2wPph3RY6R6IjHXzZgujTTAwlt3TdtcyXo825FISbOnZUOl6alTc=
X-Received: by 2002:a81:49c3:: with SMTP id w186mr62565061ywa.31.1564309091099;
 Sun, 28 Jul 2019 03:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190722050227.24944-1-amir73il@gmail.com> <20190728090440.GL7943@desktop>
In-Reply-To: <20190728090440.GL7943@desktop>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 28 Jul 2019 13:18:00 +0300
Message-ID: <CAOQ4uxihwO++86biDc_vLQ+iXV10=G-Uc7ofTw8db_pdt11Wxg@mail.gmail.com>
Subject: Re: [PATCH] overlay/065: adjust test to expect EBUSY only with index=on
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Sun, Jul 28, 2019 at 12:04 PM Eryu Guan <guaneryu@gmail.com> wrote:
>
> On Mon, Jul 22, 2019 at 08:02:27AM +0300, Amir Goldstein wrote:
> > This is needed to support the kernel regression fix commit 0be0bfd2de9d
> > ("ovl: fix regression caused by overlapping layers detection").
> >
> > Overlayfs mount is not supposed to fail due to upper/work dir in-use
> > by other mount unless option index=on is enabled.
>
> Sorry for the late review.. Looks like this patch only mount overlay
> with "index=on" explicitly, but doesn't check that mount succeeds when
> "index=off", which is really regressed. Do we need to add more
> "index=off" tests to ensure we allow re-use upperdir?

Agreed!

Thanks,
Amir.
