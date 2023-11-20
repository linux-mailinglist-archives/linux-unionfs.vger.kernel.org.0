Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7277F1246
	for <lists+linux-unionfs@lfdr.de>; Mon, 20 Nov 2023 12:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjKTLkH (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 20 Nov 2023 06:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjKTLkG (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 20 Nov 2023 06:40:06 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FAEB3;
        Mon, 20 Nov 2023 03:40:03 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-677f832d844so11192166d6.2;
        Mon, 20 Nov 2023 03:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700480403; x=1701085203; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EPsFAkvYjtvlQaVQ8lVtTBL0jOv+UC6tPuVf4HtGQTw=;
        b=dAc/1FJ0xgbeVcHb7XwZrzohlBfFzT5bjLPRFap5dksW4z20NZnjz7c5IhmCoTnbNA
         jYxjLtaXA/JhnpgRkSnjXbJRVDSn+IYRWy+hagYR6tlE6W7om6fM/syzsB4x4pyujXYv
         hRWDh51JDPyQireBP5AR6Z+dt7x3M2+k8wDveAGtgw5GOOfDEth8QGB6cKQk9XUYs3lL
         eKt5lXRvFMbBnRzcpI5E3OFbC9ZXY1xNcjrd3PxrGyZ8h4TfJpSscZHu47Czj2sontzV
         FVDjTikv+wroK8BpZEZe22AFO54Yk6ItvblQIeX6urXQl1m+bnbhgfaGmqW9daFJrxvO
         s95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700480403; x=1701085203;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EPsFAkvYjtvlQaVQ8lVtTBL0jOv+UC6tPuVf4HtGQTw=;
        b=QtclNyJBr6CxeCezyvzGqaITowVghh8CjztjSP02zeALbt5fl5lkpATaE9sQ5SOMg6
         BoX8HeoutA2fDX9mfvq92g5gaLhmc6EmzUzDAGpOD/8+6Y6I485B0pg6slKINd+XCH8G
         4JblVuIFGiyv37IXAEBRR7Jw8R7L2h6WqwTKAkNSF25DBc9rJcbjzOt7rhV/KhYYMcVI
         t0vQFb5ZKeYeyZ3PLWuLRoHDYBbPv1lu+jxJC8hLvKQTU6Xqx8AQkr9KX9+nIFp5cQXa
         NxZ/M3P2qs/e/99VSdYV2NyAanIxq7AGvj1/EB+9EwYD6Tpcu0Wg9pxqroB9Xz5gFOal
         6ksA==
X-Gm-Message-State: AOJu0YwlbEmpSO3rFz46wWmVu22FKvGmd7wNELecF/exIP5p537geIQQ
        XG2BpM5lkZAJvf/x61b1L4vCVoDPw9s8pVFuV6kVbjwJ1ig=
X-Google-Smtp-Source: AGHT+IEElqSiu2ywMYnbkqfVvL2CyBcS7CW3W7d2zWtUcyd6jDZg/9qFkpvTvz2cr/4TaBAPzARgstkZYrD6GfjNo/g=
X-Received: by 2002:a05:6214:2629:b0:679:d3af:504a with SMTP id
 gv9-20020a056214262900b00679d3af504amr5191142qvb.7.1700480402741; Mon, 20 Nov
 2023 03:40:02 -0800 (PST)
MIME-Version: 1.0
References: <20231111080400.GO1957730@ZenIV> <CAOQ4uxhQdHsegbwdqy_04eHVG+wkntA2g2qwt9wH8hb=-PtT2A@mail.gmail.com>
 <20231111185034.GP1957730@ZenIV> <CAOQ4uxjYaHk6rWUgvsFA4403Uk-hBqjGegV4CCOHZyh2LSYf4w@mail.gmail.com>
 <CAOQ4uxiJSum4a2F5FEA=a8JKwWh1XhFOpWaH8xas_uWKf+29cw@mail.gmail.com>
 <20231118200247.GF1957730@ZenIV> <CAOQ4uxjFrdKS3_yyeAcfemL-8dXm3JDWLwAmD9w3bY90=xfCjw@mail.gmail.com>
 <20231119072652.GA38156@ZenIV> <CAOQ4uxiu_qY-cSh5FcbWMh8yF6mumik8Jsv3qeTQ4qPi+80Rrw@mail.gmail.com>
In-Reply-To: <CAOQ4uxiu_qY-cSh5FcbWMh8yF6mumik8Jsv3qeTQ4qPi+80Rrw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 20 Nov 2023 13:39:51 +0200
Message-ID: <CAOQ4uxjW4yv8x0Ej7A1Y0Q=r4AkBeLbHL0yx0BpyoYrP2ehW4A@mail.gmail.com>
Subject: Re: [RFC][overlayfs] do we still need d_instantiate_anon() and export
 of d_alloc_anon()?
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

> > Another fun question: ovl_copy_up_one() has
> >         if (parent) {
> >                 ovl_path_upper(parent, &parentpath);
> >                 ctx.destdir = parentpath.dentry;
> >                 ctx.destname = dentry->d_name;
> >
> >                 err = vfs_getattr(&parentpath, &ctx.pstat,
> >                                   STATX_ATIME | STATX_MTIME,
> >                                   AT_STATX_SYNC_AS_STAT);
> >                 if (err)
> >                         return err;
> >         }
> > What stabilizes dentry->d_name here?  I might be missing something about the
> > locking environment here, so it might be OK, but...
>
> Honestly, I don't think that anything stabilizes it...
> As long as this cannot result in UAF, we don't care,
> because messing with upper fs directly yields undefined results.
> But I suspect that we do need to take_dentry_name_snapshot()
> to protect against UAF. Right?
>

Sorry, I got confused. It is not about the stability of d_name in the
underlying layer. dentry is the overlayfs dentry that is being copied up.

In principle, dentry->d_name is stable "during copy up" due to the fact
that ovl_rename() calls ovl_copy_up(old) and ovl_copy_up(new) before
starting to rename.

If ovl_dentry_has_upper_alias(dentry), as is the case if ovl_rename()
has already started, then ctx.destname will not actually be dereferenced
and racing with future ovl_rename() is not an issue.

If dentry does need to be copied up, then if ovl_rename() starts after
ovl_copy_up_start(), either ovl_copy_up(old) or ovl_copy_up(new)
will block until ovl_copy_up_end().

I think this would be easier to document and nicer to follow if we read
dentry->d_name inside ovl_do_copy_up() only if we are actually going
to need to use it.

I will try to write it up.

Thanks,
Amir.
