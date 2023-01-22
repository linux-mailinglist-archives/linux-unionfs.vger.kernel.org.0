Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A119D676B7B
	for <lists+linux-unionfs@lfdr.de>; Sun, 22 Jan 2023 08:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjAVHfk (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 22 Jan 2023 02:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVHfj (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 22 Jan 2023 02:35:39 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F241E1CD
        for <linux-unionfs@vger.kernel.org>; Sat, 21 Jan 2023 23:35:38 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e3so8168501wru.13
        for <linux-unionfs@vger.kernel.org>; Sat, 21 Jan 2023 23:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zrl5cIn9WD1Ah8HbXtLvCSoWdl9XDMhbK2OG2fkX1JU=;
        b=i7OhI1dFLf7D14D6zrnmHQFlJMZ3/er5pNA2vRvix6npH8HdG0jEJiPNkokuDv/PXB
         7Bg19qYmoo/JnmpPXsuSrQNTR6E/xECvmdhOPn0p0S+CMmeVFEOqf1bLSf3AUXxlJUKp
         6YDvp2A/k4GQ2e5lU8DNFCRVYdEbONKqy1j2/6aDl5q2eoE+CCl3695nWR6tApfF5lzy
         7Eo45ncNOTaH0N2iE1rE6adDMDn6V7Lhf4w4GzK2Q0UN75+3sugrgpF/RDr3HRltZwhP
         Z0dHu6RTJKD3ebd6sYOFeibsFqtRe4BjcgtUQ3W5wAwJADc/KbvNkAOCk59v1AA1vgyJ
         wlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zrl5cIn9WD1Ah8HbXtLvCSoWdl9XDMhbK2OG2fkX1JU=;
        b=ffjEkREA2v7QG9o7k1Jm6HqokCWk0k+iNjCEv4fCh6PEnhG0fYeq6VQassYHALsWnQ
         4xOpg5NivjPV1+HrnoFimSlnmk+lAMmyJdwzC+rClgCHz1qSgvtJsxByCW1987iYDCtZ
         j9ewOhzV187eJLp4QahdbtuNvyZ0lq8CaHSoFMngI7pgcm5c0cFk4SSd0h/A0FI25zgH
         rgpM37zjb8QO6CpLJJqoFlx/gOzh1lN+LE116vy/DZDv/YLOuVPBLWYfToYWz4Ysb4ro
         ZkxqyrE9SpM3vFoSXjjXFb2I6tTh5+I91vnQtvlRytSI6sGKSPbZWJT8xORQrEdNx94M
         AXVw==
X-Gm-Message-State: AFqh2kqU+60uj6AUdcCbaw7/sXXKACJvXRsKibBRdbeyptLwtU5lywrw
        J9cA8I97Fa0UX+YivyzuR/SUqZFurjr/zCEwhiU=
X-Google-Smtp-Source: AMrXdXvv+woFVdddO4KoOjJgj8VvxJk1bLGWFgKWdJQb24uyfr0nzWyG62KaODYX2vYZZn+172gZ7zFE+SuQ1zIXV2I=
X-Received: by 2002:a5d:51ca:0:b0:2bb:e7a6:f3c4 with SMTP id
 n10-20020a5d51ca000000b002bbe7a6f3c4mr660203wrv.539.1674372936494; Sat, 21
 Jan 2023 23:35:36 -0800 (PST)
MIME-Version: 1.0
Sender: mrumaruzongo.2@gmail.com
Received: by 2002:adf:fd4f:0:0:0:0:0 with HTTP; Sat, 21 Jan 2023 23:35:36
 -0800 (PST)
From:   "Mrs.Vanessa Adam" <mrsvanessaadams.7@gmail.com>
Date:   Sat, 21 Jan 2023 23:35:36 -0800
X-Google-Sender-Auth: UcLbWG8Y5CewXvFS5XuLM5kkEpk
Message-ID: <CAMD_TOK53uq-DLcfCynimpyACkMHuOcZxY5e7xer_Jcp7Deo0A@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Greetings My Dear Friend, ,

How are you? I hope this message will reach you in good fate. I have
severally tried to reach you in vain. My names are Mrs.Vanessa Adam,
my age is 68 and I am a citizen of Grenada. I lived in Philippines for
years where i did my missionary work. Due to my paraplegia stroke
which developed after the death of my husband i am admitted in a
specialist hospital in Israel from where i communicate you now.

My health is no longer promising and i can no longer afford to migrate
to your country for the establishment of charity service so i decided
to contact you. I got your contact through a link to your country=E2=80=99s
humanitarian event of the year.

My concern of contacting you is about the establishment of
humanitarian service in your country.

I decided to offer my financial aid for this service through you so
that you will establish a selfless service organization there in your
country for the sake of less privilege.

However, i thank you for taking your time and i expect your quick
reply so that we can discuss more about it. I am waiting for your
quick reply.

Yours faithfully,
Mrs.Vanessa Adam.
