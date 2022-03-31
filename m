Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDCB4ED859
	for <lists+linux-unionfs@lfdr.de>; Thu, 31 Mar 2022 13:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiCaLZ0 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 31 Mar 2022 07:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiCaLZY (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 31 Mar 2022 07:25:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436E360DF
        for <linux-unionfs@vger.kernel.org>; Thu, 31 Mar 2022 04:23:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30C62B81BE2
        for <linux-unionfs@vger.kernel.org>; Thu, 31 Mar 2022 11:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE5AC340ED;
        Thu, 31 Mar 2022 11:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648725812;
        bh=Xr695q+vQrlNQOUe9wVupfkmr6W1i2YD/4YHi3NEnbg=;
        h=From:To:Cc:Subject:Date:From;
        b=hKTmlaIFK7weZ2HYi+HLaE5vFLoOtRsJiH39zJsd/TCYg2cofBvYAWRWNs5do6CJ8
         FAhET2USMpHuKGrDBh0XK8z5/hijWlWRMhkjQOLCoCC0jLay271cLu3hrBab5w98dU
         jmdNPWbfSdmYkrbogaylIBGU2vY68akfzPUJN8gTGmKkwGa7sQEZWSidpPxcOJuRnK
         OCdWkj7SPwWkfZFBHs8v5oTIJW5BNxXP9sGrRrL8U+OYzWelF6Zfdg/1/gG1voNgnV
         OAznl0tKlNKGPqJ+PCQkbZRKQOs13XfOPfoMMKnvV8oUoXCZR/+EUBDBxihUnDJFZa
         ppppg8zKcVBLA==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        linux-unionfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos Catelin <rodrigo@sdfg.com.ar>,
        Seth Forshee <sforshee@digitalocean.com>,
        Luca Bocassi <luca.boccassi@microsoft.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v3 00/19] overlay: support idmapped layers
Date:   Thu, 31 Mar 2022 13:22:58 +0200
Message-Id: <20220331112318.1377494-1-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14258; h=from:subject; bh=BnifUdRONKXl0sBAXmhfNnIljhEuGL8gAb0nr6JRO0k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS59ov/UyphPaXQG7IkX83+RYpuQkrs5TL/3fdcxaTeMnEe LtncUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJFL2xj+F67Y6zzh0oE9qhv+CvM5fD wiE/KgM7vM5e7fb/xPF/HF/Gb477BS27slRmURa4W4G8uBiYt/Nt+QkfFyMOycFfa9Wu08AwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

From: "Christian Brauner (Microsoft)" <brauner@kernel.org>

Hey,

This adds support for mounting overlay on top of idmapped layers.

/* v3 */
- Add Christoph's reviews and add kerneldoc to the two lookup helpers.
- Add link to repo with manual testing instructions.
- Push out new fs.idmapped.overlay.v3 tags.

/* v2 */
- Move ovl_upper_idmap() into a separate patch early in the series but
  have it return the initial idmapping. Once all necessary preparations
  are done we switch it to return the upper mount's idmapping in the
  last patch. (Miklos)
- Add a comment to the commit message explaining the acceptable increase
  in debug output due to the switch of all places from open-coded
  vfs_*xattr() calls to the respective ovl_do_*xattr() helpers. (Miklos)
- I did another git rebase -i -x "make -j31 LOCALVERSION=-ovl" v5.17.
- Push out new fs.idmapped.overlay.v2 tag.

These details can also be found in the comments of the individual commit
messages.

I have to start by saying a massive thank you to Amir! He did not just
answer my constant overlay questions but also provided quite a few
patches himself in this series in addition to reviews, comments and a
lot of suggestions. Thank you!

There have been a lot of requests to unblock this. For just a few select
examples see [3], [4], and [5]. I've worked closely with various
communities among them containerd, Kubernetes, Podman, LXD, runC, crun,
and systemd (For the curious please see the various pull-request and
issues below.) a lot of them already support idmapped mounts since they
are enabled for btrfs, ext4, and xfs (and f2fs and fat fwiw). In
additon, a few colleagues at Microsoft and from Red Hat work on a
Kubernetes Enhancement Proposals (KEP) that also relies on overlayfs
supporting idmapped layers, see [12].

