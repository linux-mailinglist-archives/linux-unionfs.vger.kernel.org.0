Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDEC132AC2
	for <lists+linux-unionfs@lfdr.de>; Tue,  7 Jan 2020 17:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgAGQJZ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 7 Jan 2020 11:09:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59879 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728080AbgAGQJZ (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 7 Jan 2020 11:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578413364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MVGGQPGs/H6SVKV9BtWZvYmKFKG+iVt58Wff/ssjBmM=;
        b=BZHcO46bMEBN/LTCVIYWrBI1s1vVciNG6CY5j6kdDuB9Mj8WMtmSJZ1p/b302ccI9KtMKJ
        jZusc+nU7LHOqVkSAsnyXSgMHvrCE1e+GqgUeXdoVG4rfHxpf34ovqN1zyYZmYiEDQOX41
        BO3WpBPAZsKVtPTE5b0OX8wD3PEQT5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-JYsp0KW4Pf6-leAJfsbdxQ-1; Tue, 07 Jan 2020 11:09:23 -0500
X-MC-Unique: JYsp0KW4Pf6-leAJfsbdxQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 492C61800D4E;
        Tue,  7 Jan 2020 16:09:22 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D8A75D9CA;
        Tue,  7 Jan 2020 16:09:19 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E75BA2202E9; Tue,  7 Jan 2020 11:09:18 -0500 (EST)
Date:   Tue, 7 Jan 2020 11:09:18 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     "Ernst, Eric" <eric.ernst@intel.com>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>,
        "kata-dev@lists.katacontainers.io" <kata-dev@lists.katacontainers.io>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: Virtio-fs as upper layer for overlayfs
Message-ID: <20200107160918.GB15920@redhat.com>
References: <7904C889-F0AC-4473-8C02-887EF6593564@intel.com>
 <20200106183500.GA14619@redhat.com>
 <CAJfpegszhftUxkhaAaF3Gj4u+S5M74RwCrXLTptW=zcKz+_xug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegszhftUxkhaAaF3Gj4u+S5M74RwCrXLTptW=zcKz+_xug@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Jan 06, 2020 at 08:58:23PM +0100, Miklos Szeredi wrote:
> On Mon, Jan 6, 2020 at 7:35 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Mon, Jan 06, 2020 at 05:27:05PM +0000, Ernst, Eric wrote:
> >
> > [CC linux-unionfs@vger.kernel.org and amir]
> >
> > > Hi Miklos,
> > >
> > > One of the popular use cases for Kata Containers is running docker-in-docker.  That is, a container image is run which in turn will make use of a container runtime to do a container build.
> > >
> > > When combined with virtio-fs, we end up with a configuration like:
> > > xfs/ext4 -> overlayfs -> virtio-fs -> overlayfs
> > >
> > > As discussed in [1], per overlayfs spec:
> > > "The upper filesystem will normally be writable and if it is it must support the creation of trusted.* extended attributes, and must provide valid d_type in readdir responses, so NFS is not suitable."
> > >
> >
> > I don't know exaactly the reasons why NFS is not supported as upper. Are
> > above only two reasons? These might work with virtio-fs depending on
> > underlying filesystem. If yes, should we check for these properties
> > at mount time (instead of relying on dentry flags only,
> > ovl_dentry_remote()).
> >
> > I feel there is more to it.
> 
> NFS also has these automount points, that we currently can't cope with
> in overlayfs.  And there's revalidation, which we reject on upper
> simply because overlayfs currently doesn't call ->revalidate() on
> upper.   Not that we would not be able to, it's just something that
> probably needs some thought.
> 
> Virtio-fs does not yet have the magic automount thing (which would be
> useful to resolve inode number conflicts), but it does have
> revalidate. In the virtio-fs case, not calling ->revalidate() should
> not be a problem, so it's safe to try out this configuration by adding
> a hack to disable the remote check in case of a virtio-fs upper.

Here is a hack patch to provide an exception to allow virtiofs as upper
filesystem for overlayfs. 

I can mount now but I get warning that upper does not support xattr, hence
disabling index and metaocopy. Still need to test why that's the case. I
thought xattr are supported on virtiofs.


Subject: overlayfs: Allow virtiofs as overlayfs upper

This is a hack patch to allow virtiofs as overlayfs upper filesystem. At
this point of time it is meant for testing and see what issues crop up.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/overlayfs/namei.c     |    3 ++-
 fs/overlayfs/overlayfs.h |    2 ++
 fs/overlayfs/super.c     |    4 ++--
 fs/overlayfs/util.c      |   24 ++++++++++++++++++++++--
 4 files changed, 28 insertions(+), 5 deletions(-)

Index: rhvgoyal-linux/fs/overlayfs/util.c
===================================================================
--- rhvgoyal-linux.orig/fs/overlayfs/util.c	2020-01-07 11:03:22.584732137 -0500
+++ rhvgoyal-linux/fs/overlayfs/util.c	2020-01-07 11:03:55.424732137 -0500
@@ -102,11 +102,31 @@ struct ovl_entry *ovl_alloc_entry(unsign
 	return oe;
 }
 
+bool ovl_dentry_union(struct dentry *dentry)
+{
+	return dentry->d_flags & DCACHE_OP_REAL;
+}
+
 bool ovl_dentry_remote(struct dentry *dentry)
 {
 	return dentry->d_flags &
-		(DCACHE_OP_REVALIDATE | DCACHE_OP_WEAK_REVALIDATE
-		 DCACHE_OP_REAL);
+		(DCACHE_OP_REVALIDATE | DCACHE_OP_WEAK_REVALIDATE);
+}
+
+bool ovl_dentry_valid_upper(struct dentry *dentry)
+{
+	struct file_system_type *fs_type;
+
+	if (ovl_dentry_union(dentry))
+		return false;
+
+	fs_type = dentry->d_sb->s_type;
+
+	/* Provide an exception for virtiofs */
+	if (ovl_dentry_remote(dentry) && strcmp(fs_type->name, "virtiofs"))
+		return false;
+
+	return true;
 }
 
 bool ovl_dentry_weird(struct dentry *dentry)
Index: rhvgoyal-linux/fs/overlayfs/super.c
===================================================================
--- rhvgoyal-linux.orig/fs/overlayfs/super.c	2020-01-07 11:03:22.584732137 -0500
+++ rhvgoyal-linux/fs/overlayfs/super.c	2020-01-07 11:03:55.427732137 -0500
@@ -751,7 +751,7 @@ static int ovl_mount_dir(const char *nam
 		err = ovl_mount_dir_noesc(tmp, path);
 
 		if (!err)
-			if (ovl_dentry_remote(path->dentry)) {
+			if (!ovl_dentry_valid_upper(path->dentry)) {
 				pr_err("overlayfs: filesystem on '%s' not supported as upperdir\n",
 				       tmp);
 				path_put_init(path);
@@ -792,7 +792,7 @@ static int ovl_lower_dir(const char *nam
 
 	*stack_depth = max(*stack_depth, path->mnt->mnt_sb->s_stack_depth);
 
-	if (ovl_dentry_remote(path->dentry))
+	if (ovl_dentry_remote(path->dentry) || ovl_dentry_union(path->dentry))
 		*remote = true;
 
 	/*
Index: rhvgoyal-linux/fs/overlayfs/overlayfs.h
===================================================================
--- rhvgoyal-linux.orig/fs/overlayfs/overlayfs.h	2020-01-07 11:03:22.584732137 -0500
+++ rhvgoyal-linux/fs/overlayfs/overlayfs.h	2020-01-07 11:03:55.426732137 -0500
@@ -228,6 +228,8 @@ bool ovl_index_all(struct super_block *s
 bool ovl_verify_lower(struct super_block *sb);
 struct ovl_entry *ovl_alloc_entry(unsigned int numlower);
 bool ovl_dentry_remote(struct dentry *dentry);
+bool ovl_dentry_union(struct dentry *dentry);
+bool ovl_dentry_valid_upper(struct dentry *dentry);
 bool ovl_dentry_weird(struct dentry *dentry);
 enum ovl_path_type ovl_path_type(struct dentry *dentry);
 void ovl_path_upper(struct dentry *dentry, struct path *path);
Index: rhvgoyal-linux/fs/overlayfs/namei.c
===================================================================
--- rhvgoyal-linux.orig/fs/overlayfs/namei.c	2020-01-07 11:03:22.584732137 -0500
+++ rhvgoyal-linux/fs/overlayfs/namei.c	2020-01-07 11:03:55.428732137 -0500
@@ -845,7 +845,8 @@ struct dentry *ovl_lookup(struct inode *
 		if (err)
 			goto out;
 
-		if (upperdentry && unlikely(ovl_dentry_remote(upperdentry))) {
+		if (upperdentry &&
+		    unlikely(!ovl_dentry_valid_upper(upperdentry))) {
 			dput(upperdentry);
 			err = -EREMOTE;
 			goto out;

