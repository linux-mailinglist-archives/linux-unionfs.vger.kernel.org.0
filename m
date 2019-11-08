Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1559F4286
	for <lists+linux-unionfs@lfdr.de>; Fri,  8 Nov 2019 09:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfKHItL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-unionfs@lfdr.de>); Fri, 8 Nov 2019 03:49:11 -0500
Received: from smtp2.axis.com ([195.60.68.18]:6671 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730281AbfKHItL (ORCPT <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 8 Nov 2019 03:49:11 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Nov 2019 03:49:10 EST
IronPort-SDR: WvRnsVaQdIw9h4ToGnaAScFovIcj8ixDqnHUkvokG0Y1Rbohu6FQ7yHp8IuPJ+iW5qA4ANdHim
 s0eEI9Pjg3sB4d03zBdyoHeVfkRWnYbWx97P/MvJ5tH3JrrsSKjg+XWgIk9pfj87fBLccRlpiL
 wYnWFo3Z8T9BIE67fa3t/sSXpddBzmpXuXNLhJZzUdFd8scqp59EEIjfLN4UjRRvUH4xJVXKQy
 DJkMCckabPIVg3NwIKCSwPjimkuwr5NIYq7+h/U+hljSMJOptqT9y65aHKArD1/DiwVHboO6hb
 tSI=
X-IronPort-AV: E=Sophos;i="5.68,280,1569276000"; 
   d="scan'208";a="2223074"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
From:   Anders Dellien <anders.dellien@axis.com>
To:     "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>
Subject: [Help] Problem when using overlayfs with LoadPin
Thread-Topic: [Help] Problem when using overlayfs with LoadPin
Thread-Index: AQHVlg+AU4rtIfIfBEmjUkXD88NDhg==
Date:   Fri, 8 Nov 2019 08:42:02 +0000
Message-ID: <1573202522019.97305@axis.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi all,

I have previously successfully used LoadPin [https://www.kernel.org/doc/html/latest/admin-guide/LSM/LoadPin.html]
together with overlayfs, however commit a6518f "vfs: don't open real" introduces a regression.

(from loadpin.c):

        /* file_dentry sees through overlays */
        load_root = file_dentry(file)->d_sb;  (here, load_root->s_bdev is NULL and not the actual block device from the lower layer)

Questions:
* Maybe this is expected behavior and I am doing something wrong? Maybe there is some build- or mount option that
could fix the problem?
* If this really is a bug in overlayfs then I would be happy to try to fix it - however as I am not familiar with the code
I would very much appreciate if someone more knowledgeable could point me in the right direction.

Thanks,
Anders

