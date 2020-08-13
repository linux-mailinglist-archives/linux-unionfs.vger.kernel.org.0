Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93364243E35
	for <lists+linux-unionfs@lfdr.de>; Thu, 13 Aug 2020 19:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgHMRWX (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 13 Aug 2020 13:22:23 -0400
Received: from vulcan.kevinlocke.name ([107.191.43.88]:45010 "EHLO
        vulcan.kevinlocke.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgHMRWX (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 13 Aug 2020 13:22:23 -0400
Received: from kevinolos (host-69-145-60-23.bln-mt.client.bresnan.net [69.145.60.23])
        (Authenticated sender: kevin@kevinlocke.name)
        by vulcan.kevinlocke.name (Postfix) with ESMTPSA id A7CF91B6037A;
        Thu, 13 Aug 2020 17:22:20 +0000 (UTC)
Received: by kevinolos (Postfix, from userid 1000)
        id A49AC1305EC3; Thu, 13 Aug 2020 11:22:18 -0600 (MDT)
Date:   Thu, 13 Aug 2020 11:22:18 -0600
From:   Kevin Locke <kevin@kevinlocke.name>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: EIO for removed redirected files?
Message-ID: <20200813172218.GA298313@kevinolos>
Mail-Followup-To: Kevin Locke <kevin@kevinlocke.name>,
        Amir Goldstein <amir73il@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
References: <20200812135529.GA122370@kevinolos>
 <CAOQ4uxih2aDb7_LPSUb5Q4xBL5_gDaqtmC0M0M4EtCDgKLvi3w@mail.gmail.com>
 <20200812160513.GA249458@kevinolos>
 <CAOQ4uxi23Zsmfb4rCed1n=On0NNA5KZD74jjjeyz+et32sk-gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi23Zsmfb4rCed1n=On0NNA5KZD74jjjeyz+et32sk-gg@mail.gmail.com>
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Thanks again Amir!  I'll work on patches for the docs and adding
pr_warn_ratelimited() for invalid metacopy/redirect as soon as I get a
chance.

On Wed, 2020-08-12 at 20:06 +0300, Amir Goldstein wrote:
> On Wed, Aug 12, 2020 at 7:05 PM Kevin Locke <kevin@kevinlocke.name> wrote:
>> On Wed, 2020-08-12 at 18:21 +0300, Amir Goldstein wrote:
>>> I guess the only thing we could document is that changes to underlying
>>> layers with metacopy and redirects have undefined results.
>>> Vivek was a proponent of making the statements about outcome of
>>> changes to underlying layers sound more harsh.
>>
>> That sounds good to me.  My current use case involves offline changes to
>> the lower layer on a routine basis, and I interpreted the current
> 
> You are not the only one, I hear of many users that do that, but nobody ever
> bothered to sit down and document the requirements - what exactly is the
> use case and what is the expected outcome.

I can elaborate a bit.  Keep in mind that it's a personal use case which
is flexible, so it's probably not worth supporting specifically, but may
be useful to discuss/consider:

A few machines that I manage are dual-boot between Windows and Linux,
with software that runs on both OSes (Steam).  This software installs a
lot (>100GB) of semi-static data which is mostly (>90%) the same between
OSes, but not partitioned by folder or designed to be shared between
them.  The software includes mechanisms for validating the data files
and automatically updating/repairing any files which do not match
expectations.

I currently mount an overlayfs of the Windows data directory on the
Linux data directory to avoid storing multiple copies of common data.
After any data changes in Windows, I re-run the data file validation in
Linux to ensure the data is consistent.  I also occasionally run a
deduplication script[1] to remove files which may have been updated on
Linux and later updated to the same contents on Windows.

To support this use, I'm looking for a way to configure overlayfs such
that offline changes to the lower dir do not break things in a way that
can't be recovered by naive file content validation.  Beyond that, any
performance-enhancing and space-saving features are great.

metacopy and redirection would be nice to have, but are not essential as
the program does not frequently move data files or modify their
metadata.  If accessing an invalid metacopy behaved like a 0-length
file, it would be ideal for my use case (since it would be deleted and
re-created by file validation) but I can understand why this would be
undesirable for other cases and problematic to implement.  (I'm
experimenting with seccomp to prevent/ignore metadata changes, since the
program should run on filesystems which do not support them.  An option
to ignore/reject metadata changes would be handy, but may not be
justified.)

Does that explain?  Does it seem reasonable?  Is disabling metacopy and
redirect_dir likely to be sufficient?

Best,
Kevin

[1]: Do you know of any overlayfs-aware deduplication programs?  If not,
I may consider cleaning up and publishing mine at some point.
