Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7DD28173
	for <lists+linux-unionfs@lfdr.de>; Thu, 23 May 2019 17:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbfEWPmZ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 23 May 2019 11:42:25 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33907 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730790AbfEWPmY (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 23 May 2019 11:42:24 -0400
Received: by mail-yb1-f195.google.com with SMTP id v78so2449633ybv.1
        for <linux-unionfs@vger.kernel.org>; Thu, 23 May 2019 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HG+j7TY4DpRygHM3UrEQnXHNxQFQduonZ8w3weg/d/I=;
        b=EMyZh2QrYPOvgtB7HmtrEzm8xQ/D4BVCda8dVDnbmi613jd9tG2vmdrEOOg1C9IqlY
         oD5nNCJajmfvtexAgGdpl0qK6iuRf1BCly0sUDnHonwU2rKtrwu/Y/atBTnSlfJImw1b
         5lfDl/3YkkWDcSXNa3DeBU2MRQcq5p93rGziMqlMl6OQ4Fx3xy3yWIL5MaQF7Rdh7sG/
         GFDTH5jdCD0AMx1rm8sqNeBsLKokAcgSOja/cpebp2n7VweLnDQm4FGwgjg5CkWMTQ8i
         Ln0mhJYGyn/jrpUunOe92viYUTa4KrfMB1QPIHkypGUNzNfzott6eKYFKy5IfyYjuNR3
         Ox/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HG+j7TY4DpRygHM3UrEQnXHNxQFQduonZ8w3weg/d/I=;
        b=CzVk9F3FnxZGwmLmwYSD0/7+SGFHP9+JlOQbgButqlvaqgSKwNnTo7iIUMxU+2E40R
         1mYxL92+qVv2c4aj/QLoKa9lerXWyLftIuwTdVQVd55LNVXhUDU8aGajqvkC9yQzGKmS
         IWlp+B/6O5KZOJ8Jo1t+Wl0nKszlNZ+1bnuJzv/bxACvRCNk7Z+w9ML6vLFLdvd/iLdv
         ZWvV38ybOq6WjbmkJBJSX6avNHXpc7VSXAW9BqxsrMwQmK8zZC3SRzZZ9VmXwydooA+q
         7Mp1ySK8KoBFea9slUU2FZhLU04H+Qfe21oWc2ZvOqFvV/OG5la1X51wVk+ws4aBFrLh
         tZ7A==
X-Gm-Message-State: APjAAAUlwhNRAgIVjiWJ/cJyl+ArG+tvWB6/f+oa+JfzLbN/OhfSraOY
        OmueELZPNh/SqAJkMHqHxurIXxTPP++Sv+N7n24EiS8P
X-Google-Smtp-Source: APXvYqzrZwkBCcuERlWxIAk2bsM/tTtR7k8B6E5kHavtuCJDaNJ5XJDBBiL+gCx4BoMgygsKFhQqqHMfvIuU0F0xAg0=
X-Received: by 2002:a25:c983:: with SMTP id z125mr42226333ybf.45.1558626143949;
 Thu, 23 May 2019 08:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190523134549.23103-1-chrubis@suse.cz>
In-Reply-To: <20190523134549.23103-1-chrubis@suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 23 May 2019 18:42:12 +0300
Message-ID: <CAOQ4uxhHVG9f1njmPgei8-QO4UEivXbxoHkqKi4f50XN6Gup9A@mail.gmail.com>
Subject: Re: [LTP] [PATCH] [COMMITTED] syscalls/fcntl33: Fix typo overlapfs -> overlayfs
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     ltp@lists.linux.it, overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Petr Vorel <pvorel@suse.cz>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, May 23, 2019 at 4:45 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/syscalls/fcntl/fcntl33.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl33.c b/testcases/kernel/syscalls/fcntl/fcntl33.c
> index 43dc5a2af..627823c5c 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl33.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl33.c
> @@ -117,7 +117,7 @@ static void do_test(unsigned int i)
>         if (TST_RET == -1) {
>                 if (type == TST_OVERLAYFS_MAGIC && TST_ERR == EAGAIN) {
>                         tst_res(TINFO | TTERRNO,
> -                               "fcntl(F_SETLEASE, F_WRLCK) failed on overlapfs as expected");
> +                               "fcntl(F_SETLEASE, F_WRLCK) failed on overlayfs as expected");

You have 3 more of this typo in fcntl tests.

If you ask me, silencing this error seems wrong.
While the error is *expected* it is still a broken interface.
It may be just a matter of terminology, but I am reading this message as:

TEST PASSED: Overlayfs failed as expected

While it really should be more along the lines of:

TEST SKIPPED: Overlayfs doesn't support write leased

Besides, this problem looks quite easy to fix.
I think Bruce was already looking at changing the implementation of
check_conflicting_open(), so if the test is not failing, nobody is going to
nudge for a fix...

Thanks,
Amir.
