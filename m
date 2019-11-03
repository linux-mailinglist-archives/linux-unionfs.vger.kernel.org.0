Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5DABED39B
	for <lists+linux-unionfs@lfdr.de>; Sun,  3 Nov 2019 15:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfKCOqS (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 3 Nov 2019 09:46:18 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42663 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfKCOqR (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 3 Nov 2019 09:46:17 -0500
Received: by mail-yw1-f66.google.com with SMTP id d5so5948233ywk.9
        for <linux-unionfs@vger.kernel.org>; Sun, 03 Nov 2019 06:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hvlVWK1YMoJu0v37BEI7D8aK589YlkCCq6L2tmESap4=;
        b=d4xwUifVjPxHwGEhqYC5q6uQcOXBc0Xh2Ab/wg+60xFjV+8GG9nzKZsZFB6oINjeho
         pCsB0IaXHlBQYUFwIvdAkcWEBLXWAm9dERQY616oSfg3kOVF/W6jZ06Dvzm+B6ekkcPe
         I0sx1jB00kj1rzo3CpnpjWrmVERCBFGIl1h9aSBqa2QV5mdNeQF/zGk8HtNwgmHJZveI
         oYbRUtSJA0po84tIbsynqwKyes333tMhrhXnqZa6/IKg7xrrMt7uHd/iqMpQWmyV4PoX
         2aSF7DZjHOpiGaLzk2bZqlKI9/j7G5Ahxh7gzL4qsH3SvU5nRPsTKAihYClaELkWzv5X
         xblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hvlVWK1YMoJu0v37BEI7D8aK589YlkCCq6L2tmESap4=;
        b=g1ve813XQjYR4oBiaJ3sra3m9qaxtEQ+RFz7OLM6Kz4Raa/FqtlUWlvTlYGhrf/Daq
         D7psXMXDMfdVDTUXjVkSpzOfjvZpsZc/UggfsexHOCMo9EfmbYCH/37glI8EEMMnnr5j
         MdTl/+vBNsGVhq45cXQ+RRz16c1FeLdodiARZk1jHy+jbTBHJOC9P/UJUSLU85hT4IFC
         mr7f/Z0GLrEPa7zBTT4O44TbOqyWH9BkOEMRMYBHO/ty1isSRovUzBHnF0jGsJVp/7AX
         iLf0Ul0wfA6Tu8CNAGN4CX1xySrx3O3xRSNo3ixRNSOexOVRTQODONjcXa+wmR9fh4XP
         X4Hw==
X-Gm-Message-State: APjAAAW27Mf9qojdgYeBq9ikHHDbr5hIrWyJmvbVMO9qMVqbMC2uoRJe
        R5539BhVdaQXFMdVZryy+XJkixDZnoe2E2N9ci8=
X-Google-Smtp-Source: APXvYqynNHeYvZnk381A/B3cD78O2x3urYG9Dbxtj5Fc55MgalHqsIz++QHyGlTUD0omGaEwJddbclZdg/HuO7PcRAc=
X-Received: by 2002:a81:4a02:: with SMTP id x2mr16952844ywa.31.1572792376801;
 Sun, 03 Nov 2019 06:46:16 -0800 (PST)
MIME-Version: 1.0
References: <20191030124431.11242-1-cgxu519@mykernel.net> <CAOQ4uxh670WFhwpQyPFTB2nUCSc9n1VmuyPOfdqiBSsq6GxLpQ@mail.gmail.com>
 <16e204de70e.cefd69461771.2205150443916624303@mykernel.net>
 <CAOQ4uxhdSXAvFQfhzZpBC=Xmmo9y+3AOU1o-tOWsLtr2ntU6Ag@mail.gmail.com> <16e314ad3bc.f4c363d96385.3761437052169638038@mykernel.net>
In-Reply-To: <16e314ad3bc.f4c363d96385.3761437052169638038@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 3 Nov 2019 16:46:05 +0200
Message-ID: <CAOQ4uxj-hOu+TjGhUqgSbPocnZy=JDO62d6-FJC=raU6WkRvfA@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: improving copy-up efficiency for big sparse file
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Sun, Nov 3, 2019 at 2:43 PM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2019-10-31 14:53:15 Amir Gol=
dstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
>  > >  > Yes, overlayfs does not comply with this "posix"' test.
>  > >  > This is why it was removed from the auto and quick groups.
>  > >
>  > > So I'm curious what is the purpose for the test?
>  > >
>  >
>  > This is a POSIX compliance test.
>  > It is meant to "remind" us that this behavior is not POSIX compliant
>  > and that we should fix it one day...
>  > A bit controversial to have a test like this without a roadmap
>  > when it is going to be fixed in xfstests, but it's there.
>
> I haven't checked carefully for the detail but It seems  feasible if we c=
opy-up lower file  during mmap regardless of ro/rw mode.
> Is it acceptable  by slightly changing copy-up assumption to fulfill POSI=
X compliance? Or we just wait for a better solution?
>

That was attempted in the past.
It's complicated ;-)

Cheers,
Amir.
