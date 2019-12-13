Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B81011E37A
	for <lists+linux-unionfs@lfdr.de>; Fri, 13 Dec 2019 13:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfLMMTs (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 13 Dec 2019 07:19:48 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34429 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfLMMTs (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 13 Dec 2019 07:19:48 -0500
Received: by mail-yb1-f195.google.com with SMTP id k17so748138ybp.1
        for <linux-unionfs@vger.kernel.org>; Fri, 13 Dec 2019 04:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ea3ZA2nKLwruyb0gF6pAGWKj6zUIoag3zRsJ8IXEyts=;
        b=nLjmhC5Rk8hZIhhIzev0aRnuYQQi++wjwNRJtBmdWic7tE76vCFR3SNmnZidlzXDTn
         olRWvyeo41mLhAn2QVo7/UFH3SI2mc4khnc9KgU7+JwmqyZbFEUUiv/MZYFxYZVcxsXp
         W1qQCGjpfHIDdq6TK8Ap5TL5p4wiWIcbztJobputQkxsQmQPNruL8e+Q7s3lwVE2QC1F
         NPE3bco3+7StMEcQmkWmQp5hXtUUMczFUixQdO3ztiLtRnPDlC6qA38baqHBsQOBbIsP
         gcWb49I0+jmVQh1Ok7jWOtAUSMkCCB45g2mrU9JXlLdO4w4chm5IATmjUHFHOEGYPR8r
         IeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ea3ZA2nKLwruyb0gF6pAGWKj6zUIoag3zRsJ8IXEyts=;
        b=d28tvQNjc6pTOHQFu/fwq/+lIUE8e64AW+69l4j6/pvqUOl6kMydk/46woPaZzBwZy
         DxplLvj4+sKlnOk0h2+dHa6bMpmHO82mB342BcLQKgYetBwcmTppgAG96choM5OXs/nm
         p4w3towTUzBZgWSCk3sQQQeJHxhcPmsA2lJICnUHR7oE3BCWU6x9TNUjwTKxZjk5oPOt
         UFU9Q1+186ytSEfAL9UH3PKAmUm0tvJCQGZ9kcbVqu+c8G1LuvEZAPR0vfaJR7IOYaci
         XKjUQf68t/dp9nSZScQ3nRO/dGgBklPhsZxg1Zh8KY9i59Z3JhGEfn6TAzKR/rYZY/WW
         o8VQ==
X-Gm-Message-State: APjAAAXJsEbomoTIc0kNil+MeEMAIxF2V+jvcj81ZPpBcsRtWWsPLo3B
        qcD0IrCPOqZGsxuYPLSVJe3k2APHEkAAv0lvRAk=
X-Google-Smtp-Source: APXvYqyd+PAJlRHl6xT26QLqrm9ABoXWxXoRqGyWzmuoyssTDF91VIHZEiIjemmM4JXps9g68TjqjlIU69+AeSmprRU=
X-Received: by 2002:a25:3803:: with SMTP id f3mr8107360yba.144.1576239587439;
 Fri, 13 Dec 2019 04:19:47 -0800 (PST)
MIME-Version: 1.0
References: <1e61319cf6d1f3c8f313a01b0198be4745f9f460.1576208513.git.lijiazi@xiaomi.com>
In-Reply-To: <1e61319cf6d1f3c8f313a01b0198be4745f9f460.1576208513.git.lijiazi@xiaomi.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 13 Dec 2019 14:19:36 +0200
Message-ID: <CAOQ4uxifkz9wFSo58SWeru58tOvfLC_S436QiSx0Hn-XaC-Vnw@mail.gmail.com>
Subject: Re: [PATCH] ovl: use pr_fmt auto generate prefix
To:     lijiazi <jqqlijiazi@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, lijiazi <lijiazi@xiaomi.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Fri, Dec 13, 2019 at 1:13 PM lijiazi <jqqlijiazi@gmail.com> wrote:
>
> Use pr_fmt auto generate "overlayfs: " prefix.
>
> Signed-off-by: lijiazi <lijiazi@xiaomi.com>
> ---
>  fs/overlayfs/Makefile    |  4 +--
>  fs/overlayfs/copy_up.c   |  2 +-
>  fs/overlayfs/dir.c       | 10 +++---
>  fs/overlayfs/export.c    | 12 +++----
>  fs/overlayfs/inode.c     |  6 ++--
>  fs/overlayfs/namei.c     | 26 +++++++--------
>  fs/overlayfs/overlayfs.h |  6 ++++
>  fs/overlayfs/readdir.c   |  8 ++---
>  fs/overlayfs/super.c     | 85 ++++++++++++++++++++++++------------------------
>  fs/overlayfs/util.c      | 14 ++++----
>  10 files changed, 90 insertions(+), 83 deletions(-)
>
> diff --git a/fs/overlayfs/Makefile b/fs/overlayfs/Makefile
> index 9164c58..73ba668 100644
> --- a/fs/overlayfs/Makefile
> +++ b/fs/overlayfs/Makefile
> @@ -3,7 +3,7 @@
>  # Makefile for the overlay filesystem.
>  #
>
> -obj-$(CONFIG_OVERLAY_FS) += overlay.o
> +obj-$(CONFIG_OVERLAY_FS) += overlayfs.o
>
> -overlay-objs := super.o namei.o util.o inode.o file.o dir.o readdir.o \
> +overlayfs-objs := super.o namei.o util.o inode.o file.o dir.o readdir.o \
>                 copy_up.o export.o

But see ef94b1864d1e ovl: rename filesystem type to "overlay"

You can just use the string "overlayfs:" instead of KBUILD_MODNAME.

Thanks,
Amir.
