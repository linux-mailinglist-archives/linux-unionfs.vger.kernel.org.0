Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D297089BC
	for <lists+linux-unionfs@lfdr.de>; Thu, 18 May 2023 22:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjERUqr (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 18 May 2023 16:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjERUqq (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 18 May 2023 16:46:46 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EA1E7F
        for <linux-unionfs@vger.kernel.org>; Thu, 18 May 2023 13:46:42 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-562191bcfb9so2007507b3.3
        for <linux-unionfs@vger.kernel.org>; Thu, 18 May 2023 13:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684442801; x=1687034801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceRGVx/G/DIAtzoiWa4XydM/1i0e0FVfY4COrvhs3MU=;
        b=f3lAmIY6pXJsw2oWtyM6mMS+jpx4Rl6M61SR+LixhHxuPTSkl55UpVUTtpqAtW3ECd
         SkSHp6dsMUTIQRXyCa/VmIfIQde+Cblzk7shN4RTrv0X6+n3vGG+Rboae9GqEYkOzbRt
         KgJC4j0T2KzDHYkhHZ05XlH1G54OSrIQTPu/TmiNKqM+2WhiNsqvxquIj/YfL2hni7Md
         oLXb4ehJX/DBoA8ETkFhdpgb7nXMYkogVAbgvK9UgJAEoqNteYa2Z0jVmt37lwJAt8Nq
         jT8MDtSQh8Fn9jZ8VpWQo29agACImh5m8pOaCUvbjB82agUALx82/JX/2CzsKZYI+Kzg
         1NVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684442801; x=1687034801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceRGVx/G/DIAtzoiWa4XydM/1i0e0FVfY4COrvhs3MU=;
        b=FL1aSVryReSXZMBkiYnzEWPRDELDafbNajDRNX9MOmlwTJjbe/YZ2lBe9RlG28bSiQ
         nJnOR5nFHzr9nPtJP0XH7WAjyYPsJ3h63nYTCpFstSujZlXAacx6CzMXMOElvrFOkGga
         TRT5suprxsMMk/QbFuQDIatINh+wehL/tZUkWHHXNInpGDWDLnMhGA0T3iR+Ski6++62
         5BQP+3O3GTmWLPBpkzD1poYgC806/ITh5G74wwGC7WfFfGpBUCb+H4oTNgZqv4gWmKCX
         zw4vNYF+hgfoYYbu+Ox+8L59barBfsjCRaDEv3LO6t/VkB/xYWTaBYvqB8F58k3W8zrB
         Io8Q==
X-Gm-Message-State: AC+VfDygoUx8rusoo6YxdUO8hhkmDa9Nkkg3W6I9o6jrqvpCMGwi6nR2
        HgdWwez8j1jEYMsduyJNdlmbts+rOKhXLM3SUPldE+fKIpBpE0w=
X-Google-Smtp-Source: ACHHUZ4eL17jrcySmxt9X35Rh5Et3YQ+GGqU79cdnwTL2tIi9T9iIRnbebiNAOfzGfnlla+q/zh/RWedcu4H6IybIdI=
X-Received: by 2002:a25:aba5:0:b0:ba8:1089:3338 with SMTP id
 v34-20020a25aba5000000b00ba810893338mr264525ybi.39.1684442801146; Thu, 18 May
 2023 13:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <90a25725b4b3c96e84faefdb827b261901022606.camel@kernel.org> <cbffa3dee65ecc0884dd16eb3af95c09a28f4297.camel@linux.ibm.com>
In-Reply-To: <cbffa3dee65ecc0884dd16eb3af95c09a28f4297.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 May 2023 16:46:30 -0400
Message-ID: <CAHC9VhSeBn-4UN48NcQWhJqLvQuydt4OvdyUsk9AXcviJ9Cqyw@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after writes
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Fri, Apr 21, 2023 at 10:44=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
> On Fri, 2023-04-07 at 09:29 -0400, Jeff Layton wrote:
> > > > > >
> > > > > > I would ditch the original proposal in favor of this 2-line pat=
ch shown here:
> > > > > >
> > > > > > https://lore.kernel.org/linux-integrity/a95f62ed-8b8a-38e5-e468=
-ecbde3b221af@linux.ibm.com/T/#m3bd047c6e5c8200df1d273c0ad551c645dd43232
> > >
> > > We should cool it with the quick hacks to fix things. :)
> > >
> >
> > Yeah. It might fix this specific testcase, but I think the way it uses
> > the i_version is "gameable" in other situations. Then again, I don't
> > know a lot about IMA in this regard.
> >
> > When is it expected to remeasure? If it's only expected to remeasure on
> > a close(), then that's one thing. That would be a weird design though.
>
> Historical background:
>
> Prior to IMA being upstreamed there was a lot of discussion about how
> much/how frequently to measure files.  Re-measuring files after each
> write would impact performance.  Instead of re-measuring files after
> each write, if a file already opened for write was opened for read
> (open writers) or a file already opened for read was opened for write
> (Time of Measure/Time of Use) the IMA meausrement list was invalidated
> by including a violation record in the measurement list.
>
> Only the BPRM hook prevents a file from being opened for write.
>
> >
> > > > > >
> > > > > >
> > > > >
> > > > > Ok, I think I get it. IMA is trying to use the i_version from the
> > > > > overlayfs inode.
> > > > >
> > > > > I suspect that the real problem here is that IMA is just doing a =
bare
> > > > > inode_query_iversion. Really, we ought to make IMA call
> > > > > vfs_getattr_nosec (or something like it) to query the getattr rou=
tine in
> > > > > the upper layer. Then overlayfs could just propagate the results =
from
> > > > > the upper layer in its response.
> > > > >
> > > > > That sort of design may also eventually help IMA work properly wi=
th more
> > > > > exotic filesystems, like NFS or Ceph.
> > > > >
> > > > >
> > > > >
> > > >
> > > > Maybe something like this? It builds for me but I haven't tested it=
. It
> > > > looks like overlayfs already should report the upper layer's i_vers=
ion
> > > > in getattr, though I haven't tested that either:
> > > >
> > > > -----------------------8<---------------------------
> > > >
> > > > [PATCH] IMA: use vfs_getattr_nosec to get the i_version
> > > >
> > > > IMA currently accesses the i_version out of the inode directly when=
 it
> > > > does a measurement. This is fine for most simple filesystems, but c=
an be
> > > > problematic with more complex setups (e.g. overlayfs).
> > > >
> > > > Make IMA instead call vfs_getattr_nosec to get this info. This allo=
ws
> > > > the filesystem to determine whether and how to report the i_version=
, and
> > > > should allow IMA to work properly with a broader class of filesyste=
ms in
> > > > the future.
> > > >
> > > > Reported-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > >
> > > So, I think we want both; we want the ovl_copyattr() and the
> > > vfs_getattr_nosec() change:
> > >
> > > (1) overlayfs should copy up the inode version in ovl_copyattr(). Tha=
t
> > >     is in line what we do with all other inode attributes. IOW, the
> > >     overlayfs inode's i_version counter should aim to mirror the
> > >     relevant layer's i_version counter. I wouldn't know why that
> > >     shouldn't be the case. Asking the other way around there doesn't
> > >     seem to be any use for overlayfs inodes to have an i_version that
> > >     isn't just mirroring the relevant layer's i_version.
> >
> > It's less than ideal to do this IMO, particularly with an IS_I_VERSION
> > inode.
> >
> > You can't just copy up the value from the upper. You'll need to call
> > inode_query_iversion(upper_inode), which will flag the upper inode for =
a
> > logged i_version update on the next write. IOW, this could create some
> > (probably minor) metadata write amplification in the upper layer inode
> > with IS_I_VERSION inodes.
> >
> >
> > > (2) Jeff's changes for ima to make it rely on vfs_getattr_nosec().
> > >     Currently, ima assumes that it will get the correct i_version fro=
m
> > >     an inode but that just doesn't hold for stacking filesystem.
> > >
> > > While (1) would likely just fix the immediate bug (2) is correct and
> > > _robust_. If we change how attributes are handled vfs_*() helpers wil=
l
> > > get updated and ima with it. Poking at raw inodes without using
> > > appropriate helpers is much more likely to get ima into trouble.
> >
> > This will fix it the right way, I think (assuming it actually works),
> > and should open the door for IMA to work properly with networked
> > filesystems that support i_version as well.
>
> On a local filesystem, there are guarantees that the calculated file
> hash is that of the file being used.  Reminder IMA reads a file, page
> size chunk at a time into a single buffer, calculating the file hash.
> Once the file hash is calculated, the memory is freed.
>
> There are no guarantees on a fuse filesystem, for example, that the
> original file read and verified is the same as the one being executed.
> I'm not sure that the integrity guarantees of a file on a remote
> filesystem will be the same as those on a local file system.
>
> >
> > Note that there Stephen is correct that calling getattr is probably
> > going to be less efficient here since we're going to end up calling
> > generic_fillattr unnecessarily, but I still think it's the right thing
> > to do.
> >
> > If it turns out to cause measurable performance regressions though,
> > maybe we can look at adding a something that still calls ->getattr if i=
t
> > exists but only returns the change_cookie value.
>
> Sure.  For now,
>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

I'm going through my review queue to make sure I haven't missed
anything and this thread popped up ... Stefan, Mimi, did you get a fix
into an upstream tree somewhere?  If not, is it because you are
waiting on a review/merge from me into the LSM tree?

--=20
paul-moore.com