Overlayfs on top of idmapped layers will be used in various ways:

* Container managers use overlayfs to efficiently share layers between
  containers. However, this only works for privileged containers.
  Layers cannot be shared if both privileged and unprivileged containers
  are used. Layers can also not be shared if non-overlapping idmappings
  are used for unprivileged containers. Layers cannot be shared because
  of the conflicting ownership requirements between the containers.

  Both the KEP proposal (see [13]) and LXD (see [14]) use
  non-overlapping idmappings to increase isolation.

  All of these cases can be supported if overlayfs can be mounted on
  idmapped layers. The container runtime will create idmapped mounts for
  the layers supposed to be shared. Each container will be given
  idmapped mounts with the correct idmapping. Either by attaching a
  custom or its own user namespace depending on the use-case. Then an
  overlay mount can be mounted on top of the idmapped layers. The
  underlying idmapped mounts can then be unmounted and the mount table
  will be in a clean state.
  This approach has been tested an verified by Giuseppe and others.

* Because of the inability to share layers preparing a layer causes a
  big runtime overhead as ownership needs to be recursively changed.
  This becomes increasingly costly with the bigger the layers are.
  Especially for a large rootfs it becomes prohibitively expensive.

  This recursive ownership change also causes a lot storage overhead.
  Without metacopy it can quickly become unmanagable. With metacopy it
  still wastes a lot of space and inodes.

  For both the KEP and container manager being able to use idmapped
  layer with overlayfs on top of it solves all these problems.

* Container managers such as LXD do run full system containers. Such
  systems are managed like virtual machines and users run application
  containers inside. Since LXD uses an idmapped mounts for the rootfs of
  the container with the container's user namespace attached to the
  mount container runtimes cannot user overlayfs inside.

  Once overlayfs can be mounted on top of idmapped layers it will be
  possible for container runtimes to use overlayfs inside LXD
  containers.

* The systemd-homed daemon and toolsuite is a new component of systemd
  to manage home areas in a portable way. systemd-homed makes use of
  idmapped mounts for the home areas. If the kernel and used file system
  support it the user's home area will be mounted as an idmapped mount
  when they log into their system.

  All files are internally owned by the "nobody" user (i.e. the user
  typically used for indicating "this ownership is not mapped"), and
  dynamically mapped to the {g,u}id used locally on the system via
  idmapped mounts. This makes migrating home areas between different
  systems trivial because recursively chown()ing file system trees is no
  longer necessary. This also means that it is impossible to store files
  as {g,u}id 0 on disk.

  Once overlayfs can be mounted on top of idmapped layers it will be
  possible for container runtimes to work better together with
  systemd-homed.

* systemd provides various sandboxing features (see [11]) for services.
  These serve as hardening measures. In this context, idmapped mounts
  can be used to prevent services from creating files on disk as {g,u}id
  0, making specific files inaccessible, or to prevent access to whole
  directories. Since such services may also make use of overlayfs for
  e.g. the ExtensionImages= option supporting overlayfs on top of
  idmapped layers would be another huge hardening win.

* systemd provides the ability to use system extension images [15] for
  /usr and /opt (with a look to /etc in the future). Such system
  extension images contain files and directories similar in fashion to
  a regular OS system tree. When one or more system extension images are
  activated, their /usr/ and /opt/ hierarchies are combined via
  overlay with the same hierarchies of the host OS, and the host /usr/
  and /opt/ overmounted with it ("merging"). These images are read-only.

  This feature is available to unprivileged container and sandboxed
  services as well. Idmapped layers are used here to avoid runtime and
  storage overhead from recursively changing ownership and ultimately an
  overlay mount is supposed to be created on top of it.

