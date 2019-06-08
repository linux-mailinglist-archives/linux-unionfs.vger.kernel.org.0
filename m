Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7925839BF6
	for <lists+linux-unionfs@lfdr.de>; Sat,  8 Jun 2019 11:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfFHJFH (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sat, 8 Jun 2019 05:05:07 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36976 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfFHJFH (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sat, 8 Jun 2019 05:05:07 -0400
Received: by mail-yw1-f66.google.com with SMTP id 186so1668721ywo.4
        for <linux-unionfs@vger.kernel.org>; Sat, 08 Jun 2019 02:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kSk3LCh2wEWmqvPbKZ9RlFqUbMVzxusWDi9aBvvsV18=;
        b=Cal4kP9d1gZ+G03Ogw3QwaR8gmLax9S/iBSpd5YgUzulM97Jjt73MHIaIgU7HIiN7n
         kdgM7+n2Oqu4TyFvCrIUYuQBrRX7KgmUsXF6kKRsEhWcN3SSMXT1HjHgXy4u9B8FwXk8
         Gg85Ih1TdQEnLqkY4QJmByg3LTSjq5F1saUs4oOs+5AgByf3DafdCzKQJ5IrVbBRhCGv
         d59ierTyvhZIY+G1OOGT/+AtJ97T1KGce3SX1HvFMnHmcTbTMB3MTXP/ExjOVv6sZmDZ
         0SCxhlRQdddz6r0KDi9jQtt7MTYiRByr+BDeG3y9DIUcdwiyJlZ2l8mlNFVOUC8xdTBO
         kJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kSk3LCh2wEWmqvPbKZ9RlFqUbMVzxusWDi9aBvvsV18=;
        b=nO9pckLO5OP5jcA84iJfNGY1LhVbFidNS/KLfTGxG8dYMxoCSRocvNF5+MV2tfVfS3
         6oEM06OAYvecikn3TMBoG6cs52XcZw95c1JDrXfhjGDHDqMh/IWdPC9xsysxo8remVSQ
         UMh0C2S3aobIDWGiZcqdKOc93Izxb0LVUQEzNb5XAEixDcy3ECHkfx2eZWy6q5C0hooN
         xx4Xq0a5Dnam8zgmxdDNUIHz0uq7nh7ob+FKp2qKyvDNkNI8neHZeKe6JrEJR/vvq2q3
         nwRqSZvfq9NHNL3x7KZksYHvEVv0H+lqRP9Csnb86BkbFsp7ImL0592hWSeCvUNvDgfa
         Y92Q==
X-Gm-Message-State: APjAAAVxwbQlOE+c7omlWZ1v0G4/hwkK79+af1p7OQB+90QGeZQNGBGr
        K4D4JLN1Es/VdfU7+LljLoTAuefFaSTbKOIC/2o=
X-Google-Smtp-Source: APXvYqz4Nj2k9lz7M/+JXBO3edV+hIp5Ey+2Z9jGccmuryW0UlkJiTjQqMowNSJ4ElvuyJn308IjcHZH7/FLpOFfjhk=
X-Received: by 2002:a81:7096:: with SMTP id l144mr31802977ywc.294.1559984706384;
 Sat, 08 Jun 2019 02:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190607010431.11868-1-mcoffin13@gmail.com> <20190607205105.21858-1-mcoffin13@gmail.com>
In-Reply-To: <20190607205105.21858-1-mcoffin13@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 8 Jun 2019 12:04:54 +0300
Message-ID: <CAOQ4uximPqsNivkqD36LdNfT4g41v2rtDm+OB6t2z40dpWs_og@mail.gmail.com>
Subject: Re: [PATCH v2] overlay: allow config override of metacopy/redirect defaults
To:     Matt Coffin <mcoffin13@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi Matt,

Thank you for trying to address this, but I see problems both in Why and
How you did it.

On Fri, Jun 7, 2019 at 11:51 PM Matt Coffin <mcoffin13@gmail.com> wrote:
>
> [Why]
> Currently, if the redirect_dir option is set as a kernel or module
> parameter, then even if metacopy is only enabled config, then both
> metacopy and redirect_dir will be enabled when one creates a mount
> point. This is not desirable because /sys/module/overlay/parameters will
> still report that redirect_dir is not enabled

/sys/module/overlay/parameters reports that redirect_dir is not enabled
*by default* not per mount.

> and there will be no redirect_dir=on line in the mount options in /proc/mounts.

That is a bug. This code:
/* Automatically enable redirect otherwise. */
config->redirect_follow = config->redirect_dir = true;

Needs to update of config->redirect_mode.

You are very welcome to send a fix patch.

> The behavior
> of setting redirect_dir globally for overlay is likely a common pattern
> on docker workstations, as redirect_dir makes for slower building of
> docker images.

I haven't been following the progress in docker w.r.t redirect_dir,
but IMO the right way for docker is to always mandate overlayfs
mount option parameters based on user meaningful storage driver
config options, see:
https://github.com/moby/moby/pull/34342#issuecomment-320669900

Instead of depending on admin to set /sys/module/overlay/parameters
globally, docker should always pass explicit redirect_dir,metacopy
values in mount options.
Docker should check for existence of /sys/module/overlay/parameters
feature file to know if kernel supports the mount option.

BTW, docker should be treating metacopy exactly the same way as
redirect_dir because the native diff driver does not know about metacopy,
so docket should (IMO) disable metacopy in mount option unless user
explicitly opted-in for in per image and fallback to naiive diff driver if
user opted-in to enable metacopy.

IMO, docker overlay2 storage driver should have a well documented
user meaningful per container option such as:
"optimize for efficient runtime" (redirect_dir=on,metacopy=on)
vs.
"optimize for efficient image export" (redirect_dir=off,metacopy=off)

Or even simpler:
"Exportable = true/false"
Because users know if they run a container that they don't intend
to export. In that case, it makes no sense to deny user of the benefits
of redirect_dir=on,metacopy=on.

>
> [How]
> This patch adds similar logic to that already in place for parsing mount
> parameters. If the user explicitly sets redirect_dir via a kernel or
> module parameter, then metacopy will become disabled, unless it was also
> specified that way. Obviously, mount options still take precedence over
> this process, so this logic only kicks in when neither redirect_dir or
> metacopy were specified in the mount options.
>

If even we did pass the "Why", the "How" is unacceptable IMO.
It extends something that is already a local special case hack
with redirect_opt/metacopy_opt.

If we ever try to improve parameter/config/option parsing
and dependency checks we need to do it in a much more generic
way and there are much more things to consider.
I am sorry that I cannot provide you guidelines for how to
do this. I took a stab at this once, then Miklos said he will try to
redo it and came back with:
"...this is more complicated than I thought."
https://marc.info/?l=linux-unionfs&m=154110487305120&w=2

If you do insist to try and follow this path, my only suggestion
is - start with a patch to Documentation/filesystems/overlayfs.txt.
If you cannot shortly and properly describe the behavior of
your change in documentation it is a no go.

Thanks,
Amir.
