Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB3937588
	for <lists+linux-unionfs@lfdr.de>; Thu,  6 Jun 2019 15:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfFFNoX (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 6 Jun 2019 09:44:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55814 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfFFNoX (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 6 Jun 2019 09:44:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so2204226wmj.5
        for <linux-unionfs@vger.kernel.org>; Thu, 06 Jun 2019 06:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fvQrk6QqMWIbLlAcsJuBVoZshDn5zuagYNbpKnSUNYk=;
        b=ZesqP08QI2a2cCi5fQdLu7o52AAZGx22ZZYszKIm4/0sAcYm8gmt3S8Xdy9/quXxo8
         fCc9Svaa7NjdeYsBcL7Z3PfXcbwUby41EXbz72I8BMIqAQD5+dH7o0DtybR6fEJClRXf
         UM+9oBxCF775fHhmCTgv7wTlyfvcGjkIx7jQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fvQrk6QqMWIbLlAcsJuBVoZshDn5zuagYNbpKnSUNYk=;
        b=ScHVPB9iEvpW8IU3/lJN88Www3I6rgs/1opYEtMYwOmsCyM51kEBShFNUnCa7YXgvw
         J0d4SehdiYZCRDnMjI0OIjGk2TEbXlMczkJswj9RABnbU9IQ57+6Sj7/Ac+fhvbBlE8x
         pgT7NFfXijAC4mpVr/B0hh4BGL/HmuJEBz9No7eXf9JWmxr2SkfSGvlcmI0b8VRePHMP
         +jFUES8CqyzP+zcIUFp9zkFzLJYus4iPiZSqJDwkVzDRiDz3DvaLhMjwCj3iDVkexcBD
         yTZcvdkbKez8P8XWBpTLN1Opz2NwjYHznUYoQ0zWINT5MjgO4wdGva0Yfy/t9se3M8Jo
         YzoQ==
X-Gm-Message-State: APjAAAUjMkC4Va4FKMPIMDtHDayLN1O65gLVhQoe9aZbab/WsFhNSXnF
        Q6/xIjT9+rfUppNL5KHWYgIkow==
X-Google-Smtp-Source: APXvYqyd5ViDsM/ozDX+i5BT0Qs/6fseaDiqhur2F81bUtGwOj65M5uwWd0P+3/cqvLibI+BQjOSDw==
X-Received: by 2002:a1c:700b:: with SMTP id l11mr68339wmc.106.1559828661872;
        Thu, 06 Jun 2019 06:44:21 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id v6sm2252245wru.6.2019.06.06.06.44.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 06:44:21 -0700 (PDT)
Date:   Thu, 6 Jun 2019 15:44:18 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 5.2-rc4
Message-ID: <20190606134418.GB26408@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.2-rc4

Here's one fix for a class of bugs triggered by syzcaller, and one that
makes xfstests fail less.

Thanks,
Miklos

----------------------------------------------------------------
Amir Goldstein (2):
      ovl: support the FS_IOC_FS[SG]ETXATTR ioctls
      ovl: detect overlapping layers

Miklos Szeredi (1):
      ovl: doc: add non-standard corner cases

---
 Documentation/filesystems/overlayfs.txt |  16 ++-
 fs/overlayfs/file.c                     |   9 +-
 fs/overlayfs/inode.c                    |  48 +++++++++
 fs/overlayfs/namei.c                    |   8 ++
 fs/overlayfs/overlayfs.h                |   3 +
 fs/overlayfs/ovl_entry.h                |   6 ++
 fs/overlayfs/super.c                    | 169 ++++++++++++++++++++++++++++----
 fs/overlayfs/util.c                     |  12 +++
 8 files changed, 249 insertions(+), 22 deletions(-)
