Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53F47CD8CE
	for <lists+linux-unionfs@lfdr.de>; Wed, 18 Oct 2023 12:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjJRKI3 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 18 Oct 2023 06:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJRKI2 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 18 Oct 2023 06:08:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE20D95;
        Wed, 18 Oct 2023 03:08:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0A44B21AC5;
        Wed, 18 Oct 2023 10:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1697623705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Ebeu1CZw7f/xdwBs2G1M4yI3NEq7u+QmjV02kBazjyo=;
        b=Y5pMK/z30ki9SW6ywI4ydoItHoDQSnQrIccvoMfqRSw9VWAGQ6KF1ART/EDkNpKZo8M9NE
        MhHNSE3rB1HN5czic98xSDLV9THSWlkdIiSQEIpIv08ftqQF3IhyOwXBieFZhv3nr93nsh
        GCp9lfi+ubV8tZNSOGGDdKFzUUYfI6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1697623705;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Ebeu1CZw7f/xdwBs2G1M4yI3NEq7u+QmjV02kBazjyo=;
        b=HnAHfapXiN9Mon0mqRsfneN92uAtTVIpjEQ87HwwyUa0YRqVXo+RC/b4NW1AW2bOuz4rmh
        Vj4aXO8SjhS7qODQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDE1B13780;
        Wed, 18 Oct 2023 10:08:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DQ7SNJiuL2UnQwAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 18 Oct 2023 10:08:24 +0000
From:   David Disseldorp <ddiss@suse.de>
To:     selinux@vger.kernel.org
Cc:     linux-unionfs@vger.kernel.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH] RFC: selinux: don't filter copy-up xattrs while uninitialized
Date:   Wed, 18 Oct 2023 12:08:15 +0200
Message-Id: <20231018100815.26278-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.90
X-Spamd-Result: default: False [0.90 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[36.05%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Extended attribute copy-up functionality added via 19472b69d639d
("selinux: Implementation for inode_copy_up_xattr() hook") sees
"security.selinux" contexts dropped, instead relying on contexts
applied via the inode_copy_up() hook.

When copy-up takes place during early boot, prior to selinux
initialization / policy load, the context stripping can be unwanted
and unexpected. Make filtering dependent on selinux_initialized().

RFC: This changes user behaviour so is likely unacceptable. Still,
I'd be interested in hearing other suggestions for how this could be
addressed.
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2aa0e219d7217..fb3e53bb7e90c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3527,7 +3527,7 @@ static int selinux_inode_copy_up_xattr(const char *name)
 	 * don't then want to overwrite it by blindly copying all the lower
 	 * xattrs up.  Instead, we have to filter out SELinux-related xattrs.
 	 */
-	if (strcmp(name, XATTR_NAME_SELINUX) == 0)
+	if (selinux_initialized() && strcmp(name, XATTR_NAME_SELINUX) == 0)
 		return 1; /* Discard */
 	/*
 	 * Any other attribute apart from SELINUX is not claimed, supported
-- 
2.35.3

