Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53313465ED1
	for <lists+linux-unionfs@lfdr.de>; Thu,  2 Dec 2021 08:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355833AbhLBHms (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 2 Dec 2021 02:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345659AbhLBHmr (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 2 Dec 2021 02:42:47 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D19C061574
        for <linux-unionfs@vger.kernel.org>; Wed,  1 Dec 2021 23:39:25 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id p2so54070309uad.11
        for <linux-unionfs@vger.kernel.org>; Wed, 01 Dec 2021 23:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nextdayvideo-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+MjKvkD4quMK1VMiteo/4/pFBTAJQvYzJjXAdpbeGfI=;
        b=QK+oOD5yNv3IFoGNh/YWH6s0QBVe9KSRTn86z5UA+CvdfnEZw0LPzGLwCp3uxiiCvZ
         F8g6BH9ZYhRyLCgZrqg0ElhuKAa76RcluEF1G2+0yTDX7gq1Tiul53Wy7ExSZIXenplm
         08PBhZj8a5xQudLdSmI5P3Tj+GZOEoxwdEHXfywDPFt26a0OXYki9Li6PW9WrdK3Vuve
         GOOhQYRzOoC50Z3kZJd9pSvOgVs6WgP1UN+DGqGD4IfxPPfR6LAdXcsopqB12co0b2WI
         l9pt00pvKcUN95rBItETkbPED7ROdmWu5qduq6U1FhAq7Mvmqf7itEGJiJEXbxF1Lo4v
         /DHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+MjKvkD4quMK1VMiteo/4/pFBTAJQvYzJjXAdpbeGfI=;
        b=eewl/m+RP694ojR45osvhnfs/wBPl/D+Wh3H2gnYt64F8H92N2aMCBclDBQs8JHIwo
         m2rEw4vz2eIqItrkKw+TaIkv+b9PbBNbfgVqdUGDalPECj0bJUXWQbxZT6/RHXxPoo8z
         cYKbEpqIVT28OM+O53eu/FAYR6HFolYEd0e1KU5iyO21xcwpUZqq4Gs0lTuZQma+WdLf
         J1cm7wzzWj31tGqWmsHQ+Ac8kuoAvKnHqTnQRDwUDXidT+LB7GSCEJN/uqtlngVKgyc9
         /d/p/fpqNL7hM/X/jDxWIVo2KM62Lz25dUPDS1T4Sg8LYnEmIqW7wDbc7rk6oc8MYvvf
         QjMA==
X-Gm-Message-State: AOAM5315hSddtNo9A7TLOeIkNbGHEXNL13zmOcvs+x0thNCb+63ZaK7x
        PC6lGuMhsI/3zP+K7LVCZEbhSvnlGnExD58HjDekWy9NfcM=
X-Google-Smtp-Source: ABdhPJyWkWJvRvw3ZVT4NJWj02hYG4cWy8WLH1iNyH6X97sFbuAyjpVWbtr3HUTyMblW1yYVERc8Gl4EtJRqMFcA4YM=
X-Received: by 2002:a05:6102:6c9:: with SMTP id m9mr13144639vsg.32.1638430763796;
 Wed, 01 Dec 2021 23:39:23 -0800 (PST)
MIME-Version: 1.0
References: <CADmzSSiE_XKnN3XaoP5HFV_3LOwOe9txCfbcEPAm-8B_9HkLRA@mail.gmail.com>
In-Reply-To: <CADmzSSiE_XKnN3XaoP5HFV_3LOwOe9txCfbcEPAm-8B_9HkLRA@mail.gmail.com>
From:   Carl Karsten <carl@nextdayvideo.com>
Date:   Wed, 1 Dec 2021 23:38:56 -0800
Message-ID: <CADmzSSiKe-R-qzQaO3+gNZiAxqSTnsRVvt6JNjMeFyFLy8E7Nw@mail.gmail.com>
Subject: Re: nfsd blocked
To:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

vers=4.2 no help

after 5 min, client dmesg:

[  328.673438] nfs: server 10.21.0.1 not responding, still trying
pi@raspberrypi:~ $ findmnt /
TARGET SOURCE                                      FSTYPE OPTIONS
/      10.21.0.1:/srv/nfs/rpi/bullseye/root/merged nfs4
rw,relatime,vers=4.2,rsize=4096,wsize=4096,namlen=25

server:

[  612.314809] INFO: task nfsd:1034 blocked for more than 122 seconds.
[  612.314820]       Tainted: G         C        5.10.63-v7+ #1488
[  612.314825] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  612.314832] task:nfsd            state:D stack:    0 pid: 1034
ppid:     2 flags:0x00000000
[  612.314847] Backtrace:
[  612.314872] [<809f9df0>] (__schedule) from [<809fa7c8>] (schedule+0x68/0xe4)
[  612.314882]  r10:00000000 r9:89353d04 r8:8c393100 r7:00000002
r6:00000001 r5:82996c80
[  612.314888]  r4:ffffe000
[  612.314902] [<809fa760>] (schedule) from [<8017bcac>]
(rwsem_down_write_slowpath+0x318/0x518)
[  612.314909]  r5:ffffe000 r4:8c3930f0
[  612.314919] [<8017b994>] (rwsem_down_write_slowpath) from
[<809fd700>] (down_write+0x6c/0x70)
[  612.314929]  r10:86f991a0 r9:00000000 r8:8c233ee0 r7:86e64490
r6:93c56c00 r5:8c3930f0
[  612.314934]  r4:8c3930f0
[  612.314967] [<809fd694>] (down_write) from [<7f5ae6b8>]
(ovl_dir_release+0x34/0x70 [overlay])
[  612.314974]  r5:8c3930f0 r4:8eb98ac0
[  612.314999] [<7f5ae684>] (ovl_dir_release [overlay]) from
[<803359f0>] (__fput+0x90/0x25c)
[  612.315007]  r7:86e64490 r6:000a841d r5:8c393068 r4:93c56c00
[  612.315016] [<80335960>] (__fput) from [<80335c24>] (delayed_fput+0x4c/0x58)
[  612.315026]  r9:8c393068 r8:00000122 r7:00000100 r6:80f05008
r5:89353dec r4:93c56e40
[  612.315036] [<80335bd8>] (delayed_fput) from [<80335c4c>]
(flush_delayed_fput+0x1c/0x20)
[  612.315042]  r5:89353dec r4:00000001
[  612.315146] [<80335c30>] (flush_delayed_fput) from [<7f0c7ec4>]
(nfsd_file_close_inode_sync+0x180/0x188 [nfsd])
[  612.315295] [<7f0c7d44>] (nfsd_file_close_inode_sync [nfsd]) from
[<7f0c065c>] (nfsd_unlink+0x230/0x270 [nfsd])
[  612.315304]  r8:00008000 r7:9346d068 r6:86f42000 r5:93445440 r4:89290038
[  612.315451] [<7f0c042c>] (nfsd_unlink [nfsd]) from [<7f0d0ccc>]
(nfsd4_remove+0x5c/0x114 [nfsd])
[  612.315461]  r9:00000000 r8:86f43a20 r7:86f43000 r6:86f42000
r5:86f991c0 r4:89290038
[  612.315610] [<7f0d0c70>] (nfsd4_remove [nfsd]) from [<7f0d06f4>]
(nfsd4_proc_compound+0x3f4/0x648 [nfsd])
[  612.315617]  r6:86f98000 r5:86f42000 r4:89290000
[  612.315766] [<7f0d0300>] (nfsd4_proc_compound [nfsd]) from
[<7f0b973c>] (nfsd_dispatch+0xc8/0x14c [nfsd])
[  612.315776]  r10:7f0f3890 r9:00000018 r8:8ea15000 r7:8ea15014
r6:7f0f3890 r5:86f43000
[  612.315782]  r4:86f42000
[  612.315862] [<7f0b9674>] (nfsd_dispatch [nfsd]) from [<809ca22c>]
(svc_process_common+0x374/0x70c)
[  612.315871]  r9:86f43000 r8:86f43a20 r7:86f42000 r6:80f05008
r5:00000014 r4:86f42184
[  612.315882] [<809c9eb8>] (svc_process_common) from [<809ca69c>]
(svc_process+0xd8/0xec)
[  612.315891]  r10:86c85cfc r9:86f42000 r8:81016540 r7:7f100bc4
r6:816aa800 r5:bab24000
[  612.315897]  r4:86f42000
[  612.315976] [<809ca5c4>] (svc_process) from [<7f0b9100>]
(nfsd+0xf4/0x164 [nfsd])
[  612.315982]  r5:00057e40 r4:86f42000
[  612.316062] [<7f0b900c>] (nfsd [nfsd]) from [<80143790>]
(kthread+0x170/0x174)
[  612.316072]  r9:86f42000 r8:7f0b900c r7:89352000 r6:00000000
r5:89090200 r4:89256880
[  612.316082] [<80143620>] (kthread) from [<801000ec>]
(ret_from_fork+0x14/0x28)
[  612.316089] Exception stack(0x89353fb0 to 0x89353ff8)
[  612.316097] 3fa0:                                     00000000
00000000 00000000 00000000
[  612.316105] 3fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  612.316113] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  612.316122]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
r6:00000000 r5:80143620
[  612.316128]  r4:89090200


