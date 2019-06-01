Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF78320A2
	for <lists+linux-unionfs@lfdr.de>; Sat,  1 Jun 2019 22:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfFAUB6 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sat, 1 Jun 2019 16:01:58 -0400
Received: from mail-vs1-f47.google.com ([209.85.217.47]:40752 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFAUB6 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sat, 1 Jun 2019 16:01:58 -0400
Received: by mail-vs1-f47.google.com with SMTP id c24so8906981vsp.7
        for <linux-unionfs@vger.kernel.org>; Sat, 01 Jun 2019 13:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=K928l8jamCNWvjxLXiT3xGNCthYYBnojmU2eY+D0ZWk=;
        b=RC4H2z4J09yhdu8xCYKib3A6/+hGRImsWaBuc0nsVLaaCcFmGUhMCiRZQFQ8YoSZ2z
         goML8C9l57n8UHA2Y9QumbXZxggoq787AS5VBGnYqZI4F28GqIeR92tZi2HIoMT4hRc9
         SJwg9sUrluYA0cZfTsVngycn9SDYn11f9JNxGtVDVCDYcsJ2YPa4JoZu2TiJYT8eccp+
         ZNNvAbA6wYY8uZH1WdqH2omKDO7IibNLprl+PEOR7TX7OQKO5opY5ddO2ht/dic7MRaj
         Pl26lqAPUetVNztED+aP+7MtDRZESsiUx9iLMFpxJNGtI6X+BX0uy6nznU489GoU36LG
         wYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=K928l8jamCNWvjxLXiT3xGNCthYYBnojmU2eY+D0ZWk=;
        b=gATlfYNSJwpkahZQSozxTFYL/9c6sr1AjjMm1CXc8rZ8yUlI/1Y+TEkYFSCpFeRFAv
         M8LapXXyMpPQdnK3wiU09PFG69OH3xpBZmlTota00ZjCwewO730V5Ncb7/0BOva8E1q0
         dMp4DGJDCvlxdyBCTP2TMFHSNrKXhBV2FMtJh27Af7cN6HmvLHcCmZQstqGv5fF1W83w
         31tW+M9/mSjJvYMVv6fyD/GClQh2jDT+M76//1woR4slkHM5uWyi8XkTMUckmAGJxv54
         6f5yVMpJnrcClyvnD9aB27BqXsP/PlG80stoec9sx6hRP6IfsI0yj6kutQRimOkIQqa1
         Su0g==
X-Gm-Message-State: APjAAAXkdaFtGQ05noLYlXsx5BiHpB4qhiniYxFqCSKQd/4qZiqLGYgh
        IbCsSkZOI0BcrcvT96go4F37quLZbGYYa2qaZY+OmtpkLAk=
X-Google-Smtp-Source: APXvYqxUd5ZHuqi9r0jJHyo1EFD3T8VPg8dwb9S9tSs59LQTLTtjcDwf/SFS0jGw8lx4BHdcy3l0i1SCTAv6AX9jeIw=
X-Received: by 2002:a67:f78d:: with SMTP id j13mr6343979vso.67.1559419316344;
 Sat, 01 Jun 2019 13:01:56 -0700 (PDT)
MIME-Version: 1.0
From:   Marco Nelissen <marco.nelissen@gmail.com>
Date:   Sat, 1 Jun 2019 13:01:45 -0700
Message-ID: <CAH2+hP4Q3i4LdKL2Cz=1uWq0+JSD1RnzcdmicDtCeqEUqLo+hg@mail.gmail.com>
Subject: which lower filesystems are actually supported?
To:     linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

According to the documentation, "The lower filesystem can be any filesystem
supported by Linux", however this appears to not actually be the case, since
using a vfat filesystem results in the mount command printing "mount:
wrong fs type, bad option, bad superblock on overlay, missing codepage or
helper program, or other error", with dmesg saying "overlayfs: filesystem on
'/boot' not supported".
(that's from ovl_mount_dir_noesc(), when ovl_dentry_weird() returns nonzero)

Should vfat be supported, or is the documentation wrong? If the documentation
is wrong, what other filesystems are (not) supported?
