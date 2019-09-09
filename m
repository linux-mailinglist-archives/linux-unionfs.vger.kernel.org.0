Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB4EAE127
	for <lists+linux-unionfs@lfdr.de>; Tue, 10 Sep 2019 00:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbfIIWrT (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 9 Sep 2019 18:47:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37846 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbfIIWrT (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 9 Sep 2019 18:47:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3DF4360303; Mon,  9 Sep 2019 22:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568069238;
        bh=Y/IuLwHZa6E6V0WRz+uYsMdEVK899wiCU7hIZzCVVmg=;
        h=Date:From:To:Cc:Subject:From;
        b=HL/9htVWFkKjSV91mUDuHX0XKv0jblsNAbiBfDbZbi5I4j5WX/+wjkI1Hp4jqDrkk
         YLatxn4yQigfEnxuzLUDmG5kZKWfEUzdPNLAJ/z1pAAk10uYYPEDAQJkW25PhLHnQt
         zxc3Im4lfuJd43AyQHmxwThf44JgjMex+pQtKYWQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 634BE601D4;
        Mon,  9 Sep 2019 22:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568069237;
        bh=Y/IuLwHZa6E6V0WRz+uYsMdEVK899wiCU7hIZzCVVmg=;
        h=Date:From:To:Cc:Subject:From;
        b=H1nCZQ0gsMeDkNuHDtvNloVBw1wimd/3P+3OX73u0ZQTRUDX+wjBOAoFSn4THkjiI
         XVAej3kngr+iWV26AdBoGx5SLL1klWaj78X/7d3nPeGn23VZGl8xVXbwF6Y7FWsbfO
         JJvPiLhrnoyqONed+VIQnrpmG1IxXiCxoRyqOQwc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Sep 2019 15:47:17 -0700
From:   rishabhb@codeaurora.org
To:     miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tsoni@codeaurora.org, psodagud@codeaurora.org,
        jshriram@codeaurora.org
Subject: Bug at kernel/cred.c +432
Message-ID: <083b3f61efeca1d73839ac96e396748e@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi Miklos

In 4.19 kernel when we write to a file that doesn't exist we see the
following stack:
[  377.382745]  ovl_create_or_link+0xac/0x710
[  377.382745]  ovl_create_object+0xb8/0x110
[  377.382745]  ovl_create+0x34/0x40
[  377.382745]  path_openat+0xd44/0x15a8
[  377.382745]  do_filp_open+0x80/0x128
[  377.382745]  do_sys_open+0x140/0x250
[  377.382745]  __arm64_sys_openat+0x2c/0x38

If the override_cred flag = off, the ovl_override_cred and 
ovl_revert_cred just returns NULL.
But there is another override_cred in between these two functions;
		put_cred(override_creds(override_cred));
		put_cred(override_cred);

This will override the credentials permanently as there is no 
corresponding revert_cred associated.
So whenever we do commit_creds for this task, we see a BUG_ON at 
kernel/cred.c +443.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/cred.c#n443

Should this override_cred be changed to ovl_override_cred to maintain 
consistency and avoid this
BUG_ON?


Thanks,
Rishabh
