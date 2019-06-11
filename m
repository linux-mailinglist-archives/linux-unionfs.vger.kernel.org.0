Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D99B417AD
	for <lists+linux-unionfs@lfdr.de>; Tue, 11 Jun 2019 23:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405112AbfFKV5G (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 11 Jun 2019 17:57:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44798 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404770AbfFKV5G (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 11 Jun 2019 17:57:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so7691238pgp.11
        for <linux-unionfs@vger.kernel.org>; Tue, 11 Jun 2019 14:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D6gRouGX084DW2r3DERG23LeR5TCYt4EG0tOtq+VqAg=;
        b=FfA1y0/u0N5M/VbhcHjDayinwbmjrZXkq9HuUiitkgTcMKRsJ5IdCh6Sijfegh3tBG
         kwkGEGzCtrbdwxTtP6vr7D2h91nt1kdNqolU/t7f9JnAiNqwKDnSBLAcPcS/KTZrEUY0
         xmzAENgI0Oj+oymHuA1dPMVS90MytU6pTMxDbXPzF6yyP6Q+PfdG5ie/gQHDbhTlBF01
         yVv1lYoCeT+n9otUzxKdV7DbHHouyacEEvCnc8dusoU6PB8yVYvcUJeP35eWivx5Asyt
         jCxqgFoeMx9OH8SJ2XPnYY0ZMdKC89SPB+/odiIkW1/f0XWQVwjXHMZOhHnZYYel3Q6Y
         N2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=D6gRouGX084DW2r3DERG23LeR5TCYt4EG0tOtq+VqAg=;
        b=anNM9nA1ueGYly7NfSBVtnyalhhpu1fQUjwaItgtKxu8NU8LLfisZ1cXhhD6o0u6lX
         dVZxl3L7CFdIL08m+BASPKyz/Xnz0ciPc2zsMX5WmdR/2eJNAkhNawR8dOPq/POI7BIX
         nqkVMKGA6MMvTTVOfnurmBW87M1C35VMTb2hC7LWHIpqjBQz1MMt/cjKq+r6uQexBV9X
         osIKsyCNBdaOe/1hKDoVwfrBtjoauzL0vptF3uSZM+obBDBX/U67NPJ3gjANijFpT8jv
         tV4Hqc6M3gvg3mqrHrbJxQgKojpn4b2VxCz7ikhTcMWew9BtOZ5Do8+oGCOHDAFmZ+Rz
         B+3A==
X-Gm-Message-State: APjAAAWO27p4Yz7y9GZVvDXDwHttINXKhR+lhiR0uwGLcWBmm8BNikgN
        MK89iZMqv4tdV910pUGyaZ0=
X-Google-Smtp-Source: APXvYqwiiTZkaQSv9DAVyVqdOHhUfWfC0esG/5FKFMiW8gvDVRbSs5jeM9ZUKnWTJRBcC/F4Q/Mo6A==
X-Received: by 2002:a63:6f0b:: with SMTP id k11mr21886121pgc.342.1560290225242;
        Tue, 11 Jun 2019 14:57:05 -0700 (PDT)
Received: from [10.10.75.214] ([64.124.233.100])
        by smtp.gmail.com with ESMTPSA id u2sm3565917pjv.9.2019.06.11.14.57.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 14:57:04 -0700 (PDT)
Subject: Re: [PATCH v2] overlay: allow config override of metacopy/redirect
 defaults
To:     Vivek Goyal <vgoyal@redhat.com>, Daniel Walsh <dwalsh@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Nalin Dahyabhai <nalin@redhat.com>
References: <20190607205105.21858-1-mcoffin13@gmail.com>
 <CAOQ4uximPqsNivkqD36LdNfT4g41v2rtDm+OB6t2z40dpWs_og@mail.gmail.com>
 <f5b0bddd-678b-bdd9-6fc7-cc9e5b3211e5@gmail.com>
 <CAOQ4uxjQQcrcpxhtu3kAJvGaK+xd5TfNB=7_UnNciGj990DN6Q@mail.gmail.com>
 <CAJfpegvy-Vfc6AEP7+=VfUtfL4izY8AzgoUdvqP4PHnLDEQhNg@mail.gmail.com>
 <20190610184043.GD25290@redhat.com> <20190610184553.GE25290@redhat.com>
 <CAJfpegvrOy3yBpu1AVBFyjdXBNM44k4gSqQ0F2npBG8wH8cUeg@mail.gmail.com>
 <20190611130932.GA28835@redhat.com>
 <cb363beb-9b2e-1d20-ca46-cba7724ec648@redhat.com>
 <20190611214951.GC28835@redhat.com>
From:   Matt Coffin <mcoffin13@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mcoffin13@gmail.com; keydata=
 mQINBFXzZLABEADfD/9dfQPD/Ho+NHBmduela1i/ZAuKmYkKHmu3xrqZvxguxzWPUgyJpTXh
 ok1xaJyKsPEyBE2ISWtO6E7daG9ugnU/k7wYb0/Yte+LZRI+ZdeM+ZOFuu3csHmxI65DNnFT
 swM7LLugTyJc2rvAAcEkQVAXXNnzmQHNcMpaGltsTM2YOlhR6+fO8QN96pD8lFr8nmC7Lg+W
 j88Lr54Eht5XaHAI+5d54Q4kuXxaX0IVMClO2w3+zeEmSR7mnIpypVqGuI8ermGpPnF64bkm
 erzCee0uWX/H9Rc2MBBCHC/xFSZUzMX+Duu+M3V7WhFJSXjP2f5p+koTrxEZlbv4+kOM4DUu
 SMWyXcqkWDLnXJrcT9E9M6++ysIGx64dy22ZvOqooh38qWWbA2cbdLEk+MvQ8N2uiTnQQ4hK
 gjwl0MiRZ9VilfKsolAUOWsvAjCuXr2Lh0srGwUkPwyosCTbQWGCnHUMCOpImMxzVUIQqruo
 p6IWcQw9aWnjMTqbkETeumwhKd+qmW4+CA3HshRD5lG+6JIAVnzfkZ68vdKZTticODAAFK9U
 LbrcpGgyjK85qAjWHuTb9AxjS/aTzhcsdHY/6A7YrVLMdn3+zCskcCQO1wXxWY+wbxpKqsJd
 NgV8nrnQVq6wYGI6jKuIbR4TQ1+P/of6MoJ0kK3dlqT6OrTrswARAQABtCtNYXR0IENvZmZp
 biAobWNvZmZpbikgPG1jb2ZmaW4xM0BnbWFpbC5jb20+iQJVBBMBCAA/AhsDAh4BAheACAsJ
 DQgMBwsCBhUICgkLAgUWAgMBABYhBOEeyn42M0fZ/BcKpXVKf/bjCxPmBQJZ7lPCAhkBAAoJ
 EHVKf/bjCxPmuoEP/1ZlopdGKfdJ/xbfkL87wzsEUp21HWJVjABd4LnfXzPMTcHuQdqKnWbB
 Qs5mbifsCdqGw+NVB45cjzuhn0PFcQ57RNHg+aPj7ZwYBrT7oUHhKP47PFF1m62CJOzBwr3Y
 jLbx28GZDCBs3lLsP6RRl+iD+ksT1n3P92uQYmWxumManKiBXgqu1TwIOnIzsPgaLhRJpiT+
 evCuU1xuqE1PsogkWVTa39UFS4/KoXSoGYzjStnqnvMP2AWeTuiSfLznSt2HPQaj/mO6EE2J
 cDcXPyqXclPR6SVu2QWP/D2sUeMi+kFBf2sh/xrwUJ12sd00Blq1YL7x71PF1SAXCh8KYJHh
 +kzjCMMm+2dqgu8jWFi23+8PhU3co5dWlr45aZzTAS99QR82Q8Rj3RAxpn5SmEJFfEldaRI6
 wkWnq59ikGJYjyxK6b8XcfCR1E+BkwfljzoUJPTkUUdWQA2G4pRYig/ai4f1cioegFlzac4z
 FNVoOXHLyiGDLRh3ze9aHRlFRfhAxEUCMojFuFxPcWXhS9RQin3oDqJphxqyrkkbHONeqk1m
 NHjNpgAhHfkTEIVV9o+megcoPb+8Y1w9hayfbyyfGaV+/oZCuVH5A5lN8dQAwa4ZEVer28TL
 PTADIfyBEBymsfxgcWQI9UytmeD5yUfSy3AWGqRHla/asC2OZlzhuQINBFXzZLABEAC0kCDC
 2+MunDdur+HLVyBE+f5AqPjdhHP03Y/xtn2L0ZHf0sZFH4l96yycxAY48tGdwTehCg4KQuNE
 WXqAUd07qk8/3dffLnDova6OQTeY+M8bhuQ+7XL25rI0zZdhxkYRF7dZUNKTLZDia4eGA6md
 s36ypeI6jXSVddH57m8xWdArb1vXVJdqhZ8UY+vGbldhXn3Jenqb4lqcjvi017LLJ68YN+BT
 D6zniWgYh9+iL3KtGeSQRYgyuSdMPY98IoSWKGYH1my747WzWoVKHFhhz+zZaK+FZzMKPMHK
 35I+pllm3JVZARwuSxtsfAQr4WMVqYFnTuG0h5Dw8sTM7BWDBODLTOMEN6Hw6Dx/L4XYtMnS
 8YERWEVA/LYWqd7cWLECxceBCYoFB8OsfhX7ibfDUUXB8VnqVa1XzUgXHRp6wv99vF30j622
 weHWTHkzfJw18xGVqjR/2JbqmDn/X5dz3/FF7RKDC8TRmrznjARk2BpfFW7mpBYwRo0WVFQf
 heKFlAlY7rF1BrTTFKS2Thm3YWxWFkFHT3TdLCxpBcqo+J2byCcoY3X0u8ui97Yf4evR8CmP
 0u9ipj4YJzwzptIkegYh+tHeOGzlUsdqynkqZi1zR9JPKbBPiRGu7BuCR1F8Qm7zd3l/pKQp
 lSDYF3iBdewoYkR5TGCy/hSf9jF0pwARAQABiQIfBBgBCAAJBQJV82SwAhsMAAoJEHVKf/bj
 CxPmyQEQAIw12kmmbuxtekWLBCtOOvYoRwNG3YqdiKTuXuXC3d1qm+xYDGS2c2C8HE6OJ88n
 GeI9qffeF3t3IBkt3L+ploaF41xqumvdKoEE+WNZOo+GW94EoOQtkNj+U7LbwYETPRZg7j4h
 28QXVDQ/zvff4fhHT7HFoW96JOhS5fAIImiCjyfG0so7F635yiOr2hMcvkfT5hvl9Mt+Yhud
 kSp1pmkgEpbSc75cw2P0gRgljrKS2jynT0Mj80AHNx7NnzSR81XCJl6BCbBS30kPFcNfoNzs
 bfprPFcmw3GMGArOxI68jOU2BDrTHue7Y/gwkm6RCRBQjmZ8r+hffQIFqGGrMciWjYP2ZGjE
 s7y+ggh+lHE0pjRvHWhj0ZthZLP/H2N7EvM52NJaeWIQIgupQZC1RSp5H56HMszfRXoiBIxn
 KlTmpOEmdcaLib7tx70rZzo4PP9+u0A2sRakta1WgWrHvdE8J86RQwbiewIfsokGR/D2vwSi
 BsCexsDtEwYLdCWIARHqvg5c6fkutVrHIFHeMUatNDWdUTs1tTHPhW7MGn0EX1xlcTZr/cSE
 7BCcpFzkGSCYWWBKJX9hy2xPe7F4rf3qx14eE3P4N6z+yfKMr51GQTKlqITf89jgGatx2RN7
 MFcRevlKA9HPvhzi3k6uaZbjH74Shgp+6ry8OB/Ypc3kuQINBFysxHwBEACbhsgcX3hB8824
 vnheWHUMPkn5HSTbNem/6ihVdraga71mTuiW4Yb6nObeYU0BKFXO+wqrryvFQ7kNvEaVmF75
 l/GD9qFpDOQuA6wMgo1RAxLYSunYMdasRTNgeNYq49Y8rUvTVhs9c/dti8sSdBuHXqk50K8z
 02Xk504kzL5tkS012rq7m01GBVDFjtCyLpFsasb+4wWFs+VfgBn1J8Lph88eCuzHHOyqjpT4
 KOOR4tH1yy1NXF/oUnOu5c4KL04T0gKTk+PUd9B/JfuDTysQqtBuX3+RBDN/M/LOYxct6OWJ
 mxdzv7HUKFblQGJm88iuumoL1Fg6nPfKkkcxQJ0UKMipqxlbim/dVMC821yMQQ0of62UjG5C
 9+FEZxJdxP5f2QCRVtyfl9jOpwPc0mi5gEGavDLV4e7wdtZ3R09IvY+5DZmRPJq7YuPv12Rj
 bIiKIXJh690+HHGXymJUJTodCS+IUD49yDP7N867Rx+JvIS1FMRLSM3fvpFpBYvg8eSgacJ0
 UPhnqw8s3WPXRnvUK+dGogX8r1qGolyENWqBJT+aDOrFZDLLS8kE+HYtNEdOVjWEAYfVXhah
 bWmG/XL6JfnekUBcGMG7kT41HHaxUO4l3PFZe9BUZO8+4ATVSZldVCx8OgVu803vGyNZ4tBI
 oSg7vfcakMDDMtMcpCSFFQARAQABiQRyBBgBCAAmFiEE4R7KfjYzR9n8FwqldUp/9uMLE+YF
 AlysxHwCGwIFCQHhM4ACQAkQdUp/9uMLE+bBdCAEGQEIAB0WIQSpcIIFFn2awmtYrSpTMblX
 d8CEPQUCXKzEfAAKCRBTMblXd8CEPd1BD/9YW+quUkqltxCVn1EP9Z5P/IFj8Mv1CFojlZ4x
 BhjDhm7mUfFkHByrm0ieiXJz/QeL2R/yUzP1nRqPk2+TTlet9LN5INnbkz1xWgZZcSNCxztu
 nKkPYRP3KOVW5rfA8scIyXoJ2uM82f9/mcDuwC8/GQ7Rqi9hMxAYQy4Fci5NI53iiL4QjfJH
 LnYwhOrzT3t6VTNBZgWMu0tY86upwLkY9MIT6qb+ZtLmmzLIJg7qGPYW217PxPL5nwAIznaY
 BdRFMbiMAKct2hndQmu5GdO/buFvMiANK72VbdhQnQthNd4gh+o/8k6awH+73mrt4qW1jYJY
 t0Gl3718TIA6H0pGPxynV6a+uBBmY2A98lR/OHed1VDUo6YIz4fqTx73bHtXELS5vl+Wmtcu
 qq2ZHMh6T4W1Vh+8L9jfIKbCLQoGuPVypzw+v0h2DXaAQWkLHWCi6GgHa3bJKEgS6Q6KSJ4q
 kpRcsBng6InFifwdphuF2ZTAZfF6EHvqlcmpULjiLrnF4czwpp/wrTQL2f+NCwPvSqTmLACW
 b5Zu4FjA//JfYkk76JBJxck3oA1FXcnfBpOgQPZbqC80BZE52Ncp7ocFtFbO43Dq8Bj4AJQl
 9Q6Baj80q64lDFQULqJfcFYwn3XHoMNf8E6gcvNAYUVSQ3ai1iUyrkKE76KLhdIDzlUufSHH
 EACWCvYfYttni32Twl7SD6aMaHIeAJ9lvnMqgxzyC/vgOlJBAD07nQVbBLSkhiJ4tZiIPMhn
 IU7u/AKxhJak0rZ2M4OTHmYcyElLSNRAjqBW4rdPYulDgk9vRkS2mof/Fd/tzDtRJ6ToZgkM
 jbfnaYhDdVIXRH7I4emd076Be97mkVDO7S8eeKHlFxsnm3gVXd0YVl+pRCArjfCgKbA+jXzg
 KdCnOGZoGVftIX3gCushwK3ORmtx2kmthXb3s5PZUMAbP4YkiA+SJlUgfAzmTXs6Eac5kiNc
 39NsBZVUSzXOkqGwD2LgUL31N8bF9lJq7i/DrOQdlMZcn5EwgGjnJgmL8GK4VUvipsO331yg
 haG+zICmBHZT2dM9lfVytIDRNATAmXlYPXNrkPwU2CYevmjMdkKG2heaoFHuSt355pLc5UTt
 Nh9txF/tDLk0y51vpfH1m96CjX+sVfnVXnY7KHYqCPoQj6wAZvUBx8PCR6sCkSSZdxAGSNPW
 m5XrftI3NGJ7D97Df8anCLiY8pAKzQfuNCLDQY6HJwFvEJK+j4ueveFGik0XleJS0Xc4/Tx9
 sFDNdR7U/zd2PXFdrdYX1QCyPaus/qfogJfGSZZShVPoifPCS+IazEdElbm4oVUguSO3Vb7h
 1Gcz6OdGWcLINzPXGZj6VyT4otaO/HPNCBuMGQ==
Message-ID: <be9bfd25-ff48-bd9e-25ff-aa2a5f5873ed@gmail.com>
Date:   Tue, 11 Jun 2019 15:57:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611214951.GC28835@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

This could just be because I don't understand the implications here, but
wouldn't it be easier, at least for now, to just mount with

redirect_dir=0,metacopy=0

in the mount parameters when building images, but allow the user's
default settings to still take over when just executing a container?

On 6/11/19 3:49 PM, Vivek Goyal wrote:
> On Tue, Jun 11, 2019 at 05:44:33PM -0400, Daniel Walsh wrote:
>> On 6/11/19 9:09 AM, Vivek Goyal wrote:
>>> On Tue, Jun 11, 2019 at 02:37:34PM +0200, Miklos Szeredi wrote:
>>>> On Mon, Jun 10, 2019 at 8:45 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>>>> AFAICS what happens when generating a layer is to start with a clean
>>>> upper layer, do some operations, then save the contents of the upper
>>>> layer.  If redirect or metacopy is enabled, then the contents of the
>>>> upper layer won't be portable.  So need to do something like this:
>>>>
>>>> traverse(overlay_dir, upper_dir, target_dir)
>>>> {
>>>>     iterate name for entries in $upper_dir {
>>>>         if ($name is non-directory) {
>>>>             copy($overlay_dir/$name, $target_dir/$name)
>>>>         } else if ($name is redirect) {
>>>>             copy-recursive($overlay_dir/$name, $target_dir/$name)
>>>>         } else {
>>>>             copy($overlay_dir/$name, $target_dir/$name)
>>>>             traverse($overlay_dir/$name, $upper_dir/$name, $target_dir/$name)
>>>>         }
>>>>     }
>>>> }
>>>>
>>>> Basically: traverse the *upper layer* but copy files and directories
>>>> from the *overlay*.  Does that make sense?
