Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBE31140E2
	for <lists+linux-unionfs@lfdr.de>; Thu,  5 Dec 2019 13:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfLEMgg (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 5 Dec 2019 07:36:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:52778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729048AbfLEMgg (ORCPT <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 5 Dec 2019 07:36:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D965BB42A;
        Thu,  5 Dec 2019 12:36:34 +0000 (UTC)
Date:   Thu, 5 Dec 2019 13:36:34 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, lkp@lists.01.org,
        Miklos Szeredi <mszeredi@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, ltp@lists.linux.it,
        linux-unionfs@vger.kernel.org
Subject: Re: [LTP] [f*xattr]  ab91fe640f: ltp.open13.fail
Message-ID: <20191205123633.GC5693@rei.lan>
References: <20191205112439.GE32275@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205112439.GE32275@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi!
> commit: ab91fe640fca6de988a888b2de89d58014d120d4 ("f*xattr: allow O_PATH descriptors")
> https://git.kernel.org/cgit/linux/kernel/git/mszeredi/vfs.git for-viro

Looks like fgetxattr() on fd that has been opened with O_PATH returns
wrong errno after this patch, which I guess is OK because that seems to
be the point of this patch.

We will fix the test if/once this patch gets upstreamed.

Also btw man 2 open needs changes in the O_PATH paragraph after this as
well.

-- 
Cyril Hrubis
chrubis@suse.cz
