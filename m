Return-Path: <linux-unionfs+bounces-1325-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6C5A703FE
	for <lists+linux-unionfs@lfdr.de>; Tue, 25 Mar 2025 15:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3F03AA28F
	for <lists+linux-unionfs@lfdr.de>; Tue, 25 Mar 2025 14:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C922B25A342;
	Tue, 25 Mar 2025 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgn8SINA"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31F2253F0E;
	Tue, 25 Mar 2025 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913499; cv=none; b=BHi1sOyXmuKu8sqFkGJNp4gTI7fAX2xc7QKjFDOxW93ZjiSpaEmIk7zAJWbPqpuatsIBBbuyl6/ctVb9Szo7N2k2J0hkhURce6egrpGSbD8nQaxl9T0p4jysbhN8uGwqoqn5n8XwxTbAygi968FnxJqsXt+Gal6Vqaxm4rvN8HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913499; c=relaxed/simple;
	bh=SQRQCHXnKAJTYBGIBPWyfS5cbS3cerVyNwnrVBmR+X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOguKwpFEL8fuWLZxyGVSGA1NjsaP9UvoZLCLIrjLgnCOfiOWQdIsbi3eSwwyXPcJYXewNB5wZKzVx8uqORjFAAcHSAd+LTXGtr8mcZKD6PObYGqx6W6oNCkPEa3wcdPWBvXbavcwH+CPIUzh2xHWUkTVZBWZGG1BXUKNwFNpJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgn8SINA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9DEC4CEE4;
	Tue, 25 Mar 2025 14:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742913496;
	bh=SQRQCHXnKAJTYBGIBPWyfS5cbS3cerVyNwnrVBmR+X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qgn8SINANg0YQzklX1ensoemEagiYfzrbiMHmxGFF7EsMhFs0B1vVibwNy2ZfXdS4
	 TK0R14v1SjfGLIzhQ+qd0G27sdNjIAkluZs9S+A9C/CwbHV0OrG+dPZr3mCog+KFaI
	 OXg+Vd1oMuEiC9gNRIXK/ncxftINV/hV0+HrnAWj0jsLsS3jwNAQHTCMbg9aQ+bAfS
	 clSDACcOG/OWiO9dVkkLhl+LpWVit+dNjofxW/nOdnHoE9PrbZP2a7p1LTMvmI2wOG
	 5CzZfdkHZz7j6rxGhPQv399Qdjir6ArvJ1bZruX91rCgWy1M+UnBa6cfKKh1jrz++9
	 9NXNRjYaB3oEw==
Date: Tue, 25 Mar 2025 15:38:14 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Alexander Larsson <alexl@redhat.com>
Subject: Re: [PATCH v2 2/5] ovl: remove unused forward declaration
Message-ID: <20250325-randfigur-tauchen-ce9db20214fc@brauner>
References: <20250325104634.162496-1-mszeredi@redhat.com>
 <20250325104634.162496-3-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250325104634.162496-3-mszeredi@redhat.com>

On Tue, Mar 25, 2025 at 11:46:30AM +0100, Miklos Szeredi wrote:
> From: Giuseppe Scrivano <gscrivan@redhat.com>
> 
> The ovl_get_verity_xattr() function was never added, only its declaration.
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> Fixes: 184996e92e86 ("ovl: Validate verity xattr when resolving lowerdata")
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

