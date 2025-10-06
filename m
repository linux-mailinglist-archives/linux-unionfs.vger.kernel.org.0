Return-Path: <linux-unionfs+bounces-2156-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1610BBE270
	for <lists+linux-unionfs@lfdr.de>; Mon, 06 Oct 2025 15:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4D8D4E9D5B
	for <lists+linux-unionfs@lfdr.de>; Mon,  6 Oct 2025 13:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A6E2C2363;
	Mon,  6 Oct 2025 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WADEXV5y"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5182E2C2340
	for <linux-unionfs@vger.kernel.org>; Mon,  6 Oct 2025 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759756602; cv=none; b=Xp/fBEqOhMkBYJL+HxjlGgMXmHMQ8W8kvebTYrb/1543KoxK+UeNWwGIg/QWOJavpg3i3Q6SehFCz1ZzCKkWEXfdJwx9y6+4nP5hAZ5HtSuRlIWyNH4/8XCiY/H08QLwnlgFWqzgC9c5cfPQruMsU9L/9fFM6t0zD3FGOHj+yRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759756602; c=relaxed/simple;
	bh=9RiibcQ8hYvWrHwNJrsOBQZBaxnayLS0Ew1MmhtqWo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aggZ8D7zL0/5zKXaBUJE9Gu8PJcR5E0LwQGLGkKMNIXvXjwaGEiocq6PVc/Z64HkLSZP7FWsbtR6uPFAB1NpV+5KOj00qxs0GvTn4eBIYNNfcgxWVbrlI4zkVS3zuOzCZlZNtBE1H0xqMvOw5sHFWSIcjqeJ0gXhU0o9aJ6XhKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WADEXV5y; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3e9d633b78so649743466b.1
        for <linux-unionfs@vger.kernel.org>; Mon, 06 Oct 2025 06:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759756599; x=1760361399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yONkX6le0asFqe/FiMMLWvsxiXDZUAvFOOTqPAZxMYs=;
        b=WADEXV5yL2pC5NDHItmncaXGE0hSdlv5UmaUabVz4OMowbUupEA2eTTd1Uk3iqDpiF
         FEcLPKLKFnOS5py3TFC9kWn3ztjBCuztlFmOEfacKAQttpJJQxc/xbeAn65EotLasYzM
         sj8ai6VFZM947QQLp/mb+TyctQSb5Hchyz6+CiRLDsghMTeL5f/FpjefA3x2Ppw3oBZw
         Dp9PngFT4H8gkJp7Aa+ZXu0H2UAovDLOJlmufZsREgxIA7sA6pPxcgNTwUgwQxyKXSvn
         YJr02dz1QtQaS7yolIBlYpluGlBpvbkCcVAxyhuHgXGCdi9jTWs+D6PmvrU/3U3IxJ1b
         oqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759756599; x=1760361399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yONkX6le0asFqe/FiMMLWvsxiXDZUAvFOOTqPAZxMYs=;
        b=GR/ys1CWZy8hMw3mH2qZR3+78OI7vlpxu4KhjuxLpP9S/UPldP5NkHeIr1kvrBgl+J
         1ijVbkrgfpxmISk/ECNnpl4Qu9x6Y6z5UCHlTRnDX3dcmUkZ6A25tbeWveUFEbABTmMi
         7GjmdMEln0EMvoVmBhBTbx4Y5lV4ajO1XCpTT6NeAw797buuCOfUlM6Ia5SM9rVLIXZf
         TAzjkCgMlUZtQifTeYBfgirlNxROUx//Z2tV7jZDG2NyLG1iZWDdJZmPKAiiYy85DN/h
         XLYj/2ks7CoUAPnKVNhSXNQLZQKLmkfdLizHKotpbL/mExwhjIxb4Avml488pARrSCl6
         bHag==
X-Forwarded-Encrypted: i=1; AJvYcCWy3G2SUUxcMc4kOznGzYrubLjhQAe//zMQrF7NlRU7I/bMA48y1DNIeuayo+ryjMSf3S9r2PyFi+BopfFe@vger.kernel.org
X-Gm-Message-State: AOJu0YzX0/OBzRrl9s6kNjZBWbkRfN/txdLrcFuxjEHxwAKxb13+R7DZ
	2AO6BhrjuSedYRMDMKi9+dwqundYfa5C8wtCNhMArlvMMyeWoyvNya1NYjtqaSro5r5adeJxlZo
	KdcJA9MRShkXZv0fXJ4hLV9ZGaV+VvKs=
X-Gm-Gg: ASbGncvnKhBS63437+LBPwWZ8ZCDeCWzfNAoMuF1gXuM1v+uNAS8RUq6NK/MJADj7SU
	XPF9W/wqBjBCJCRwZwSWjS98JhSHhvtFhUURXrvX6LqwAWx5RvCoKX9h3IpUAEdGsiwFwvYBk+y
	gUcnqpdpqa59g4RBtHWeV+h75scNrPfGpnfkzp5Lcy6ti2Ip2IumWxv7qUUMtEzEa6wJ7YnRVAt
	RuPmVvYv/M2CL5GHCJ3zD21w5uNWL2siKx3I+CJ3Skel0JUi6i7Af4GF4I9DPs2cIdXB7X+/Q==
X-Google-Smtp-Source: AGHT+IGgfaKILwiIYhOJauD31uynKvUTNQB8TM3B4u9+8sn3XNc0LxMTwvmUPPVqZHvJq+WHY2tARoUrXupUK50gMkY=
X-Received: by 2002:a17:906:37c5:b0:b4a:e7c9:84c1 with SMTP id
 a640c23a62f3a-b4ae7c98631mr906398266b.7.1759756598374; Mon, 06 Oct 2025
 06:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923104710.2973493-1-mjguzik@gmail.com> <20250929-samstag-unkenntlich-623abeff6085@brauner>
 <CAGudoHFm9_-AuRh52-KRCADQ8suqUMmYUUsg126kmA+N8Ah+6g@mail.gmail.com> <20251006-kernlos-etablieren-25b07b5ea9b3@brauner>
In-Reply-To: <20251006-kernlos-etablieren-25b07b5ea9b3@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 6 Oct 2025 15:16:26 +0200
X-Gm-Features: AS18NWCEM0fjjZM6zlyL8ddYZ6bYQjBB781Tu0JzfRDs6qIJETdk0ZVa55ZRAIQ
Message-ID: <CAGudoHGZreXKHGBvkEPOkf=tL69rJD0sTYAV0NJRVS2aA+B5_g@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] hide ->i_state behind accessors
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, 
	amir73il@gmail.com, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 1:38=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Mon, Sep 29, 2025 at 02:56:23PM +0200, Mateusz Guzik wrote:
> > This was a stripped down version (no lockdep) in hopes of getting into
> > 6.18. It also happens to come with some renames.
>
> That was not obvious at all and I didn't read that anywhere in the
> commit messages?
>

Well I thought I made it clear in the updated cover letter, we can
chalk it up to miscommunication. Shit happens.

> Anyway, please resend on top of vfs-6.19.inode where I applied your
> other patches! Thank you!

I rebased the patchset on top of vfs-6.19.inode and got a build failure:

fs/ocfs2/super.c:132:27: error: =E2=80=98inode_just_drop=E2=80=99 undeclare=
d here (not
in a function)
  132 |         .drop_inode     =3D inode_just_drop,
      |                           ^~~~~~~~~~~~~~~

and sure enough the commit renaming that helper is missing. Can you
please rebase the branch?

