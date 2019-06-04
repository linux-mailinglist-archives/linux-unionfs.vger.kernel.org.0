Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B82D34BA8
	for <lists+linux-unionfs@lfdr.de>; Tue,  4 Jun 2019 17:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfFDPKp (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 4 Jun 2019 11:10:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38856 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbfFDPKp (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 4 Jun 2019 11:10:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id t5so447706wmh.3
        for <linux-unionfs@vger.kernel.org>; Tue, 04 Jun 2019 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cd0jL1l37AnAOITWAtpWiSM2eipoS5jrsZBNVNTYX+Y=;
        b=by4JaETlUxK8Sj9bFkvoi3uSw1FzFALFVuZ6ZhcaO1IaDAWVoYYXdcyqjV6oxKHydJ
         7oYR74yw8/jy3ZI/jmJM3esmrz4+Ga0s4cUX5oYA5hue8pN/KMo9/T+jIio075E7g/M0
         m0RaDsD+hverwxYkoNmaWfrKlNEGPIG7wRqY+gn/yfgzqvz8mGsnPnpg3sWofoj3f+dE
         KHwZxv8fIM0FufqVCztUJ1hDE6J91XHmSohxw2w99y9daSuJRwGHLGSjq9gXgzJdNrCF
         rjpy4SR/KJPMjcTmwjT2I6HaDEkkdNArJun+k4ttKMHRs4T4Rw/0+jDaoRsZl19xXRPc
         ZGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cd0jL1l37AnAOITWAtpWiSM2eipoS5jrsZBNVNTYX+Y=;
        b=IEKBHMX4zvb3e8IiUPawuualpJdtibG1BE6p2IXbO7lCp8xBrueL1IsNITjQYtMHMB
         yIBIzCK39Ci29l8JVnab+zJRIubLNIIs3933XIN0PWcCKBuoFt+27Xhi1ckLror3hvAg
         Xb7x/+gNJa3I5P7BJSH2+sXKqppdKrgxL2vOV3rQ7RL+J0Nh2d3FntTfEzAkiN3X+OR3
         nEOS5fkPp02xnIIH+PKz1VCGjrKKGOyEWvADd8VcOarZIuCsMmF6LigFT6fdloJklsTW
         V6crmfpYNl3IiZ4KADtpPMyI4zQgy+MFKc4e3iZCU0WLTIU0DaTsOW6Het05QaWU9V98
         r5TA==
X-Gm-Message-State: APjAAAVrO58ZWLFMDwQxmmsOMcZj+qMefVf9d4VadEl/WZl1xGQUtv+X
        TNIz/2BdV2zasXoTotGlbzA=
X-Google-Smtp-Source: APXvYqzoS/F608X6NNxHUoRRU3U0zMg5YiNwbZPvcZGzR8gnpSKhAL2mhiJPhhiZAemkXoBv4RgvvQ==
X-Received: by 2002:a1c:f901:: with SMTP id x1mr6430198wmh.157.1559661042766;
        Tue, 04 Jun 2019 08:10:42 -0700 (PDT)
Received: from localhost.localdomain (p548C66C4.dip0.t-ipconnect.de. [84.140.102.196])
        by smtp.gmail.com with ESMTPSA id l7sm9077326wmh.20.2019.06.04.08.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 08:10:42 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Cyril Hrubis <chrubis@suse.cz>, Murphy Zhou <xzhou@redhat.com>,
        Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, ltp@lists.linux.it
Subject: [PATCH v2 2/2] fanotify06: Close all file descriptors of read events
Date:   Tue,  4 Jun 2019 18:10:35 +0300
Message-Id: <20190604151035.6123-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604151035.6123-1-amir73il@gmail.com>
References: <20190604151035.6123-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

With overlayfs test case on kernel v4.19, we get extra events.
If we do not close the event->fd file descriptros of all the events
that we read, overlayfs will fail to unmount at the end of the test
and test will retry un-mounting for a while.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify06.c      | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c b/testcases/kernel/syscalls/fanotify/fanotify06.c
index e053da0e5..273c1f0c4 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify06.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
@@ -148,6 +148,17 @@ static void verify_event(int group, struct fanotify_event_metadata *event)
 	}
 }
 
+/* Close all file descriptors of read events */
+static void close_events_fd(struct fanotify_event_metadata *event, int buflen)
+{
+	while (buflen >= (int)FAN_EVENT_METADATA_LEN) {
+		if (event->fd != FAN_NOFD)
+			SAFE_CLOSE(event->fd);
+		buflen -= (int)FAN_EVENT_METADATA_LEN;
+		event++;
+	}
+}
+
 void test_fanotify(unsigned int n)
 {
 	int ret;
@@ -198,17 +209,16 @@ void test_fanotify(unsigned int n)
 		} else {
 			verify_event(i, event);
 		}
-		if (event->fd != FAN_NOFD)
-			SAFE_CLOSE(event->fd);
+		close_events_fd(event, ret);
 	}
+
 	for (p = 1; p < FANOTIFY_PRIORITIES; p++) {
 		for (i = 0; i < GROUPS_PER_PRIO; i++) {
 			ret = read(fd_notify[p][i], event_buf, EVENT_BUF_LEN);
 			if (ret > 0) {
 				tst_res(TFAIL, "group %d got event",
 					p*GROUPS_PER_PRIO + i);
-				if (event->fd != FAN_NOFD)
-					SAFE_CLOSE(event->fd);
+				close_events_fd((void *)event_buf, ret);
 			} else if (ret == 0) {
 				tst_brk(TBROK, "zero length "
 					"read from fanotify fd");
-- 
2.17.1

