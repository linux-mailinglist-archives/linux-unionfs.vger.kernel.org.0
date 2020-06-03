Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D527D1ECA3C
	for <lists+linux-unionfs@lfdr.de>; Wed,  3 Jun 2020 09:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgFCHNZ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 3 Jun 2020 03:13:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5779 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725275AbgFCHNY (ORCPT <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 3 Jun 2020 03:13:24 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C6368A1AD3E30B5E4244;
        Wed,  3 Jun 2020 15:13:21 +0800 (CST)
Received: from [127.0.0.1] (10.166.212.218) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 3 Jun 2020
 15:13:19 +0800
Subject: Re: [PATCH v2 0/3] overlayfs: Do not check metacopy in
 ovl_get_inode()
To:     Vivek Goyal <vgoyal@redhat.com>, <amir73il@gmail.com>,
        <miklos@szeredi.hu>
CC:     <linux-unionfs@vger.kernel.org>
References: <20200601155652.17486-1-vgoyal@redhat.com>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <a2f863af-6674-e148-181c-4fb5aca68885@huawei.com>
Date:   Wed, 3 Jun 2020 15:13:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200601155652.17486-1-vgoyal@redhat.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.212.218]
X-CFilter-Loop: Reflected
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Try repeat this testcase for about half of a day. Wont happen again.

Thanks,

�� 2020/6/1 23:56, Vivek Goyal д��:
> Hi,
> 
> This is V2 of the patches. Took care of few suggestions from Amir.
> 
> This series tries to implement Amir's suggestion of initializing
> OVL_UPPERDATA in callers of ovl_get_inode() and move checking of
> metacopy xattr out of ovl_get_inode().
> 
> It also has to patches to cleanup metacopy logic a bit and make it
> little more readable and understandable in ovl_lookup().
> 
> yangerkun, can you please make sure if this patch series fixes the
> xfstest issue you were facing once in a while.
> 
> Vivek Goyal (3):
>    overlayfs: Simplify setting of origin for index lookup
>    overlayfs: ovl_lookup(): Use only uppermetacopy state
>    overlayfs: Initialize OVL_UPPERDATA in ovl_lookup()
> 
>   fs/overlayfs/dir.c   |  2 +
>   fs/overlayfs/inode.c | 11 +-----
>   fs/overlayfs/namei.c | 89 ++++++++++++++++++++++++--------------------
>   3 files changed, 51 insertions(+), 51 deletions(-)
> 

