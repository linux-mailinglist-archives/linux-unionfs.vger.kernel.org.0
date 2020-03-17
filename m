Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55114188312
	for <lists+linux-unionfs@lfdr.de>; Tue, 17 Mar 2020 13:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgCQMJc (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 17 Mar 2020 08:09:32 -0400
Received: from sonic307-2.consmr.mail.ne1.yahoo.com ([66.163.190.121]:42063
        "EHLO sonic307-2.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726705AbgCQMJc (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 17 Mar 2020 08:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1584446971; bh=kcevCRoll2+Bsa3FDERpIV72LVcB1A4YV1b5N2AWYBk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=YO0tVrQVvzfL2xl61ElSaonc3517GXUr0CDAxIB/J60BNk++5+YDQYJCADuPQrgC3Nm7qQiarie3CGUkhklb/7KJKqEOdupkobzgSYzDXgwmLyelTzifPlQTOYbXnvdSr/ln0xMv6o5/eMeR+6LoSRP/jT3YvF7l5aQR64z3Ze/GcfVd4VpiUalS5GWMCarbzZLJGTwAMaMJoviyCW9zdohxsHwS4jmItVEn0tCD0w4Im8NTK0E3hGsYL8OL0szUmaOOJar6Q+a535fMn+5tzzWmg5j7MTm3OX+QOIdmfZjsMbdpAbJIYLVkLCuH2/OeLT/xDe8uXjcxDqq1SSZaVg==
X-YMail-OSG: _SJfPigVM1kXmNt8jPd7ks7OdsTkH5cZ0rp5hOOs8vq95p1mnEQV.avInsHNaaQ
 iVSQL2q4IPnHNN6uquNiNhjK6GF_whiUZzxOiRvCbd_G9yG7EfomXrdZUljOpd6G8a0BtfoWpjTw
 B4ydA0EW1g84WDczFyRzb4oWWwJ2gFKbaK7immyHwy30eWmsNq96Z6UoHHRVOax_9NrXiZigaSkh
 V.z2.Zff0YsKE0290B7pLm7s5F4CB8jaIg1rI4qboAyT1lbZca9_1k7dNLpGER4bLd_Cf80aT2NW
 GXoIaWK9bgkICK1EmcxNuwPcsXuISpXjSK_HpfWI4ApF4sVKAat8zTiYvsSMq4T6pOVsVCcxVPUw
 7UTGjvs9ntMfXF6XK3.42XYMxZbzD.q1GQhK_jwzcpv96MwLNlCggbV6S77lz7kL0T1.kAK5MtKP
 Zly4VDEyZC0cql2vHxyIscKMLiItoekWDfQ5YOH2pNN5UcQsgzy2F1UoSjb0edVVxHXh1u4uHq0_
 XhfRdZmEMYHQjGT8BJkNKBrf9WGfdW6tBxbHViH.M2OBVhAwZ8f.hThyCYqadd.2E8JKnAARe2CT
 eN5nGTbBI_16DKZtQoQAfT_Nfr5_ZtBG7sHmAVz0a8Jrw3tYwS0fs.CzocLk.BBBOp0F.ht8wY1J
 RbNL0SO7N4AAc6K64fhUC.m19l3dGKWdQow4iBVG4KgPbl8bmgwhN2T4tdeIHHYC.q5nCIZ2KVVZ
 PwTgZqUS3_f15qJPM0rjjhCvl7ZfJdgS2doo7Sa6D8N_Dmcux44tffYGpzCAq3YG9RnrnwvivuNo
 1w2VSMdUCSAhzkSoF.TZkGymSAS4RN8texI1Gh6gmMUHRq_5ksx5amMayQp4phvn0epTiCAj6Tnz
 7BB8b6yXGZSvw6nn4SvXeK3v2v4bhD_abJZS24h8RNgltg99S4INAxlcz0zB64DboO9AMorJVkF.
 IOUxoH1Y4gZeGjeOlHdnDkKJ_riC2Q9cF9CfAz0hk7v3yPJ4KhGsHVDbdcMHxWZNiGQdmI97y7c5
 U8ZIpwopgkRgHSC0Bm_ezDmUpG79TP7BPQwSXF63ilZY8ZswCPPWsq8IZ79W2575GwYL9Jlfx1ol
 7z5KV0EmQCARXn6k13rk9vKhD.6mG5wIbiWKO1V77l0u8rHMSJbE9pmvKDgJ2LKSr2NUzQzsoVnx
 YiAhY6Aid7uVLw97G8OvQsFl68p6hAV9dpxybh2qyzrR01.k6UYyCB.hHb0Ap0_P48xTN.xAnMMY
 w.pSdEPLR25_A1f0_FCFQ..kcJK0Z0DZp53yJzNtOnx5O6zWu4549oTIZmgWDhElx_mGML01KQo2
 qgjzvoBsyizVdBaGiuZ.IM4G7rqw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Mar 2020 12:09:31 +0000
Date:   Tue, 17 Mar 2020 12:07:31 +0000 (UTC)
From:   Stephen Li <stenn7@gabg.net>
Reply-To: stephli947701@gmail.com
Message-ID: <1553052642.1814451.1584446851283@mail.yahoo.com>
Subject: REF
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1553052642.1814451.1584446851283.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15342 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org



Greetings,
I was searching through a local business directory when I found your
profile. I am Soliciting On-Behalf of my private client who is
interested in having a serious business investment in your country. If
you have a valid business, investment or project he can invest
back to me for more details. Your swift response is highly needed.
Sincerely
Stephen Li
Please response back to me with is my private email below for more details
stephli947701@gmail.com
