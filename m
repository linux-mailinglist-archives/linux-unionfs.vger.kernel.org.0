Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F047EEFE8
	for <lists+linux-unionfs@lfdr.de>; Mon,  4 Nov 2019 23:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfKDWYQ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 4 Nov 2019 17:24:16 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34111 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730910AbfKDVxK (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 4 Nov 2019 16:53:10 -0500
Received: by mail-pl1-f194.google.com with SMTP id k7so8301258pll.1
        for <linux-unionfs@vger.kernel.org>; Mon, 04 Nov 2019 13:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8J8d9IDvRoUC4AVADMVMFKu1u3aWQelO26+oyWH8/ZU=;
        b=YGooEbC/FZt/rx/Q4C8AAxDrLoXSJS2L5JXBZYa+3jbO6XTOXiHGSgdAyUPSKCYK3t
         xKs+nz4eCsQxb3xFGOr3uyiHgaAdHoo7xAybFQLZBN0AfDW7AxTng6VRUJnfBwjuurGq
         5QlYGyEizmKZkHB91EwRE9mg/r/1x65V8IESorxsBxD/VNtXAugORC3+G6tHh6tc0/b1
         VsmlzpRd5j2F0FaU2WCkP5QVzIcPAAQtOPVyOICXzrOJ9L/oca3jwahTPdaMXrcob09P
         JAK5Ny9etwU4yLbLBNTICIRVIzEi6KCnKk0rTZS6hdYmGNPzLwWknlk2oKc+yM7v6ifB
         FWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8J8d9IDvRoUC4AVADMVMFKu1u3aWQelO26+oyWH8/ZU=;
        b=Jz0FN0x0f3kdu/TFtDA+dZtCHwhR7Wbf1EKNlSpsdW2yxRzK9XH3LBPVLL82ymJElH
         tr+VQNUPHOi830jMIBgehG9eMJVfoc1XL+g7PlucC5nGu8X4DcykbyKKVEJVWmKuvnG0
         /gSWoeKys1bsdyLtuxmTNikeJtJ+O//BDbPZx0X2dvDhFGcAWlZ8ZH44ZLBUjeB7DHox
         uW5C59XIKWgcpwn1DOMTDWvRS0X+cXA3nMoENp1UbBh6jTaMhbJTo0qzIRvCe3AsTP0F
         7DtQx6tCSJ+Y9cN74MKEQxkX2rwYztEUf1oBOwLVeY0tFovf4zyjxOC5hX+pc/v9+Sa5
         Fo2Q==
X-Gm-Message-State: APjAAAUathVkLguQKTGFPSTYNsMXR1Sd36ydOHb2PJ+ytQQtKo3LYO2x
        WMASWkouKdXwwFvXQjcHRsFTsg==
X-Google-Smtp-Source: APXvYqxX9UqKrw8lrRrBt5lN1xyC9Rblbt8uiPQ5DQtjXLaEKb4PPpnhQUllos59EPtfA5JhrETjgw==
X-Received: by 2002:a17:902:521:: with SMTP id 30mr29357684plf.37.1572904389349;
        Mon, 04 Nov 2019 13:53:09 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id e198sm19231350pfh.83.2019.11.04.13.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 13:53:08 -0800 (PST)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v15 0/4] overlayfs override_creds=off & nested get xattr fix
Date:   Mon,  4 Nov 2019 13:52:45 -0800
Message-Id: <20191104215253.141818-1-salyzyn@android.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Patch series:

Mark Salyzyn (4):
  Add flags option to get xattr method paired to __vfs_getxattr
  overlayfs: handle XATTR_NOSECURITY flag for get xattr method
  overlayfs: internal getxattr operations without sepolicy checking
  overlayfs: override_creds=off option bypass creator_cred

The first three patches address fundamental security issues that should
be solved regardless of the override_creds=off feature.

The fourth adds the feature depends on these other fixes.

By default, all access to the upper, lower and work directories is the
recorded mounter's MAC and DAC credentials.  The incoming accesses are
checked against the caller's credentials.

If the principles of least privilege are applied for sepolicy, the
mounter's credentials might not overlap the credentials of the caller's
when accessing the overlayfs filesystem.  For example, a file that a
lower DAC privileged caller can execute, is MAC denied to the
generally higher DAC privileged mounter, to prevent an attack vector.

We add the option to turn off override_creds in the mount options; all
subsequent operations after mount on the filesystem will be only the
caller's credentials.  The module boolean parameter and mount option
override_creds is also added as a presence check for this "feature",
existence of /sys/module/overlay/parameters/overlay_creds

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-unionfs@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
v15
- Revert back to v4 with fixes from on the way from v5-v14. The single
  structure argument passing to address the complaints about too many
  arguments was rejected by the community.
- Drop the udner discussion fix for an additional CAP_DAC_READ_SEARCH
  check. Can address that independently.
- ToDo: upstream test frame for thes security fixes (currently testing
  is all in Android).

v14:
- Rejoin, rebase and a few adjustments.

v13:
- Pull out first patch and try to get it in alone feedback, some
  Acks, and then <crickets> because people forgot why we were doing i.

