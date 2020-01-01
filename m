Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E425012DFDE
	for <lists+linux-unionfs@lfdr.de>; Wed,  1 Jan 2020 18:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgAAR6e (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 1 Jan 2020 12:58:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54365 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbgAAR6e (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 1 Jan 2020 12:58:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id b19so3900241wmj.4
        for <linux-unionfs@vger.kernel.org>; Wed, 01 Jan 2020 09:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vIKlWSeOTcmAVPjwfcAQ5dtZhhA26mTehZtQSsoh4rQ=;
        b=UTk4HKrpPeI0IMgdpjUAP2fNpYfXmK1RgyWuPiVu5FVcZgPYfV7+SFBm/HKyknGwEO
         yQLUM3NyvfA/THp9gqhg995KNORmq1j7XsyTdIxA5SoMA45SbCP/Th2tAJlcSlCNe3yQ
         zx8gxRxUg5hCR7i9T83pILdNP3DyGRMwJ8zBxfRHviy7fVDiW8mKRKvKr7d5eLp1WbQ2
         ZpRfkOuy5LfarfwMl7i2VYPKUYAKqZzgm4sUyo5sHUSsSuTKWxfWd/VFMLK2guFsJsux
         xTc1ShFBXvFtxNR/zDMyLpY5hc1XAUbrWSNZiY90+EXoBaWJhsBdYgDPE2D/rydmVRLB
         e8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vIKlWSeOTcmAVPjwfcAQ5dtZhhA26mTehZtQSsoh4rQ=;
        b=YwRr45dn7Nt7b3uoYCA1CmbNcWRHDtXZhkDli6oXZhbxyg3h/iwVMCpfE+oYL1IYg7
         XBbc5wym1lioadvvGNaKB1bmXFEysYbQt7ohAZFSidMkzGWntJfAcrzdkwUf1V+1qIR9
         WTdkEC3hUSvxEoxwD7Ot9yDWCo370hHG7M2uLWZBxZFYfl6KmWxaMy4fHOInMiOAN1lv
         FuGDUbEScWK63R2Mo2CZ3Bz1BlXqj4xPeFOHoPk7eZjoLxg6iVDLfl0pJkkyNBTL++q5
         xUBim2h5ZptZ6DoMlD1I5c1jJs6G4tVsrgsFTKDmhc/f60Wkl3myJaBnp1BfSYO+HLyk
         G29Q==
X-Gm-Message-State: APjAAAXf4AAycBDbPdJfq7o6/d4vNAuXqABqLQpZMSgvp8kmYpcCXdLT
        cy1u7Gsk0FCv8Sl29kYALo8=
X-Google-Smtp-Source: APXvYqx/zdRScNT9lAYwZOyVCykT1ate5XQvVk2hhPeQsL/mjqgynCLBOmKdz+Vch1+RWP9ZMUIwvQ==
X-Received: by 2002:a05:600c:2549:: with SMTP id e9mr10698724wma.6.1577901512164;
        Wed, 01 Jan 2020 09:58:32 -0800 (PST)
Received: from localhost.localdomain ([141.226.169.66])
        by smtp.gmail.com with ESMTPSA id z3sm53274778wrs.94.2020.01.01.09.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 09:58:31 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org
Subject: [PATCH 7/7] ovl: document xino expected behavior
Date:   Wed,  1 Jan 2020 19:58:14 +0200
Message-Id: <20200101175814.14144-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200101175814.14144-1-amir73il@gmail.com>
References: <20200101175814.14144-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Summarize the inode properties of different configurations in a table.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 Documentation/filesystems/overlayfs.rst | 38 +++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index e443be7928db..fcd8537b8402 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -40,13 +40,46 @@ On 64bit systems, even if all overlay layers are not on the same
 underlying filesystem, the same compliant behavior could be achieved
 with the "xino" feature.  The "xino" feature composes a unique object
 identifier from the real object st_ino and an underlying fsid index.
+
 If all underlying filesystems support NFS file handles and export file
 handles with 32bit inode number encoding (e.g. ext4), overlay filesystem
 will use the high inode number bits for fsid.  Even when the underlying
 filesystem uses 64bit inode numbers, users can still enable the "xino"
 feature with the "-o xino=on" overlay mount option.  That is useful for the
 case of underlying filesystems like xfs and tmpfs, which use 64bit inode
-numbers, but are very unlikely to use the high inode number bit.
+numbers, but are very unlikely to use the high inode number bits.  In case
+the underlying inode number does overflow into the high xino bits, overlay
+filesystem will fall back to the non xino behavior for that inode.
+
+The following table summarizes what can be expected in different overlay
+configurations.
+
+Inode properties
+````````````````
+
++--------------+------------+------------+-----------------+----------------+
+|Configuration | Persistent | Uniform    | st_ino == d_ino | d_ino == i_ino |
+|              | st_ino     | st_dev     |                 | [*]            |
++==============+=====+======+=====+======+========+========+========+=======+
+|              | dir | !dir | dir | !dir |  dir   +  !dir  |  dir   | !dir  |
++--------------+-----+------+-----+------+--------+--------+--------+-------+
+| All layers   |  Y  |  Y   |  Y  |  Y   |  Y     |   Y    |  Y     |  Y    |
+| on same fs   |     |      |     |      |        |        |        |       |
++--------------+-----+------+-----+------+--------+--------+--------+-------+
+| Layers not   |  N  |  Y   |  Y  |  N   |  N     |   Y    |  N     |  Y    |
+| on same fs,  |     |      |     |      |        |        |        |       |
+| xino=off     |     |      |     |      |        |        |        |       |
++--------------+-----+------+-----+------+--------+--------+--------+-------+
+| xino=on/auto |  Y  |  Y   |  Y  |  Y   |  Y     |   Y    |  Y     |  Y    |
+|              |     |      |     |      |        |        |        |       |
++--------------+-----+------+-----+------+--------+--------+--------+-------+
+| xino=on/auto,|  N  |  Y   |  Y  |  N   |  N     |   Y    |  N     |  Y    |
+| ino overflow |     |      |     |      |        |        |        |       |
++--------------+-----+------+-----+------+--------+--------+--------+-------+
+
+[*] nfsd v3 readdirplus verifies d_ino == i_ino. i_ino is exposed via several
+/proc files, such as /proc/locks and /proc/self/fdinfo/<fd> of an inotify
+file descriptor.
 
 
 Upper and Lower
@@ -383,7 +416,8 @@ guarantee that the values of st_ino and st_dev returned by stat(2) and the
 value of d_ino returned by readdir(3) will act like on a normal filesystem.
 E.g. the value of st_dev may be different for two objects in the same
 overlay filesystem and the value of st_ino for directory objects may not be
-persistent and could change even while the overlay filesystem is mounted.
+persistent and could change even while the overlay filesystem is mounted, as
+summarized in the `Inode properties`_ table above.
 
 
 Changes to underlying filesystems
-- 
2.17.1

