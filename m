Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7C6E49ED
	for <lists+linux-unionfs@lfdr.de>; Fri, 25 Oct 2019 13:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439419AbfJYL31 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 25 Oct 2019 07:29:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27919 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439401AbfJYL31 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 25 Oct 2019 07:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572002966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I33B+0F6drNe2DO1ImWZrj95FAKHCL4hyPcaly3kasA=;
        b=b8VHg1ryI+Yi5V+XJ/f/2353saJosSQ2++XK0HvKBa5vcyh2VAMphLr1IqTRs3xb2HSJyC
        lx/aplvQZafb0mjejcsaaHHTNKI7LZhLylDjw1LvsgIa53PpODaA2ve7OLnZeD3v0orc9J
        Y7sQOQoNTAjZqbHJ92ewxBnXo0avUqw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-sGS_9NELO7irac0imQLKIw-1; Fri, 25 Oct 2019 07:29:23 -0400
Received: by mail-wr1-f69.google.com with SMTP id e25so930390wra.9
        for <linux-unionfs@vger.kernel.org>; Fri, 25 Oct 2019 04:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d8l72uHGzG6m6K3/bpmVJ/Qpjsjtmq+Lqod9QQYQlTc=;
        b=e4Iw7u2vZsjizScoRBKRdS7yOYRo36Tr8nzXInxKF9GH+FzOhRAJeElyCHTCBrCbJU
         sBSOeXCEAGOdYYd93+1zQ9ZoiuwbdRDAPjjIlhk0cR4Hw3NAGkTkQzuCObm9WVU6Q98j
         INvZu0A41mtJ9W1EGdRtlSVhIXa29irhE3gpxY47m/VxLpE3+wUBo1mbXCuP4nChFqQ7
         PG2ssoLsZy5cl6rJEnXAG9rYcPZZ3vTDqdQcB4KQLwW3bhg1c3+hAFmRHe+JCChZNmKA
         hNRdqrnoSFWO8yKf87EhXp6BHH2Ab8NET83Tu79qOONYRPkAxJZ/SZ28pgv02lFdEA0n
         E4Bw==
X-Gm-Message-State: APjAAAUbNNO8qwBkPgopYOPcLNDpNbit668+YqEsP3M6lan+uThufkKa
        bOqijLTbLarWGmkyVfO1YrUZqk+cwBAruMaUhrspXsrOXNlFhrrhw8S4Wqon58yZHoufk1f9Lil
        GXGq7dGqfiabkTxhcZ+iVRwzfLw==
X-Received: by 2002:a5d:6b0e:: with SMTP id v14mr2525704wrw.280.1572002961875;
        Fri, 25 Oct 2019 04:29:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxPpQGXTNJrxLkgVezHj1T1jGuquL8GQd5mEOwUp11MWfS05ZJe9b8tNYouTGJhnrGVK8HvrQ==
X-Received: by 2002:a5d:6b0e:: with SMTP id v14mr2525688wrw.280.1572002961667;
        Fri, 25 Oct 2019 04:29:21 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (185-79-95-246.pool.digikabel.hu. [185.79.95.246])
        by smtp.gmail.com with ESMTPSA id l18sm3974080wrn.48.2019.10.25.04.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 04:29:20 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/5] ovl: document permission model
Date:   Fri, 25 Oct 2019 13:29:13 +0200
Message-Id: <20191025112917.22518-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025112917.22518-1-mszeredi@redhat.com>
References: <20191025112917.22518-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: sGS_9NELO7irac0imQLKIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Add missing piece of documentation regarding how permissions are checked in
overlayfs.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 Documentation/filesystems/overlayfs.txt | 44 +++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/filesystems/overlayfs.txt b/Documentation/filesy=
stems/overlayfs.txt
index 845d689e0fd7..674fc8b1e420 100644
--- a/Documentation/filesystems/overlayfs.txt
+++ b/Documentation/filesystems/overlayfs.txt
@@ -246,6 +246,50 @@ overlay filesystem (though an operation on the name of=
 the file such as
 rename or unlink will of course be noticed and handled).
=20
=20
+Permission model
+----------------
+
+Permission checking in the overlay filesystem follows these principles:
+
+ 1) permission check SHOULD return the same result before and after copy u=
p
+
+ 2) task creating the overlay mount MUST NOT gain additional privileges
+
+ 3) non-mounting task MAY gain additional privileges through the overlay,
+ compared to direct access on underlying lower or upper filesystems
+
+This is achieved by performing two permission checks on each access
+
+ a) check if current task is allowed access based on local DAC (owner,
+    group, mode and posix acl), as well as MAC checks
+
+ b) check if mounting task would be allowed real operation on lower or
+    upper layer based on underlying filesystem permissions, again includin=
g
+    MAC checks
+
+Check (a) ensures consistency (1) since owner, group, mode and posix acls
+are copied up.  On the other hand it can result in server enforced
+permissions (used by NFS, for example) being ignored (3).
+
+Check (b) ensures that no task gains permissions to underlying layers that
+the mounting task does not have (2).  This also means that it is possible
+to create setups where the consistency rule (1) does not hold; normally,
+however, the mounting task will have sufficient privileges to perform all
+operations.
+
+Another way to demonstrate this model is drawing parallels between
+
+  mount -t overlay overlay -olowerdir=3D/lower,upperdir=3D/upper,... /merg=
ed
+
+and
+
+  cp -a /lower /upper
+  mount --bind /upper /merged
+
+The resulting access permissions should be the same.  The difference is in
+the time of copy (on-demand vs. up-front).
+
+
 Multiple lower layers
 ---------------------
=20
--=20
2.21.0