v12:
- Restore squished out patch 2 and 3 in the series,
  then change algorithm to add flags argument.
  Per-thread flag is a large security surface.

v11:
- Squish out v10 introduced patch 2 and 3 in the series,
  then and use per-thread flag instead for nesting.
- Switch name to ovl_do_vds_getxattr for __vds_getxattr wrapper.
- Add sb argument to ovl_revert_creds to match future work.

v10:
- Return NULL on CAP_DAC_READ_SEARCH
- Add __get xattr method to solve sepolicy logging issue
- Drop unnecessary sys_admin sepolicy checking for administrative
  driver internal xattr functions.

v6:
- Drop CONFIG_OVERLAY_FS_OVERRIDE_CREDS.
- Do better with the documentation, drop rationalizations.
- pr_warn message adjusted to report consequences.

v5:
- beefed up the caveats in the Documentation
- Is dependent on
  "overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh"
  "overlayfs: check CAP_MKNOD before issuing vfs_whiteout"
- Added prwarn when override_creds=off

v4:
- spelling and grammar errors in text

v3:
- Change name from caller_credentials / creator_credentials to the
  boolean override_creds.
- Changed from creator to mounter credentials.
- Updated and fortified the documentation.
- Added CONFIG_OVERLAY_FS_OVERRIDE_CREDS

v2:
- Forward port changed attr to stat, resulting in a build error.
- altered commit message.

 Documentation/filesystems/locking.rst   |  2 +-
 Documentation/filesystems/overlayfs.txt | 23 ++++++++++++++++
 fs/9p/acl.c                             |  3 ++-
 fs/9p/xattr.c                           |  3 ++-
 fs/afs/xattr.c                          | 26 +++++++++---------
 fs/btrfs/xattr.c                        |  3 ++-
 fs/ceph/xattr.c                         |  3 ++-
 fs/cifs/xattr.c                         |  2 +-
 fs/ecryptfs/inode.c                     |  6 +++--
 fs/ecryptfs/mmap.c                      |  2 +-
 fs/erofs/xattr.c                        |  3 ++-
 fs/ext2/xattr_security.c                |  2 +-
 fs/ext2/xattr_trusted.c                 |  2 +-
 fs/ext2/xattr_user.c                    |  2 +-
 fs/ext4/xattr_security.c                |  2 +-
 fs/ext4/xattr_trusted.c                 |  2 +-
 fs/ext4/xattr_user.c                    |  2 +-
 fs/f2fs/xattr.c                         |  4 +--
 fs/fuse/xattr.c                         |  4 +--
 fs/gfs2/xattr.c                         |  3 ++-
 fs/hfs/attr.c                           |  2 +-
 fs/hfsplus/xattr.c                      |  3 ++-
 fs/hfsplus/xattr_security.c             |  3 ++-
 fs/hfsplus/xattr_trusted.c              |  3 ++-
 fs/hfsplus/xattr_user.c                 |  3 ++-
 fs/jffs2/security.c                     |  3 ++-
 fs/jffs2/xattr_trusted.c                |  3 ++-
 fs/jffs2/xattr_user.c                   |  3 ++-
 fs/jfs/xattr.c                          |  5 ++--
 fs/kernfs/inode.c                       |  3 ++-
 fs/nfs/nfs4proc.c                       |  6 +++--
 fs/ocfs2/xattr.c                        |  9 ++++---
 fs/orangefs/xattr.c                     |  3 ++-
 fs/overlayfs/copy_up.c                  |  2 +-
 fs/overlayfs/dir.c                      | 17 +++++++-----
 fs/overlayfs/file.c                     | 20 +++++++-------
 fs/overlayfs/inode.c                    | 23 ++++++++--------
 fs/overlayfs/namei.c                    | 18 +++++++------
 fs/overlayfs/overlayfs.h                | 11 +++++++-
 fs/overlayfs/ovl_entry.h                |  1 +
 fs/overlayfs/readdir.c                  |  4 +--
 fs/overlayfs/super.c                    | 34 ++++++++++++++++++-----
 fs/overlayfs/util.c                     | 30 +++++++++++++--------
 fs/posix_acl.c                          |  2 +-
 fs/reiserfs/xattr_security.c            |  3 ++-
 fs/reiserfs/xattr_trusted.c             |  3 ++-
 fs/reiserfs/xattr_user.c                |  3 ++-
 fs/squashfs/xattr.c                     |  2 +-
 fs/ubifs/xattr.c                        |  3 ++-
 fs/xattr.c                              | 36 ++++++++++++-------------
 fs/xfs/xfs_xattr.c                      |  3 ++-
 include/linux/xattr.h                   |  9 ++++---
 include/uapi/linux/xattr.h              |  7 +++--
 mm/shmem.c                              |  3 ++-
 net/socket.c                            |  3 ++-
 security/commoncap.c                    |  6 +++--
 security/integrity/evm/evm_main.c       |  3 ++-
 security/selinux/hooks.c                | 11 +++++---
 security/smack/smack_lsm.c              |  5 ++--
 59 files changed, 261 insertions(+), 149 deletions(-)

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

