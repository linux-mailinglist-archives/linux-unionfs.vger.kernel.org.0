Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 850DE120492
	for <lists+linux-unionfs@lfdr.de>; Mon, 16 Dec 2019 12:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfLPL65 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 16 Dec 2019 06:58:57 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35488 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfLPL64 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 16 Dec 2019 06:58:56 -0500
Received: by mail-io1-f65.google.com with SMTP id v18so5591207iol.2
        for <linux-unionfs@vger.kernel.org>; Mon, 16 Dec 2019 03:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iBPKLYYc8Xi6jZpPoRvSVAVt+YuZ/amTfSmG/PRyQVA=;
        b=oJW3mcAE62qWZuvFRaWC4Swwk/FqyVm9mJJyFd/0Dyx7qkEyGgjpAK0ssIyl5hWjKT
         AK2QxufzH1PHVpilbD0YaO+Dw2hVFg1jXCNxyvytvzMKrlt4DhaUfQJ1GNq3ldZ1zq1p
         DZ9Kt9bb5x6+XZvGZJMj2RzH3rPN6VO+k37y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBPKLYYc8Xi6jZpPoRvSVAVt+YuZ/amTfSmG/PRyQVA=;
        b=VK9ie81hMVvOY9YWOoYRe4dVkFSzwnPm2/Th5hBLLOBaQ8Atjf4+D6NKLkSONlTcFb
         sOvQqUG4QE5syCC7PqzZ3Nf5zgsP60Ia902nA+r4reLVoDmFURIWgWDNVeB29AtEMMer
         D4Uob9H9Sikrx3VepCoJHWo7G64dN8VXj9tHojKaxpeqZz9aUUK0Nm3asIWPl9atvAC+
         3wz3JOqe/cYY3j9WHGFOQuRXwZX4c4hEciDJsBckiyQ3GtUXP6A8oQnSvb4YTB24bHgA
         8aX3TLuEqIt/ia2QwbrHBWQiigcv0Izm2GERGz9TK1CvaQzBGp6Q8X0QGxmZ7M0Rk+CQ
         NI4A==
X-Gm-Message-State: APjAAAWpbiSWU0YY0lrcamkk32rUq4dgrktoPq7e7zqhit3kaRf0TG6n
        abiZ+82CFGOINubyoSxoot/+jvaeHVXrTldqvIsJlg==
X-Google-Smtp-Source: APXvYqzZKtKX+t/Xc+EUm7y6SQPxlAVYolP69bgsk5R036Uihx2cWE9Fgjc3Xi0GnbkTvlaDv8EOk7G1W62dO56Px+k=
X-Received: by 2002:a02:2446:: with SMTP id q6mr3668631jae.78.1576497535832;
 Mon, 16 Dec 2019 03:58:55 -0800 (PST)
MIME-Version: 1.0
References: <20191101123551.8849-1-cgxu519@mykernel.net> <CAOQ4uxi6g=UmfCjtZiyfgPhHc9+NCOQBQ++YeBTWmJaXjDNX_g@mail.gmail.com>
In-Reply-To: <CAOQ4uxi6g=UmfCjtZiyfgPhHc9+NCOQBQ++YeBTWmJaXjDNX_g@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 16 Dec 2019 12:58:44 +0100
Message-ID: <CAJfpegv39gDaVwLXx4+Vzb75Bv2fOfCHX8-bjS0N9QRkXo=G1Q@mail.gmail.com>
Subject: Re: [PATCH v4] ovl: improving copy-up efficiency for big sparse file
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Chengguang Xu <cgxu519@mykernel.net>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, Dec 12, 2019 at 4:43 PM Amir Goldstein <amir73il@gmail.com> wrote:

> It's the same old story that was fixed in commit:
> 6d0a8a90a5bb ovl: take lower dir inode mutex outside upper sb_writers lock
>
> The lower overlay inode mutex is taken inside ovl_llseek() while upper fs
> sb_writers is held since ovl_maybe_copy_up() of nested overlay.
>
> Since the lower overlay uses same real fs as nested overlay upper,
> this could really deadlock if the lower overlay inode is being modified
> (took inode mutex and trying to take real fs sb_writers).
>
> Not a very common case, but still a possible deadlock.
>
> The only way to avoid this deadlock is probably a bit too hacky for your taste:
>
>         /* Skip copy hole optimization for nested overlay */
>         if (old->mnt->mnt_sb->s_stack_depth)
>                 skip_hole = false;
>
> The other way is to use ovl_inode_lock() in ovl_llseek().
>
> Have any preference? Something else?
>
> Should we maybe use ovl_inode_lock() also in ovl_write_iter() and
> ovl_ioctl_set_flags()? In all those cases, we are not protecting the overlay
> inode members, but the real inode members from concurrent modification
> through overlay.

Possibly.   I think this whole thing needs a good analysis of i_rwsem
use in overlayfs.

Thanks,
Miklos
