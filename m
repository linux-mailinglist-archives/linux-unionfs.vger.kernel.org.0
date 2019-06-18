Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF9FC49CC1
	for <lists+linux-unionfs@lfdr.de>; Tue, 18 Jun 2019 11:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfFRJNC (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 18 Jun 2019 05:13:02 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44400 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbfFRJNB (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 18 Jun 2019 05:13:01 -0400
Received: by mail-yw1-f65.google.com with SMTP id l79so6403305ywe.11
        for <linux-unionfs@vger.kernel.org>; Tue, 18 Jun 2019 02:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XywuI29qSHG00+yadPxt2M+ih9N2nOc8Y0BW0cF5lbo=;
        b=QGk0KFawi7BW0OB253O5mlg0wJ1msJCfuwdzuNcUqQEIBXvfbgP47hZGHByZLXwkTX
         Cl0PZxFhzzYLMj8dQiK7zLqBrHJUHsSeu8bAp2n+Uc25kDz0ze3U/sWtEHaBbcJoat/v
         eeSzhfqi/7kEGsBTAsRYUWzyc/EMfpchSQ1e4j7czhPe8YsFL/OidtGj+NT+D1At5qtP
         6u6TCOXHNXGEo2ln0fKft/7GB9QJ866BGUjJatWBlPZSl885dXdRpGTz0hSTw5NdMqRS
         M0F6uljBb7HvJCdwCOuFBF4UCm2/5vbfZ3tH13dAHFkoJ71SUVDfRhDdJZJlI/goIsQL
         UsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XywuI29qSHG00+yadPxt2M+ih9N2nOc8Y0BW0cF5lbo=;
        b=hYSYnoAdsY1DPQOPKAGgUmPHeQYMccmnsbujL0Qwvxi4qHfIxxiMRozM9WinNX8pRM
         M67WtPJ30ypEKiVv7ZvLksNbHSLmcBKs8BsIKYFUz/o4k9YLtbyEfGnVeC+BeRUgMFDO
         bOo7zkeI127uPGROwMMNaw67HhqD8zhwTYm2tBSwxjnYJnh+3/su5EP25aQCo/ekwSCv
         EeRL9H78DA0aAuHhId2YK0LqG+EI+Vc9QP+Fdqdvoy+syM4HXvjTMPCG6KKdWqy44uVC
         IENW/L2AtT/gZgB9A1PsRYilH5ZxTje5IIXqorUzYonSonf505rQ0XSi2mD515uMPbu/
         +eNQ==
X-Gm-Message-State: APjAAAWenLPh0Dryhz32u+qsvr8FsFkp+nYedONFvP7u9T+Etj6mkBhf
        4YWFWto4ntHJOeHS0sLaR4VYgPz2ZNn7j4QyaRAc1g==
X-Google-Smtp-Source: APXvYqzbwmS96ritLI/F4AL2adGlv1tpuIb45MK+sw8za+/YVk/FNxd2vgYRJ5qQy95w4ZR+oTa3jCr5XdiST76AL5c=
X-Received: by 2002:a81:910a:: with SMTP id i10mr49510016ywg.31.1560849180290;
 Tue, 18 Jun 2019 02:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190611150928.12175-1-amir73il@gmail.com>
In-Reply-To: <20190611150928.12175-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 18 Jun 2019 12:12:49 +0300
Message-ID: <CAOQ4uxgt1wm+fWuCzTizLXnejGRFWQySfCTzDMSyBFMo0-5K4Q@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix wrong flags check in FS_IOC_FS[SG]ETXATTR ioctls
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Jun 11, 2019 at 6:09 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> The ioctl argument was parsed as the wrong type.
>
> Fixes: b21d9c435f93 ("ovl: support the FS_IOC_FS[SG]ETXATTR ioctls")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Miklos,
>
> Please take this braino fix through the "fast track".
> I have now an xfstest to verify the fix is correct.
> Will post it shortly.
>
> Thanks,
> Amir.

Since this is a rc4 bug, I am increasing the nudge-factor.

Thanks,
Amir.

>
>  fs/overlayfs/file.c | 91 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 65 insertions(+), 26 deletions(-)
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 340a6ad45914..75d8d00fa087 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -409,37 +409,16 @@ static long ovl_real_ioctl(struct file *file, unsigned int cmd,
>         return ret;
>  }
>
> -static unsigned int ovl_get_inode_flags(struct inode *inode)
> -{
> -       unsigned int flags = READ_ONCE(inode->i_flags);
> -       unsigned int ovl_iflags = 0;
> -
> -       if (flags & S_SYNC)
> -               ovl_iflags |= FS_SYNC_FL;
> -       if (flags & S_APPEND)
> -               ovl_iflags |= FS_APPEND_FL;
> -       if (flags & S_IMMUTABLE)
> -               ovl_iflags |= FS_IMMUTABLE_FL;
> -       if (flags & S_NOATIME)
> -               ovl_iflags |= FS_NOATIME_FL;
> -
> -       return ovl_iflags;
> -}
> -
>  static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
> -                               unsigned long arg)
> +                               unsigned long arg, unsigned int iflags)
>  {
>         long ret;
>         struct inode *inode = file_inode(file);
> -       unsigned int flags;
> -       unsigned int old_flags;
> +       unsigned int old_iflags;
>
>         if (!inode_owner_or_capable(inode))
>                 return -EACCES;
>
> -       if (get_user(flags, (int __user *) arg))
> -               return -EFAULT;
> -
>         ret = mnt_want_write_file(file);
>         if (ret)
>                 return ret;
> @@ -448,8 +427,8 @@ static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
>
>         /* Check the capability before cred override */
>         ret = -EPERM;
> -       old_flags = ovl_get_inode_flags(inode);
> -       if (((flags ^ old_flags) & (FS_APPEND_FL | FS_IMMUTABLE_FL)) &&
> +       old_iflags = READ_ONCE(inode->i_flags);
> +       if (((iflags ^ old_iflags) & (S_APPEND | S_IMMUTABLE)) &&
>             !capable(CAP_LINUX_IMMUTABLE))
>                 goto unlock;
>
> @@ -469,6 +448,63 @@ static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
>
>  }
>
> +static unsigned int ovl_fsflags_to_iflags(unsigned int flags)
> +{
> +       unsigned int iflags = 0;
> +
> +       if (flags & FS_SYNC_FL)
> +               iflags |= S_SYNC;
> +       if (flags & FS_APPEND_FL)
> +               iflags |= S_APPEND;
> +       if (flags & FS_IMMUTABLE_FL)
> +               iflags |= S_IMMUTABLE;
> +       if (flags & FS_NOATIME_FL)
> +               iflags |= S_NOATIME;
> +
> +       return iflags;
> +}
> +
> +static long ovl_ioctl_set_fsflags(struct file *file, unsigned int cmd,
> +                                 unsigned long arg)
> +{
> +       unsigned int flags;
> +
> +       if (get_user(flags, (int __user *) arg))
> +               return -EFAULT;
> +
> +       return ovl_ioctl_set_flags(file, cmd, arg,
> +                                  ovl_fsflags_to_iflags(flags));
> +}
> +
> +static unsigned int ovl_fsxflags_to_iflags(unsigned int xflags)
> +{
> +       unsigned int iflags = 0;
> +
> +       if (xflags & FS_XFLAG_SYNC)
> +               iflags |= S_SYNC;
> +       if (xflags & FS_XFLAG_APPEND)
> +               iflags |= S_APPEND;
> +       if (xflags & FS_XFLAG_IMMUTABLE)
> +               iflags |= S_IMMUTABLE;
> +       if (xflags & FS_XFLAG_NOATIME)
> +               iflags |= S_NOATIME;
> +
> +       return iflags;
> +}
> +
> +static long ovl_ioctl_set_fsxflags(struct file *file, unsigned int cmd,
> +                                  unsigned long arg)
> +{
> +       struct fsxattr fa;
> +
> +       memset(&fa, 0, sizeof(fa));
> +       if (copy_from_user(&fa, (void __user *) arg, sizeof(fa)))
> +               return -EFAULT;
> +
> +       return ovl_ioctl_set_flags(file, cmd, arg,
> +                                  ovl_fsxflags_to_iflags(fa.fsx_xflags));
> +}
> +
>  static long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
>         long ret;
> @@ -480,8 +516,11 @@ static long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>                 break;
>
>         case FS_IOC_SETFLAGS:
> +               ret = ovl_ioctl_set_fsflags(file, cmd, arg);
> +               break;
> +
>         case FS_IOC_FSSETXATTR:
> -               ret = ovl_ioctl_set_flags(file, cmd, arg);
> +               ret = ovl_ioctl_set_fsxflags(file, cmd, arg);
>                 break;
>
>         default:
> --
> 2.17.1
>
