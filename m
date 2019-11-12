Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE82F89F8
	for <lists+linux-unionfs@lfdr.de>; Tue, 12 Nov 2019 08:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725283AbfKLHxq (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 12 Nov 2019 02:53:46 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:49432 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725825AbfKLHxq (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 12 Nov 2019 02:53:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0ThsYsUX_1573545224;
Received: from ali-186590e05fa3.local(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0ThsYsUX_1573545224)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Nov 2019 15:53:44 +0800
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
Subject: [Regression] performance regression since v4.19
Message-ID: <1086cadc-53c3-effd-5ba3-797a015944b5@linux.alibaba.com>
Date:   Tue, 12 Nov 2019 15:53:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi Miklos,

A performance regression is observed since linux v4.19 when we do aio
test using fio with iodepth 128 on overlayfs. And we found that queue
depth of the device is always 1 which is unexpected. 

After investigation, it is found that commit 16914e6fc7
(“ovl: add ovl_read_iter()”) and commit 2a92e07edc
(“ovl: add ovl_write_iter()”) use do_iter_readv_writev() to submit
requests to real filesystem. Async IOs are converted to sync IOs here
and cause performance regression.

I wondered that is this a design flaw or supposed to be.

Thanks a lot,
Jiufei
