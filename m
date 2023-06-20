Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FB3736794
	for <lists+linux-unionfs@lfdr.de>; Tue, 20 Jun 2023 11:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjFTJVM (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 20 Jun 2023 05:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjFTJVL (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 20 Jun 2023 05:21:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FED118
        for <linux-unionfs@vger.kernel.org>; Tue, 20 Jun 2023 02:21:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B75C460E9E
        for <linux-unionfs@vger.kernel.org>; Tue, 20 Jun 2023 09:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455F4C433C0;
        Tue, 20 Jun 2023 09:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687252869;
        bh=i7IKMoals021Q74niR9GpxKLSdz7lZbDFLzTzwxX1Y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BAPJTIxLZQYebCcj0nF+xQ/GtQVCBMs7HqhE/cIBtnv9fpN+LXNdxBLDeGs4Dhn1x
         w2+8C/iWbFW2VQQCf2yYC07ieYICTeWn+sH2fxOYdSWf+ncHEUHoTof3+730+JHklt
         6raIyuDFd5zFXxe0W5PtHSQfiT+WgFHljSl1H9Me/LGR4p2V0jiFr8BSy5Lly71GU7
         AWwYkAcMv4IZy33nBTdPPNR4nFQ7XwZWE2elracRyyREebSKYDAsghGqC3uYR7s8mK
         xHgC8c6jzRvVNn61WB481uUHsDnOgudwFga8JKv8wNE9y2bvWoK0p6VAIub+OLryTg
         PqxDcnpImtuWA==
Date:   Tue, 20 Jun 2023 11:21:05 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 2/5] ovl: clarify ovl_get_root() semantics
Message-ID: <20230620-wortfetzen-immer-03f4be630be7@brauner>
References: <20230617084702.2468470-1-amir73il@gmail.com>
 <20230617084702.2468470-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230617084702.2468470-3-amir73il@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Sat, Jun 17, 2023 at 11:46:59AM +0300, Amir Goldstein wrote:
> Change the semantics to take a reference on upperdentry instead
> of transferrig the reference.
> 
> This is needed for upcoming port to new mount api.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
