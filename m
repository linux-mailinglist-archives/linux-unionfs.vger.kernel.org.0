Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 978B4B5096
	for <lists+linux-unionfs@lfdr.de>; Tue, 17 Sep 2019 16:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfIQOkh (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 17 Sep 2019 10:40:37 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:41629 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfIQOkh (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 17 Sep 2019 10:40:37 -0400
Received: by mail-io1-f54.google.com with SMTP id r26so8118879ioh.8
        for <linux-unionfs@vger.kernel.org>; Tue, 17 Sep 2019 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rnSWI4J4NCobQ9BCkPSc9FlyIk/TXW5aeLVwRDqzcQ8=;
        b=aCCFAFf02kcrNPvxT1ujxsWn3CI3wph06woVjC1WjpMqPStypUSaWV5AIQkDJ7b74h
         w2zePIR02z3Q0203OPJx3L5VnG+5WYvwh+8yAKbXZoojV2sQXoDx+fDwYP2bmJCQF3Kk
         oOkslrbJT6SZ8QeZGwSWE9Dcxbk31vbIRZFyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rnSWI4J4NCobQ9BCkPSc9FlyIk/TXW5aeLVwRDqzcQ8=;
        b=uSfNS09PgwfUJnBpTRvFIg7OH+f/w8SxYdLmn9hK0hmAbWOqg7cWnRfb/rSz9s3dLS
         zsPZntedQ9wYKTLKx7Lr6J8gfFyGqv2qRvnNYHOg8+vlEoaK0LY15GHOwMHCj6jHaLiB
         p/GZ/+ArLB4iqlmSv5eI3VC1RzuvzUDRjHLWHyPCk+ZXHU264XOJQj30ly4sazxdyKT9
         2gv5k6eNJMZZUhxmLvw5PazwmK8uYwIyiraaAfP+mUp4UtohR2AyzhfLARoMO7l7Mk3w
         tTX80xv26nvUhY8ISKRRWOJtE2Capqzh8WzP+K5LzScYsziDXbj6loadxfcwXmZJRwJ6
         gFGQ==
X-Gm-Message-State: APjAAAXOLOw5EuehXri4wGMFFwdvsgoe5MAUKldFTZuNS4oH+X2m/wVD
        +/QCLmLPgKXnnU15U/iajmEAt+kPr/nrCg+4zeWBOw==
X-Google-Smtp-Source: APXvYqyePktRtnqiucN+eLu5Qfdh4Eyozjz6dOihqfVbvI1/OXzU8yn21LA+l0rUYcWM4ExnaEUH6uHTFpB2WcNdLgw=
X-Received: by 2002:a02:9443:: with SMTP id a61mr3614127jai.35.1568731234495;
 Tue, 17 Sep 2019 07:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <23935.36189.612024.342204@informatik.uni-koeln.de>
 <CAJfpegsk30wCJY1WaQWJOibfw35TGYxUuPBYx8v7xObJBSgTAw@mail.gmail.com>
 <23936.43370.127198.222503@informatik.uni-koeln.de> <CAJfpegu0FprqEkgU2rDCiu-2nr=jwzS3wNZAj6oV-DEdv+v=eQ@mail.gmail.com>
 <23936.61171.958066.468358@informatik.uni-koeln.de>
In-Reply-To: <23936.61171.958066.468358@informatik.uni-koeln.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Sep 2019 16:40:23 +0200
Message-ID: <CAJfpegsKcLknLO2-w=y=yqu48BDOEaA03wcuGe_Qesnkn5syXQ@mail.gmail.com>
Subject: Re: can overlayfs work wit NFS v4 as lower fs?
To:     Thomas Lange <lange@informatik.uni-koeln.de>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Sep 17, 2019 at 4:34 PM Thomas Lange
<lange@informatik.uni-koeln.de> wrote:
>
> >>>>> On Tue, 17 Sep 2019 15:26:28 +0200, Miklos Szeredi <miklos@szeredi.hu> said:
>
>     > Ah, the way to disable these is to disable acl on the exported filesystem.  I.e.
>     > mount -oremount,noacl $EXPORTED_FS
> That works perfect for me. Thanks a lot for your help.
>
> It would be nice to add a note about this in the kernel
> overlayfs.txt. What about this:
>
>  The lower filesystem can be any filesystem supported by Linux and does
> -not need to be writable.  The lower filesystem can even be another
> +not need to be writable. If you are using an NFS v4 mount as lower
> +filesystem, you should disable acl on the exported filesystem.
> +The lower filesystem can even be another

Just started working on documentation update to explain this and related issues.

Thanks,
Miklos