Giuseppe provided testing for runC/crun/Podman and he put up a pull
request to support overlayfs on top of idmapped layers at [16]. That
already covers a lot of users. Other tools have put up pull requests as
well and they are linked below.

The patchset has been extensively tested for about 2 weeks with
xfstests. The tests and results are explained in the following
paragraphs.

In order to test overlayfs with idmapped mounts a simple patch to
xfstests has been added which is part of this series. The patchset
simply allows for each test in the xfstests suite to be run on top of
idmapped mounts. That is in addition to the generic idmapped mount tests
that have existed and are already run for a long time.

Since idmapped mounts can be created on top of btrfs, ext4, and xfs and
these are the most relevant filesystems for users they were taken into
the test matrix.

Amir ensured that the test matrix also includes metacopy. So all tests
are run once with metacopy=on and once with metacopy=off.

Additionally, the unionmount tesuite that Amir maintains was run as part
of xfstests. This brings testing for multi layer overlay and a few
rarely used overlayfs use-cases.

And last, xfstests were run with and without idmapped mounts.

Since the patch series is based on Linux 5.17 the 5.17 kernel was chosen
as a baseline kernel. The baseline kernel is pure 5.17 upstream without
any of the patches in this series. The baseline kernel was used to run
all xfstests with the same parameters minus the idmapped mount part of
the test matrix. This ensured that regressions would be immediately
noticeable.

So the full test matrix is:

ext4 x metacopy=off x -idmapped mounts
ext4 x metacopy=on  x -idmapped mounts
ext4 x metacopy=off x +idmapped mounts
ext4 x metacopy=on  x +idmapped mounts

xfs x metacopy=off x -idmapped mounts
xfs x metacopy=on  x -idmapped mounts
xfs x metacopy=off x +idmapped mounts
xfs x metacopy=on  x +idmapped mounts

btrfs x metacopy=off x -idmapped mounts
btrfs x metacopy=on  x -idmapped mounts
btrfs x metacopy=off x +idmapped mounts
btrfs x metacopy=on  x +idmapped mounts

The test runs were started with:

sudo ./check -overlay

so they encompass all xfstests apart from those that needed to be
excluded because they triggered known issues (One such example is
generic/530 which causes an xfs corruption that is currently under
discussion for a fix upstream.).

A single testrun with over 750 tests takes a bonkers long time given
that I run them in a beefy VM on top of an ssd and not on bare metal.

The successes and failures are identical for the whole test matrix with
and without idmapped mounts. The tests and failures are also identical
compared to the baseline kernel. All in all this should provide a good
amount of convidence. The full test output can be found in [18].

People that want to directly play with this have various options the two
easiest are:

1. Giuseppe has already put up support the containers/storage go library:
   https://github.com/containers/storage/pull/1180
   and he's been running workloads with that branch. If the tooling in
   this area is familiar to you it easy to test this.
   One can vendor containers/storage branch into Podman and then run
   workloads like:
   podman run --uidmap 0:2000:40000 --gidmap 0:8000:50000 --rm fedora bash

2. xfstests have - for a long time already - support for a generic
   idmapped mount testsuite. Part of the testsuite is the
   "mount-idmapped" binary which makes it easy to create idmapped
   mounts:
   https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/src/idmapped-mounts/mount-idmapped.c

More detailed instructions can be found in the
"manual.test.instructions" file in the repo at [18].

In order to create an idmapped mount the mount_setattr() system call
(see [17]) can be used together with the MOUNT_ATTR_IDMAP flag to attach
a userns fd to a detached mount created with open_tree()'s
OPEN_TREE_CLONE flag. The only effect is that the idmapping of the
userns becomes the idmapping of the relevant. The links below should
serve to illustrate how widely they are already used.

For people who would like to test I've created a tag fs.idmapped.overlay.v3
which can be fetched:

git fetch git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git fs.idmapped.overlay.v3

the same goes for xfstests:

git fetch git://git.kernel.org/pub/scm/linux/kernel/git/brauner/xfstests-dev.git fs.idmapped.overlay.v3

