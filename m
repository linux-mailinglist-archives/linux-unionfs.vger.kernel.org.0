Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B94C22AFAE
	for <lists+linux-unionfs@lfdr.de>; Mon, 27 May 2019 10:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfE0IEX (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 27 May 2019 04:04:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40464 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfE0IEW (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 27 May 2019 04:04:22 -0400
Received: by mail-io1-f65.google.com with SMTP id n5so6402817ioc.7
        for <linux-unionfs@vger.kernel.org>; Mon, 27 May 2019 01:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oq1VRTyGOQqRfozLQ/A8lwTjPf2jKBZ94QPfTNcJawk=;
        b=XGm4JwRtnZxnJl0TL9l4hNd4nk1PvH/dkXRdmfV2DWAyME+NBLf5z049EgDVX51CIw
         YJMD6zHYp7fbhlhI3hopKWmn9LrR11Ppp7t2ErYyleIx4N1LLFVBYQpTYX/+azbjxdzj
         9NeyuL80svvkyqw8blqn1hKYRjVc4cMlKIzhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oq1VRTyGOQqRfozLQ/A8lwTjPf2jKBZ94QPfTNcJawk=;
        b=rz1vuLMLfhGjbh65s1Rk8NuPLqa0aFk8MzSHVgUZPXq9JA7H5H0NUqJ1kdAV28bkTT
         38nbcB0L7fFxN2v8T+Sfgpi3LdPbvA1Fmhy22Zvn9DR3lOgUx/AhXcJzjQ+hTihxBerY
         pmTUaq342D6D6W5xa5z+kEm9mSxEZAALgXPo92ZaLhYHwgngpfA3VE8PX2BR3RzSrNEm
         bXA0jr13eTka17f5f/Q89aDFC3LdJYIpiul7/ntnatlzYCeJY6YxqEfRdr6gldG9+7/y
         4PcNAofQUQTIAKI3N8BWweOtR3Yu2Si7qUHPQtSKudTssgTV/OuXFYlTrQQF2HMHEQ27
         rHYw==
X-Gm-Message-State: APjAAAXrCelbzZlUFyIeXg/EbCGh3Sg20IfjaV9lsOVsUTIxZVw6vhDC
        JH9KeQMgzNMs0+LuG3+N0JqHsiqXCrP+Y/F7A2cHdw==
X-Google-Smtp-Source: APXvYqyqLD7xiKOt/BVvYR17z0F3zuEtukYV8wiIMpZYqlCIc7cXV0rD1a61DK9E6m8OgvWKU40I9SBozY9ylRqSnwc=
X-Received: by 2002:a5e:cb43:: with SMTP id h3mr1781449iok.252.1558944262167;
 Mon, 27 May 2019 01:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190526062825.23059-1-amir73il@gmail.com>
In-Reply-To: <20190526062825.23059-1-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 27 May 2019 10:04:11 +0200
Message-ID: <CAJfpegvsN4qUXOpRGwv-0PkE8tjy6dGNCtekfbFaJviiDQd8Xg@mail.gmail.com>
Subject: Re: [PATCH] ovl: support the FS_IOC_FS[SG]ETXATTR ioctls
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Sun, May 26, 2019 at 8:28 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> They are the extended version of FS_IOC_FS[SG]ETFLAGS ioctls.
> xfs_io -c "chattr <flags>" uses the new ioctls for setting flags.
>
> This used to work in kernel pre v4.19, before stacked file ops
> introduced the ovl_ioctl whitelist.
>
> Reported-by: Dave Chinner <david@fromorbit.com>
> Fixes: d1d04ef8572b ("ovl: stack file ops")
> Cc: <stable@vger.kernel.org> # v4.19
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Thanks,  applied.

Miklos
