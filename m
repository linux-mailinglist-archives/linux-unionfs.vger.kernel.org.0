Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093A2255DF6
	for <lists+linux-unionfs@lfdr.de>; Fri, 28 Aug 2020 17:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgH1PhT (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 28 Aug 2020 11:37:19 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53440 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgH1PhC (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 28 Aug 2020 11:37:02 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kBgR2-009Hwp-Ey; Fri, 28 Aug 2020 09:37:00 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kBgR1-0008Vh-Mz; Fri, 28 Aug 2020 09:37:00 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
References: <CAOQ4uxjXZdXZAaeiJ_p9n7NJziBv2yvWqSDs0hDd1ONUrVKxOQ@mail.gmail.com>
Date:   Fri, 28 Aug 2020 10:33:16 -0500
In-Reply-To: <CAOQ4uxjXZdXZAaeiJ_p9n7NJziBv2yvWqSDs0hDd1ONUrVKxOQ@mail.gmail.com>
        (Amir Goldstein's message of "Tue, 25 Aug 2020 09:07:04 +0300")
Message-ID: <87tuwmiy4j.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kBgR1-0008Vh-Mz;;;mid=<87tuwmiy4j.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+UEvHHyKyN1lFrfwsVXfqd0dqui9Ko9ME=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2193]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Amir Goldstein <amir73il@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 410 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 10 (2.5%), b_tie_ro: 9 (2.2%), parse: 1.52 (0.4%),
         extract_message_metadata: 20 (4.9%), get_uri_detail_list: 1.37 (0.3%),
         tests_pri_-1000: 6 (1.4%), tests_pri_-950: 1.36 (0.3%),
        tests_pri_-900: 1.12 (0.3%), tests_pri_-90: 188 (45.9%), check_bayes:
        174 (42.4%), b_tokenize: 4.9 (1.2%), b_tok_get_all: 4.0 (1.0%),
        b_comp_prob: 1.78 (0.4%), b_tok_touch_all: 159 (38.8%), b_finish: 1.24
        (0.3%), tests_pri_0: 163 (39.8%), check_dkim_signature: 0.86 (0.2%),
        check_dkim_adsp: 3.6 (0.9%), poll_dns_idle: 0.87 (0.2%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 11 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Overlayfs @Plumbers
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> Hi Guys,
>
> It's been nice to virtually meet with you yesterday.
> Some of you wanted to follow up on overlayfs related issues.
>
> If you want to discuss, try to find me in one of the
> https://meet.2020.linuxplumbersconf.org/hackrooms
> today between 16:00-17:00 UTC
> (No need to enter the room to see who's inside)
>
> If those times do not work for you, contact me and we can try
> to schedule another time.

Did this conversation wind up happening?  Do we need to reschedule?

Eric