Thanks!
Christian

[1]: OCI runtime-spec extension for idmapped mounts
     https://github.com/opencontainers/runtime-spec/pull/1143

[2]: Support for idmapped mounts for shared volumes
     https://github.com/opencontainers/runc/pull/3429

[3]: containerd support for idmapped mounts with focus on overlayfs
     https://github.com/containerd/containerd/pull/5890

[4]: runC support for idmapped mounts with focus on overlayfs
     https://github.com/opencontainers/runc/issues/2821

[5]: Podman support for idmapped mounts with focus on overlayfs
     https://github.com/containers/podman/issues/10374

[6]: systemd-nspawn support for idmapped mounts
     https://github.com/systemd/systemd/pull/19438

[7]: systemd-homed support for idmapped mounts
     https://github.com/systemd/systemd/pull/21136

[8]: LXD support for idmapped mounts
     https://github.com/lxc/lxd/pull/8778

[9]: LXC support for idmapped mounts
     https://github.com/lxc/lxc/pull/3709

[10]: crun support for idmapped mounts
      https://github.com/containers/crun/pull/874

[11]: https://www.freedesktop.org/software/systemd/man/systemd.exec.html#Sandboxing

[12]: https://github.com/kubernetes/enhancements/pull/3065

[13]: https://github.com/kubernetes/enhancements/pull/3065/files#diff-a9ca9fbce1538447b92f03125ca2b8474e2d875071f1172d2afa0b1e8cadeabaR118

[14]: https://github.com/lxc/lxd/blob/master/doc/instances.md
      (The relevant entry can be found by looking for the
       "security.idmap.isolated" key.)

[15]: https://www.freedesktop.org/software/systemd/man/systemd-sysext.html

[16]: https://github.com/containers/storage/pull/1180

[17]: https://man7.org/linux/man-pages/man2/mount_setattr.2.html

[18]: https://gitlab.com/brauner/fs.idmapped.overlay.xfstests.output

Amir Goldstein (3):
  ovl: use wrappers to all vfs_*xattr() calls
  ovl: pass layer mnt to ovl_open_realfile()
  ovl: store lower path in ovl_inode

Christian Brauner (16):
  fs: add two trivial lookup helpers
  exportfs: support idmapped mounts
  ovl: pass ofs to creation operations
  ovl: add ovl_upper_idmap() wrapper
  ovl: handle idmappings in creation operations
  ovl: pass ofs to setattr operations
  ovl: use ovl_do_notify_change() wrapper
  ovl: use ovl_lookup_upper() wrapper
  ovl: use ovl_path_getxattr() wrapper
  ovl: handle idmappings for layer fileattrs
  ovl: handle idmappings for layer lookup
  ovl: use ovl_copy_{real,upper}attr() wrappers
  ovl: handle idmappings in ovl_permission()
  ovl: handle idmappings in layer open helpers
  ovl: handle idmappings in ovl_xattr_{g,s}et()
  ovl: support idmapped layers

 fs/exportfs/expfs.c      |   5 +-
 fs/namei.c               |  69 ++++++++++--
 fs/overlayfs/copy_up.c   |  96 +++++++++-------
 fs/overlayfs/dir.c       | 133 +++++++++++-----------
 fs/overlayfs/export.c    |   3 +-
 fs/overlayfs/file.c      |  44 ++++----
 fs/overlayfs/inode.c     |  63 +++++++----
 fs/overlayfs/namei.c     |  49 +++++---
 fs/overlayfs/overlayfs.h | 233 ++++++++++++++++++++++++++++-----------
 fs/overlayfs/ovl_entry.h |   7 +-
 fs/overlayfs/readdir.c   |  48 ++++----
 fs/overlayfs/super.c     |  57 +++++-----
 fs/overlayfs/util.c      | 142 +++++++++++++++++++-----
 include/linux/namei.h    |   6 +
 14 files changed, 629 insertions(+), 326 deletions(-)


base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.32.0

