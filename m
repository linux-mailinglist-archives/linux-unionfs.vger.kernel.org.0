Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCC64F568
	for <lists+linux-unionfs@lfdr.de>; Sat, 22 Jun 2019 12:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfFVKww (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Sat, 22 Jun 2019 06:52:52 -0400
Received: from sonic311-48.consmr.mail.bf2.yahoo.com ([74.6.131.222]:33581
        "EHLO sonic311-48.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726278AbfFVKww (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Sat, 22 Jun 2019 06:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561200770; bh=Wn45IEVQxjYS/KJ/AenupJ6pixj3tpnk+IQw8lNF8Cw=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Oq1YKrXr1kYD8c6yLlRZRbniJSlcC5200yUStvYqrcLnO30Yt5HCFxnIo532pk36ZzwXxbRwXW4sXrmw9HyVL5f5ub16ZqbekWDzBpiRCfmgWNvjXpIB1k+vAGgblYiBm+vua7lHKdn0OlejzTZEwhbVJv0psnegUgWrd7tR8Xo4Wm3FG8Ww7CeujPCxr8EDbTKDOY+/qrgWMb4/HXLMQsEph7YBYSwn28x7N1uC3PfGodra1+vkcnbQ8xwqHsNad4QGgVMmAAtn5cMCNCQurq9VNdZv0LpGfIR6lZESIwbb7E8JEV4VTctkfqyAQVLzPvXmxwhqiIEddxR5FFL9WA==
X-YMail-OSG: 2jSg0CIVM1m1YpToY_tKT7C7f.m2kPvEiuZQjPMNHLtMYV6SsMAw8STVFAG_uBt
 DT9jt6Yn7XUUHFXkghQb4kNRGomq6APuFH7ixVDAZpsNKfIq4J2LyVPf2R2AWZ5LDVPvQU6cYpQv
 LNT0Klio4Z.LmqY66B5OuQoDMaLTneX_xLvIbIqUAGWaVqmk7wh_Ar4UpB80TiYU0IswMgEWS8KI
 scls1aH5pVOGfjoTv_qm0vLrLUJmX0GifDvP7JmGTJDmJSn4fXKW2Oy6YPMu0Svoc8UNvQVKpQTm
 ysvr4WTucpMKkdoQx.RdwMbKUdOatzYDRSH32hUWkuH1.1VmhBEs5HMQySuLhFn0ZaDfCB_5MwXb
 o3bZygbHV7IYzaT1w7xDZJ0Lw5Rx6Jfj4f00g.Igoueera.VPoTgaA6FlUlBwiNTMalL1pohBi_s
 DCVvGuZmJczhw3bO3hygnAes2QNDITn3wTgvAWWwHAdK3wKGKSyPkg2wAAYxTbC08ZTa5mKUUa7O
 7OY84YXtO.LduF3rHvxm8icJI6RMAMBmc_oGRfj1IfpwcFX5RNdYpuEFrMjZZcuf0TevC72C0ie4
 gogGflRhHx0QPw.kVZSvrcArD0JeB9IOd3vEvlzcgxLKYEI127_IW1IQ0KSlYOGYB3iBRsQzKkfg
 HeEmllWxisCOAOLIcagXt5z0vJT0kKITo_4AiDoOKakamDacgOfF1K0RBiL9zfe3LVdk1E4bricH
 SkQLw9nBe.O_.eInwAIe7jqSZFiee4MUMJ3bJgIOKv.7rFLwmJ149fZDAiEo09H4QMYmnl6PDQCj
 LBIIcnZ7tHVTer99ZwILFLx4Niz6cUX0B_gUCOfGGxj6qK.KwKCeEnOnmqsfQ1NgYjNwg2_Y53Zn
 5cTnHN7rkYw.xGqUobS96YfWdW0vsGncQbvSK3r5I5zJuB9BMrDYCp1F.4TpjkfPpSNfqLWepFFm
 BK9.iOFMIIpfH8CTkh0ESrBK3iqhdHB174gAM0vf3ovX10HNx1AGFUECTQXcRU8KIU3en7jOkXxA
 W.pu36cVlAAQ1FO5ijZwDTbmGXOeuhmana9EW0mcOWh_eps.S.BNuN.xgWF9HWNwUaSXOFzgHTFk
 4SnsUQT8p6wpGBNuACf6cSyhSX7mNdqh43KbMPbEh.HonUVO4tSp0utaDFELo59MlerRxe4PYKAb
 Vf8ESCJiZK270JOh4SmONqupevAci
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Sat, 22 Jun 2019 10:52:50 +0000
Date:   Sat, 22 Jun 2019 10:50:49 +0000 (UTC)
From:   Major Dennis Hornbeck <ab3@gajdm.org.in>
Reply-To: Major Dennis Hornbeck <hornbeckmajordennis635@gmail.com>
Message-ID: <277629053.248981.1561200649617@mail.yahoo.com>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <277629053.248981.1561200649617.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.13837 YahooMailBasic Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

I am in the military unit here in Afghanistan, we have some amount of funds that we want to move out of the country. My partners and I need a good partner someone we can trust. It is risk free and legal. Reply to this email: hornbeckmajordennis635@gmail.com

Regards,
Major Dennis Hornbeck.
