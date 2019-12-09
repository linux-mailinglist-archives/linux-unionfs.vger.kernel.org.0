Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75D96116FC8
	for <lists+linux-unionfs@lfdr.de>; Mon,  9 Dec 2019 15:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfLIO5i (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 9 Dec 2019 09:57:38 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:35160 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfLIO5i (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 9 Dec 2019 09:57:38 -0500
Received: by mail-io1-f43.google.com with SMTP id v18so15087681iol.2
        for <linux-unionfs@vger.kernel.org>; Mon, 09 Dec 2019 06:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tzN5z7lN2a/KJCOCYI/RukGcVVmHZ5uMBYIJED3u+I8=;
        b=WwMpoFvVBd1IA3cxiyl2kIegAwqIYZ/eOl7EfzUnev9zMH8SsdUobI+XjKIxhJg0wp
         r+3PygiRKkp5O2LsHuVLdkisk8rkw1rMCSlo9ZJj740hxHCbzabeZIJ/P9KenfX7bYxY
         KBYqkMrtpS8Rb382F8X1rtSt8a/rpSjx8TQ08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzN5z7lN2a/KJCOCYI/RukGcVVmHZ5uMBYIJED3u+I8=;
        b=r22aYms9QCWxfoRnXc2+vnF4FNv3z2vHDSxHxLFMR9xY/lzvFUsXD8ChDyty6+BwKE
         z9x2Kynne5g/YHJHh0kfV6/wvP37RQGbsZ3r/SdYCeE0Lm4HNZKB6atPrLO8Te4555+W
         OAC6J89Cw81bGAp/lpcw+ktxOK1lnatMKsTXcDVYTlIhA4TimD1r1pOHItq5AHqMrDbz
         RbtH/2P8uTULd4bi9VsBy0kqVFZeYHHpaR5mYvT2uBeofh9DiyU8SvPC4+1zsXzkNvAv
         2tnD4xLMjof9ku4CKBe/0EXpgskHveRlHF5s51wTJpOZxo045GZidWV3rImY2n9sAfA1
         PN1Q==
X-Gm-Message-State: APjAAAW2rdAJG3sBKNnDj9uSz99Y3sBj7ql/kbCauxBk9IyBd6iMGlH8
        vlw0raBdEZ6ZeHVXbNTSOPMWAY64cVnCL7WxGZbd4oi/
X-Google-Smtp-Source: APXvYqw5dMhIUjcEq6SfPV4dkyVaZxRDEoS5JHMD60Yf5hwWo3ca2OD52WysQBW8nN4OIPTcrFL8hjFG9zE+Kont21A=
X-Received: by 2002:a6b:6f07:: with SMTP id k7mr21388166ioc.174.1575903457824;
 Mon, 09 Dec 2019 06:57:37 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxh7fszXGXV0U5K4yz4o3WwDk40LmOi+dH2Nwi+yq_5+Pw@mail.gmail.com>
In-Reply-To: <CAOQ4uxh7fszXGXV0U5K4yz4o3WwDk40LmOi+dH2Nwi+yq_5+Pw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 9 Dec 2019 15:57:26 +0100
Message-ID: <CAJfpegv8sN=XB5ePnEiz3KfVhHhyNmYWW8C-bckaxeYiQ0Ee-g@mail.gmail.com>
Subject: Re: Overlayfs fixes queue
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Mon, Dec 2, 2019 at 7:32 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Hi Miklos,
>
> Will you have time to queue some of the queued fixed [1] and docs .rst
> conversion [2] for 5.5, maybe rc2?
>
> The timestamp limits issue is also being addressed by Deepa in vfs as
> you suggested, so not critical but nice to have.
>
> I posted an xfstest [3] that demonstrates the corner case of
> non-unique st_dev;st_ino (v4.17 regression).

Hi Amir,

I'm going though your queue, hoping to finish it for -rc2.

Thanks,
Miklos
