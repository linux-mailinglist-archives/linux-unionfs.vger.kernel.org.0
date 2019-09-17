Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4C1B48C1
	for <lists+linux-unionfs@lfdr.de>; Tue, 17 Sep 2019 10:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404625AbfIQIGf (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 17 Sep 2019 04:06:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34358 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731782AbfIQIGf (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 17 Sep 2019 04:06:35 -0400
Received: by mail-io1-f65.google.com with SMTP id q1so5520545ion.1
        for <linux-unionfs@vger.kernel.org>; Tue, 17 Sep 2019 01:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rOVqkumQN5CEwQ1QOe3+67O+QvL5+kQKUKOQklx5+IQ=;
        b=SxJoufJAOfbF2RwDS0pCxab33Nn6kfhsv5d+081atG/Zap3xQyZ8RMJbv9ScBPJ+Kg
         MY3eDxzP0ub05OZpG9cZFAzcTVrfvhcPOxtKaPa8Zf137LoyRB7t51pyJB1YMISWluGu
         OqLFXI6lucYPJeDumVte1G1rNzlCbyhhy9PqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rOVqkumQN5CEwQ1QOe3+67O+QvL5+kQKUKOQklx5+IQ=;
        b=IcK4pD2SQz1Y2e6H4CxJzK/2aSqSIwwshRZBuAQ8k7vI7u9KF6VVF+DYPF61xqlvau
         VWj9BRRzEss5kBTh+jG6lQUlHLvek9vs4sNDIH5kSJOr+A+tBkyqU7kIzuIH1YMID6Uw
         r/PbAVz/kD0UKuc6AE8GYl55aDEujuj1qE53y/b5gc1TKqg+7/+r1raRhf7rU9OXKMIR
         eDcikQMyzGrs481NTO813PUQYwJ91NcZbSEIZH7Fr2oUkUZ4I6Km1RwQRVmoAs/gpoP8
         vfIVF+dG893W6ckjSXHRY7Husx2NtBsqHEv10huu++yhwfAyBCjSRbxNCg2TEQt8p5z9
         bVmA==
X-Gm-Message-State: APjAAAVLnh1lHqmCEdImkAEKcJKb1xiTE1xOs3MFHsdoVpIoTd7x3mBT
        2cHAh2e2QXlXMD6oELcCgEVUNuC78P1VxYZJoD+aBQ==
X-Google-Smtp-Source: APXvYqzMAEWqw+AVnbnbUMQptM7jfWNqRQGF2rp1VDmddInyKkG2oE/7WqiAZRfqBTTXHBgZhMgO49ZaeqP3Xh1bh58=
X-Received: by 2002:a6b:bec6:: with SMTP id o189mr2143281iof.62.1568707594550;
 Tue, 17 Sep 2019 01:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <1568017796-27513-1-git-send-email-dingxiang@cmss.chinamobile.com>
In-Reply-To: <1568017796-27513-1-git-send-email-dingxiang@cmss.chinamobile.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Sep 2019 10:06:23 +0200
Message-ID: <CAJfpeguMAzej0OroDXLJsntx5R_XQWOcgSCZLFe=M8e4=A8CAA@mail.gmail.com>
Subject: Re: [PATCH] ovl: Fix dereferencing possible ERR_PTR()
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Sep 9, 2019 at 10:30 AM Ding Xiang
<dingxiang@cmss.chinamobile.com> wrote:
>
> if ovl_encode_real_fh() fails, no memory was allocated
> and the error in the error-valued pointer should be returned.

Applied, thanks.

Miklos
