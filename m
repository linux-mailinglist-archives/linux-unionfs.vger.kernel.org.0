Return-Path: <linux-unionfs+bounces-921-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ECB97B19A
	for <lists+linux-unionfs@lfdr.de>; Tue, 17 Sep 2024 16:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3607F1C213D5
	for <lists+linux-unionfs@lfdr.de>; Tue, 17 Sep 2024 14:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7104171099;
	Tue, 17 Sep 2024 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMlJQDh5"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F483535DC
	for <linux-unionfs@vger.kernel.org>; Tue, 17 Sep 2024 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726584674; cv=none; b=cyNaawGOGQQ9AmY/nMSsoyUIfLY1EK1i1o90hKXb1efD0kDcqu+bvsPeMFpzxZ4COSOw2bYnvNKxn6o8fe00KoVwiyYxNDaScskL9oATSJREZTr4ke6cevEFrOQV6uuITRDLWB6I4xJ+flqn1YT/pmBNVodHrmRW67NQ55XSGSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726584674; c=relaxed/simple;
	bh=GSAvo848APws1YK1CWDROXMlZk6aqGiNq2qNKesb+vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcXHt2U50WiGt1F3B45XkHziqbw1GbyNHWhOzw0nwvMQJXhYwYQSUjj0jIbg8bBxkE9A0sZnOf4ulUh+psyMDezORCq6M+CrMltZy4kKBfJ6T+glWq6ZmikyVK4NVh4JyC2LcXLCw4yDC/APRM4Ms50zeqzO/zuCMSsMVvfRGu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMlJQDh5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726584671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0S19n2xUOJPjKn7LEX93bWZmkDrf3H+c/LntcS+IUE=;
	b=SMlJQDh5nzDZ6MqlmXUPPx6556huhRkaCB7v6ciixJJMjSXjW3KjAabEpdtMiompAylS8F
	0cliQy03Am2ltgQRbiMiV75QfXMej0h7nx7nBTZ8g0jmkPTlZ1sCzu71QrwHMR5N1Rny+N
	iujfYeFAbt183naPku04DCI7oKeokfA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-gGcG1Op8O8a2vSpwi9UlHA-1; Tue, 17 Sep 2024 10:51:09 -0400
X-MC-Unique: gGcG1Op8O8a2vSpwi9UlHA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7177906db91so6039651b3a.3
        for <linux-unionfs@vger.kernel.org>; Tue, 17 Sep 2024 07:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726584669; x=1727189469;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G0S19n2xUOJPjKn7LEX93bWZmkDrf3H+c/LntcS+IUE=;
        b=cgWa2MV8R6oR/oUN57y6bSPZJzAFFUEXnTWOYyBTUzphVoKt9Oe1OeP+u9pgaBk/Bt
         D1fM7mSZCnIjzQ/I5UGnnMP5KZxjUfoyz+C1+BMmPSCO0Gqi2NE6z+LiLGX5dTzi1lpm
         sOcfuFRqo97wIJTwOU1N4V3fM+fpHEJSFxxXneMr4qVZGRI/iGvhYqYTuhnOP519VW4e
         OJEZOHoSJye8kswCZDWPajytV3TkIkdGKkK53LDJVmEMX9MsdW7d1wYI8WQa3l62wmny
         oJ/7mt9PIMq8MzRlzGAfr1z+PcgzG5s7uaeGb7HvIjhZxyjmMGknIDhQ4TkAIzXUk7s5
         1Zpg==
X-Forwarded-Encrypted: i=1; AJvYcCUDxdtyiS1+QtzzwPJpFjPDjTKYSlrclSb6LEVT+rTTue2Km8slEj9sPFzP9Y8pr7CsszX6Lo4+XAOMPoEd@vger.kernel.org
X-Gm-Message-State: AOJu0YxPb4I8YUWYNecuKeCdNKcrh1cgjTGsGLVy+zFxRMf5znAgiTym
	uIjttfwgjKX6i3cD73GlycPD6gT3baLLkeAaZi1KSaY9LAOgtT63cze9TPUhCby3DHUkl/zyf2w
	Mnm+WATRWoZ3a6MSMSxIEpUQjZ7NSVVguGYljVIDkfHLgEU3WeOKK1i+bdJW2Ppw=
