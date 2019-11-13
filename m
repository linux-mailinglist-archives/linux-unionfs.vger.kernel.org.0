Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E687BFAE6B
	for <lists+linux-unionfs@lfdr.de>; Wed, 13 Nov 2019 11:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKMK00 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 13 Nov 2019 05:26:26 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44129 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfKMK00 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 13 Nov 2019 05:26:26 -0500
Received: by mail-io1-f66.google.com with SMTP id j20so1902347ioo.11
        for <linux-unionfs@vger.kernel.org>; Wed, 13 Nov 2019 02:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AShlT2NMuDzRkz8rOdqEHOGvn4UNwyVi7xeYItaRgrA=;
        b=NhuETSqrfqHDbGzgpPIaNKNagTdOgUz32ujfB+c45DjadHYYQJvlAZ0XGAK1X/MSBl
         66+GUNJsKic9x/G6mo1Yi0+Nn0H8kg1J79Ukw2oKQD2YcAMngWotLGI+NrIsgZT44tuR
         oOlAEDoYFwa0URw4W1STQQepzlm/PDv5FgR+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AShlT2NMuDzRkz8rOdqEHOGvn4UNwyVi7xeYItaRgrA=;
        b=QvfONSc9BQBfvV/QgWLdIWUhDS63t3moUFcS+ahgQXq3Yjkm9Djk4KkTj+B5s576FY
         cpHDBPFdtzLGihQIynteGR0VzFU6/+3FB8u0UBSDW0K+WO7lpt5RXAWWJz7NsUcLhfP0
         6hTF8vy5uqpROUFJMEol4T1jrHXjX9mbqKt3tnA5NdLwBBTkCklTUmhO+2JPkaoA9xih
         qVF50JsFAQt0V7/7o7U239vygWiVZ7CIBXsPT+JH5TCJy7sgQ+OLQGqO2sEM8L5R0xQs
         xv4d4iXlGgdN+pzOQsTW809JxcIAAUvz0gDU5UZv0XAPybhnfCCn7wqaevdzPZ9Vm6rb
         cX2A==
X-Gm-Message-State: APjAAAXdepygdqLwzEwmowav8Rvt0GufOjsR5eSI6/reXqOJGBWHeNWj
        p0Dhdb0b4civ80MJp9jVI9c97OVVFv1gpX6gzEUfvA==
X-Google-Smtp-Source: APXvYqyMHNP4A1goS5VZQeC36febOXqlyFVvxXyFyHq1h1A/RgrbDZjRFAoroTPCP1PYc7PXGpXyUVfdyUk9ETlPA8o=
X-Received: by 2002:a6b:b296:: with SMTP id b144mr548532iof.63.1573640784042;
 Wed, 13 Nov 2019 02:26:24 -0800 (PST)
MIME-Version: 1.0
References: <20191111073000.2957-1-amir73il@gmail.com> <CAJfpegvASSszZoYOdX9dcffo0EUNGVe_b8RU3JTtn-tXr9O7eg@mail.gmail.com>
 <CAOQ4uxhMqYWYnXfXrzU7Qtv8xpR6k_tR9CFSo01NLZSvqBOxsw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhMqYWYnXfXrzU7Qtv8xpR6k_tR9CFSo01NLZSvqBOxsw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 13 Nov 2019 11:26:13 +0100
Message-ID: <CAJfpeguvm=1Dw7V4XTr4gyo3uK+-EFNYKeDCFvUmuMPJxA=TcA@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix timestamp limits
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Nov 12, 2019 at 5:06 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Nov 12, 2019 at 5:48 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, Nov 11, 2019 at 8:30 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > Overlayfs timestamp overflow limits should be inherrited from upper
> > > filesystem.
> > >
> > > The current behavior, when overlayfs is over an underlying filesystem
> > > that does not support post 2038 timestamps (e.g. xfs), is that overlayfs
> > > overflows post 2038 timestamps instead of clamping them.
> >
> > How?  Isn't the clamping supposed to happen in the underlying filesystem anyway?
> >
>
> Not sure if it is supposed to be it doesn't.
> It happens in do_utimes() -> utimes_common()

Ah.   How about moving the timestamp_truncate() inside notify_change()?

> clamping seems to happen when user sets the times,
> so setting the overlay limits to those of upper fs seems
> correct anyway.

It does seem correct, I just think moving the truncation into the
right layer would make more sense.

Thanks,
Miklos
