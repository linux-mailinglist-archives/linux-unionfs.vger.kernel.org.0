Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9276BCEA6
	for <lists+linux-unionfs@lfdr.de>; Thu, 16 Mar 2023 12:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjCPLpk (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 16 Mar 2023 07:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjCPLpa (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 16 Mar 2023 07:45:30 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E659A7A99
        for <linux-unionfs@vger.kernel.org>; Thu, 16 Mar 2023 04:45:28 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id t13so1006948qvn.2
        for <linux-unionfs@vger.kernel.org>; Thu, 16 Mar 2023 04:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678967127;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7al5tUCjdA9CCQe4odwP1DfME2QXDR1IbbFzP4IEE4=;
        b=BzFjFJXKk4ABNdgdLtfJHHShX7t3wYw39L+ShibXewF6fjxx2qPSogdQ20Vj54PfdU
         9rhL5ZIONd4Y0WZhtNw11TE5XR5gRUl5EE7IfM97MqtqobpktwpMm9qClk5eLCmFZGQb
         qC+a1fOzCP0sGNVMB3CX222WK4oBKzIdG8zV3/ZLj37u4+Gfo2kSoPFKiuGNLWjEqCVY
         rnBpvpH+p57OOZkjttsWP/X2tplWz2jJH7r3Q4l7qNnHTcNGQxqiPnPb8+V6L6T4hfLf
         rawKgz4NcYdXc0f3opQ3Y4yjcZGk1d6QXeWUIi44sMsqIGuT0j0nFriGphS/b1a+ZUdj
         2Bmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678967127;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7al5tUCjdA9CCQe4odwP1DfME2QXDR1IbbFzP4IEE4=;
        b=HdwY0FUrOO8FIwrWSFyuJIov6wC2bbWo1r21qX2Kflqq4u3CvXITZ0Mfhcf4LBfxHA
         bXLGN2yNICG2yR3/1aWGQkiS+fs4KyrzWr1a8E3eZhBnQdSc9aTfpV+DpE7Oftpdve3U
         IL/6mXuBuFOepfV/VK/Yh0MhMa2TXgywrqc9O1HRsQPjD7CL/EwwhdmozTqV/agrKRHM
         7syltj1G4t+kngw5fh7m9kXKT5FirHEz6ozjoPKiYxbCDQ2k5cfrzhp2iwifedCaDhvg
         vWTihy4Sdrqf2LHVL2qq+sctkUpkm6n0rVyuHuyOhkIIRCDx3fp3bWd0RmAIYFalFpWH
         cBIg==
X-Gm-Message-State: AO0yUKVJFsWwLPIK82JLHPu85Q3M54+R4Ns3v6pZKLz3TlV2p5a9f46w
        1bSxRwPB8RhzgqoDmzCyRzn56SoITb/oD7UwlA==
X-Google-Smtp-Source: AK7set8YWulpFp78k05O47KmBZiOt93aLH8E5obP3H93mLiz6n+yw1SD8cJoOeFb8P8PaiOSPQn8iKuFrZsN2AUWogs=
X-Received: by 2002:ad4:4ae3:0:b0:56e:a7d5:7c75 with SMTP id
 cp3-20020ad44ae3000000b0056ea7d57c75mr4813532qvb.3.1678967127223; Thu, 16 Mar
 2023 04:45:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:d989:0:b0:5b2:f74:d6f1 with HTTP; Thu, 16 Mar 2023
 04:45:26 -0700 (PDT)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <barr.makpojames.tg@gmail.com>
Date:   Thu, 16 Mar 2023 04:45:26 -0700
Message-ID: <CABXrGPddkQ_jym+w8t-04Jo6UF+fBOs3ttsGDhoidJdsv+UYZw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f34 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6168]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [barr.makpojames.tg[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

-- 
Did you receive my messages?
