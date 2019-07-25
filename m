Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B70DD75162
	for <lists+linux-unionfs@lfdr.de>; Thu, 25 Jul 2019 16:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfGYOi5 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 25 Jul 2019 10:38:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34721 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfGYOi4 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 25 Jul 2019 10:38:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so22871587pfo.1
        for <linux-unionfs@vger.kernel.org>; Thu, 25 Jul 2019 07:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dM0tavbTao+XHLEjp4zxGd1Wc/gjo0u4n5AfPPLxYxY=;
        b=qW9lqXmWOxkhdiOYGKrIWBHJs6675m6ojicr27ola+XCc/laXgrTsFw66srMTfptKM
         E79JHYUrgD0swB3l5aRCQD23i2Yw2BoCoSowYMi0YrTZ439hPJPdYEpr+IPidFY7bJ6w
         pYFJoxehPvvEcBRzxjNtLlvrWBiePB0+ymsj/T7HaZBy/uLx765/XOGY8lMSK+q1l0vj
         2Tg3XPrMqO++R7wch3UgVTEumv9q1vy/A7yceOCUX3sSgckKX3VdA/enhcH4mOqaTvj5
         3sHr+pvZlJx5Ev1BtEhINmnp3Q8GES5JIb0iUg15mcxR6OZc0CGwqWYCVo6sw3ar6rfF
         lCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dM0tavbTao+XHLEjp4zxGd1Wc/gjo0u4n5AfPPLxYxY=;
        b=Zm/kw9RoEQ5YD2eANhNj78yDm0UtkuZrO6EF1JoGb6fP5YhNvnZCQJFzGCSJa4oIKn
         8C/vZQPd31qJlnLIXovjH2UGJvlPNV4D9GGilg4iRlAdhKHVcSFMw0orhHVW84k3t42K
         dCqcWgDCUBHq6g8wH+NXX0HqjacPEMp48IFIbL70oAE9JA4jVgxANBSq7Zt8nayb7Eqv
         RGvMwcqPvqNPmb+hlm6damoNa/Z5zHHJcp047quhcjNKgZdBDXCuV+6jvCXNpx7KgMb7
         EP2bgazJZY/Wm7Bvcu8Szf4DXBjuPpaASKegOI4+uX4a/pDuugGdZqkTKZLgC/eIHV2M
         dEbg==
X-Gm-Message-State: APjAAAV+asggMnrLIrTi45A8K4Bsn+uJ4xXowDKOTEj8VsYydcMxwvkK
        ZTrrW8Uq7y3PyCPcCrp3cjM=
X-Google-Smtp-Source: APXvYqxbW1kdSdI2g5El3DdDVDtndVrRVVH5xAYU7zqmtvAOT6CVSwyux9F/5Aztl1fxRRkV7d9XhQ==
X-Received: by 2002:a63:c44c:: with SMTP id m12mr48061734pgg.396.1564065536100;
        Thu, 25 Jul 2019 07:38:56 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id z4sm39432142pgp.80.2019.07.25.07.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 07:38:55 -0700 (PDT)
Subject: Re: [PATCH v10 5/5] overlayfs: override_creds=off option bypass
 creator_cred
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
 <20190724195719.218307-6-salyzyn@android.com>
 <CAOQ4uxim8zZN5YHZs2OJz5A=3B0U10wyf371yadpe2B7hA8pZw@mail.gmail.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <9acceab1-86af-758a-ec00-8f6d33f3da87@android.com>
Date:   Thu, 25 Jul 2019 07:38:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxim8zZN5YHZs2OJz5A=3B0U10wyf371yadpe2B7hA8pZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On 7/24/19 11:14 PM, Amir Goldstein wrote:
>> +void ovl_revert_creds(const struct cred *old_cred)
>> +{
>> +       if (old_cred)
>> +               revert_creds(old_cred);
>> +}
>> +
> Mark,
>
> Not sure if you have seen my "shutdown" patches:
> https://lore.kernel.org/linux-fsdevel/20190715133839.9878-4-amir73il@gmail.com/

Good to know!

>
> I am fine with this patch, but would like to request that you add @sb arg
> to the ovl_revert_creds() helper, so it is more useful for other things in the
> future that scope the underlying layers access (like shutdown).

Will respin and retest.

-- Mark

