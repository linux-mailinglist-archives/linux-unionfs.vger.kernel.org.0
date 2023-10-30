Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5AB7DBCD5
	for <lists+linux-unionfs@lfdr.de>; Mon, 30 Oct 2023 16:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbjJ3Pl1 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 30 Oct 2023 11:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjJ3Pl0 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 30 Oct 2023 11:41:26 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B88B7
        for <linux-unionfs@vger.kernel.org>; Mon, 30 Oct 2023 08:41:24 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9becde9ea7bso1201146366b.0
        for <linux-unionfs@vger.kernel.org>; Mon, 30 Oct 2023 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1698680482; x=1699285282; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+B5V87Wgylgu5326bEDIYWKGT3pn5la4XhSjLpBZPGQ=;
        b=lwy5tNLIOVoz4usWEWjbIXfBHavdOFutubR8nGYtTPuTkWUdkezQ7amyXQNeA9GGd7
         bHBiYYBYYRAvuaaK42+p7+RSfkc9UQKh6+h8vcwIFlKUBjsmU/7eCjL++FjCfXwcOjLo
         QbRjAm7tcBKEFpCwJw8BvMe7PmYo/BsoeqpCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698680482; x=1699285282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+B5V87Wgylgu5326bEDIYWKGT3pn5la4XhSjLpBZPGQ=;
        b=SqnFRBgK2o2o16x4JxKyMGbOgW+ev4A3GIbIhnich0rlHlScwNBZY81blPM5yoAavL
         1ZpWZ1I5u45gk32qvPAoVZJ8S/6O9MCnq+2foW5APPpPtAVyxEai4Dxs+VCu1R9wTq9Z
         FfTN77Da/fNsX+RTgy1JTdaDItOEws1uXOPHbOhFe88g2sBxPXCSg12Yi3kWlRV72rPZ
         wvotBFee8nmojPyuim2UuUqsHjlcwA7ZB9sNMkWoFpUD1dLjIVsjTmmdf+/WYzFJraOE
         yYwZpXtczU96FdaHDrBtHv61ILBK7IDn5H8TAwYTmx3j4UjGQgrxskIKv7ymSwUdN8k8
         9OPA==
X-Gm-Message-State: AOJu0YzqHAJmnIZCU8RWfEEMh/HUV/36AfWS4/h5VMCzQWWVnRrg9tdq
        8qzGXC5PAv2rhn8PfY03aK4ktIuAef667e2NK7Rw+A==
X-Google-Smtp-Source: AGHT+IEWz/BtFbgKPasppQaRnehIntmsQ6eZEeymmOJ4VQeDtvkdlQoaWYOgPlkP444xKbT9BNkykwWBhBzvRl9oCUk=
X-Received: by 2002:a17:907:1b1a:b0:9b7:4ec2:444e with SMTP id
 mp26-20020a1709071b1a00b009b74ec2444emr217ejc.8.1698680482608; Mon, 30 Oct
 2023 08:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231030120419.478228-1-amir73il@gmail.com>
In-Reply-To: <20231030120419.478228-1-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 30 Oct 2023 16:41:11 +0100
Message-ID: <CAJfpegvMtqk6eiLvGbC+2oQDHSP6M2HEZVWzTFpVpbWN6GCaOQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] ovl: new mount options lowerdir+,datadir+
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, 30 Oct 2023 at 13:04, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Miklos,
>
> As discussed, here are the patches for the new mount options.
>
> - Only string format is supported
> - Legacy lowerdir= cannot be mixed with new lowerdir+,datadir+
> - lowerdir+,datadir+ are not escaped
> - lowerdir,upperdir,workdir are escaped as always
>
> I did not find a good reason to change escaping of upperdir,workdir.
> We can skip escaping when we add support for path format.

Looks good, other than the minor error reporting issue.

Thanks,
Miklos
