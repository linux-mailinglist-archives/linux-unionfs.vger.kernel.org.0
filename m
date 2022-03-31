Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C414ED865
	for <lists+linux-unionfs@lfdr.de>; Thu, 31 Mar 2022 13:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbiCaLZ4 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 31 Mar 2022 07:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbiCaLZu (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 31 Mar 2022 07:25:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D244A3E7
        for <linux-unionfs@vger.kernel.org>; Thu, 31 Mar 2022 04:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2663614ED
        for <linux-unionfs@vger.kernel.org>; Thu, 31 Mar 2022 11:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8D6C340F3;
        Thu, 31 Mar 2022 11:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648725842;
        bh=II70sTDLY9LItlWI23mxZrS64QBm0nTIcCL0trt0Emw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nCyQbOWp3qvD1Ca1wIQWaXcyaZEO5bfKYBxMSUD+8psYD227I+yAWo8o/LO5mywPI
         KxXAMbodkO+xocwYxmqCbQ6qwiDB3S3tW6WTAJr8k5K2P05YWWN5moqBd2981BCW1W
         1QsSQowjbl3VWixofDNMDvFQzcPTjNRsGYQ6L1TQCLMp9LFtxXgCwuW5C+AoGjVz6F
         J3psC2XF6hR/2yrhm4CSZm7DvIH/vfWx8JgM/3zPa8kmjoYxHfMssrzYoaIwMm5aaa
         b+/TX5RfUb/EsEu0M0sLfNNsa+c1lLChffWm5prbcKJmWDMHYJ3cQZxxW/7G5YgwB9
         D6urv+9hSVSJA==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-unionfs@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos Catelin <rodrigo@sdfg.com.ar>,
        Seth Forshee <sforshee@digitalocean.com>,
        Luca Bocassi <luca.boccassi@microsoft.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>
Subject: [PATCH v3 05/19] ovl: add ovl_upper_idmap() wrapper
Date:   Thu, 31 Mar 2022 13:23:03 +0200
Message-Id: <20220331112318.1377494-6-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220331112318.1377494-1-brauner@kernel.org>
References: <20220331112318.1377494-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302; h=from:subject; bh=II70sTDLY9LItlWI23mxZrS64QBm0nTIcCL0trt0Emw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS59ks0X3BUYlPlrUqd/83g1lazgqfzDRy36zAvYNH0zHOy aDjRUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBHVXIb/9cEpvI9M57/KucvFnWv6d+ 4dNtnXruvCU3KDxc+8mlvfyshweZXopKCQe4oP+RozevQnLLKfblUW4bd8y3ehe88CF8kyAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Add a tiny wrapper to retrieve the upper mount's idmapping. Have it
return the initial idmapping until we have prepared and converted all
places to take the relevant idmapping into account. Then we can switch
on idmapped layer support by having ovl_upper_idmap() return the upper
mount's idmapping.

Suggested-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
/* v2 */
- Miklos Szeredi <mszeredi@redhat.com>:
  - Add separate patch for ovl_upper_idmap() and have it return the
    initial idmapping until we turn idmapped layer support on later.

/* v3 */
unchanged
---
 fs/overlayfs/ovl_entry.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 63efee554f69..22ce60426de2 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -90,6 +90,11 @@ static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
 	return ofs->layers[0].mnt;
 }
 
+static inline struct user_namespace *ovl_upper_idmap(struct ovl_fs *ofs)
+{
+       return &init_user_ns;
+}
+
 static inline struct ovl_fs *OVL_FS(struct super_block *sb)
 {
 	return (struct ovl_fs *)sb->s_fs_info;
-- 
2.32.0

