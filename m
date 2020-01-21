Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCD39143A75
	for <lists+linux-unionfs@lfdr.de>; Tue, 21 Jan 2020 11:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgAUKHX (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 21 Jan 2020 05:07:23 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33533 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgAUKHX (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 21 Jan 2020 05:07:23 -0500
Received: by mail-io1-f66.google.com with SMTP id z8so2275207ioh.0
        for <linux-unionfs@vger.kernel.org>; Tue, 21 Jan 2020 02:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LbNrZ+gZVV7IniIQ7VPeUebRBD1PKtuaoCcPZF1Vi20=;
        b=WPHD6yGXsdzAVV5wDRsuC+4p4em05GZmG5bfd9esFbEG0GLWtY1W6pMKp2EKc1pi7A
         6qHGkmzX1pRG79k+2/0oirCaqZAHMMlf9YiOYCfVH4ddrZt3SN0UT5gvhlsy9rgKeU49
         M6SggZTt1U6UUY2Uy9r0pvJCE1xZFhVENKstE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LbNrZ+gZVV7IniIQ7VPeUebRBD1PKtuaoCcPZF1Vi20=;
        b=oXX+i+Kg4DXfyPOs9fZJ9sRwT4nAgip+YER1BUKqGbABqkBavstIxrcO5bTIc7joya
         zwIV27EymnCHEUQi5Nt7i9FQ5bBb0hcChd2HWDm1yvuy6bn721tJ3C0OHU1RB7R57KXr
         4jqirC9bUFepwXhvLpQP1cVRwqJi2YkQ/OfG65dz/IDQfnEAHTWnRRkE85KIyw0bwSz9
         yfbZpN9XH7M/5J1yQrdR7JWWiclVClveSaXTruvLXIAL57gsVW0Mquo+jySPNmqRJXmM
         4vYbyU2GMjSBHI0OAaY7fllbdXNHusIkMUuZwQiTNySyg7fWg+Lrxx/C9ss1TAVMe7jS
         v96g==
X-Gm-Message-State: APjAAAUkxovUQnvQhxQcNrYiLwpb4lyv7HQ8B8LUB6phviO7Le2iHFEE
        z9vfTu8ZPL36fLYvEoqQFCuc6m+1yXOfwwph43R3Dg==
X-Google-Smtp-Source: APXvYqytn4txf5pSNrhHc7gmgIPbGHQQ7uIhi23NWKqGIgIG4I6/oWwH0mUuiEfNTqq/G0aegUUTCXQcJfTYi4pnJUs=
X-Received: by 2002:a05:6638:3b6:: with SMTP id z22mr2573277jap.35.1579601242151;
 Tue, 21 Jan 2020 02:07:22 -0800 (PST)
MIME-Version: 1.0
References: <20191223064025.23801-1-amir73il@gmail.com> <CAOQ4uxh4NygFUFvUp3xs8rZRUkc3SDxO1DL6YrNhx3j0SBgAJg@mail.gmail.com>
 <CAOQ4uxjsiQ5PKYSPLmgk5b5O_e5255+QK8Obgs9K--cTi3z=7w@mail.gmail.com>
In-Reply-To: <CAOQ4uxjsiQ5PKYSPLmgk5b5O_e5255+QK8Obgs9K--cTi3z=7w@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 21 Jan 2020 11:07:10 +0100
Message-ID: <CAJfpegtcpqhiOqbdCCEz5_h=2WbYDWvLihAUYPC9KkB-uCmDbg@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix wrong WARN_ON() in ovl_cache_update_ino()
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Jan 21, 2020 at 11:04 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Jan 6, 2020 at 8:35 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Mon, Dec 23, 2019 at 8:40 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > The WARN_ON() that child entry is always on overlay st_dev became wrong
> > > when we allowed this function to update d_ino in non-samefs setup with
> > > xino enabled.
> > >
> > > It is not true in case of xino bits overflow on a non-dir inode.
> > > Leave the WARN_ON() only for directories, where assertion is still true.
> > >
> > > Fixes: adbf4f7ea834 ("ovl: consistent d_ino for non-samefs with xino")
> > > Cc: <stable@vger.kernel.org> # v4.17+
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> >
> > Miklos,
> >
> > If you have time, please send this one to Linus for v5.5.
> > It is a simple fix and the only one causing failure in the new xfstests [1]
> > that I posted.
> >
>
> Gentle nudge..

I'm working this into the next batch bound for 5.6, unless something
more urgent comes up before that.

Thanks,
Miklos
