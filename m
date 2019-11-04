Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83AB9ED6C4
	for <lists+linux-unionfs@lfdr.de>; Mon,  4 Nov 2019 02:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfKDBDz (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 3 Nov 2019 20:03:55 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44171 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfKDBDy (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 3 Nov 2019 20:03:54 -0500
Received: by mail-ot1-f66.google.com with SMTP id n48so12984442ota.11
        for <linux-unionfs@vger.kernel.org>; Sun, 03 Nov 2019 17:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sl5ohjDSCyJbL6kBAZlCxhYunWZNGBDnW5N9EXg/9+A=;
        b=qbRERWMmJCrjNgVN6H21n+K3GL+2Ri2BwdSsYGJ7eZZZfbicmcF9N+rNERQG2Y3Mg9
         ZaIR/8pd8NOLIs3sCXI0p+yZueka968vFii6Nr46WTYegAsapVrvRXTv4eGz07Izb3CF
         eKtr5z6+UVOfnAFH2ubbtkJ8byYEhYcVaEa1lXnEu2tBfZjdl/V9BecmJuRlptkxp8dV
         zMHp8EawpzMBqNOym9sWRmvYbfuQ3A7Oit24BnDDbv/Cx7xMnVseuQVVuGVWrSBYzXg8
         KJdbdArLDqhhRbJVrXYHvA5yZE72bBFN38GIARj+IQeJrUhXB6oF86XEsaXQVDk2OQu6
         9tIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sl5ohjDSCyJbL6kBAZlCxhYunWZNGBDnW5N9EXg/9+A=;
        b=SPOUOR/8B4f7qKP8oATwRVi3bjxtcdqWg28SRKi2gdBC4aBLLfeSJfDS3F6WOrCaiR
         RftfrOrqOvUm4Z9LWCK45v8amoCeCvgfeoolVCjynnXfXZ39wig7ytHtu0rywcfNoy91
         VRmhkh5L9i5ORxfLELjcKOZqjizDADvaqt+DOhVLYmmi1EEAQ3DvlXS0PgPE5QZTI3wD
         jDoWUnQH3SEgyO07c4UMxuxMH0RiS3nXWzJmBLWehTs72pjw1gGrlqmPVDqwt7yzwMoL
         l3utxqIIIUy1h6rCAqROK4vfN1wRNMCPwdGgXRY/dHbJ+s7zAtaL4ZBnskueWbVNvf3c
         HlQQ==
X-Gm-Message-State: APjAAAWmxiJmVuhzO6lzjSjgZvg4rKCMJXozeC800AK8IDb236hK4q4D
        UMSzsDjLmuXq9zMrvhrws+ChPmQ7
X-Google-Smtp-Source: APXvYqwiPvyXx80Wzl4r8+e9ezcB3m36ildp3qi4wyN0xOGGvPKnN7irr69puR+Hbfkv/fcbDxlkQQ==
X-Received: by 2002:a9d:39e3:: with SMTP id y90mr13391453otb.194.1572829433892;
        Sun, 03 Nov 2019 17:03:53 -0800 (PST)
Received: from JosephdeMacBook-Pro.local ([205.204.117.4])
        by smtp.gmail.com with ESMTPSA id k10sm4005827oig.25.2019.11.03.17.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Nov 2019 17:03:53 -0800 (PST)
Subject: Re: Performance regression caused by stack operation of regular file
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     JeffleXu <jefflexu@linux.alibaba.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>
References: <ae928bd7-001a-061e-01f0-43b53a0adcd1@linux.alibaba.com>
 <88f09a1e-2481-ac16-9754-77e21296b03a@gmail.com>
 <CAOQ4uxgHrtbCk+FMi5VOmQ+XUxGKmb5y--zgOQAz5_jx0ZuG8Q@mail.gmail.com>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <2013b3b1-fc4d-3288-b0e8-cfb2e4aab361@gmail.com>
Date:   Mon, 4 Nov 2019 09:03:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxgHrtbCk+FMi5VOmQ+XUxGKmb5y--zgOQAz5_jx0ZuG8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi Amir,
Thanks for your valuable inputs.

On 19/11/1 22:25, Amir Goldstein wrote:
> On Fri, Nov 1, 2019 at 9:27 AM Joseph Qi <jiangqi903@gmail.com> wrote:
>>
>> Hi Miklos & Amir,
>> Could you please take a look at this?
>> It behaves different between the latest kernel and an old one, e.g. 4.9.
> 
> Not surprisingly.
> Stacked file operations in 4.19 shuffled the cards.
> See below.
> 
>>
>> Thanks,
>> Joseph
>>
>> On 19/10/28 14:21, JeffleXu wrote:
>>> Hi, Miklos,
>>>
>>> I noticed a performance regression of reading/writing files in mergeddir caused by commit a6518f73e60e5044656d1ba587e7463479a9381a (vfs: don't open real), using unixbench fstime.
>>>
>>>
>>> Reproduce Steps:
>>>
>>> 1. cd /mnt/lower/ && git clone https://github.com/kdlucas/byte-unixbench.git
>>>
>>> 2. mount -t overlay overlay -olowerdir=/mnt/lower,upperdir=/mnt/upper,workdir=/mnt/work /mnt/merge
>>>
>>> 3. cd /mnt/merge/byte-unixbench/UnixBench && ./Run -c 1 -i 1 fstime
>>>
>>>
>>> The score is 2870 before applying the patch, while it is 1780 after applying the patch, causing a 40% performance regression.
>>>
>>> The testcase repeatedly reads 1024 bytes from one file and writes the readed data into another file, while both these two files
>>>
>>> are created under /mnt/merge/tmp.  I have testsed the latest kernel 5.4.0-rc4+, same results.
>>>
> 
> Is this really a workload that you are interested in or just a random
> micro benchmark?
> If kernel changes behavior for the better in some workloads and for the worst
> in other workloads, it is important to distinguish between the case of real
> life workloads and less meaningful micro benchmarks that do not really have
> that much effect on real world.
> 
We'll figure out if there is a real use case with respect to this benchmark.

>>>
>>> The perf shows that there's extra one call of file_remove_privs(), override_creds() and revert_creds() every write() syscall,
>>>
>>> among which file_remove_privs() is pretty expensive.
>>>
> 
> Interesting.
> If this is indeed the reasons for the perf regression
> then it boils down to performance vs. security, because if kernel
> 4.9 is truly faster due to skipped file_remove_privs() and override_creds()
> then it is not really enforcing security in a consistent manner.
> It's true that in the common case, mounter credentials are a super set of
> user credentials, so file_remove_privs() and  security_file_permission()
> with user credentials are most of the time practically enough, but that is
> not universally true.
> > If the workload is truly important to you, please try to figure out
> why the extra calls are so expensive.
> Do you have any LSMs enabled?
> 
Yes, we've enabled SELinux by default.

Thanks,
Joseph
