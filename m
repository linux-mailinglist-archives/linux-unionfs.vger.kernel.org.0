Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63B934FBC5
	for <lists+linux-unionfs@lfdr.de>; Sun, 23 Jun 2019 15:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfFWNZL (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 23 Jun 2019 09:25:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42368 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfFWNZL (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 23 Jun 2019 09:25:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so5331289plb.9;
        Sun, 23 Jun 2019 06:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V/UgQ7IMf+CX7qQwZbfPZ1u2EZn+QTDW1KliWLWfses=;
        b=njhLsK+daBHxoJ4CP97xoheOwArWouHlN2tbRfJnVnGrx37fFcPlVJKgLZfyrX2dRo
         OoakAE9ScYhrSMlYnZqrDQUQHHgQ478LWxCdEaAM9nXBfXI8mQXdPbVrm37VVzeA7WQ4
         +HQROstnIyjk/9iQz4skLG06RdKNM/B4v8+/1mJUuWOVtzOHUKJaMfnv7n3Olw4H5Vjd
         Of3q41gqqg3Ru/8po0Vei9NjkXChbNjfWNXinArP846EO9U2n9DxnwEublyr8WUB0iCW
         3M55O9yycv0MExye3R+6aVYMzvExBEZ/FmaH0+nmsuECEN+rfBPBc/3CAkEGMlLqgs6I
         5ETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V/UgQ7IMf+CX7qQwZbfPZ1u2EZn+QTDW1KliWLWfses=;
        b=C3tUn+W1tync5S1viOenPGzLN6VplTd2jXyoeyKGZxSnbuBPOhwiQZPJDva4/dSqbo
         dncWXAlZwvEUzXeHlSt1beFPbcdj8tV+4uf/x9oqE71gYHjr8GXwbMrHnpkhO0U3Jv52
         U/vh8xZycKJm/lnOeMie2iOGcEMRZNbDCJw44RUCgGn/0UVkSCLp+AO9ALDCUTR4D3ib
         iXdOk5Fx7FP1xJURu4ZgqOFDGJfIYKdOq1/8h76anypVYvmPLpvOpfcJ6b7f5cXrxtmn
         bgEVeKFkYTBtZXwyLCxrh5fbisWgtE7hoOyIHzgGVXTdje6fd3z+IgCjCDJgqNJFShTJ
         ewRg==
X-Gm-Message-State: APjAAAVwbcGZUgiK2bzQ8s+QgJwwAEpYBBjGLPXoI8CcvBF/55aT+uak
        Hwhom5IsHsd/8Y8GcH1Fkz0wen+Y
X-Google-Smtp-Source: APXvYqzaDg3nS2EeBqHcrTtXIh/QjPSqISbYAsGCHAogGSMUXrJKo/x5j2tZKl4TuhMN4IzbwlHi4w==
X-Received: by 2002:a17:902:b7c1:: with SMTP id v1mr49462136plz.85.1561296310741;
        Sun, 23 Jun 2019 06:25:10 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id p67sm12140053pfg.124.2019.06.23.06.25.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 06:25:09 -0700 (PDT)
Date:   Sun, 23 Jun 2019 21:25:03 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] overlay/061: remove from auto and quick groups
Message-ID: <20190623132503.GM15846@desktop>
References: <20190618064355.29398-1-amir73il@gmail.com>
 <CAOQ4uxiDZjr2+EyjWtimjLxFHrMN13K4N5Aw+9BACPmx+2W6Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiDZjr2+EyjWtimjLxFHrMN13K4N5Aw+9BACPmx+2W6Kg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Jun 19, 2019 at 01:47:01PM +0300, Amir Goldstein wrote:
> >
> > I did not observe any regressing with check -overlay -g generic/quick
> > compared to check -g generic/quick on xfs with recent kernel.
> > I did not test all filesystems and -g generic/auto with recent kernel,
> > but I am not aware of any expected failures specific for -overlay run
> > on generic tests.
> >
> 
> Oh! I was lying. I *did* notice two regressions with
> check -overlay -g generic/quick (compared to xfs),
> so I posted fixes for them:
> 
> 1) generic/504 is failing with -overlay on master.
> 
> This kernel fix commit is on linux-next:
> 6ef048fd5955 locks: eliminate false positive conflicts for write lease
> 
> 2) generic/555 (was just merged this week) is failing with
> -overlay on master.
> 
> This kernel fix commit is on Miklos' overlayfs-next:
> 941d935ac763 ovl: fix wrong flags check in FS_IOC_FS[SG]ETXATTR ioctls

Thanks a lot for the detailed information!

Eryu
