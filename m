Return-Path: <linux-unionfs+bounces-397-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CE985EDB1
	for <lists+linux-unionfs@lfdr.de>; Thu, 22 Feb 2024 01:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB41284A33
	for <lists+linux-unionfs@lfdr.de>; Thu, 22 Feb 2024 00:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA9F881F;
	Thu, 22 Feb 2024 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WI8G2UF6"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD32AA35;
	Thu, 22 Feb 2024 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708560645; cv=none; b=dmBpybcBKCis/BRpwNag/jTQvYtGY0efoZzWFWJsPEr2ge2b4DHAsZVdNqgEJ8h594mN/cSXu991xBZECHJHVNtdRX8hTYKQI2QxCpH8vouBOVEwH6qsM37UVBuOnNG3y3SIdjuuweWt8ige2lqXBULRqdGOIBroyE+QHCn6lRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708560645; c=relaxed/simple;
	bh=zlJyY3XbdGnoeuA5i4CL3so5iDSHMzSmQnC6t4+gix4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDy6UzwtpJdYRvf7+BnW6sq/fIAA/AVUr+1elUTcDXAQnRIzVrfaZ6Q7bOKY+Jz5xeP2Zi+zzDZNwCeqrXkuZcZcJBoPIiI6C8pNCGeUUJLweG+eQihcJ1hpExdXtapDXNsEyblEFNUSPgSA2r7VJPt3/DuSXUiVB1Dhsd3ZB10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WI8G2UF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6E7C433F1;
	Thu, 22 Feb 2024 00:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708560645;
	bh=zlJyY3XbdGnoeuA5i4CL3so5iDSHMzSmQnC6t4+gix4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WI8G2UF6Y+uwZhKf4ihUf9stmKvZ91fGSJZc3PPmCtCjLuaro9rQSKP7q4y6PP348
	 KDWPM0ohXL+7wtH8MTTfPhNWn1XrX3D1dtF8j9c8I4V/zPEX8Mscb0aEjY77J2dgJ5
	 PVQD+pzHEABosHTh5/jnrtZ6Rx+qLIhYZZ3sW8QgHo7vwwIqPve1UvdL3TMmFSY/Oo
	 ej/2ix1Oe3qU7q/IKQFrElHCrpYPPdbgiGy3OLr8SmT95d5JbRH71anRrz5xpWCrrt
	 llmyfqzOTXLVvLZMjkcnfEVCeoBNFIMElRmCHbsf5tKnyBHMYAh9XyINg49vfJT6cM
	 lPV2HH7DkguaQ==
Date: Wed, 21 Feb 2024 18:10:44 -0600
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>,
	Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, audit@vger.kernel.org,
	selinux@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 12/25] selinux: add hooks for fscaps operations
Message-ID: <ZdaRBBU6K3nvklPI@do-x1extreme>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-12-3039364623bd@kernel.org>
 <CAHC9VhTgHP=3Te4=t6chGte15CA_tMoVjFuzBwh+FxQ6Ri4mQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTgHP=3Te4=t6chGte15CA_tMoVjFuzBwh+FxQ6Ri4mQQ@mail.gmail.com>

On Wed, Feb 21, 2024 at 06:38:33PM -0500, Paul Moore wrote:
> On Wed, Feb 21, 2024 at 4:25 PM Seth Forshee (DigitalOcean)
> <sforshee@kernel.org> wrote:
> >
> > Add hooks for set/get/remove fscaps operations which perform the same
> > checks as the xattr hooks would have done for XATTR_NAME_CAPS.
> >
> > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > ---
> >  security/selinux/hooks.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index a6bf90ace84c..da129a387b34 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3367,6 +3367,29 @@ static int selinux_inode_removexattr(struct mnt_idmap *idmap,
> >         return -EACCES;
> >  }
> >
> > +static int selinux_inode_set_fscaps(struct mnt_idmap *idmap,
> > +                                   struct dentry *dentry,
> > +                                   const struct vfs_caps *caps, int flags)
> > +{
> > +       return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
> > +}
> 
> The selinux_inode_setxattr() code also has a cap_inode_setxattr()
> check which is missing here.  Unless you are handling this somewhere
> else, I would expect the function above to look similar to
> selinux_inode_remove_fscaps(), but obviously tweaked for setting the
> fscaps and not removing them.

Right, but cap_inode_setxattr() doesn't do anything for fscaps, so I
omitted the call. Unless you think the call should be included in case
cap_inode_setxattr() changes in the future, which is a reasonable
position.

Thanks,
Seth

