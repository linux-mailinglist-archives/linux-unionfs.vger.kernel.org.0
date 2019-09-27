Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00408C0262
	for <lists+linux-unionfs@lfdr.de>; Fri, 27 Sep 2019 11:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfI0Jaj (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 27 Sep 2019 05:30:39 -0400
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25986 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbfI0Jaj (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 27 Sep 2019 05:30:39 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Sep 2019 05:30:38 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1569575724; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=eb17F1Non85XNfYIqLt3sACZd0m4e6u+0bxnj4+oGDKhJGZEU1XXMytQBH3hfYPmnTASnO3uJind0vn4+ImuW+JtmG7ju9V3dCjyN+lQ8yGKSZZYFDTASQ8C3XoZiQXmn29k6jj2eI7n4aeWfH4GFffMXyiX5Ig4MIzKTWyJG4w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1569575724; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results; 
        bh=JVXdfnH1h9+CN+0ofoEsDBsbbJT4lnn6Jr8SBMPUsNU=; 
        b=ioZ2H5iWn7XOtaJaF9ptzrOTv6HEPNkc4g4saO794ikI9wWK1a6rHJQaO+5GDnKdBdF87mvjcG4Ka3ful/Fh6ornQA4mFBy2hIb12mDHuZs6Z3zo0J0kxsUXAU7G3rqrEEDeCUosnN71FTQB3Nig+IhQs4XcWEsWrjtnGnDMP5A=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1569575724128201.5293655946234; Fri, 27 Sep 2019 17:15:24 +0800 (CST)
Received: from  [218.18.229.179] by mail.zoho.com.cn
        with HTTP;Fri, 27 Sep 2019 17:15:24 +0800 (CST)
Date:   Fri, 27 Sep 2019 17:15:24 +0800
From:   admin <cgxu519@zoho.com.cn>
Reply-To: cgxu519@zoho.com.cn
To:     "miklos" <miklos@szeredi.hu>
Cc:     "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "cgxu519" <cgxu519@zoho.com.cn>
Message-ID: <16d7200e45c.1398c37e020790.5506577327176178828@zoho.com.cn>
In-Reply-To: 
Subject: syncfs improvement for overlayfs
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Priority: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi Miklos,

It's been a while since I posted my last version of syncfs improvement patch[1]
and I noticed it isn't get merged yet. If you think this patch is still valuable then
I would like to do rebase on latest overlayfs tree and resend for review.
What do you think?


[1]
https://www.spinics.net/lists/linux-unionfs/msg04174.html

Thanks,
Chengguang

