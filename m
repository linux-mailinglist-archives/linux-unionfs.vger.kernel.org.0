Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE74CBBDF
	for <lists+linux-unionfs@lfdr.de>; Fri,  4 Oct 2019 15:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388321AbfJDNg1 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 4 Oct 2019 09:36:27 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21626 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388244AbfJDNg1 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 4 Oct 2019 09:36:27 -0400
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Oct 2019 09:36:25 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1570195248; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=dmgC1R8P/pDyx8JUvBR6XMsaeZ0SmzLZSO/J0EvOl/NySRLnoZm9xSLoYeK6Ifv6dj3biyseFRQOqlTJodT4rR/tCgNQ5/T65TT0171XYonHf4OmwpMqxBDtsh+th519sz30d3FqG7cKRBONvp0ifd7CRlcIU8+i2pz/awjtgeA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1570195248; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=yCzUkIfe//ibW7atC0MU+OHkZ64NinB+KwQXe7H2h3k=; 
        b=QUAuuNyNu6BoIKUMWjoqBNj3rKcKQ6satgwcPAZWQF8rNsevXLezbPscF2+HpAALolhV9niq0wUUZPJWiR3rkdHGimqE0n37MuogtjyhRbXaIErI3WahQ1SmLl3XmeSqoFK5KXjqdS4HU1XTy4DTh3f2rtxttBdcRvG45BNxLqo=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1570195248;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=2139; bh=yCzUkIfe//ibW7atC0MU+OHkZ64NinB+KwQXe7H2h3k=;
        b=cMKt7DOgxYGTfNMKlvto/F2h/DXgwGGW4QCJSD9L8igzgVVEQSP10PEb+zyfo5MA
        DW4zHRwYhvzkC10LZf+9zfAHLrEDPXwEMqjaFWUQ6QZFFUJv0EXDm1leqlVUCmPh2/m
        ON5LMwUz1tgYGPWxfA1/Fxox42v/w2L7Jpul43sc=
Received: from localhost.localdomain (113.87.91.134 [113.87.91.134]) by mx.zoho.com.cn
        with SMTPS id 157019524446510.220044819845384; Fri, 4 Oct 2019 21:20:44 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu
Cc:     linux-unionfs@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191004132030.28353-1-cgxu519@mykernel.net>
Subject: [PATCH] ovl: improving copy-up efficiency for sparse file
Date:   Fri,  4 Oct 2019 21:20:30 +0800
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Current copy-up is not efficient for sparse file,
It's not only slow but also wasting more disk space
when the target lower file has huge hole inside.
This patch tries to recognize file hole and skip it
during copy-up.

In detail, this optimization checks the hole according
to copy-up chunk size so it may not recognize all kind
of holes in the file. However, it is easy to implement
and will be enough for most of the time.

Additionally, this optimization relies on lseek(2)
SEEK_DATA implementation, so for some specific
filesystems which do not support this feature
will behave as before on copy-up.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/copy_up.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index b801c6353100..028033c9f021 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -144,10 +144,11 @@ static int ovl_copy_up_data(struct path *old, struct =
path *new, loff_t len)
 =09=09goto out;
 =09/* Couldn't clone, so now we try to copy the data */
=20
-=09/* FIXME: copy up sparse files efficiently */
 =09while (len) {
 =09=09size_t this_len =3D OVL_COPY_UP_CHUNK_SIZE;
 =09=09long bytes;
+=09=09loff_t old_next_data_pos;
+=09=09loff_t hole_len;
=20
 =09=09if (len < this_len)
 =09=09=09this_len =3D len;
@@ -157,6 +158,18 @@ static int ovl_copy_up_data(struct path *old, struct p=
ath *new, loff_t len)
 =09=09=09break;
 =09=09}
=20
+=09=09old_next_data_pos =3D vfs_llseek(old_file, old_pos, SEEK_DATA);
+=09=09if (old_next_data_pos >=3D old_pos + OVL_COPY_UP_CHUNK_SIZE) {
+=09=09=09hole_len =3D (old_next_data_pos - old_pos) /
+=09=09=09=09OVL_COPY_UP_CHUNK_SIZE * OVL_COPY_UP_CHUNK_SIZE;
+=09=09=09old_pos +=3D hole_len;
+=09=09=09new_pos +=3D hole_len;
+=09=09=09len -=3D hole_len;
+=09=09=09continue;
+=09=09} else if (old_next_data_pos =3D=3D -ENXIO) {
+=09=09=09break;
+=09=09}
+
 =09=09bytes =3D do_splice_direct(old_file, &old_pos,
 =09=09=09=09=09 new_file, &new_pos,
 =09=09=09=09=09 this_len, SPLICE_F_MOVE);
--=20
2.21.0