On Wed, Dec 1, 2021 at 6:56 PM Carl Karsten <carl@nextdayvideo.com> wrote:
>
> there is overlayfs in the middle of the stack dump, so I think this is
> the place to post.   happy to post it somewhere else if directed.
>
> currently very reproducible - 3 times in a row, rebooting both clent
> and server between.
>
> tt may be related to me setting nfsvers=3. I plan on testing this
> guess, but it may be a while. hours or maybe a day or 2.
>
> I tried to pin down the file operation client side, but that hasn't
> happened yet either.
>
> client and server Details:
>
> server: raspberry pi v3,
> pi@rpi-cb-1f-f7:~$ uname -a
> Linux rpi-cb-1f-f7 5.10.63-v7+ #1488 SMP Thu Nov 18 16:14:44 GMT 2021
> armv7l GNU/Linux
>
> pi@rpi-cb-1f-f7:~$ cat /etc/exports
> /srv/nfs/rpi/bullseye/root/merged
> *(rw,sync,no_subtree_check,no_root_squash,fsid=2)
>
> pi@rpi-cb-1f-f7:~$ findmnt /srv/nfs/rpi/bullseye/root/merged | cat
> TARGET                            SOURCE  FSTYPE  OPTIONS
> /srv/nfs/rpi/bullseye/root/merged overlay overlay
> rw,relatime,lowerdir=/srv/nfs/rpi/bullseye/root/setup:/srv/nfs/rpi/bullseye/root/base,upperdir=/srv/nfs/rpi/bullseye/root/updates,workdir=/srv/nfs/rpi/bullseye/root/work,index=on,nfs_export=on
>
> pi@rpi-cb-1f-f7:~$ findmnt  /
> TARGET SOURCE         FSTYPE OPTIONS
> /      /dev/mmcblk0p2 ext4   rw,noatime
>
> client: also a pi:
> pi@raspberrypi:~ $ uname -a
> Linux raspberrypi 5.10.63-v8+ #1488 SMP PREEMPT Thu Nov 18 16:16:16
> GMT 2021 aarch64 GNU/Linux
>
> root@raspberrypi:~# cat /etc/fstab
> # proc            /proc           proc    defaults          0       0
> 10.21.0.1:/srv/nfs/rpi/bullseye/root/merged / nfs defaults,auto,rw,nfsvers=3 0 0
>
> root@raspberrypi:~# findmnt /|cat
> /      10.21.0.1:/srv/nfs/rpi/bullseye/root/merged nfs
> rw,relatime,vers=3,rsize=4096,wsize=4096,namlen=255,hard,nolock,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=10.21.0.1,mountvers=3,mountproto=tcp,local_lock=all,addr=10.21.0.1
>
> on the client, I run
> apt autoremove --assume-yes
>
>
>
>
> [ 1103.834869] INFO: task nfsd:1029 blocked for more than 122 seconds.
> [ 1103.834889]       Tainted: G         C        5.10.63-v7+ #1488
> [ 1103.834901] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 1103.834915] task:nfsd            state:D stack:    0 pid: 1029
> ppid:     2 flags:0x00000000
> [ 1103.834945] Backtrace:
> [ 1103.834992] [<809f9df0>] (__schedule) from [<809fa7c8>] (schedule+0x68/0xe4)
> [ 1103.835015]  r10:00000000 r9:86f67d4c r8:8fc134a0 r7:00000002
> r6:00000001 r5:86dc4d80
> [ 1103.835029]  r4:ffffe000
> [ 1103.835056] [<809fa760>] (schedule) from [<8017bcac>]
> (rwsem_down_write_slowpath+0x318/0x518)
> [ 1103.835072]  r5:ffffe000 r4:8fc13490
> [ 1103.835094] [<8017b994>] (rwsem_down_write_slowpath) from
> [<809fd700>] (down_write+0x6c/0x70)
> [ 1103.835116]  r10:7f0f2df4 r9:00000000 r8:8c696bb0 r7:82ba73d0
> r6:85d00600 r5:8fc13490
> [ 1103.835129]  r4:8fc13490
> [ 1103.835195] [<809fd694>] (down_write) from [<7f6676b8>]
> (ovl_dir_release+0x34/0x70 [overlay])
> [ 1103.835211]  r5:8fc13490 r4:96d1eb80
> [ 1103.835267] [<7f667684>] (ovl_dir_release [overlay]) from
> [<803359f0>] (__fput+0x90/0x25c)
> [ 1103.835286]  r7:82ba73d0 r6:000a841d r5:8fc13408 r4:85d00600
> [ 1103.835307] [<80335960>] (__fput) from [<80335c24>] (delayed_fput+0x4c/0x58)
> [ 1103.835328]  r9:8fc13408 r8:00000122 r7:00000100 r6:80f05008
> r5:86f67e34 r4:85d00180
> [ 1103.835348] [<80335bd8>] (delayed_fput) from [<80335c4c>]
> (flush_delayed_fput+0x1c/0x20)
> [ 1103.835363]  r5:86f67e34 r4:00000001
> [ 1103.835570] [<80335c30>] (flush_delayed_fput) from [<7f0c7ec4>]
> (nfsd_file_close_inode_sync+0x180/0x188 [nfsd])
> [ 1103.835916] [<7f0c7d44>] (nfsd_file_close_inode_sync [nfsd]) from
> [<7f0c065c>] (nfsd_unlink+0x230/0x270 [nfsd])
> [ 1103.835938]  r8:ffffc000 r7:92419068 r6:86f44000 r5:937dd3b8 r4:86fa0008
> [ 1103.836285] [<7f0c042c>] (nfsd_unlink [nfsd]) from [<7f0ca3f4>]
> (nfsd3_proc_remove+0x80/0xd8 [nfsd])
> [ 1103.836308]  r9:00000018 r8:96dd5000 r7:86f44000 r6:86fa0008
> r5:86fa0000 r4:86f38000
> [ 1103.836650] [<7f0ca374>] (nfsd3_proc_remove [nfsd]) from
> [<7f0b973c>] (nfsd_dispatch+0xc8/0x14c [nfsd])
> [ 1103.836669]  r7:96dd5014 r6:7f0f2df4 r5:86f45000 r4:86f44000
> [ 1103.836856] [<7f0b9674>] (nfsd_dispatch [nfsd]) from [<809ca22c>]
> (svc_process_common+0x374/0x70c)
> [ 1103.836878]  r9:86f45000 r8:86f45a20 r7:86f44000 r6:80f05008
> r5:00000014 r4:86f44184
> [ 1103.836901] [<809c9eb8>] (svc_process_common) from [<809ca69c>]
> (svc_process+0xd8/0xec)
> [ 1103.836923]  r10:856abcfc r9:86f44000 r8:81016540 r7:7f100bc4
> r6:816cae00 r5:bab24000
> [ 1103.836937]  r4:86f44000
> [ 1103.837120] [<809ca5c4>] (svc_process) from [<7f0b9100>]
> (nfsd+0xf4/0x164 [nfsd])
> [ 1103.837135]  r5:00057e40 r4:86f44000
> [ 1103.837321] [<7f0b900c>] (nfsd [nfsd]) from [<80143790>]
> (kthread+0x170/0x174)
> [ 1103.837342]  r9:86f44000 r8:7f0b900c r7:86f66000 r6:00000000
> r5:892b9580 r4:847acbc0
> [ 1103.837364] [<80143620>] (kthread) from [<801000ec>]
> (ret_from_fork+0x14/0x28)
> [ 1103.837378] Exception stack(0x86f67fb0 to 0x86f67ff8)
> [ 1103.837396] 7fa0:                                     00000000
> 00000000 00000000 00000000
> [ 1103.837415] 7fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [ 1103.837434] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [ 1103.837454]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
> r6:00000000 r5:80143620
> [ 1103.837467]  r4:892b9580
>
>
> --
> Carl K



-- 
Carl K
