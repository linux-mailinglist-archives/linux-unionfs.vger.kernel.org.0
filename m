Return-Path: <linux-unionfs+bounces-1034-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0485A9A3BA5
	for <lists+linux-unionfs@lfdr.de>; Fri, 18 Oct 2024 12:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14B71F2478D
	for <lists+linux-unionfs@lfdr.de>; Fri, 18 Oct 2024 10:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6F120126B;
	Fri, 18 Oct 2024 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBRmaBV+"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25611201266;
	Fri, 18 Oct 2024 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247657; cv=none; b=AeWWscWOpWCBiTvaUF4Jep+U69uSpp5IFIK5A6j42OlM/h7a61QHVsDf4UoqTo2xP6IZEyS1CPB1oZqBgNwPjRfa9TeQwngiF+s+MBbeFaJ6LrwsKamyXn67+xDAKP/m6PS/2xOyfpl1+TFliSgcbTOiLyFTf2dxsq3Pm0yjSY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247657; c=relaxed/simple;
	bh=0AMKP6S99EU9OwaTkTCfSMauhlIub2tR0jTH+oM3o7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inDSbl7minUcCNLLG9p88mOv59FiuVakbxVmfiQa94O9ELwOQmPtELF6L2KAzqP8kU3IVA7xPLK35oeNZZLhHx8XRgRTAwtnBKn9lJefanRzFocOa3xFHS3WBdsR+CeqHPUli7MnlzsM5IzB5/FQiLLjS79qtSLcn04CyhupCH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBRmaBV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA2CC4CEC6;
	Fri, 18 Oct 2024 10:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729247656;
	bh=0AMKP6S99EU9OwaTkTCfSMauhlIub2tR0jTH+oM3o7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IBRmaBV+pGJSk08yLNN6HVgDJJ+SPWow5upwqmYJ/i2g7vUEELHXA0TnB3HEy3mrV
	 i76JsPJhS83heeYqLQX3AauYQCtY9to1s83hMXFL0kfXir4825JuUnm9CqGDAxxlOW
	 uxSehAUdB1Y8VzbWKe4VinUqvx7YIzOCbbjPeKN+ggRdQ4cuqItF8/YQl9JXvbD95f
	 F4p8aaNnrKW4UVQ+aXnpagNb6ZFHfV2FlvbvyqpBEss6hguL3VwzrlxmfQyyWwNSeA
	 2PZ3aPvESxKmwtcBRWd6fH17WhFksIWWNfNP/QrxHa26WqTLh/ExR2p13fWKDHwQJI
	 GL98tozAeG+sQ==
Date: Fri, 18 Oct 2024 12:34:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v3 2/5] ovl: specify layers via file descriptors
Message-ID: <20241018-autofrei-feucht-4abc4f6ca30a@brauner>
References: <20241014-work-overlayfs-v3-0-32b3fed1286e@kernel.org>
 <20241014-work-overlayfs-v3-2-32b3fed1286e@kernel.org>
 <CAJfpegvqDPqVMfUkTxVSE580QF5mqOeorH7fT+zUoZGqqZ3TNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegvqDPqVMfUkTxVSE580QF5mqOeorH7fT+zUoZGqqZ3TNA@mail.gmail.com>

> Can static checkers deal with this?

I don't know.

