Return-Path: <linux-unionfs+bounces-762-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56511912E24
	for <lists+linux-unionfs@lfdr.de>; Fri, 21 Jun 2024 21:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8788C1C2229A
	for <lists+linux-unionfs@lfdr.de>; Fri, 21 Jun 2024 19:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9730A17B504;
	Fri, 21 Jun 2024 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jzaRl8Wr"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2A85664
	for <linux-unionfs@vger.kernel.org>; Fri, 21 Jun 2024 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718999685; cv=none; b=VWh4BKfxIdR3u3+qIw4c/QsjZpuyb0dt3adDMnPBLinADjggCl1xGSyBywme9xUhuH22NsInmGK+Qrfi61yybYKdB4lTtB+RQS2CruYmlyHW/FoOOmEXkC6RjAiuoE1pCf4Jcr8rEOY36JsQpRQW9sX95W4CJKEQ1I98pV8zcTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718999685; c=relaxed/simple;
	bh=D3ymLZciavul1Y12MVNcx4+feyXXYgMZz6/03/D75sE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IN0r4yUdt6gSuFaHjCHLrCGmu4GozoTq41XtBf4b7oM1fLatfGJ5uE2trk2gjYImR43QDAge78gv/40r0l0ygy4cGURVSRI7dlx/88G+hFiJ6r/HLIlmkK5XNcHbKSwgbH2JHAFW2QFD54xuFXo2cHZwJMPLtcUiyp2onPMF4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jzaRl8Wr; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57d280e2d5dso2007322a12.1
        for <linux-unionfs@vger.kernel.org>; Fri, 21 Jun 2024 12:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1718999680; x=1719604480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=33jEI5/feKxqme62YiuJFqZt4cfWs+d7SXX2h8CWrRk=;
        b=jzaRl8Wrd7mvryJbCn5CX40Pe8/BJSiffXlFf/g7a5vo6zGimnPkCFrVbzWbiI/E7a
         YlUxJANtONOZOzf3/CQ1jqKezaLfzNJQ7DVYxj1TdLEFFYrHUg/fdzPCg2kkuIwGRHm2
         HkgvHeAi9eNeL8mNml+8m/Tn4n5PankPDw+CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718999680; x=1719604480;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=33jEI5/feKxqme62YiuJFqZt4cfWs+d7SXX2h8CWrRk=;
        b=SZV44kFVErnt433pZWHo9ZQOAtNTGm1ZTA9PUX0KIZzm8HWs1GDooeDJ4vhzVnZaj6
         cjsKQe0ekg1ps7pkqloy6LWmapS+c1F2hfyUU5IeZmUZgGUOssJmsz5U5IDOf3xdUkSu
         XxlpQsEliFJ0jT5BW7bs5YuvkvISXFWwX8CkCCL0eSjPcv9JhM4Ps5/ZbUHFbq8OjN6Q
         XzdKXhx9e20uBmB9Ke4d+yzkwL9ij13GvKvEA+L9IUAX7rZxiE5wtTbsx/QIoTfBFU7D
         VpsBbP/Dp8c6EWrs8Tv628WQ8NE3XzvghzLETNEA2qOCIFOZdfzvugnVYCGyTTZUgoKd
         hxQw==
X-Forwarded-Encrypted: i=1; AJvYcCXrSxLRVEygS9fXzc+ZvsUeHchs64sDbgNqaEUzms566O1+q3yiGbSElVgdP649WEHLR6/tCfjRMedtAUm4V92ruelSHyjvfUzgyZY6yQ==
X-Gm-Message-State: AOJu0YzKYncrF5+U+JUwr1bvV2cgYr/kGAOxzeeERZRyscPWCNRN9T85
	zU6NBG+L/UBJPJWpAhMpwopPxXIVeym0B757GMUWF4/ao9HZEj6zMgpKR6IDp87giz5ddCCn++H
	fp/K4zYT6xZPqL1/jYtwMYO2AxmshZ5jhgIdIoA==
X-Google-Smtp-Source: AGHT+IHMPxRSpeWfFETILoj83QSpeXgYk8tMPeCiUlyNTt4XtvfyTrE0PqN0dcALyeXIod8bt3F7q/kAGJ/d13yodi8=
X-Received: by 2002:a17:906:7148:b0:a6f:6292:2425 with SMTP id
 a640c23a62f3a-a6fab648959mr496741166b.38.1718999679727; Fri, 21 Jun 2024
 12:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 21 Jun 2024 21:54:28 +0200
Message-ID: <CAJfpegvm9M9Kzmtd=X66YijMOoJpKX62vuL4maD+7xBJ0-n5Zw@mail.gmail.com>
Subject: [GIT PULL] overlayfs fixes for 6.10-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git
tags/ovl-fixes-6.10-rc5

Fix two bugs, one originating in this cycle and one from 6.6.

Thanks,
Miklos

---
Miklos Szeredi (2):
      ovl: fix copy-up in tmpfile
      ovl: fix encoding fid for lower only root

---
 fs/overlayfs/dir.c    | 8 ++++----
 fs/overlayfs/export.c | 6 +++++-
 2 files changed, 9 insertions(+), 5 deletions(-)

