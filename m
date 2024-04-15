Return-Path: <linux-unionfs+bounces-675-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE888A51CB
	for <lists+linux-unionfs@lfdr.de>; Mon, 15 Apr 2024 15:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679AA289C0E
	for <lists+linux-unionfs@lfdr.de>; Mon, 15 Apr 2024 13:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FFA71737;
	Mon, 15 Apr 2024 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JYVfqpYd"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F165D72B
	for <linux-unionfs@vger.kernel.org>; Mon, 15 Apr 2024 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188247; cv=none; b=iMg26AvqvMxhWLOSSDbjSq9lXSj1nqXBW0VIbDeDX9xW0FvoYR/aak8z54PR9qucOGxmeWQoc+OzAluMDvptg+Mnd62G8nR8kjN3wELjFWXwBtLclKlfujAIyCyJuZEuaIGklbTbr63WrZoydcX2VS+mhOJL7NalG+pvpW0/rHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188247; c=relaxed/simple;
	bh=4ViYQ+2Lt42ejTYjdgQpNkpQY07cN1icXMKPuFRqS/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9H470t8uwXD7SbPmJ/1mCUTJYfaxgbfKGc5aFLHwTV8mw4dLTVYeOD9vK0ouqlfHQT+oxpajX5tNQO5wFg75djStWt0Fzj8+gw/74vjkxNt1prQNefClSR3p2RRHzsNCp1f0cZWtDN/emQf0tnHWkmKFB46FeKXxL+p7FraIvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JYVfqpYd; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so6981986a12.1
        for <linux-unionfs@vger.kernel.org>; Mon, 15 Apr 2024 06:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1713188244; x=1713793044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aP8e5Mw/nPhZuC9dHaBcUgqP+I7JVkqAQoU/rOv9kGE=;
        b=JYVfqpYdSWC4MpJCLcQ3fslX/nt7dJRA8Cax0QkeBN5D2lvhpOvA61YsjqVBA2m1RR
         907slMVXqaJhxEsfefOxZjWVphsMriP+pEIJMRzxuC8RoOTeKCARubYfHsnZRIRrTToe
         cqWJRgWaAXveasjZ2Rn1Jf/YHPiZBvPPilz9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713188244; x=1713793044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aP8e5Mw/nPhZuC9dHaBcUgqP+I7JVkqAQoU/rOv9kGE=;
        b=oVHw7ux1+UxA1cBbxNp3FRamqU1SFyv+fo/VPAhJEdtYCap5wWLndNmFWVwzaCc584
         3z106pGO5XkP4Ss0AJdvY3gIoRWacJYHz/5Eyc5qJihL2W8PooIS+YTZbNNrNr1x9qpB
         SS366LssE7DWaS5JCN42CSb1HCUMO27ZbGQp6TmV6cxNbjPWQ9/pbcDf/oeixdLxyai6
         ENxdXkv2D/eaLhqAOqOjNQ/9+3J6JlLrHt/+6ay0qN59WOqLxNTAJ5QH2+5UzqL6wABN
         2kLWFvjcWuxEP2yxlNrurTaAFQtM/NdsNj4V3SyM1767BctuptZww26LmcLC/LuUK157
         d1kw==
X-Gm-Message-State: AOJu0YwWi8s2YiLmbkLQlXXd36In59T+mcyryFPzLpsYmJZHQyA5efFe
	BTca8yLLp4aZIUgydYVva4U3Lg8VqviVRrRKL4QJUVOJdVmnoRu0kSH3iORjI8ZuEtOWAtuJV8Q
	FsadQgl402/0dLMVUCy1pVOHIjb5Q0hIR4wilZw==
X-Google-Smtp-Source: AGHT+IGDr/x7Xv+COEDlGNPN+XEUwUdM0PcoyF/y4XPvsWnWqh2TgZVnrFy4LrDAEB3rCZ3WIkFeEuWQ6qS0snRFggU=
X-Received: by 2002:a17:906:140d:b0:a52:3631:72c7 with SMTP id
 p13-20020a170906140d00b00a52363172c7mr6990322ejc.5.1713188243973; Mon, 15 Apr
 2024 06:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <29C3102E-08CC-43D6-BCC0-2CA588A3C5B1@gmail.com>
In-Reply-To: <29C3102E-08CC-43D6-BCC0-2CA588A3C5B1@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 15 Apr 2024 15:37:11 +0200
Message-ID: <CAJfpegtVLbG8pCs3wJP2th_heX1AzyOzAbEc6ndF1=wJv3Bssg@mail.gmail.com>
Subject: Re: Question regarding internals of metacopy=on feature
To: Yuriy Belikov <yuriybelikov1@gmail.com>
Cc: linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Apr 2024 at 15:16, Yuriy Belikov <yuriybelikov1@gmail.com> wrote:

> such files are visible in the terminal using the ls command. However, as there
> were no modifications to the file content, a copy-up was not triggered. This leads
> to my question about the type of filesystem object represented in the upper-layer
> directory when only metadata is modified.

It will be a empty file with no allocated data.  If you read such a
file it will contain all zeroes, but those zeroes are not actually
stored on disk, so doing "du $METACOPY_FILE" should yield zero.

It's easy to create such objects with the truncate(1) utility.

Thanks,
Miklos

