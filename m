Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF563BC21
	for <lists+linux-unionfs@lfdr.de>; Mon, 10 Jun 2019 20:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388872AbfFJSv6 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 10 Jun 2019 14:51:58 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34035 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388544AbfFJSv5 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 10 Jun 2019 14:51:57 -0400
Received: by mail-yw1-f65.google.com with SMTP id v189so4202482ywe.1
        for <linux-unionfs@vger.kernel.org>; Mon, 10 Jun 2019 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AcvsIzRWeXTiSyoqYtOf4WdTdruyzP9Domc7rCPHoh4=;
        b=nEBdd9H3vufqG4Uq5fwJxUWLP0xVVS8VjzWKVocisGTdjXfGA122U6JsG1q8atbPxo
         0dF+QIUfp/C2eO/aWr+11y+6iTNm6pYSAS2qgTpiWrUVDylAbYgMuNEKuveRbWR4qFvQ
         a1ZXa9KVfruemuvSABlg1ygx8FW2ivJTOx7Zq3kPhXI1vKISYAjfouju7pg8WJgMtR60
         wYj6zFya9V23RJ3t7RgkNJKOMK3Y+Xa2HP7yHtcQaYrLk80W2PMz/uxlIC04YzOoqvrr
         5TduzxLcQa2zHaCNrH5zo3AIAEKnVN6fttav6abVdjaak0+qJSi5/OmlGb2AzlSS13Ym
         rcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AcvsIzRWeXTiSyoqYtOf4WdTdruyzP9Domc7rCPHoh4=;
        b=p2PXTqlarISPA3oyObFPodzGeypkCxrxb4TMdTxF7WOTHRImfaGvpWo3NI9PqJXSW+
         81BgZSL7XfOzseWSZsBw7GmQzH07/k3jeQGRuQUffrUCpZJ5RyWhqAqRzeL4RA9R3jwc
         o/f8Vp0bZIEWOVOb8asZwhfCdLIrc2xl0JqFn1tEPdXA9RFJt625LP/F73MGjxI9fETu
         UuIOK576yi39NgcoxgaEoMZ8JIMcrmsY/ItnWgoobcv/nrPTn+aRfd6ag3JoVnkW6NFl
         jJNjeZNrP9D8Ka9+1ury/C4ZUOeA12GtkLsho2CbcFtrxKDqH9F5wW+B0QUaSgyIi7Nf
         oIwg==
X-Gm-Message-State: APjAAAUq1ulTOUhWhu4I1FEMEClPPZ5qMn8mpN4DN4PQKVINLajj6/kN
        jL6W7Ohp0CRXGkQbUpgVinNKlREKgvk4bY5gQWT+dg==
X-Google-Smtp-Source: APXvYqzdUP5z6Gbsaq3lq1TnfZ2oGwFd4VpPgk7Q9G2CAdPo7jR3Q1Ad1mRYqUi1eBw2buvQE2oMRKI5y9d3TubtbN0=
X-Received: by 2002:a81:13d4:: with SMTP id 203mr7175787ywt.181.1560192716389;
 Mon, 10 Jun 2019 11:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190607010431.11868-1-mcoffin13@gmail.com> <20190607205105.21858-1-mcoffin13@gmail.com>
 <CAOQ4uximPqsNivkqD36LdNfT4g41v2rtDm+OB6t2z40dpWs_og@mail.gmail.com> <20190610183053.GA29869@redhat.com>
In-Reply-To: <20190610183053.GA29869@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 10 Jun 2019 21:51:45 +0300
Message-ID: <CAOQ4uxjf4nbPbAdbn3wGcJSKQJ7nTdHu_XpjM7zv5iW52G3M4g@mail.gmail.com>
Subject: Re: [PATCH v2] overlay: allow config override of metacopy/redirect defaults
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Matt Coffin <mcoffin13@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Jun 10, 2019 at 9:31 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Sat, Jun 08, 2019 at 12:04:54PM +0300, Amir Goldstein wrote:
> > Hi Matt,
> >
> > Thank you for trying to address this, but I see problems both in Why and
> > How you did it.
> >
> > On Fri, Jun 7, 2019 at 11:51 PM Matt Coffin <mcoffin13@gmail.com> wrote:
> > >
> > > [Why]
> > > Currently, if the redirect_dir option is set as a kernel or module
> > > parameter, then even if metacopy is only enabled config, then both
> > > metacopy and redirect_dir will be enabled when one creates a mount
> > > point. This is not desirable because /sys/module/overlay/parameters will
> > > still report that redirect_dir is not enabled
> >
> > /sys/module/overlay/parameters reports that redirect_dir is not enabled
> > *by default* not per mount.
> >
> > > and there will be no redirect_dir=on line in the mount options in /proc/mounts.
> >
> > That is a bug. This code:
> > /* Automatically enable redirect otherwise. */
> > config->redirect_follow = config->redirect_dir = true;
> >
> > Needs to update of config->redirect_mode.
>
> Hi Amir,
>
> It took me a while to understand what's the problem. So IIUC, issue is
> that kernel has enabled redirect_dir by default. But it was disabled
> using module parameter. But it was enabled again as a side affect because
> metacopy=on was passed as mount option. And /proc/self/mountinfo does
> not show redirect_dir=on and hence the confusion.
>
> IIRC, once you mentioned that we only show those options which needs
> to be specified if same mount has to be reproduced on different machine
> with same kernel/module options. If yes, then setting
> config->redirect_dir=on is not needed because passing metacopy=on will
> ensure that.

I agree it is not a must fix bug, more of a nice to have.
In all other similar cases (actual differs from module param value) we would
have presented the option in /proc/mounts. It is only because redirect_dir is
not consistent with redirect_mode that we do not.
This seems inconsistent and hence I called it a bug.

Thanks,
Amir.
