Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50D01753C6
	for <lists+linux-unionfs@lfdr.de>; Thu, 25 Jul 2019 18:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389583AbfGYQWD (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 25 Jul 2019 12:22:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38173 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389405AbfGYQWD (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 25 Jul 2019 12:22:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id f5so14471514pgu.5
        for <linux-unionfs@vger.kernel.org>; Thu, 25 Jul 2019 09:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=u6QQcRyveiHvf3n/ThuMriSU0sNCDtWoFYIj3lHyjPc=;
        b=CpMliZ0FSoXb2RETeJwlRkpfpP5ANESfneRGLLoUYWt72jPPZjT01/XXtyIWKYQi2I
         /vPr5aa55CowmdBKdDmZnp+kKidKGuV4Rz1QOlFCt+igK4RjI3L0uxdD+7xIAhdiz/yY
         FqoY3lkXfPDRHfPYU3kh2DQbLeZN17iu7WFvXdsGVEGP7LV9vFzqes+jUwLT2wKZg6wR
         d5QDB2K6qcNahCZsuEU1+7rAQN87MIMj+Vvw7dv4CnsMzkrS/FC9xoWPyyYK4RwmOkr+
         1H75dc+nwx09lB0/w+WwmsXf7kRoeVS00KYk9831vCwtwPt8NyRBH3RpSy9cv826fGJ9
         kkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=u6QQcRyveiHvf3n/ThuMriSU0sNCDtWoFYIj3lHyjPc=;
        b=J8s+RcXnTcCrY1wiMFV9ejZMoWmvJ+0L5LYCc1EalpUKIt+oTjltgldOd7E7TMrCud
         RzvRkBAI508M48HAkn4MnBVB+D1OrZDNfR4YwQh9cmE9w+rJWX+bHICgJd+mfk7qb+Ch
         nUl0a9vgMVf2wVcSQwAfx5ztzqmVxTWbNLr3bAp5ScyCRk6f9sa1ovDULQ7nD2G+dZrR
         Mszew11hi8mgkrWHY8zIAD8AY/x8SeNFBFJ8DLlKSGho08ATvsDojwAF59Why5aDH9Vk
         +GhMN+hr+BR0OHzI7WlZRT1TC9WZalLH1ulCTvi7d44oXR7hIHklwP2DSLu0e+Ho+FHz
         I8zg==
X-Gm-Message-State: APjAAAWAAW/zkn3JR+IWaiBsK3+c4/cyoTTBs9To96BCAuwllyHVxsXq
        oIwqdRRGURIJOz/g2FNHu/OxpsTX
X-Google-Smtp-Source: APXvYqyDYkqZYK92OGiQNqG44X4PD+TGUbMCsizfqySvfVVpij6rSdgZ97tMI46WWzy0xO2+627wDw==
X-Received: by 2002:a65:4103:: with SMTP id w3mr71316031pgp.1.1564071722348;
        Thu, 25 Jul 2019 09:22:02 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id z19sm43072163pgv.35.2019.07.25.09.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:22:01 -0700 (PDT)
Subject: Re: [PATCH v10 3/5] overlayfs: add __get xattr method
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org
References: <20190724195719.218307-1-salyzyn@android.com>
 <20190724195719.218307-4-salyzyn@android.com>
 <CAOQ4uxjizC1RhmLe3qmfASk2M-Y+QEiyLL1yJXa4zXAEby7Tig@mail.gmail.com>
 <af254162-10bf-1fc5-2286-8d002a287400@android.com>
 <CAOQ4uxi5S9HTx+wR1U_8vQ-6nyCozykWBZbZwiHhnXBGhXRz8Q@mail.gmail.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <35b70147-25ad-4c29-3972-418ebee5e7b8@android.com>
Date:   Thu, 25 Jul 2019 09:22:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxi5S9HTx+wR1U_8vQ-6nyCozykWBZbZwiHhnXBGhXRz8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On 7/25/19 8:43 AM, Amir Goldstein wrote:
> On Thu, Jul 25, 2019 at 6:03 PM Mark Salyzyn <salyzyn@android.com> wrote:
>> On 7/24/19 10:48 PM, Amir Goldstein wrote:
>>> On Wed, Jul 24, 2019 at 10:57 PM Mark Salyzyn <salyzyn@android.com> wrote:
>>>> Because of the overlayfs getxattr recursion, the incoming inode fails
>>>> to update the selinux sid resulting in avc denials being reported
>>>> against a target context of u:object_r:unlabeled:s0.
>>> This description is too brief for me to understand the root problem.
>>> What's wring with the overlayfs getxattr recursion w.r.t the selinux
>>> security model?
>> __vfs_getxattr (the way the security layer acquires the target sid
>> without recursing back to security to check the access permissions)
>> calls get xattr method, which in overlayfs calls vfs_getxattr on the
>> lower layer (which then recurses back to security to check permissions)
>> and reports back -EACCES if there was a denial (which is OK) and _no_
>> sid copied to caller's inode security data, bubbles back to the security
>> layer caller, which reports an invalid avc: message for
>> u:object_r:unlabeled:s0 (the uninitialized sid instead of the sid for
>> the lower filesystem target). The blocked access is 100% valid, it is
>> supposed to be blocked. This does however result in a cosmetic issue
>> that makes it impossible to use audit2allow to construct a rule that
>> would be usable to fix the access problem.
>>
> Ahhh you are talking about getting the security.selinux.* xattrs?
> I was under the impression (Vivek please correct me if I wrong)
> that overlayfs objects cannot have individual security labels and

They can, and we _need_ them for Android's use cases, upper and lower 
filesystems.

Some (most?) union filesystems (like Android's sdcardfs) set sepolicy 
from the mount options, we did not need this adjustment there of course.

> the only way to label overlayfs objects is by mount options on the
> entire mount? Or is this just for lower layer objects?
>
> Anyway, the API I would go for is adding a @flags argument to
> get() which can take XATTR_NOSECURITY akin to
> FMODE_NONOTIFY, GFP_NOFS, meant to avoid recursions.

I do like it better (with the following 7 stages of grief below), best 
for the future.

The change in this handler's API will affect all filesystem drivers 
(well, my change affects the ABI, so it is not as-if I saved the world 
from a module recompile) touching all filesystem sources with an even 
larger audience of stakeholders. Larger audience of stakeholders, the 
harder to get the change in ;-/. This is also concerning since I would 
like this change to go to stable 4.4, 4.9, 4.14 and 4.19 where this 
regression got introduced. I can either craft specific stable patches or 
just let it go and deal with them in the android-common distributions 
rather than seeking stable merged down. ABI/API breaks are a problem for 
stable anyway ...

-- Mark

