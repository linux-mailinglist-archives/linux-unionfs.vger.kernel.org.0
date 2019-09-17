Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7689B5072
	for <lists+linux-unionfs@lfdr.de>; Tue, 17 Sep 2019 16:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfIQOeb (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 17 Sep 2019 10:34:31 -0400
Received: from kueppers.informatik.uni-koeln.de ([134.95.9.149]:56340 "EHLO
        kueppers.informatik.uni-Koeln.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728210AbfIQOea (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 17 Sep 2019 10:34:30 -0400
Received: from suenner.informatik.uni-Koeln.de (suenner [134.95.9.136])
        by kueppers.informatik.uni-Koeln.de (8.15.2/8.15.2/Debian-8) with ESMTP id x8HEYS9m009467;
        Tue, 17 Sep 2019 16:34:28 +0200
Received: from suenner.informatik.uni-Koeln.de (localhost [127.0.0.1])
        by suenner.informatik.uni-Koeln.de (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id x8HEYRJl020386;
        Tue, 17 Sep 2019 16:34:27 +0200
Received: (from lange@localhost)
        by suenner.informatik.uni-Koeln.de (8.15.2/8.15.2/Submit) id x8HEYR49020385;
        Tue, 17 Sep 2019 16:34:27 +0200
From:   Thomas Lange <lange@informatik.uni-koeln.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <23936.61171.958066.468358@informatik.uni-koeln.de>
Date:   Tue, 17 Sep 2019 16:34:27 +0200
To:     Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: can overlayfs work wit NFS v4 as lower fs?
In-Reply-To: <CAJfpegu0FprqEkgU2rDCiu-2nr=jwzS3wNZAj6oV-DEdv+v=eQ@mail.gmail.com>
References: <23935.36189.612024.342204@informatik.uni-koeln.de>
        <CAJfpegsk30wCJY1WaQWJOibfw35TGYxUuPBYx8v7xObJBSgTAw@mail.gmail.com>
        <23936.43370.127198.222503@informatik.uni-koeln.de>
        <CAJfpegu0FprqEkgU2rDCiu-2nr=jwzS3wNZAj6oV-DEdv+v=eQ@mail.gmail.com>
X-Mailer: VM 8.2.0b under 26.1 (x86_64-pc-linux-gnu)
CC:     linux-unionfs@vger.kernel.org
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

>>>>> On Tue, 17 Sep 2019 15:26:28 +0200, Miklos Szeredi <miklos@szeredi.hu> said:

    > Ah, the way to disable these is to disable acl on the exported filesystem.  I.e.
    > mount -oremount,noacl $EXPORTED_FS
That works perfect for me. Thanks a lot for your help.

It would be nice to add a note about this in the kernel
overlayfs.txt. What about this:

 The lower filesystem can be any filesystem supported by Linux and does
-not need to be writable.  The lower filesystem can even be another
+not need to be writable. If you are using an NFS v4 mount as lower
+filesystem, you should disable acl on the exported filesystem.
+The lower filesystem can even be another

-- 
regards Thomas
