Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86209242AD9
	for <lists+linux-unionfs@lfdr.de>; Wed, 12 Aug 2020 16:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgHLOD1 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 12 Aug 2020 10:03:27 -0400
Received: from vulcan.kevinlocke.name ([107.191.43.88]:34888 "EHLO
        vulcan.kevinlocke.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgHLODW (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 12 Aug 2020 10:03:22 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Aug 2020 10:03:22 EDT
Received: from kevinolos (2600-6c67-5080-46fc-8110-55a1-bd49-78cf.res6.spectrum.com [IPv6:2600:6c67:5080:46fc:8110:55a1:bd49:78cf])
        (Authenticated sender: kevin@kevinlocke.name)
        by vulcan.kevinlocke.name (Postfix) with ESMTPSA id 44CE51B58ACD
        for <linux-unionfs@vger.kernel.org>; Wed, 12 Aug 2020 13:55:33 +0000 (UTC)
Received: by kevinolos (Postfix, from userid 1000)
        id 4859A130056E; Wed, 12 Aug 2020 07:55:29 -0600 (MDT)
Date:   Wed, 12 Aug 2020 07:55:29 -0600
From:   Kevin Locke <kevin@kevinlocke.name>
To:     linux-unionfs@vger.kernel.org
Subject: EIO for removed redirected files?
Message-ID: <20200812135529.GA122370@kevinolos>
Mail-Followup-To: Kevin Locke <kevin@kevinlocke.name>,
        linux-unionfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi All,

I recently encountered files on an overlayfs which returned EIO
(Input/output error) for open, stat, and unlink (and presumably other)
syscalls.  I eventually determined that the files had been redirected
and the target removed from the lower level.  The behavior can be
reproduced as follows:

# Create overlay with foo.txt on lower level
mkdir -p lower upper work merged
touch lower/foo.txt
mount -t overlay -o lowerdir=lower,upperdir=upper,workdir=work,metacopy=on none merged

# Redirect bar.txt on upper to foo.txt on lower
mv merged/foo.txt merged/bar.txt

# Remove foo.txt on lower while unmounted
umount merged
rm lower/foo.txt

# open, stat, and unlink on bar.txt now fail with EIO:
mount -t overlay -o lowerdir=lower,upperdir=upper,workdir=work,metacopy=on none merged
cat merged/bar.txt
stat merged/bar.txt
rm merged/bar.txt

At this point, the only way to recover appears to be unmounting the
overlay and removing the file from upper (or updating the
overlay.redirect xattr to a valid location).  Is that correct?

Is this the intended behavior?  I didn't see any tests covering it in
unionmount-testsuite.  If so, perhaps the behavior could be noted in
"Changes to underlying filesystems" in
Documentation/filesystems/overlayfs.rst?  I'd be willing to write a
first draft.  (I doubt I understand it well enough to get everything
right on the first try.)

Also, if there is any way this could be made easier to debug, it might
be helpful for users, particularly newbies like myself.  Perhaps logging
bad redirects at KERN_ERR?  If that would be too noisy, perhaps only
behind a debug module option?  Again, if this is acceptable I'd be
willing to draft a patch.  (Same caveat as above.)

Thanks for considering,
Kevin
