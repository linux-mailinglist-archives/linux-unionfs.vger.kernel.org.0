Return-Path: <linux-unionfs+bounces-1258-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C6AA30AAA
	for <lists+linux-unionfs@lfdr.de>; Tue, 11 Feb 2025 12:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19831672A7
	for <lists+linux-unionfs@lfdr.de>; Tue, 11 Feb 2025 11:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955761E5721;
	Tue, 11 Feb 2025 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="mwhW6KXM"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F381F8BDA
	for <linux-unionfs@vger.kernel.org>; Tue, 11 Feb 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739274414; cv=none; b=aJGY7NQqrxEGSxrv4feYmIVWyalGULFAAnT7P5n31GT3KMbHHKVaaPxNKUKruM4F7jLHdet1FManP4LPZZ+cABoY/d6SzaX4fCQl/5LYyvf+Q9bDePzehwTjZT0SOHdkUkvdrxxF0ZOfuwH/ttt3BzDLxP6a6Fn3iP0kpZZxyeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739274414; c=relaxed/simple;
	bh=HU2lgbAvTzZczLwDFM+mWgUlPFtVZnOv13XC/0hnkYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sneTEtT2AgertxtfuBxjWgYof2RRlLxaaEomc1iHeSoFdLN/9YfhZi1YisqgftWU8xKHMiPrz1iBZZYn9H232AuXBIa0/VK0QFOl/8KN9+V8RDsu4D5xw4iH0uLPCEjBYkil91d9vlvNz8wesahg/zUkdCbK0z+z3hiaIZlSLL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=mwhW6KXM; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46b1d40abbdso46434061cf.2
        for <linux-unionfs@vger.kernel.org>; Tue, 11 Feb 2025 03:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739274410; x=1739879210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HnL/Dz2TMv3JHkN6lrci9rKkr9vWVmRHytpkEbB8hbI=;
        b=mwhW6KXMSQu3qUzyGLTNL9hdaDihFijGsBgNE8qtDQc0/d73CLq18hfFRyUZXZHYVB
         KLZrrwkwoSPTRifBHxL5KCD6ibPjKIXTdOF7wC+OLJnDvHrr5tfOPdM+XfkftZ2+UH3u
         11X0FTaDXZDLXOJ9DaCpn189WrhQpJFy4w5ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739274410; x=1739879210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnL/Dz2TMv3JHkN6lrci9rKkr9vWVmRHytpkEbB8hbI=;
        b=Xgq/A73mnIoaKS23hH5updyT+niyYnW9Z4q5AKqVt6u+nTDX7MQ+Thaq3p1zyduL38
         bkhm62ssLKH7MESDxcbFNXNtpObzsl6TLW+MlusBaK1RE3uHTRUUY9QjJGaJxuSI3uJL
         jJ1dojYB+YnbVB2FUEP6Gty+sfR3qimM0Ta2nApHJg3w6e/WduulPLbkVexF/BKEjVMR
         6+TwbpKdRe2Fl+/0hr/U/7Pck1ujvXkLw25PJAVBBJhBL2b/uh9a4IF/RK9ZhcSFU+fX
         joCkRB4hQtzikOYhaj2IkKEw+GmUgfvJbHOxkjPW5SfzrepoDyqJDVeo0EC78lKNn+o9
         sIyw==
X-Forwarded-Encrypted: i=1; AJvYcCU30N9Pjvx+achPCH1aRmdd/pgiN1yCR9FgBfawW3D2KYpUr/1AD7VSYxoxt0l428S669eU0oS1Mmp7ixO/@vger.kernel.org
X-Gm-Message-State: AOJu0YziptEZigbsBuKcu4lXcnHp0UGJlu/ghrBrpsAI5D20ZcUsHcjz
	HzFF4FPGvYawj0sX9Ogz83bJ7cyAC/B8XrEA64J+tTXcRrA6ZsmS6q34XcrVmnkrgrK8VPdy+vJ
	mcp6Uh/kHn1fDr9W/f0/xG7XLTC150ovNC3CLdg==
X-Gm-Gg: ASbGncsZfTrfmBpM6sLxUgeR6YBYPzWJqS6R1i0rSXjHqwpamx4YQyNsPkE7GsBXcwm
	poi+zRq/vfcb17zBFSrTzD6Ys1Qc6tUd9hxL3m2esQc/mXt4cUT6LIIDkYvmUzyHj+CElzg==
X-Google-Smtp-Source: AGHT+IEWW3RDakLCwdfQuLRxiMstZeo43djhBnTNbsyfx9bWAzDFa1o0+Gc/AruWfR7kCc0WspRxJsr3bC1B9GBeV3k=
X-Received: by 2002:ac8:7d56:0:b0:471:8e90:dd5e with SMTP id
 d75a77b69052e-4718e90e1eamr108072371cf.42.1739274410167; Tue, 11 Feb 2025
 03:46:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210194512.417339-1-mszeredi@redhat.com> <20250210194512.417339-3-mszeredi@redhat.com>
 <CAOQ4uxiqis6kawuv4pa6jxHYgpQPc18izFP8e0TORfA_mVu_-w@mail.gmail.com>
In-Reply-To: <CAOQ4uxiqis6kawuv4pa6jxHYgpQPc18izFP8e0TORfA_mVu_-w@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Feb 2025 12:46:39 +0100
X-Gm-Features: AWEUYZmQtFnTTI0mTs7aDw6kMwxBThmXcOVaq7Luf-4CoUDMHKifueQXBzbE4NQ
Message-ID: <CAJfpegt=PWs8ZDF11p3nOCWHbWescE5nwVtUt82f=B6B+S0Miw@mail.gmail.com>
Subject: Re: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 12:13, Amir Goldstein <amir73il@gmail.com> wrote:

> What do you say about moving this comment outside the loop and leaving here
> only:
>
>     /* Should redirects/metacopy to lower layers be followed? */
>     if ((nextmetacopy && !ofs->config.metacopy) ||
>         (nextredirect && !ovl_redirect_follow(ofs)))
>           break;

Nice idea, except it would break the next patch.

I don't like the duplication either, maybe move
nextmetacopy/nextredirect into ovl_lookup_data and create a helper?

Thanks,
Miklos

