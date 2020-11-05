Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4C42A750F
	for <lists+linux-unionfs@lfdr.de>; Thu,  5 Nov 2020 02:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbgKEBss (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 4 Nov 2020 20:48:48 -0500
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25335 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730735AbgKEBss (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 4 Nov 2020 20:48:48 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604540924; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=oUFQdX6tMj3Bqi9WES0mO8GNMztYJ7tW4FU0h5ho+81y5VD91o1Tv8F626zyFGpA7Khavcim+pw1Cm5ESUO8lg5D5GyXBWOoU+LK8tCMrOP6lyoA9tW0hNgYLGbWMsLsT9H/6dCEUPQ6ZJYtuapn3wVOg1GgOWGkDWFCEp47Jnw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1604540924; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Reply-To:Subject:To; 
        bh=B0oBgziSoXq+h+yLFYJMrbR9qoFhZ5sIyznLlQi0vW0=; 
        b=OMVv7RGrbCFYEllRFcGgxPLGGAozfvwHzMFB2PSl3Z4IYfGsi8laezUE5fm+maYNlB6PdBU8eBzy+F2ySV74297yP4tRR9oiWNLj84c2wI+YcsuVBTSOkJiGl8MRTP/QJ30B8QKz/LkkR388gbENShpgp3yYJStnOJ7XdApjeiU=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604540924;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=B0oBgziSoXq+h+yLFYJMrbR9qoFhZ5sIyznLlQi0vW0=;
        b=Zpv3lNuW1FOOLvqOX4QFxnW96uiGflqQz6QtetF7n9wgifPJKfrMy7WLojrvk6yS
        WzaQ8L5hoZJVvb4ZpAaDqqSOnAEzDw97hXDEwP5orN1s7f6AOHctD3Q1+/QlxlxJonc
        tGFQdzXskkSxP2G/0D5vKxu60PqMiFuLV+N84WyA=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1604540922151665.6650297799029; Thu, 5 Nov 2020 09:48:42 +0800 (CST)
Date:   Thu, 05 Nov 2020 09:48:42 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "linux-unionfs" <linux-unionfs@vger.kernel.org>
Cc:     "cgxu519" <cgxu519@mykernel.net>
Message-ID: <17596177926.d559c8b77834.5766617584799741474@mykernel.net>
In-Reply-To: 
Subject: a question about opening file
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hello,
 
I have a question about opening file of underlying filesystem in overlayfs,

why we use overlayfs' path(vfsmount/dentry) struct for underlying fs' file  

in ovl_open_realfile()?  Is it by design?


Thanks,
Chengguang
