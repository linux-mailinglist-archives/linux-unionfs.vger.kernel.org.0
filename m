Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1CB7E170F
	for <lists+linux-unionfs@lfdr.de>; Sun,  5 Nov 2023 23:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjKEWAA (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 5 Nov 2023 17:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjKEV77 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 5 Nov 2023 16:59:59 -0500
X-Greylist: delayed 5157 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Nov 2023 13:59:54 PST
Received: from SMTP-HCRC-200.brggroup.vn (mail.hcrc.vn [42.112.212.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFCE125
        for <linux-unionfs@vger.kernel.org>; Sun,  5 Nov 2023 13:59:53 -0800 (PST)
Received: from SMTP-HCRC-200.brggroup.vn (localhost [127.0.0.1])
        by SMTP-HCRC-200.brggroup.vn (SMTP-CTTV) with ESMTP id CD6D81973F;
        Mon,  6 Nov 2023 01:58:14 +0700 (+07)
Received: from zimbra.hcrc.vn (unknown [192.168.200.66])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by SMTP-HCRC-200.brggroup.vn (SMTP-CTTV) with ESMTPS id C75EF19808;
        Mon,  6 Nov 2023 01:58:14 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.hcrc.vn (Postfix) with ESMTP id 638271B8223A;
        Mon,  6 Nov 2023 01:58:16 +0700 (+07)
Received: from zimbra.hcrc.vn ([127.0.0.1])
        by localhost (zimbra.hcrc.vn [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MEXt3TFJIIc7; Mon,  6 Nov 2023 01:58:16 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.hcrc.vn (Postfix) with ESMTP id 2FBB91B8253E;
        Mon,  6 Nov 2023 01:58:16 +0700 (+07)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.hcrc.vn 2FBB91B8253E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hcrc.vn;
        s=64D43D38-C7D6-11ED-8EFE-0027945F1BFA; t=1699210696;
        bh=WOZURJ77pkiMUL2pPLC14ifVPRvyTQIBEQmxuN1ezAA=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=zUDs4DObYCnXMQ6Os34A7EMkDvNcO994cEhenMAjcR0cBHozmaYvz7WOlFuQ0Dq/Q
         KA+xlqjbkitdyqIDvdOOs8PQ0/qssSWss7/cW9JEjbNbfeSLmq/kbGgcds47GCWhU9
         H5Uh3yACrE0apNeYCkPAjdVk0AEkwawAvL/6ry5LD2PLsHDBee3keSy5SzivAmBfgf
         +41qY1STX0uYCSDadBYTfQK7Bp08k5LmxbpCPIZV+bIU5GdJFzNClYBxAJ+4c04d/Z
         bGQoCQS3VcHWKpgN0nUikh0MjFZlziSxTmTlBqd0AUCfRZRG8NUC5gZWkfFs5MqOv4
         Pn58LZGEP1P6g==
X-Virus-Scanned: amavisd-new at hcrc.vn
Received: from zimbra.hcrc.vn ([127.0.0.1])
        by localhost (zimbra.hcrc.vn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Tm-_T52nvTzz; Mon,  6 Nov 2023 01:58:16 +0700 (+07)
Received: from [192.168.1.152] (unknown [51.179.100.52])
        by zimbra.hcrc.vn (Postfix) with ESMTPSA id D606A1B8252B;
        Mon,  6 Nov 2023 01:58:09 +0700 (+07)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?b?4oKsIDEwMC4wMDAuMDAwPw==?=
To:     Recipients <ch.31hamnghi@hcrc.vn>
From:   ch.31hamnghi@hcrc.vn
Date:   Sun, 05 Nov 2023 19:57:59 +0100
Reply-To: joliushk@gmail.com
Message-Id: <20231105185809.D606A1B8252B@zimbra.hcrc.vn>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Goededag,
Ik ben mevrouw Joanna Liu en een medewerker van Citi Bank Hong Kong.
Kan ik =E2=82=AC 100.000.000 aan u overmaken? Kan ik je vertrouwen


Ik wacht op jullie reacties
Met vriendelijke groeten
mevrouw Joanna Liu

