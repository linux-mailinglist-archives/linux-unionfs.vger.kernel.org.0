Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF84013EEE
	for <lists+linux-unionfs@lfdr.de>; Sun,  5 May 2019 12:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfEEKpG (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 5 May 2019 06:45:06 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41226 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfEEKpG (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 5 May 2019 06:45:06 -0400
Received: by mail-yw1-f68.google.com with SMTP id o65so6357828ywd.8
        for <linux-unionfs@vger.kernel.org>; Sun, 05 May 2019 03:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=grYaOZkxpqmPQvo7Yg++rOTUtQ3PhyvWDoiFrE+9T/Y=;
        b=WCA1P+8sCSkuFBttPzEkCjGzx6ZgUG2fVF1c0x4Kx8UBCHQHr4pqck+SJRZpXP9iTL
         EfZYbUZH3UB/uuFLGTb8s7o1iF4ZsT3hxt0omc8ypS9TE0l9F4Kdx+pLhmHLDzEGIgx+
         3zfivOB1bPXZwb57slmvWB29/BNI+5t5cLIui9KsGVifSHZv/U/ZbiQ3kJWlRJB/3jiA
         33lHaLbmf80dqFJ1GgxsfcBYAeuRtaihtyXtVJhihzbWu7NQT52GSbPtJesl3ouBOotS
         +Yb2A5SEwk4oi0UTke8EmjFtRT1NPpX9n9PKhMARF+MXDEfGvrFo5NMPT6uaRlKvPJm2
         GtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=grYaOZkxpqmPQvo7Yg++rOTUtQ3PhyvWDoiFrE+9T/Y=;
        b=jyz7anDmRirYmI3AQg46ZQpXWT2lO10TkedwJStAC4P5GiAKlT8sbxxa0ehLlxFYxn
         dMYSaedOAwrHAjcMxhK2hCsM1GEeA+RINAnaNlc7eAMioiocf8AYlYcgnRgtQj+SaMcO
         h5gUDG2IBNikHGX9PAERX1ZWVkHLTijJLR3DJB7J82xfDDzPNSTiuKjWC28QQhfiWFsT
         jIxkhK9o5xIuL/jexZl99zQgkMjB94hP0m6HC2HhfaR+hKyhu9RvbLpZdcSiTi+zFu8O
         7MUTZAiH3nGYl0uG8vZwjcsHyaXKM0p1zL83NUVt4iJXvvifUcC99cvLD2seYhSxqLJH
         KbEA==
X-Gm-Message-State: APjAAAW0rNpD5jYCsRaI+mph8fB0p/HOD735vBVsDBZ/GEVvBhHLr8FV
        HoYgsPHinu5HSVqD/wSAYlCcKbzI6NdRktqerq3mwiLItLE=
X-Google-Smtp-Source: APXvYqzDZf+x7hpnHPgpVSg3GrmwnpTfzfP3nSRxt2YYAQXKTwMnpTBfhCcynvxRAvCOGoHhAbFidKTb3yElrU9ihLU=
X-Received: by 2002:a25:74c9:: with SMTP id p192mr14321263ybc.507.1557053105045;
 Sun, 05 May 2019 03:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <3393f96c-e9a7-2882-f210-81a9c332a138@linux.alibaba.com>
In-Reply-To: <3393f96c-e9a7-2882-f210-81a9c332a138@linux.alibaba.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 5 May 2019 13:44:53 +0300
Message-ID: <CAOQ4uxgkO23o8yPdeu060oeU6CwhvQs9f+R0qFEiQGLA1SdL6w@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5Bbug_report=5D_chattr_=2Bi_succeed_in_docker_which_d?=
        =?UTF-8?Q?on=E2=80=98t_have_the_capability_CAP=5FLINUX=5FIMMUTABLE?=
To:     Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Sun, May 5, 2019 at 12:27 PM Jiufei Xue <jiufei.xue@linux.alibaba.com> wrote:
>
> Hi,
>
> We are using kernel v4.19.24 and have found that it can be successful
> when we set IMMUTABLE_FL flag to a file in docker while the docker
> didn't have the capability CAP_LINUX_IMMUTABLE.
>
> # touch tmp
> # chattr +i tmp
> # lsattr tmp
> ----i--------e-- tmp
>
> We have tested this case in older version such as 4.9 and it returned
> -EPERM as expected.
>
> We found that the commit d1d04ef8572b ("ovl: stack file ops") and
> dab5ca8fd9dd ("ovl: add lsattr/chattr support") implemented chattr
> operations on a regular overlay file. ovl_real_ioctl() overridden the
> current process's subjective credentials with ofs->creator_cred which
> have the capability CAP_LINUX_IMMUTABLE so that it will return success
> in vfs_ioctl()->cap_capable().
>
> I wondered is this kind of mechanism of overlayfs or a bug?
>

It's a bug, but I am not sure how to fix it.
If we want to check IMMUTABLE_FL and APPEND_FL permissions
in ovl_ioctl() we need to execute FS_IOC_GETFLAGS on upper
file to know if we are changing those flags.

Note that overlayfs also (never) copied up those flags, so if flags
exist in lower fs they are lost on copy up.
Therefore, if we remove ovl_override_creds() from ovl_real_ioctl()
if lower inode has APPEND_FL it will be removed on copy up
and chattr +S by user without CAP_LINUX_IMMUTABLE will fail
because it will do FS_IOC_GETFLAGS from lower and then
FS_IOC_SETFLAGS that will do copy up and try to set both
APPEND_FL and SYNC_FL on upper inode.

Best I can come up with is store flags in overlay inode on
FS_IOC_GETFLAGS and check changes against stored
flags on  FS_IOC_SETFLAGS. It relies on the fact that
chattr always calls FS_IOC_GETFLAGS before it calls
FS_IOC_SETFLAGS (even with the usage chattr =<flags>).

Want to try and write a patch and test?

Thanks,
Amir.
