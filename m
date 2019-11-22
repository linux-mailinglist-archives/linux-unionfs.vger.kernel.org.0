Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF531068ED
	for <lists+linux-unionfs@lfdr.de>; Fri, 22 Nov 2019 10:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfKVJh3 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 22 Nov 2019 04:37:29 -0500
Received: from mail-yw1-f47.google.com ([209.85.161.47]:34863 "EHLO
        mail-yw1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKVJh3 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 22 Nov 2019 04:37:29 -0500
Received: by mail-yw1-f47.google.com with SMTP id r131so2255296ywh.2
        for <linux-unionfs@vger.kernel.org>; Fri, 22 Nov 2019 01:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=38Ube36fxNXGCUyi48CZ7QFLrU7pdCa/iYRXf9W3GMw=;
        b=DUadi3fEC3L74SwUBV+xbE0iAf3oaJnIsTf1cMvkTxrhPfXsSa8suKbsK+iGal2zpu
         Q7M+Wi+ET2fRsTAuzSAMlOZ1jpaTVmy8mPNO9iMHJcnnBUSoMO+jKUqdeuEqEXm4g8yx
         23eGPmpcHDuQwtAfRbuZCqtYndSsnpoMb8/NkEU+nhRPrartaOnYmPethF1llAQO109B
         KW5c8kMlETN475cG2ni/aRw6uPgO+soGGPVwuk/ZsR2N5Ab6wqu+R8epelNf9V2oLHzV
         0if4v9qlZsBUW4noVV0qqCj+sBERo+5P7LnuzFobtQTHhAhODdCzemACeyrS4AAZyVc1
         8EXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38Ube36fxNXGCUyi48CZ7QFLrU7pdCa/iYRXf9W3GMw=;
        b=hjpVtzK5pY2h26qo9WDo4gwDWXvCx+uWkuj4Yc/KXFq/AWaU+0FoIOHcEO9K4FdZkM
         shMFFihzC3dv9k9ZGDb6m/keV+mgZWtJcMcU45fDbSZxas31wGYhmZngT/6gHIkrtnWy
         LWxPz1BbhDEmpsX6V5dVlhXYznEv2S9xaLuiu6v4L6w7OZpXiM/GQ9lXPHjfTK2YGPBG
         k2Yan8xEt0nRLFRuNtnyqXyQT0tT1MNiXmuLHyQQzACXX8krG7okmI6xo8bYYHnGbjdp
         WZXuufVUaB/Y+7uHcL2Ud/JwAa/TkMvwld/L2eNBValeQekHgS7I6t/4FgcWeZlPWHPj
         2fkQ==
X-Gm-Message-State: APjAAAXmsJqVvLUqKQRG1yJ/U+Ng19/ZEEfDnQafPOC3ayrCwAHjh/TJ
        bpIMqW9Ep2EGR/Qj21BZdaH1xWOSBFyLd91dVhtNAg==
X-Google-Smtp-Source: APXvYqyUJKdNyFQZBBV0aHOGmP8m575XmmYR+Vl3hhFhLht4VdadbExxjhqxuY+FeBFLq5Qvg751oHQJjXcNJFq4Xv8=
X-Received: by 2002:a81:ae07:: with SMTP id m7mr266902ywh.294.1574415448445;
 Fri, 22 Nov 2019 01:37:28 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxjryJep94sLgVxV7sGab8K3yeeDUZwOYOfLtOOguW1pcA@mail.gmail.com>
 <CAOQ4uxiHKjNba8HD5JUWFxxJqyJxPMk3fFfA3fi-nO6uJngTAg@mail.gmail.com>
In-Reply-To: <CAOQ4uxiHKjNba8HD5JUWFxxJqyJxPMk3fFfA3fi-nO6uJngTAg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 22 Nov 2019 11:37:17 +0200
Message-ID: <CAOQ4uxhBBnr5zFOn1Dr-XtDSo=p3BovyhK6xZh22GA=dv1L8Bw@mail.gmail.com>
Subject: [ANNOUNCE] unionmount-testsuite: master branch updated to 1724ef2
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
