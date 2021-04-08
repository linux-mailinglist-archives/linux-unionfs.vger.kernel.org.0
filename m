Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C0E358D65
	for <lists+linux-unionfs@lfdr.de>; Thu,  8 Apr 2021 21:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhDHTSG (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 8 Apr 2021 15:18:06 -0400
Received: from ishtar.tlinx.org ([173.164.175.65]:40966 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbhDHTSG (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 8 Apr 2021 15:18:06 -0400
X-Greylist: delayed 1143 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Apr 2021 15:18:06 EDT
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id 138IwoOV010899
        for <linux-unionfs@vger.kernel.org>; Thu, 8 Apr 2021 11:58:52 -0700
Message-ID: <606F526A.1040405@tlinx.org>
Date:   Thu, 08 Apr 2021 11:58:50 -0700
From:   "L. A. Walsh" <lkml@tlinx.org>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     overlayfs <linux-unionfs@vger.kernel.org>
Subject: odd error: why: mount: /home2: mount(2) system call failed: Stale
 file handle
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Started to try overlay fs w/one fs, but decided on another, so
umounted the first -- hadn't done any changes.

Then tried a different lower dir (/home) and tried to mount into new
dir /home2.  Got:
mount: /home2: mount(2) system call failed: Stale file handle

any idea why?  I cleared out contents of workdir (two empty dirs)
but still didn't work again.

running a Vanilla-ish self-made kernel version 5.9.2...
don't know what other info I should provide...oh well...

