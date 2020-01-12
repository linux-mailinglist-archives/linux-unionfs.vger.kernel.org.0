Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DABD1388C8
	for <lists+linux-unionfs@lfdr.de>; Mon, 13 Jan 2020 00:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387451AbgALXgD (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 12 Jan 2020 18:36:03 -0500
Received: from mail01.vodafone.es ([217.130.24.71]:60208 "EHLO
        mail01.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgALXgD (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 12 Jan 2020 18:36:03 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Jan 2020 18:36:01 EST
IronPort-SDR: 5z38MgAcS3xFxsxQ7zYNFER/ddBo4HGPgZ74MWStG215seRezmY6m4x7VnLgxv30huwVG4La0U
 DOu0qdkPbaZg==
IronPort-PHdr: =?us-ascii?q?9a23=3AhdV44hLKmuuYf7vWU9mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgeI/XxwZ3uMQTl6Ol3ixeRBMOHsqkC0bSH+Pm6EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMhm7rAHcusYLjYd8N6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhCEAOzAk7G7YkMlwjaJCrB+/oBx/2ZbUYIaPNPVkYqPSY8oWSn?=
 =?us-ascii?q?RHXspISyFBHp+8YJETAOoBI+lYqpfyp10SrRenGwasAvrjxDhPhn/ww6I70/?=
 =?us-ascii?q?0tHh/A3Ac9G94DvmjYoMnwOKoUTOu7zrTHzS/bYv1Y2Tn98pbGfBM8r/6DQb?=
 =?us-ascii?q?1+ftHcyVUtGgzZklmctZDpMy2T2+8Qs2ab9e1gVee3hmA9tQ5xviagxt0xgY?=
 =?us-ascii?q?bJgYIVzF/E/jh+zYYtO9K4VFB0YcSqEZtXsSGaOJB7QsM5Q25zpCk20KEJuZ?=
 =?us-ascii?q?m+fCQQyJQnxAfSZvqaeIaL+hLuTPidLSp6iX5/Zb6yiQq+/VK+xuDzTMW53l?=
 =?us-ascii?q?ZHoyxYmdfWrH8NzQbc6s2fR/t4+UeuxCiA2hjI6uFBPUA0ja3bK4M9wrIolp?=
 =?us-ascii?q?ocr0DDHijulUXzlqCWd0Ek+vK25OTjfrnrqYWQN5Fzig7jKKsulMu/AeImPQ?=
 =?us-ascii?q?QUQWeb4vyw1Lzl/ULnXLVHluM6nrTbvZzAOMgWqLK1DxVL3oss8RqyATer3M?=
 =?us-ascii?q?wdnXYdLVJFfByHj5LuO1HLOP34Femwg0iynzdxyfHGObvhAprWI3jDi7fuZq?=
 =?us-ascii?q?py51RAxwo0yNBT/ZJUCrIZLPLpRkDxrMDYDgM+MwGsx+bnCdN91p4RWG6WH6?=
 =?us-ascii?q?+ZNqLSsViO5uIhOOmBf5EVuDnjJPg//fLujmE2mUUbfaa32Zsbcne4Hu5pIx?=
 =?us-ascii?q?bRXX25htYHDHdPoww/S+rkk3WcXjNJIXW/RaQx4nc8Eo31N4rbQpGRh+m50T?=
 =?us-ascii?q?u2BNVpYWZJQgSUHGvlbZqDXfgMayKJKMRJnTkNVLznQIgkg0KArgj/noJqMu?=
 =?us-ascii?q?fOshIfs52rgMB4++DJihY0+hR0FM6WlWqKSid0nTVbFHcNwKljrBkkmR+42q?=
 =?us-ascii?q?9ijqkDTYRe?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FHSwDXqxtemCMYgtkUBjMYGwEBAQE?=
 =?us-ascii?q?BAQEFAQEBEQEBAwMBAQGBewIBgT0CCYFNUiASk1CBTR+DQ4tjgQCDHhWGCBM?=
 =?us-ascii?q?MgVsNAQEBAQE1AgEBhEBOAReBDyQ6BA0CAw0BAQUBAQEBAQUEAQECEAEBAQE?=
 =?us-ascii?q?BBg0LBimFSoIdDB4BBAEBAQEDAwMBAQwBg10HGQ85SkwBDgFTgwSCSwEBM4U?=
 =?us-ascii?q?ol34BjQQNDQKFHYI7BAqBCYEaI4E0AgEBjBcagUE/gSMhgisIAYIBgn8BEgF?=
 =?us-ascii?q?sgkiCWQSNQhIhgQeIKZgXgkEEdolMjAKCNwEPiAGEMQMQgkUPgQmIA4ROgX2?=
 =?us-ascii?q?jN1eBDA16cTMagiYagSBPGA2IG44tQIEWEAJPi2KCMgEB?=
X-IPAS-Result: =?us-ascii?q?A2FHSwDXqxtemCMYgtkUBjMYGwEBAQEBAQEFAQEBEQEBA?=
 =?us-ascii?q?wMBAQGBewIBgT0CCYFNUiASk1CBTR+DQ4tjgQCDHhWGCBMMgVsNAQEBAQE1A?=
 =?us-ascii?q?gEBhEBOAReBDyQ6BA0CAw0BAQUBAQEBAQUEAQECEAEBAQEBBg0LBimFSoIdD?=
 =?us-ascii?q?B4BBAEBAQEDAwMBAQwBg10HGQ85SkwBDgFTgwSCSwEBM4Uol34BjQQNDQKFH?=
 =?us-ascii?q?YI7BAqBCYEaI4E0AgEBjBcagUE/gSMhgisIAYIBgn8BEgFsgkiCWQSNQhIhg?=
 =?us-ascii?q?QeIKZgXgkEEdolMjAKCNwEPiAGEMQMQgkUPgQmIA4ROgX2jN1eBDA16cTMag?=
 =?us-ascii?q?iYagSBPGA2IG44tQIEWEAJPi2KCMgEB?=
X-IronPort-AV: E=Sophos;i="5.69,426,1571695200"; 
   d="scan'208";a="304359143"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail01.vodafone.es with ESMTP; 13 Jan 2020 00:30:57 +0100
Received: (qmail 24469 invoked from network); 12 Jan 2020 05:00:21 -0000
Received: from unknown (HELO 192.168.1.3) (quesosbelda@[217.217.179.17])
          (envelope-sender <peterwong@hsbc.com.hk>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-unionfs@vger.kernel.org>; 12 Jan 2020 05:00:21 -0000
Date:   Sun, 12 Jan 2020 06:00:20 +0100 (CET)
From:   Peter Wong <peterwong@hsbc.com.hk>
Reply-To: Peter Wong <peterwonghkhsbc@gmail.com>
To:     linux-unionfs@vger.kernel.org
Message-ID: <5761870.460811.1578805221421.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Greetings,
Please read the attached investment proposal and reply for more details.
Are you interested in loan?
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

