Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB8A0F94AE
	for <lists+linux-unionfs@lfdr.de>; Tue, 12 Nov 2019 16:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfKLPsi (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 12 Nov 2019 10:48:38 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:33710 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfKLPsh (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 12 Nov 2019 10:48:37 -0500
Received: by mail-il1-f196.google.com with SMTP id m5so15978161ilq.0
        for <linux-unionfs@vger.kernel.org>; Tue, 12 Nov 2019 07:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQYYs5gP58q9NKDR4KDDpcN53ACGcO4dfBpm0LTurb0=;
        b=Zx2pkcDqRCOK9AjzSsxr22sfDJCYVJlHi21Mrs2n3uzUB4lqOh8TNtQQ3isohXY9Sm
         JKUyP983sjtQTcq76LsF7/6stNhcfwzibwHGe5kLZvPWoIwLWo1EBzaGQJzv9L9JsNN/
         CLXd5wnQY+SGd/+9fEjVUkwGmyw9H91bvrG9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQYYs5gP58q9NKDR4KDDpcN53ACGcO4dfBpm0LTurb0=;
        b=nq7hFWar9i8gsOC5rHCV/biinvriZE29X6pUkXVVx65d1xIloXCj5aQLJ74x5FnyUP
         K+GCnUiO3ecSzAsvKTMU+X7kAVvRX7g3LXC9IQi6OWzmd+SoizByXrqyNfvflah0naDs
         vyH1tRyqEkpl3okXnvVOne5/7pQ7gVX4Cdx994QPBULx9vJKF1zlVwoeGzGiYG3wnGpE
         f16K6QNNm06O7nKH4GFmmQGj8S4t8NjNnM531jL+zqBwD1yYswzwbflNS/wRFfKAysaq
         s+GuAw2spSdWFK60UG9vi7yLSiYQKgZGEI8xG3RObL4XY2GjTK6jBZpDUrH8ylPVRXh3
         ISXw==
X-Gm-Message-State: APjAAAXQJMXHgpEGbqiZow1q/w0PQcN5MwqDqNn88J3DORPUwAoBRVWH
        Rt4xMq0ueGOc9pzGavudCeAL96+ppdWoq7Q0tzGe3Q==
X-Google-Smtp-Source: APXvYqz5NlEKVCU0okosLPppCrqys6PzYIZg+HlU/XQ1CXQueeA9XcUGtwWGaC1lV2H6WtCRUSs1tPh/+iZIQTlVcy0=
X-Received: by 2002:a92:6407:: with SMTP id y7mr8965398ilb.285.1573573715886;
 Tue, 12 Nov 2019 07:48:35 -0800 (PST)
MIME-Version: 1.0
References: <20191111073000.2957-1-amir73il@gmail.com>
In-Reply-To: <20191111073000.2957-1-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 12 Nov 2019 16:48:24 +0100
Message-ID: <CAJfpegvASSszZoYOdX9dcffo0EUNGVe_b8RU3JTtn-tXr9O7eg@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix timestamp limits
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Nov 11, 2019 at 8:30 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Overlayfs timestamp overflow limits should be inherrited from upper
> filesystem.
>
> The current behavior, when overlayfs is over an underlying filesystem
> that does not support post 2038 timestamps (e.g. xfs), is that overlayfs
> overflows post 2038 timestamps instead of clamping them.

How?  Isn't the clamping supposed to happen in the underlying filesystem anyway?

Thanks,
Miklos
