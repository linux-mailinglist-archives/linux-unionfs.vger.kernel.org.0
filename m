Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A640C4E7548
	for <lists+linux-unionfs@lfdr.de>; Fri, 25 Mar 2022 15:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359297AbiCYOqT (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 25 Mar 2022 10:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359360AbiCYOqS (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 25 Mar 2022 10:46:18 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65191694B4
        for <linux-unionfs@vger.kernel.org>; Fri, 25 Mar 2022 07:44:43 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id p15so15812578ejc.7
        for <linux-unionfs@vger.kernel.org>; Fri, 25 Mar 2022 07:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=urG7wJTk7cfW0/ofN6lIZchUSJr5GfrgF/MGHRkbzfo=;
        b=0uRg1QezADBC/ILzIwNBoyspyE+c44iE0EV74wopWYwfcdaPLR0/iOlOqkaJD04K4m
         nJtf5lzxRfppUzB2TFGhB0T/LLpP1vPtgzoCPIboXORxHHDSaKop2nuyROd4PIkctcO3
         zrMS7kndvdEf+wg4lAsQ6NzHWdnzbk+X5DHQWuqQV10/4hgymFy2xthTzcsf5ipTTyyF
         qQ+kG14vRSkBK9VzKb5mdIzU8SiwKFpWBGZD7Kucer6GHbbYWaCBxAnLwJBzph+eIWbF
         hYsvNoNP617PWdyyv5a3ucJlptVhA7PJ8Sz5nZ0t0e81jkgL0KH88AOd+u8xVbtNpb86
         ry+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=urG7wJTk7cfW0/ofN6lIZchUSJr5GfrgF/MGHRkbzfo=;
        b=LIBOXTkWlc8yFbLm86DphyYj2PioyWgcqSRCSz2atJ7o+Ml/KO8wncphIXpAsaomAG
         BcXqRZ85a57SMZ5vfvR02q7JSr+rkMS60k8cY7YUoeSrq+Kjq7MkPu0k1r3HBSEdUt20
         84A5fhHaqfFPxG5BMlZsRKSH9WqofkocHIFNHgmqoSN7Cq/My+PPWpIcOv8kDb+pQtxi
         PoBFxi0Wy8cSyOf05FRA7VT21cu7GGhLWE3ZnSztWjHx3eSbGFDM1Lq72yvQ+zLtrkIz
         EKb/dC4cBpDkDL/KcE28GAtLFpq+AqRzaTYzS56p+Rnv5uIdsLt34cTjr1s2F8+7WFmK
         1mqA==
X-Gm-Message-State: AOAM533MjSnFj4is3PH0vfSzwbBTMWW1b19vW9t1FD63BQmqqcx2u91A
        mmvL9M6L9odz1PFhZVK/lG2EtKlrWORt3iflwn7Y
X-Google-Smtp-Source: ABdhPJwgb34PQtxZiwkjD2cnEoZdlxAKPwCbK/YF6t1Jz/L6Ghi/seTC93M+pUkxGnTVXRpSNFIKVtrTIKR6bm39X4w=
X-Received: by 2002:a17:907:7202:b0:6df:83a9:67d2 with SMTP id
 dr2-20020a170907720200b006df83a967d2mr11765091ejc.327.1648219481881; Fri, 25
 Mar 2022 07:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211117015806.2192263-2-dvander@google.com> <CISWB5OO4TSD.1YIUVDSVYSIF0@otso>
In-Reply-To: <CISWB5OO4TSD.1YIUVDSVYSIF0@otso>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 25 Mar 2022 10:44:31 -0400
Message-ID: <CAHC9VhRs95Be484hqDm8SW=dyYtziHSwo=7Eb5kwYxT1HxG7_Q@mail.gmail.com>
Subject: Re: [PATCH v19 1/4] Add flags option to get xattr method paired to __vfs_getxattr
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     dvander@google.com, Luca.Boccassi@microsoft.com,
        darrick.wong@oracle.com, dsterba@suse.com, hubcap@omnibond.com,
        jack@suse.cz, jlayton@kernel.org, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org, paulmoore@microsoft.com,
        salyzyn@android.com, sds@tycho.nsa.gov, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Fri, Mar 25, 2022 at 7:02 AM Luca Weiss <luca.weiss@fairphone.com> wrote:
>
> Hi David,
>
> this patch doesn't compile with CONFIG_SECURITY=n:
>
> ./include/linux/security.h: In function 'security_inode_need_killpriv':
> ./include/linux/security.h:893:40: error: passing argument 1 of 'cap_inode_need_killpriv' from incompatible pointer type [-Werror=incompatible-pointer-types]
>   893 |         return cap_inode_need_killpriv(dentry);
>       |                                        ^~~~~~
>       |                                        |
>       |                                        struct dentry *
> ./include/linux/security.h:153:52: note: expected 'struct user_namespace *' but argument is of type 'struct dentry *'
>   153 | int cap_inode_need_killpriv(struct user_namespace *mnt_userns,
>       |                             ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~
>
> I applied the patch on linux-next tag next-20220318, but the relevant part
> doesn't seem to have changed lately.

I believe David (and Google) have abandoned this patchset in favor of
another approach.  I'm possibly going to recycle some of the ideas in
this patchset for some future work, but the details are still TBD.

-- 
paul-moore.com
