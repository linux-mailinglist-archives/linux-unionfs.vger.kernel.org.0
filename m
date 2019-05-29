Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA762DAF7
	for <lists+linux-unionfs@lfdr.de>; Wed, 29 May 2019 12:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfE2KnG (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 29 May 2019 06:43:06 -0400
Received: from mail-yb1-f175.google.com ([209.85.219.175]:46271 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfE2KnG (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 29 May 2019 06:43:06 -0400
Received: by mail-yb1-f175.google.com with SMTP id p8so586824ybo.13
        for <linux-unionfs@vger.kernel.org>; Wed, 29 May 2019 03:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eonbqDCHsVuiHrhUN5KUYPEGi4gZzmkyK9BMR88OEes=;
        b=SkNqup0MVT+R21oxpXgOdBq3DQmLKetH8ad6EogR5uQUXUnU0L0HEV0htHk/VcTWgR
         RXlRmBJD+TLnoxFdtAhhY0RzUzpXeWlQKRwvUvpc0qEJ1pU2Qgz7w4Ss6WrWgOplN5uH
         ue6yQEnFUyNyxjZkXoLxMbmKF87dDkX/X89AThCDBCGMOmkhnp00kjFDbfDcAwBclKEM
         AT8dRMl+JX/FclrXIN93KWiE8EQRfvrsDlP5mFjk1pykDw6VLAiyzx+1idwRMTtmYHhH
         M+U1j1KznUKXEFWkBTDh1pGPh2iWrX8EEjjp3w3SiKAYgoP6+kSWCmw4hxbW9SoB114r
         3EcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eonbqDCHsVuiHrhUN5KUYPEGi4gZzmkyK9BMR88OEes=;
        b=cUGfj5oNfSDO7lbz3kKmA2O+Evc/NDvR0bEqLau0RutqakUbdT4k26RYJfzbGSWux2
         hrKG8eV6cDedmaVaUyMrXYWwdW64U/sYm6N8n5RfqlKLJx77YSKWy315XkQoBk8RJJo7
         KymSxLsxdgjo3dx3lEHOcQEckl60Hctw829esAQmF20RQqMWqZM5AjEsM2FfAqzUIc+X
         wRyAk3aPWt/56AZEU414Oo4jzmi7X/3bjtNYhV1jDL5mLtAg0SSqAShQuJtZxZdTU7wA
         RKfzJHBN4fe1z6/ktD9XGaYMYGTRH65iKLSu9VvkNd9n2KS+b/HXHlKB5YQsWJOirbgR
         Befg==
X-Gm-Message-State: APjAAAUpVWVYLJVyzSXoOsVEnOa/VKyXfOwjdiNQBZ7KZ79+GASzyFYr
        M4Q2a/BN9WJzrjAuhnbtZ2vfJCMuh4XNb3u9Hj42uwk9
X-Google-Smtp-Source: APXvYqwfZpfynXaRdVMGsnOzlFm/MzPIwMJLh0wMcwOi8wf4Uh6Y6jtcPvZ+lXQmMt2yMK2tkvQLvWJN7OOLBvxnYsA=
X-Received: by 2002:a25:c983:: with SMTP id z125mr57864097ybf.45.1559126585713;
 Wed, 29 May 2019 03:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190529103120.GA15021@mwanda>
In-Reply-To: <20190529103120.GA15021@mwanda>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 29 May 2019 13:42:54 +0300
Message-ID: <CAOQ4uxjZi-XF17+GT1iQYEHmr18AiZpTjL1M_HhGPaLhtSvBxQ@mail.gmail.com>
Subject: Re: [bug report] ovl: detect overlapping layers
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, May 29, 2019 at 1:31 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Amir Goldstein,
>
> The patch 0e7f2cccb42a: "ovl: detect overlapping layers" from Apr 18,
> 2019, leads to the following static checker warning:
>
>         fs/overlayfs/super.c:998 ovl_setup_trap()
>         warn: passing a valid pointer to 'PTR_ERR'
>
> fs/overlayfs/super.c
>    991  static int ovl_setup_trap(struct super_block *sb, struct dentry *dir,
>    992                            struct inode **ptrap, const char *name)
>    993  {
>    994          struct inode *trap;
>    995          int err;
>    996
>    997          trap = ovl_get_trap_inode(sb, dir);
>    998          err = PTR_ERR(trap);
>    999          if (IS_ERR(trap) && err == -ELOOP) {
>   1000                  pr_err("overlayfs: conflicting %s path\n", name);
>   1001                  return err;
>   1002          }
>   1003
>   1004          *ptrap = trap;
>   1005          return 0;
>   1006  }
>
> The warning message is wrong but the code is also wrong.  The
> ovl_get_trap_inode() can return ERR_PTR(-ENOMEM) and that would lead to
> and Oops when we try to call iput() on it.
>

Right, thank you for spotting this!

Miklos,

Can you fold in this fix:

Thanks,
Amir.

--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -996,8 +996,9 @@ static int ovl_setup_trap(struct super_block *sb,
struct dentry *dir,

        trap = ovl_get_trap_inode(sb, dir);
        err = PTR_ERR(trap);
-       if (IS_ERR(trap) && err == -ELOOP) {
-               pr_err("overlayfs: conflicting %s path\n", name);
+       if (IS_ERR(trap)) {
+               if (err == -ELOOP)
+                       pr_err("overlayfs: conflicting %s path\n", name);
                return err;
        }
