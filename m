Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA22134637
	for <lists+linux-unionfs@lfdr.de>; Wed,  8 Jan 2020 16:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgAHP37 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 8 Jan 2020 10:29:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36252 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgAHP37 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 8 Jan 2020 10:29:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id a6so1274020plm.3
        for <linux-unionfs@vger.kernel.org>; Wed, 08 Jan 2020 07:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bsFLaRVwJl1muQaHc6qol6Zx8YuPcAvjJrLvsxuYd5Q=;
        b=FXeABJQYBlgzNgKsBkngpFn65SgXi2QQ2pBtQtWefujHnhtGMw/f7NX3me6abpfuj/
         eyGvXo2grjfnXzjs3GRuHL7IM+WXuJFdHFvMpjIwV+JJJ5LB/o96RpjK9JsFLDRICifR
         GW/++CGS/gTtQCObn1R5t6KG+DFReqkJEVlLc17XK6/mJH/lCWeFCS28H9aPQVMmU9pD
         mC/xSy4bsf3d2jAcG42pzKm9UnacvhCGpOlWhx/oG6aoNMBRRIG+ugXVhqG5sUEMfPW6
         LOYI+uW2bTozP90NE0v5Vu+AK8w8vb6mJ5LZNE7x/OXHWdyzjjgXlUJn/BQQpiwEe+Yp
         RVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bsFLaRVwJl1muQaHc6qol6Zx8YuPcAvjJrLvsxuYd5Q=;
        b=mbM9h5Wi12BX79U8/HgBBFul5nzUgJ/fkxbW2jWw3CFonGY1K08wHrBWh/UXZeFp/m
         aURPYkddqrGjnH5Ww74mmNCSu5+iweVstglnt0sc/f8jpnLP4H8qeqL685HNhCPuyE5D
         yVOI1QJC2gQFMwqbNm3ea4FPtwimDV1H7oY8b2F1lx2OaemQuSFKvLG9onRg2He5tOW0
         PS+fV9ALRPZa9RBHalqPlSC+/vIxogXbdH5QE2rTC7DUEc5LGzr1utmAthU0QCTRMDoL
         G1ILGYrH/xxoUCsF+7Q/ol1w0iO4yD12FzviICaYfHyaqZFaqJZB7cG952HiphrVM1ky
         qthw==
X-Gm-Message-State: APjAAAXMCVDi9AQ4q81mW4bPKYnR5YvA/aF8rmN75mHDor6q/AP6+Ao8
        iFcrBJDVozyiE1EgBK4e3rbrxQ==
X-Google-Smtp-Source: APXvYqzqtx8ON2XpQzXfz34PxP9O2YpQNraj6CkwoDfKjWPXTjYS3Lu8a/KI3UWwytfXtjnV6NYEGw==
X-Received: by 2002:a17:90a:aa81:: with SMTP id l1mr5007054pjq.62.1578497397577;
        Wed, 08 Jan 2020 07:29:57 -0800 (PST)
Received: from cisco ([2601:282:b02:8120:8cce:f495:841a:bcdb])
        by smtp.gmail.com with ESMTPSA id j28sm4069043pgb.36.2020.01.08.07.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 07:29:56 -0800 (PST)
Date:   Wed, 8 Jan 2020 08:29:56 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        StuartIanNaylor <rolyantrauts@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        kmxz <kxzkxz7139@gmail.com>,
        James.Bottomley@HansenPartnership.com
Subject: Re: OverlaysFS offline tools
Message-ID: <20200108152956.GD1169@cisco>
References: <CAOQ4uxjFC81hikgg0WaF0Z3Mxkk3iDakKx2Ttuhp_L_2Tnc6xQ@mail.gmail.com>
 <20200108140611.GA1995@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108140611.GA1995@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Jan 08, 2020 at 09:06:11AM -0500, Vivek Goyal wrote:
> - shiftfs
> 
>   As of now they are relying on doing chown of the image but will really
>   like to see the ability to shift uid/gids using shiftfs or using
>   VFS layer solution.

I think James is working on this:

https://lore.kernel.org/linux-fsdevel/20200104203946.27914-1-James.Bottomley@HansenPartnership.com/

Tycho
