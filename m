Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 746921393B2
	for <lists+linux-unionfs@lfdr.de>; Mon, 13 Jan 2020 15:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgAMOaW (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 13 Jan 2020 09:30:22 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41379 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgAMOaW (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 13 Jan 2020 09:30:22 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so9980648ioo.8
        for <linux-unionfs@vger.kernel.org>; Mon, 13 Jan 2020 06:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AU1Sj4PqUTVHwGrAyhiCa5gjG7he8nCJVgbYmXTy5NQ=;
        b=RZxv4m5GEHhb6s3V6OBTLY4rln6B2//+ZSTM7t6faPrHMCw7mAIC5ypgl1k6WphLQa
         4EdYU64ydGnnj3SOSc8OQfcHjV69EOUSIwbX8aSOJ/VMQw/OyDX3BXoG1JZLiBFj7ZnJ
         wFzNXnKvm856nS/2Nv3dMAXPjesSFQJIfGmTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AU1Sj4PqUTVHwGrAyhiCa5gjG7he8nCJVgbYmXTy5NQ=;
        b=mohJDAPT8hpnsZLGkPtFaE71WRD2cw0h+sZYtNC/Mrq4sc1IhWvrYXvwElVa7Gzw/G
         vzvmYvCl2Cx4NC7xnsQ+g6bByy6dBsEn2i9ha+UQbkKQClSTBAX7pMtM1aUHK5ZITPAq
         ZCA0rmdqD7OqFAE5oUKqx61ctvKFpZSrcz1yMzASVvx3S50DvpYPSLKur0Na14JENaVn
         9KH9ANQ1zkh2utc1pw884nNcPagS2nbyX+uOv1Jx7jhd1mlFyda7U/JhZriSinr7+ooI
         A+/bdfyqOdAUYCZ0WUWyssmkmUC5ldUDhJBWYSS4PVuu+xTkB/Br7Q2Vr6oVzwGPVM9x
         I4Yw==
X-Gm-Message-State: APjAAAV03RTY1m4H4QibBo7/nlx4bRQ3Ate2IiSJ7wM4VKxnv3qnIdQG
        hoqVFigBXtLwgcKf4tTIR+JjpO3qegkYbDw+pPsvEA==
X-Google-Smtp-Source: APXvYqzsenR7zFk6gRYBJwi+jN01HrlBDruEc0ccRYib0rL9toqupGuaUk5jv98XC8O21b6q+Si0JvGJ+la3TZ4BN70=
X-Received: by 2002:a02:6a10:: with SMTP id l16mr14181435jac.77.1578925821810;
 Mon, 13 Jan 2020 06:30:21 -0800 (PST)
MIME-Version: 1.0
References: <20191222080759.32035-1-amir73il@gmail.com> <20191222080759.32035-4-amir73il@gmail.com>
In-Reply-To: <20191222080759.32035-4-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 13 Jan 2020 15:30:10 +0100
Message-ID: <CAJfpegvqXAc2gH2zeAU3V+cNPujdT4h9gJ8f1m=NaAxUL5iXCw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ovl: generalize the lower_fs[] array
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Sun, Dec 22, 2019 at 9:08 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Rename lower_fs[] array to fs[], extend its size by one and use
> index fsid (instead of fsid-1) to access the fs[] array.
>
> Initialize fs[0] with upper fs values. fsid 0 is reserved even with
> lower only overlay, so fs[0] remains null in this case.
>
> This gets rid of special casing upper layer in ovl_map_dev_ino().

Okay, but shouldn't this last one (which changes behavior) be split
into a separate patch?

Thanks,
Miklos
