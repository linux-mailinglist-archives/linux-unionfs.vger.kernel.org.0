Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9FD1484FB
	for <lists+linux-unionfs@lfdr.de>; Fri, 24 Jan 2020 13:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbgAXMK7 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 24 Jan 2020 07:10:59 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34689 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730050AbgAXMK7 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 24 Jan 2020 07:10:59 -0500
Received: by mail-io1-f67.google.com with SMTP id z193so1643801iof.1
        for <linux-unionfs@vger.kernel.org>; Fri, 24 Jan 2020 04:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sy+PQDvsWmewmFHIUrX8Pq8s2Ztiwko6kLRqBplRIKk=;
        b=FqR8Ry9s0TsYbcoK+HvmwdjAs13BFD+xQqumXN85FAmkZOpnyMT23n2VxrYGgwA+PL
         dl5UpMT12kjI6wvHAZWWkFxA0GsqVQ3k0H3n8vhxrhTDm/uj4ho0Zjg/k8hRTdXpPTGY
         xk6D8RRa8scwN2XCzAj2KL0KPq5xBsCbYIbWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sy+PQDvsWmewmFHIUrX8Pq8s2Ztiwko6kLRqBplRIKk=;
        b=onPaEdgZQUD0jUtbc34g6aHDLfF/kvmYi2T4krtzu8ROnqintubj6ZBOjVuNg13mhF
         Lzar6ju96rGDtP5r7K+LfAQXufiJnM9GTbz3mt+ynCJfwfah4RpTJSLb85I4tNv1as/D
         X+HyzH+C6FkmG0qX+8fm8ClilIQL50HF6vjnSdKFfpExriDtRZUveXLC8+tW/lSfK4ux
         Bk6WnuMEqyPAO8IA60mNujl7LsUJcuop9+FVkzvV0RzpJoevb7zpkpA6JB80fj0PIiYS
         xDAm7vV9/53GZPrGyHXM05zTrgEkqNwKiGcpSz7jqlqkXakcakfs4LAp6wT8JJVKtvzd
         JyAg==
X-Gm-Message-State: APjAAAWuSfJGKntuxXqmJ+DkGZJVEOVy2da9Q8aSjHs9jKlWTHv33Nce
        IMVSO7d7zCxZzAl+0yp2/8oyRiwBw8pCP2uIYMG/Rw==
X-Google-Smtp-Source: APXvYqwaG9On1c7dozCovP02QrSzFjdwVrPNzeR9j0u9E+i78sNabHVkv5S1f4N2LDTUI4Ds2fSfGfQ62hiwB3MLQq4=
X-Received: by 2002:a02:b897:: with SMTP id p23mr2267764jam.58.1579867859068;
 Fri, 24 Jan 2020 04:10:59 -0800 (PST)
MIME-Version: 1.0
References: <1574243126-59283-1-git-send-email-jiufei.xue@linux.alibaba.com>
In-Reply-To: <1574243126-59283-1-git-send-email-jiufei.xue@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 24 Jan 2020 13:10:48 +0100
Message-ID: <CAJfpegsOt0cX-8dN-3Fq=bfqmxYCDu=7eN_-=5rusy5VTjD3Mg@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] ovl: implement async IO routines
To:     Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Nov 20, 2019 at 10:45 AM Jiufei Xue
<jiufei.xue@linux.alibaba.com> wrote:
>
> ovl stacks regular file operations now. However it doesn't implement
> async IO routines and will convert async IOs to sync IOs which is not
> expected.
>
> This patchset implements overlayfs async IO routines.

Thanks,  pushed to overlayfs-next with slight modifications.

Miklos