X-Received: by 2002:a05:6a00:130b:b0:717:925a:299a with SMTP id d2e1a72fcca58-71936adf9efmr21183849b3a.19.1726584668723;
        Tue, 17 Sep 2024 07:51:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe5c4+wJWAlAHHwJASR7TRhjn9xe4rGPWqkNWmqYOUDaQ0KRmGp4s2pUgeHHOYv2jdRtPivQ==
X-Received: by 2002:a05:6a00:130b:b0:717:925a:299a with SMTP id d2e1a72fcca58-71936adf9efmr21183828b3a.19.1726584668231;
        Tue, 17 Sep 2024 07:51:08 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b132sm5292566b3a.117.2024.09.17.07.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 07:51:07 -0700 (PDT)
Date: Tue, 17 Sep 2024 22:51:04 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
	fstests@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] overlay: create a variant to syncfs error test xfs/546
Message-ID: <20240917145104.iqmsf24qn5loppvy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240830180844.857283-1-amir73il@gmail.com>
 <20240903042128.ksqua6ha47iayolq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAOQ4uxifYDgCmKEUQrbZWwL8JxmRnmPK3dGtVpMhq2cgGQ_etg@mail.gmail.com>
 <20240904025840.obxcbe22bud6ga2i@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAOQ4uxjDcgm9preuBY_5b+bbHpiLzVw+yKNj7KaeWs_1ye1Tqw@mail.gmail.com>
 <20240904112533.vbzp3nclece2sukg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAOQ4uxiTKJjgL16tL2iUzxBFAK+bLCsgfGaj3HGKq+nYWFMAnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiTKJjgL16tL2iUzxBFAK+bLCsgfGaj3HGKq+nYWFMAnQ@mail.gmail.com>

