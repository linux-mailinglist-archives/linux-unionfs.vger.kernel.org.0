Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9CF2E041A
	for <lists+linux-unionfs@lfdr.de>; Tue, 22 Dec 2020 02:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgLVBxu (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 21 Dec 2020 20:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgLVBxu (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 21 Dec 2020 20:53:50 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3EFC0613D3;
        Mon, 21 Dec 2020 17:53:08 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krWrG-00368L-Jw; Tue, 22 Dec 2020 01:53:02 +0000
Date:   Tue, 22 Dec 2020 01:53:02 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Liangyan <liangyan.peng@linux.alibaba.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v3] ovl: fix  dentry leak in ovl_get_redirect
Message-ID: <20201222015302.GR3579531@ZenIV.linux.org.uk>
References: <20201221183327.134077-1-liangyan.peng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221183327.134077-1-liangyan.peng@linux.alibaba.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Dec 22, 2020 at 02:33:27AM +0800, Liangyan wrote:

> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 28a075b5f5b2..e9aa4a12ad82 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -973,6 +973,7 @@ static char *ovl_get_redirect(struct dentry *dentry, bool abs_redirect)
>  	for (d = dget(dentry); !IS_ROOT(d);) {
>  		const char *name;
>  		int thislen;
> +		struct dentry *parent = NULL;
>  
>  		spin_lock(&d->d_lock);
>  		name = ovl_dentry_get_redirect(d);
> @@ -992,11 +993,10 @@ static char *ovl_get_redirect(struct dentry *dentry, bool abs_redirect)
>  
>  		buflen -= thislen;
>  		memcpy(&buf[buflen], name, thislen);
> -		tmp = dget_dlock(d->d_parent);
>  		spin_unlock(&d->d_lock);
> -
> +		parent = dget_parent(d);
>  		dput(d);
> -		d = tmp;
> +		d = parent;
>  
>  		/* Absolute redirect: finished */
>  		if (buf[buflen] == '/')

FWIW, I'd suggest this:

dget_dlock(d->d_parent) is unsafe - it requires ->d_lock on
dentry we are grabbing and that's not what we are holding
here.  It's the wrong way to grab the parent anyway; use
dget_parent(d) instead.


diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 28a075b5f5b2..d1efa3a5a503 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -992,8 +992,8 @@ static char *ovl_get_redirect(struct dentry *dentry, bool abs_redirect)
 
 		buflen -= thislen;
 		memcpy(&buf[buflen], name, thislen);
-		tmp = dget_dlock(d->d_parent);
 		spin_unlock(&d->d_lock);
+		tmp = dget_parent(d);
 
 		dput(d);
 		d = tmp;
