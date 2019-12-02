Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 383D810E5F8
	for <lists+linux-unionfs@lfdr.de>; Mon,  2 Dec 2019 07:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfLBGcB (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 2 Dec 2019 01:32:01 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33645 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfLBGcB (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 2 Dec 2019 01:32:01 -0500
Received: by mail-yw1-f67.google.com with SMTP id 192so5400541ywy.0
        for <linux-unionfs@vger.kernel.org>; Sun, 01 Dec 2019 22:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5BdYjIdaxc/KydvwRvVdZXA2xPscX2pQH/5c4JWb5yE=;
        b=d4Fw40FN5rkKZ02ZK5YEbCPnnnxNf0fAR4CXbfxCk8Xy5zhmMyX6Qajb2EEkEFvbqu
         eTIP1uxEyXZM1Wpid3pCdIdieiziDoeqNAyIx9KhMGaBMqhuPDPK0zpbDM81Fj6SF7Fw
         Q2AA0Itnx8EF2gKFlUweKK6VtznPzZKoQmtbeuAUeAGQS5NKyy/rvVS6uU2+/Vps28aR
         QzYuUqnwqEzuNFw4D8jAFXszCnA4bpgA0JRRfRrA4DVO2GkNcxu92mC3hlrHIoT3eown
         sbYFSWVdRkAyDgEsrXNXyuKI4lUnRbcpVZVsNtZ2H4HSXv5Cgd+8Y0DYQyiDBbsMssCS
         PW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5BdYjIdaxc/KydvwRvVdZXA2xPscX2pQH/5c4JWb5yE=;
        b=aBiVnVUKhEKsuOdDMrIm9vfgXd4hK4WP6/ARgcMeLOT33aPCjoJLjtBzN9z83FW978
         YhY832gBJsmjHSBPqc3jdr2nEkX+P6MpjVU0Ivj3qgx7h8HDC4pAJ3o7m1P7Of49j68o
         /Zs06THFoKlihrkGoa2KWvLg8h5E4abgfGZDQtLz/Dka8Ry0AJ3/DczE82LGuFJZx1W+
         yyOZ9xoGAlzkjKWJ+ZBtLQ82dLJwqrzBMZQlHKfn8Yxp7FqKDABK/yZqcYv/b4hkHHXx
         SpWj6t2l6cN4e/CMFzRc0UjmZ5YuK/5AN1/FK3UKTEyuXb+kfiCWzp8Ft/wuAcA0AGtb
         r2kw==
X-Gm-Message-State: APjAAAX2HFHc+FtpH9byE8dsT+AdW0iQzVVWJIkyT/e/7dxqkVCd7z3N
        Dnap9Ry7ChO9/E/SKUjGmrRsQq86Wc/GpbodVkLShvuB
X-Google-Smtp-Source: APXvYqwsh9JbRDNo5s0naE6Tm6MSaqNodP/io4tCuG7Vyucbj4BcWTT1kaKV0b0oPd5l7UZDyxsprMlxS8pZ0A0R14M=
X-Received: by 2002:a81:408:: with SMTP id 8mr19228238ywe.88.1575268320324;
 Sun, 01 Dec 2019 22:32:00 -0800 (PST)
MIME-Version: 1.0
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 2 Dec 2019 08:31:49 +0200
Message-ID: <CAOQ4uxh7fszXGXV0U5K4yz4o3WwDk40LmOi+dH2Nwi+yq_5+Pw@mail.gmail.com>
Subject: Overlayfs fixes queue
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi Miklos,

Will you have time to queue some of the queued fixed [1] and docs .rst
conversion [2] for 5.5, maybe rc2?

The timestamp limits issue is also being addressed by Deepa in vfs as
you suggested, so not critical but nice to have.

I posted an xfstest [3] that demonstrates the corner case of
non-unique st_dev;st_ino (v4.17 regression).

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/ovl-fixes

* f25e33779931 - ovl: fix corner case of non-unique st_dev;st_ino
* c0eb8296e077 - ovl: don't use a temp buf for encoding real fh
* 84d7f2d7d93d - ovl: make sure that real fid is 32bit aligned in memory
* b2d4f0ea5af4 - ovl: fix lookup failure on multi lower squashfs
* e930bd4d5e9d - ovl: fix timestamp limits

[2] https://github.com/amir73il/linux/commits/ovl-docs

* 80efb1bb664f - docs: filesystems: overlayfs: Fix restview warnings
* 28329d8b3cb2 - docs: filesystems: overlayfs: Rename overlayfs.txt to .rst

[3] https://lore.kernel.org/fstests/20191124142957.20873-1-amir73il@gmail.com/
