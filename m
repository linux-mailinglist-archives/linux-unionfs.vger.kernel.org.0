Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC073CDCE
	for <lists+linux-unionfs@lfdr.de>; Tue, 11 Jun 2019 15:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387856AbfFKN6t (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 11 Jun 2019 09:58:49 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52278 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387966AbfFKN6t (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 11 Jun 2019 09:58:49 -0400
Received: by mail-it1-f195.google.com with SMTP id l21so5063747ita.2
        for <linux-unionfs@vger.kernel.org>; Tue, 11 Jun 2019 06:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rck34IKBXxtoHj9es4Ou084gbPV4EZ4/MCaqtYNr9fg=;
        b=XaYBib+fKTxOoYk9pTHGKo6uqBPnbwmBi/eWiHEoXsBBEXrJeFH0pW7y+vtEwPVVkv
         1ShcSHGWCniFGxXCKygN6jsGtDA+DOUYE46KaLhS9zKRFg21AJ1lAKGzBEpmKnnMaVsO
         d/ybaEfaF6hqEiVBXHJuEgicjWevmupnTW9l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rck34IKBXxtoHj9es4Ou084gbPV4EZ4/MCaqtYNr9fg=;
        b=JsmHA3mI1xLHqAYHe7sAbJIU/rotTfJFiPPSS6ANtFe2Se5nPdRSndR3DV2JDYdwV7
         lCfMZtZ7maeL0Rd5gf7fXJ891tWZ11Kj2bS2PMv5E7tX0fqFcWlZazlvQNDZDg/ZVlHT
         8vFyBy/tj+6S4Xmc6H6xfBAVhKaspSMDB73cx7U6EswBtJxrvQ9fWZINJdr0squBqXjg
         D07ozvwqgwT2Ltj4xMNIcRz0tYEiJbmS0uwrEZgF+THK6AmdMFQv+HU7m/lO/6lNiyO6
         S5N/wxSUE6Xbc+X86wGA1zMN9yEaTtvV4OglitbJ+qT8sUOQmIPBSlWcSAtGN28VoRsC
         UeHg==
X-Gm-Message-State: APjAAAXtUcbU0Anwbvwx2LsofYSTQTI6JEdQqECO66T8gVJ88CqIwaq2
        CrnpIfZfz50IcTiD+2dvHtZOfKAbIugiQ5ZjW4JM65rd
X-Google-Smtp-Source: APXvYqxX60RMSkL4RHF9vyDwsgvMsG9kC5AZ+EWQ/EVpPuyeHVoqUsM99NfLsNQE8eTU+YLPVJukxoFBzXExd84E7eg=
X-Received: by 2002:a24:2846:: with SMTP id h67mr18758658ith.94.1560261528469;
 Tue, 11 Jun 2019 06:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190609160344.24979-1-amir73il@gmail.com>
In-Reply-To: <20190609160344.24979-1-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 11 Jun 2019 15:58:37 +0200
Message-ID: <CAJfpegt4QXGC0-y_sug7kuFo2q28c6DFJQnQ-UHe1bmCGC0jag@mail.gmail.com>
Subject: Re: [PATCH] ovl: make i_ino consistent with st_ino in more cases
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Sun, Jun 9, 2019 at 6:03 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Relax the condition that overlayfs supports nfs export, to require
> that i_ino is consistent with st_ino/d_ino.
>
> It is enough to require that st_ino and d_ino are consistent.

Yes.

>
> This fixes the failure of xfstest generic/504, due to mismatch of
> st_ino to inode number in the output of /proc/locks.
>
> Fixes: 12574a9f4c9c ("ovl: consistent i_ino for non-samefs with xino")
> Cc: <stable@vger.kernel.org> # v4.19
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Miklos,
>
> TBH, I can't remember why I put the s_export_op condition in the
> first place (can you?), expect for the fact the original bug fix
> was reported on nfsd readdirplus.

I have no recollection of any issue that would require nfs export.

I've applied the patch.

Thanks,
Miklos
