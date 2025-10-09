Return-Path: <linux-unionfs+bounces-2160-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1D4BC7DA8
	for <lists+linux-unionfs@lfdr.de>; Thu, 09 Oct 2025 10:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 729654F7B28
	for <lists+linux-unionfs@lfdr.de>; Thu,  9 Oct 2025 08:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131782D321D;
	Thu,  9 Oct 2025 07:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMirGicO"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F6C2D131A
	for <linux-unionfs@vger.kernel.org>; Thu,  9 Oct 2025 07:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996785; cv=none; b=GJIcpSU8m/bERC//qIlPpxMQitaKQS6P3ZIXXSknby8Zpz6gz8E5NERF3XYGINhpd79epB1/+qZmIljJSnwNcZeTXiqXovVbfLtraowYf+enLkNfJu28n0ppK3OgGDqh4rr6amCYjOxQeaAY2PXxya4bgcgH90/6tMa4k2JqyUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996785; c=relaxed/simple;
	bh=hn/T4KF427I5vM1FE3EEQtD8Ky5WVe1EdG5AuHI54+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AaK2OHY70rGGv8LnHcirfrgxYDvUuePENpq8Kdo8W2HQSzBkwQKxsMCRfmqMRglk9z/et88WYh8SH+ZDEQD2snIV1Dt6yxLsVxFuaI8Ac/b7kUv53G8QfPulftB0W1eIGDDjXs+pozMhYKKsFGQFxkRzfrOZKcgkjj4eLiXXnzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMirGicO; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b41870fef44so112509766b.3
        for <linux-unionfs@vger.kernel.org>; Thu, 09 Oct 2025 00:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996781; x=1760601581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v56yGNQ37Majx7vHh2h4KlxSuTszWt/5MXXh209zdXY=;
        b=lMirGicOJdPSNtq9UZZJiIbkDKhy9CQKtYmj64hbx8QVtEfVQuXDHFoFXpPwusWLPp
         TgB2diOAbyyiUZcXGKKHKQWVgGL1Jx5zQmAsLuWo7rzUL/RHUceQ6EmmLLL7Tuuvpp4o
         p9ObZpVAYRgOtDSAocog43dOeC1QR+/iw8CnAsNHbYFgI5Ks4nU2NhrpX0ALFEcaEVps
         HMcARGcAMROGsXQWYoNrwFrRuRN/dEOF92/+8jeLPDMVuQaS266+1IDl1a5rwpVSlF6c
         2XA+0rOpC18GFVQLbBReMGiW4hLHZ1ZRNPiZz+JymED71pXEAhX8lcUFUw1rNjt8rgI/
         ickw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996781; x=1760601581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v56yGNQ37Majx7vHh2h4KlxSuTszWt/5MXXh209zdXY=;
        b=PYMVmIDoRMo/YKcN/pfg70Tlm6uEMCeLkqCj9Jtqfnx2Qnp1R09Jjgz7YycoyO9YIN
         S9QBj/qSPfssbNwXpMelNwt1791ahuol+VAahZPsZdYzoBzVUSz3hhOGnBH7CNDv0I57
         9rsvNe6PP/7COoC5f5coaA3aGKsG8FwF9LbQ5TXUpM59ZCFCZMXjwL5Z2nH3QapTR6Jf
         oFU+8LkV8KRJmRJs2wqqNceM4f9KGRhv4wYXt3n7jBfhghrUPEmp7MT730TVifMsi3ZN
         QC2srPwuQnbcnb2n1NvaNs0Io5y7fhhDZRtAof2DCtRjPBqVRv8fiwQtTlO0FUTdIuhJ
         4j8w==
X-Forwarded-Encrypted: i=1; AJvYcCUREJMUbUqkDOFpnYCO6I+0MKLPdPByXItbZHSvH45wOK8DdfFTokcndqAC8IR2GMhVVxMKut+VuO9fQ7R2@vger.kernel.org
X-Gm-Message-State: AOJu0YwJcLMu8kMUUVQe+3yPvm6XLAmy9o8fM2KZw9H3xo7f7RCpYkTS
	XpBdlDPwmRTiWfzXSm5Qexqrgjt7btgg0N04rL3FnA6o93LSRslfJHfF
X-Gm-Gg: ASbGncsV6qjQFbTwCc30hVCZS2mAPncvFTkc1+a/DZxDFf+AgEU/caJuQ9KuUr95LYF
	1bTqXKBW5NEDCNaFBBhxK99ZgDlqdTjKkQUSw1OFoTz5qYA0CB9ozRgF2uJWnmuMjhBv6mpapzb
	ovJyexi0afmLAh+aTyCXV5R/gVsvRWlEumGWedpNiyFc95iUm3mJvbFILhyxs0Vel9BmgjZyui6
	ZLziY/CjS+nsDhmNEyAcLtdFzLSiMmYVacIQ7wjz3tOMrXlrFn6WDWegj7/OI04mnVGLPNaCvuP
	L25XpnSIt6fRX+nZtsDgr3RXlGN/vBFnpMYr3Y1UN4Nww4hm9HrikDVlzfPfg6flJNk+yOZ7AwR
	84dFE40ila6MeMi2aiFsDlzuR6i8vFrbm9pmyROz9f7Zjzr6NPwDNCaJgjN8VMAAd1NBMCeKh5b
	uiVg8wN4axFW4em8Hc2JXJKcyKn5hWIAFA
X-Google-Smtp-Source: AGHT+IEc4DRH7N7VTwKCGCSJIEPnJelkA9fOKTTSeoDugfMSCygU9n//Fy4KEuh4pwZhlTzmLezAHw==
X-Received: by 2002:a17:907:3f17:b0:b41:abc9:613c with SMTP id a640c23a62f3a-b50ac5d08e9mr658923266b.51.1759996781064;
        Thu, 09 Oct 2025 00:59:41 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.00.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:59:40 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v7 01/14] fs: move wait_on_inode() from writeback.h to fs.h
Date: Thu,  9 Oct 2025 09:59:15 +0200
Message-ID: <20251009075929.1203950-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009075929.1203950-1-mjguzik@gmail.com>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only consumer outside of fs/inode.c is gfs2 and it already includes
fs.h in the relevant file.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h        | 10 ++++++++++
 include/linux/writeback.h | 11 -----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ac62b9d10b00..b35014ba681b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -949,6 +949,16 @@ static inline void inode_fake_hash(struct inode *inode)
 	hlist_add_fake(&inode->i_hash);
 }
 
+static inline void wait_on_inode(struct inode *inode)
+{
+	wait_var_event(inode_state_wait_address(inode, __I_NEW),
+		       !(READ_ONCE(inode->i_state) & I_NEW));
+	/*
+	 * Pairs with routines clearing I_NEW.
+	 */
+	smp_rmb();
+}
+
 /*
  * inode->i_rwsem nesting subclasses for the lock validator:
  *
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index e1e1231a6830..06195c2a535b 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -189,17 +189,6 @@ void wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
 void inode_wait_for_writeback(struct inode *inode);
 void inode_io_list_del(struct inode *inode);
 
-/* writeback.h requires fs.h; it, too, is not included from here. */
-static inline void wait_on_inode(struct inode *inode)
-{
-	wait_var_event(inode_state_wait_address(inode, __I_NEW),
-		       !(READ_ONCE(inode->i_state) & I_NEW));
-	/*
-	 * Pairs with routines clearing I_NEW.
-	 */
-	smp_rmb();
-}
-
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 #include <linux/cgroup.h>
-- 
2.34.1


