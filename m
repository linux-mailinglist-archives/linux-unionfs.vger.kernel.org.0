Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFC2673B2A
	for <lists+linux-unionfs@lfdr.de>; Wed, 24 Jul 2019 21:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391917AbfGXT52 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 24 Jul 2019 15:57:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45604 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391976AbfGXT52 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 24 Jul 2019 15:57:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so21452797pfq.12
        for <linux-unionfs@vger.kernel.org>; Wed, 24 Jul 2019 12:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3hIqVIsW0Jzv3qlJGiJ8fmrkQndrI1bOT+U/YKeP91w=;
        b=G5AjQYftTGGOfdkJsIj3NaLgEDUlZP91m+rouc5jJaPeUxm49PKwX+kPqwAa2V7AnB
         2eqvQ+C2gczG8vr1SCtVrY3GUttlIvDAlx8ABZeFpls9ipL1G7U6PIwaJPjKNAV7kpmo
         6jgCzp0OAnxEEm47X0bE/HyhjPo9UxQCuWVvm5eUgAJhqJm+DieWs6iS8XZdj98C4w8g
         pyFf2gGtyDUzJozXaLHY18a9NtYkX/WqgTkYm6lyaBr5jHE0etxoYdBgamdu3iqzekt7
         Pz18kON/KoDzsy9GlupQqjI9N13kcAZtWCbaE9YkAgRg1E7P1/e2tdstcOvngir6qOV/
         NN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3hIqVIsW0Jzv3qlJGiJ8fmrkQndrI1bOT+U/YKeP91w=;
        b=RCrUGwLYg2ioHB8PitaPQJZ+6SI7TFlgv/QYO4gcQVh4mjc1FIGTUBL6UjpivDnvSX
         ZPOYafhb5KIYMhDrtJJGQd84U0qaeoO6t50jRT/tQvryxH1ILZBkJK7DP0NsVwDUcTCx
         fb8h/7a1iJkGbqx2vnkP4Flr9mhOQt9TgDAbT5wUJgqAp6lIx0t8+Z9vPXQW+c6tGkIP
         o/rK+nfag+6iDLfT9ukQmjtJDWSh4BCxajC5PMq6sFi6O5obPZMvszHPoEE0/bHXB7RM
         rbi3IOPz2E2DlR9ZPdJwovlXjyfZLeBQhJa6uxTv2hrtIgfD5mYzYEIMjgIDvEKD5cGf
         5ABQ==
X-Gm-Message-State: APjAAAWdSlvWvNjLq3NLYbYh1VvLrOFMw7q3sODATl0AaFwEtjanSl9C
        HNFPREwqvEgg5Z3gki3WdMTKHOpR
X-Google-Smtp-Source: APXvYqzZWQoYs7Fqyx9XIWGApgxx0jM5sfYBQXgu4zGqe1/h6VS9ZqeEJKn7ZZDuvPulVlMjtuT2zA==
X-Received: by 2002:a63:b64:: with SMTP id a36mr73284058pgl.215.1563998247307;
        Wed, 24 Jul 2019 12:57:27 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.gmail.com with ESMTPSA id f88sm46307394pjg.5.2019.07.24.12.57.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 12:57:26 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v10 0/2] overlayfs override_creds=off
Date:   Wed, 24 Jul 2019 12:57:11 -0700
Message-Id: <20190724195719.218307-1-salyzyn@android.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Patch series:

overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh
Add optional __get xattr method paired to __vfs_getxattr
overlayfs: add __get xattr method
overlayfs: internal getxattr operations without sepolicy checking
overlayfs: override_creds=off option bypass creator_cred

The first four patches address fundamental security issues that should
be solved regardless of the override_creds=off feature.

The fifth that adds the feature depends on these other fixes.

By default, all access to the upper, lower and work directories is the
recorded mounter's MAC and DAC credentials.  The incoming accesses are
checked against the caller's credentials.

If the principles of least privilege are applied for sepolicy, the
mounter's credentials might not overlap the credentials of the caller's
when accessing the overlayfs filesystem.  For example, a file that a
lower DAC privileged caller can execute, is MAC denied to the
generally higher DAC privileged mounter, to prevent an attack vector.

We add the option to turn off override_creds in the mount options; all
subsequent operations after mount on the filesystem will be only the
caller's credentials.  The module boolean parameter and mount option
override_creds is also added as a presence check for this "feature",
existence of /sys/module/overlay/parameters/overlay_creds

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-unionfs@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
v10:
- Rebase
- Return NULL on CAP_DAC_READ_SEARCH
- Add __get xattr method to solve sepolicy logging issue
- Drop unnecassary sys_admin sepolicy checking for administrative
  driver internal xattr functions.

v6:
- Drop CONFIG_OVERLAY_FS_OVERRIDE_CREDS.
- Do better with the documentation, drop rationalizations.
- pr_warn message adjusted to report consequences.

v5:
- beefed up the caveats in the Documentation
- Is dependent on
  "overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh"
  "overlayfs: check CAP_MKNOD before issuing vfs_whiteout"
- Added prwarn when override_creds=off

v4:
- spelling and grammar errors in text

v3:
- Change name from caller_credentials / creator_credentials to the
  boolean override_creds.
- Changed from creator to mounter credentials.
- Updated and fortified the documentation.
- Added CONFIG_OVERLAY_FS_OVERRIDE_CREDS

v2:
- Forward port changed attr to stat, resulting in a build error.
- altered commit message.
