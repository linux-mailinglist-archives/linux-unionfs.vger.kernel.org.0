Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFED214935
	for <lists+linux-unionfs@lfdr.de>; Mon,  6 May 2019 13:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfEFL5U (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 6 May 2019 07:57:20 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52554 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfEFL5U (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 6 May 2019 07:57:20 -0400
Received: by mail-it1-f195.google.com with SMTP id q65so18279633itg.2
        for <linux-unionfs@vger.kernel.org>; Mon, 06 May 2019 04:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s1IpoUDGK+xfBvzrXvSA3aVuNuuuS7Q2B8vJFGaWnhE=;
        b=Ljhy2kH/QCdBpk5hiyT+huW3Rvc54rD3SqCuuwqkwjbm+pscoMcTC+qE/mW+Ti+lFe
         RJfdGedIg1wHMk4uLnaLqjlZFfv5IzK2je9HTmpHf48lRrDZTWvsZ0oJZ/GylZVuS3PP
         mP8qVFy0Pb40H3Xpk2CCU/qgAG4yr0pUOAsVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s1IpoUDGK+xfBvzrXvSA3aVuNuuuS7Q2B8vJFGaWnhE=;
        b=uZ7Pk/zkRwb3f3yU0DSE330vq/Udi54tM+faODNqvph4h3pYFS1Dy8Q3HOgUgmINQv
         AjsuOxeIw6ig7B/QEneAT+I/8IO5fYziI5woxTfxQO80ZI8OGYE8pTGI6if/mbYYivFo
         bm8cWtDHqal1jf60wg7dfolL7dpOhfh1UmfttfAJOT6fejeoH7VuqoxTpdbOaYtwVE8h
         9rt04UVEXvgTEVgbF8FxgjIxbFolacT4wh/jiu0H1KwjB8vkZRZg+2BEWr/gjrp7QBfz
         mTsQjeK7efWIwzIJZj4udFBAPvjMCedpUPjQLW7HUvT3JdUGra4J2FJfe+tjPLg1/sDD
         0VnQ==
X-Gm-Message-State: APjAAAU2pAs7ODCxOINHquDn4NvBaAHLiNst75P6Z2XRriclTA2JiQxY
        NqcFISBucKZZAKZEVNXXv2lfLm2ruIHPr8LRdPD3sg==
X-Google-Smtp-Source: APXvYqxWpw3FJjtAf3ioRcSbbNFGDGkoAUD0UAcJMhw3XNpuaqBzwKd7uPSHSI8lLllRLZC4xhHUcftIC0v9j9mz6oU=
X-Received: by 2002:a24:b342:: with SMTP id z2mr15979857iti.121.1557143839552;
 Mon, 06 May 2019 04:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190227113211.28006-1-amir73il@gmail.com>
In-Reply-To: <20190227113211.28006-1-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 6 May 2019 07:57:08 -0400
Message-ID: <CAJfpegsD8DWW4d8yFxbL57cUHehE8AoiDU-OyB-FCMZ6+3nONA@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: support stacked SEEK_HOLE/SEEK_DATA
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Eddie Horng <eddiehorng.tw@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Feb 27, 2019 at 7:32 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Overlay file f_pos is the master copy that is preserved
> through copy up and modified on read/write, but only real
> fs knows how to SEEK_HOLE/SEEK_DATA and real fs may impose
> limitations that are more strict than ->s_maxbytes for specific
> files, so we use the real file to perform seeks.
>
> We do not call real fs for SEEK_CUR:0 query and for SEEK_SET:0
> requests.
>
> Fixes: d1d04ef8572b ("ovl: stack file ops")
> Reported-by: Eddie Horng <eddiehorng.tw@gmail.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Thanks, applied.

Miklos
