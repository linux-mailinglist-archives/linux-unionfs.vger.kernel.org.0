Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3747B1B38F8
	for <lists+linux-unionfs@lfdr.de>; Wed, 22 Apr 2020 09:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgDVH3q (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 22 Apr 2020 03:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726337AbgDVH3q (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 22 Apr 2020 03:29:46 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEFFC03C1A6
        for <linux-unionfs@vger.kernel.org>; Wed, 22 Apr 2020 00:29:45 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w2so766578edx.4
        for <linux-unionfs@vger.kernel.org>; Wed, 22 Apr 2020 00:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fUVQvoEuvZuztuJXSmW66Qx7hZMX6RsHLXVTpI674m4=;
        b=q+2g7tb8WgqJLhZtoW5AwZzI5JXbQUIZdIWb/7sviNoE55ZGHPuxaoeRrxjRRklON6
         Qq65gtYGsya7F5UdR4rrx7smt7esv+RqJ1rYTC6cxQssCo4TtdbWTL+zWQgikF4FVRm3
         2pSHMlKwqlanuJls0pbxXdC6X0iTm5vAFNw2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fUVQvoEuvZuztuJXSmW66Qx7hZMX6RsHLXVTpI674m4=;
        b=EIfVv0iNr5fnCNEvg4iDvabpIWtjoVTxBNooY0ZcN1MIMjbjO7wvm3t3X+nbr4pO9L
         XVy87sdK91xMGbvTd3YDbKVcDR96aulm7bbTbiIf/Rnyq1WD/p3WA7nCBn3gRV4fiEYJ
         Q3wF1orMgR8HOp3uXd0vmTZ1B30pvS19dERu5+cnEphCxYaY9sAH2MoXdqcAboER31PT
         VQN5elwOYnvltZl9mkjXjRhwKmTyTBKowi2GWPYG+7b+Ky3ts9zTlHwkiH7nk3m4Fw8h
         LB0QOgJ4dIgir5pQp18SeHFFjiSLmCjphkATiuB51k5XVi7R17c3wqeHJ1VZucR42yga
         g3qw==
X-Gm-Message-State: AGi0PubIUph2BC5bOB2FwvHVzXHS7XLNXtMdd59Pa3KBn/JuC/Ks+IoE
        joFfIEw5wX9thb8HKLHrCsIMXOSS8lRbsuib14/5dQ==
X-Google-Smtp-Source: APiQypLHIX0MuEtFubvMkRLGxwavqhCI7Pbepmp4Ixsm2zSXXZpLPje4Ot0w+BnWvvJpzbwB5vvQEMALhqrHa/xngMw=
X-Received: by 2002:a05:6402:1296:: with SMTP id w22mr13132599edv.364.1587540584639;
 Wed, 22 Apr 2020 00:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200422042843.4881-1-cgxu519@mykernel.net>
In-Reply-To: <20200422042843.4881-1-cgxu519@mykernel.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 22 Apr 2020 09:29:33 +0200
Message-ID: <CAJfpegu_t7Zdu2p64aJJ=W=+A6DTddszshk-ODiDjLqWqEwXaQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: sync dirty data when remounting to ro mode
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Apr 22, 2020 at 6:29 AM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> sync_filesystem() does not sync dirty data for readonly
> filesystem during umount, so before changing to readonly
> filesystem we should sync dirty data for data integrity.

Isn't the same true for ->put_super()?

Thanks,
Miklos
