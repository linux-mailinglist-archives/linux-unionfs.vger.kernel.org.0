Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDEB035638
	for <lists+linux-unionfs@lfdr.de>; Wed,  5 Jun 2019 07:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfFEFbP (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 5 Jun 2019 01:31:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:53942 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725268AbfFEFbO (ORCPT <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 5 Jun 2019 01:31:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3767AF51;
        Wed,  5 Jun 2019 05:31:13 +0000 (UTC)
Date:   Wed, 5 Jun 2019 07:31:14 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Cyril Hrubis <chrubis@suse.cz>, Murphy Zhou <xzhou@redhat.com>,
        Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [PATCH v2 2/2] fanotify06: Close all file descriptors of read
 events
Message-ID: <20190605053114.GA31796@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190604151035.6123-1-amir73il@gmail.com>
 <20190604151035.6123-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604151035.6123-2-amir73il@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi Amir,

thanks for your patchset, merged.

Kind regards,
Petr
