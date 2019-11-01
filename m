Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B992EBE76
	for <lists+linux-unionfs@lfdr.de>; Fri,  1 Nov 2019 08:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfKAH1y (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 1 Nov 2019 03:27:54 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34561 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfKAH1y (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 1 Nov 2019 03:27:54 -0400
Received: by mail-oi1-f193.google.com with SMTP id l202so7463953oig.1
        for <linux-unionfs@vger.kernel.org>; Fri, 01 Nov 2019 00:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SBjQVCMFKnrJXdM6Q7dICUdlYg2Y+SSu4XE2KX/cUk4=;
        b=gHMUlu/kfxgoWKB6JPIH1pg2O01Yjb/O0FVyVrDHZxsLTsocIjPHRJA7MwFYbYaWxQ
         IdgZl9o0mKHZN59SpIg2Vbzc8BP0Llfajz+8QBorvC4gj6n/MDawCUb0EDbIIjL2w9ZG
         8kUL0sDMrGjkqH6KpDjjVzxyBxJ9vhtvFs0Vulw6kIGYDnu60b0giR4It6ZENxpb47Ro
         ZjZ9bRTJdAwkPTdKGA3eCtGw86lXWVpeQAonyjJDcNFkGd+/C2pn/sY5lv9Da2JvqjCW
         hP7h7PAVo40Lx7JzhIWsq5sBFGwc1maY680YGxVYuEA2pj5rZv1H/jMU6CPaflKY4RHd
         v9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SBjQVCMFKnrJXdM6Q7dICUdlYg2Y+SSu4XE2KX/cUk4=;
        b=n1xj/z1FAIZ2JX5Xf5MUZXT+wBOJhFRuk5qTnW5aS3bOZ/XwUMRzLIiw/7TL8VgFr9
         35CUPqaAyQcmBa2pXM3w7X18YlR2vMmesTeFQ6+fLt8vmDXmKYzGEugCj7bvs+IIqSap
         JEYQOvvLmD4B4N+0Wv0vFhFP/LMN5shSy2q3/dfex0mUhrm9OAOSRlwytkdR4a7WZLp5
         SkJ7fxTYnzFDxdSjj0SZtHZ5iDmMr7mAv6x7YMN30JUkhnzhsExl0X2f/+jsq5gFlLrp
         0bJd0JcHBJHbBB4PCKbEB8R8sCLhaCKYadB2bAJWvzVIu/t8ZvrgGHGwvjpV0tEpODlb
         y/lg==
X-Gm-Message-State: APjAAAVAkyXDqQyI7dxtHzUMFI6o/aq0PaH2TjhaxS5GNj3Sv3EI+IIo
        VI8tFMIebXlhEfn3qbuEwlD6ZJ1G
X-Google-Smtp-Source: APXvYqyHqYHCnncQyaqzVrruMZWxAzOpNcnAzkEugMc/amSt2+IgiT48IQR/QFWb4uxF2Tsl1DJLOw==
X-Received: by 2002:aca:b445:: with SMTP id d66mr2837346oif.111.1572593273598;
        Fri, 01 Nov 2019 00:27:53 -0700 (PDT)
Received: from JosephdeMacBook-Pro.local ([205.204.117.14])
        by smtp.gmail.com with ESMTPSA id n39sm1961810ota.33.2019.11.01.00.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 00:27:52 -0700 (PDT)
Subject: Re: Performance regression caused by stack operation of regular file
To:     JeffleXu <jefflexu@linux.alibaba.com>, miklos@szeredi.hu,
        Amir Goldstein <amir73il@gmail.com>
Cc:     linux-unionfs@vger.kernel.org
References: <ae928bd7-001a-061e-01f0-43b53a0adcd1@linux.alibaba.com>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <88f09a1e-2481-ac16-9754-77e21296b03a@gmail.com>
Date:   Fri, 1 Nov 2019 15:27:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ae928bd7-001a-061e-01f0-43b53a0adcd1@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi Miklos & Amir,
Could you please take a look at this?
It behaves different between the latest kernel and an old one, e.g. 4.9.

Thanks,
Joseph

On 19/10/28 14:21, JeffleXu wrote:
> Hi, Miklos,
> 
> I noticed a performance regression of reading/writing files in mergeddir caused by commit a6518f73e60e5044656d1ba587e7463479a9381a (vfs: don't open real), using unixbench fstime.
> 
> 
> Reproduce Steps:
> 
> 1. cd /mnt/lower/ && git clone https://github.com/kdlucas/byte-unixbench.git
> 
> 2. mount -t overlay overlay -olowerdir=/mnt/lower,upperdir=/mnt/upper,workdir=/mnt/work /mnt/merge
> 
> 3. cd /mnt/merge/byte-unixbench/UnixBench && ./Run -c 1 -i 1 fstime
> 
> 
> The score is 2870 before applying the patch, while it is 1780 after applying the patch, causing a 40% performance regression.
> 
> The testcase repeatedly reads 1024 bytes from one file and writes the readed data into another file, while both these two files
> 
> are created under /mnt/merge/tmp.  I have testsed the latest kernel 5.4.0-rc4+, same results.
> 
> 
> The perf shows that there's extra one call of file_remove_privs(), override_creds() and revert_creds() every write() syscall,
> 
> among which file_remove_privs() is pretty expensive.
> 
> 
> - perf data before applying the patch.
> 
> ```
> 
> -   53.00%     0.93%  fstime    [kernel.kallsyms]   [k] __vfs_write
>    - 52.08% __vfs_write
>       - 51.94% ext4_file_write_iter
>          + 48.89% __generic_file_write_iter
>            0.83% down_write_trylock
>            0.79% up_write
> 
> ```
> 
> 
> - perf data after applying the patch.
> 
> ```
> 
> +   94.88%     0.00%  fstime    [kernel.kallsyms]   [k] entry_SYSCALL_64_after_hwframe
> +   94.88%     4.67%  fstime    [kernel.kallsyms]   [k] do_syscall_64
> +   66.08%     1.60%  fstime    libc-2.17.so        [.] __GI___libc_write
> +   62.37%     0.23%  fstime    [kernel.kallsyms]   [k] ksys_write
> +   61.74%     0.62%  fstime    [kernel.kallsyms]   [k] vfs_write
> -   60.10%     0.49%  fstime    [kernel.kallsyms]   [k] __vfs_write
>    - 59.61% __vfs_write
>       - 59.56% ovl_write_iter
>          - 33.81% do_iter_write
>             - 32.50% do_iter_readv_writev
>                + ext4_file_write_iter
>          + 19.15% file_remove_privs
>            2.15% revert_creds
>            2.02% override_creds
>            0.64% down_write
>            0.63% up_write
> 
> ```
> 
> 
> Regards.
> 
> Jeffle
> 
