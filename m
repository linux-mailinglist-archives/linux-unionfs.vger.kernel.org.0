Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17751AEB89
	for <lists+linux-unionfs@lfdr.de>; Sat, 18 Apr 2020 11:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgDRJ5l (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sat, 18 Apr 2020 05:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725856AbgDRJ5l (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sat, 18 Apr 2020 05:57:41 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB03C061A0C
        for <linux-unionfs@vger.kernel.org>; Sat, 18 Apr 2020 02:57:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id h2so5281280wmb.4
        for <linux-unionfs@vger.kernel.org>; Sat, 18 Apr 2020 02:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TfrUS5rwb1Lm1+fUNVoGgv8zsS/ehzKTgMHCq+Rkvu4=;
        b=JTWaO8kQ3QzInCc9DRMihu9tOOI9EHgdJoVTD0934wYeAJlT4+yl6MICBzxNx7nApj
         TMZ/BaubQ1L0fw/FqBmrjWArY9TSIBRTVZY+DqUJTPFLiXUwrTnWuD5/YwCTNiJpZAPx
         WMIq8ABHexizB7V9X+R7YduHbRfe0H/3GicgAX3sDFobog8OZWSCw+ewb/h/ijoP/tSj
         KasilG2fooVcJzxpR+c8N92iqkvSPk3XB+E05ndfEuNSlFH7uwjV8n5j/ffuji+d/PbL
         lnIGZRea06jMogWWMXSVJ4Njh6sdIHIrEDzRzwpVNr9JdP3B1F/1OWZPIjnh0z7PouyD
         66ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TfrUS5rwb1Lm1+fUNVoGgv8zsS/ehzKTgMHCq+Rkvu4=;
        b=QdZVyLR6PW0jIQYhB95n6bCiQLM5Gfrx870PA9avl9fFF32tP/lvfZVSK6RHHBdbCM
         LtldDxp80ChR4YYDkIbvr3fYwih2ajdvTfkYGfqbILw0RH3boZtO6Mnti+FDnWG0KMp+
         bXHcAJ2aHgBNMvnUSS3vLHPYT4IOyGShbqVEoIDvFHrUGM1jj3fIlrFsGX4T5SJH09AT
         8Pa30ImINMkDUeMF7dq8Q7sXlp29KZOJ5AdazEiqEqVN+DRnEOdAkDf9vz/W+SQbTj1M
         14i1wcmkhlJ2caIImxIjQUmuAG/oAwwG6nw7nHFQgQhwQn0Jp0F3HFuv7G0kyGHGkrp6
         s4Mw==
X-Gm-Message-State: AGi0PuYnNtjjuJ9yBalDRkJdYxCih6BdDcXHqOt8ys3sIWysdjx/y8mD
        6xObXilmRIkBklkDbAlCitLvdAxdwQjHv4SWbCs=
X-Google-Smtp-Source: APiQypLi2DeqJJ4yK6qxuto9hjB7lZGWsOx0Ga6g6aYn8MIVNbMLIAFUUNvnwHU+1vfSoZVW+xFYX8JqzXtXAxCoyEw=
X-Received: by 2002:a1c:5fc4:: with SMTP id t187mr7881419wmb.181.1587203859433;
 Sat, 18 Apr 2020 02:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200415120134.28154-1-amir73il@gmail.com> <20200415120134.28154-3-amir73il@gmail.com>
 <20200415153032.GC239514@redhat.com> <CAOQ4uxhmxxjGGB3bBoK1OmcAWDsoNi3WdORtH7WDLOcp8=sYSQ@mail.gmail.com>
 <20200415194243.GE239514@redhat.com> <CAOQ4uxjZ4Yd3ZWi+Fe64fVkrD=XMDjF1=C=XN_PNdywbGx_gzQ@mail.gmail.com>
 <20200416125807.GB276932@redhat.com> <CAOQ4uxi=mT2JYGSXro5YW8gTE5256cxauBddYe2HXM=ZfZ=+ZA@mail.gmail.com>
In-Reply-To: <CAOQ4uxi=mT2JYGSXro5YW8gTE5256cxauBddYe2HXM=ZfZ=+ZA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 18 Apr 2020 12:57:27 +0300
Message-ID: <CAOQ4uxjvtGLn=SvLXy3KU6uKbonBUznL==OjdVVjjB6sM=-mgg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Configure custom layers via environment variables
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

> > If I specify UNIONMOUNT_BASEDIR, then --samefs should be implied?
> >
>
> This might have made sense with the meaning of UNIONMOUNT_BASEDIR
> as it is in current posting, but with intended change, I suppose an empty
> UNIONMOUNT_LOWERDIR could mean --samefs.
> When both --samefs and UNIONMOUNT_LOWERDIR are specified, I'll
> throw a warning that UNIONMOUNT_LOWERDIR is ignored.
>

Vivek,

I updated the logic per some of your suggestions and push to:
  https://github.com/amir73il/unionmount-testsuite/commits/overlayfs-devel
The example of how xfstests uses it is at:
  https://github.com/amir73il/xfstests/commits/unionmount

Since I am mostly interested in feedback on config interface, I'll just
paste the commit message here (same text is also in README).

In short: if you set UNIONMOUNT_BASEDIR to virtiofs path and
execute run --ov, all layers will be created under that virtiofs path.

Let me know if this works for you.
Thanks,
Amir.

commit 8c2ac6e0cd9d4b01e421375e0b9c3703e774cd9f
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Sun Apr 12 19:22:19 2020 +0300

    Configure custom layers via environment variables

    The following environment variables are supported:

     UNIONMOUNT_BASEDIR  - parent dir of all samefs layers (default: /base)
     UNIONMOUNT_LOWERDIR - lower layer path for non samefs (default: /lower)
     UNIONMOUNT_MNTPOINT - mount point for executing tests (default: /mnt)

    When user provides paths for base/lower dir, they should point at
    existing directories and their content will be deleted.
    When the default base/lower paths are used, tmpfs instances are created.

    UNIONMOUNT_LOWERDIR is meaningless and will be ignored with --samefs.
    Empty UNIONMOUNT_LOWERDIR with non-empty UNIONMOUNT_BASEDIR imply --samefs,
    unless user explicitly requested non samefs setup with maxfs=<M>.

    This is going to be used for running unionmount tests from xfstests.

    Signed-off-by: Amir Goldstein <amir73il@gmail.com>
