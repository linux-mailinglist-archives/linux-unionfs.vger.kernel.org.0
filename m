Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3B7E49F2
	for <lists+linux-unionfs@lfdr.de>; Fri, 25 Oct 2019 13:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439564AbfJYL3c (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 25 Oct 2019 07:29:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58145 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2439401AbfJYL3a (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 25 Oct 2019 07:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572002969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9uL6B8L1AUAy/UiZQvA9Cim16okzyI5YnHL1NCMV9QY=;
        b=MVwSFMFBiQryw3Z1Q52hwQvlMQqLjJMdz3jY/QJxtjjwBFfJ0cpUSpuvPr/y5f0eT6AI/P
        sI9UWAUwfBfGMo8g7pFvyq5gVwI1Kz7gOs91tfaeoxV2IylfOi5xTcJlW1YvmzABaqSVZe
        JdBdIzUYBElMvHetz5wEN+//3DbKjmo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-kcDicyJpOf6gbZ1-9GwI8w-1; Fri, 25 Oct 2019 07:29:26 -0400
Received: by mail-wr1-f72.google.com with SMTP id r8so924568wrx.8
        for <linux-unionfs@vger.kernel.org>; Fri, 25 Oct 2019 04:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1a/jvPs2SyoieuY5sUx5bSduqfiYAGGvkqIa6LCkCRY=;
        b=jkWgqGZrCWTXe4LWOCExIgcKF8qjI76Jn9ZOpVZElI4AVZiiIX7h0TiqSnRSaOFfjq
         N+z/66wMrdvjkdr/2rABr2z3EOOZDznOyYjJO1ibHVS9MYrtVh+7ovH4wLWHb2k6a1sa
         Y66FPq7BmDUqHSS5pj5tzGTePRg5/fFO6dx3rHNSWJAfxgMVX4hVRgiuTBlUX+mqN1YJ
         /WqzmTLYu2inoTSgeXnxTGnnxUC0mYUSaZ+1cN/oA3/mchZWu7NkWDePTH/oLQz7c665
         /EgXqzh2jNPM4lfrFHJFoporpKrdAXX9qgkPiiV39YJjlXPNPGafHAscRwAUfUDPbp2G
         ocSw==
X-Gm-Message-State: APjAAAU1gr26uWbpfymco3+WurK06s2/1jT/7t0kfYHXTZMq9LkHa7vy
        7aLTww5yMZFV0szFpO/tOBSYdItsOs75TQaeBaBZd49leFVPljqVAVllvn+eJlnGvwayeYw35/+
        NDo1Vh+NfDS8qu7Xir6+EfzaBIw==
X-Received: by 2002:adf:e7cf:: with SMTP id e15mr2518271wrn.303.1572002965918;
        Fri, 25 Oct 2019 04:29:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwvfPJJ2c/wmZStZlRDQhI1hTNTMWyooEQFpsvxbtMEd+kN4kjZa+gDkGbcqMbI/WXcN+LFaw==
X-Received: by 2002:adf:e7cf:: with SMTP id e15mr2518261wrn.303.1572002965778;
        Fri, 25 Oct 2019 04:29:25 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (185-79-95-246.pool.digikabel.hu. [185.79.95.246])
        by smtp.gmail.com with ESMTPSA id l18sm3974080wrn.48.2019.10.25.04.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 04:29:25 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/5] ovl: unprivieged mounts
Date:   Fri, 25 Oct 2019 13:29:17 +0200
Message-Id: <20191025112917.22518-6-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025112917.22518-1-mszeredi@redhat.com>
References: <20191025112917.22518-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: kcDicyJpOf6gbZ1-9GwI8w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Enable unprivileged user namespace mounts of overlayfs.  Overlayfs's
permission model (*) ensures that the mounter itself cannot gain additional
privileges by the act of creating an overlayfs mount.

This feature request is coming from the "rootless" container crowd.

(*) Documentation/filesystems/overlayfs.txt#Permission model

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index d122c07f2a43..c7f21a049c6b 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1739,6 +1739,7 @@ static struct dentry *ovl_mount(struct file_system_ty=
pe *fs_type, int flags,
 static struct file_system_type ovl_fs_type =3D {
 =09.owner=09=09=3D THIS_MODULE,
 =09.name=09=09=3D "overlay",
+=09.fs_flags=09=3D FS_USERNS_MOUNT,
 =09.mount=09=09=3D ovl_mount,
 =09.kill_sb=09=3D kill_anon_super,
 };
--=20
2.21.0

