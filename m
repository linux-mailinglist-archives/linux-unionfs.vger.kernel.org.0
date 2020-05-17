Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A231D68D0
	for <lists+linux-unionfs@lfdr.de>; Sun, 17 May 2020 18:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgEQQY0 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 17 May 2020 12:24:26 -0400
Received: from out20-14.mail.aliyun.com ([115.124.20.14]:58400 "EHLO
        out20-14.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgEQQYZ (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 17 May 2020 12:24:25 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1941293|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0117065-0.00458725-0.983706;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03303;MF=guan@eryu.me;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.HZt5RnS_1589732658;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.HZt5RnS_1589732658)
          by smtp.aliyun-inc.com(10.147.43.230);
          Mon, 18 May 2020 00:24:19 +0800
Date:   Mon, 18 May 2020 00:24:18 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Eryu Guan <guaneryu@gmail.com>,
        Chengguang Xu <cgxu519@mykernel.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v5] overlay: test for whiteout inode sharing
Message-ID: <20200517162418.GG2704@desktop>
References: <20200513192338.13584-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513192338.13584-1-amir73il@gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, May 13, 2020 at 10:23:38PM +0300, Amir Goldstein wrote:
> From: Chengguang Xu <cgxu519@mykernel.net>
> 
> This is a test for whiteout inode sharing feature.
> 
> [Amir] added check for whiteout sharing support
>        and whiteout of lower dir.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Chengguang,
> 
> I decided to take a stab at Eryu's challenge ;-)

Great! Thanks for the update!

Eryu
