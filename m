Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE34421A1AA
	for <lists+linux-unionfs@lfdr.de>; Thu,  9 Jul 2020 16:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGIOC0 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 9 Jul 2020 10:02:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35690 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbgGIOC0 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 9 Jul 2020 10:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594303345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=l9wiuPF7CNBdgguTw2kU5bfibEmZXIMMNaJ08n51z9k=;
        b=fK268XpmN7Y9dTX8J+iGj6nBn04jZJ3ml9e3p7sqZfgkJt7iLDRMjm9TzHEc9FcRV0m4/e
        aDyxqC4e29BEW0yVfedH5RqPAjwqW4qSV9UQABLOWW/vc9R1pHkB9SPE4J9Dz/KUJ/6spR
        rQLIyQZIo/Q57hSQ5ADXUtJlrDRiXE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-dY7_4vx6MmGM8H8__00kHw-1; Thu, 09 Jul 2020 10:02:23 -0400
X-MC-Unique: dY7_4vx6MmGM8H8__00kHw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F34505EB;
        Thu,  9 Jul 2020 14:02:21 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-114.rdu2.redhat.com [10.10.115.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 750C41001B07;
        Thu,  9 Jul 2020 14:02:21 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 98527220689; Thu,  9 Jul 2020 10:02:20 -0400 (EDT)
Date:   Thu, 9 Jul 2020 10:02:20 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org
Subject: [PATCH] overlayfs, doc: Do not allow lower layer recreation with
 redirect_dir enabled
Message-ID: <20200709140220.GC150543@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Currently we seem to support lower layer recreation and re-use with existing
upper until and unless "index" or "metadata only copy up" feature is
enabled.

If redirect_dir feature is enabled then re-creating/modifying lower layers
will break things. For example.

- mkdir lower lower/foo upper work merged
- touch lower/foo/foo-child
- mount -t overlay -o lowerdir=lower,upperdir=upper,workdir=work,redirect_dir=on none merged
- mv merged/foo merged/bar
- ls merged/bar/ (this should list foo-child)

- umount merged
- mv lower/foo lower/baz
- mount -t overlay -o lowerdir=lower,upperdir=upper,workdir=work,redirect_dir=on none merged
- ls merged/bar/  (Now foo-child has disappeared)

IOW, modifying lower layers did not crash overlay but it resulted in
directory contents being lost and that can be unexpected. So don't
support lower layer recreation/modification when redirect_dir is enabled
at any point of time.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 Documentation/filesystems/overlayfs.rst | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index 660dbaf0b9b8..1d1a8da7fdbc 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -371,8 +371,8 @@ conflict with metacopy=on, and will result in an error.
 [*] redirect_dir=follow only conflicts with metacopy=on if upperdir=... is
 given.
 
-Sharing and copying layers
---------------------------
+Sharing, copying and recreating lower layers
+--------------------------------------------
 
 Lower layers may be shared among several overlay mounts and that is indeed
 a very common practice.  An overlay mount may use the same lower layer
@@ -388,8 +388,12 @@ though it will not result in a crash or deadlock.
 
 Mounting an overlay using an upper layer path, where the upper layer path
 was previously used by another mounted overlay in combination with a
-different lower layer path, is allowed, unless the "inodes index" feature
-or "metadata only copy up" feature is enabled.
+different lower layer path, is allowed, unless any of the following features
+is enabled at any point of time.
+
+- inode index
+- metadata only copy up
+- redirect_dir
 
 With the "inodes index" feature, on the first time mount, an NFS file
 handle of the lower layer root directory, along with the UUID of the lower
-- 
2.25.4

