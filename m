Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BA15827AF
	for <lists+linux-unionfs@lfdr.de>; Wed, 27 Jul 2022 15:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiG0N3W (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 27 Jul 2022 09:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiG0N3V (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 27 Jul 2022 09:29:21 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B5223147
        for <linux-unionfs@vger.kernel.org>; Wed, 27 Jul 2022 06:29:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s9so2167113edd.8
        for <linux-unionfs@vger.kernel.org>; Wed, 27 Jul 2022 06:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IZC9NEhf05++/nyq+KA7I22wmZBHbNz5U6HDcm4S/Gg=;
        b=QUUOmuOPdKZaVDwP46yrsLjlhkNgx236+kyN/pzXLVNcxS/NNPOaK65eDooxwLXVTM
         7xZlGcil5YXcGY2dQxkP9AOJCuJWaniWL+0O0w4JQqZv26KEttY1pQEwaUdLFlj5+rET
         zt8oSojN1OGpy+0kYuNE3JOp1opZbgdI5BdAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IZC9NEhf05++/nyq+KA7I22wmZBHbNz5U6HDcm4S/Gg=;
        b=nkrThR5nkjszbQ4swWjxM+3UWYc0TMu+0E25aGL19I7M7H0+ePeMZizFLg1mcUGXNK
         d+iADwnFLJ+IZ+l5WzyPcZ2r6UYi7LHnKL1bIQnv5pWFjy8MFgYMoumaxCka1VKAMHem
         Xvs7J/tmKfPu8IPOHCOCASBLxJiSmf2pJSVZmTo3JlNk4Qvk4/Khu95sU1dJIzc1zDlo
         lO9LqPr8ApMusb2jbZhXZplKNrkGQ//GkN6P+ocJijCmsb9rm9CZaVZvDjP6CX9aODx6
         SSSo781JfCCYyv3d9a5wkCJdAAgnwIpmvBbdW7BcnR/MRB+j56E+DjVuglUIuIftvfi5
         0rlw==
X-Gm-Message-State: AJIora/+8VEA8H5WngKPYu+5i9kFafXxrAQ3HvS3PPX8HEYr7/yai5vm
        +UrpwpDQSPlIkFu6VV5jq/Q0DTaFjBKh1Dwhg10FSw==
X-Google-Smtp-Source: AGRyM1sR1qNmR47DsRJObhi68nvBusP+p+yzQluzwv7oyanNwWa7tQ/pkPkv8OVezPa2wPPBbBHcLYo2moJEHGpHtEc=
X-Received: by 2002:a05:6402:4247:b0:43c:12a7:6bf4 with SMTP id
 g7-20020a056402424700b0043c12a76bf4mr13170002edb.374.1658928559169; Wed, 27
 Jul 2022 06:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220713073217.2663078-1-williamsukatube@163.com>
In-Reply-To: <20220713073217.2663078-1-williamsukatube@163.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 27 Jul 2022 15:29:07 +0200
Message-ID: <CAJfpegt_pYg5ypOP+Epd5s=jg5K-g_drTPyOSAdy61d_-0PPiA@mail.gmail.com>
Subject: Re: [PATCH] ovl: Fix a potential memory leak for kstrdup()
To:     williamsukatube@163.com
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, 13 Jul 2022 at 09:33, <williamsukatube@163.com> wrote:
>
> From: William Dean <williamsukatube@gmail.com>
>
> kfree() is missing on an error path to free the memory
> allocated by kstrdup():
>
> config->redirect_mode = kstrdup(ovl_redirect_mode_def(), GFP_KERNEL);
>
> So it is better to free it via kfree(config->redirect_mode).

Will be freed in ovl_free_fs().

Thanks,
Miklos