On Tue, Sep 17, 2024 at 04:37:04PM +0200, Amir Goldstein wrote:
> On Wed, Sep 4, 2024 at 1:25 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Wed, Sep 04, 2024 at 10:23:16AM +0200, Amir Goldstein wrote:
> > > On Wed, Sep 4, 2024 at 4:58 AM Zorro Lang <zlang@redhat.com> wrote:
> > > >
> > > > On Tue, Sep 03, 2024 at 08:41:28AM +0200, Amir Goldstein wrote:
> > > > > On Tue, Sep 3, 2024 at 6:21 AM Zorro Lang <zlang@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Aug 30, 2024 at 08:08:44PM +0200, Amir Goldstein wrote:
> > > > > > > Test overlayfs over xfs with and without "volatile" mount option.
> > > > > > >
> > > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > > > ---
> > > > > > >
> > > > > > > Zorro,
> > > > > > >
> > > > > > > I was going to make a generic test from xfs/546, so that overlayfs could
> > > > > > > also run it, but then I realized that ext4 does not behave as xfs in
> > > > > > > that case (it returns success on syncfs post shutdown).
> > > > > > >
> > > > > > > Unless and until this behavior is made a standard, I made an overlayfs
> > > > > > > specialized test instead, which checks for underlying fs xfs.
> > > > > > > While at it, I also added test coverage for the "volatile" mount options
> > > > > > > that is expected to return succuss in that case regardles of the
> > > > > > > behavior of the underlying fs.
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Amir.
> > > > > > >
> > > > > > >  tests/overlay/087     | 62 +++++++++++++++++++++++++++++++++++++++++++
> > > > > > >  tests/overlay/087.out |  4 +++
> > > > > > >  2 files changed, 66 insertions(+)
> > > > > > >  create mode 100755 tests/overlay/087
> > > > > > >  create mode 100644 tests/overlay/087.out
> > > > > > >
> > > > > > > diff --git a/tests/overlay/087 b/tests/overlay/087
> > > > > > > new file mode 100755
> > > > > > > index 00000000..a5afb0d5
> > > > > > > --- /dev/null
> > > > > > > +++ b/tests/overlay/087
> > > > > > > @@ -0,0 +1,62 @@
> > > > > > > +#! /bin/bash
> > > > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > > > +# Copyright (c) 2022 Oracle.  All Rights Reserved.
> > > > > > > +# Copyright (c) 2024 CTERA Networks.  All Rights Reserved.
> > > > > > > +#
> > > > > > > +# FS QA Test No. 087
> > > > > > > +#
> > > > > > > +# This is a variant of test xfs/546 for overlayfs
> > > > > > > +# with and without the "volatile" mount option.
> > > > > > > +# It only works over xfs underlying fs.
> > > > > > > +#
> > > > > > > +# Regression test for kernel commits:
> > > > > > > +#
> > > > > > > +# 5679897eb104 ("vfs: make sync_filesystem return errors from ->sync_fs")
> > > > > > > +# 2d86293c7075 ("xfs: return errors in xfs_fs_sync_fs")
> > > > > > > +#
> > > > > > > +# During a code inspection, I noticed that sync_filesystem ignores the return
> > > > > > > +# value of the ->sync_fs calls that it makes.  sync_filesystem, in turn is used
> > > > > > > +# by the syncfs(2) syscall to persist filesystem changes to disk.  This means
> > > > > > > +# that syncfs(2) does not capture internal filesystem errors that are neither
> > > > > > > +# visible from the block device (e.g. media error) nor recorded in s_wb_err.
> > > > > > > +# XFS historically returned 0 from ->sync_fs even if there were log failures,
> > > > > > > +# so that had to be corrected as well.
> > > > > > > +#
> > > > > > > +# The kernel commits above fix this problem, so this test tries to trigger the
> > > > > > > +# bug by using the shutdown ioctl on a clean, freshly mounted filesystem in the
> > > > > > > +# hope that the EIO generated as a result of the filesystem being shut down is
> > > > > > > +# only visible via ->sync_fs.
> > > > > > > +#
> > > > > > > +. ./common/preamble
> > > > > > > +_begin_fstest auto quick mount shutdown
> > > > > > > +
> > > > > > > +
> > > > > > > +# Modify as appropriate.
> > > > > > > +_require_xfs_io_command syncfs
> > > > > > > +_require_scratch_nocheck
> > > > > > > +_require_scratch_shutdown
> > > > > > > +
> > > > > > > +[ "$OVL_BASE_FSTYP" == "xfs" ] || \
> > > > > > > +     _notrun "base fs $OVL_BASE_FSTYP has unknown behavior with syncfs after shutdown"
> > > > > > > +
> > > > > > > +# Reuse the fs formatted when we checked for the shutdown ioctl, and don't
> > > > > > > +# bother checking the filesystem afterwards since we never wrote anything.
> > > > > > > +echo "=== syncfs after shutdown"
> > > > > > > +_scratch_mount
> > > > > > > +# This command is complicated a bit because in the case of overlayfs the
> > > > > > > +# syncfs fd needs to be opened before shutdown and it is different from the
> > > > > > > +# shutdown fd, so we cannot use the _scratch_shutdown() helper.
> > > > > > > +# Filter out xfs_io output of active fds.
> > > > > > > +$XFS_IO_PROG -x -c "open $(_scratch_shutdown_handle)" -c 'shutdown -f ' -c close -c syncfs $SCRATCH_MNT | \
> > > > > > > +     grep -vF '[00'
> > > > > > > +
> > > > > > > +# Now repeat the same test with a volatile overlayfs mount and expect no error
> > > > > > > +_scratch_unmount
> > > > > > > +echo "=== syncfs after shutdown (volatile)"
> > > > > > > +_scratch_mount -o volatile
> > > > > > > +$XFS_IO_PROG -x -c "open $(_scratch_shutdown_handle)" -c 'shutdown -f ' -c close -c syncfs $SCRATCH_MNT | \
> > > > > > > +     grep -vF '[00'
> > > > > >
> > > > > > Oh, the test steps are much different from xfs/546. If we move x/546 to generic/,
> > > > > > can overlay reproduce this bug by that?
> > > > >
> > > > > Yes and no.
> > > > >
> > > > > For overlayfs to support this as a generic test, the helper
> > > > > _scratch_shutdown_handle must be used and the shutdown+syncfs
> > > > > command must be complicated to something like this:
> > > > >
> > > > > $XFS_IO_PROG -x -c "open $(_scratch_shutdown_handle)" -c 'shutdown -f
> > > > > ' -c close -c syncfs $SCRATCH_MNT | \
> > > > >        grep -vF '[00'
> > > > >
> > > > > This is because overlayfs itself does not support the shutdown ioctl.
> > > > > If the test is moved to generic as it is we get an error when running
> > > > > overlayfs:
> > > > >
> > > > >     XFS_IOC_GOINGDOWN: Inappropriate ioctl for device
> > > > >
> > > > > because _require_scratch_shutdown is "supported" by overlayfs
> > > > > but only when the _scratch_shutdown helpers are used.
> > > >
> > > > Yeah, I know this.
> > > >
> > > > >
> > > > > If the test is to be moved as is, it will need to opt-out of overlayfs
> > > > > explicitly.
> > > >
> > > > I mean you have a "-o volatile" option test, that's an overlayfs specific
> > > > mount option. If you need that test, that's an overlay specific test, that
> > > > part can be an overlay specific test case. If not, we can use a generic
> > > > case (from xfs/546) to cover overlay and other fs.
> > >
> > > I need the -o volatile test regardless of moving xfs/546 to generic.
> > > That's why I posted this patch.
> >
> > OK, let's have two patches, one moves xfs/546 to generic/, the other
> > is this overlay specific test case.
> >
> 
> Hi Zorro,
> 
> I thought that you agreed to include the overlay specific test overlay/087,
> but I still do not see it in for-next.
> 
> Did I misunderstand you, or was it accidently left out of for-next?

Sorry, I thought you'd like to send another patch with this patch in your
next patchset. OK, I'll check this one singly, and try to merge it this
week.

Thanks,
Zorro

> 
> Regarding moving xfs/546 to generic/, I had sent a patch to ext4 [1],
> but no comment from Ted yet.
> 
> [1] https://lore.kernel.org/linux-ext4/20240904084657.1062243-1-amir73il@gmail.com/
> 
> > >
> > > >
> > > > BTW, we actually we have a common _scratch_shutdown helper, I'm wondering
> > > > if it works for this test? Likes:
> > > >
> > > >   _scratch_shutdown -f
> > > >   $XFS_IO_PROG -c syncfs $SCRATCH_MNT
> > > >
> > > > Can this work?
> > >
> > > Nope, because $XFS_IO_PROG -c syncfs $SCRATCH_MNT
> > > will fail (EIO) to open the directory after shutdown.
> > > That's why the dance with -c open -c close is needed.
> >
> > Oh, although below line:
> >   $XFS_IO_PROG -x -c "open $(_scratch_shutdown_handle)" -c 'shutdown -f ' -c close -c syncfs $SCRATCH_MNT
> >
> > trys to shudown on $(_scratch_shutdown_handle), then syncfs on $SCRATCH_MNT too.
> > But the difference is it opens $SCRATCH_MNT before shutdown, so that's what you
> > need.
> 
> Correct, this is why the dance with -c open -c close is needed when the test is
> overlayfs specific and/or generic.
> 
> Thanks,
> Amir.
> 


