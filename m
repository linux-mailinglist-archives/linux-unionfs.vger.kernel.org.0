Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 961D041713
	for <lists+linux-unionfs@lfdr.de>; Tue, 11 Jun 2019 23:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405135AbfFKVoi (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 11 Jun 2019 17:44:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404730AbfFKVoi (ORCPT <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 11 Jun 2019 17:44:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E295685542;
        Tue, 11 Jun 2019 21:44:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47BFC5D721;
        Tue, 11 Jun 2019 21:44:36 +0000 (UTC)
Reply-To: dwalsh@redhat.com
Subject: Re: [PATCH v2] overlay: allow config override of metacopy/redirect
 defaults
To:     Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Matt Coffin <mcoffin13@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Nalin Dahyabhai <nalin@redhat.com>
References: <20190607010431.11868-1-mcoffin13@gmail.com>
 <20190607205105.21858-1-mcoffin13@gmail.com>
 <CAOQ4uximPqsNivkqD36LdNfT4g41v2rtDm+OB6t2z40dpWs_og@mail.gmail.com>
 <f5b0bddd-678b-bdd9-6fc7-cc9e5b3211e5@gmail.com>
 <CAOQ4uxjQQcrcpxhtu3kAJvGaK+xd5TfNB=7_UnNciGj990DN6Q@mail.gmail.com>
 <CAJfpegvy-Vfc6AEP7+=VfUtfL4izY8AzgoUdvqP4PHnLDEQhNg@mail.gmail.com>
 <20190610184043.GD25290@redhat.com> <20190610184553.GE25290@redhat.com>
 <CAJfpegvrOy3yBpu1AVBFyjdXBNM44k4gSqQ0F2npBG8wH8cUeg@mail.gmail.com>
 <20190611130932.GA28835@redhat.com>
From:   Daniel Walsh <dwalsh@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dwalsh@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFsaqOEBCADBSnZCZpi262vX8m7iL/OdHKP9G9dhS28FR60cjd8nMPqHDNhQJBjLMZra
 66L2cCIEhc4HEItail7KU1BckrMc4laFaxL8tLoVTKHZwb74n2OcAJ4FtgzkNNlB1XJvSwC/
 909uwt7cpDqwXpJvyP3t17iuklB1OY0EEjTDt9aU4+0QjHzV18L4Cpd9iQ4ksu+EHT+pjlBk
 DdQB+hKoAjxPl11Eh6pZfrAcrNWpYBBk0A3XE9Jb6ghbmHWltNgVOsCa9GcswJHUEeFiOup6
 J5DTv6Xzwt0t6QB8nIs+wDJH+VxqAXcrxscnAhViIfGGS2AtxzjnVOz/J+UZPaauIGXTABEB
 AAG0LERhbmllbCBKIFdhbHNoIChGb3IgR2l0KSA8ZHdhbHNoQHJlZGhhdC5jb20+iQE4BBMB
 AgAiBQJbGqjhAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCi35Adq+LAKHuJB/98
 nZB5RmNjMWua4Ms8q5a1R9XWlDAb3mrST6JeL+uV/M0fa18e2Aw4/hi/WZHjAjoypLmcuaRx
 GeCbC8iYdpfRDUG79Y956Qq+Vs8c6VfNDMY1mvtfb00eeTaYoOCu0Aa9LDeR9iLKh2g0RI+N
 Zr3EU45RxZdacIs1v6mU8pGpyUq/FvuTGK9GzR9d1YeVCuSpQKN4ckHNZHJUXyk0vOZft1oO
 nSgLqM9EDWA+yz1JLmRYwbNsim7IvfVOav5mCgnKzHcL2mLv8qCnMFZjoQV8aGny/W739Z3a
 YJo1CdOg6zSu5SOvmq9idYrBRkwEtyLXss2oceTVBs0MxqQ/9mLPuQENBFsaqOEBCADDl2hl
 bUpqJGgwt2eQvs0Z0DCx/7nn0hlLfEn4WAv2HqP25AjIRXUX31Mzu68C4QnsvNtY4zN+FGRC
 EfUpYsjiL7vBYlRePhIohyMYU4RLp5eXFQKahHO/9Xlhe8mwueQNwYxNBPfMQ65U2AuqxpcS
 scx4s5w208mhqHoKz6IB2LuKeflhYfH5Y1FNAtVGHfhg22xlcAdupPPcxGuS4fBEW6PD/SDf
 Y4HT5iUHsyksQKjM0IFalqZ7YuLfXBl07OD2zU7WI9c3W0dwkvwIRjt3aD4iAah544uOLff+
 BzfxWghXeo80S2a1WCL0S/2qR0NVct/ExaDWboYr/bKpTa/1ABEBAAGJAR8EGAECAAkFAlsa
 qOECGwwACgkQot+QHaviwCi2hgf/XRvrt+VBmp1ZFxQAR9E6S7AtRT8KSytjFiqEC7TpOx3r
 2OZ4gZ3ZiW4TMW8hS7aYRgF1uYpLzl7BbrCfCHfAWEcXZ+uG8vayg8G/mLAcNlLY+JE76ATs
 53ziEY9R2Vb/wLMFd2nNBdqfwGcRH9N9VOej9vP76nCP01ZolY8Nms2hE383/+1Quxp5EedU
 BN5W5l7x9riBJyqCA63hr4u8wNsTuQgrDyhm/U1IvYeLtMopgotjnIR3KiTKOElbppLeXW3w
 EO/sQTPk+vQ4vcsJYY9Dnf1NlvHE4klj60GHjtjitsBEHzdE7s+J9FOxPmt8l+gMogGumKpN
 Y4lO0pfTyg==
Organization: Red Hat
Message-ID: <cb363beb-9b2e-1d20-ca46-cba7724ec648@redhat.com>
Date:   Tue, 11 Jun 2019 17:44:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611130932.GA28835@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 11 Jun 2019 21:44:37 +0000 (UTC)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On 6/11/19 9:09 AM, Vivek Goyal wrote:
> On Tue, Jun 11, 2019 at 02:37:34PM +0200, Miklos Szeredi wrote:
>> On Mon, Jun 10, 2019 at 8:45 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>>> On Mon, Jun 10, 2019 at 02:40:43PM -0400, Vivek Goyal wrote:
>>>> On Sun, Jun 09, 2019 at 09:14:38PM +0200, Miklos Szeredi wrote:
>>>>> On Sat, Jun 8, 2019 at 8:47 PM Amir Goldstein <amir73il@gmail.com> wrote:
>>>>>
>>>>>> And then every time that a feature needs to be turned off for some reason
>>>>>> that also needs to be taken into account.
>>>>>> IOW, I advise against diving into this mess. You have been warned ;-)
>>>>> Also a much more productive direction would be to optimize building
>>>>> the docker image based on the specific format used by overlayfs for
>>>>> readirect_dir/metacopy.
>>>>>
>>>>> To me it seems like a no-brainer, but I don't know much about docker, so...
>>>> [ cc Daniel Walsh]
>>>>
>>>> Hi Miklos,
>>>>
>>>> Can you elaborate a bit more on what docker/container-storoage and do
>>>> here to expedite image generation with redirect_dir/metacopy enabled.
>>>>
>>>> They can't pack these xattrs in image because image will not be portable.
>>>> It will be overlayfs specific and can't be made to work on target without
>>>> overlayfs.
>>> Are you referring to apps being able to traverse lower layers and do
>>> the redirect_dir and metacopy resoltion as kernel does. To me that process
>>> is not trivial. Having a library might help with adoption though.
>> AFAICS what happens when generating a layer is to start with a clean
>> upper layer, do some operations, then save the contents of the upper
>> layer.  If redirect or metacopy is enabled, then the contents of the
>> upper layer won't be portable.  So need to do something like this:
>>
>> traverse(overlay_dir, upper_dir, target_dir)
>> {
>>     iterate name for entries in $upper_dir {
>>         if ($name is non-directory) {
>>             copy($overlay_dir/$name, $target_dir/$name)
>>         } else if ($name is redirect) {
>>             copy-recursive($overlay_dir/$name, $target_dir/$name)
>>         } else {
>>             copy($overlay_dir/$name, $target_dir/$name)
>>             traverse($overlay_dir/$name, $upper_dir/$name, $target_dir/$name)
>>         }
>>     }
>> }
>>
>> Basically: traverse the *upper layer* but copy files and directories
>> from the *overlay*.  Does that make sense?
> [ cc nalin ]
>
> Aha... This makes sense to me. This does away with need of separate
> library or user space tool and hopefully its faster than naivediff
> interface. 
>
> Dan, Nalin, what do you think about above idea.
>
> Thanks
> Vivek

This is something we would add to containers/storage?

