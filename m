Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2EC144CA4
	for <lists+linux-unionfs@lfdr.de>; Wed, 22 Jan 2020 08:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgAVHw1 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 22 Jan 2020 02:52:27 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:44002 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgAVHw1 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 22 Jan 2020 02:52:27 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iuAns-00C9NK-Ot; Wed, 22 Jan 2020 08:51:56 +0100
Message-ID: <946dd98f6597cdc9e75cce1929991ca3c6d6b12d.camel@sipsolutions.net>
Subject: Re: [PATCH] overlayfs: print format optimization
From:   Johannes Berg <johannes@sipsolutions.net>
To:     liuyang34 <yangliuxm34@gmail.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alex Dewar <alex.dewar@gmx.co.uk>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc:     liuyang34 <liuyang34@xiaomi.com>
Date:   Wed, 22 Jan 2020 08:51:54 +0100
In-Reply-To: <9e77421d905f0eda08753cf7a7b40f51b5b8c688.1579676323.git.liuyang34@xiaomi.com>
References: <cover.1579676323.git.liuyang34@xiaomi.com>
         <9e77421d905f0eda08753cf7a7b40f51b5b8c688.1579676323.git.liuyang34@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org


> diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
> index 44def53..54246b7 100644
> --- a/arch/um/os-Linux/umid.c
> +++ b/arch/um/os-Linux/umid.c
> @@ -349,7 +349,7 @@ int __init umid_file_name(char *name, char *buf, int len)
>  	if (err)
>  		return err;
>  
> -	n = snprintf(buf, len, "%s%s/%s", uml_dir, umid, name);
> +	n = snddprintf(buf, len, "%s%s/%s", uml_dir, umid, name);
>  	if (n >= len) {

Huh, what's this?

johannes

