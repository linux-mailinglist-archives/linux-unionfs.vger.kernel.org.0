Return-Path: <linux-unionfs+bounces-100-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C30D180E4F0
	for <lists+linux-unionfs@lfdr.de>; Tue, 12 Dec 2023 08:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B1F1F22E61
	for <lists+linux-unionfs@lfdr.de>; Tue, 12 Dec 2023 07:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E639168DA;
	Tue, 12 Dec 2023 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rhyiQAuA"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80730AB;
	Mon, 11 Dec 2023 23:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AcYhiiH7fhawjVuelCjJeq52YfhKQC6amDLwlqcKTwo=; b=rhyiQAuAA9SMhBFiM8MkZ6S7/n
	2VqgqBenkm2syZdsR1Rs17Wb5BaWMmD22pzkTDL6hYP58KirLwQ8G4Hx2+CujuFMTHiC1xqZtL6ud
	5Ol2yLOF+hnaxCoUbzWseGsOuFgtT+oO9YvjDwYL/VW46twsaJSB7qVoUPFilAFQoF9N7XDWmhEV7
	C5wYXOnPMOjocN4mK5mn4YHhT3wXd4c1mrJdmhV6LrfjCdOb6tTlbXN0mKGhssdilbPbUbACzCEKr
	ugWu78xhg3L50aQSFtgRwv7Hi+deVFSZtKpq51xv0R9033QmVrF2kw2P7atuEz4Z38Ue87RHO6TTv
	H64AJwtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rCxIh-00AwT9-2z;
	Tue, 12 Dec 2023 07:35:31 +0000
Date: Mon, 11 Dec 2023 23:35:31 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Eric Curtin <ecurtin@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Stephen Smoogen <ssmoogen@redhat.com>,
	Yariv Rachmani <yrachman@redhat.com>,
	Daniel Walsh <dwalsh@redhat.com>,
	Douglas Landgraf <dlandgra@redhat.com>,
	Alexander Larsson <alexl@redhat.com>,
	Colin Walters <walters@redhat.com>,
	Brian Masney <bmasney@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Pavol Brilla <pbrilla@redhat.com>,
	Lokesh Mandvekar <lmandvek@redhat.com>,
	Petr =?utf-8?Q?=C5=A0abata?= <psabata@redhat.com>,
	Lennart Poettering <lennart@poettering.net>,
	Luca Boccassi <bluca@debian.org>, Neal Gompa <neal@gompa.dev>,
	nvdimm@lists.linux.dev
Subject: Re: [RFC KERNEL] initoverlayfs - a scalable initial filesystem
Message-ID: <ZXgNQ85PdUKrQU1j@infradead.org>
References: <CAOgh=Fwb+JCTQ-iqzjq8st9qbvauxc4gqqafjWG2Xc08MeBabQ@mail.gmail.com>
 <941aff31-6aa4-4c37-bb94-547c46250304@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <941aff31-6aa4-4c37-bb94-547c46250304@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 12, 2023 at 08:50:56AM +0800, Gao Xiang wrote:
> For non-virtualization cases, I guess you could try to use `memmap`
> kernel option [2] to specify a memory region by bootloaders which
> contains an EROFS rootfs and a customized init for booting as
> erofs+overlayfs at least for `initoverlayfs`.  The main benefit is
> that the memory region specified by the bootloader can be directly
> used for mounting.  But I never tried if this option actually works.
> 
> Furthermore, compared to traditional ramdisks, using direct address
> can avoid page cache totally for uncompressed files like it can
> just use unencoded data as mmaped memory.  For compressed files, it
> still needs page cache to support mmaped access but we could adapt
> more for persistent memory scenarios such as disable cache
> decompression compared to previous block devices.
> 
> I'm not sure if it's worth implementing this in kernelspace since
> it's out of scope of an individual filesystem anyway.

IFF the use case turns out to be generally useful (it looks quite
convoluted and odd to me), we could esily do an initdax concept where
a chunk of memory passed by the bootloader is presented as a DAX device
properly without memmap hacks.


