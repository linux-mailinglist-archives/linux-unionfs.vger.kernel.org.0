Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 239BCE49EE
	for <lists+linux-unionfs@lfdr.de>; Fri, 25 Oct 2019 13:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439402AbfJYL31 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 25 Oct 2019 07:29:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33749 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2439212AbfJYL31 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 25 Oct 2019 07:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572002965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uWR0FeiNl3309mlO6E0ZvUU8kwY1OBQz216A0AG4Xw4=;
        b=euFSA05CFfQyqCAil6I7w+3kNQl+pDCFe5Jqv2lQGxWblaRHZxQV3e1fvxd5PLKmq2Gp9R
        tynOoBUzAJRopYSXCSGmToy9+YLPtjn+3wNYx5XYJn2qY9KhFP92o+Q0gWzL43JNf24Z0K
        fDaSgYfmKfYrAXq1f7EVC3Ibs+/Bk50=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-Q8e9cDvrP56daTcHyZLl5A-1; Fri, 25 Oct 2019 07:29:24 -0400
Received: by mail-wr1-f69.google.com with SMTP id 92so929106wro.14
        for <linux-unionfs@vger.kernel.org>; Fri, 25 Oct 2019 04:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECMzKToI8lUs7uXqHIyGRHyiocaJAiDHNlfvJlo41SA=;
        b=GY5/RNLg9OT8uKQusy8o2CGEf9ZxLc2tYBXLZeh2xoQjw9r+BKNdYInv2KxL1QA43B
         v4DJ2fCezI9h2MNRrrxls3TyU2vjT2Johmqff4u6Vu2W254oS7dPCbx5GSaijCOSfayf
         HW/RqnaBaDwxnusZl5dXb6ad2hJpWrmBD8uZ2livPYNo8LtGFClZF4dkn80TD+KiQRtn
         LT6qGeY/RLL4ygmHt/OAC5CtVIyK/SmaLqg65YwBJNsdIDJL8YjzEtd068GeljSPn+ss
         hqPjT24CLMxsOqd0hggVJ+pmSHO65xzSwaIOJPpX+sb+L95ogJ1E5HZs7KwP+RuTgUqX
         du1g==
X-Gm-Message-State: APjAAAXz+u93kG+0w8axPqo3nz+tmj0CB1yMGR+ekODzHEukc08ZxDEk
        pc0SnBylb7xclxFMc2uIfx/+R7dqoSqFs72MXJpqmNMcI6xJnyvqrWfL47WMuChZTUIuSmKck0I
        UqkuG8JJz+SuGflsNbvlSDJ1bSw==
X-Received: by 2002:a5d:4945:: with SMTP id r5mr2503169wrs.37.1572002962863;
        Fri, 25 Oct 2019 04:29:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxxZN9Mnc+StD4TaIv7j6jidJ6uc4Izr0imiWOZEmOA/aRp1o/R0zlvUyoK2S2AsyuHVsjk0Q==
X-Received: by 2002:a5d:4945:: with SMTP id r5mr2503154wrs.37.1572002962677;
        Fri, 25 Oct 2019 04:29:22 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (185-79-95-246.pool.digikabel.hu. [185.79.95.246])
        by smtp.gmail.com with ESMTPSA id l18sm3974080wrn.48.2019.10.25.04.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 04:29:22 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/5] ovl: ignore failure to copy up unknown xattrs
Date:   Fri, 25 Oct 2019 13:29:14 +0200
Message-Id: <20191025112917.22518-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025112917.22518-1-mszeredi@redhat.com>
References: <20191025112917.22518-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: Q8e9cDvrP56daTcHyZLl5A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

This issue came up with NFSv4 as the lower layer, which generates
"system.nfs4_acl" xattrs (even for plain old unix permissions).  Prior to
this patch this prevented copy-up from succeeding.

The overlayfs permission model mandates that permissions are checked
locally for the task and remotely for the mounter(*).  NFS4 ACLs are not
supported by the Linux kernel currently, hence they cannot be enforced
locally.  Which means it is indifferent whether this attribute is copied or
not.

Generalize this to any xattr that is not used in access checking (i.e. it's
not a POSIX ACL and not in the "security." namespace).

Incidentally, best effort copying of xattrs seems to also be the behavior
of "cp -a", which is what overlayfs tries to mimic.

(*) Documentation/filesystems/overlayfs.txt#Permission model

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/copy_up.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index b801c6353100..ed6e2d6cf7a1 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -36,6 +36,13 @@ static int ovl_ccup_get(char *buf, const struct kernel_p=
aram *param)
 module_param_call(check_copy_up, ovl_ccup_set, ovl_ccup_get, NULL, 0644);
 MODULE_PARM_DESC(check_copy_up, "Obsolete; does nothing");
=20
+static bool ovl_must_copy_xattr(const char *name)
+{
+=09return !strcmp(name, XATTR_POSIX_ACL_ACCESS) ||
+=09       !strcmp(name, XATTR_POSIX_ACL_DEFAULT) ||
+=09       !strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN)=
;
+}
+
 int ovl_copy_xattr(struct dentry *old, struct dentry *new)
 {
 =09ssize_t list_size, size, value_size =3D 0;
@@ -107,8 +114,13 @@ int ovl_copy_xattr(struct dentry *old, struct dentry *=
new)
 =09=09=09continue; /* Discard */
 =09=09}
 =09=09error =3D vfs_setxattr(new, name, value, size, 0);
-=09=09if (error)
-=09=09=09break;
+=09=09if (error) {
+=09=09=09if (error !=3D -EOPNOTSUPP || ovl_must_copy_xattr(name))
+=09=09=09=09break;
+
+=09=09=09/* Ignore failure to copy unknown xattrs */
+=09=09=09error =3D 0;
+=09=09}
 =09}
 =09kfree(value);
 out:
--=20
2.21.0

