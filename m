Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 734CEFB7B5
	for <lists+linux-unionfs@lfdr.de>; Wed, 13 Nov 2019 19:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfKMSfM (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 13 Nov 2019 13:35:12 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39870 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbfKMSfK (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 13 Nov 2019 13:35:10 -0500
Received: by mail-yb1-f196.google.com with SMTP id q18so1353871ybq.6;
        Wed, 13 Nov 2019 10:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XDi/ntprkg3QynLzmnS5etARNN2x0LlcxJAfofHbmvI=;
        b=mz29wxCLbj5XV0esYlUTXfCBkGNYAf+abaKCz/Gnsro+dGcvQ/eXD5L+c0Pt4Wtofl
         ZvLUcI5ltaBf5gxBl3IuzlsJsWpL9DErj1FG+vqINIY1pwAePwtQXhDLVr1Wof9iABuI
         /AmgK1E4UQyyQZElYH4eDFo3nXYO1OUoQjBC4J3o0Ye2eqx7FuBbvLKyzpKHOda4qVv9
         VBnfKYhRRKliNkwhu3JDXdKdvFLOZ9Tp6baKF+6V/gwDmGbF7FmE1AYMlIpXKz3579Y2
         kH/sK9AqI6gwlhUnnMKHBt9T2Cxt/HVNlXTGJjrjMgVQyjLDebY7kZNziz/sq7HA7lUU
         uVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XDi/ntprkg3QynLzmnS5etARNN2x0LlcxJAfofHbmvI=;
        b=DG+qHCui4mVRTpuJ6asGv/Uedz3bD6QjNnzQK+prqyRQJs7KqEA4H0bksczdtx71ef
         GjUZc26oQD3+2aMc/Kbs4D9l8RSp0H5OtkzA0lLD0QSAiB59y9cL1I49HXJ8so5wsxJ7
         4QCHdLzMUMmRZOsXSG/6bCYl0E2svFHOAB/OvZ7u7YEtvV6AEPK5YTaGxyg31a4AGWUh
         jSXA4aCp5DOdoiuRqb8yEoEZb/C/YSpaMWrt0XqdSszjIi52LXqRWskCuha2ArBtmvQY
         DoZPNd3MUtG6+o8qib8wF6J6QR5G6cMnGTqOeX/LccWVf263i799QH7E7j0SIRuNVlHv
         X0Zw==
X-Gm-Message-State: APjAAAWMPDFLoq3oD5CfJE5kVzysT2Vd7FXcypmRhNgZbCDcnnOBXX/7
        c1CRqao2+IxIDTC9Kfsf8Cd2JY2gCZ+SN86M1Hk=
X-Google-Smtp-Source: APXvYqxjaYBZBav2D3uP0xrSXLsQH8FhA7HHnTMnS+eyI3XQFNy+cNCBTl+Jzpx51zpV//vkajjdZIdYfUFDPBFhccg=
X-Received: by 2002:a25:6649:: with SMTP id z9mr3375513ybm.132.1573670108633;
 Wed, 13 Nov 2019 10:35:08 -0800 (PST)
MIME-Version: 1.0
References: <20191113175746.110933-1-colin.king@canonical.com>
In-Reply-To: <20191113175746.110933-1-colin.king@canonical.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 13 Nov 2019 20:34:57 +0200
Message-ID: <CAOQ4uxiV06H9s8WMso6A1A7mhdvQ_AuWM0n71VoGYTdryi8KNA@mail.gmail.com>
Subject: Re: [PATCH][V3] ovl: fix lookup failure on multi lower squashfs
To:     Colin King <colin.king@canonical.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Nov 13, 2019 at 7:57 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Amir Goldstein <amir73il@gmail.com>
>
> In the past, overlayfs required that lower fs have non null
> uuid in order to support nfs export and decode copy up origin file handles.
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
> [Colin Ian King] fixed the case of index=off,nfs_export=off
>
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Link: https://lore.kernel.org/lkml/20191106234301.283006-1-colin.king@canonical.com/
> Fixes: 9df085f3c9a2 ("ovl: relax requirement for non null uuid ...")
> Cc: stable@vger.kernel.org # v4.20+
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Tested-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>`
> ---
>
> V3: fix the following check:
>   -       if (!ofs->config.nfs_export && !(ofs->config.index && ofs->upper_mnt))
>   +       if (!ofs->config.nfs_export && !ofs->upper_mnt)
>
> Add the index=off,nfs_export=off comment in the commit message
>
> ---
>  fs/overlayfs/namei.c     |  8 ++++++++
>  fs/overlayfs/ovl_entry.h |  2 ++
>  fs/overlayfs/super.c     | 15 +++++++++++----
>  3 files changed, 21 insertions(+), 4 deletions(-)
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
> index afbcb116a7f1..e53d399ce0af 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1255,7 +1255,7 @@ static bool ovl_lower_uuid_ok(struct ovl_fs *ofs, const uuid_t *uuid)
>  {
>         unsigned int i;
>
> -       if (!ofs->config.nfs_export && !(ofs->config.index && ofs->upper_mnt))
> +       if (!ofs->config.nfs_export && !ofs->upper_mnt)
>                 return true;
>
>         for (i = 0; i < ofs->numlowerfs; i++) {
> @@ -1263,9 +1263,13 @@ static bool ovl_lower_uuid_ok(struct ovl_fs *ofs, const uuid_t *uuid)
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
> @@ -1277,6 +1281,7 @@ static int ovl_get_fsid(struct ovl_fs *ofs, const struct path *path)
>         unsigned int i;
>         dev_t dev;
>         int err;
> +       bool bad_uuid = false;
>
>         /* fsid 0 is reserved for upper fs even with non upper overlay */
>         if (ofs->upper_mnt && ofs->upper_mnt->mnt_sb == sb)
> @@ -1287,10 +1292,11 @@ static int ovl_get_fsid(struct ovl_fs *ofs, const struct path *path)
>                         return i + 1;
>         }
>
> -       if (!ovl_lower_uuid_ok(ofs, &sb->s_uuid)) {
> +       if (ofs->upper_mnt && !ovl_lower_uuid_ok(ofs, &sb->s_uuid)) {

Sorry I wasn't clear.
Miklos is right. the test ofs->upper_mnt here is bogus because
nfs_export could be enabled without upper.
The change you made in v3 to ovl_lower_uuid_ok() should be enough.

> +               bad_uuid = true;
>                 ofs->config.index = false;
>                 ofs->config.nfs_export = false;
> -               pr_warn("overlayfs: %s uuid detected in lower fs '%pd2', falling back to index=off,nfs_export=off.\n",
> +               pr_warn("overlayfs: %s uuid detected in lower fs '%pd2', enforcing index=off,nfs_export=off.\n",
>                         uuid_is_null(&sb->s_uuid) ? "null" : "conflicting",
>                         path->dentry);
>         }
> @@ -1303,6 +1309,7 @@ static int ovl_get_fsid(struct ovl_fs *ofs, const struct path *path)
>
>         ofs->lower_fs[ofs->numlowerfs].sb = sb;
>         ofs->lower_fs[ofs->numlowerfs].pseudo_dev = dev;
> +       ofs->lower_fs[ofs->numlowerfs].bad_uuid = bad_uuid;
>         ofs->numlowerfs++;
>
>         return ofs->numlowerfs;
> --
> 2.20.1
>
