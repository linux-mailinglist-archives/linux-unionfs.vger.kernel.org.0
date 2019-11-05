Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6EF1F0115
	for <lists+linux-unionfs@lfdr.de>; Tue,  5 Nov 2019 16:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389784AbfKEPUO (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 5 Nov 2019 10:20:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40024 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389339AbfKEPUO (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 5 Nov 2019 10:20:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id r4so15679130pfl.7
        for <linux-unionfs@vger.kernel.org>; Tue, 05 Nov 2019 07:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4knTl1jsJDuMainkSHY+5ZG6p+2SnQH1xWJ5/mQLZcc=;
        b=DjIPeMXW32l5fRqhcF/hEw9KGRzv0na04clJGjRNUHPMDnhcD3TsmsKSwyjh+w/6sQ
         PTAqM9sTWDUSi6tZrUkRd13QgbMTNVRPQlqdW+1hhLVpk9FmJHl8J6cSMn/Mway2kCWz
         MJm6ZtryFrevQ+LCFRayk+JyZnFlnyxIgQZD2+1CxTk2zLzkpHX0WenqGSA5OAR0vNLJ
         vGJ8Nob1RDlf/duriZT/QO02e/vLPDCDiLWW63O8ik1SD8GufmRrU1jjAolUO1dJiToY
         jI2ZBWJGQxv6FDn+WE71NE1f+THhy/OGWe2P+plmcPg7d6M/DmrAToeVoM6Dzo/qyyJR
         LmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4knTl1jsJDuMainkSHY+5ZG6p+2SnQH1xWJ5/mQLZcc=;
        b=rSu7DmKcmZOJPpl12dQieEe+Y6LCrnFikVR7TaRie0cgijuL3Oc3UtTptFvtoJJyVb
         QdNaKneWIKhi9YJIHaj9vZp29g+yP4jgTWFE76I46LJFLVjGDF7gxtWbEMko4GwF705u
         HKvi1Y7/qqn8vQnka6vqGPEcsDiKxvGT+dQRx4alXChaBV3wMw6pwTGHmbh1MrsuCUcU
         F/4UJOaCjzXWDAqpGnTJwBKTHbjeWmW0Ol0KyVvQd5P5bu+FIcFUkOpRQ9AJ7hbzqwK8
         g7VkinE5y02JpDnySdxbI0kAdf9hJMaxk0Aa5JmQfSW1guM9/gKSh3+MSPCMnFi3fmCI
         OtCw==
X-Gm-Message-State: APjAAAVayuHnskzC0iz9xnmKJzmUQ5s+XDO6SURsnAX0z9d4QVwHBdU/
        cKo3Y/kIBg33edeHq3rnPyBEsQ==
X-Google-Smtp-Source: APXvYqwngaEbIGV2C3ll19WybcLW+UHBVqY0ruQKQmcGOlj8LAdvhzyLZLrbbYkv25c+m4rL0C7yWw==
X-Received: by 2002:a62:1dc6:: with SMTP id d189mr20322264pfd.100.1572967212046;
        Tue, 05 Nov 2019 07:20:12 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id h8sm149633pjp.1.2019.11.05.07.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 07:20:11 -0800 (PST)
Subject: Re: [PATCH v15 0/4] overlayfs override_creds=off & nested get xattr
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
        linux-doc@vger.kernel.org
References: <20191104215253.141818-1-salyzyn@android.com>
 <CAOQ4uxhoozGgxYmucFpFx8N=b4x9H3sfp60TNzf0dmU9eQi2UQ@mail.gmail.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <97c4108f-3a9b-e58b-56e0-dfe2642cc1f5@android.com>
Date:   Tue, 5 Nov 2019 07:20:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxhoozGgxYmucFpFx8N=b4x9H3sfp60TNzf0dmU9eQi2UQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On 11/4/19 11:56 PM, Amir Goldstein wrote:
> On Mon, Nov 4, 2019 at 11:53 PM Mark Salyzyn <salyzyn@android.com> wrote:
>> Patch series:
>>
>> Mark Salyzyn (4):
>>    Add flags option to get xattr method paired to __vfs_getxattr
> Sigh.. did not get to fsdevel (again...) I already told you several times
> that you need to use a shorter CC list.

This is a direct result of the _required_ scripts/get_maintainer.pl 
logic, I am not going to override it for first send. I was going to 
forward to fsdevel after the messages settled, I am still waiting for 
1/4 to land on lore before continuing.

The first patch in the series needs to get in before the others. I was 
told to send the first one individually because the series has so many 
recipients and stakeholders, and <crickets> because no on could see the 
reason for the patch once it was all by itself. So I rejoined the set so 
they could see the reason for the first patch.

If only the first patch in the series that added the flag argument got 
in (somewhere), then the overlayfs portion would be much easier to handle.

>>    overlayfs: handle XATTR_NOSECURITY flag for get xattr method
>>    overlayfs: internal getxattr operations without sepolicy checking
>>    overlayfs: override_creds=off option bypass creator_cred
> It would be better for review IMO if you rebase your series on top of
> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git ovl-unpriv
Will do, send it only to fsdevel, other recipients? What do I do with 
get_maintainer.pl? The first patch in the series is noisy, I am getting 
more and more uncomfortable sending it to the list as it looks more and 
more like spam.
> 1. internal getxattr patch would be a one liner change to ovl_own_getxattr()
> 2. The documentation of override_creds would be much more
> meaningful if it used the overlay permission model terminology
> that Miklos added in his patch set and extend it
>
> Thanks,
> Amir.

-- Mark

