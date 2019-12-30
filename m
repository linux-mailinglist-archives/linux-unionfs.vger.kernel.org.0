Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE07512D087
	for <lists+linux-unionfs@lfdr.de>; Mon, 30 Dec 2019 15:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfL3OOe (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 30 Dec 2019 09:14:34 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:52190 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbfL3OOd (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 30 Dec 2019 09:14:33 -0500
Received: by mail-wm1-f46.google.com with SMTP id d73so14028162wmd.1;
        Mon, 30 Dec 2019 06:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5BRhvobtNdmKk3i7GYogWznJM8/6rPQQF6haJk7WNLI=;
        b=qfC3EWr5t135z+izzMQVQO9zIyNrGp1ojxNrudKIuNJEcI96RT1FfZP5junsAzqWND
         kVubFK4kOxu+Q0Ymvb3XIqpZG1wd9h+nKFfLL5O5nX2CVyOngOS0BmTRJ7Ve+u7zyPhv
         nLgFmag9eRpAeB/GiScNhL4qDeLqYvxuTwYp6j4ZFok/Q7ejTd4/LPRTxH9T4q8yAmJS
         CYKht1mfmLN6Uvfqjo+r4oYXvAlMe7bTwRhfYp+ZFXrOnFQKXxuqLHxnlaxqhwbZx/VB
         yyOzU7iqft1OtWygTILc9aE06qCeFNM77e5HoMVN7HcBtdlCZmF8TsepOcBHgqzaUSvh
         HPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5BRhvobtNdmKk3i7GYogWznJM8/6rPQQF6haJk7WNLI=;
        b=BPF5JTArm4aSgp/nJOOWA7VpO62T1RqXzuh2Szt9IYS/LT0Us+Ijiwxxu/TdhwBDar
         HffzDkZ15dfyyfJZ+IYPh0l1BgXxR54d14KSLVg5YYr7hUeUgzX9Ld0ovL0eImEVwgvE
         m69QmFi+vJVGKT91I1LTyKydedzoUT2bM1PzJRaq0YjIPuG5Jp8OEv4UVMXNJ42BhAii
         5TAwv9LuUaAJxPPFalnLZCriS87iJkoyR+P4AhTITRFPM/T5w3KiafT//muwmwVoYuUK
         KXSkvKNE8v73KvdXKjDMQn6Vec/wQdTf1YzCTDPA3FoPy2NZYcKy775g8PPymyDiFtzO
         4Ddg==
X-Gm-Message-State: APjAAAXcrO09PGL4Mj65gHGMQGVRVnBmzn0Ai0sRtkP8gHUifo0pjsxO
        +q2hRmloxvrmvwcUyP3AxH9eLmnP
X-Google-Smtp-Source: APXvYqzbtzt8WEyhtEtRURvNZkueIbnQoC+RQT9tXTbs6WWiPBIUZG+fUxzw8RFs/tne59F1yQzUJg==
X-Received: by 2002:a05:600c:2318:: with SMTP id 24mr34061028wmo.48.1577715271622;
        Mon, 30 Dec 2019 06:14:31 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id t8sm44532651wrp.69.2019.12.30.06.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 06:14:31 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Jeff Layton <jlayton@poochiereds.net>,
        linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH v2 1/5] overlay: create the overlay/nested test group
Date:   Mon, 30 Dec 2019 16:14:19 +0200
Message-Id: <20191230141423.31695-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230141423.31695-1-amir73il@gmail.com>
References: <20191230141423.31695-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

For tests that mount an overlayfs over overlayfs.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/overlay/group | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/overlay/group b/tests/overlay/group
index b7cd7774..e809f7f2 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -24,14 +24,14 @@
 019 auto stress
 020 auto quick copyup perms
 021 auto quick copyup
-022 auto quick mount
+022 auto quick mount nested
 023 auto quick attr
 024 auto quick mount
 025 auto quick attr
 026 auto attr quick
 027 auto quick perms
 028 auto copyup quick
-029 auto quick
+029 auto quick nested
 030 auto quick perms
 031 auto quick whiteout
 032 auto quick copyup hardlink
-- 
2.17.1

