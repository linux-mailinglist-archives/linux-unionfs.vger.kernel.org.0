Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A66C583ACA
	for <lists+linux-unionfs@lfdr.de>; Thu, 28 Jul 2022 10:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbiG1I5l (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 28 Jul 2022 04:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbiG1I5k (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 28 Jul 2022 04:57:40 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1108B6556B
        for <linux-unionfs@vger.kernel.org>; Thu, 28 Jul 2022 01:57:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id j22so2046380ejs.2
        for <linux-unionfs@vger.kernel.org>; Thu, 28 Jul 2022 01:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwfttGU/k1I9a2kTyLxRXPdvdNGKDNXOB3vdeDt2IZE=;
        b=ZrSPdFO8YMUIQROaKnue3yKZbUz/2Hg5MPQInCarovto3loHky29xy69zpWMCRz3Hf
         QY94c6ryEn3aLobEVOJReS7jbMKyGInZTZ/OLkISyFTv6QchHcwowHxvgSHVpUNOwYtS
         7Fy4LZ/OeZ2WmpLkqxbuutEZDYk3Nk5PPOLjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwfttGU/k1I9a2kTyLxRXPdvdNGKDNXOB3vdeDt2IZE=;
        b=5sbmmV6RAoRYvjWZwp4SisKvnYQQPWVxm9+/BnZvvqWuhGx8QzB/I8/6a0VpQSByEZ
         QaU+//hd78lDSLCPQGX7cevpN0vYKTxmng+KQrjIk0LT+2BqiVdHCC4jikLazlfzClAC
         OGbX9xHrGHM+r3itibzdaYbtaeJhGCAIq0ktUa3HchSNZK1eEYA5T0HkSRpve9RLckw9
         Bz8rd+/HC1XNKhskqms4QDJpNVh9UTcbixeqY7StycylZZpty5+z21YfB1SGYYKohMqZ
         lB6+Hg2ifsbvrfRhP9RqFMMT+6Ps8YLwx42tdORvNCAAZDkv7Pkh8qqrVAkqovm+sSR6
         bNdA==
X-Gm-Message-State: AJIora+fZi/6CViLmEfSP67zQXbavE4R8oIO/Uik0/efITwiPY1HHgad
        7rwZAFgoGLSBMGYENivLXnxeOc+eoO7N91Ds/wmhgQ==
X-Google-Smtp-Source: AGRyM1uD6O64z7MKe5zWkIPORzBnJ0jZZ5Yiz6x284X0yVcxlVjrHHPvyvYiODjTZ9zON6f4ZHHpQN2Gn+ODr96E86Y=
X-Received: by 2002:a17:907:2855:b0:72b:700e:21eb with SMTP id
 el21-20020a170907285500b0072b700e21ebmr20656742ejc.270.1658998656661; Thu, 28
 Jul 2022 01:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220728063856.72705-1-zhangjiachen.jaycee@bytedance.com>
In-Reply-To: <20220728063856.72705-1-zhangjiachen.jaycee@bytedance.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 28 Jul 2022 10:57:25 +0200
Message-ID: <CAJfpegsAf=VzvC=ej+60bHgK7zOoKwQehabTAmvNYQPCQwmFKA@mail.gmail.com>
Subject: Re: [PATCH] ovl: only WARN_ON_ONCE() if dentry is NULL in ovl_encode_fh()
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Hongbo Yin <yinhongbo@bytedance.com>,
        Tianci Zhang <zhangtianci.1997@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, 28 Jul 2022 at 08:39, Jiachen Zhang
<zhangjiachen.jaycee@bytedance.com> wrote:
>
> Some code paths cannot guarantee the inode have any dentry alias. So
> WARN_ON() all !dentry may flood the kernel logs.
>
> For example, when an overlayfs inode is watched by inotifywait (1), and
> someone is trying to read the /proc/$(pidof inotifywait)/fdinfo/INOTIFY_FD,
> at that time if the dentry has been reclaimed by kernel (such as
> echo 2 > /proc/sys/vm/drop_caches), there will be a WARN_ON(). The
> printed call stack would be like:
>
>     ? show_mark_fhandle+0xf0/0xf0
>     show_mark_fhandle+0x4a/0xf0
>     ? show_mark_fhandle+0xf0/0xf0
>     ? seq_vprintf+0x30/0x50
>     ? seq_printf+0x53/0x70
>     ? show_mark_fhandle+0xf0/0xf0
>     inotify_fdinfo+0x70/0x90
>     show_fdinfo.isra.4+0x53/0x70
>     seq_show+0x130/0x170
>     seq_read+0x153/0x440
>     vfs_read+0x94/0x150
>     ksys_read+0x5f/0xe0
>     do_syscall_64+0x59/0x1e0
>     entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> So let's replace WARN_ON() with WARN_ON_ONCE() to avoid kernel log
> flooding.

Better just drop the WARN_ON() completely in that case, since it's a
normally occurring condition.

Thanks,
Miklos
