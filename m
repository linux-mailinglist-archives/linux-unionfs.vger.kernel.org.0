Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB1EE1DCC
	for <lists+linux-unionfs@lfdr.de>; Wed, 23 Oct 2019 16:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732586AbfJWONG (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 23 Oct 2019 10:13:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36565 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732229AbfJWONG (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 23 Oct 2019 10:13:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so13036642pfr.3
        for <linux-unionfs@vger.kernel.org>; Wed, 23 Oct 2019 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=99Meb/NHEeKKNcKVEpi7PqCxKLzU8P8+91Q4MKWh7cI=;
        b=lf1+OUQSg17r/yrL9lhjMmeTO5DASONcrqjjSGZuqTc8BE+uYEPOuHyZa2AZfnTMdA
         18yU5/a04N+Bl72T6QW+pDByPxPvZESf3X7iQlLiv8ZgA0UZCeCKnH8JYcuET7UkA2mO
         uKSqTsby9YseGjPDwhxq5FHy0gWrt6bEWMVWP746cLMFPfnGaZ3bqDHXH5MH89t2/jbR
         XO3UsLZ7THwebT3ucHj/1Ls4zM/U6/k5RHUJcs9looZxzF1Di1q9A3dWTTRVxXoCpTbq
         EaD0ngSR2QEeetKPHUG/6yxB8HRtOYglIpjcbojDaFh0bFUL9doMquCNmp7ZyOj+HH4M
         KJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=99Meb/NHEeKKNcKVEpi7PqCxKLzU8P8+91Q4MKWh7cI=;
        b=c5H5B1aJ2/9tIJj6Ytns6PBiDtuLwa0WwrP87Yyio+3bdm7cRfGaXooEY4DafrIdxo
         oBJALfjyU2Ud4D8uVhN0XD3vT7FDtwfsDJtdL3zC9OWHyR6yZQDRnQ/AjVCdb0udeKbw
         RbDPm2oumM9PvGzbpjhqn9MwnoHKjn9SW0bOpn0Pz7DqP9rWy58I94tziWH1S4r306hZ
         zYxkhfhv4MCjuBCILgOBzPLYfkfa+2v82HuodImu5NSMH/ZhkE3eDPR9nDgV1e4F8pEX
         KapmpaJIoRUeh/u7BkRyrrNiEfEdvM1gMYQ4vIhlgJ8mrX1X93ynHOq4mUZa/fsicf9S
         KBPw==
X-Gm-Message-State: APjAAAXQ1wl/v9bEvXI3IiUJ4jRhaHz7sIn9jmYRCHNAm+MecFGhm8n9
        r0wEG2+qdxGvUEGhmlrEH8hK2Q==
X-Google-Smtp-Source: APXvYqxXV6ehSun4jHHdfCA+e8oz0034JMZdHeaJPsB5n71nk/2n4r9au+p2qiLCcxP5Xq6XX+glrQ==
X-Received: by 2002:aa7:8b16:: with SMTP id f22mr10892476pfd.17.1571839985385;
        Wed, 23 Oct 2019 07:13:05 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id q13sm25230503pjq.0.2019.10.23.07.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 07:13:04 -0700 (PDT)
Subject: Re: [PATCH v14 0/5] overlayfs override_creds=off & nested get xattr
 fix
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20191022204453.97058-1-salyzyn@android.com>
 <CAOQ4uxjFqq0zA7V3A9s0h2om7AWY5AT-2sQ4z2G0Vk2gtf1M=w@mail.gmail.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <c0eb1b6e-65f6-9d38-64b9-333f3e82905a@android.com>
Date:   Wed, 23 Oct 2019 07:13:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxjFqq0zA7V3A9s0h2om7AWY5AT-2sQ4z2G0Vk2gtf1M=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On 10/22/19 11:54 PM, Amir Goldstein wrote:
> On Tue, Oct 22, 2019 at 11:45 PM Mark Salyzyn <salyzyn@android.com> wrote:
>> Patch series:
>>
>> Mark Salyzyn (5):
>>    Add flags option to get xattr method paired to __vfs_getxattr
>>    overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh
>>    overlayfs: handle XATTR_NOSECURITY flag for get xattr method
>>    overlayfs: internal getxattr operations without sepolicy checking
>>    overlayfs: override_creds=off option bypass creator_cred
>>
>> The first four patches address fundamental security issues that should
>> be solved regardless of the override_creds=off feature.
>>
>> The fifth adds the feature depends on these other fixes.
>>
>> By default, all access to the upper, lower and work directories is the
>> recorded mounter's MAC and DAC credentials.  The incoming accesses are
>> checked against the caller's credentials.
>>
>> If the principles of least privilege are applied for sepolicy, the
>> mounter's credentials might not overlap the credentials of the caller's
>> when accessing the overlayfs filesystem.  For example, a file that a
>> lower DAC privileged caller can execute, is MAC denied to the
>> generally higher DAC privileged mounter, to prevent an attack vector.
>>
>> We add the option to turn off override_creds in the mount options; all
>> subsequent operations after mount on the filesystem will be only the
>> caller's credentials.  The module boolean parameter and mount option
>> override_creds is also added as a presence check for this "feature",
>> existence of /sys/module/overlay/parameters/overlay_creds
>>
>> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
>> Cc: Miklos Szeredi <miklos@szeredi.hu>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Eric W. Biederman <ebiederm@xmission.com>
>> Cc: Amir Goldstein <amir73il@gmail.com>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Stephen Smalley <sds@tycho.nsa.gov>
>> Cc: linux-unionfs@vger.kernel.org
>> Cc: linux-doc@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>>
>> ---
>> v14:
>> - Rejoin, rebase and a few adjustments.
>>
>> v13:
>> - Pull out first patch and try to get it in alone feedback, some
>>    Acks, and then <crickets> because people forgot why we were doing i.
> Mark,
>
> I do not see the first patch on fsdevel
> and I am confused from all the suggested APIs
> I recall Christoph's comment on v8 for not using xattr_gs_args
> and just adding flags to existing get() method.
> I agree to that comment.

As already responded, third (?) patch version was like that, gregkh@ 
said it passed the limit for number of arguments, is looking a bit silly 
(my paraphrase), and that it should be passed as a structure. Two others 
agreed. We gained because both set and get use the same structure after 
this change (this allows a simplified read-modify-write cycle).

We will need a quorum on this, 3 (structure) to 2 (flag) now (but really 
basically between Greg and Christoph?). Coding style issue: Add a flag, 
or switch to a common xattr argument  structure?

> I remember asking - don't remember the answer -
> do you have any testing for this feature?
Yes, on an unnamed 4.19-based and mainline-based Android and virtual 
cuttlefish product ... which was critically unworkable without this 
patch series.
> I have a WIP branch to run unionmount-testsuite not as root,
> which is a start, but I didn't get to finish the work.
> Let me know if you want to take up this work.
Please refer it in private email to me, no guarantees, my cycles are so 
sparse right now that it took a month to respin this patch series to 
upstream. If I can make it test on Android with overlayfs activated, big 
gain.
>
> Thanks,
> Amir.


