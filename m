Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93AA72EA66
	for <lists+linux-unionfs@lfdr.de>; Tue, 13 Jun 2023 19:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240019AbjFMR7f (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 13 Jun 2023 13:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240065AbjFMR7d (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 13 Jun 2023 13:59:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ABB19BC
        for <linux-unionfs@vger.kernel.org>; Tue, 13 Jun 2023 10:59:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B22262CE4
        for <linux-unionfs@vger.kernel.org>; Tue, 13 Jun 2023 17:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845E2C433F1;
        Tue, 13 Jun 2023 17:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686679169;
        bh=CONyUZqGphXLnif9HJpI3hCBWVcuUeD7SdmKhoOVvag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s0I5ZWw7+csrpAqilpjXApMRMZmvsIEfHGg5sXZHHVDeVMP8wdTgni3XWzUaAk5pp
         rjzBpNKOBBtLv8QR+QsaJzkCvx3DnNIWjV1TIai6mR/5Yu8EgGk7laKmlimiIxlTtS
         0QZLtavAiNow+gl1keTH485QRZh6lYsEGHwIrelrxLcdvfTkKGpcUuNjZc3tmobs2D
         LywcsFBA+DirvHVGOu3QoaoUlPrBJA2GK8Sd6JMfxwcJzJVpA7tIT4g9rUpRlLn3ig
         Jm0Agq/ktgfMjoo9a8EfPv5BrgnPhzxUTJdFP/paAmA2FLGshCjNx1f4pI7dKSE/pr
         EF1i852Cv8Rlg==
Date:   Tue, 13 Jun 2023 10:59:27 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Larsson <alexl@redhat.com>
Cc:     miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
        amir73il@gmail.com, tytso@mit.edu, fsverity@lists.linux.dev
Subject: Re: [PATCH v3 0/4] ovl: Add support for fs-verity checking of
 lowerdata
Message-ID: <20230613175927.GB1139@sol.localdomain>
References: <cover.1686565330.git.alexl@redhat.com>
 <CAL7ro1EWzvWvwsO4dTc28HVj9nGfniz8HFix=pm40giTGv3YAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL7ro1EWzvWvwsO4dTc28HVj9nGfniz8HFix=pm40giTGv3YAg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Jun 13, 2023 at 03:57:48PM +0200, Alexander Larsson wrote:
> 
> I pushed a new version of this branch with the following changes:
> 
>  * Includes and uses the new fsverity_get_digest() rework from Eric
>  * The above means we now use the FS_VERITY_ALG_* enum values in the xattr
>  * Made the overlayfs.rst document change a bit more explicit on what
> happens and by whom
>  * Ignore EOPNOTSUPP failure from removexattrs as pointed out by Amir
> 
> The previous patchset is available as the overlay-verity-v3 tag so you
> can compare the differences.
> 

Where can I find the new version?

- Eric
