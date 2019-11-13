Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D09FB489
	for <lists+linux-unionfs@lfdr.de>; Wed, 13 Nov 2019 17:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfKMQCZ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 13 Nov 2019 11:02:25 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:42083 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfKMQCX (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 13 Nov 2019 11:02:23 -0500
Received: by mail-il1-f196.google.com with SMTP id n18so2247470ilt.9
        for <linux-unionfs@vger.kernel.org>; Wed, 13 Nov 2019 08:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vaq1pj16nvNdrIA4rU9ikCjEIqjZ7g4H3dbwn5ZPZpE=;
        b=RRj1kkDTg6ox6n0Uq2c0HcGj9sRL1KGKC4asp/ZKW+ZZfa/hvrSRZhm/LyqUPnDo3s
         BGLX5fN1tfLoluE3a3v2I+bFWyxUhYjK4DaUXkxgnmMyS28XpGwZa3OIxzhMxZunbtLe
         L3JwGeCZaNdvnEKowxEO6r0DTar0Y7L55JXX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vaq1pj16nvNdrIA4rU9ikCjEIqjZ7g4H3dbwn5ZPZpE=;
        b=nqI9qvNcvuWfi4yzUrNXz9poTlUGaR7uWVCv5G5I/URMf3OrjzhxBgXKUW9JW4igND
         u77hockdbSYdiAUYoncpMpyrFWBEzwsaEgvBwjXwWcOpBpRD4CzCJ/PP7DdxDzA9cuU6
         jA3rVzbO/AcyxiafbchcKgUWe4kRgS12st9qouJ4sZVy9OKZTcrRDtk9bQt5ElBjjL2b
         QP30tmNeS+0wkdKvDQJqcZZ1xoax82R7FIo84gt8KK2u7eI6J7vzsrBqah9nZ8Rf+MtD
         Di81YA+Qzclk8t7YMKdpIrMGuKqACD5F3hEBxpd8+5yza9hKBymxPn1Bl1+z91SHzr2A
         YL0w==
X-Gm-Message-State: APjAAAW8Fgi+OAGjP8wu1JvvapY4OnLc6/zKOkQJbcPKrZ0nY/LJoqJe
        D5hhvhnflNjQ7GL5s36Odsb+IIWam0yNaiiu2fObiQ==
X-Google-Smtp-Source: APXvYqxhBwpo0UE8m+50rphlIrAnu7/RxFsTHA50cy7rxY4tNFKVyYWyDIfBwLu1/QjLIrJq9mXhbVsNMLCVRw2E2Lk=
X-Received: by 2002:a92:c14d:: with SMTP id b13mr4723899ilh.174.1573660940866;
 Wed, 13 Nov 2019 08:02:20 -0800 (PST)
MIME-Version: 1.0
References: <20191107104957.306383-1-colin.king@canonical.com>
In-Reply-To: <20191107104957.306383-1-colin.king@canonical.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 13 Nov 2019 17:02:10 +0100
Message-ID: <CAJfpegtr_xg_VG2npTfaxC+vD7B8bKa_0n9pu5vyfU-XQ9oV9Q@mail.gmail.com>
Subject: Re: [PATCH][V2] ovl: fix lookup failure on multi lower squashfs
To:     Colin King <colin.king@canonical.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        stable <stable@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, Nov 7, 2019 at 11:50 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> In the past, overlayfs required that lower fs have non null uuid in
> order to support nfs export and decode copy up origin file handles.
>
> Commit 9df085f3c9a2 ("ovl: relax requirement for non null uuid of
> lower fs") relaxed this requirement for nfs export support, as long
> as uuid (even if null) is unique among all lower fs.
>
> However, said commit unintentionally also relaxed the non null uuid
> requirement for decoding copy up origin file handles, regardless of
> the unique uuid requirement.
>
> Amend this mistake by disabling decoding of copy up origin file handle
> from lower fs with a conflicting uuid.
>
> We still encode copy up origin file handles from those fs, because
> file handles like those already exist in the wild and because they
> might provide useful information in the future.
>
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Link: https://lore.kernel.org/lkml/20191106234301.283006-1-colin.king@canonical.com/
> Fixes: 9df085f3c9a2 ("ovl: relax requirement for non null uuid ...")
> Cc: stable@vger.kernel.org # v4.20+
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/overlayfs/namei.c     |  8 ++++++++
>  fs/overlayfs/ovl_entry.h |  2 ++
>  fs/overlayfs/super.c     | 16 ++++++++++------
>  3 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index e9717c2f7d45..f47c591402d7 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -325,6 +325,14 @@ int ovl_check_origin_fh(struct ovl_fs *ofs, struct ovl_fh *fh, bool connected,
>         int i;
>
>         for (i = 0; i < ofs->numlower; i++) {
> +               /*
> +                * If lower fs uuid is not unique among lower fs we cannot match
> +                * fh->uuid to layer.
> +                */
> +               if (ofs->lower_layers[i].fsid &&
> +                   ofs->lower_layers[i].fs->bad_uuid)
> +                       continue;
> +
>                 origin = ovl_decode_real_fh(fh, ofs->lower_layers[i].mnt,
>                                             connected);
>                 if (origin)
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index a8279280e88d..28348c44ea5b 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -22,6 +22,8 @@ struct ovl_config {
>  struct ovl_sb {
>         struct super_block *sb;
>         dev_t pseudo_dev;
> +       /* Unusable (conflicting) uuid */
> +       bool bad_uuid;
>  };
>
>  struct ovl_layer {
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index afbcb116a7f1..5d4faab57ba0 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1255,17 +1255,18 @@ static bool ovl_lower_uuid_ok(struct ovl_fs *ofs, const uuid_t *uuid)
>  {
>         unsigned int i;
>
> -       if (!ofs->config.nfs_export && !(ofs->config.index && ofs->upper_mnt))
> -               return true;
> -
>         for (i = 0; i < ofs->numlowerfs; i++) {
>                 /*
>                  * We use uuid to associate an overlay lower file handle with a
>                  * lower layer, so we can accept lower fs with null uuid as long
>                  * as all lower layers with null uuid are on the same fs.
> +                * if we detect multiple lower fs with the same uuid, we
> +                * disable lower file handle decoding on all of them.
>                  */
> -               if (uuid_equal(&ofs->lower_fs[i].sb->s_uuid, uuid))
> +               if (uuid_equal(&ofs->lower_fs[i].sb->s_uuid, uuid)) {
> +                       ofs->lower_fs[i].bad_uuid = true;
>                         return false;
> +               }
>         }
>         return true;
>  }
> @@ -1277,6 +1278,7 @@ static int ovl_get_fsid(struct ovl_fs *ofs, const struct path *path)
>         unsigned int i;
>         dev_t dev;
>         int err;
> +       bool bad_uuid = false;
>
>         /* fsid 0 is reserved for upper fs even with non upper overlay */
>         if (ofs->upper_mnt && ofs->upper_mnt->mnt_sb == sb)
> @@ -1287,10 +1289,11 @@ static int ovl_get_fsid(struct ovl_fs *ofs, const struct path *path)
>                         return i + 1;
>         }
>
> -       if (!ovl_lower_uuid_ok(ofs, &sb->s_uuid)) {
> +       if (ofs->upper_mnt && !ovl_lower_uuid_ok(ofs, &sb->s_uuid)) {

This seems bogus: why only check conflicting lower layers if there's
an upper layer?

> +               bad_uuid = true;
>                 ofs->config.index = false;
>                 ofs->config.nfs_export = false;
> -               pr_warn("overlayfs: %s uuid detected in lower fs '%pd2', falling back to index=off,nfs_export=off.\n",
> +               pr_warn("overlayfs: %s uuid detected in lower fs '%pd2', enforcing index=off,nfs_export=off.\n",

And this while this makes sense, it doesn't really fit into this patch
(no change of behavior regarding how index and nfs_export are
handled).

Thanks,
Miklos
