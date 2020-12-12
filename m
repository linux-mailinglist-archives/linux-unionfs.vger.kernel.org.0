Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724812D82E6
	for <lists+linux-unionfs@lfdr.de>; Sat, 12 Dec 2020 00:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437220AbgLKXvX (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 11 Dec 2020 18:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437382AbgLKXuz (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 11 Dec 2020 18:50:55 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AE3C061793
        for <linux-unionfs@vger.kernel.org>; Fri, 11 Dec 2020 15:50:10 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id n10so215377pgl.10
        for <linux-unionfs@vger.kernel.org>; Fri, 11 Dec 2020 15:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vla+WGz7+mzNEdRyGw8REUjx9ptVUt1AwhoEYPEDIOo=;
        b=vBcbxkkdmEb4J01i8uv63ai1hi2Kb4RziEjzwz8z6zBTxlrKtlCJMMxjB4pv6mNmjw
         oFTxGy6ao+nzZ7vDFQ2y/IDnWDLoEk7HvAo2vey9NAF4897VvHoJwhgNomPx3v7MVUn3
         C5xv3QpsCyL3t981iq6rvLb8CONrGFO56U/3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vla+WGz7+mzNEdRyGw8REUjx9ptVUt1AwhoEYPEDIOo=;
        b=VuHJ0KVsmNo35osoQeJSmBxaoqs17l00mYYWdZsa2jCJL/fPf8EbeX8/+iHhGpEMt8
         ivb2P9yZ5RFh4bKwYvRDNMzfK1t7T5tf2AWk5co2CFRI2cIRdf4yHDzNZeOvzQRQ0m+8
         3YisMg1wkfb/x3UPl9aYqjqnm8a4PSaWmG2M9H5C6ehMAPn455+OamLgMq0w3FVnDrfR
         qPAvzbXRRlS0YfwDXILbOzxWaSGjXhexKb1ygU+YgI2dZzxd6tW22OycK+ZnZy1sZSlH
         +tqNCe7Jgc7wyVx63yYvwNRsRG8kydlUJAmTOhP+n+m0KDEamz2EBPeB7PvINXA50mGR
         rINw==
X-Gm-Message-State: AOAM530KnJk88fhlDuTnscDTjkjQNPbvg231UzvC7aBYPtp2e1muILA6
        3X517Mco8zICNN1qjZ3J6D1xuA==
X-Google-Smtp-Source: ABdhPJzHhYldYQY0mXXNqyFrwIVLfLEcO/RLUvoEIFBO3MqVGKJ5uPcfvBV1RbqB25IQsoaSsqfn6w==
X-Received: by 2002:a62:d142:0:b029:19e:62a0:ca1a with SMTP id t2-20020a62d1420000b029019e62a0ca1amr13650389pfl.80.1607730609520;
        Fri, 11 Dec 2020 15:50:09 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id b12sm11324641pft.114.2020.12.11.15.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 15:50:08 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Sargun Dhillon <sargun@sargun.me>, Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 0/3] Check errors on sync for volatile overlayfs mounts
Date:   Fri, 11 Dec 2020 15:49:59 -0800
Message-Id: <20201211235002.4195-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

The semantics of errseq and syncfs are such that it is impossible to track
if any errors have occurred between the time the first error occurred, and
the user checks for the error (calls syncfs, and subsequently
errseq_check_and_advance.

Overlayfs has a volatile feature which short-circuits syncfs. This, in turn
makes it so that the user can have silent data corruption and not know
about it. The third patch in the series introduces behaviour that makes it
so that we can track errors, and bubble up whether the user has put
themselves in bad situation.

This required some gymanstics in errseq, and adding a wrapper around it
called "errseq_counter" (errseq + counter). The data structure uses an
atomic to track overflow errors. This approach, rather than moving to an
atomic64 / u64 is so we can avoid bloating every person that subscribes to
an errseq, and only add the subscriber behaviour to those who care (at the
expense of space.

The datastructure is write-optimized, and rightfully so, as the users
of the counter feature are just overlayfs, and it's called in fsync
checking, which is a rather seldom operation, and not really on
any hotpaths.

[1]: https://lore.kernel.org/linux-fsdevel/20201202092720.41522-1-sargun@sargun.me/

Sargun Dhillon (3):
  errseq: Add errseq_counter to allow for all errors to be observed
  errseq: Add mechanism to snapshot errseq_counter and check snapshot
  overlay: Implement volatile-specific fsync error behaviour

 Documentation/filesystems/overlayfs.rst |   8 ++
 fs/buffer.c                             |   2 +-
 fs/overlayfs/file.c                     |   5 +-
 fs/overlayfs/overlayfs.h                |   1 +
 fs/overlayfs/ovl_entry.h                |   3 +
 fs/overlayfs/readdir.c                  |   5 +-
 fs/overlayfs/super.c                    |  26 +++--
 fs/overlayfs/util.c                     |  28 +++++
 fs/super.c                              |   1 +
 fs/sync.c                               |   3 +-
 include/linux/errseq.h                  |  18 ++++
 include/linux/fs.h                      |   6 +-
 include/linux/pagemap.h                 |   2 +-
 lib/errseq.c                            | 129 ++++++++++++++++++++----
 14 files changed, 202 insertions(+), 35 deletions(-)

-- 
2.25.1

