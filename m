Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CFC7F0499
	for <lists+linux-unionfs@lfdr.de>; Sun, 19 Nov 2023 07:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjKSG5l (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 19 Nov 2023 01:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSG5l (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 19 Nov 2023 01:57:41 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B73B9;
        Sat, 18 Nov 2023 22:57:37 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-778a92c06d6so217853285a.2;
        Sat, 18 Nov 2023 22:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700377057; x=1700981857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLW6HkzVdYCeJUhhGeIdlWYHgI3B8sPyX+6CznAB6nM=;
        b=VO5ovyEzEEg/tQaVNFSY8laRB5HqdQDzTIeB6pa01sWuvuILanglU5wU9jkta/nVHt
         7ymL0n7P1YRw/GdYyScx2CpYsiynGPTaG3ohMFiOKC28DubrA3ssjSy7T/aaWT9UNXGO
         K+IdZW+W3RN61l3DTOt5pUwsr6jQWKfJLHCp6hgF89mkUbPA9ziCmx9mtE96iThk/jTq
         bX1MW7/f3mwW+OULVAaFW2ClXkvZo/Wxpg0jsA3CK+cX9jIJMB4Q5OVrfv4gVQiI6rcl
         P+B4GNRjPT1hmI5L3Jpt6afHx+lZH75teP4sIf9Z2oHasEZTNFkVaRebtRNWttFezqOc
         qmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700377057; x=1700981857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLW6HkzVdYCeJUhhGeIdlWYHgI3B8sPyX+6CznAB6nM=;
        b=E34yku+eRMh1wYZeMiUgUfgpAVOEQ4c9hpSk9iqHtsb/q23SeKGlVwLH4uGVmbbIrT
         BomJWc7zstbhoqqIJ4mbGkkAKLoWiuWA3uDQvUsmAo5LvI6lJ9qL1tLYPB/+jKnjcZnU
         m0nqc3orZ7Vg0SGY3Y+j62ny5HX3vU6YVZaKhQaVOMAH+hb3VNyRWhE7r/ee2qkVXHKQ
         0IO+fykEjk0DbAYDwTQOFq0i45HSx9gkh/f9HAe1jw5r5myJO6JkpjX7+Uu7wZ4csHdM
         TR0CEzUeGfHLRPhUzPdU7SgSubzyq5TAWjUzVzLddtoEwJs0UrUDlfpXnSNnX4yq5fDr
         kM3A==
X-Gm-Message-State: AOJu0YwyhtF5VQIl5GIuzoj54J3xNB5PsYPEHLTZ/FPHp7pnkoDobc9n
        yrXXsmCRtmUO6Vs3r43q/t8lAzVaMoghsmpAFCzwKKgSsMQ=
X-Google-Smtp-Source: AGHT+IE1eUT+XD8Pjchmw/G1UGy3fbSeVfH0CWORZrkiOvGhpNs/T80TDjKWawCcRVw/as2je4CHYFGgO5y/yJyJNeE=
X-Received: by 2002:a05:6214:c2a:b0:647:406b:4b06 with SMTP id
 a10-20020a0562140c2a00b00647406b4b06mr4486521qvd.57.1700377056880; Sat, 18
 Nov 2023 22:57:36 -0800 (PST)
MIME-Version: 1.0
References: <20231111080400.GO1957730@ZenIV> <CAOQ4uxhQdHsegbwdqy_04eHVG+wkntA2g2qwt9wH8hb=-PtT2A@mail.gmail.com>
 <20231111185034.GP1957730@ZenIV> <CAOQ4uxjYaHk6rWUgvsFA4403Uk-hBqjGegV4CCOHZyh2LSYf4w@mail.gmail.com>
 <CAOQ4uxiJSum4a2F5FEA=a8JKwWh1XhFOpWaH8xas_uWKf+29cw@mail.gmail.com> <20231118200247.GF1957730@ZenIV>
In-Reply-To: <20231118200247.GF1957730@ZenIV>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 19 Nov 2023 08:57:25 +0200
Message-ID: <CAOQ4uxjFrdKS3_yyeAcfemL-8dXm3JDWLwAmD9w3bY90=xfCjw@mail.gmail.com>
Subject: Re: [RFC][overlayfs] do we still need d_instantiate_anon() and export
 of d_alloc_anon()?
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Sat, Nov 18, 2023 at 10:02=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Sun, Nov 12, 2023 at 09:26:28AM +0200, Amir Goldstein wrote:
>
> > Tested the patch below.
> > If you want to apply it as part of dcache cleanup, it's fine by me.
> > Otherwise, I will queue it for the next overlayfs update.
>
> OK...  Let's do it that way - overlayfs part goes into never-rebased bran=
ch
> (no matter which tree), pulled into dcache series and into your overlayfs
> update, with removal of unused stuff done in a separate patch in dcache
> series.
>

Sounds good.

> That way we won't step on each other's toes when reordering, etc.
> Does that work for you?  I can put the overlayfs part into #no-rebase-ove=
rlayfs
> in vfs.git, or you could do it in a v6.7-rc1-based branch in your tree -
> whatever's more convenient for you.

I've reset overlayfs-next to no-rebase-overlayfs, as it  had my version
with removal so far.

For the final update, I doubt I will need to include it at all, because
the chances of ovl_obtain_alias() colliding with anything for the next
cycle are pretty slim, but it's good that I have the option and I will
anyway make sure to always test the next update with this change.

Thanks,
Amir.
