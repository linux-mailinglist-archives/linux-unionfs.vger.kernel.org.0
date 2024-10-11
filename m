Return-Path: <linux-unionfs+bounces-991-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8627999A862
	for <lists+linux-unionfs@lfdr.de>; Fri, 11 Oct 2024 17:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24AA41F257BE
	for <lists+linux-unionfs@lfdr.de>; Fri, 11 Oct 2024 15:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5901957FD;
	Fri, 11 Oct 2024 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ARJeQ+ZG"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42512198E7A
	for <linux-unionfs@vger.kernel.org>; Fri, 11 Oct 2024 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661972; cv=none; b=tRaU7eQc7/epRs8GnPB1ngicwt736ideKRWJxkmodFfrvaoxzxQrveiz5CFMXe9RBiTRtsFxD7HPIttJdqGip9851ISyWfjExJozN/5zLRRlWP871aZiUeECw9CaMEs0/4ztmgfDVAqymkhbKDF0tYmiOz7Xqsm41clOX3fIge4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661972; c=relaxed/simple;
	bh=2cnpIpx2npZ2RcJMdl1om2QaNoJNOR0GO7VoLTyd3PY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmjXMuYjloBhE6EsGSyOMwbVP0+Biu/x9Dfszoex92vyx9Af3XjHRfrCt6G19NW0JlKTDOGM0CCqwcEd1Ya2F2ObZHsXKXFWitm7w2+Dja0eZehdrNAqZEtSWaym/lQVgJTGk1sHgC9NItw0IQzGsMgcr7JViIPxqig3kG9CQ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ARJeQ+ZG; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fad6de2590so33091281fa.0
        for <linux-unionfs@vger.kernel.org>; Fri, 11 Oct 2024 08:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1728661968; x=1729266768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CKbCfc0GSJHP9tDSJaE2Sqci6+zlP6d2qUVYjC2YJRw=;
        b=ARJeQ+ZG12H0vVt5jsmZC9KjhSroNqKV8oWpZ8cOrbAbEu/T7RmP3dO7cPa3vWQLn/
         gCyASBh4y6JS3+9F/tHXKu0UBUE+akBPsw4gsiE4Fsm1xbK7cS53RayCcgB6HuP7v/Se
         sy35Kzh1DAa8rcc29nsSVQ2mzy5zAVjWs0fwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728661968; x=1729266768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKbCfc0GSJHP9tDSJaE2Sqci6+zlP6d2qUVYjC2YJRw=;
        b=A0uSJghW/az+QDfSsZJwVxUSietBXfNHcP41URkp+p2CSULKMMOz1prGBZ9RsDqh3X
         6exiWTynwiaOt6EWy24fRYVAKSvbs1UDsfA/Nl9s0kTvumhvuo6ePpu1yHv6jfCW6vnC
         QkoD7H6XsIH3IivKeOWvmVEa5AArt3DZuBpoBFNhZaiuWTRmEe0XdP3ah6epuIr0dXK6
         dTIKD7EIRmwVVdqOFc0iJjAlSXEkCNYfwLZHAFBtPU6oaaJVubxHL1PmD2e5xJbZTnXA
         pa1VwCAAtMeHKB+m4EFRH+q5LZmgL+YPPLbmBS3r5vRuPt7UD27N0j5xEXEzbh/mBiac
         L4vg==
X-Forwarded-Encrypted: i=1; AJvYcCWV0jl9dTcitGIiAHlqz8JQD68eZ92Cx5pNoqThi/ufCxFCsIpWtEWWyNn6MxQWQNrKEdeN6WoMARM4K4n0@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz24/qn93qD6agtsZxXlirrm97i4rqkh3erKh6QK8MVRGiSzN5
	Ks6ihVrqKa0XnEIJgg9aKpFZCxb5MLnSe2UCXfkv5EEVLpEV3IRdpo3b0yNPW/KOWTG9FF2FIny
	sd34Ef+ei0uXbSj3bO8e2ist8ZmgYJpiGmBFX6A==
X-Google-Smtp-Source: AGHT+IE5ypaAeiPlzEi3oHU8Y8cqAc8XraDYoYQ1xE4i6SbfplJ5kRLScOWnTlK7NqRHiXp9tOW+Vu6lYmpKsKKGKe8=
X-Received: by 2002:a2e:4e12:0:b0:2fa:dd6a:9250 with SMTP id
 38308e7fff4ca-2fb3f1b476fmr397641fa.20.1728661967999; Fri, 11 Oct 2024
 08:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-work-overlayfs-v1-0-e34243841279@kernel.org>
In-Reply-To: <20241011-work-overlayfs-v1-0-e34243841279@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 11 Oct 2024 17:52:32 +0200
Message-ID: <CAJfpeguO7PWQ9jRsYkW-ENRk6Y0GDGHJ6qt59+Wu6-sphQ75aw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] ovl: specify layers via file descriptors
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Oct 2024 at 17:43, Christian Brauner <brauner@kernel.org> wrote:

> The mount api doesn't allow overloading of mount option parameters
> (except for strings and flags). Making this work for arbitrary
> parameters would be quite ugly or file descriptors would have to be
> special cased. Neither is very appealing. I do prefer the *_fd mount
> options because they aren't ambiguous.

But the fd's just represent a path (they can be O_PATH, right?)

So upperdir and upperdir_fd are exactly the same options, no?  Just
the representation is different.

Am I missing something?

Thanks,
Miklos

