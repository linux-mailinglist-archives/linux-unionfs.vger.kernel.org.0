Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAF0B49916
	for <lists+linux-unionfs@lfdr.de>; Tue, 18 Jun 2019 08:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfFRGoF (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 18 Jun 2019 02:44:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33498 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbfFRGoE (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 18 Jun 2019 02:44:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so12611168wru.0;
        Mon, 17 Jun 2019 23:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8YMeWmIyyq89IcmvN4vVUK/VhCYck0NSmpdo/v8WKm4=;
        b=e94dxPpwgZV3PHR4nIc8QMgqNZalHb7PN1og1K9MfDCKqeceF790IjA33gFIpNtR2O
         U8apiHRCZ4R1VkHgYbOCRpakPCxrxWmzZzBtVdkGCLFYm5B1J1dSy+iKlz72yd4IsZ4G
         AHNc6XnfQQhNf/rxRY+2+v1sCuMTkJW5YNIUNx4B4oOcsVgdR808VMfgFOzBuKisnP0O
         Xh9Z7CtehqC8yjiwfrUBC0oUicsts9VIUluIIHsa+igljUMKkECQLNOJYFfLwIlOK0aX
         CSSt+ltBHr5IlfXIOGJ1Auq2fdAjnSz31ux67THjTlbXbl27ZCVoI673qimKvFL8meqX
         1SCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8YMeWmIyyq89IcmvN4vVUK/VhCYck0NSmpdo/v8WKm4=;
        b=EiGu4nGvPV8dwgA4KMpSS8NB9K115nMrbZFRNTkAiMebZ9OXjuW/dMVug3/45C/6yq
         20mi5ZdFoHcku7AM/8vnJd1OK5ZQhgz9e5cyYgpPzCRKDhlqR8QHQTQqAkzNlgKSzvxj
         XG0HBg66b/o3CuK70A3ncdeyqfQpTqg+nYrYtAq8vL/JnOESzGp4fN6TNnamgnxlOw3f
         KzCQUHO4ooFtvWxSxMIJrC0Z/lsTSDK/iqHuPWuJvO4ZveCbuaydyhcQDh2lA3DWdwHy
         1+iwOgY491Y6T6oYLxBv3ObFGtLQZwA2q1dCSj3XlymNOj3WTW6WG4be6bvnkulvgwAd
         2Hrg==
X-Gm-Message-State: APjAAAXPZ5UNt/Io3jxc2YH3CFrUX/9nUyt7AgJoOIJ6emgzD4e/iPDE
        JCFUmHplICjZGrRMEzvEIpc=
X-Google-Smtp-Source: APXvYqxCUDkuoirh8jkmUMXmmbqK9SCbMDeFNY6uu493rWObMQT9lgtorsdsSUG73rOj3dB2zK0KDA==
X-Received: by 2002:adf:e9c6:: with SMTP id l6mr1561280wrn.216.1560840242343;
        Mon, 17 Jun 2019 23:44:02 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id v204sm1429006wma.20.2019.06.17.23.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 23:44:01 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] overlay/061: remove from auto and quick groups
Date:   Tue, 18 Jun 2019 09:43:55 +0300
Message-Id: <20190618064355.29398-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

In late 2016, tests overlay/01[6-8] where merged to track the
state of several ilong standing posix compliance issues on overlayfs.

This practice was somewhat of an exception for xfstests project,
which more often merges tests for issues that are expected to be
resolved in the short term.

Over the years, some test cases have been fixed and more tests
where created to cover the remaining issues (e.g. overlay/04[34]).

Currently, the only failing test from this category is overlay/061
which covers item b) in the "Non-standard behavior" section of
Documentation/filesystems/overlayfs.txt.

Since there is no clear design, roadmap nor allocated resources
to resolve this remaining issue, the test is removed from the
"auto" and "quick" groups, following a suggestion that Darrick
has made for a similarly long failing generic test.

The test was added to the new "posix" group, to allow testing
for posix compliance.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Eryu,

With this change, check -overlay -g overlay/quick run is expdected
to be all green.

I did not observe any regressing with check -overlay -g generic/quick
compared to check -g generic/quick on xfs with recent kernel.
I did not test all filesystems and -g generic/auto with recent kernel,
but I am not aware of any expected failures specific for -overlay run
on generic tests.

check -overlay -g overlay/auto has one non-quick stress test
(overlay/019) which is failing on lockdep circular locking dependency
warning (if you have lockdep enabled).
This is a known issue that has also been reported by syzbot.

Thanks,
Amir.

 tests/overlay/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/overlay/group b/tests/overlay/group
index 8bde6ea1..ef8517a1 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -63,7 +63,7 @@
 058 auto quick exportfs
 059 auto quick copyup
 060 auto quick metacopy
-061 auto quick copyup
+061 posix copyup
 062 auto quick exportfs
 063 auto quick whiteout
 064 auto quick copyup
-- 
2.17.1

