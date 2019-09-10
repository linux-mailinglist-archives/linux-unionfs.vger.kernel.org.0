Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED5A2AEC5C
	for <lists+linux-unionfs@lfdr.de>; Tue, 10 Sep 2019 15:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfIJNxh (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 10 Sep 2019 09:53:37 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45441 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfIJNxh (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 10 Sep 2019 09:53:37 -0400
Received: by mail-yb1-f193.google.com with SMTP id u32so6120918ybi.12
        for <linux-unionfs@vger.kernel.org>; Tue, 10 Sep 2019 06:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39t7Omr3q5Kdpabj2FpbR1fNKCCozFPuDb7csZrBNE4=;
        b=I65XaI4Aupu8YTboTvQSC2R7z4oKpyKhpmPtgYTEe7Al5RJ0RA6Tx/NNWQ+plAYZIm
         26FQaaYX5IPW+Ie8E9WjGhzf1vrTH6mqt8Q/6kV+fcOgEM27orbcLyDgz+oFLzDIUnGa
         2FKqAY795lctYHuRSMGQu8DCQwZJflrUcWIDJhocNqtU9UjTroRSrJhWxlWyLrN+k0YT
         8LGrr4D9j/M2yggzob5rjA6dOgcA12ybKscZ3ZSXDIeyDyeisK3KKZsHtw/l+kFuI5aB
         RweNhfn3hyWVvI6LpwuzxQvoYBHA2FyYqGXp3sU/kXs6kwLNgLNg1fSibZHaEul/2CxA
         3DjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39t7Omr3q5Kdpabj2FpbR1fNKCCozFPuDb7csZrBNE4=;
        b=gb+EA4XA1XgsWr0J20o3q0jCZM3VdB98bEiO5qwi1aOFQrT9qam1QSkR7t6Qiw7N2f
         r9Byr7jfiIizNiYJFoQi48bLCooGJLgLLFDwcxfXCHHe0JXXj+5iFyoNOGQ3N0smLcFJ
         5D6rzbb649TBpPhmCElwE4Ujq4BcGHreycuuaEjsimWH1QQlmF+YOygf//6d0Dvy5aV1
         82n+pRgBYVczxTz/fCDA1oBMjGm/YTYIj1Sm2b0sYxqOrfcHB7l9X3XmvTsRqSpP3uoN
         n3zqCemZ539kcIoOQJ95kFhkuHPTj4RrE6dXMXtqPUbhrmg36btQdQvjZJG+73gt0Bko
         z00A==
X-Gm-Message-State: APjAAAWT7WEGDHyMoNoGcdqOYQAOMcAOqtSlW9xLDcbihTw3Z75Iqq65
        C1g8FDRquZ763exRZP3lu7Ok4eaK7Lk1oA5AJfcWkQ==
X-Google-Smtp-Source: APXvYqwFLQoUuu3Q4ctusGBnB6qUBTY2A4n7HSxJrGy2IvnGFBJeXydQQKZPTk1ssTawRpjIHahnpKF86XEm9hkaERE=
X-Received: by 2002:a25:6c84:: with SMTP id h126mr19702108ybc.144.1568123614546;
 Tue, 10 Sep 2019 06:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190712122434.14809-1-amir73il@gmail.com> <CAOQ4uxg+equ2vt3xqsC_v=m=YMFSAj2ywk2pga=BGZWgOQcVoA@mail.gmail.com>
In-Reply-To: <CAOQ4uxg+equ2vt3xqsC_v=m=YMFSAj2ywk2pga=BGZWgOQcVoA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 10 Sep 2019 16:53:23 +0300
Message-ID: <CAOQ4uxhC_=oPcjwpzgq7YvZuFL=HWJ=9hXwcY=EupcAnLobcsA@mail.gmail.com>
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

On Tue, Jul 16, 2019 at 8:15 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Fri, Jul 12, 2019 at 3:24 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Once upon a time, commit 2cac0c00a6cd ("ovl: get exclusive ownership on
> > upper/work dirs") in v4.13 added some sanity checks on overlayfs layers.
> > This change caused a docker regression. The root cause was mount leaks
> > by docker, which as far as I know, still exist.
> >
> > To mitigate the regression, commit 85fdee1eef1a ("ovl: fix regression
> > caused by exclusive upper/work dir protection") in v4.14 turned the
> > mount errors into warnings for the default index=off configuration.
> >
> > Recently, commit 146d62e5a586 ("ovl: detect overlapping layers") in
> > v5.2, re-introduced exclusive upper/work dir checks regardless of
> > index=off configuration.
> >
> > This changes the status quo and mount leak related bug reports have
> > started to re-surface. Restore the status quo to fix the regressions.
> > To clarify, index=off does NOT relax overlapping layers check for this
> > ovelayfs mount. index=off only relaxes exclusive upper/work dir checks
> > with another overlayfs mount.
> >
> > To cover the part of overlapping layers detection that used the
> > exclusive upper/work dir checks to detect overlap with self upper/work
> > dir, add a trap also on the work base dir.
> >
> > Link: https://github.com/moby/moby/issues/34672
> > Link: https://lore.kernel.org/linux-fsdevel/20171006121405.GA32700@veci.piliscsaba.szeredi.hu/
> > Link: https://github.com/containers/libpod/issues/3540
> > Fixes: 146d62e5a586 ("ovl: detect overlapping layers")
> > Cc: <stable@vger.kernel.org> # v4.19+
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Miklos,
>
> Please add:
> Tested-by: Colin Walters <walters@verbum.org>
>

Miklos,

This patch got stuck in overlayfs-next.
Could you push it to Linus please?

Thanks,
Amir.
