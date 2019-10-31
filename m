Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9808EADCE
	for <lists+linux-unionfs@lfdr.de>; Thu, 31 Oct 2019 11:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfJaKr4 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 31 Oct 2019 06:47:56 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21470 "EHLO
        sender2.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726952AbfJaKr4 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 31 Oct 2019 06:47:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572518855; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=ZTJaUMtwpHaAqsZpLZrePM1KyAd/Vx1N8MpAo+OCUfbGZMGY15Kgb9P+SV4887OTvB0ZSiX9vTVrJGtHQUviF39w8PcvOD4MyeKSG9B3X9dUIplTrIjvaPbAq3AjGiINLq3gACePnWDdMfJmQqCC31sq0ZI/wf13wK1HWdfQXSE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1572518855; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=ehKvJdg4fB+sIFnVkAfw/ZvwwmF2VvVqS2dq06ejRNA=; 
        b=KTg7MW4T78/HEnmHFevv9QQLQ49/LUSWYYvB534NsEyCf1Q1JuZDLD8YteZmxFD+qrv6k9twnbE+wSNwE8wUpNinHyFVB7vxtegm+FJF65+XuiwJHzKI0BKxrgQmE6+ClQ8piGGwmQ+lr83MDSkcHwqSfHdZ9qau+pqcrNAKAd4=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1572518855;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=4197; bh=ehKvJdg4fB+sIFnVkAfw/ZvwwmF2VvVqS2dq06ejRNA=;
        b=PpcSLhN+G933BQBip5SJDI8k7cIBcNZwnPya6zsM9CZEOAni3inBaFO7fQ8015Lu
        HZPZPe/HadcS9ujeWg3migaRNYcIYmF6lnCZwCDD1OsjwfmkZ56HWRW+kwFXCgjr6Al
        zAcGKX7q5tPPhsAUkd5WRCETH0y27mS6CfW7Y9jE=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1572518852745978.5319925854856; Thu, 31 Oct 2019 18:47:32 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191031104649.7177-1-cgxu519@mykernel.net>
Subject: [PATCH v3] ovl: improving copy-up efficiency for big sparse file
Date:   Thu, 31 Oct 2019 18:46:49 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Current copy-up is not efficient for big sparse file,
It's not only slow but also wasting more disk space
when the target lower file has huge hole inside.
This patch tries to recognize file hole and skip it
during copy-up.

Detail logic of hole detection as below:
When we detect next data position is larger than current
position we will skip that hole, otherwise we copy
data in the size of OVL_COPY_UP_CHUNK_SIZE. Actually,
it may not recognize all kind of holes and sometimes
only skips partial of hole area. However, it will be
enough for most of the use cases.

Additionally, this optimization relies on lseek(2)
SEEK_DATA implementation, so for some specific
filesystems which do not support this feature
will behave as before on copy-up.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
v1->v2:
- Set file size when the hole is in the end of the file.
- Add a code comment for hole copy-up improvement.
- Check SEEK_DATA support before doing hole skip.
- Back to original copy-up when seek data fails(in error case).

v2->v3:
- Detect big continuous holes in an effective way.
- Modify changelog and code comment.
- Set file size in the end of ovl_copy_up_inode().

 fs/overlayfs/copy_up.c | 43 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index b801c6353100..10a2ae452393 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -123,6 +123,9 @@ static int ovl_copy_up_data(struct path *old, struct pa=
th *new, loff_t len)
 =09loff_t old_pos =3D 0;
 =09loff_t new_pos =3D 0;
 =09loff_t cloned;
+=09loff_t old_next_data_pos;
+=09loff_t hole_len;
+=09bool skip_hole =3D false;
 =09int error =3D 0;
=20
 =09if (len =3D=3D 0)
@@ -144,7 +147,11 @@ static int ovl_copy_up_data(struct path *old, struct p=
ath *new, loff_t len)
 =09=09goto out;
 =09/* Couldn't clone, so now we try to copy the data */
=20
-=09/* FIXME: copy up sparse files efficiently */
+=09/* Check if lower fs supports seek operation */
+=09if (old_file->f_mode & FMODE_LSEEK &&
+=09    old_file->f_op->llseek)
+=09=09skip_hole =3D true;
+
 =09while (len) {
 =09=09size_t this_len =3D OVL_COPY_UP_CHUNK_SIZE;
 =09=09long bytes;
@@ -157,6 +164,38 @@ static int ovl_copy_up_data(struct path *old, struct p=
ath *new, loff_t len)
 =09=09=09break;
 =09=09}
=20
+=09=09/*
+=09=09 * Fill zero for hole will cost unnecessary disk space
+=09=09 * and meanwhile slow down the copy-up speed, so we do
+=09=09 * an optimization for hole during copy-up, it relies
+=09=09 * on SEEK_DATA implementation in lower fs so if lower
+=09=09 * fs does not support it, copy-up will behave as before.
+=09=09 *
+=09=09 * Detail logic of hole detection as below:
+=09=09 * When we detect next data position is larger than current
+=09=09 * position we will skip that hole, otherwise we copy
+=09=09 * data in the size of OVL_COPY_UP_CHUNK_SIZE. Actually,
+=09=09 * it may not recognize all kind of holes and sometimes
+=09=09 * only skips partial of hole area. However, it will be
+=09=09 * enough for most of the use cases.
+=09=09 */
+
+=09=09if (skip_hole) {
+=09=09=09old_next_data_pos =3D vfs_llseek(old_file,
+=09=09=09=09=09=09old_pos, SEEK_DATA);
+=09=09=09if (old_next_data_pos > old_pos) {
+=09=09=09=09hole_len =3D old_next_data_pos - old_pos;
+=09=09=09=09old_pos +=3D hole_len;
+=09=09=09=09new_pos +=3D hole_len;
+=09=09=09=09len -=3D hole_len;
+=09=09=09=09continue;
+=09=09=09} else if (old_next_data_pos =3D=3D -ENXIO) {
+=09=09=09=09break;
+=09=09=09} else if (old_next_data_pos < 0) {
+=09=09=09=09skip_hole =3D false;
+=09=09=09}
+=09=09}
+
 =09=09bytes =3D do_splice_direct(old_file, &old_pos,
 =09=09=09=09=09 new_file, &new_pos,
 =09=09=09=09=09 this_len, SPLICE_F_MOVE);
@@ -483,7 +522,7 @@ static int ovl_copy_up_inode(struct ovl_copy_up_ctx *c,=
 struct dentry *temp)
 =09}
=20
 =09inode_lock(temp->d_inode);
-=09if (c->metacopy)
+=09if (S_ISREG(c->stat.mode))
 =09=09err =3D ovl_set_size(temp, &c->stat);
 =09if (!err)
 =09=09err =3D ovl_set_attr(temp, &c->stat);
--=20
2.20.1



