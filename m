Return-Path: <linux-unionfs+bounces-639-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE468913E2
	for <lists+linux-unionfs@lfdr.de>; Fri, 29 Mar 2024 07:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2851F23873
	for <lists+linux-unionfs@lfdr.de>; Fri, 29 Mar 2024 06:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093173B1A4;
	Fri, 29 Mar 2024 06:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHDvpK6G"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF919A3D;
	Fri, 29 Mar 2024 06:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711694707; cv=none; b=Jsn+9WH7rT07PEQKn8ZjkTW7FNiW6TPPCpXWAmhkFYqETrBs93ha1EoM5ZdravwsV5MDfMYENNqVhTFk/fsimrOLsq0sYMSvPEBsyhlsUnYbQymmI6Ho3UHO7/RBDDgI9uiY8D88B9oX7oDA+OFzfaEUYmUf8a80rxCL5QlISp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711694707; c=relaxed/simple;
	bh=91mAmkafELsib3/Quhgpb5ItlPGTm6Mk6VFAqIUThjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LO895PpsOqBJDJ3c1xhxR02J34g3WYN1Mga0Gts4NqqjGI1WRg4YoZULydspVuajFrU0qmLxdll0JfktAjXhqvWOjBrMNONbMvWLG+uWLe2nT3fUb/4VH/sf9MAmrziRkYVJmoQu1KtFASBW9Yo5IMH2xwQOy9onaVKIJoH7uxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHDvpK6G; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-789d0c90cadso110719185a.3;
        Thu, 28 Mar 2024 23:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711694705; x=1712299505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31N9TyVfVhzvjR4DYFnbZjnn+IXdbLMNFIsB62iZTO8=;
        b=JHDvpK6G9nfAGkShGY8HVaGArh5JogInb1x0imG6cccj7Pzq9LsGE5zzx4dIAitRn1
         f5ZzaYZPhqDAgcRBMo5nqQ0bxNYU4yIW3WNUrJ1t6PWy3oJevi05eSUEV0CcwqRyum3D
         73yInEyzPic0GpEPEi+7MBuFy2x+IU19Y+N71gU+cJRtvC9QrCzPRVAqfMJv8TKG+lMx
         nE4+TZ+T+94fcaFFhbCD++fFQH0xsUgW1a5TGh0yoeiYsX0hoijGhgitzT14noiy5OHc
         N0Uxg2AY1EmvcZgfg7no6XBjq3GOTu1FOnLFwKdLU1CX7er/2B9/zfKvXduKltxXe4ET
         lyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711694705; x=1712299505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31N9TyVfVhzvjR4DYFnbZjnn+IXdbLMNFIsB62iZTO8=;
        b=vXi0vYpI0jblMkz+yoKW3lpoWXHjFSaEfVuyD4Wg8i2Lg3a13UrgGukUH3AqPBZJlQ
         36xJ7vPAaN4PsNoeNAu2+Pdch7PBZWkWyaPAEryADN4v9gRz3xonpwpyZe2QvG4QA+Nq
         y2pY2OmdomnBOG7pn/sZRFkARnnTyRfUTWcpdq5HVl8nS/ppjdOxhGMJBMRkmtCkrDeV
         On4RzlczZunaYLcz46SOD7HEXqPC5vhDSCJvQO7T5fGUdgTQ76jcfaFu/WL5U8HpMmf0
         Le4Cna3FNXrPlsK/4P69pB+wuccDFHbG64q8wxdafVCpQNybMtd0r8vJqsCcbkFbYtr1
         SeKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtMBadl+JqqKmZPqaJLsOoq1KMWkQV4nZlM5ADYFONMoGXqdlYbKc59mZUWvvoZPqdCOdeXY04gvMFQmYqOLLDf586kEIWKrV7yQQCBewmzL+vpbwkLF9bYYeY3pjegiLG4diIFdGxj3HXre7aUsN89gFbseB+heH4hFQWDcRbvXwP2PAfX6RLMWW4quk8aRpxK3SueTUmAOuFqsmErCw=
X-Gm-Message-State: AOJu0YyVgD6guHTt4/iLTJcCaALLV73QvYHf79eyhOP4W/bV+H7yNNlw
	pq44VImXjypygfzjkoFxFTfVlfp/l5apE/eXl4pLiaBox5fPioWCb1UV2j5YqWFmL9WtlHY3iTb
	wzfi58UZkHvNVpbk82Rau4izcw80=
