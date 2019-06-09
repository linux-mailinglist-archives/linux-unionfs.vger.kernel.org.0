Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D96023AB9A
	for <lists+linux-unionfs@lfdr.de>; Sun,  9 Jun 2019 21:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfFITOu (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 9 Jun 2019 15:14:50 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54532 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729163AbfFITOu (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 9 Jun 2019 15:14:50 -0400
Received: by mail-it1-f195.google.com with SMTP id m138so8504296ita.4
        for <linux-unionfs@vger.kernel.org>; Sun, 09 Jun 2019 12:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P5Pd/Hc+J/D+S818ZNSPGXdANB/70Kck426UUxoe1U8=;
        b=b+0uwLBKwNE5aHoBiTJqP4UvzvwemF0nlc45qvxqzRwyW9lXfRBOcZ6/XjkRVAbrof
         X7s5OA6Pa4jQxxupcVOYPrc5OIAmxX0bcB1DoPvyLuLH7sAXPhZbw/AAiwHYQc59Y0Ie
         ndEsHsJPYVnFlSz9GQjl2fd65QKFK4JQm854E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5Pd/Hc+J/D+S818ZNSPGXdANB/70Kck426UUxoe1U8=;
        b=Et6TzL7UwL3adTjqVaIymhqVVXdNZWJO+poZHap6orALum8ukHJOSldIu1y/5Jj5Ir
         u2aTjRUu02rDLJDUkjllwQdVhkh6p3WGd1rKgQTD3dekDR7RgHHEF3UHvjJg1lbEqGU3
         CgPq/Imv2ut4/PbAG+WEEWPcVPVbb7/6QvqFPAjN55Uqp32AUNq7Ul1TmWqoPmbQkJWJ
         3JKD1uUz2miLFG0ioH/ImgPe4lag2/w6KlDL4pAvl9FY5WxCjswntkpqYuk4Q0U37luv
         pM2QTHjD4YDQx+u/s9YJExBH9Q/hTG1tOnQjbZF+u2qrQv+V69g7ZGshjQc5cYoG1aJO
         QHzA==
X-Gm-Message-State: APjAAAXHXZ9hZiNTMMFbAa2hvvdFFQlPRd1WY84WLxOgoPFYRsAmD37v
        +DEGehL4Z1NaE01dwRjnAf6BFiL4g6ru6jM7O6oYqA==
X-Google-Smtp-Source: APXvYqxW6QD48CCnqGkIG2VEn4gNoIzr2dM8ua3FphJvHV2kvI88V7pgUdUGczaKTPdIJW+XlP72Eq2z3zVdH0dieQ0=
X-Received: by 2002:a24:292:: with SMTP id 140mr12340371itu.57.1560107689276;
 Sun, 09 Jun 2019 12:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190607010431.11868-1-mcoffin13@gmail.com> <20190607205105.21858-1-mcoffin13@gmail.com>
 <CAOQ4uximPqsNivkqD36LdNfT4g41v2rtDm+OB6t2z40dpWs_og@mail.gmail.com>
 <f5b0bddd-678b-bdd9-6fc7-cc9e5b3211e5@gmail.com> <CAOQ4uxjQQcrcpxhtu3kAJvGaK+xd5TfNB=7_UnNciGj990DN6Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxjQQcrcpxhtu3kAJvGaK+xd5TfNB=7_UnNciGj990DN6Q@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Sun, 9 Jun 2019 21:14:38 +0200
Message-ID: <CAJfpegvy-Vfc6AEP7+=VfUtfL4izY8AzgoUdvqP4PHnLDEQhNg@mail.gmail.com>
Subject: Re: [PATCH v2] overlay: allow config override of metacopy/redirect defaults
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Matt Coffin <mcoffin13@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Sat, Jun 8, 2019 at 8:47 PM Amir Goldstein <amir73il@gmail.com> wrote:

> And then every time that a feature needs to be turned off for some reason
> that also needs to be taken into account.
> IOW, I advise against diving into this mess. You have been warned ;-)

Also a much more productive direction would be to optimize building
the docker image based on the specific format used by overlayfs for
readirect_dir/metacopy.

To me it seems like a no-brainer, but I don't know much about docker, so...

Thanks,
Miklos
