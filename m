Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 365291068E8
	for <lists+linux-unionfs@lfdr.de>; Fri, 22 Nov 2019 10:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKVJf1 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 22 Nov 2019 04:35:27 -0500
Received: from mail-yb1-f175.google.com ([209.85.219.175]:42959 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfKVJf1 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 22 Nov 2019 04:35:27 -0500
Received: by mail-yb1-f175.google.com with SMTP id a11so2479284ybc.9
        for <linux-unionfs@vger.kernel.org>; Fri, 22 Nov 2019 01:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=38Ube36fxNXGCUyi48CZ7QFLrU7pdCa/iYRXf9W3GMw=;
        b=Uv+DEKfvjB+lk7arHwyY0sXJhHWR47s/JJMEKprf3gTqlktKZ51zfWCHnblkWy6xSD
         5pKlCpjJBbBZLvVlZr6o7w0xJdcPWNc2j0ngUnJO5UAkckS3iAMrbomoX64XTLPAnr3P
         DvTHUVLZoR7fiQ7yQYwSgDtmbwBvK3gmhi/SUutMx8Uguz5VnycZEim0IxK3SoT8Sysx
         lyaAkXIAKncqtlBQhL7ovLKOm/brUxUuUwKC34TAL6zRocrmNOYC159bwgu5FB7EwGWu
         Lm5IgGealAtCBDI5P99RhMU+v5DYjlcBDwpYN5RmzZ2D4JzPR4oNYd4CsiyZ9SP1+2WB
         73yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38Ube36fxNXGCUyi48CZ7QFLrU7pdCa/iYRXf9W3GMw=;
        b=REHX0B6pjTsyU2doRWEAzkl2XFB8RdTCcmCLteZ+lC0fnFFyYGQF+NgzJr0b3froOZ
         rPvuoxw/MSRfnu7li8VBtwX6JsvOfIAiSRszQFTan1oY66dMzPOKjjEMmkcxAP3x457O
         M7/p/aVrOdo0CpQ3eGKnLjpOpnc3gLzBjnPFPyduumirvHNf2SNlRhdBCBVR1+xXnB0a
         t/OMt2RGVq6iBiWPydv+/qcVMxg7R1ubJ/bs9GtxQ5N77zoGmKOf4+ct+B6y55/DU57L
         eFOYx/fA1vAvBuqLwm0bl9RXdjwMRwTjeuOvVH+CaT6JbXL7/E4h3xYoFh0saL1beZ1a
         Ryww==
X-Gm-Message-State: APjAAAXI4/1R/0/CUYPzk8WnukeyDoWS46CWa2XPMicc95qiL9OQfJHf
        w3MW/aAguYM0ti2LY+duF7o24tlxb3H5Oi201eXNYg==
X-Google-Smtp-Source: APXvYqyT8bm+1bxnjrsbjk9WZCsfdisPYUEgPfqple1C5HvvSBDWXdtlGVCDFGPSDw/xxq3WcGkXuvvrz4W5bdvNRWo=
X-Received: by 2002:a25:6649:: with SMTP id z9mr8942051ybm.132.1574415326626;
 Fri, 22 Nov 2019 01:35:26 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxjryJep94sLgVxV7sGab8K3yeeDUZwOYOfLtOOguW1pcA@mail.gmail.com>
In-Reply-To: <CAOQ4uxjryJep94sLgVxV7sGab8K3yeeDUZwOYOfLtOOguW1pcA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 22 Nov 2019 11:35:15 +0200
Message-ID: <CAOQ4uxiHKjNba8HD5JUWFxxJqyJxPMk3fFfA3fi-nO6uJngTAg@mail.gmail.com>
Subject: Fwd: [ANNOUNCE] unionmount-testsuite: master branch updated to 509b1e7
To:     overlayfs <linux-unionfs@vger.kernel.org>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi All,

The master branch on the unionmount-testsuite tree [1] has been updated.

Changes in this update:
- Enhance --verify with copy up state checks
- Verify metadata only copy up with --verify --meta
- Verify unified ino domain with xino requires --verify --xino

Note that this release changes xino from a test configuration that is
implied from --verify to requiring an explicit opt-in with --xino option.

This change allows more strict checking of the xino=off configuration
and exposes a kernel v4.17 regression:

 ./run --ov=1 --verify hard-link
 ...
 /mnt/a/no_foo110: File unexpectedly on upper layer

Thanks,
Amir.

[1] https://github.com/amir73il/unionmount-testsuite

The head of the master branch is commit:

1724ef2 Decouple xino configuration from --verify

New commits:

Amir Goldstein (8):
  Fix ./run --ov --verify --recycle
  Simplify initialization of __upper
  Fix instantiation of hardlinked dentry
  Record meta copy_up vs. data copy_up
  Check that files were copied up as expected
  Reset dentry copy_up state on upper layer rotate
  Check that data was not copied up with metacopy=on
  Decouple xino configuration from --verify
