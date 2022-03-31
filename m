Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E4F4ED626
	for <lists+linux-unionfs@lfdr.de>; Thu, 31 Mar 2022 10:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiCaItF (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 31 Mar 2022 04:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbiCaItC (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 31 Mar 2022 04:49:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CDC1FAA19
        for <linux-unionfs@vger.kernel.org>; Thu, 31 Mar 2022 01:47:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D06476195A
        for <linux-unionfs@vger.kernel.org>; Thu, 31 Mar 2022 08:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA90C340F0;
        Thu, 31 Mar 2022 08:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648716430;
        bh=mOV2UT1BdsN9jR9U+kMzjMSvF0OTKseSYU5B1ElpUhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hz2EW9cK2igQCTWR2S1h2Ue7xgA7TGEe7dm23adxhaQm/RKWqM64SDc/oZZi+1Ok9
         p0XLHZlvgazNGumqMQdDHbZBaPenzNYIkhQYlMsMANl69uG0LeINIpSR1621KTjB2d
         4T1yx2KDJfHYKbWHs5B/9ydVplerCNhGBoZbft07Q7UahYfer/xd3ezxTcPg30P+DE
         yyg3oCJzy0eKlU8DLR5U1RaErGHasbc/BroBMPHH15sDMg7c4Gp3k3vbjgP+gifKbd
         Kj04ai0uZy6r4vk/e6nFonNg5xXzbjbLOtXJK+VBnlksVje20OR76M6OBqYWV4FfUn
         3APOLgIswD37w==
Date:   Thu, 31 Mar 2022 10:47:04 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-unionfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos Catelin <rodrigoca@microsoft.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        Luca Bocassi <luca.boccassi@microsoft.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>
Subject: Re: [PATCH 00/18] overlay: support idmapped layers
Message-ID: <20220331084704.l5wkwm6ammcm2fcs@wittgenstein>
References: <20220329103526.1207086-1-brauner@kernel.org>
 <YkTEWy7byDiPAvzc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YkTEWy7byDiPAvzc@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Mar 30, 2022 at 04:58:03PM -0400, Vivek Goyal wrote:
> On Tue, Mar 29, 2022 at 12:35:07PM +0200, Christian Brauner wrote:
> > From: "Christian Brauner (Microsoft)" <brauner@kernel.org>
> > 
> > Hey,
> > 
> > This adds support for mounting overlay on top of idmapped layers.
> > 
> > I have to start by saying a massive thank you to Amir! He did not just
> > answer my constant overlay questions but also provided quite a few
> > patches himself in this series in addition to reviews, comments and a
> > lot of suggestions. Thank you!
> > 
> > There have been a lot of requests to unblock this. For just a few select
> > examples see [3], [4], and [5]. I've worked closely with various
> > communities among them containerd, Kubernetes, Podman, LXD, runC, crun,
> > and systemd (For the curious please see the various pull-request and
> > issues below.) a lot of them already support idmapped mounts since they
> > are enabled for btrfs, ext4, and xfs (and f2fs and fat fwiw). In
> > additon, a few colleagues at Microsoft and from Red Hat work on a
> > Kubernetes Enhancement Proposals (KEP) that also relies on overlayfs
> > supporting idmapped layers, see [12].
> > 
> > Overlayfs on top of idmapped layers will be used in various ways:
> > 
> > * Container managers use overlayfs to efficiently share layers between
> >   containers. However, this only works for privileged containers.
> >   Layers cannot be shared if both privileged and unprivileged containers
> >   are used. Layers can also not be shared if non-overlapping idmappings
> >   are used for unprivileged containers. Layers cannot be shared because
> >   of the conflicting ownership requirements between the containers.
> 
> Hi Christian,
> 
> Thank you for this work. This is awesome.

Thanks for saying that! Appreciate it.

> 
> Wanted to test it. I was wondering how to test it. Some simple
> instructions will help.

Of course. There are various ways:

1. Giuseppe has already put up support the containers/storage go library:
   https://github.com/containers/storage/pull/1180
   and he's been running workloads with that branch. If you're familiar
   with that tooling you can just use that.

2. xfstests have - for a long time already - support for a generic
   idmapped mount testsuite. Alongside that testsuite I added the
   "mount-idmapped" binary which makes it easy to create idmapped
   mounts.

   You can compile it via xfstests:
   https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/src/idmapped-mounts/mount-idmapped.c

I've pushed detailed instructions to the test repo at 
https://gitlab.com/brauner/fs.idmapped.overlay.xfstests.output
They are avaiable in the "manual.test.instructions" file.

> 
> I am assuming I will need to be priviliged to be able to setup idmapped
> mounts. And then overlay can be mounted on top of these layers (either

Yes.

> as a priviliged operation outside container or unprivileged overlayfs
> inside container). Sorry, just trying to wrap my head around which

Correct.

> operations will require me to be priviliged (root in init_user_ns)
> and which operations I can do unprivileged (as normal user).
> 
> Thanks
> Vivek
> 
> > 
> >   Both the KEP proposal (see [13]) and LXD (see [14]) use
> >   non-overlapping idmappings to increase isolation.
> > 
> >   All of these cases can be supported if overlayfs can be mounted on
> >   idmapped layers. The container runtime will create idmapped mounts for
> >   the layers supposed to be shared. Each container will be given
> >   idmapped mounts with the correct idmapping. Either by attaching a
> >   custom or its own user namespace depending on the use-case. Then an
> >   overlay mount can be mounted on top of the idmapped layers. The
> >   underlying idmapped mounts can then be unmounted and the mount table
> >   will be in a clean state.
> >   This approach has been tested an verified by Giuseppe and others.
> > 
> > * Because of the inability to share layers preparing a layer causes a
> >   big runtime overhead as ownership needs to be recursively changed.
> >   This becomes increasingly costly with the bigger the layers are.
> >   Especially for a large rootfs it becomes prohibitively expensive.
> > 
> >   This recursive ownership change also causes a lot storage overhead.
> >   Without metacopy it can quickly become unmanagable. With metacopy it
> >   still wastes a lot of space and inodes.
> > 
> >   For both the KEP and container manager being able to use idmapped
> >   layer with overlayfs on top of it solves all these problems.
> > 
> > * Container managers such as LXD do run full system containers. Such
> >   systems are managed like virtual machines and users run application
> >   containers inside. Since LXD uses an idmapped mounts for the rootfs of
> >   the container with the container's user namespace attached to the
> >   mount container runtimes cannot user overlayfs inside.
> > 
> >   Once overlayfs can be mounted on top of idmapped layers it will be
> >   possible for container runtimes to use overlayfs inside LXD
> >   containers.
> > 
> > * The systemd-homed daemon and toolsuite is a new component of systemd
> >   to manage home areas in a portable way. systemd-homed makes use of
> >   idmapped mounts for the home areas. If the kernel and used file system
> >   support it the user's home area will be mounted as an idmapped mount
> >   when they log into their system.
> > 
> >   All files are internally owned by the "nobody" user (i.e. the user
> >   typically used for indicating "this ownership is not mapped"), and
> >   dynamically mapped to the {g,u}id used locally on the system via
> >   idmapped mounts. This makes migrating home areas between different
> >   systems trivial because recursively chown()ing file system trees is no
> >   longer necessary. This also means that it is impossible to store files
> >   as {g,u}id 0 on disk.
> > 
> >   Once overlayfs can be mounted on top of idmapped layers it will be
> >   possible for container runtimes to work better together with
> >   systemd-homed.
> > 
> > * systemd provides various sandboxing features (see [11]) for services.
> >   These serve as hardening measures. In this context, idmapped mounts
> >   can be used to prevent services from creating files on disk as {g,u}id
> >   0, making specific files inaccessible, or to prevent access to whole
> >   directories. Since such services may also make use of overlayfs for
> >   e.g. the ExtensionImages= option supporting overlayfs on top of
> >   idmapped layers would be another huge hardening win.
> > 
> > * systemd provides the ability to use system extension images [15] for
> >   /usr and /opt (with a look to /etc in the future). Such system
> >   extension images contain files and directories similar in fashion to
> >   a regular OS system tree. When one or more system extension images are
> >   activated, their /usr/ and /opt/ hierarchies are combined via
> >   overlay with the same hierarchies of the host OS, and the host /usr/
> >   and /opt/ overmounted with it ("merging"). These images are read-only.
> > 
> >   This feature is available to unprivileged container and sandboxed
> >   services as well. Idmapped layers are used here to avoid runtime and
> >   storage overhead from recursively changing ownership and ultimately an
> >   overlay mount is supposed to be created on top of it.
> > 
> > Giuseppe provided testing for runC/crun/Podman and he put up a pull
> > request to support overlayfs on top of idmapped layers at [16]. That
> > already covers a lot of users. Other tools have put up pull requests as
> > well and they are linked below.
> > 
> > The patchset has been extensively tested for about 2 weeks with
> > xfstests. The tests and results are explained in the following
> > paragraphs.
> > 
> > In order to test overlayfs with idmapped mounts a simple patch to
> > xfstests has been added which is part of this series. The patchset
> > simply allows for each test in the xfstests suite to be run on top of
> > idmapped mounts. That is in addition to the generic idmapped mount tests
> > that have existed and are already run for a long time.
> > 
> > Since idmapped mounts can be created on top of btrfs, ext4, and xfs and
> > these are the most relevant filesystems for users they were taken into
> > the test matrix.
> > 
> > Amir ensured that the test matrix also includes metacopy. So all tests
> > are run once with metacopy=on and once with metacopy=off.
> > 
> > Additionally, the unionmount tesuite that Amir maintains was run as part
> > of xfstests. This brings testing for multi layer overlay and a few
> > rarely used overlayfs use-cases.
> > 
> > And last, xfstests were run with and without idmapped mounts.
> > 
> > Since the patch series is based on Linux 5.17 the 5.17 kernel was chosen
> > as a baseline kernel. The baseline kernel is pure 5.17 upstream without
> > any of the patches in this series. The baseline kernel was used to run
> > all xfstests with the same parameters minus the idmapped mount part of
> > the test matrix. This ensured that regressions would be immediately
> > noticeable.
> > 
> > So the full test matrix is:
> > 
> > ext4 x metacopy=off x -idmapped mounts
> > ext4 x metacopy=on  x -idmapped mounts
> > ext4 x metacopy=off x +idmapped mounts
> > ext4 x metacopy=on  x +idmapped mounts
> > 
> > xfs x metacopy=off x -idmapped mounts
> > xfs x metacopy=on  x -idmapped mounts
> > xfs x metacopy=off x +idmapped mounts
> > xfs x metacopy=on  x +idmapped mounts
> > 
> > btrfs x metacopy=off x -idmapped mounts
> > btrfs x metacopy=on  x -idmapped mounts
> > btrfs x metacopy=off x +idmapped mounts
> > btrfs x metacopy=on  x +idmapped mounts
> > 
> > The test runs were started with:
> > 
> > sudo ./check -overlay
> > 
> > so they encompass all xfstests apart from those that needed to be
> > excluded because they triggered known issues (One such example is
> > generic/530 which causes an xfs corruption that is currently under
> > discussion for a fix upstream.).
> > 
> > A single testrun with over 750 tests takes a bonkers long time given
> > that I run them in a beefy VM on top of an ssd and not on bare metal.
> > 
> > The successes and failures are identical for the whole test matrix with
> > and without idmapped mounts. The tests and failures are also identical
> > compared to the baseline kernel. All in all this should provide a good
> > amount of convidence. The full test output can be found in the following
> > repo: https://gitlab.com/brauner/fs.idmapped.overlay.xfstests.output
> > 
> > In order to create an idmapped mount the mount_setattr() system call
> > (see [17]) can be used together with the MOUNT_ATTR_IDMAP flag to attach
> > a userns fd to a detached mount created with open_tree()'s
> > OPEN_TREE_CLONE flag. The only effect is that the idmapping of the
> > userns becomes the idmapping of the relevant. The links below should
> > serve to illustrate how widely they are already used.
> > 
> > For people who would like to test I've created a tag fs.idmapped.overlay.v1
> > which can be fetched:
> > 
> > git fetch git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git fs.idmapped.overlay.v1
> > 
> > the same goes for xfstests:
> > 
> > git fetch git://git.kernel.org/pub/scm/linux/kernel/git/brauner/xfstests-dev.git fs.idmapped.overlay.v1
> > 
> > Thanks!
> > Christian
> > 
> > [1]: OCI runtime-spec extension for idmapped mounts
> >      https://github.com/opencontainers/runtime-spec/pull/1143
> > 
> > [2]: Support for idmapped mounts for shared volumes
> >      https://github.com/opencontainers/runc/pull/3429
> > 
> > [3]: containerd support for idmapped mounts with focus on overlayfs
> >      https://github.com/containerd/containerd/pull/5890
> > 
> > [4]: runC support for idmapped mounts with focus on overlayfs
> >      https://github.com/opencontainers/runc/issues/2821
> > 
> > [5]: Podman support for idmapped mounts with focus on overlayfs
> >      https://github.com/containers/podman/issues/10374
> > 
> > [6]: systemd-nspawn support for idmapped mounts
> >      https://github.com/systemd/systemd/pull/19438
> > 
> > [7]: systemd-homed support for idmapped mounts
> >      https://github.com/systemd/systemd/pull/21136
> > 
> > [8]: LXD support for idmapped mounts
> >      https://github.com/lxc/lxd/pull/8778
> > 
> > [9]: LXC support for idmapped mounts
> >      https://github.com/lxc/lxc/pull/3709
> > 
> > [10]: crun support for idmapped mounts
> >       https://github.com/containers/crun/pull/874
> > 
> > [11]: https://www.freedesktop.org/software/systemd/man/systemd.exec.html#Sandboxing
> > 
> > [12]: https://github.com/kubernetes/enhancements/pull/3065
> > 
> > [13]: https://github.com/kubernetes/enhancements/pull/3065/files#diff-a9ca9fbce1538447b92f03125ca2b8474e2d875071f1172d2afa0b1e8cadeabaR118
> > 
> > [14]: https://github.com/lxc/lxd/blob/master/doc/instances.md
> >       (The relevant entry can be found by looking for the
> >        "security.idmap.isolated" key.)
> > 
> > [15]: https://www.freedesktop.org/software/systemd/man/systemd-sysext.html
> > 
> > [16]: https://github.com/containers/storage/pull/1180
> > 
> > [17]: https://man7.org/linux/man-pages/man2/mount_setattr.2.html
> > 
> > Amir Goldstein (3):
> >   ovl: use wrappers to all vfs_*xattr() calls
> >   ovl: pass layer mnt to ovl_open_realfile()
> >   ovl: store lower path in ovl_inode
> > 
> > Christian Brauner (15):
> >   fs: add two trivial lookup helpers
> >   exportfs: support idmapped mounts
> >   ovl: pass ofs to creation operations
> >   ovl: handle idmappings in creation operations
> >   ovl: pass ofs to setattr operations
> >   ovl: use ovl_do_notify_change() wrapper
> >   ovl: use ovl_lookup_upper() wrapper
> >   ovl: use ovl_path_getxattr() wrapper
> >   ovl: handle idmappings for layer fileattrs
> >   ovl: handle idmappings for layer lookup
> >   ovl: use ovl_copy_{real,upper}attr() wrappers
> >   ovl: handle idmappings in ovl_permission()
> >   ovl: handle idmappings in layer open helpers
> >   ovl: handle idmappings in ovl_xattr_{g,s}et()
> >   ovl: support idmapped layers
> > 
> >  fs/exportfs/expfs.c      |   5 +-
> >  fs/namei.c               |  52 +++++++--
> >  fs/overlayfs/copy_up.c   |  97 +++++++++-------
> >  fs/overlayfs/dir.c       | 133 +++++++++++-----------
> >  fs/overlayfs/export.c    |   3 +-
> >  fs/overlayfs/file.c      |  44 ++++----
> >  fs/overlayfs/inode.c     |  63 +++++++----
> >  fs/overlayfs/namei.c     |  49 ++++++---
> >  fs/overlayfs/overlayfs.h | 231 ++++++++++++++++++++++++++++-----------
> >  fs/overlayfs/ovl_entry.h |   7 +-
> >  fs/overlayfs/readdir.c   |  48 ++++----
> >  fs/overlayfs/super.c     |  57 +++++-----
> >  fs/overlayfs/util.c      | 142 +++++++++++++++++++-----
> >  include/linux/namei.h    |   2 +
> >  14 files changed, 607 insertions(+), 326 deletions(-)
> > 
> > 
> > base-commit: f443e374ae131c168a065ea1748feac6b2e76613
> > -- 
> > 2.32.0
> > 
> 
