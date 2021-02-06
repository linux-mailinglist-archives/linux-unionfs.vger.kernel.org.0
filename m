Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7672311DDA
	for <lists+linux-unionfs@lfdr.de>; Sat,  6 Feb 2021 15:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhBFOkV (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sat, 6 Feb 2021 09:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhBFOkP (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sat, 6 Feb 2021 09:40:15 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B6CC0617A7
        for <linux-unionfs@vger.kernel.org>; Sat,  6 Feb 2021 06:39:35 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id r21so1360273otk.13
        for <linux-unionfs@vger.kernel.org>; Sat, 06 Feb 2021 06:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=cU2mOYChw8cJi+thD74b3zU3CdZyhIFrj+z1FgDWS9c3MwPpzCgv5D6xzAQ4H+XHQ6
         Iv0fP7YTRtsOjji8/OAvn+fVo8SIbr5k2P/U1rEPUOzqrR/uMhQZBWJpWrTIUr5yObSJ
         ik/68cvuoM0ZX6q2JuKNScSVzCrolB+b9ed0Qrq9hzL6BZq5rOmk4p/NrYVed/F/y81L
         isX3LRnFKq8lPhUUUpquE4f78f4gcHOAwGRrHml3VmWvnFZYEa2ERoyEXNbpMgZn8dFt
         ZCyqlOu57jE9ET8Vc9BDyMyOaUfSvEYvNUE9aAjwYoAvXcMzV/b5Xildipi3+AAY+/TZ
         Rl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=gU78ZRwK4tFlEUvCrPR1Wefl9xlSkGi5xu3BTLZsxajcnZrJgeK0I+kyVGYG9CzyeX
         fLVmuji2vWONmXhY4J68f/ZRRtX4d+rc12eye07bYSpUfZAXr3DAafdnsMoHzNrStJJz
         ojJoTwwwL0zUUUKDh+yw4NZR9jtEgScbgK5gtlU8yU3hhnOjQXLTLgboyuMW1md88AF2
         wde5k5UMaegOEV3c9jnjQACDTWJ+35TahyUE8a1q+dma/6ekDSB7OcQE1C/KFM5JGe5A
         /CZH115no1sdEpkEjs16zooRS+3CXsJkXkPslX8qY8aq0XyagyeWfE6CKRtcIDBcCiLf
         XizQ==
X-Gm-Message-State: AOAM533ynqJHy93KjjvMuZG27cVcqFbAUCeMX1Q7TQz5rvj9WBfk7p8t
        d5HKobn36A8R0pfjyJzFtAEfMbjkoU0G1wpN0rE=
X-Google-Smtp-Source: ABdhPJxyMD5yJ/1d7xMqXvhbp2UZXNbYzEw3sC6ZD45yJ4GQamrOGDouwkEyGlCjNKZdaF1YdHKGQG7CyKUwHJgiQy4=
X-Received: by 2002:a9d:69cf:: with SMTP id v15mr7282339oto.122.1612622374592;
 Sat, 06 Feb 2021 06:39:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:3e4c:0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:39:34 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada@gmail.com>
Date:   Sat, 6 Feb 2021 15:39:34 +0100
Message-ID: <CAO_fDi-9zBXBwhB-t58M7hoLSx+iPpY=jhpXcHc3Xh-TUin1Hw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
