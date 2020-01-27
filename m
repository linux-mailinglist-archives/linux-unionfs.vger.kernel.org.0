Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0483714A311
	for <lists+linux-unionfs@lfdr.de>; Mon, 27 Jan 2020 12:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbgA0Lcw (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 27 Jan 2020 06:32:52 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38767 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729764AbgA0Lcw (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 27 Jan 2020 06:32:52 -0500
Received: by mail-qk1-f194.google.com with SMTP id k6so9214276qki.5
        for <linux-unionfs@vger.kernel.org>; Mon, 27 Jan 2020 03:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AphZxboVMysVairYeCCsCZBOqk4cfY9EbLBe1193qaQ=;
        b=GWRbnvAzj8H3EEKmXsMDYVku9L6GVEnIZE8H3hw7NQ3ausp3TfsWB5CQXw8JgdriiH
         kuiioRtxKBk98Pn5/44PoRP+73JGu43K6QVZs9klpenrkHJ9e/bAxaL+NjPuqIjJ4a8k
         +DLAc9BUsNnxnJjWW7878aO0zgil4VcWVj7IU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AphZxboVMysVairYeCCsCZBOqk4cfY9EbLBe1193qaQ=;
        b=a1UMOBckDkgy8rIW0/7fw4mVV+uCrsdBE7QGDf/9FOEqC6tQj7LUbWhlVEvdo256W2
         AF9pdCwX51mVhgI0aK6J1HHX9m6Bj5nZ7ueH431QnE+Q+yXeFeR+HZnvO5F/yL++gQk2
         X7hq2mQW0OYC5jW4ImsKpoapnFppiwkRVpizJs8bQXXQEn40GmdpfXeSYQO4Onzc1WzK
         5gEEaTNCrhh1YcH52xbV3jdifUqMLmWm7AHkJ//r1r5INPZSyKOsx2ZIVVIsEpWxw4Qg
         Y/TwbO3rxBoFUDYujhKSUJ29CymYSDVqg34o1N3YfTQqMWBkVcEhyFob8wDBzFEItLpU
         /ouw==
X-Gm-Message-State: APjAAAXSzyhXsJmNHK0cc3bnP0JuRWQNhQj7fxVwzqIAEu0e81kSJNUM
        8tOkswX3N1NlV3NGJTUmCmIW+0DBdXaEMyhaK9v9ddqS5KQ=
X-Google-Smtp-Source: APXvYqxgEEqyedw5IDybLs5KNfR1+Tf+lO0QgYO/uI+27WuAb+9aRctQ1AKWUVTOyX2mdIktvKlySsg2QJ/BffN9qtU=
X-Received: by 2002:a05:6638:3b6:: with SMTP id z22mr12436906jap.35.1580123103114;
 Mon, 27 Jan 2020 03:05:03 -0800 (PST)
MIME-Version: 1.0
References: <20200117124929.6nhgpd7mgcbwae5z@xzhoux.usersys.redhat.com>
In-Reply-To: <20200117124929.6nhgpd7mgcbwae5z@xzhoux.usersys.redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 27 Jan 2020 12:04:52 +0100
Message-ID: <CAJfpegvn+eOQVoAKiv1mSuZcFacdDVKPHo4gtkt-=d5+9_mDJA@mail.gmail.com>
Subject: Re: [PATCH] fs/overlayfs: add splice file read write helper
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Fri, Jan 17, 2020 at 1:49 PM Murphy Zhou <jencce.kernel@gmail.com> wrote:
>
> Now overlayfs falls back to use default file splice read
> and write, which is not compatiple with overlayfs, returning
> EFAULT. xfstests generic/591 can reproduce part of this.
>
> Tested this patch with xfstests auto group tests.

Thanks, applied.

Miklos
