Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E392B133C49
	for <lists+linux-unionfs@lfdr.de>; Wed,  8 Jan 2020 08:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgAHH1Y (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 8 Jan 2020 02:27:24 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:46032 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgAHH1X (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 8 Jan 2020 02:27:23 -0500
Received: by mail-io1-f49.google.com with SMTP id i11so2062097ioi.12
        for <linux-unionfs@vger.kernel.org>; Tue, 07 Jan 2020 23:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=yFb9COXwv691181NTvML3zHA8cYgQA9NRUgQ5Cd1jtE=;
        b=U6XC/YTfpSkD/CTUwZ2w3SXikYx7r8XWUZA3qv3CwCdRSdm2ryFXUuiEyC8ebadkFm
         DEQfFQXsvRVTGsA53rSt1wA6K4rDm43a28Do7mQt+OXhFXXeDVr+65m/lzKxiCshnaE7
         bjGDDl5ph8ll6ereOIdXTC6E/1kQ92LjjG2rk/B09Xog+zfyRHEHLVRt9zdfHOljksgN
         7nTRV8d21vML0TPAoa8ib/VPxvwosi5ARvwv+tu3SPK+I1Ehr0L9w8VAlWWwZGwXJx5E
         IQAnp7XE/bMqHQjchbK1b4+r5LNF5MG6nvaEhUsh0Dq73WSuDMGndBDhsmH1XwvJgpoD
         HzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yFb9COXwv691181NTvML3zHA8cYgQA9NRUgQ5Cd1jtE=;
        b=OUSCE3ABqieLr0vVNCL+eT7oV/WWW00Beib7DiIVD/ARm3fj1fC8L3FQu54xmnMWSR
         +k8ydGwGRPXW0e96X4oDNKrEWqM/8yYKTH7B25xASRWAOzf/CfrkG1X7zr17VIEViDtf
         McssqgQx8AMztMPivt8JnCRym/Q2jPNeAolpaoyOHfjmnPbH/MtpG88JtJtmh9Tovxq+
         paGGHYNr7riEJAB4aXrDs35qLzey4Lc4UHV1IqA4QjNeba8k7w1kSOLGENb13mYPRvqv
         M33kyNt7+yhDwNFjvzj1BbhsErcLO+TixHLnFA7Uw9oqd2qa4UsrvHKMcdRmlQgmfaT4
         6zMQ==
X-Gm-Message-State: APjAAAUqC+mPbAV5ZdD79UcEhI6xCV3s3D4DJQPfJv+6vggpM2AUIKXE
        FLYJUhy1pqVoRm/l5eD2d+dmzUsQpuJuR1cx2eE=
X-Google-Smtp-Source: APXvYqx+NIxxp9mv/sB7SyV1Qm3YqkZnTg2FRvBsfJQePg3iyjIpbCa8rvmCm7gJpmy1GQ8jQcBaRomzUXaPGPGkH0k=
X-Received: by 2002:a02:8817:: with SMTP id r23mr3019136jai.120.1578468443128;
 Tue, 07 Jan 2020 23:27:23 -0800 (PST)
MIME-Version: 1.0
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 8 Jan 2020 09:27:12 +0200
Message-ID: <CAOQ4uxjFC81hikgg0WaF0Z3Mxkk3iDakKx2Ttuhp_L_2Tnc6xQ@mail.gmail.com>
Subject: Re: OverlaysFS offline tools
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        StuartIanNaylor <rolyantrauts@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        kmxz <kxzkxz7139@gmail.com>, "zhangyi (F)" <yi.zhang@huawei.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

[-fsdevel,+containers]

> On Thu, Apr 18, 2019 at 1:58 PM StuartIanNaylor <rolyantrauts@gmail.com> wrote:
> >
> > Apols to ask here but are there any tools for overlayFS?
> >
> > https://github.com/kmxz/overlayfs-tools is just about the only thing I
> > can find.
>
> There is also https://github.com/hisilicon/overlayfs-progs which
> can check and fix overlay layers, but it hasn't been updated in a while.
>

Hi Vivek (and containers folks),

Stuart has pinged me on https://github.com/StuartIanNaylor/zram-config/issues/4
to ask about the status of overlayfs offline tools.

Quoting my answer here for visibility to more container developers:

I have been involved with implementing many overlayfs features in the
kernel in the
past couple of years (redirect_dir,index,nfs_export,xino,metacopy).
All of these features bring benefits to end users, but AFAIK, they are
all still disabled
by default in containers runtimes (?) because lack of tools support
(e.g. migration
/import/export). I cannot force anyone to use the new overlayfs
features nor to write
offline tools support for them.

So how can we improve this situation?

If the problem is development resources then I've had great experience
in the past
with OSS internship programs like Google summer of code (GSoC):
Organizations, such as Redhat or mobyproject.org, can participate in the program
by posting proposals for open source projects.
Developers, such as myself, volunteer to mentors projects and students apply
to work on them.

IIRC, the timeline for GSoC for project proposals in around April. Applying as
an organization could be before that.

Vivek, since you are the only developer I know involved in containers runtime
projects I am asking you, but really its a question for all container developers
out there.

Are you aware of missing features in containers that could be met by filling the
gaps with overlayfs offline tools?
Are you a part of an organization that could consider posting this sort of
project proposals to GSoC or other internship programs?

Thanks,
Amir.
