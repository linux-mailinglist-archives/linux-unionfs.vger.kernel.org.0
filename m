Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A150AE6C62
	for <lists+linux-unionfs@lfdr.de>; Mon, 28 Oct 2019 07:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbfJ1GVZ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 28 Oct 2019 02:21:25 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:50020 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728657AbfJ1GVZ (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 28 Oct 2019 02:21:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0TgSyXzG_1572243682;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0TgSyXzG_1572243682)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 28 Oct 2019 14:21:23 +0800
To:     miklos@szeredi.hu
Cc:     linux-unionfs@vger.kernel.org
From:   JeffleXu <jefflexu@linux.alibaba.com>
Subject: Performance regression caused by stack operation of regular file
Message-ID: <ae928bd7-001a-061e-01f0-43b53a0adcd1@linux.alibaba.com>
Date:   Mon, 28 Oct 2019 14:21:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi, Miklos,

I noticed a performance regression of reading/writing files in mergeddir 
caused by commit a6518f73e60e5044656d1ba587e7463479a9381a (vfs: don't 
open real), using unixbench fstime.


Reproduce Steps:

1. cd /mnt/lower/ && git clone 
https://github.com/kdlucas/byte-unixbench.git

2. mount -t overlay overlay 
-olowerdir=/mnt/lower,upperdir=/mnt/upper,workdir=/mnt/work /mnt/merge

3. cd /mnt/merge/byte-unixbench/UnixBench && ./Run -c 1 -i 1 fstime


The score is 2870 before applying the patch, while it is 1780 after 
applying the patch, causing a 40% performance regression.

The testcase repeatedly reads 1024 bytes from one file and writes the 
readed data into another file, while both these two files

are created under /mnt/merge/tmp.  I have testsed the latest kernel 
5.4.0-rc4+, same results.


The perf shows that there's extra one call of file_remove_privs(), 
override_creds() and revert_creds() every write() syscall,

among which file_remove_privs() is pretty expensive.


- perf data before applying the patch.

```

-   53.00%     0.93%  fstime    [kernel.kallsyms]   [k] __vfs_write
    - 52.08% __vfs_write
       - 51.94% ext4_file_write_iter
          + 48.89% __generic_file_write_iter
            0.83% down_write_trylock
            0.79% up_write

```


- perf data after applying the patch.

```

+   94.88%     0.00%  fstime    [kernel.kallsyms]   [k] 
entry_SYSCALL_64_after_hwframe
+   94.88%     4.67%  fstime    [kernel.kallsyms]   [k] do_syscall_64
+   66.08%     1.60%  fstime    libc-2.17.so        [.] __GI___libc_write
+   62.37%     0.23%  fstime    [kernel.kallsyms]   [k] ksys_write
+   61.74%     0.62%  fstime    [kernel.kallsyms]   [k] vfs_write
-   60.10%     0.49%  fstime    [kernel.kallsyms]   [k] __vfs_write
    - 59.61% __vfs_write
       - 59.56% ovl_write_iter
          - 33.81% do_iter_write
             - 32.50% do_iter_readv_writev
                + ext4_file_write_iter
          + 19.15% file_remove_privs
            2.15% revert_creds
            2.02% override_creds
            0.64% down_write
            0.63% up_write

```


Regards.

Jeffle

