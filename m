Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7527FB48D9
	for <lists+linux-unionfs@lfdr.de>; Tue, 17 Sep 2019 10:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfIQIKX (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 17 Sep 2019 04:10:23 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45481 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfIQIKX (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 17 Sep 2019 04:10:23 -0400
Received: by mail-io1-f68.google.com with SMTP id f12so5360817iog.12
        for <linux-unionfs@vger.kernel.org>; Tue, 17 Sep 2019 01:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fsRwjvkTQ7WoFhqmiZtKBKDIGWjq0cKRV/wpCDXNzU8=;
        b=aR3Im5bqR5Q8podMYYj61/HGKa/NCm5VgyDOMjmpvloS/9S/OQaQHFJuwWPOQ3uMp4
         x9Ovyf61mRI/JX00k9Y1/F5dYAr/w5h4Vgy9TejRkOt2FFfxBW17HV9pDqCPdZ4q5eBS
         jmgaSeJS9WJujhVNAtthgGCbrkt0zwOiJL9R4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fsRwjvkTQ7WoFhqmiZtKBKDIGWjq0cKRV/wpCDXNzU8=;
        b=Wskx8n1sYVsu/Q6EJ44MRY3epE2yhjtmnuNcQwhXHSNleEEE+7ENSoi8uT4RPI6dB/
         loyYQdlhGiDWF8bxwrOPglUkW8WgcLRf9s0y2PFSEDmAHpt0dmzwZkBhaFRaXS2mPRLa
         7nikIG2bdY+OrIG2bRoFhA2sPeD8bV/HsDIS25l65PVsKOVq+yRc0/nPxbwBLEuV3ros
         WSBzHYQDrqUA5Jm/8RVxP3g7PWGGNP33NilqV72CRqN8EtXFYbG8CmK9xDuE1rkB43xK
         kX2z2oXuvnMwit7lBFpN6mv5E7LcMaptNGrhwNLKCWrlOqFR+d058hrYsQTLqdZ1zfLV
         eOJQ==
X-Gm-Message-State: APjAAAUlkGSEofNKDUp5Fi4BAB2MVmpWMbdvP2HVZZLLBB/PdlzKJYwa
        lYUg6SEXSytT6rJoM+uznAK5SOX/CSt3rVmHkhAUpA==
X-Google-Smtp-Source: APXvYqwRU6l/ZnZu/b5BbW7ucUq/upKYcFs/oBlqD3NaOeAToWtD8TK6hq1GQ+NCyA3AL9sKDjz0zNo7NVBQsD8Wr2M=
X-Received: by 2002:a02:1444:: with SMTP id 65mr2894537jag.58.1568707822398;
 Tue, 17 Sep 2019 01:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <23935.36189.612024.342204@informatik.uni-koeln.de>
In-Reply-To: <23935.36189.612024.342204@informatik.uni-koeln.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Sep 2019 10:10:11 +0200
Message-ID: <CAJfpegsk30wCJY1WaQWJOibfw35TGYxUuPBYx8v7xObJBSgTAw@mail.gmail.com>
Subject: Re: can overlayfs work wit NFS v4 as lower fs?
To:     lange@debian.org
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Sep 16, 2019 at 3:25 PM <lange@debian.org> wrote:
>
> Hi,
>
> I'm using overlayfs with NFS v3 as a lower (mounted read-only) and a
> tmpfs as an upper filesystem. This works nicely since several years.
> So I get a writeable directory tree on an nfs client even the nfs was
> mounted ro.
>
> But then I mount the lower filesystem as NFS v4 (4.2) it does not
> work. Is this combination supposed to work?
> I tested this with kernels up to 5.2 yet but still no success.
>
>
> Here's my current test setup:
>
> NFS server kernel 5.2.0-0.bpo.2-amd64 (Debian 10 with newer kernel)
> NFS client kernel 5.2.0-0.bpo.2-amd64 (Debian 10 with newer kernel)
>
> On the NFS server I did once
> # mkdir /files/scratch/t/etc; echo test-buster > /files/scratch/t/etc/test1
>
> /etc/exports: /files/scratch  11.22.33.128/25(async,ro,no_subtree_check,no_root_squash)
>
> I can do more tests if you tell me what I can change.
> Here are the two tests result, one using nfs v3 the other using NFS v4.
>
> P.S.: After more research I think this may be a problem of a
>       filesystem missing xattr support. Do you have any experiences
>       using overlayfs using NFS v4 as lower fs?

This is most probably about nfs4 acl support.   Does "noacl" export
option fix it?

Thanks,
Miklos



>
