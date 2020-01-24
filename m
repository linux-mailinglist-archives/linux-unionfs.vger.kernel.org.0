Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF601478AD
	for <lists+linux-unionfs@lfdr.de>; Fri, 24 Jan 2020 07:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgAXGuD (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 24 Jan 2020 01:50:03 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43489 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730310AbgAXGuB (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 24 Jan 2020 01:50:01 -0500
Received: by mail-io1-f67.google.com with SMTP id n21so856158ioo.10
        for <linux-unionfs@vger.kernel.org>; Thu, 23 Jan 2020 22:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4d1fPVXo4k99mZEf3oxn3/dm1FbeL88HhoRHhZ1X/k=;
        b=FeMAWmtqcY3gR8IhfHYHvxo7feypEMsxUz0bBCLE6Ud/Elg3OWsZ+oG29XSLvb3MoC
         n5aLLfI2eVaSLKTMx8VAM7+2HTWCb20eYLzgJVX/DZplOuufnF7tnftjc9jGKaYgZwjM
         1ZvLdQqg9W6YDCkcycXSmeeH2s4sFZC+ZEjikEbvQrCWlPKMyY4iJBBNm7MDzTbPbGqg
         7odwIelR2SAPpsvmikbjHy0rTuz4tyl8aHzoLDvGYlHhtxANBoqMMD42boVijZnVTB6C
         UKE/V8Mzd/a0fKoVrCubGTkhF56D46Xyq0QdDOsG/FKf9RwtRatf4LfzcHVPGbHV32mx
         kbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4d1fPVXo4k99mZEf3oxn3/dm1FbeL88HhoRHhZ1X/k=;
        b=qEDwvAA9I1//aAh5muAGNsFNHm2Q55KOwRiMZzWHGO2eFRhVBjAdDoCJ7Ey4Kw+qqf
         6NNxq0yS1h5rcH76SGEIecw3WXyvYc3RSgQX5O3avZLA3rLYLACyF+ORVvPPrNYejvLD
         zusysYS74ytr/90xNw2AwocacxOS+RKANyn4V02LguZgNQI/KCJdRCn8Vmj2HfGQdgJl
         jvRyULZTCFoFZWYPmOI03me4eQ3u0kcN9VT5DeMGzE4j3K5VKMkbMcdtldyiUx1AeTQZ
         Jez9wpwNSenOOooDnHuqhWzd7TU+YmUlHNiu7W8CyAqY3rImciqBCudiGkrm7nhQutQH
         4r1g==
X-Gm-Message-State: APjAAAXZnNQvL4pnEwPUQPb1H/b17cbY+vkDix3uNC/VfadxbXXS+SFR
        8fykjAyuRysQSqKYNLDPzOXBta2xXKEvIxV/i71yfR6I
X-Google-Smtp-Source: APXvYqxcc8oh0IS1wKhwaiAlvOSC3JqjLrfwqzCI8R4vDkNuo2XUQVE3ELRaHyDZ8ji9rV756ovFzGxxiCqciBb1E20=
X-Received: by 2002:a5e:a616:: with SMTP id q22mr450048ioi.250.1579848600885;
 Thu, 23 Jan 2020 22:50:00 -0800 (PST)
MIME-Version: 1.0
References: <20191223064025.23801-1-amir73il@gmail.com> <CAOQ4uxh4NygFUFvUp3xs8rZRUkc3SDxO1DL6YrNhx3j0SBgAJg@mail.gmail.com>
 <CAOQ4uxjsiQ5PKYSPLmgk5b5O_e5255+QK8Obgs9K--cTi3z=7w@mail.gmail.com> <CAJfpegtcpqhiOqbdCCEz5_h=2WbYDWvLihAUYPC9KkB-uCmDbg@mail.gmail.com>
In-Reply-To: <CAJfpegtcpqhiOqbdCCEz5_h=2WbYDWvLihAUYPC9KkB-uCmDbg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 24 Jan 2020 08:49:49 +0200
Message-ID: <CAOQ4uxh3b1AEBEAax8OvXvyUXw5K9YJNo-tqvWuKdSpJVdYBRg@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix wrong WARN_ON() in ovl_cache_update_ino()
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

> I'm working this into the next batch bound for 5.6, unless something
> more urgent comes up before that.
>

overlayfs-next tested.
ovl-ino rebased.

You would probably want to squash the "merge conflict" below to overlayfs-next.

Thanks,
Amir.


--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1348,7 +1348,7 @@ static int ovl_get_layers(struct super_block
*sb, struct ovl_fs *ofs,
         */
        err = get_anon_bdev(&ofs->fs[0].pseudo_dev);
        if (err) {
-               pr_err("overlayfs: failed to get anonymous bdev for
upper fs\n");
+               pr_err("failed to get anonymous bdev for upper fs\n");
                goto out;
        }

@@ -1409,7 +1409,7 @@ static int ovl_get_layers(struct super_block
*sb, struct ovl_fs *ofs,
         */
        if (ofs->numfs - !ofs->upper_mnt == 1) {
                if (ofs->config.xino == OVL_XINO_ON)
-                       pr_info("overlayfs: \"xino=on\" is useless
with all layers on same fs, ignore.\n");
+                       pr_info("\"xino=on\" is useless with all
layers on same fs, ignore.\n");
                ofs->xino_mode = 0;
        } else if (ofs->config.xino == OVL_XINO_ON && ofs->xino_mode < 0) {
