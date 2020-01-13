Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9B91393C8
	for <lists+linux-unionfs@lfdr.de>; Mon, 13 Jan 2020 15:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgAMOio (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 13 Jan 2020 09:38:44 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:42928 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgAMOio (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 13 Jan 2020 09:38:44 -0500
Received: by mail-il1-f196.google.com with SMTP id t2so8321431ilq.9
        for <linux-unionfs@vger.kernel.org>; Mon, 13 Jan 2020 06:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sqyPK7WhCbrPtkh7KIrmwoyNB45GHMdR4ucMCWu4Bzk=;
        b=fKPKiwPo+j8tB3iH8ZLIg5kS/G8zqZqvk+/C3oNfMEBNW0TEKwtQliA9kf3V0ay/DL
         xEhy0eTnlqMBdVOFTc975r50WUgtLn0bnxlbIxrJs+DbsIcwZuUYTVVnNYUh0npFtmHN
         j6fJ3WVNSuGvk4tE/L2IPfSRTbvhqb7q0hRwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sqyPK7WhCbrPtkh7KIrmwoyNB45GHMdR4ucMCWu4Bzk=;
        b=mkIiC0TTcWBQoKCYjQKCb/Bm0mqdtFWvXX1lZXWIoyGFaq2/b4y2MmKw9MkUXNzCGR
         dtbbgX6E+h1DLZ9+NFXbqqxCCoIQ11tUuQjYp1sUyfFQ3lEDGCpwXOsyx/nFKtmgfUIz
         r38N6IjzTYViO40qqF8Is+LNNox3nZMxgcqebLlBnNuC3coYzLQnH4tuXdJVJFySQC/7
         by0hRJdQgrE3UbRO3AURgaMV1TK6nbvrxL3KyGkDD3WXymPt179a7jpv4Il6F1GcoB1K
         fsdoWcN550djDtX4rFsjE3jlcvLPRv7HnKSlzXMz//M5VhtodKmqmlDc9SbpB3+qocHa
         uOcw==
X-Gm-Message-State: APjAAAULUzL6ycW84RILQuxImePUQBSo25NPjAzn4w7xHVzDMj83EwHp
        qi2bfNSWEUKCBw4W84DEBTNMbcbRGZbwNw7ieiUsIX45+zQ=
X-Google-Smtp-Source: APXvYqzbFcHNlq6C3fKe5Bb1bIMw8GwCq9K8ZaejyC2ZF83AaWjp3nUktk2xGauD1fFe77OX5EP1SG3+0Ylfvg+eQAg=
X-Received: by 2002:a92:c703:: with SMTP id a3mr13776778ilp.63.1578926323548;
 Mon, 13 Jan 2020 06:38:43 -0800 (PST)
MIME-Version: 1.0
References: <20191222080759.32035-1-amir73il@gmail.com> <20191222080759.32035-3-amir73il@gmail.com>
 <CAJfpeguNywFLtpETg1oVpLnjkMP=DPZU3Fjvvb9aumRvTXBwtw@mail.gmail.com> <CAOQ4uxj8yewBzot0_Hu2OwNWMH=M_yGf_wtsCJn9UkwJARs0SA@mail.gmail.com>
In-Reply-To: <CAOQ4uxj8yewBzot0_Hu2OwNWMH=M_yGf_wtsCJn9UkwJARs0SA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 13 Jan 2020 15:38:32 +0100
Message-ID: <CAJfpegvpQXzEpZUrrNLMt=2Bs_ykx9RoV+hXfKF_33ybo4-HPg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] ovl: simplify ovl_same_sb() helper
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Jan 13, 2020 at 3:31 PM Amir Goldstein <amir73il@gmail.com> wrote:

> OK, I understand why you don't like it and I think is makes sense to
> have an xino_state.
> However, xino_state and xino_bits are quite redundant.
>
> If we change:
> unsigned int xino_bits;
> to:
> int xino_mode;
>
> It can take the values:
> -1 /* not same dev */
> 0 /* same fs */
> 1..32 /* xino_bits */
>
> And:
>
> static inline unsigned int ovl_xino_bits(struct super_block *sb)
> {
>         return OVL_FS(sb)->xino_mode > 0 : OVL_FS(sb)->xino_mode : 0;
> }

Okay.

Thanks,
Miklos
