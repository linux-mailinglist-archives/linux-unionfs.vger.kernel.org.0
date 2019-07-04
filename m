Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12FD25FAB0
	for <lists+linux-unionfs@lfdr.de>; Thu,  4 Jul 2019 17:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfGDPLh (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 4 Jul 2019 11:11:37 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41574 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfGDPLh (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 4 Jul 2019 11:11:37 -0400
Received: by mail-yw1-f67.google.com with SMTP id i138so751941ywg.8
        for <linux-unionfs@vger.kernel.org>; Thu, 04 Jul 2019 08:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=al4DDYpqc1Zkt/32fIQDJrKfhDj95S+mMumK6s8aPM4=;
        b=Rdknc6MlPqul5WYolg3jG3qOXTgjYpaxisPQLXYSwFBqSB5s7ndudCRmAtr5PKJ8ZW
         GdzMIY1e8hLsy4kg4ORn0uN9f1yL81BFci0cVekzqiRBMDo9QdZdZG7/jOCgmJve4YFI
         UWsgFBWt83KTWll00ncEJyW0OX33wY+J4zaAQTJEMeJF9AY4fXknJ4qLtPwih3cfb1Wo
         yU02nSm9FGSYXYw564R0QIoGzw96H+CUgP4JY/lx/4JkxX0bjHqQSuSfJ7feYy+x1qiV
         0dCOyCORHikdPlE4+SwG5T0qrbJgFMzJ500w73UQ8DCsB3MrcEkLHLp9Lo5fv+YyhZWD
         9E6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=al4DDYpqc1Zkt/32fIQDJrKfhDj95S+mMumK6s8aPM4=;
        b=PlnQ72xE6a2iq0LtrfJnrk33lrTVU8TZfNhCRs2Lp/LLclvwEmYBFWHeNjBmUGYLOL
         uQiVtm+4XYbmaBXUF/uT7R/4XMSDaCWV67SmL38ksD4tvlbQvUXgJMsXPcFu0EZBt87b
         ByCMTdAC1t6A1myOHFzkzRgvR2YoCDBjsA2vFikJAQpLiLD/UUR25s5CgMa0HMLbKNdo
         6pFLv8d/6rodLj1tQENrdzwAS4PFOnbiwts7+QjmtOh+M5IK+JZzv76hj2JiEvdxYvm+
         XLEMrkUrp9a4qtBGt1JfpItbUOQpxSaLzVLTxiUmNf+J6CFzBsKjeo4SxxXLzJM2nNZD
         pAtg==
X-Gm-Message-State: APjAAAVusrVnvHthgzbkgJbbXIGwYj96drn6W4i7UAeuW38nj6Qn6y6h
        MXtxO3mjmjPYqHDoCzjf5Rj5jWvqXrE7+IvsZys=
X-Google-Smtp-Source: APXvYqzTg5Qr49wZkFGg7HeBxnLmRF8l5oCubGJkSKwhugJ+OA3j1AChIgAPT/OD0pCKFMeL89g53a8AbsZoUdvrep8=
X-Received: by 2002:a81:910a:: with SMTP id i10mr26522952ywg.31.1562253096149;
 Thu, 04 Jul 2019 08:11:36 -0700 (PDT)
MIME-Version: 1.0
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 4 Jul 2019 18:11:25 +0300
Message-ID: <CAOQ4uxhi63LPKdmkEJjnTEgy0VaX0qXML2Uz_258_B2iZcqd3w@mail.gmail.com>
Subject: [RFC] unionmount metacopy tests
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hi Vivek,

I was working on extending snapshot validation tests and got
this as a by-product:

https://github.com/amir73il/unionmount-testsuite/commits/metacopy

ca566c3 Check that data was not copied up with metacopy=on
140d99c Reset dentry copy_up state on upper layer rotate
960a5ce Check that files were copied up as expected
1bfcc7d Record meta copy_up vs. data copy_up
c3db453 Fix instantiation of hardlinked dentry
2104e51 Simplify initialization of __upper
1fc2eec Fix ./run --ov --verify --recycle

Would you be interested to review these changes,
so I would merge them to master?

Would you or someone else be interested in running those tests
regularly on pre release kernel?

If anyone is running unionmount-testsuite on regular basis
I would be happy to know which configurations are being tested,
because the test matrix grew considerably since I took over the project -
both Overlayfs config options and the testsuite config options.

Thanks,
Amir.
