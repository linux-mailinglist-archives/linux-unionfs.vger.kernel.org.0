Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A44B32B80C
	for <lists+linux-unionfs@lfdr.de>; Mon, 27 May 2019 17:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfE0PA4 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 27 May 2019 11:00:56 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38763 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfE0PA4 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 27 May 2019 11:00:56 -0400
Received: by mail-it1-f196.google.com with SMTP id i63so24419967ita.3
        for <linux-unionfs@vger.kernel.org>; Mon, 27 May 2019 08:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Lc57E7riR7pcaDGK7J31LCr2OGsECGyxVHwxNgaxZE=;
        b=mM7ljQS+BNSmQQhs5COUe1789TmQjVjrim1guSaj6W6s/Y2/67x9Dbd8kPVmZXm79C
         BkVQNoiEDtOFZAeXJcmIPv1NoD99vQLlXe274IOzClYtH7fWWOYqWRhLKJ6NrH2JJkJ+
         Z0QqwzWGtvpDP0gbdHBn+Oc3tdLgVlwYwcnYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Lc57E7riR7pcaDGK7J31LCr2OGsECGyxVHwxNgaxZE=;
        b=OXnv96GrWJ3kdGb1VnjKTjt/SbNS9fAb8A2eV383Y4SfpDktDBTQCNE2XAPZ1s91M/
         0OawCjB4ESDd+9e4LVlvrMdI1uTgsMCpTG3g9EnRAOx0u6cWc62sBdyUNhReAw/sNSgz
         kTypHTHKQBfL1RfjBviga5s0y7bjjAxTKkylj2OSzUTHVpdO3JIJvLziUchtYco+QGWC
         NQHqCW32aeSl1+kigOz0h9uvuC33ClFJavPcs3n1dK7VSMYUl2I/iQouiw3B/KxyFRcT
         8IzKjx2WlmY/IfaYJfPnlAldf9U1eA4I6apTtFEIQYLhJZ0GETpdw7h0D6gmF4wd04db
         qm4g==
X-Gm-Message-State: APjAAAUgpgYBuQoG6lKR3LECMh0qkVlkY38hAnk9s/41kl6Y4FhFNrzx
        qTnS2LBCLqVOv4JKgdGGryYJK5PqTZRRl6xMQvji/Ipv
X-Google-Smtp-Source: APXvYqxTaZt9XF/UTBIkSNkM5+xHdXkaRKyc/+hzFDe+0WJizLIQa/V3liRY6Co/rKtN/UKHeXLv7MzxfnhPGHP5DKk=
X-Received: by 2002:a24:9d8b:: with SMTP id f133mr30145435itd.118.1558969255443;
 Mon, 27 May 2019 08:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190418144208.21832-1-amir73il@gmail.com>
In-Reply-To: <20190418144208.21832-1-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 27 May 2019 17:00:44 +0200
Message-ID: <CAJfpegvCcShc9DNJtrOxmtAtChMgvYT-yDbiZS5wBQgusnMhHg@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: detect overlapping layers
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, Apr 18, 2019 at 4:42 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Overlapping overlay layers are not supported and can cause unexpected
> behavior, but overlayfs does not currently check or warn about these
> configurations.
>
> User is not supposed to specify the same directory for upper and
> lower dirs or for different lower layers and user is not supposed to
> specify directories that are descendants of each other for overlay
> layers, but that is exactly what this zysbot repro did:
>
>     https://syzkaller.appspot.com/x/repro.syz?x=12c7a94f400000
>
> Moving layer root directories into other layers while overlayfs
> is mounted could also result in unexpected behavior.
>
> This commit places "traps" in the overlay inode hash table.
> Those traps are dummy overlay inodes that are hashed by the layers
> root inodes.
>
> On mount, the hash table trap entries are used to verify that overlay
> layers are not overlapping.  While at it, we also verify that overlay
> layers are not overlapping with directories "in-use" by other overlay
> instances as upperdir/workdir.
>
> On lookup, the trap entries are used to verify that overlay layers
> root inodes have not been moved into other layers after mount.
>
> Some examples:
>
> $ ./run --ov --samefs -s
> ...
> ( mkdir -p base/upper/0/u base/upper/0/w base/lower lower upper mnt
>   mount -o bind base/lower lower
>   mount -o bind base/upper upper
>   mount -t overlay none mnt ...
>         -o lowerdir=lower,upperdir=upper/0/u,workdir=upper/0/w)
>
> $ umount mnt
> $ mount -t overlay none mnt ...
>         -o lowerdir=base,upperdir=upper/0/u,workdir=upper/0/w
>
>   [   94.434900] overlayfs: overlapping upperdir path
>   mount: mount overlay on mnt failed: Too many levels of symbolic links
>
> $ mount -t overlay none mnt ...
>         -o lowerdir=upper/0/u,upperdir=upper/0/u,workdir=upper/0/w
>
>   [  151.350132] overlayfs: conflicting lowerdir path
>   mount: none is already mounted or mnt busy
>
> $ mount -t overlay none mnt ...
>         -o lowerdir=lower:lower/a,upperdir=upper/0/u,workdir=upper/0/w
>
>   [  201.205045] overlayfs: overlapping lowerdir path
>   mount: mount overlay on mnt failed: Too many levels of symbolic links
>
> $ mount -t overlay none mnt ...
>         -o lowerdir=lower,upperdir=upper/0/u,workdir=upper/0/w
> $ mv base/upper/0/ base/lower/
> $ find mnt/0
>   mnt/0
>   mnt/0/w
>   find: 'mnt/0/w/work': Too many levels of symbolic links
>   find: 'mnt/0/u': Too many levels of symbolic links
>
> Reported-by: syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Applied, thanks.

Miklos
