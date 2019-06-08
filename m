Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D383A0E0
	for <lists+linux-unionfs@lfdr.de>; Sat,  8 Jun 2019 19:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfFHR2m (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sat, 8 Jun 2019 13:28:42 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33634 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfFHR2m (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sat, 8 Jun 2019 13:28:42 -0400
Received: by mail-io1-f65.google.com with SMTP id u13so3896789iop.0
        for <linux-unionfs@vger.kernel.org>; Sat, 08 Jun 2019 10:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DcrFWOJh5wY9/j+WZRfBdjv3RaYbdXFdrbR8rKdTuFc=;
        b=jDWy2JzOOAayllqOPszMn7pveCqR2nd23CcPvgOtrbqtbBEDl54hiRLq+E/S2bEDgc
         3ZYUvEOlRlrFvKbHuldCdBOEn6I/Cl0ZhhMtknjTDVXVxpxxLJu9LBbZYVfjc+GpTPt/
         d/6CyhtPOHQ/9NrFETykuHi3mVB+xqrfyBoKnDi1hPfMNV4HXRzpIp3YtB76G3Bzuz3W
         DqDf9VS6TxPYhryXrcKXtkcSrhhlrQ7bV8fVUlJpraOUa32JyL7HsCBecTHht3rYgNIe
         u1iwyoQ+dZEn53MZsvhB7tPrzd7HWtAxW0hhTolQ632B3+82sefbBMnhqrZKyFSWFMDi
         n4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DcrFWOJh5wY9/j+WZRfBdjv3RaYbdXFdrbR8rKdTuFc=;
        b=UOKQrRsh3z/eximcLJM/9YmNGd5noIUF5yihj+FySSWpf3hCAi619vhajzzcVUBYHG
         OjFTRsjxGdDQ7eY1M9gSAwtaY9Mwfb8+z5Bka9KUngwRZ1izcRbh0S0s1eSBLocqft+G
         eTjUQjHHEu5BxrXfePFWCX1zS7+XNqLdseJBhKLLGtpT0FtBAJOYWGgYewjU6o+ZQCgH
         wvvsXUInPkZ7Z6BebWII0o0TdoACsnz6sZ9037nT+RdOWMmp+73YTpswRWUcz/Ig5GoM
         gvo+SCBoRDJrIZyKwZlGjfNQIdnXDzycBNrMO6bbjmiA8C+foECV4+Apq6VijQurTIVd
         1fNw==
X-Gm-Message-State: APjAAAX9/hGudmfIZmXZPjcuUf0e/bPd4nN5YIJvR6EAW2kHoFvXhg27
        7MPtNGF1MsRwtfkrV3mJsAc=
X-Google-Smtp-Source: APXvYqzbHI7AYW8uYubTEDu/bHubu9FZUhcGSGm575gzYL4pdZ6kDJnuL0c/TdRBA48Ccwy0z+3Fog==
X-Received: by 2002:a5d:9291:: with SMTP id s17mr2063737iom.10.1560014920954;
        Sat, 08 Jun 2019 10:28:40 -0700 (PDT)
Received: from ?IPv6:2602:47:da8f:c200:f24d:a2ff:fedd:b812? ([2602:47:da8f:c200:f24d:a2ff:fedd:b812])
        by smtp.gmail.com with ESMTPSA id v187sm2501033ita.37.2019.06.08.10.28.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 10:28:40 -0700 (PDT)
Subject: Re: [PATCH v2] overlay: allow config override of metacopy/redirect
 defaults
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>
References: <20190607010431.11868-1-mcoffin13@gmail.com>
 <20190607205105.21858-1-mcoffin13@gmail.com>
 <CAOQ4uximPqsNivkqD36LdNfT4g41v2rtDm+OB6t2z40dpWs_og@mail.gmail.com>
From:   Matt Coffin <mcoffin13@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mcoffin13@gmail.com; keydata=
 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
 1Gcz6OdGWcLINzPXGZj6VyT4otaO/HPNCBuMGQ==
Message-ID: <f5b0bddd-678b-bdd9-6fc7-cc9e5b3211e5@gmail.com>
Date:   Sat, 8 Jun 2019 11:28:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uximPqsNivkqD36LdNfT4g41v2rtDm+OB6t2z40dpWs_og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Thanks for the comments, Amir. It's my first kernel patch so it's a
learning process.

I'll take a stab at fleshing out what the documentation would look like
for a different config system, and submit a patch for the redirect_dir
not showing in procfs bug. Unless there's opposition, I'll also add a
log line (similar to the one that warns about disabling metacopy) for
when redirect_dir becomes enabled due to an explicitly configured
metacopy for the mount point. A line like that in dmesg would have saved
me a log of trouble trying to figure out WHY this was happening in the
first place.

As far as docker goes, I think you're absolutely correct there. There's
no reason that the overlay2 backend shouldn't be passing these
parameters explicitly to the mount point. That said, even with the
visibility improvements above, it does seem odd to me that passing
"redirect_dir=0" explicitly to the module wouldn't actually disable it,
just because the "metacopy" parameter is defaulting it to being on. Even
if we display the overridden options in /proc/mounts, and log in dmesg,
it seems odd to me that a default on another setting would override an
explicitly passed other setting.

Hopefully, there won't be many people actually doing that globally once
the overlay2 backend behaves properly, but it still seems like odd
behavior to me; but, if that's intended and desired then it's not the
end of the world.

Thanks again for the comments and working with me. Sorry if the
[How]/[Why] formatting isn't the standard here, I just pulled it from
the amd-gfx mailing list since I've never submitted a patch before.

So, if one were to take a stab at implementing a more generic
configuration approach, what would the ideal desired behavior for the
options look like?

1. Should kernel config not be override-able? The current behavior is to
allow overriding kernel config with mount options/params. It might be
confusing to change that, so likely the desire would be to keep the
existing behavior?
2. Should mount options take precedence over module params? The current
behavior is that mount options take precedence, and likely I think
that's desired as well.

Thanks in advance for the help,
Matt Coffin

On 6/8/19 3:04 AM, Amir Goldstein wrote:
> Hi Matt,
> 
> Thank you for trying to address this, but I see problems both in Why and
> How you did it.
> 
> On Fri, Jun 7, 2019 at 11:51 PM Matt Coffin <mcoffin13@gmail.com> wrote:
>>
>> [Why]
>> Currently, if the redirect_dir option is set as a kernel or module
>> parameter, then even if metacopy is only enabled config, then both
>> metacopy and redirect_dir will be enabled when one creates a mount
>> point. This is not desirable because /sys/module/overlay/parameters will
>> still report that redirect_dir is not enabled
> 
> /sys/module/overlay/parameters reports that redirect_dir is not enabled
> *by default* not per mount.
> 
>> and there will be no redirect_dir=on line in the mount options in /proc/mounts.
> 
> That is a bug. This code:
> /* Automatically enable redirect otherwise. */
> config->redirect_follow = config->redirect_dir = true;
> 
> Needs to update of config->redirect_mode.
> 
> You are very welcome to send a fix patch.
> 
>> The behavior
>> of setting redirect_dir globally for overlay is likely a common pattern
>> on docker workstations, as redirect_dir makes for slower building of
>> docker images.
> 
> I haven't been following the progress in docker w.r.t redirect_dir,
> but IMO the right way for docker is to always mandate overlayfs
> mount option parameters based on user meaningful storage driver
> config options, see:
> https://github.com/moby/moby/pull/34342#issuecomment-320669900
> 
> Instead of depending on admin to set /sys/module/overlay/parameters
> globally, docker should always pass explicit redirect_dir,metacopy
> values in mount options.
> Docker should check for existence of /sys/module/overlay/parameters
> feature file to know if kernel supports the mount option.
> 
> BTW, docker should be treating metacopy exactly the same way as
> redirect_dir because the native diff driver does not know about metacopy,
> so docket should (IMO) disable metacopy in mount option unless user
> explicitly opted-in for in per image and fallback to naiive diff driver if
> user opted-in to enable metacopy.
> 
> IMO, docker overlay2 storage driver should have a well documented
> user meaningful per container option such as:
> "optimize for efficient runtime" (redirect_dir=on,metacopy=on)
> vs.
> "optimize for efficient image export" (redirect_dir=off,metacopy=off)
> 
> Or even simpler:
> "Exportable = true/false"
> Because users know if they run a container that they don't intend
> to export. In that case, it makes no sense to deny user of the benefits
> of redirect_dir=on,metacopy=on.
> 
>>
>> [How]
>> This patch adds similar logic to that already in place for parsing mount
>> parameters. If the user explicitly sets redirect_dir via a kernel or
>> module parameter, then metacopy will become disabled, unless it was also
>> specified that way. Obviously, mount options still take precedence over
>> this process, so this logic only kicks in when neither redirect_dir or
>> metacopy were specified in the mount options.
>>
> 
> If even we did pass the "Why", the "How" is unacceptable IMO.
> It extends something that is already a local special case hack
> with redirect_opt/metacopy_opt.
> 
> If we ever try to improve parameter/config/option parsing
> and dependency checks we need to do it in a much more generic
> way and there are much more things to consider.
> I am sorry that I cannot provide you guidelines for how to
> do this. I took a stab at this once, then Miklos said he will try to
> redo it and came back with:
> "...this is more complicated than I thought."
> https://marc.info/?l=linux-unionfs&m=154110487305120&w=2
> 
> If you do insist to try and follow this path, my only suggestion
> is - start with a patch to Documentation/filesystems/overlayfs.txt.
> If you cannot shortly and properly describe the behavior of
> your change in documentation it is a no go.
> 
> Thanks,
> Amir.
> 
