Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A865FFA8B
	for <lists+linux-unionfs@lfdr.de>; Sun, 17 Nov 2019 16:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfKQPoB (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 17 Nov 2019 10:44:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38973 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfKQPoB (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 17 Nov 2019 10:44:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id l7so16524995wrp.6
        for <linux-unionfs@vger.kernel.org>; Sun, 17 Nov 2019 07:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=k+p3t3zs596LQLhrVhSA+oel+AwBE1REXL4+Z6RqPGo=;
        b=kBpEWZNFuOLCdc2+4qIOMT9pFzCPnjC2xjeUsMh9/H5C67mrrzrENI3pTKYvYcUkDX
         BVrxmLR7nxU0utsg2kOSAjr82/c2kZPunC5KMppGz7J4ahHMhpCT/MC5JnIZwxlpkTGv
         FO16dq5iQNkuvKH+TnONW8RmS42WWIcHlYGGYdf+H2YKIp1ESH335t7OrXiBMpMjyZpg
         /9gBiwCM6XTG7QdtbeCJvYYnMCvzYFUOv6eRJNK/kc1BhKrFItcmyimNBxT9JTU3t27b
         VjD3bEOmCu3J9BWwem1QRjOlvQVxWuobxF2jOFjlq6NXvOEulQCCi/G+QmnYEvBEPmWq
         2hdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k+p3t3zs596LQLhrVhSA+oel+AwBE1REXL4+Z6RqPGo=;
        b=TMdRj5/4KwFopCCylmCVJOuvdlKDQNY+4gSVwdQiZkJA7XlALHp6u/t3SvCYxZRaTY
         fqjYotP+eIO2aFhK3u5AAB4kkALmHKjYaUw2fGKi7d2Cf3TbK+z7hcR/ZLo3oK1P6k7O
         gSoxJVhxUXlPAudypu8cbug8GpPY2r8efB5UcTM/1B22+BNeXj26EFK+Po4gXl5GLYod
         ppanASyYDCwnkcZnbhY+3Kjpm9LCEifVSylmRY19SpB5zD/hTH2VupbpJVk1harZhysf
         rg3hBCZqiviCutsDodS75a7gQe6qVyjYPFYk7mdiNavjXOJTYPF0L9ZHnx9Q10OF1b8T
         fWcg==
X-Gm-Message-State: APjAAAUvTCRdLmCqmFyjZotGM8A8pPCh8deyr+Gk4frt9bBY0wgOnmDX
        +FQUstVXXt0R4yIg8q9tRN0=
X-Google-Smtp-Source: APXvYqx4dEKCFB06aUcPDQoyqXDcCvVAeB1mgEhVP4rTexvi38LCVVkItUF7ZnDjEBLl81oP2sS46g==
X-Received: by 2002:a5d:6351:: with SMTP id b17mr9769611wrw.126.1574005438316;
        Sun, 17 Nov 2019 07:43:58 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id z8sm19061613wrp.49.2019.11.17.07.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 07:43:57 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Colin Ian King <colin.king@canonical.com>,
        linux-unionfs@vger.kernel.org
Subject: [PATCH 0/6] Sort out overlay layers and fs arrays
Date:   Sun, 17 Nov 2019 17:43:43 +0200
Message-Id: <20191117154349.28695-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Miklos,

When I started generalizing the lower_layers/lower_fs arrays
I noticed a bug that was introduced in v4.17 with xino.

In the case of lower layer on upper fs, we do not have a pseudo_dev
assigned to lower layer and we expose the real lower st_dev;st_ino.
This happens on non-samefs when xino is disabled (default).
This is a very real bug, not really a corner case and I have an
an xfstest [1] for it that I will post later.

In the mean while, I also pushed a fix to unionmount-testsuite devel
branch [2] to demonstrate the issue.

With upstream kernel, this test ends up with a copied up file
from middle layer, whose on same fs as upper and its exposed
st_dev;st_ino are invalid:

 ./run --ov=1 --verify hard-link
 ...
 /mnt/a/no_foo110: File unexpectedly on upper layer

Patch 1 in the series is a small fix for stable that fixes the
v4.17 regression in favor of a different, less severe regression.
The new regression can be demonstrated with:

 ./run --ov=1 --verify --xino hard-link
 ...
 /mnt/a/no_foo110: inode number/layer changed on copy up
 (got 39:24707, was 39:24700)

Patches 2-4 generalize the lower_{layer/fs} arrays to layer/fs arrays
and get rid of some special casing of upper layer.

Patches 5-6 use the cleanup to solve the corner case that you pointed
out with bas_uuid [3] and to fix the regression introduced by patch 1.

After patch 6, both unionmount-testsuite configurations
above pass the test st_dev;st_ino verifications.

I doubt if patches 2-6 are stable material, because not sure the
corner cases they fix are worth the trouble.

The series depends on the bad_uuid patch v5 that I posted on Thursday.

I was also considering setting xino=on by default if xino_auto
is enabled, because what have we got to loose?

The inodes whose st_ino fit in lower bits (by far more common) will
use overlay st_dev and the inodes whose st_ino overflow the lower bits
will use pseudo_dev. Seems like a win-win situation, but I wanted to
get your feedback on this before sending out a patch.

Thanks,
Amir.

[1] https://github.com/amir73il/xfstests/commit/c667f26839ae487c509b95abae670fdca1c535c8
[2] https://github.com/amir73il/unionmount-testsuite/commit/1724ef2245c5e56f73e436b37407d00ef498f9bc
[3] https://lore.kernel.org/lkml/CAJfpegufS=OGcvFbWEVumNSCPO_JXyEuJNAbmO5ubscSarVtRQ@mail.gmail.com/

Amir Goldstein (6):
  ovl: fix corner case of non-unique st_dev;st_ino
  ovl: generalize the lower_layers[] array
  ovl: simplify ovl_same_sb() helper
  ovl: generalize the lower_fs[] array
  ovl: fix corner case of conflicting lower layer uuid
  ovl: fix corner case of non-constant st_dev;st_ino

 fs/overlayfs/export.c    |   6 +-
 fs/overlayfs/inode.c     |  35 +++++------
 fs/overlayfs/namei.c     |  10 ++--
 fs/overlayfs/overlayfs.h |  23 ++++++-
 fs/overlayfs/ovl_entry.h |  14 +++--
 fs/overlayfs/readdir.c   |  11 ++--
 fs/overlayfs/super.c     | 125 ++++++++++++++++++++++-----------------
 fs/overlayfs/util.c      |  18 ++----
 8 files changed, 132 insertions(+), 110 deletions(-)

-- 
2.17.1

