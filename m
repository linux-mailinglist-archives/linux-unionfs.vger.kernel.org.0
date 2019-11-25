Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7031090CD
	for <lists+linux-unionfs@lfdr.de>; Mon, 25 Nov 2019 16:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfKYPON (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 25 Nov 2019 10:14:13 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37319 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbfKYPON (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 25 Nov 2019 10:14:13 -0500
Received: by mail-io1-f67.google.com with SMTP id k24so5971483ioc.4
        for <linux-unionfs@vger.kernel.org>; Mon, 25 Nov 2019 07:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ALu9igSRSsKi52hn+f9OyAjdyB0mBhNXe9BnXNqIOe4=;
        b=Uhh7wOIqPQR81MSbRooLEt8qyy+07qluJoDtNGDtuedJKTsKjd14fVckV+hyDQmbo6
         78MPzzDXsUkzjxgRhAEm9siOrRhNZUiy8r2DTW7OWcdnHo7YHAbfbIO7lH/4mUPXSThw
         yCn+Oo5iRpC87zL2LqOdI1JCfz+ssecH+ma6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALu9igSRSsKi52hn+f9OyAjdyB0mBhNXe9BnXNqIOe4=;
        b=jTDTAx1nc2HAyFakWnw0yZxHNh+9zjJiX9Y5yvRv7xCq/ajUoLMrSqiHzi69S0Lmbv
         bj3xnTo/umA+XSaBjVYba/eSSExtLf5MQbXH4msOG7NGwXa8Pg32MV0zSwsogsswnVK/
         pjNAtA6+fo+cZ1wZc8RX5julEHRySKjiPeKhG+UoS/Jj9T07z4p/NEIK71LaetoAAaw+
         wvksKi3vnBEWxKB28RvOkKt1Fh6hnXr+EyIkdTEzMn01iuHnbhaDCiUgjhF1lBgJIRv+
         TeXvOZ77n7tfUHyDjQYHSbZ3wTgupmTFjMf5uvkZljrUxK6Syp2sg/Qc88axIHMbyD11
         B4lA==
X-Gm-Message-State: APjAAAWAA+WWE3jxklbOs+gGjF0ZuxMWslxURRkbqF0ZIZv+EeDDscjD
        dfajXvFyaATzbdzuP6YvjSvylo8ZbucptjJugdyvYA==
X-Google-Smtp-Source: APXvYqymUw8TAznCvAM14YFrTvY36Km1p/Eylp7nwOHjzN72m1nqZQk+qCIweSmRGc14oNLOCMmjpk2sZSwXjZnmUyo=
X-Received: by 2002:a5d:91da:: with SMTP id k26mr26131450ior.252.1574694852323;
 Mon, 25 Nov 2019 07:14:12 -0800 (PST)
MIME-Version: 1.0
References: <20191025112917.22518-1-mszeredi@redhat.com> <87r231rlfj.fsf@x220.int.ebiederm.org>
In-Reply-To: <87r231rlfj.fsf@x220.int.ebiederm.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 25 Nov 2019 16:14:01 +0100
Message-ID: <CAJfpegt_haMDwd6jo3mQzX2vchk_LLMH+V+h4yDs7geLmo4NhA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] allow unprivileged overlay mounts
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Fri, Oct 25, 2019 at 3:43 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Miklos Szeredi <mszeredi@redhat.com> writes:
>
> > Hi Eric,
> >
> > Can you please have a look at this patchset?
> >
> > The most interesting one is the last oneliner adding FS_USERNS_MOUNT;
> > whether I'm correct in stating that this isn't going to introduce any
> > holes, or not...
>
> I will take some time and dig through this.
>
> From a robustness standpoint I worry about the stackable filesystem
> side.  As that is uniquely an attack vector with overlayfs.
>
> There is definitely demand for this.

Hi Eric,

Have you had time to look into this yet?

Thanks,
Miklos
