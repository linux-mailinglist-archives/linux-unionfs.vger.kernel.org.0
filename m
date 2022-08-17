Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6FE596DEA
	for <lists+linux-unionfs@lfdr.de>; Wed, 17 Aug 2022 14:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbiHQL4t (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 17 Aug 2022 07:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbiHQL4r (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 17 Aug 2022 07:56:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E5882D3B;
        Wed, 17 Aug 2022 04:56:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC7D4B81CCF;
        Wed, 17 Aug 2022 11:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF69C433C1;
        Wed, 17 Aug 2022 11:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660737403;
        bh=dZ5V0pYWBv2EO2scynhRABC5UwQLwIA8G30fRkCiqmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhXcbDLv/rCht9Xko0lxCBdFgNXkPGIFQ8qcVT9diSFDNmyl2KOYnXJnZA4Mowzyc
         PyUqM2LLHfqvPKhQkHXbq3bN7ZjbShbPCRbflM7LSAhO9rfavyDczwPqUuOy6d+yPb
         /kjTJYKWsI4v5vr0QQIWsmRmOUW9Kf51HIwbcfKvnYsquR32yhOb15G/fkLZVkdip9
         x1mnJYtR5ocIz0T0brqQndRrzW4aPcYGS3NU14GX0ATuqbXrDzb3i/caMxZLfo8hfL
         lJGZXCqjzKLpVbVupkag6/wuE9I04LqYVAlegAFu7dGdWBGOnw/PsqYeQ3u/T5GLBo
         f0vmDUqKDzoew==
Date:   Wed, 17 Aug 2022 13:56:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     =?utf-8?B?5aSp6LWQ5byg?= <zhangtianci.1997@bytedance.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: Re: [External] Re: [PATCH] ovl: Do not override fsuid and fsgid in
 ovl_link()
Message-ID: <20220817115638.2etj6ruuutjurgjv@wittgenstein>
References: <20220817034559.44936-1-zhangtianci.1997@bytedance.com>
 <CAOQ4uxgrkPYBkZG--70s4PnUiT0ht=GdWrrm+aY4ZHoZjZrWAw@mail.gmail.com>
 <CAP4dvsfqxEGJtQgSdfN+nxbyMAdm2rj_tmUeqXc8syPyK98MHA@mail.gmail.com>
 <CAOQ4uxhD0an61z5wArn=uRsXF7+_3soNgPB7ikp2HYX8nQGkCg@mail.gmail.com>
 <CAOQ4uxj_XhC51yS0QCoo8kYWmMxm1XQH4bhoSMZReUd7nc2UFA@mail.gmail.com>
 <20220817102722.wny7x5iwf62edpkd@wittgenstein>
 <20220817102951.xnvesg3a7rbv576x@wittgenstein>
 <CAP4dvscpm2FyuJ6gqZz=32ffrN9BORaa=Q0grPEgB+KUXbJniw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP4dvscpm2FyuJ6gqZz=32ffrN9BORaa=Q0grPEgB+KUXbJniw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Aug 17, 2022 at 07:36:44PM +0800, 天赐张 wrote:
> On Wed, Aug 17, 2022 at 6:29 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Wed, Aug 17, 2022 at 12:27:27PM +0200, Christian Brauner wrote:
> > > On Wed, Aug 17, 2022 at 12:55:22PM +0300, Amir Goldstein wrote:
> > > > On Wed, Aug 17, 2022 at 12:53 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > >
> > > > > On Wed, Aug 17, 2022 at 12:11 PM 天赐张 <zhangtianci.1997@bytedance.com> wrote:
> > > > > >
> > > > > > On Wed, Aug 17, 2022 at 3:36 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Aug 17, 2022 at 6:49 AM Zhang Tianci
> > > > > > > <zhangtianci.1997@bytedance.com> wrote:
> > > > > > > >
> > > > > > > > ovl_link() did not create a new inode after commit
> > > > > > > > 51f7e52dc943 ("ovl: share inode for hard link"), so
> > > > > > > > in ovl_create_or_link() we should not override cred's
> > > > > > > > fsuid and fsgid when called by ovl_link().
> > > > > > > >
> > > > > > > > Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> > > > > > > > Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> > > > > > > > ---
> > > > > > > >  fs/overlayfs/dir.c | 4 ++--
> > > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > > > > > > > index 6b03457f72bb..568d338032db 100644
> > > > > > > > --- a/fs/overlayfs/dir.c
> > > > > > > > +++ b/fs/overlayfs/dir.c
> > > > > > > > @@ -595,9 +595,9 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
> > > > > > > >         err = -ENOMEM;
> > > > > > > >         override_cred = prepare_creds();
> > > > > > > >         if (override_cred) {
> > > > > > > > -               override_cred->fsuid = inode->i_uid;
> > > > > > > > -               override_cred->fsgid = inode->i_gid;
> > > > > > > >                 if (!attr->hardlink) {
> > > > > > > > +                       override_cred->fsuid = inode->i_uid;
> > > > > > > > +                       override_cred->fsgid = inode->i_gid;
> > > > > > > >                         err = security_dentry_create_files_as(dentry,
> > > > > > > >                                         attr->mode, &dentry->d_name, old_cred,
> > > > > > > >                                         override_cred);
> > > > > > > > --
> > > > > > >
> > > > > > > This change looks incorrect.
> > > > > > > Unless I am missing something, fsuid/fsgid still need to
> > > > > > > be overridden for calling link() on underlying fs.
> > > > > > > What made you do this change?
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Amir.
> > > > > >
> > > > > > Hi Amir,
> > > > > >
> > > > > > I ran into an error when I tested overlay on fuse:
> > > > > >   $ mkdir /lower /fuse /merge
> > > > > >   $ mount -t fuse /fuse
> > > > > >   $ mkdir /fuse/upper /fuse/work
> > > > > >   $ mount -t overlay /merge -o lowerdir=/lower,upperdir=/fuse/upper,workdir=work
> > > > > >   $ touch /merge/file
> > > > > >   $ chown bin.bin /merge/file // the file's caller becomes "bin"
> > > > > >   $ ln /merge/file /merge/lnkfile
> > > > > >
> > > > > > Then I got an error(EACCES) because fuse daemon checks the link()'s
> > > > > > caller is "bin", it denied this request.
> > > > > > I browsed the changing history of ovl_link(). There are two key commits:
> > > > > > The first is commit bb0d2b8ad296 ("ovl: fix sgid on directory") which
> > > > > > overrides the cred's fsuid/fsgid using the new inode. The new inode's
> > > > > > owner is initialized by inode_init_owner(), and inode->fsuid is
> > > > > > assigned to the current user. So the override fsuid becomes the
> > > > > > current user. We know link() is actually modifying the directory, so
> > > > > > the caller must have the MAY_WRITE permission on the directory. The
> > > > > > current caller may should have this permission. I think this is
> > > > > > acceptable to use the caller's fsuid(But I still feel a little
> > > > > > conflicted with the overlay's design).
> > > > > > The second is commit 51f7e52dc943 ("ovl: share inode for hard link")
> > > > > > which removed the inode creation in ovl_link(). This commit move
> > > > > > inode_init_owner() into ovl_create_object(), so the ovl_link() just
> > > > > > give the old inode to ovl_create_or_link(). Then the override fsuid
> > > > > > becomes the old inode's fsuid, neither the caller nor the overlay's
> > > > > > creator! So I think this is incorrect.
> > > > > > I think the link() should be like unlink(), overlay fs should just use
> > > > > > the creator cred to do underlying fs's operations.
> > > > > >
> > > > >
> > > > > I see. The reproducer and explanation belong in the commit message.
> > > > >
> > > > > Your argument makes sense to me, but CC Christian to make
> > > > > sure I am not missing anything related to ACLs and what not.
> > > >
> > > > Once again with correct email address...
> > >
> > > So we have:
> > >
> > > ovl_create_object()
> > > -> ovl_override_creds(ovl_sb)
> > > -> ovl_new_inode()
> > >    -> inode_init_owner()
> > >       {
> > >               inode->i_uid = current_fsuid();
> > >               inode->i_gid = current_fsgid();
> 
> In inode_init_owner(), the inode->i_gid may inherit from parent dir.
> And this is the main purpose of the commit bb0d2b8ad296 ("ovl: fix
> sgid on directory").
> 
> > >       }
> > > -> ovl_create_or_link(inode, ...)
> > > -> prepare_creds() // Copy of caller's creds
> >
> > s/caller's/creator's/
> >
> > > {
> > >         override_creds->fsuid = inode->i_uid;
> > >         override_creds->fsgid = inode->i_gid;
> > > }
> > > -> revert_creds()
> > >
> > > which afaict means that the mounter's credentials are used apart from
> > > the fs{g,u}id which is taken from inode->i_{g,u}id which should
> > > correspond to current_fs{g,u}id().
> > >
> > > The commit that is pointed out in the patch
> > > 51f7e52dc943 ("ovl: share inode for hard link")
> > > seems to have broken that assumption.
> > >
> > > Given that the intention was to use the creator's creds _with the
> > > caller's fs{g,u}id_ wouldn't it make more sense to simply ensure that
> > > the caller's fs{g,u}id are always used instead of using the full
> > > creator's creds just for the link operation? So something like this
> > > (untested):
> > >
> > > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > > index 6b03457f72bb..4a3ee16a6d70 100644
> > > --- a/fs/overlayfs/dir.c
> > > +++ b/fs/overlayfs/dir.c
> > > @@ -575,6 +575,9 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
> > >         const struct cred *old_cred;
> > >         struct cred *override_cred;
> > >         struct dentry *parent = dentry->d_parent;
> > > +       /* Retrieve caller's fs{g,u}id before we override creds below. */
> > > +       kuid_t caller_fsuid = current_fsuid();
> > > +       kgid_t caller_fsgid = current_fsgid();
> > >
> > >         err = ovl_copy_up(parent);
> > >         if (err)
> > > @@ -595,8 +598,8 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
> > >         err = -ENOMEM;
> > >         override_cred = prepare_creds();
> > >         if (override_cred) {
> > > -               override_cred->fsuid = inode->i_uid;
> > > -               override_cred->fsgid = inode->i_gid;
> > > +               override_cred->fsuid = caller_fsuid;
> > > +               override_cred->fsgid = caller_fsgid;
> 
> So the override_cred->fsgid should be inode->i_gid if the inode is a new inode.
> 
> > >                 if (!attr->hardlink) {
> > >                         err = security_dentry_create_files_as(dentry,
> > >                                         attr->mode, &dentry->d_name, old_cred,
> 
> So your meaning should be like this:
> 
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 6b03457f72bb..9aead6ddc071 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -575,6 +575,8 @@ static int ovl_create_or_link(struct dentry
> *dentry, struct inode *inode,
>         const struct cred *old_cred;
>         struct cred *override_cred;
>         struct dentry *parent = dentry->d_parent;
> +       kuid_t caller_fsuid = current_fsuid();
> +       kgid_t caller_fsgid = current_fsgid();
> 
>         err = ovl_copy_up(parent);
>         if (err)
> @@ -595,9 +597,9 @@ static int ovl_create_or_link(struct dentry
> *dentry, struct inode *inode,
>         err = -ENOMEM;
>         override_cred = prepare_creds();
>         if (override_cred) {
> -               override_cred->fsuid = inode->i_uid;
> -               override_cred->fsgid = inode->i_gid;
>                 if (!attr->hardlink) {
> +                       override_cred->fsuid = inode->i_uid;
> +                       override_cred->fsgid = inode->i_gid;
>                         err = security_dentry_create_files_as(dentry,
>                                         attr->mode, &dentry->d_name, old_cred,
>                                         override_cred);
> @@ -605,6 +607,9 @@ static int ovl_create_or_link(struct dentry
> *dentry, struct inode *inode,
>                                 put_cred(override_cred);
>                                 goto out_revert_creds;
>                         }
> +               } else {
> +                       override_cred->fsuid = caller_fsuid;
> +                       override_cred->fsgid = caller_fsgid;
>                 }
>                 put_cred(override_creds(override_cred));
>                 put_cred(override_cred);

Hah, wait. I had a pretty obvious braino when I did that. I forgot to
account for setgid handling in inode_init_owner(). Let me take another
close look...
