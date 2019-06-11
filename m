Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDCC418A6
	for <lists+linux-unionfs@lfdr.de>; Wed, 12 Jun 2019 01:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405148AbfFKXJo (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 11 Jun 2019 19:09:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404669AbfFKXJn (ORCPT <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 11 Jun 2019 19:09:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D0563083392;
        Tue, 11 Jun 2019 23:09:43 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-22.rdu2.redhat.com [10.10.112.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B55C25DD80;
        Tue, 11 Jun 2019 23:09:31 +0000 (UTC)
Reply-To: dwalsh@redhat.com
Subject: Re: [PATCH v2] overlay: allow config override of metacopy/redirect
 defaults
To:     Matt Coffin <mcoffin13@gmail.com>, Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Nalin Dahyabhai <nalin@redhat.com>
References: <20190607205105.21858-1-mcoffin13@gmail.com>
 <CAOQ4uximPqsNivkqD36LdNfT4g41v2rtDm+OB6t2z40dpWs_og@mail.gmail.com>
 <f5b0bddd-678b-bdd9-6fc7-cc9e5b3211e5@gmail.com>
 <CAOQ4uxjQQcrcpxhtu3kAJvGaK+xd5TfNB=7_UnNciGj990DN6Q@mail.gmail.com>
 <CAJfpegvy-Vfc6AEP7+=VfUtfL4izY8AzgoUdvqP4PHnLDEQhNg@mail.gmail.com>
 <20190610184043.GD25290@redhat.com> <20190610184553.GE25290@redhat.com>
 <CAJfpegvrOy3yBpu1AVBFyjdXBNM44k4gSqQ0F2npBG8wH8cUeg@mail.gmail.com>
 <20190611130932.GA28835@redhat.com>
 <cb363beb-9b2e-1d20-ca46-cba7724ec648@redhat.com>
 <20190611214951.GC28835@redhat.com>
 <be9bfd25-ff48-bd9e-25ff-aa2a5f5873ed@gmail.com>
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
Message-ID: <d6eabcef-0b8b-2c00-a39a-0283c9c674c1@redhat.com>
Date:   Tue, 11 Jun 2019 19:09:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <be9bfd25-ff48-bd9e-25ff-aa2a5f5873ed@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 11 Jun 2019 23:09:43 +0000 (UTC)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On 6/11/19 5:57 PM, Matt Coffin wrote:
> This could just be because I don't understand the implications here, but
> wouldn't it be easier, at least for now, to just mount with
>
> redirect_dir=0,metacopy=0
We want the advantages of metacopy for use with User Namespace.
> in the mount parameters when building images, but allow the user's
> default settings to still take over when just executing a container?
>
> On 6/11/19 3:49 PM, Vivek Goyal wrote:
>> On Tue, Jun 11, 2019 at 05:44:33PM -0400, Daniel Walsh wrote:
>>> On 6/11/19 9:09 AM, Vivek Goyal wrote:
>>>> On Tue, Jun 11, 2019 at 02:37:34PM +0200, Miklos Szeredi wrote:
>>>>> On Mon, Jun 10, 2019 at 8:45 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>>>>> AFAICS what happens when generating a layer is to start with a clean
>>>>> upper layer, do some operations, then save the contents of the upper
>>>>> layer.  If redirect or metacopy is enabled, then the contents of the
>>>>> upper layer won't be portable.  So need to do something like this:
>>>>>
>>>>> traverse(overlay_dir, upper_dir, target_dir)
>>>>> {
>>>>>     iterate name for entries in $upper_dir {
>>>>>         if ($name is non-directory) {
>>>>>             copy($overlay_dir/$name, $target_dir/$name)
>>>>>         } else if ($name is redirect) {
>>>>>             copy-recursive($overlay_dir/$name, $target_dir/$name)
>>>>>         } else {
>>>>>             copy($overlay_dir/$name, $target_dir/$name)
>>>>>             traverse($overlay_dir/$name, $upper_dir/$name, $target_dir/$name)
>>>>>         }
>>>>>     }
>>>>> }
>>>>>
>>>>> Basically: traverse the *upper layer* but copy files and directories
>>>>> from the *overlay*.  Does that make sense?


