Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A288AFD5E
	for <lists+linux-unionfs@lfdr.de>; Wed, 11 Sep 2019 15:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfIKNEt (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 11 Sep 2019 09:04:49 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41887 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbfIKNEt (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 11 Sep 2019 09:04:49 -0400
Received: by mail-yw1-f68.google.com with SMTP id 129so7776344ywb.8
        for <linux-unionfs@vger.kernel.org>; Wed, 11 Sep 2019 06:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w5pAHYb/wQH2+99Nyxjw8D+WsWtZH2AWCEPBIx4BETM=;
        b=ZDvx39ilqMFDwrDAVQHw/+V/NRwJq0J7cMGcGib3r/pd3FR8gUH5+DZ+tWGZOGFvFh
         WgGc/Y3J0j/Wzr2NIc7b6KPxUYd3WFXSQUI5eHkX06Vzj7CbPwJozgTwbFTDyXqeaJ60
         Vi1CIYSh4Zj42RPqlLfhIdYzNF+WRH6/Bg1eH6MLc/iMJ1La/IB4qX3VXu9pfFHE371I
         YhT60wFPDVbXhdLwoU5bV57NL7czHPLimwo/muxhj2qwrYMTTywuyI64v0fLLxr6sLi+
         DSWFpA9bX+wps4Qul0W1LfQ1a1MwIlKOUYHczqu4QwCp9YFXJnZB9JZlk086e86yrFuL
         nj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5pAHYb/wQH2+99Nyxjw8D+WsWtZH2AWCEPBIx4BETM=;
        b=FsHEt1T2ms41V4pDg3HRwrQor3t/XpUzWlLLmHwcdgmMUzDhknvOukIT3pzRlJWjmv
         3g2k9Hlc4NxL5NgbU6+ivSMozYTFJ9VzW8AmTMdqfHymXKpUTML4JHRWSqX4xrKdlCVG
         pFhtIkVPxOv/y8QVEtrXuBmNnjwLj2mphtZEDt8T3iKpQI0Vsr9oWNTXfTQOaOHWWDiG
         ceeonbUVsFMvqAxnHFilBC24AFQC2+/GE/7TDBAc/8oJGwAGEzdEyiRISvm7EvoEJoSD
         UvcNwAhagMUkU9UYcuaSj8ZWjDf8ui/WdzoVGl1TmCOvPVafkW2gSLF/mrNH6dAw7h0a
         G43w==
X-Gm-Message-State: APjAAAXrAJ1RClvGnq1ja1JzJRW61VaGdOQdcM4UKIz7JuMq8FKBvY5t
        DKW6BQ7EtxH25x3O/eHtgxzwW2krnTvGypnVLkc=
X-Google-Smtp-Source: APXvYqxKamOj1eg9B1YZjq65aJ3c5IFS3WkERueDw+M04VbqZdelTTCKVSykH0eSZ4EQYyzkugjvwCKgvOL4+lPgMt8=
X-Received: by 2002:a0d:f5c4:: with SMTP id e187mr11530672ywf.294.1568207088275;
 Wed, 11 Sep 2019 06:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190712122434.14809-1-amir73il@gmail.com> <CAOQ4uxg+equ2vt3xqsC_v=m=YMFSAj2ywk2pga=BGZWgOQcVoA@mail.gmail.com>
 <CAOQ4uxhC_=oPcjwpzgq7YvZuFL=HWJ=9hXwcY=EupcAnLobcsA@mail.gmail.com> <CAJfpegvQzAmDHhoXh-aSPjmkqLSpP_KWOf08YED4H7uwqa-oVg@mail.gmail.com>
In-Reply-To: <CAJfpegvQzAmDHhoXh-aSPjmkqLSpP_KWOf08YED4H7uwqa-oVg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 11 Sep 2019 16:04:37 +0300
Message-ID: <CAOQ4uxjwwxosfzkjjxUhBjizHGOx1wJ9zzFPmxVzLJx-ZFud+w@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix regression caused by overlapping layers detection
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Colin Walters <walters@verbum.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Sep 11, 2019 at 2:50 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, Sep 10, 2019 at 3:53 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > This patch got stuck in overlayfs-next.
> > Could you push it to Linus please?
>
> Just tested applied on top of -linus, and it fails overlayfs/065 with this:
>
> --- /root/xfstests-dev/tests/overlay/065.out    2019-06-18
> 15:12:19.147000000 +0200
> +++ /root/xfstests-dev/results//overlay/065.out.bad    2019-09-11
> 13:22:34.612000000 +0200
> @@ -1,8 +1,8 @@
>  QA output created by 065
>  Conflicting upperdir/lowerdir
> -mount: device already mounted or mount point busy
> +mount: /scratch/ovl-mnt: mount(2) system call failed: Too many levels
> of symbolic links
>  Conflicting workdir/lowerdir
> -mount: device already mounted or mount point busy
> +mount: /scratch/ovl-mnt: mount(2) system call failed: Too many levels
> of symbolic links
>  Overlapping upperdir/lowerdir
>  mount: Too many levels of symbolic links
>  Conflicting lower layers
>
> So the mount seems to fail, but with a different than expected error
> value.  Do you know what might be happening?
>

Yes, intentional. I have an update for  the test.
Was waiting with it until patch is merged upstream.

I also have a test for the regression, see:
https://github.com/amir73il/xfstests/commits/overlayfs-devel

Thanks,
Amir.
