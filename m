Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3DF701F3E
	for <lists+linux-unionfs@lfdr.de>; Sun, 14 May 2023 21:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjENTWb (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sun, 14 May 2023 15:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjENTWb (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sun, 14 May 2023 15:22:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B221E4E
        for <linux-unionfs@vger.kernel.org>; Sun, 14 May 2023 12:22:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B94C96106E
        for <linux-unionfs@vger.kernel.org>; Sun, 14 May 2023 19:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BA6C433EF;
        Sun, 14 May 2023 19:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684092149;
        bh=igJIyKpflq3ZdDQLT8vidW1QaAmqyDBdhF6YagIwwcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t5G7UXPNG4NLxnZ7yC+tONFhY9GtTwvB43PmCh5/jfVbxJRwNC0Qj8Uwfm0VG40BX
         BQTYSmsbpWCFr92J5bLjkCxE+Fo6mFAGXHue3gysaZxgJoREpy1dFxu2/MmeThh6v0
         UUiT6COAoJolwEF3L7ly4fi2xzpTuZPdvzmZF6vj3BtDLcYmcMPIWWtiJIAP8SSeUb
         ZDXjYakeJ276VzYCKWn+1AtBevrkufWgNNWJw6BxQLRxhk2PmgLwIUkJjewWDGWFGW
         wjdVPKZ9Fu84PjgnAyrt69bvmhe/E7V7nGT0pVbmdmjqSf9oFekd3zHgsN2pnBTSAK
         Ai5ocBVokHpEA==
Date:   Sun, 14 May 2023 12:22:27 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Larsson <alexl@redhat.com>
Cc:     miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
        amir73il@gmail.com, tytso@mit.edu, fsverity@lists.linux.dev
Subject: Re: [PATCH v2 4/6] ovl: Add framework for verity support
Message-ID: <20230514192227.GE9528@sol.localdomain>
References: <cover.1683102959.git.alexl@redhat.com>
 <0292ade77250a8bb563744f596ecaab5614cbd80.1683102959.git.alexl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0292ade77250a8bb563744f596ecaab5614cbd80.1683102959.git.alexl@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, May 03, 2023 at 10:51:37AM +0200, Alexander Larsson wrote:
> +- "require":
> +    Same as "on", but additionally all metacopy files must specify a
> +    verity xattr. This means metadata copy up will only be used if
> +    the data file has fs-verity enabled, otherwise a full copy-up is
> +    used.

The second sentence makes it sound like an attacker can inject arbitrary data
just by replacing a data file with one that doesn't have fsverity enabled.

I really hope that's not the case?

I *think* there is a subtlety here involving "metacopy files" that were created
ahead of time by the user, vs. being generated by overlayfs.  But it's not
really explained.

- Eric
