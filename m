Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C7B7C7C45
	for <lists+linux-unionfs@lfdr.de>; Fri, 13 Oct 2023 05:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjJMDob (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 12 Oct 2023 23:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjJMDoa (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 12 Oct 2023 23:44:30 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7B8B7
        for <linux-unionfs@vger.kernel.org>; Thu, 12 Oct 2023 20:44:28 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3af5b5d816aso2489444b6e.3
        for <linux-unionfs@vger.kernel.org>; Thu, 12 Oct 2023 20:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697168668; x=1697773468;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mt5lwhC39izgTZ2VYtKVLxhKrOpgc+bFz9LIFDekYx8=;
        b=nfHrwsT2kZG8LOQ243ioafS1MBGyL6J78MRLTKGsLbrElcgTXcF0os2e8TO2UfJ/kb
         NmbKmxlmAbu0rqMhsqzYkFq2/fCblcNB24UOzoNJhawKkifPFo8i1QjxLwFPhMxYkDmK
         r4v16U/62oSsoX1LraBPXZJ0PZFtVhehHaSusVJ3WJuC4LamBQMTNu6/MaZvv5vCfo+b
         g0bpQC7SG0bnMCToJ/UUnre3MSeIwZ0in0syuDi2NYfqX/s3DOGNomsJS0YUjP86R5yl
         eumrCl/EvUKyPFpK19sTH79ObYoDG2lqCRlMI1vJg2qd82THypN4EiwKPZJ3WJZMtEUa
         8P5A==
X-Gm-Message-State: AOJu0Yz+3GeSzepHpuIQtqngx8fO6uX8TvZtYMswY3PUt40jEzMIk74S
        +SjTvIXAFviVKtJ4oL0nxrp4BaAoV5+rOf91WSzSCXgHWFOJ
X-Google-Smtp-Source: AGHT+IELbRThAdn5Z7PxEQ2q784CB31g7j9A0PV98zUl+RW8YJASygLBqKQpFkzypV3y11u9UGbDuQ3MD7vzMK6PCLZl/FkwCOeL
MIME-Version: 1.0
X-Received: by 2002:a05:6808:152a:b0:3ad:fd08:30a3 with SMTP id
 u42-20020a056808152a00b003adfd0830a3mr13193875oiw.11.1697168667943; Thu, 12
 Oct 2023 20:44:27 -0700 (PDT)
Date:   Thu, 12 Oct 2023 20:44:27 -0700
In-Reply-To: <000000000000648bb80600bccb40@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093a958060790df91@google.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in wait4 (4)
From:   syzbot <syzbot+8ee0140c3f5eab8a8d4f@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, brauner@kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 8542f1712074f070ae90b64e6082d10d8e912e32
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Mon Oct 2 10:04:45 2023 +0000

    ovl: fix file reference leak when submitting aio

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=131df329680000
start commit:   9d23aac8a85f Merge branch 'net-sched-fixes-for-sch_qfq'
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a211c03cef60366
dashboard link: https://syzkaller.appspot.com/bug?extid=8ee0140c3f5eab8a8d4f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1014d574a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173e5deca80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ovl: fix file reference leak when submitting aio

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
