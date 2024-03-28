Return-Path: <linux-unionfs+bounces-510-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 364E28781C9
	for <lists+linux-unionfs@lfdr.de>; Mon, 11 Mar 2024 15:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4179281683
	for <lists+linux-unionfs@lfdr.de>; Mon, 11 Mar 2024 14:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3093FE52;
	Mon, 11 Mar 2024 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FtwoKkDH"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1F63FBBE
	for <linux-unionfs@vger.kernel.org>; Mon, 11 Mar 2024 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167995; cv=none; b=bD4crgyaYQjHmIfj0cTf/M+KF5HF8F18fnN8BE5tpCnPUZdbxfYm+xsivlJNQTocd+8NSYnUGhl964/ZiMTgYk+eYhnRen32su9ziAz8QFNPLQvkUqwMQHPo91FWvMzIKnDN0/byy7yw+Xz9Cp3vl8WLXzdm4HrKKne0YTbNLWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167995; c=relaxed/simple;
	bh=u4RbZxYkIUcZLlV/Aac1nmArqd0mIIwdpdWDUU4vGBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOn9de0p9HkR6sQG5tTPf+oIn2JYfo2rhxiztwuRIaZkP/YbJ60zsNAGRfcD4jg4jxXcj3NqoPJXQk4i4RE/cLD03NPQJX/XXGEhj0nqS06AjKPtsqq4d/M27vo/zoO5IWZ7gvvV8UrLgkqhU6SDCEQEFC2/oz4gY8jGTH8f5gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FtwoKkDH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4627a7233aso169129666b.1
        for <linux-unionfs@vger.kernel.org>; Mon, 11 Mar 2024 07:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710167991; x=1710772791; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HtzqfIQsJolmXYNugXTjr3G7HqidI6CITo9smjLyZOw=;
        b=FtwoKkDHraZU1QoV8Gum7FNgNNK37LfUzLn/WibufGarZSGcL8edRvDxuPyl2KGgjV
         hhRPWMJ4XjwgyCaT/VMpMPhN80X90X9eptqmTeE/4uxl+De2zMxiWc+fAGlp/IMWujoH
         Pvcy0fRPRV3nf3vzu+ussZJOxEjjULlZ3x+V0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710167991; x=1710772791;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HtzqfIQsJolmXYNugXTjr3G7HqidI6CITo9smjLyZOw=;
        b=gUV5q3ARcmmpIQBEsYB143OR5YS81chsjS0wF8z/cuqbU7padDX/ZGoXwt7/5ZPE6J
         EQu9fa/rLzGexGTZoze7BBO1u7bDsnRyQwesOCXDoqqyE+FSsjeNaG5CCeeQ9ikODMOF
         oVGCRy42ReVh7scbP006jvEfH4E3IMVbT5+OPeinG1HpwISu0VukJbGuY4k+8pcy5yqB
         iEKJMKWCr64CpUxQz8XtSBWjrIad0qulWJYJ8Lw2+a0FVCUOmGs9WUFzmLxTHbljyIDG
         uq8tQwUA3k41wQZ1dZ8tO/sbFDdJRQSO4x2IDxaqSj7CFfBMI1u2zlJcMNfRJ3IxJgWY
         pNqg==
X-Forwarded-Encrypted: i=1; AJvYcCWbqBS8lBAwPd5uq6UR2slAsjqW1/lCor9FINOlXMj7NMlEhVVW5BiT187/dFE1qkxmLsHOFXjg3YLZ5Ev46q9fH7KSjL2D2AXwXtMPog==
X-Gm-Message-State: AOJu0YxBoG+yzLKFGuW6p5XJ23D3B1fXQPZp0XhDoIwjOlCnpmch3p1O
	XWDjF0DCv46ZtPgenaDye34xIRChxNte58nebR1L1oyzzW7dZv6aqiiwma9YIL14tIXeZqaZz8l
	wq/XVEGOWGjcbMRGX1lrqmGlSLm2zfrmnPG20Kg==
X-Google-Smtp-Source: AGHT+IGf4wdVDNSe9F8sTHDMC/cjLnlVXjyWLYFxWYXRm2kSRwP0f2EzEVpHJ2uhZASUIGetXgmhSfoQf15nQCRa0/A=
X-Received: by 2002:a17:906:9c8e:b0:a46:13d3:e5e6 with SMTP id
 fj14-20020a1709069c8e00b00a4613d3e5e6mr5401892ejc.0.1710167990841; Mon, 11
 Mar 2024 07:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307160225.23841-1-lhenriques@suse.de> <20240307160225.23841-4-lhenriques@suse.de>
 <CAJfpegtQSi0GFzUEDqdeOAq7BN2KvDV8i3oBFvPOCKfJJOBd2g@mail.gmail.com>
 <87le6p6oqe.fsf@suse.de> <CAJfpeguN9nMJGJzx8sgwP=P9rJFVkYF5rVZOi_wNu7mj_jfBsA@mail.gmail.com>
 <20240311-weltmeere-gesiegt-798c4201c3f8@brauner>
In-Reply-To: <20240311-weltmeere-gesiegt-798c4201c3f8@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Mar 2024 15:39:39 +0100
Message-ID: <CAJfpegsn-jMY2J8Wd2Q9qmZFqxR6fAwZ4auoK+-uyxaK+F-0rw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ovl: fix the parsing of empty string mount parameters
To: Christian Brauner <brauner@kernel.org>
Cc: Luis Henriques <lhenriques@suse.de>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 14:25, Christian Brauner <brauner@kernel.org> wrote:

> Yeah, so with that I do agree. But have you read my reply to the other
> thread? I'd like to hear your thoughs on that. The problem is that
> mount(8) currently does:
>
> fsconfig(3, FSCONFIG_SET_FLAG, "usrjquota", NULL, 0) = -1 EINVAL (Invalid argument)
>
> for both -o usrjquota and -o usrjquota=

For "-o usrjquota" this seems right.

For "-o usrjquota=" it doesn't.  Flags should never have that "=", so
this seems buggy in more than one ways.

> So we need a clear contract with userspace or the in-kernel solution
> proposed here. I see the following options:
>
> (1) Userspace must know that mount options such as "usrjquota" that can
>     have no value must be specified as "usrjquota=" when passed to
>     mount(8). This in turn means we need to tell Karel to update
>     mount(8) to recognize this and infer from "usrjquota=" that it must
>     be passed as FSCONFIG_SET_STRING.

Yes, this is what I'm thinking.  Of course this only works if there
are no backward compatibility issues, if "-o usrjquota" worked in the
past and some systems out there relied on this, then this is not
sufficient.
>
> (2) We use the proposed in-kernel solution where relevant filesystems
>     get the ability to declare this both as a string or as a flag value
>     in their parameter parsing code. That's not a VFS generic thing.
>     It's a per-fs thing.

This encourages inconsistency between filesystems, but if there's no
other way to preserve backward compatibility, then...

>
> (3) We burden mount(8) with knowing what mount options are string
>     options that are allowed to be empty. This is clearly the least
>     preferable one, imho.
>
> (4) We add a sentinel such as "usrjquota=default" or
>     "usrjquota=auto" as a VFS level keyword.

I don't really understand how this last one is supposed to fix the issue.

> In any case, we need to document what we want:
>
> https://github.com/brauner/man-pages-md/blob/main/fsconfig.md

What's the plan with these?  It would be good if "man fsconfig" would
finally work.

Thanks,
Miklos

