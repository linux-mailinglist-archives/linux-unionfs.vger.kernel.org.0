Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 870BB75154
	for <lists+linux-unionfs@lfdr.de>; Thu, 25 Jul 2019 16:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbfGYOhJ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 25 Jul 2019 10:37:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34582 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfGYOhJ (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 25 Jul 2019 10:37:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id b13so22869305pfo.1
        for <linux-unionfs@vger.kernel.org>; Thu, 25 Jul 2019 07:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eR9Hp6lNdSYA3Q9LS12AuwAXP6EgUTReBDkxImpX5hM=;
        b=lk2NGtx5FqgD81SxeWV7cc9gi6gUfxxPm8Vw1C2fRjdvKVT415jdlNqzYMMC+aB53l
         HwC2FGD/kd+ot31j2TND04GQNCilJniBlkulcKaqjUc/gkYJYPjxtUEahs9Tfiia9r/f
         ifHMuSLRXja1h4Ebug5DXIxxSVErvU4Qc7l2QtRmAakLP2bzsJA0fFxy0FgkLoyGOkZU
         uz/Tt9gAr/tWmFDWcmjY7BGQa3KSxFWBeRxU60dXJk7/1RTrjIdlZGF4Vgh4XYpHWBgJ
         6WiE6PpzpvtvLlv6P7wF0jyo34sn9Ir3Le7yN/XJnJ3JO2yIUXc+8OSRzdcOObHAxN/I
         b94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eR9Hp6lNdSYA3Q9LS12AuwAXP6EgUTReBDkxImpX5hM=;
        b=g+SJgCC42EOlleewUPxnT+E0YBN9rkIudV5/EkOUuO8wmA9JdcE5EVNidn9ydhrtgJ
         0RvH3TrdE0UyiRYo7/RjGW0x2Ldz4nO6gjDMM4iAN6OxazN1h4DDwwjw6zQC5cf1m/fT
         jxvzUZUf6ubjvF1IucK2eNX0lIbHD1z7+h32rk1luefF5rorv4StBh/78HbBOQ+hMAEv
         XNdLAvhGcmEZqIv1sRsiGUGe/LkIEovi4LTLdYcYkdRUS3rQhMgvXhkWoANrz50Eig7T
         NRKr055sHaWayJLw7n/ipM2AY97sS9gBMx9EQ2bAE5ZwvPlPI8ak87dBV1h4JchDIc8l
         sJNA==
X-Gm-Message-State: APjAAAX1vBiFZAzG4CDCR0xnOCwOZjhTiE6ETH2cD7yVQQ2r1sL9xFgW
        JBchLVHomEmk+u8R+LWXZEI=
X-Google-Smtp-Source: APXvYqyM+b0LIhHKU6UawP/Xg2Yu8CVrpTZWWVwOYd0IcNAxs1f6VsdAVX4Xa08OWBMpPtwJXLywcw==
X-Received: by 2002:a62:e20b:: with SMTP id a11mr17216612pfi.0.1564065428842;
        Thu, 25 Jul 2019 07:37:08 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id k3sm35749356pgq.92.2019.07.25.07.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 07:37:08 -0700 (PDT)
Subject: Re: [PATCH v10 4/5] overlayfs: internal getxattr operations without
 sepolicy checking
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
 <20190724195719.218307-5-salyzyn@android.com>
 <CAOQ4uxhtASSymEOdh4XByXbxWO2_ZivzqjBrgK7jB3fWXLqr_w@mail.gmail.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <20df8497-17ea-27db-43c8-fcd73633e7f3@android.com>
Date:   Thu, 25 Jul 2019 07:37:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxhtASSymEOdh4XByXbxWO2_ZivzqjBrgK7jB3fWXLqr_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Thanks for the review.

On 7/25/19 4:00 AM, Amir Goldstein wrote:
> On Wed, Jul 24, 2019 at 10:57 PM Mark Salyzyn <salyzyn@android.com> wrote:
>> Check impure, opaque, origin & meta xattr with no sepolicy audit
>> (using __vfs_getxattr) since these operations are internal to
>> overlayfs operations and do not disclose any data.  This became
>> an issue for credential override off since sys_admin would have
>> been required by the caller; whereas would have been inherently
>> present for the creator since it performed the mount.
>>
>> This is a change in operations since we do not check in the new
>> ovl_vfs_getxattr function if the credential override is off or
>> not.  Reasoning is that the sepolicy check is unnecessary overhead,
>> especially since the check can be expensive.
> I don't know that this reasoning suffice to skip the sepolicy checks
> for overlayfs private xattrs.
> Can't sepolicy be defined to allow get access to trusted.overlay.*?

Because for override credentials off, _everyone_ would need it (at least 
on Android, the sole user AFAIK, and only on userdebug builds, not user 
builds), and if everyone is special, and possibly including the random 
applications we add from the play store, then no one is ...

For the override credentials on, the sepolicy would be required to add 
to init or other mounters so that callers can actually use overlayfs. 
Without the sepolicy for init, overlayfs will not function. the xattr 
are in the backing storage and the details are not exported outside of 
the driver. This would represent an imbalance since none of the callers 
would require the sepolicy adjustment for the ;normal' case, but for 
override credentials off as stated above, _everyone_ would require it.

Not against adding the sepolicy in Android, it is how we roll with only 
opening up credentials on an as-need basis. We could deny it on user 
(customer) builds and that closes a door that gains security. However 
our people are starting to resist userdebug being different from user so 
it may be a door I can not shut. Again felt like an imbalance for a 
trusted driver read only operation.

Sincerely -- Mark Salyzyn

