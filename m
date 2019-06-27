Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA4657EE3
	for <lists+linux-unionfs@lfdr.de>; Thu, 27 Jun 2019 11:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfF0JC2 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 27 Jun 2019 05:02:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34119 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfF0JC2 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 27 Jun 2019 05:02:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id c85so903876pfc.1;
        Thu, 27 Jun 2019 02:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bdGzQwsFbUV/HCONHsbImrbySNkccApcp2w5Da9OzBs=;
        b=IbU0B/hwWepUteRrj5UH2NWM7Lq5swfwNkfhgAxGnG8Ey5JG2iqADQNxgCnrTCHGux
         8YpOa8P1E62GubkzwlpXbaW9oIdbd+VhCUCD8fdEw4Ohfmjvt67a/bPcaPN80y03Kk6r
         lrDZ1G4CNYeDYylpRCn4ncCeQ2mFqJ4Pb9su26U28Q2xALJ5VgwH/bN0eXwrmmCp1BYT
         jxzcFufhf8/AetK8RPv1Y5sUOfR313Yle0u0R09JI/hSdQ8PXd7oC1D6HM5+gYwQz3q4
         4rb2ZJ3EKX4aUq4PmEUi7EBRYPb8JsI/DZ6lgTXPTbBu+G8ccN1Q+uXUJ8wn0xVqRl6X
         lR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bdGzQwsFbUV/HCONHsbImrbySNkccApcp2w5Da9OzBs=;
        b=ZD83t/FYaAxWFP8I1e7bxslgfhf4annfQ4Ts6doxnhIqybQz30KHhFunBtjBpcFw7+
         UfNI2ivPZ/sFS1tw0neAQZwBuABHLerRve1lHCGz0+Tb9GhCyjZNTUOQE/a9IjtO9lZy
         WLm0HAJsjBVf3KoTwHa9pybUcxhXW6//3izVtAzWD0KluxohleZTqZwIyO8e2OhZd9nb
         k5Ogjc/8EmgLsx3Pk3Wla+RcFW9CIv5jetys47kIPfyWcTBF1mRjbaONYINTRpN6abyO
         lEkxWXfBjTLYaICeUEp8/5fMZDUhvQ4tytGMjiuHQ0JN7Mse4s3HNXaGZz+v/qOCo91Q
         IqsA==
X-Gm-Message-State: APjAAAXFFHv5khm4uNFwOn20IdQ5vfXxz8KFWhc3eaI0AD943odHraAy
        B/W1wkYgUfgTAxhQGpebK9o/qskcP+0=
X-Google-Smtp-Source: APXvYqwRcewbzAvJx30vEKvhfVvrfoShUQgdbDxAJKifmb1Tmyx+YEUSjU+9QSJta7H85zInH+wnUg==
X-Received: by 2002:a63:d755:: with SMTP id w21mr2742917pgi.311.1561626147397;
        Thu, 27 Jun 2019 02:02:27 -0700 (PDT)
Received: from XZHOUW.usersys.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a21sm2555134pfi.27.2019.06.27.02.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 02:02:26 -0700 (PDT)
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     fstests@vger.kernel.org
Cc:     darrick.wong@oracle.com, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, Murphy Zhou <jencce.kernel@gmail.com>
Subject: [PATCH] generic/486: filter out irrelevant attrs
Date:   Thu, 27 Jun 2019 17:00:59 +0800
Message-Id: <20190627090100.18542-1-jencce.kernel@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

In some setup, there could be extra attrs printed, like selinux.
They are breaking golden output and irrelevant for this test.
So focus on the attr we are testing on to avoid false alarm.
Print the output to .full for debug.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 tests/generic/486 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/generic/486 b/tests/generic/486
index ff115a07..ea571efe 100755
--- a/tests/generic/486
+++ b/tests/generic/486
@@ -46,10 +46,12 @@ _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount >>$seqres.full 2>&1
 
 filter_attr_output() {
-	_filter_scratch | sed -e 's/has a [0-9]* byte value/has a NNNN byte value/g'
+	_filter_scratch | grep world | \
+		sed -e 's/has a [0-9]* byte value/has a NNNN byte value/g'
 }
 
 ./src/attr_replace_test $SCRATCH_MNT/hello
+$ATTR_PROG -l $SCRATCH_MNT/hello >>$seqres.full 2>&1
 $ATTR_PROG -l $SCRATCH_MNT/hello | filter_attr_output
 
 status=0
-- 
2.21.0

