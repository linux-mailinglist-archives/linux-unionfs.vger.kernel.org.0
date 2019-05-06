Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03CD014932
	for <lists+linux-unionfs@lfdr.de>; Mon,  6 May 2019 13:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfEFL4p (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 6 May 2019 07:56:45 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41735 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfEFL4p (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 6 May 2019 07:56:45 -0400
Received: by mail-io1-f67.google.com with SMTP id a17so2666008iot.8
        for <linux-unionfs@vger.kernel.org>; Mon, 06 May 2019 04:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YWFzvnD/RE8DxT98mCEZ7EuIbpUu+/2S8F1/XA9A+x4=;
        b=hCpDnsrIRSR/WM16yOcbAfVH2EOsZ2ewpwWoipAy9Wq0Motox3GzWLyYbhMXPHleS4
         q6ht5tLx7H+hCPaEFQXwfRq+Sldo0uOltcBbIohNpp141jDoKtTitsDIGACDJP3mv9FE
         C5JhMaTR/02qgIvywU47Smc9OVIEshWh9zT4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YWFzvnD/RE8DxT98mCEZ7EuIbpUu+/2S8F1/XA9A+x4=;
        b=MQEIe+q7WbQYKqiC6hHYf9nuSGcbsziNqK2ZF/1Cysfp0rhgyb6U+otkgZ3ov+tDeo
         BSsiTE+uBMugWbEFkbzO5H+pWAhxh5ZzqXDXxZEFK3DWUAK5ElCZkdcYjgeDZTiI1Jn+
         bo8Nsx92nmE2kIJCUZc9pKhKeDlyEI5VG5z4L+E2arx3/yeQP9akG1Zb9+vCjG0N/7hJ
         dTeSoMRp2C4m0fVSlymna0Ut5mKd/LN321D8cb2/nwVU018LFQSgsFgZVqxeiemr1AJj
         rVFdOoRx/2PFX0H8xF4Ls0tH/9dn5NwwjtMECaQjwv7JuyT1QiI+DpN1Jo0yAD+uWJh5
         D0fw==
X-Gm-Message-State: APjAAAVD5xNob0lHfZwFX5YE8UYLEe2kg2MVsarHlBa3xF6y+L7G12EV
        5czhESsTT2kMavpsj/FwZe0iuYYHqHyzq6t1/lHRxg==
X-Google-Smtp-Source: APXvYqyudIs2cgUm/x9fyrJKQ1DFsqcJEjjr/ni+RM4ZKx1tGGrFQrq+WZv1kCkB3Y76KB4IsVxgO2Lu6YriAAjm/fE=
X-Received: by 2002:a5d:88d1:: with SMTP id i17mr16730467iol.294.1557143804180;
 Mon, 06 May 2019 04:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190122050139.19701-1-amir73il@gmail.com> <CAOQ4uxhdgxtL3-tMDSegruCnNdvfLNDJ2p0OcnZrvXtPqiDf8A@mail.gmail.com>
 <CAOQ4uxjxOKXMviymoF6W7q1RPCht1z49N85S=ATGq5-oqfb1qQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjxOKXMviymoF6W7q1RPCht1z49N85S=ATGq5-oqfb1qQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 6 May 2019 07:56:33 -0400
Message-ID: <CAJfpegv6HWXHvRLBkSpb0_TT=mmwgL873iw4LMMM_aU_tXnepg@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix missing upper fs freeze protection on copy up
 for ioctl
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Mar 27, 2019 at 2:37 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Fri, Mar 1, 2019 at 11:29 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Tue, Jan 22, 2019 at 7:01 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > Generalize the helper ovl_open_maybe_copy_up() and use it to copy up
> > > file with data before FS_IOC_SETFLAGS ioctl.
> > >
> > > Fixes: dab5ca8fd9dd ("ovl: add lsattr/chattr support")
> > > Cc: <stable@vger.kernel.org> # v4.19
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Thanks, applied.

Miklos
