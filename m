Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5397520F
	for <lists+linux-unionfs@lfdr.de>; Thu, 25 Jul 2019 17:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbfGYPDQ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 25 Jul 2019 11:03:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40826 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387422AbfGYPDQ (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 25 Jul 2019 11:03:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so23194100pgj.7
        for <linux-unionfs@vger.kernel.org>; Thu, 25 Jul 2019 08:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Z2st2E/k1wPw0kwagbLifDOpfVRIGVH2FYBnMGx+2mA=;
        b=ZR5bB87b86BCq25/80OQysgpZBaCLzLLAQq25cYja31QimT+CI44YNOXRoF1DqvdaZ
         uvVu3L8WhtJSKo3U4uyIqjP/mjKPCYtnEWi0Biz7vTU++WFO8ihM+HMg3e0nkmQf/uj+
         aFE9F0SdFUlzMjSVRskpLLnqsyhjAn5LL59132CoZ2koyIprjOPeVRGfPpK/e+G1vjAT
         e9mP5lYvLmZ7hyGaUqh+k+7gTrXn6fRUA/0mUD6P4VZQwZ4inTq7W4XGBR1WhIr0Bjdi
         1m3B24vCMJe94+R89WrrCsG4kvvStdtyrVryQ8wjGoSYgh9YbwDpv52deH1sj8XPlzxy
         stRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Z2st2E/k1wPw0kwagbLifDOpfVRIGVH2FYBnMGx+2mA=;
        b=MbjTkhJqJ/cGoJplgT0Oqzycn+0tEcjZ24HgGPF/Lj00cBkKb1Z3GhUxdJZGucwbuW
         B9dVEPsqhBHsk/v4P3OQFSlFIzibyB/UdvTwq6+JG2NBAApi6C/T4wBSoRGQtqLY7as5
         5914MbNaSKFRWaJMKZC0/e5TSoki56XE2A96HPnRe/WUEEOCDzVCWNHw2tNFpOMsNJAz
         IEGiT2dU6wymePSnN/Un3hcirA/sImIJZqxnvuduMiBTxGPYOnUE5rlC344TAZ1LySaq
         usDHNFceBMjFo/8nkVNKv7O0SMFmO9B4QGCBvHfdP53MQZMDSxZScKqV6o4LGepe0daS
         lgPA==
X-Gm-Message-State: APjAAAUD8YiMLOTdnA5DEAvVMstjjDPJDSg2BXBUb/WvTv66zcXMhf3C
        ZZKS47fsOoG0useBF3Q6cq8=
X-Google-Smtp-Source: APXvYqxLRe5H+SjbdSL/NrxwJNv/WOC5qyNYRufG2NOuFCPS4O5d+Nu8GUyHogcJJjI52tumYTtb1Q==
X-Received: by 2002:a63:c748:: with SMTP id v8mr55423006pgg.418.1564066994913;
        Thu, 25 Jul 2019 08:03:14 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id e124sm81017049pfh.181.2019.07.25.08.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 08:03:14 -0700 (PDT)
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
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <af254162-10bf-1fc5-2286-8d002a287400@android.com>
Date:   Thu, 25 Jul 2019 08:03:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxjizC1RhmLe3qmfASk2M-Y+QEiyLL1yJXa4zXAEby7Tig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On 7/24/19 10:48 PM, Amir Goldstein wrote:
> On Wed, Jul 24, 2019 at 10:57 PM Mark Salyzyn <salyzyn@android.com> wrote:
>> Because of the overlayfs getxattr recursion, the incoming inode fails
>> to update the selinux sid resulting in avc denials being reported
>> against a target context of u:object_r:unlabeled:s0.
> This description is too brief for me to understand the root problem.
> What's wring with the overlayfs getxattr recursion w.r.t the selinux
> security model?

__vfs_getxattr (the way the security layer acquires the target sid 
without recursing back to security to check the access permissions) 
calls get xattr method, which in overlayfs calls vfs_getxattr on the 
lower layer (which then recurses back to security to check permissions) 
and reports back -EACCES if there was a denial (which is OK) and _no_ 
sid copied to caller's inode security data, bubbles back to the security 
layer caller, which reports an invalid avc: message for 
u:object_r:unlabeled:s0 (the uninitialized sid instead of the sid for 
the lower filesystem target). The blocked access is 100% valid, it is 
supposed to be blocked. This does however result in a cosmetic issue 
that makes it impossible to use audit2allow to construct a rule that 
would be usable to fix the access problem.

This problem would exist for any (in tree or out-of-tree) union 
filesystems that need to reflect the __vfs_getxattr call into a 
__vfs_getxattr call to the underlying filesystem.

>
> Please give an example of your unprivileged mounter use case
> to explain.

The mounter merely does not have access to the targets in one of the 
referenced filesystems (for override creds = on)

In Android would be init, it does not have access to a subset of 
u:object_r:*_exec:s0 and u::objects_r:vendor*:s0 labels. Based on a need 
to access basis.

This gets worse if we add override creds = off, because the multitude of 
callers could be denied access, and rightfully so, and we would have no 
clue how to construct rules to grant them permissions using standard 
tools like audit2allow.

I will figure out how to explain this in the commit message ... but do 
tell me if I did not 'connect' you to the underlying problem so I can 
make it clear to _everyone_.

>
> CC Vivek because I could really never understand all this.
>
>> Solution is to add a _get xattr method that calls the __vfs_getxattr
>> handler so that the context can be read in, rather than being denied
>> with an -EACCES when vfs_getxattr handler is called.
>> . . .
>> @@ -972,6 +989,7 @@ static const struct xattr_handler ovl_own_xattr_handler = {
>>   static const struct xattr_handler ovl_other_xattr_handler = {
>>          .prefix = "", /* catch all */
>>          .get = ovl_other_xattr_get,
>> +       .__get = __ovl_other_xattr_get,
>>          .set = ovl_other_xattr_set,
>>   };
>>
>
> Not very professional of me to comment on the proposed solution
> without understanding the problem, but my nose says this cannot
> be the right solution and if it is, then you better find a much better
> name for the API then __get() and document it properly.

Yes __get (instead of the existing get which checks sepolicy) was my 
idea. get_wo_security was a close alternative.

We worked through 5 "solutions", this one privately appeared to please 
the security folks. In fact the solution was their suggestion because 
they noticed that __vfs_getxattr was meant to bypass sepolicy checking, 
yet when nested through overlayfs, it called vfs_getxattr for the lower 
filesystems and blocked necessary content (sid actually) from the upper 
call in order to properly log the denial. I had originally copied just 
the sid to the upper caller by adding layering violations that creeped 
them out ;-/

