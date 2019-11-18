Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6281009DD
	for <lists+linux-unionfs@lfdr.de>; Mon, 18 Nov 2019 18:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfKRRCA (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 18 Nov 2019 12:02:00 -0500
Received: from mail-yb1-f170.google.com ([209.85.219.170]:33138 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfKRRCA (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 18 Nov 2019 12:02:00 -0500
Received: by mail-yb1-f170.google.com with SMTP id i15so7474851ybq.0
        for <linux-unionfs@vger.kernel.org>; Mon, 18 Nov 2019 09:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CwsfqIzh4IWA6VWHTa2PM+DfK0o8iKLrUd9La8Pyer8=;
        b=pIIvPztibS8OVmGUHOWvgulJxO5FbuBrisOdLACpVbx6UqLsRq2weItXIaQwaREhEe
         dXujjBm5Kfn+e1TNjsDW2hcBu9XM81hX8KGeU1jhlIiL0lYJsk7zXYm8OC8wVhNJCPb2
         1PPaUqgMJyO+a5Nu5qg3aNr+levdVhMd4I36a27ZMphAvTpIjuRylgffTtI9q5SOAE+b
         RzR+4n8OShdiHZY76Bs68g/p6FlEOU1Scu5L6H4qrvu5rv5ftcxXsP0WVj2KapOauO99
         kCsIhPbiQlL4s0xxNBEQd+Nzxlny7Oh0dxt+FqdRMqjWfECbkzXet9Hy150NfOmrSzs3
         KI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CwsfqIzh4IWA6VWHTa2PM+DfK0o8iKLrUd9La8Pyer8=;
        b=APUVzED+CNrC+StxEHmHZ/ZoeV+9s1bvtw5wyNP6xrl+xG6rEJsuK8wENVZmGZPE4V
         ZvR20RHg83ffgYA4XbtNoiRb7CSxFXAm6We16fSUW4qs4cv6DpvmlRnSvmAD7dT7jnjs
         Oe4l+qoVPZjKOcDHOs3Jv8NFDA+BV8oXO3N++2lTsISkBUuZAZjrCt6aOjmd5bUnTw5X
         3XF9H3e5bh1ca0ahhStCA12/D7Ik16VcOm6DLWMItiARiDoFe5xIvL43i/lE4dsKWUe3
         eYCp9C0Amnuwxd94n2lkkZMJyCfLx/iX6y7J5xPvaBVNoNfl5Y3Q1CM26njjbHqWUkQ6
         Uqyw==
X-Gm-Message-State: APjAAAXbRwQtYfVupOpzoDzc/9heHcm2rfetaqhnKj7g+5e1BEhTYeCB
        QRg50E00yn2QKMNqd5W8MlWyzxayridve1O5oSDxbQ==
X-Google-Smtp-Source: APXvYqxUu37PClsqGbhCL9okLC5lKJtBtF0+kbGsmBbDezponjlIPJsh1kQAFk5pH9V8JdgsG8dcPFa9/H53A96v1I8=
X-Received: by 2002:a25:383:: with SMTP id 125mr24421273ybd.45.1574096519435;
 Mon, 18 Nov 2019 09:01:59 -0800 (PST)
MIME-Version: 1.0
References: <20191117154349.28695-1-amir73il@gmail.com> <20191117154349.28695-5-amir73il@gmail.com>
In-Reply-To: <20191117154349.28695-5-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 18 Nov 2019 19:01:48 +0200
Message-ID: <CAOQ4uxioVp0ULGz6fXLyC9rBeNdV4nT0swzVpY2yKgSuThPo0Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] ovl: generalize the lower_fs[] array
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Colin Ian King <colin.king@canonical.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Sun, Nov 17, 2019 at 5:44 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Rename lower_fs[] array to fs[], extend its size by one and initialize
> fs[0] with upper fs values. fsid 0 is already reserved even with lower
> only overlay, so fs[0] remains uninitialized in this case as well.
>
> Rename numlowerfs to maxfsid and use index 0..maxfsid to access the
> fs[] array.
>

FYI, I don't know what I was thinking with the conversion to maxfsid.
I don't like that and intend to change it back to numfs.

Thanks,
Amir.
