Return-Path: <linux-unionfs+bounces-2-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A79187F22ED
	for <lists+linux-unionfs@lfdr.de>; Tue, 21 Nov 2023 02:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6EF11C20ED0
	for <lists+linux-unionfs@lfdr.de>; Tue, 21 Nov 2023 01:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB4B5397;
	Tue, 21 Nov 2023 01:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aWIBzDUB"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5A35394
	for <linux-unionfs@vger.kernel.org>; Tue, 21 Nov 2023 01:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00599C433C7;
	Tue, 21 Nov 2023 01:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700529132;
	bh=WydedWHI5hgSzmjYaAgFcEvQrWisnvd0Tah1sl3VwoE=;
	h=Date:From:To:Subject:From;
	b=aWIBzDUBltgZGA6d/oqyQTtOaR/9sXg//+iYwnyM2uT2uJ4oqsYdmcVNRHiUBdv73
	 KUGTX2uCDBwoTmH+PVis+ktV03PDxzW9d1ZcP+uF8SmAykOLsmtC3IxGoudhA3p/tU
	 fyOhwWqHZg1vHZcxjpqgTk4peEze2vOdyK5gOd70=
Date: Mon, 20 Nov 2023 20:12:11 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-unionfs@vger.kernel.org
Subject: PSA: this list has moved to new vger infra (no action required)
Message-ID: <20231120-woodoo-nyala-of-shopping-efe1bc@nitro>
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list has been migrated to new vger infrastructure. No action is required
on your part and there should be no change in how you interact with this list.

This message acts as a verification test that the archives are properly
updating.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

Best regards,
-K

