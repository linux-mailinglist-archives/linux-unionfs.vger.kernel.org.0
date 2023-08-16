Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6BA77DEA1
	for <lists+linux-unionfs@lfdr.de>; Wed, 16 Aug 2023 12:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243965AbjHPK2z (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 16 Aug 2023 06:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243893AbjHPK2X (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 16 Aug 2023 06:28:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FCF1BF3
        for <linux-unionfs@vger.kernel.org>; Wed, 16 Aug 2023 03:28:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32E51619F3
        for <linux-unionfs@vger.kernel.org>; Wed, 16 Aug 2023 10:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69713C433C8;
        Wed, 16 Aug 2023 10:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692181701;
        bh=zr86vRAB3oBynLh20oWxKGdO9OfbNgNS+1F691D8760=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=chhxWXul3EdLXiWSAeAPfdn3QIzY9L5rXIOERpleQAqgB6RzZL26ST4rWIF8Dm8Pc
         0F4xle3MtkoAnGGKF4zea9ugEorY+V/0N3uhn9+xvi/dlekEhMp0aGzm2bXcMD8y3P
         B5AjnV+ki7eQr+2s8SXuDx1ZBa46Wjch9J5+b6k5JlCftH5gbGZWA2nQzHniDsQcTT
         7LcSwF23/9L7miY2+Nb53PoQrvbvz68Py1J0F5/Fef+1CzwXUIbUsxlirEv94iwiQo
         rfRE+Jju3avAOC+eO4YmnCBXoW0a+hkuCUearLiIOK90TY+BAi1F6oSKIIzqExDPp9
         y4psjN7GtBiRA==
Date:   Wed, 16 Aug 2023 12:28:17 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ovl: do not open/llseek lower file with upper
 sb_writers held
Message-ID: <20230816-beantragen-fehlalarm-98d937e251f7@brauner>
References: <20230814140518.763674-1-amir73il@gmail.com>
 <20230814140518.763674-3-amir73il@gmail.com>
 <CAJfpegu=-+jA1026KoqrFBX9dsfvQbcjHbkNunkZ6A794mZ1TQ@mail.gmail.com>
 <CAOQ4uxiTtraLVdsKJdty6z89=Lm52DGHFf1i_aL9jQz3L80V9Q@mail.gmail.com>
 <CAJfpegudye=2e2BWtk+fmaKMN_vUnwsKM8fi-GPcEX5n_vEizQ@mail.gmail.com>
 <CAOQ4uxi5oF7HWudQ7BBN9Matpsc2jqcftKZNH2Wpc778YK0mNg@mail.gmail.com>
 <CAJfpegssz5jpMBZs871QHuVfjA8ODvnc2_kN9YXw53Q7e47gLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegssz5jpMBZs871QHuVfjA8ODvnc2_kN9YXw53Q7e47gLg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Aug 15, 2023 at 10:36:52PM +0200, Miklos Szeredi wrote:
> On Tue, 15 Aug 2023 at 21:51, Amir Goldstein <amir73il@gmail.com> wrote:
> 
> > What I meant is, except from emergency remount rdonly and fs specific
> > cases like ext4 remount-ro on error, is there a way via new mount API
> > that users can request remount of the upper SB rdonly, despite the
> > fact that this sb has private writable mount clones?
> > even if ovl has elevated mnt_writers of upper_mnt?
> 
> Private and public mounts are completely equal in this regard.  So no,
> you can't remount rdonly if upper mnt has an elevated mnt_writers.

It's worth noting that during _emergency_ rw->ro remount writers on
mounts are ignored.

IOW, if SB_FORCE is set then we don't call sb_prepare_remount_readonly()
which would otherwise walk all mounts of the superblock marking them as
about to be made ro and would fail the rw->ro if there are any active
writers.

And a real emergency ro remount would make all active superblocks ro
including any overlayfs ones.

But for a regular rw->ro any writable mount with active writers would
prevent the sb from going ro.
