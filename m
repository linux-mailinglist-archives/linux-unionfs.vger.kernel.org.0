Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B058A58CDD9
	for <lists+linux-unionfs@lfdr.de>; Mon,  8 Aug 2022 20:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244489AbiHHSmt (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 8 Aug 2022 14:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244274AbiHHSmd (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 8 Aug 2022 14:42:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABC3265B;
        Mon,  8 Aug 2022 11:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A00CB8105A;
        Mon,  8 Aug 2022 18:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFDC8C433D7;
        Mon,  8 Aug 2022 18:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659984127;
        bh=yLXDTzKoagr2Gvnlghalzf4R7piz3/N6jNOnhwk3gh8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=a8vs1LFB/Durhi6rRJiI8XWFLAfkg5c37scdQuwwS0cZKZbvXq4j2/FDckQlUUIkA
         DstzjsO+DgRCVv8RmY6nIWxND7t13RmQY+I4QqoJilUx4GKQ8lpji2fgNZhQE2CZv3
         NR2+3p73z9rZTGxijaLyK1ehnVEm7ZS+Tgkzoj8c07gkhHx+P5j9V7+G4NE+ALSfmS
         bYk5TXyGUm6QX2sH0Iu2EeiWInupiUMATcRKdWhA8IKV+R+udByKtnWp08OzuLEOkH
         qYnmLRaEQQ2hZvWoF2oIbBXoEl59v4ZtAYfZ/msopdbn3ereWjx8kcmdScScpylY3e
         GfnMU5UK1lucg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD227C43142;
        Mon,  8 Aug 2022 18:42:06 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs update for 6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YvD/cnBLsE8P8sWS@miu.piliscsaba.redhat.com>
References: <YvD/cnBLsE8P8sWS@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YvD/cnBLsE8P8sWS@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-6.0
X-PR-Tracked-Commit-Id: 4f1196288dfb6fc63e28e585392f2df3b8a63388
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65512eb0e9e6308ca08110c88a9619a9e5a19aa9
Message-Id: <165998412690.757.7088500334461976484.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Aug 2022 18:42:06 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

The pull request you sent on Mon, 8 Aug 2022 14:20:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65512eb0e9e6308ca08110c88a9619a9e5a19aa9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
