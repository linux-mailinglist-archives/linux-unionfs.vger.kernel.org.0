Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE833EAAE0
	for <lists+linux-unionfs@lfdr.de>; Thu, 12 Aug 2021 21:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhHLTYd (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 12 Aug 2021 15:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38308 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231331AbhHLTYc (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 12 Aug 2021 15:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628796246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8N86vzBdNfGIw1497CO2pBCfWWqdNZr9GKs8Sj+sQpI=;
        b=LIpTaVRmcRILJgdF0PAQaWjGXprX7N0Ib8w/me6HXxfiG5JqvllOzvBf3KB22UwKtmcoth
        0Hc1VCIb9yaOba/LX/p1yvhQWH9xaGC1LHn5+dk6NbqGQ4yZC4fuAMl+v3mGSS1BAGjOlg
        a5fGl4gM6ydAsVcsvsxOHr9yoLeyRiE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-byICGm-DPQqvatDSZvCYZg-1; Thu, 12 Aug 2021 15:24:05 -0400
X-MC-Unique: byICGm-DPQqvatDSZvCYZg-1
Received: by mail-wr1-f71.google.com with SMTP id v18-20020adfe2920000b029013bbfb19640so2144371wri.17
        for <linux-unionfs@vger.kernel.org>; Thu, 12 Aug 2021 12:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8N86vzBdNfGIw1497CO2pBCfWWqdNZr9GKs8Sj+sQpI=;
        b=k0ELd64LixW3HATYqE/90fOs8xfRd6zFQIhW+wcz2yqIt/hhGK8/Ef3xz8BGLqXKRL
         w6uotqpIqwuv254G+f1A6quZsiv5W7UOjHmtdX4Q/kDc7ehOmk+67Zi2HHOEZoKMH7Fd
         C6Fox/2hTyPKeIs4SRyXe2xykHYO3NUsxYm4zpdNshmOEMtqiOUFrwrFbYN2c823p5lL
         dtfc/qI8/fTp5EHjh5VrMStfj2e1VQLvO4uwyqLIAtmtU5GLXhCSoAQwHmvVTN8v20aD
         SWMMsVM040HJvn14o/TrRP/I9b6xI0cWQKnmnrz7+VvHfns/OYVDHSiDhrqiXzdG8aXH
         J/qw==
X-Gm-Message-State: AOAM531Y7HD83qvaWPauwZCRpk1oxForA+avJ3db173RQdU40QERZxnP
        3WwQJD0e7THX6bvEP7EHMyDt1jv7L9N5KfqWPrtaV74NybT3nCveAJhCLqOwxiie8xDb+Fi8k4y
        5FJX2RSUab4sdDEuM4mvMnoKqqw==
X-Received: by 2002:a05:600c:1552:: with SMTP id f18mr160504wmg.40.1628796243840;
        Thu, 12 Aug 2021 12:24:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoi73TjuPhfXBY9qVs1gNFHq5iS0Cg54p1SYixusgscxJCJ6YZqkOPk8ytKcP9LVXjwJLvRw==
X-Received: by 2002:a05:600c:1552:: with SMTP id f18mr160487wmg.40.1628796243648;
        Thu, 12 Aug 2021 12:24:03 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d8b.dip0.t-ipconnect.de. [79.242.61.139])
        by smtp.gmail.com with ESMTPSA id m10sm3080907wro.63.2021.08.12.12.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 12:24:02 -0700 (PDT)
Subject: Re: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Michel Lespinasse <walken@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Price <steven.price@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Marco Elver <elver@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Collin Fijalkovich <cfijalkovich@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-unionfs@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
 <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com>
 <87lf56bllc.fsf@disp2133>
 <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <0ab1a811-4040-2657-7b48-b39ada300749@redhat.com>
Date:   Thu, 12 Aug 2021 21:24:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On 12.08.21 20:10, Linus Torvalds wrote:
> On Thu, Aug 12, 2021 at 7:48 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Given that MAP_PRIVATE for shared libraries is our strategy for handling
>> writes to shared libraries perhaps we just need to use MAP_POPULATE or a
>> new related flag (perhaps MAP_PRIVATE_NOW)
> 
> No. That would be horrible for the usual bloated GUI libraries. It
> might help some (dynamic page faults are not cheap either), but it
> would hurt a lot.

Right, we most certainly don't want to waste system ram / swap space, 
memory for page tables, and degrade performance just because some 
corner-case nasty user space could harm itself.

> 
> This is definitely a "if you overwrite a system library while it's
> being used, you get to keep both pieces" situation.

Right, play stupid games, win stupid prices. I agree that if there would 
be an efficient way to detect+handle such overwrites gracefully, it 
would be great to have the kernel support that. ETXTBUSY as implemented 
with this series (but also before this series) is really only a 
minimalistic approach to help detect some issues regarding the main 
executable.

-- 
Thanks,

David / dhildenb