X-Google-Smtp-Source: AGHT+IG/TIKeSGMqKW6YChPWLmBMKKX3Gy9OdlipXJCgr21BbSHGjntCg3DDkBO9VhRmJoaGJJ94yJ2lJWoCLnINQBI=
X-Received: by 2002:a0c:fbc8:0:b0:696:a42d:898f with SMTP id
 n8-20020a0cfbc8000000b00696a42d898fmr1452653qvp.10.1711694704845; Thu, 28 Mar
 2024 23:45:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 29 Mar 2024 09:44:53 +0300
Message-ID: <CAOQ4uxhLPw9AKBWmUcom3RUrsov0q39tiNhh2Mw7qJbwKr1yRQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/36] Fuse-BPF and plans on merging with Fuse Passthrough
To: Daniel Rosenberg <drosen@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Fri, Mar 29, 2024 at 4:54=E2=80=AFAM Daniel Rosenberg <drosen@google.com=
> wrote:
>
> I've recently gotten some time to re-focus on fuse-bpf efforts, and

Glad to hear that this effort is still on track!

> had some questions on how to best integrate with recent changes that
> have landed in the last year. I've included a rebased version (ontop
> of bpf-next e63985ecd226 ("bpf, riscv64/cfi: Support kCFI + BPF on
> riscv64") of the old patchset for reference here.
>
> On the bpf end, I'm struggling a little bit with the interface for
> selecting programs. I'd like to be able to pass the map id to fuse,
> since that's a value userspace already knows the program by. Would it
> be reasonable to either pass that ID down to the registration
> function, or otherwise provide a path for a separate module to
> translate from a map id to a struct_op program?
>
> On the fuse end, I'm wondering how the interface will extend to
> directories. At LSFMMBPF last year, some people brought up concerns
> with the interface we had, specifically that it required opens to get
> fds, which we'd then use to respond to lookup requests, adding a lot
> of extra overhead. I had been planning to switch to a path that the
> response would supply instead, likely limited by RESOLVE_BENEATH. That
> seems pretty different from Fuse Passthrough's approach. Are there any
> current plans on how that interface will extend for a directory
> passthrough?
>

My plan was to start from passthrough ioctl with O_PATH fd on lookup
and deal with performance improvements later when there are actual
workloads that report a problem and that depends where the overhead is.

Is it with the opening of O_PATH fds?
Is it with the passthtough ioctls?
If latter, then when fuse uring is merged, I think we could get loose
the ioctls anyway.

> Could someone clarify why passthrough has an extra layer to register
> for use as a backing file? Does the ioctl provide some additional
> tracking purpose? I recall there being some security issue around
> directly responding with the fd. In fuse-bpf, we were handling this by
> responding to the fuse request via an ioctl in those cases.
>

The original reason was to mitigate an attack vector of fooling a
privileged process into writing the fd (number) to /dev/fuse to
gain access to a backing file this way.

The fuse-bpf way of doing all responds with ioctls seems fine for
this purpose, but note that the explicit setup also provides feedback
to the server in case the passthrough cannot be accomplished
for a specific inode (e.g. because of stacking depths overflow)
and that is a big benefit IMO.

> Passthrough also maintains a separate cred instance for each backing
> file. I had been planning to have a single one for the userspace
> daemon, likely grabbed during the init response. I'm unsure how the
> current Passthrough method there should scale to directories.
>

Using a global cred should be fine, just as overlayfs does.
The specific inode passthrough setup could mention if the global
cred should be used.

However, note that overlayfs needs to handle some special cases
when using mounter creds (e.g.: ovl_create_or_link() and dropping
of CAP_SYS_RESOURCE).

If you are going to mimic all this, better have that in the stacking fs
common code.

> Now on to my plans. Struct ops programs have more dynamic support now
> [1]. I'm hoping to be able to move most of the Fuse BPF related code
> to live closer to Fuse, and to have it more neatly encapsulated when
> building as a module. I'm not sure if everything that's needed for
> that exists, but I need to play with it a bit more to understand what
> I'm missing. I'll probably show up at bpf office hours at some point.
>
> Struct ops have proper multi page support now [2], which removes
> another patch. I'm still slightly over the struct ops limit, but that
> may change with other changes I'm considering.
>
> I'm very excited to see the new generic stacking filesystem support
> with backing-file [3]. I imagine in time we'll extend that to have a
> backing-inode as well, for the various inode_operations. That will

Yes, that was the plan.
I had initially planned to start an fsstack library, but I found out that
this "library" already exists (fs/stack.c), but it has code that is not a
good abstraction for ovl/fuse and ecryptfs will not be changed to
improve the abstraction, so we first need to burn this lib and start over:
https://github.com/amir73il/linux/commits/fsstack
Then, we can move backing_file.c into fs/stack/.

> definitely involve a lot of refactoring of the way fuse-bpf is
> currently structured, but it's clearly the right way forward.
>
> I'm glad to see fuse passthrough, which provides a subset of the
> fuse-bpf functionality, has landed[4]. I'm planning to rework the
> patch set to integrate better with that. First off, I've been
> considering splitting up the bpf progam into a dentry, inode, and file

That sounds like a good plan, but also, please remember Miklos' request -
please split the patch sets for review to:
1. FUSE-passthrough-all-mode
2. Attach BPF program

We FUSE developers must be able to review the FUSE/passthough changes
without any BPF code at all (which we have little understanding thereof)

As a merge strategy, I think we need to aim for merging all the FUSE
passthrough infrastructure needed for passthrough of inode operations
strictly before merging any FUSE-BPF specific code.

In parallel you may get BPF infrastructure merged, but integrating FUSE+BPF=
,
should be done only after all infrastructure is already merged IMO.

> set. That has the added bonus of pushing us back down below the
> current struct_op function list limits. I would want to establish some
> linkage between the sets, so that you could still just set the bpf
> program at a folder level, and have all objects underneath inherit the
> correct program. That's not an issue for a version with just file
> support, but I'll want to ensure the interface extends naturally. With
> the increased module support, I plan to redo all of the bpf program
> linking anyways. The existing code was a temporary placeholder while
> the method of registering struct ops programs was still in flux.
>

So I don't think there is any point in anyone actually reviewing the
v4 patch set that you just posted?

> My plan for the next patch set is to prune down to just the file

Please explain what you mean by that.
How are fuse-bpf file operations expected to be used and specifically,
How are they expected to extend the current FUSE passthrough functionality?

Do you mean that an passthrough setup will include a reference to a bpf
program that will be used to decide per read/write/splice operation
whether it should be passed through to backing file or sent to server
direct_io style?

I just wanted to make sure that you are aware of the fact that direct io
to server is the only mode of io that is allowed on an inode with an attach=
ed
backing file.

Thanks,
Amir.

> operations. That removes a lot of the tricky questions for the moment,
> and should shrink down the patch set massively. Along with that, I'll
> clean up the struct_op implementation to take more advantage of the
> recent bpf additions.
>
> [1] https://lore.kernel.org/r/20240119225005.668602-12-thinker.li@gmail.c=
om
> [2] https://lore.kernel.org/all/20240224223418.526631-3-thinker.li@gmail.=
com/
> [3] https://lore.kernel.org/all/20240105-vfs-rw-9b5809292b57@brauner/
> [4] https://lore.kernel.org/all/CAJfpegsZoLMfcpBXBPr7wdAnuXfAYUZYyinru3jr=
OWWEz7DJPQ@mail.gmail.com/
>
>
> Daniel Rosenberg (36):
>   fuse-bpf: Update fuse side uapi
>   fuse-bpf: Add data structures for fuse-bpf
>   fuse-bpf: Prepare for fuse-bpf patch
>   fuse: Add fuse-bpf, a stacked fs extension for FUSE
>   fuse-bpf: Add ioctl interface for /dev/fuse
>   fuse-bpf: Don't support export_operations
>   fuse-bpf: Add support for access
>   fuse-bpf: Partially add mapping support
>   fuse-bpf: Add lseek support
>   fuse-bpf: Add support for fallocate
>   fuse-bpf: Support file/dir open/close
>   fuse-bpf: Support mknod/unlink/mkdir/rmdir
>   fuse-bpf: Add support for read/write iter
>   fuse-bpf: support readdir
>   fuse-bpf: Add support for sync operations
>   fuse-bpf: Add Rename support
>   fuse-bpf: Add attr support
>   fuse-bpf: Add support for FUSE_COPY_FILE_RANGE
>   fuse-bpf: Add xattr support
>   fuse-bpf: Add symlink/link support
>   fuse-bpf: Add partial flock support
>   fuse-bpf: Add partial ioctl support
>   fuse-bpf: allow mounting with no userspace daemon
>   fuse-bpf: Add fuse-bpf constants
>   bpf: Increase struct_op max members
>   WIP: bpf: Add fuse_ops struct_op programs
>   fuse-bpf: Export Functions
>   fuse: Provide registration functions for fuse-bpf
>   fuse-bpf: Set fuse_ops at mount or lookup time
>   fuse-bpf: Call bpf for pre/post filters
>   fuse-bpf: Add userspace pre/post filters
>   WIP: fuse-bpf: add error_out
>   fuse-bpf: Add default filter op
>   tools: Add FUSE, update bpf includes
>   fuse-bpf: Add selftests
>   fuse: Provide easy way to test fuse struct_op call
>
>  fs/fuse/Kconfig                               |    8 +
>  fs/fuse/Makefile                              |    1 +
>  fs/fuse/backing.c                             | 4287 +++++++++++++++++
>  fs/fuse/bpf_register.c                        |  207 +
>  fs/fuse/control.c                             |    2 +-
>  fs/fuse/dev.c                                 |   85 +-
>  fs/fuse/dir.c                                 |  318 +-
>  fs/fuse/file.c                                |  126 +-
>  fs/fuse/fuse_i.h                              |  472 +-
>  fs/fuse/inode.c                               |  377 +-
>  fs/fuse/ioctl.c                               |   11 +-
>  fs/fuse/readdir.c                             |    5 +
>  fs/fuse/xattr.c                               |   18 +
>  include/linux/bpf.h                           |    2 +-
>  include/linux/bpf_fuse.h                      |  285 ++
>  include/uapi/linux/bpf.h                      |   13 +
>  include/uapi/linux/fuse.h                     |   41 +
>  kernel/bpf/Makefile                           |    4 +
>  kernel/bpf/bpf_fuse.c                         |  716 +++
>  kernel/bpf/bpf_struct_ops.c                   |    2 +
>  kernel/bpf/btf.c                              |    1 +
>  kernel/bpf/verifier.c                         |   10 +-
>  tools/include/uapi/linux/bpf.h                |   13 +
>  tools/include/uapi/linux/fuse.h               | 1197 +++++
>  .../selftests/filesystems/fuse/.gitignore     |    2 +
>  .../selftests/filesystems/fuse/Makefile       |  189 +
>  .../testing/selftests/filesystems/fuse/OWNERS |    2 +
>  .../selftests/filesystems/fuse/bpf_common.h   |   51 +
>  .../selftests/filesystems/fuse/bpf_loader.c   |  597 +++
>  .../testing/selftests/filesystems/fuse/fd.txt |   21 +
>  .../selftests/filesystems/fuse/fd_bpf.bpf.c   |  397 ++
>  .../selftests/filesystems/fuse/fuse_daemon.c  |  300 ++
>  .../selftests/filesystems/fuse/fuse_test.c    | 2476 ++++++++++
>  .../filesystems/fuse/struct_op_test.bpf.c     |  642 +++
>  .../selftests/filesystems/fuse/test.bpf.c     | 1045 ++++
>  .../filesystems/fuse/test_framework.h         |  172 +
>  .../selftests/filesystems/fuse/test_fuse.h    |  494 ++
>  37 files changed, 14385 insertions(+), 204 deletions(-)
>  create mode 100644 fs/fuse/backing.c
>  create mode 100644 fs/fuse/bpf_register.c
>  create mode 100644 include/linux/bpf_fuse.h
>  create mode 100644 kernel/bpf/bpf_fuse.c
>  create mode 100644 tools/include/uapi/linux/fuse.h
>  create mode 100644 tools/testing/selftests/filesystems/fuse/.gitignore
>  create mode 100644 tools/testing/selftests/filesystems/fuse/Makefile
>  create mode 100644 tools/testing/selftests/filesystems/fuse/OWNERS
>  create mode 100644 tools/testing/selftests/filesystems/fuse/bpf_common.h
>  create mode 100644 tools/testing/selftests/filesystems/fuse/bpf_loader.c
>  create mode 100644 tools/testing/selftests/filesystems/fuse/fd.txt
>  create mode 100644 tools/testing/selftests/filesystems/fuse/fd_bpf.bpf.c
>  create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_daemon.=
c
>  create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_test.c
>  create mode 100644 tools/testing/selftests/filesystems/fuse/struct_op_te=
st.bpf.c
>  create mode 100644 tools/testing/selftests/filesystems/fuse/test.bpf.c
>  create mode 100644 tools/testing/selftests/filesystems/fuse/test_framewo=
rk.h
>  create mode 100644 tools/testing/selftests/filesystems/fuse/test_fuse.h
>
>
> base-commit: e63985ecd22681c7f5975f2e8637187a326b6791
> --
> 2.44.0.478.gd926399ef9-goog
>

