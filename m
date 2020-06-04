Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F871EE858
	for <lists+linux-unionfs@lfdr.de>; Thu,  4 Jun 2020 18:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbgFDQMz (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 4 Jun 2020 12:12:55 -0400
Received: from relay.sw.ru ([185.231.240.75]:35370 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729678AbgFDQMz (ORCPT <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 4 Jun 2020 12:12:55 -0400
Received: from [172.16.25.93] (helo=amikhalitsyn-pc0.sw.ru)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <alexander.mikhalitsyn@virtuozzo.com>)
        id 1jgsU3-0003Zt-83; Thu, 04 Jun 2020 19:12:47 +0300
From:   Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
To:     miklos@szeredi.hu
Cc:     avagin@openvz.org, ptikhomirov@virtuozzo.com,
        khorenko@virtuozzo.com, vvs@virtuozzo.com, ktkhai@virtuozzo.com,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] overlayfs: C/R enhancements
Date:   Thu,  4 Jun 2020 19:11:31 +0300
Message-Id: <20200604161133.20949-1-alexander.mikhalitsyn@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

This patchset aimed to make C/R of overlayfs mounts with CRIU possible.
We introduce two new overlayfs module options -- dyn_path_opts and
mnt_id_path_opts. If enabled this options allows to see real *full* paths
in lowerdir, workdir, upperdir options, and also mnt_ids for corresponding
paths.

This changes should not break anything because for showing mnt_ids we simply
introduce new show-time mount options. And for paths we simply *always*
provide *full paths* instead of relative path on mountinfo.

BEFORE

overlay on /var/lib/docker/overlay2/XYZ/merged type overlay (rw,relatime,
lowerdir=/var/lib/docker/overlay2/XYZ-init/diff:/var/lib/docker/overlay2/
ABC/diff,upperdir=/var/lib/docker/overlay2/XYZ/diff,workdir=/var/lib/docker
/overlay2/XYZ/work)
none on /sys type sysfs (rw,relatime)

AFTER

overlay on /var/lib/docker/overlay2/XYZ/merged type overlay (rw,relatime,
lowerdir=/var/lib/docker/overlay2/XYZ-init/diff:/var/lib/docker/overlay2/
ABC/diff,upperdir=/var/lib/docker/overlay2/XYZ/diff,workdir=/var/lib/docker
/overlay2/XYZ/work,lowerdir_mnt_id=175:175,upperdir_mnt_id=175)
none on /sys type sysfs (rw,relatime)

Alexander Mikhalitsyn (2):
  overlayfs: add dynamic path resolving in mount options
  overlayfs: add mnt_id paths options

 fs/overlayfs/Kconfig     |  57 ++++++++++++++++++++++
 fs/overlayfs/overlayfs.h |   7 +++
 fs/overlayfs/ovl_entry.h |   6 ++-
 fs/overlayfs/super.c     | 103 ++++++++++++++++++++++++---------------
 fs/overlayfs/util.c      |  42 ++++++++++++++++
 5 files changed, 174 insertions(+), 41 deletions(-)

-- 
2.17.1

