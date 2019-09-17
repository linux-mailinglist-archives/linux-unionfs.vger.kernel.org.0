Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29978B4AC6
	for <lists+linux-unionfs@lfdr.de>; Tue, 17 Sep 2019 11:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfIQJhw (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 17 Sep 2019 05:37:52 -0400
Received: from kueppers.informatik.uni-koeln.de ([134.95.9.149]:47116 "EHLO
        kueppers.informatik.uni-Koeln.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728276AbfIQJhv (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 17 Sep 2019 05:37:51 -0400
Received: from suenner.informatik.uni-Koeln.de (suenner [134.95.9.136])
        by kueppers.informatik.uni-Koeln.de (8.15.2/8.15.2/Debian-8) with ESMTP id x8H9bmB8002814;
        Tue, 17 Sep 2019 11:37:48 +0200
Received: from suenner.informatik.uni-Koeln.de (localhost [127.0.0.1])
        by suenner.informatik.uni-Koeln.de (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id x8H9bmej013467;
        Tue, 17 Sep 2019 11:37:48 +0200
Received: (from lange@localhost)
        by suenner.informatik.uni-Koeln.de (8.15.2/8.15.2/Submit) id x8H9bmTs013466;
        Tue, 17 Sep 2019 11:37:48 +0200
From:   Thomas Lange <lange@informatik.uni-koeln.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <23936.43370.127198.222503@informatik.uni-koeln.de>
Date:   Tue, 17 Sep 2019 11:37:46 +0200
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: can overlayfs work wit NFS v4 as lower fs?
In-Reply-To: <CAJfpegsk30wCJY1WaQWJOibfw35TGYxUuPBYx8v7xObJBSgTAw@mail.gmail.com>
References: <23935.36189.612024.342204@informatik.uni-koeln.de>
        <CAJfpegsk30wCJY1WaQWJOibfw35TGYxUuPBYx8v7xObJBSgTAw@mail.gmail.com>
X-Mailer: VM 8.2.0b under 26.1 (x86_64-pc-linux-gnu)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

>>>>> On Tue, 17 Sep 2019 10:10:11 +0200, Miklos Szeredi <miklos@szeredi.hu> said:

    > This is most probably about nfs4 acl support.   Does "noacl" export
    > option fix it?
Unfortunately it's not possible to disable acl support for NFS v4 (only in Debian?).
That's what I read in some articles.

I've added no_acl to the exports line:
# exportfs -v
/files/scratch  134.95.9.128/25(ro,async,wdelay,no_root_squash,no_subtree_check,no_acl,sec=sys,ro,secure,no_root_squash,no_all_squash)

But this command does not show the no_acl option:

# cat /proc/fs/nfs/exports
# Version 1.1
# Path Client(Flags) # IPs
/files  134.95.9.128/25(ro,no_root_squash,sync,no_wdelay,no_subtree_check,v4root,uuid=9d4520b3:676a426f:92251f2f:b0e40f3b,sec=390003:390004:390005:1)
/       134.95.9.128/25(ro,no_root_squash,sync,no_wdelay,no_subtree_check,v4root,fsid=0,uuid=9d4520b3:676a426f:92251f2f:b0e40f3b,sec=390003:390004:390005:1)
/files/scratch  134.95.9.128/25(ro,no_root_squash,async,wdelay,no_subtree_check,uuid=9d4520b3:676a426f:92251f2f:b0e40f3b,sec=1)


I've also added -onoacl the the mount command on client side. Still the
same results, when I want to write to a file in overlayfs

13415 openat(AT_FDCWD, "/b/merged/etc/test1", O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EOPNOTSUPP (Operation not supported)


I've checked the access to the  "original" file in the lower (NFS v4
mounted) directory, by checking the results of getfacl and nfs4_getfacl.


NFS v3, exportfs with no_acl
============================
+ strace -etrace=getxattr getfacl /b/lower/etc/test1
getxattr("/b/lower/etc/test1", "system.posix_acl_access", 0x7ffcb6b56160, 132) = -1 EOPNOTSUPP (Operation not supported)
getfacl: Removing leading '/' from absolute path names

suenner[~]# strace -etrace=getxattr nfs4_getfacl /b/lower/etc/test1
getxattr("/b/lower/etc/test1", "system.nfs4_acl", NULL, 0) = -1 EOPNOTSUPP (Operation not supported)



NFS v4 using mount -onoacl, exportfs with no_acl
================================================

+ strace -etrace=getxattr getfacl /b/lower/etc/test1
getxattr("/b/lower/etc/test1", "system.posix_acl_access", 0x7fff39fd9cd0, 132) = -1 EOPNOTSUPP (Operation not supported)


+ strace -etrace=getxattr nfs4_getfacl /b/lower/etc/test1
getxattr("/b/lower/etc/test1", "system.nfs4_acl", NULL, 0) = 80
getxattr("/b/lower/etc/test1", "system.nfs4_acl", "\0\0\0\3\0\0\0\0\0\0\0\0\0\26\1\207\0\0\0\6OWNER@\0\0\0\0\0", 80) = 80


This shows that disabling ACL in NFS v4 does not work.
Does this disturb the behaviour of overlayfs?

-- 
regards Thomas
