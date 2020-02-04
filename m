Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE65E1518B4
	for <lists+linux-unionfs@lfdr.de>; Tue,  4 Feb 2020 11:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgBDKUJ (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 4 Feb 2020 05:20:09 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:45940 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgBDKUI (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 4 Feb 2020 05:20:08 -0500
Received: by mail-io1-f54.google.com with SMTP id i11so20215235ioi.12
        for <linux-unionfs@vger.kernel.org>; Tue, 04 Feb 2020 02:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=rtWvxbFxRmS2DJppP4nF4FGfXrKAjyId7vxeppC6P00=;
        b=n+phWuRiPMFcdMUqgy2X2H155f0xKcVlEzpPdGmnl35HXWmdWEHDxmk1sJOTcQ8mT4
         bj1rAvjl/ZRBzVh70ZClZLFTkG1JGNXnaWZH8b/LIO4582FXPGOemXJGoyrsLIN4Dr8j
         tmj5eR9WdNDacmASOgPpMLQxnS94qr7jYG56c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rtWvxbFxRmS2DJppP4nF4FGfXrKAjyId7vxeppC6P00=;
        b=k/s3Co28POfDNYWc+JBhmprtm6JvUxLwQ0sBnu4CplcXIrlQimjW6RAyVjGE5bWjkG
         H0jBUX3Ercz430ggnZXNtcoo0/Yk69CL0o7bpTWztEPpXpI9U+5zq+4NJF0G/+MwNdM4
         KotKPoMy00KLKXoc82XpSavbi3Jw3MFUNHMgdOr2nDN09McFkxAiqqbyPK3WPYW1ZdbG
         L9Y6TMoyPJf2Uq68gaPYmmjpN69MOpVbCZAisN0Y5dytPd/fppkTtX3jAfQMZR7xksJa
         FmtnLnIaykjkwRfrqkc8iHBRQ/sF1kc0j67fO8o+N0a+gE9n8XKkzU+g9Y/udYmI6kZd
         YW/w==
X-Gm-Message-State: APjAAAVMAS3eAB3o3L/cxovnyvkg6TBNfBFf7BchN+jMwddGfS676Ymn
        EcOZ1CLkbnMhO10x2WOeUnM1jm3hTRbXhMf+7LWkqQJHz7k=
X-Google-Smtp-Source: APXvYqzGseW8cI2ucUlZfKIiFirVTw3NDYWGWIhoYXrCRK9xAkjqp5Py/6g0GLOfRELyc8n03X7ONNrYYN6R0YjheR0=
X-Received: by 2002:a05:6638:3b6:: with SMTP id z22mr23073821jap.35.1580811608069;
 Tue, 04 Feb 2020 02:20:08 -0800 (PST)
MIME-Version: 1.0
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 4 Feb 2020 11:19:57 +0100
Message-ID: <CAJfpegtz4fRPL9pRBW_-3KbLwW5t+1Er3VR=tt5r7_eU9KtxFA@mail.gmail.com>
Subject: lore archive
To:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

This list (linux-unionfs@vger.kernel.org) is now archived on lore:

   https://lore.kernel.org/linux-unionfs/

Thanks,
Miklos
