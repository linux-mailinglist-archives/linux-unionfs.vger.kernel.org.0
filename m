Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31B1F12DFD7
	for <lists+linux-unionfs@lfdr.de>; Wed,  1 Jan 2020 18:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgAAR60 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 1 Jan 2020 12:58:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40946 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbgAAR60 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 1 Jan 2020 12:58:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so37376099wrn.7
        for <linux-unionfs@vger.kernel.org>; Wed, 01 Jan 2020 09:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FgG8pj4Ji2fJ2MP9mQAbToLjvi7AYkar8GfSw9VdPBE=;
        b=ma8FnUrQvzhTUYj/uBlV68dNdET0JwMlA1Ymggs8s8M7Pb0pvRrcuOqgrPTx09BYVh
         kHv+aJbb5CeQnb+IquVYBIJ65JJFGxSbGPCxbEu5ZzR9/GzmphLDG/eUK/Bv8M0NFhW7
         KoUPRA1LP4GTSftbbzsURrJEvkzmZaOOj91cOV0FxttZNY8eTvvds5mWw+d3PoB8evxu
         Uo0O6XfPqCzS7XrPQNVIIj1A1y+MtA/VQT9wZ5MZBI59/eJ6eq4wvopFc0fBSSslg7d2
         lRuWFluDGcG+jspSqCQp/lf31Kqsf+hhaWE9RuPJ55FgKnW5WulpKxzowfcCXPAqhXxs
         u5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FgG8pj4Ji2fJ2MP9mQAbToLjvi7AYkar8GfSw9VdPBE=;
        b=Zg+j7F9QcAJr5OC7zSbBw/8rujehfT49HIZeVk9gtB5MfXYI0CK1fyyChM9oVQFwxV
         rJFgL0yCzQXggisavwBzr+h3Bo4kfk9b8l9qZi4s0vZ6G00fC+uiI2fKuyQ/R479u/oF
         hps+3seZTfYUXISTk7y2J3bLH/mtJFDl5HKdmAgg/6m9XsEX5+4dsmSxuiS/CPfP5/We
         +EesN8k4931DTyztCb9OlgrgYixcC839jv4diBymCoygfgVKeptp3rvQAj9SKkNKamqB
         x2oKAT6hZoSqCn53ZPj4G7FXBkPuq5X0TPa6dpj81yEb9CrLhGPCT7hyBr+XK6pff8q3
         XNSg==
X-Gm-Message-State: APjAAAW6IbbqrbVL0hxoVCaCUIblJv/4gTXXAcIa31c4z4K5P1t7MTHk
        VZAkO9c/LrnFJI7vl1isP9rAmV5l
X-Google-Smtp-Source: APXvYqwRaUH/86q3E2a7udwS+IakwsYI8b4CkCVQD8sDnDxK4iil1yk88HHxXJb1zEdoOXTGoPO9TQ==
X-Received: by 2002:a5d:5345:: with SMTP id t5mr81617665wrv.0.1577901504009;
        Wed, 01 Jan 2020 09:58:24 -0800 (PST)
Received: from localhost.localdomain ([141.226.169.66])
        by smtp.gmail.com with ESMTPSA id z3sm53274778wrs.94.2020.01.01.09.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 09:58:23 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org
Subject: [PATCH 0/7] Sort out overlay ino numbers
Date:   Wed,  1 Jan 2020 19:58:07 +0200
Message-Id: <20200101175814.14144-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Miklos,

Most of this series is sorting out internal overlayfs messy code
having to do with i_ino.

The value of i_ino was very inconsistent in different setups, so this
series also sorts this out and adds documentation of expected values
for st_ino/d_ino/i_ino in different setups.

Patch #5 fixes a potential inode number collision bug (st_ino;st_dev).
It happens with the "less tested" case of xino bits overflow.
I have recently posted [1] some xfstests which also test overlay i_ino.
They require a /proc/locks fix that was merged to v5.5-rc4.
The test overlay/071 also tests a case of xino bits overflow.

Patch #6 includes a change of behavior, which auto enables xino for
tmpfs/xfs.

The series is available on branch ovl-ino on my github [2] and depends
on the previously posted ovl-layers pathces [3].

[1] https://lore.kernel.org/fstests/20191230141423.31695-1-amir73il@gmail.com
[2] https://github.com/amir73il/linux/commits/ovl-ino
[3] https://marc.info/?l=linux-unionfs&m=157700209100564&w=2

Amir Goldstein (7):
  ovl: fix value of i_ino for lower hardlink corner case
  ovl: fix out of date comment and unreachable code
  ovl: factor out helper ovl_get_root()
  ovl: simplify i_ino initialization
  ovl: avoid possible inode number collisions with xino=on
  ovl: enable xino automatically in more cases
  ovl: document xino expected behavior

 Documentation/filesystems/overlayfs.rst |  38 ++++++++-
 fs/overlayfs/inode.c                    | 101 ++++++++++++++++++------
 fs/overlayfs/overlayfs.h                |  21 ++++-
 fs/overlayfs/readdir.c                  |  17 ++--
 fs/overlayfs/super.c                    |  83 ++++++++++++-------
 fs/overlayfs/util.c                     |  20 -----
 6 files changed, 198 insertions(+), 82 deletions(-)

-- 
2.17.1

