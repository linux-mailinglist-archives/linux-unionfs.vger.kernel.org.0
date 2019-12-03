Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C382A110001
	for <lists+linux-unionfs@lfdr.de>; Tue,  3 Dec 2019 15:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfLCOTk (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 3 Dec 2019 09:19:40 -0500
Received: from mail-il1-f179.google.com ([209.85.166.179]:36844 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfLCOTj (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 3 Dec 2019 09:19:39 -0500
Received: by mail-il1-f179.google.com with SMTP id b15so3321702iln.3
        for <linux-unionfs@vger.kernel.org>; Tue, 03 Dec 2019 06:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zgQs0+/wVB33/qB4I+ui0oRVVR3x0wd1D/9RRHjxplc=;
        b=HzfTxMZtXTdteqsZmbJEpD8VaVG5XgUtWSaDs1VG0i1d0749Gg9hJLMDkUxfBQSyTg
         Wy62ulgq75sFax1v6MsTzeXysUZhk0jfz8B6LjxFg+X21lR/zjLG/bR3R91n62Ews3cL
         YjLjHkLptrE6Oe1OClSUT9YnNa/LdEaulvCnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zgQs0+/wVB33/qB4I+ui0oRVVR3x0wd1D/9RRHjxplc=;
        b=YixMZLigUvTtvoN3FL4RpKMGN3sZPFTNIEoZY28QSxnt3xqeBRfbe56sB6vJYCgmNt
         9EO/imvg/tX181NadHcLPDQ716/vM25ozYegY8cWTyLkS0qh1JzqMhvZqqf1BWT4swJM
         Wtnr1qwWvgTrITddcD/bOtiiVKQSlLI3/5SBiL8UoNDGBEInTg7IZ6cG+pQoN/+qO510
         AJtarWVittS+9TjtPtt42bVtO4StANZHDKZZ09p4lriKmukutjt+vjHpyqreUo9IW4Qe
         PaWavVc0Ok+XC8dV8tajaRpWW+nZLoiMl1jRP4el0i5CDMfxnRqjMzGly7qrOGJG9cmK
         DlvQ==
X-Gm-Message-State: APjAAAXZoKZUE8n1CKfWh4ouu/bn7GjWdd8dV6eqeZRw2yQN5ZEnXMDx
        vnjbcUzN44alwKvKJMvt8tMAx2Y/v8jsEfTPDX5Uaz/+
X-Google-Smtp-Source: APXvYqxoXRjHoISOeJnzk3DxSN0qv0NBtgmua1Mz4QCRJrTgGwdEaN/vwI09F7SelszphUTiT+jZBKp39QzIHWDGqPU=
X-Received: by 2002:a92:320f:: with SMTP id z15mr4944305ile.252.1575382779234;
 Tue, 03 Dec 2019 06:19:39 -0800 (PST)
MIME-Version: 1.0
References: <7817498.QaoxCVBQX0@linux-e202.suse.de>
In-Reply-To: <7817498.QaoxCVBQX0@linux-e202.suse.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 3 Dec 2019 15:19:28 +0100
Message-ID: <CAJfpeguBxP7QPSr9UO6yzPpWHJ+fAckozQ823u5hPY76kqYjSQ@mail.gmail.com>
Subject: Re: overlayfs does not pin underlying layers
To:     Fabian Vogt <fvogt@suse.de>
Cc:     linux-unionfs <linux-unionfs@vger.kernel.org>,
        Ignaz Forster <iforster@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Dec 3, 2019 at 2:49 PM Fabian Vogt <fvogt@suse.de> wrote:
>
> Hi,
>
> I noticed that you can still unmount the lower/upper/work layers, even if
> they're currently part of an active overlay mount. This is the case even when
> files in the overlay mount are currently open. After unmounting, the usual
> effects of a lazy umount can be observed, like still active loop devices.
>
> Is this intentional?

It's a known feature.  Not sure how much thought was given to this,
but nobody took notice up till now.

Do you have a good reason for wanting the underlying mounts pinned, or
you are just surprised by this behavior?  In the latter case we can
just add a paragraph to the documentation and be done with it.

Thanks,
Miklos
