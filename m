Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 212BFAFBE1
	for <lists+linux-unionfs@lfdr.de>; Wed, 11 Sep 2019 13:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfIKLul (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 11 Sep 2019 07:50:41 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43284 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfIKLul (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 11 Sep 2019 07:50:41 -0400
Received: by mail-io1-f67.google.com with SMTP id r8so20100409iol.10
        for <linux-unionfs@vger.kernel.org>; Wed, 11 Sep 2019 04:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R3UrGvJBTbdXrtP79UGFfhmzZPm7pw1Hlf0qzr2G4WA=;
        b=ZmaNRoYTyH1VXv1LKP8FnlCe/r1V9d4YLvPjZItmPVQRH4QzIuSZOPhUjdXv5hTQAk
         Wt3OoE+0jBYAFSQHTP6EsCv5d1vwZn7ZwW657rAqihtkgBWm4KK/3Z8WAYSktWMvz9m4
         htjFy0i078PlMH84+g9FFw1BAUZA07+AFPiD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R3UrGvJBTbdXrtP79UGFfhmzZPm7pw1Hlf0qzr2G4WA=;
        b=CfeUx0kKoLmbEqSn5EgMuqfz2HNtLgP/CBaKXvvNLCp925r68hLYemYJtt6zGTnmT5
         pawHIRQ/nSRb6mUlUofu6EtJgEDH+ib2AtsVNV6YQlCJ8a23l1+rCxvLa1CCokBqK1nO
         cSAlIfSW3PZl3VQv4Ng2qsLE36QTmc6cSglQvuwuGLWmjl6aKcUt3fDe8nXDPlqOxDXF
         Wr/6CGnENuv4cweuZpmsZYvATinvm19YtPcM6YfovYjvfqWdVTf8W7whBKD0PSfQ7eB3
         zRVMumesIfb8ucuNgdCIEUzPKjhFNE0OkXncbknOaPN1kNtgwCbe6IxPnoZ8a5cypmtF
         tDiw==
X-Gm-Message-State: APjAAAVj9LjdZn2R315up94uATFUEqd6mG9/0zrCqxBI2hwu0W95hnvl
        nxuWdbw1LcmbBQlGM/ZUSqAK6kpWwsHIhVQ7z86erQ==
X-Google-Smtp-Source: APXvYqyMK5BlNR9C+OMxkCR0EBf7DRaQ4XvoaprVQQ4Db2zaDqL65MJOb2jN6uBpb4/gJelmsX789mjWSgwftZwSxwA=
X-Received: by 2002:a05:6602:21cb:: with SMTP id c11mr215542ioc.25.1568202640309;
 Wed, 11 Sep 2019 04:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190712122434.14809-1-amir73il@gmail.com> <CAOQ4uxg+equ2vt3xqsC_v=m=YMFSAj2ywk2pga=BGZWgOQcVoA@mail.gmail.com>
 <CAOQ4uxhC_=oPcjwpzgq7YvZuFL=HWJ=9hXwcY=EupcAnLobcsA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhC_=oPcjwpzgq7YvZuFL=HWJ=9hXwcY=EupcAnLobcsA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 11 Sep 2019 13:50:29 +0200
Message-ID: <CAJfpegvQzAmDHhoXh-aSPjmkqLSpP_KWOf08YED4H7uwqa-oVg@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix regression caused by overlapping layers detection
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Colin Walters <walters@verbum.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Sep 10, 2019 at 3:53 PM Amir Goldstein <amir73il@gmail.com> wrote:

> This patch got stuck in overlayfs-next.
> Could you push it to Linus please?

Just tested applied on top of -linus, and it fails overlayfs/065 with this:

--- /root/xfstests-dev/tests/overlay/065.out    2019-06-18
15:12:19.147000000 +0200
+++ /root/xfstests-dev/results//overlay/065.out.bad    2019-09-11
13:22:34.612000000 +0200
@@ -1,8 +1,8 @@
 QA output created by 065
 Conflicting upperdir/lowerdir
-mount: device already mounted or mount point busy
+mount: /scratch/ovl-mnt: mount(2) system call failed: Too many levels
of symbolic links
 Conflicting workdir/lowerdir
-mount: device already mounted or mount point busy
+mount: /scratch/ovl-mnt: mount(2) system call failed: Too many levels
of symbolic links
 Overlapping upperdir/lowerdir
 mount: Too many levels of symbolic links
 Conflicting lower layers

So the mount seems to fail, but with a different than expected error
value.  Do you know what might be happening?

Thanks,
Miklos
