Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35D90FC42D
	for <lists+linux-unionfs@lfdr.de>; Thu, 14 Nov 2019 11:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfKNKa0 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 14 Nov 2019 05:30:26 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36949 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfKNKa0 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 14 Nov 2019 05:30:26 -0500
Received: by mail-io1-f66.google.com with SMTP id 1so6235069iou.4
        for <linux-unionfs@vger.kernel.org>; Thu, 14 Nov 2019 02:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q0ODQMjiIKKDNHMHFmstYPQVkSDb52CtygX5wXt7a60=;
        b=RPQgdynYquk1oX1FlJYROA3WoECoE8TuBO6QFqoYnJX2y6zQvSgSS12bmkC2MMNyVm
         ubKNHkff9bsXOxrsS8frUFNImLf/lTOBrv4PDhNbvVsWy/jR33CM+eyXSDYWyvYXuH1R
         SsbDaX4F8xABNuwPY3VKxmfk0hUTpSr2JPeIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q0ODQMjiIKKDNHMHFmstYPQVkSDb52CtygX5wXt7a60=;
        b=U2jBXg7wIqXKckIDJu0SKxCAEtU4MykCGJqBMBwbsdmlz2Kn6J79hrsPPGmEIkGirJ
         Hm9edtEVyWQYfAk+70aquGDtfPoXzHoa1qOBEiv1TgpBJlUtM+fNpPAGmYly9D9DWriZ
         AXiRrvPy4M0SC4ZRRE04kA5r+23yoIV1xFw1Fgd70uc8MUY4iUKsIpLNaJOXXQapbGLJ
         ny0bVLYyrOTtrhMnqqXrkvXsTUK4g6NGdmtHUHH/qC/SFQ249rvEDcopYYDyfW6vhHN2
         e6EohUJTyf1QUUA5E4jCxcy8fS2TcbNsgt/7g/aJCqbr/DcV8oMSneIwAOHqZCRYDiyx
         aIwg==
X-Gm-Message-State: APjAAAUF4qZI++mwr0gN8BBJnAwFAMQwcces1uCk5ERDiEljXTBmXffQ
        DXKt/DNiWf27hEwnBZYTGggPjSm3Xt/sx8O3GyAvuw==
X-Google-Smtp-Source: APXvYqyFB3goydsCrDzye1z3rnm33m5fU70E0wh+81ZMdqXoZNXF97wesNRGnM95NZF4bjAMv7oGDQM9lP5R7AgpLFI=
X-Received: by 2002:a05:6638:9:: with SMTP id z9mr6880049jao.35.1573727425730;
 Thu, 14 Nov 2019 02:30:25 -0800 (PST)
MIME-Version: 1.0
References: <20191113200651.114606-1-colin.king@canonical.com>
In-Reply-To: <20191113200651.114606-1-colin.king@canonical.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 14 Nov 2019 11:30:14 +0100
Message-ID: <CAJfpegug-saOEigqDNKfwMR5qdzrbLnRBD=0eN5juGioFH_L_Q@mail.gmail.com>
Subject: Re: [PATCH][V4] ovl: fix lookup failure on multi lower squashfs
To:     Colin King <colin.king@canonical.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Nov 13, 2019 at 9:06 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Amir Goldstein <amir73il@gmail.com>
>
> In the past, overlayfs required that lower fs have non null
> uuid in order to support nfs export and decode copy up origin file handles.
>
> Commit 9df085f3c9a2 ("ovl: relax requirement for non null uuid of
> lower fs") relaxed this requirement for nfs export support, as long
> as uuid (even if null) is unique among all lower fs.

I see another corner case:

n- two filesystems, A and B, both have null uuid
 - upper layer is on A
 - lower layer 1 is also on A
 - lower layer 2 is on B

In this case bad_uuid won't be set for B, because the check only
involves the list of lower fs.  Hence we'll try to decode a layer 2
origin on layer 1 and fail.

Can we fix this without special casing lower layer fsid == 0 in
various places?  I guess that involves using lower_fs[0] for the
fsid=0 case (i.e. index lower_fs by fsid, rather than (fsid -1)).
Probably warrants a separate patch.

Thanks,
Miklos
