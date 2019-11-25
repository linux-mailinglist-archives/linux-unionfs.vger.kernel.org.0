Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E721109015
	for <lists+linux-unionfs@lfdr.de>; Mon, 25 Nov 2019 15:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfKYOeo (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 25 Nov 2019 09:34:44 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44744 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbfKYOeo (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 25 Nov 2019 09:34:44 -0500
Received: by mail-yb1-f195.google.com with SMTP id g38so6028195ybe.11;
        Mon, 25 Nov 2019 06:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w1yTsSJv7yyPjyVs+cGPsIL5YirijWEFLZ/VgJHff6M=;
        b=pI4OoDNgpfIVkba/mTG4LhMfCFt3W5sG/l/kegM6avxfhWYgSBrrH80egFzM3hr/Td
         CKxGzrKvszKJllYFWGG0cREng0cEA37G9hOayADqHlpg/z6KKbF1iqxYEy+L95sE7lqU
         MDml3fOy5lyS2RkaNeV+MNrQGKlRZp7JIKJTkXtBm6rSKMl4PuQaos+2e2LdziviupYm
         jNOJaGBFIIl3YRSkl6DKXnXuEVhqHHrqA4RgiG9fxYTlnBtvK4e26lef4nr4iqXA7WG+
         GQPU5th7KX1J3tAJL5prQ8qkFKthELwbE9W4ZIdmLwmVbcOdV+fYEDVe6fQFCY3gDiir
         Q5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w1yTsSJv7yyPjyVs+cGPsIL5YirijWEFLZ/VgJHff6M=;
        b=UNugWEIjO6rC2feqzTi6RAdPaTQj1CJX6Y0xtd4rPm5XHd6bMLREYNkQREm9BkgiPz
         7S5EE+i+SDX/6TimGmNhvXxqtwWg9halYewsc1gdnufsOpGORQLB6BSAD/iOuhcwQStB
         k+Blcf2d1c2w0Jn5Oo4q7FLGAc34TKAyauY8eBJhiZaHNC5911OMFnH1kG5oxDeEHVPR
         2k2RSBHxD8DCejaNjG7Ic1orhQR/mZf0G+k8Xoei+qc6JiTFT9FA8gzTBN+2uO3Z8S6y
         /zcQ/L+TvYictWd1XBNOUn8DdZeTuRLLtWUb1jDahhIY36ZRe8ThHe9rxdgD9how157N
         eKYQ==
X-Gm-Message-State: APjAAAVD9QBR7qECcQXXPCKs/gph/UdCQODZ4Omp5/t0LoEiva+9D6BD
        2ZcQKY7SzkpBIoii4PyUZ81KcovfAIEwZSGQpixyBQ==
X-Google-Smtp-Source: APXvYqwPmHgh2qcLrxCP63kQojXfSXOD7VAXU/t5ny4S8cMVifTcJS0u+TO3aEFmj5UzVvnwmjwomeNP2aCUQvtldao=
X-Received: by 2002:a25:c50c:: with SMTP id v12mr23486813ybe.428.1574692483098;
 Mon, 25 Nov 2019 06:34:43 -0800 (PST)
MIME-Version: 1.0
References: <20191125101626.32722-1-amir73il@gmail.com>
In-Reply-To: <20191125101626.32722-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 25 Nov 2019 16:34:32 +0200
Message-ID: <CAOQ4uxiBs==-RV4mCdFyPaFZtWix1xQKkQ9oDPy7EbPW7Byb3Q@mail.gmail.com>
Subject: Re: [PATCH] docs: filesystems: overlayfs: Rename overlayfs.txt to .rst
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-doc@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000016134905982caa47"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

--00000000000016134905982caa47
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 25, 2019 at 12:16 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> It is already formatted as RST.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Hi John,
>
> Not sure if this doc is up to standards, but it is already displayed
> fairly well on github as .rst.
>

You'd probably want to apply the attached patch as well.

I wasn't sure if those should go through documentation tree or overlayfs tree.
Miklos, if you have any objections or would like to carry this though your tree
please speak up.

Thanks,
Amir.

--00000000000016134905982caa47
Content-Type: text/plain; charset="US-ASCII"; 
	name="0002-docs-filesystems-overlayfs-Fix-restview-warnings.patch.txt"
Content-Disposition: attachment; 
	filename="0002-docs-filesystems-overlayfs-Fix-restview-warnings.patch.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_k3ej5x4t0>
X-Attachment-Id: f_k3ej5x4t0

RnJvbSA3NTcwMTY5Y2JmYjk2YmI0ZjJjZTJiNjJjYWEwMjFjNjcxZDM0NWNkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBNb24sIDI1IE5vdiAyMDE5IDExOjUxOjI1ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gZG9j
czogZmlsZXN5c3RlbXM6IG92ZXJsYXlmczogRml4IHJlc3R2aWV3IHdhcm5pbmdzCgpGaXggb25s
eSB0aGUgb2J2aW91cyBwcm9ibGVtcwoKU2lnbmVkLW9mZi1ieTogQW1pciBHb2xkc3RlaW4gPGFt
aXI3M2lsQGdtYWlsLmNvbT4KLS0tCiBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL292ZXJsYXlm
cy5yc3QgfCA4ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvb3Zlcmxh
eWZzLnJzdCBiL0RvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvb3ZlcmxheWZzLnJzdAppbmRleCA4
NDVkNjg5ZTBmZDcuLjExMzM5ZTJhMDRjZCAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9maWxl
c3lzdGVtcy9vdmVybGF5ZnMucnN0CisrKyBiL0RvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvb3Zl
cmxheWZzLnJzdApAQCAtMTgxLDcgKzE4MSw3IEBAIEtlcm5lbCBjb25maWcgb3B0aW9uczoKICAg
ICB3b3JyaWVkIGFib3V0IGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgd2l0aCBrZXJuZWxzIHRoYXQg
aGF2ZSB0aGUgcmVkaXJlY3RfZGlyCiAgICAgZmVhdHVyZSBhbmQgZm9sbG93IHJlZGlyZWN0cyBl
dmVuIGlmIHR1cm5lZCBvZmYuCiAKLU1vZHVsZSBvcHRpb25zIChjYW4gYWxzbyBiZSBjaGFuZ2Vk
IHRocm91Z2ggL3N5cy9tb2R1bGUvb3ZlcmxheS9wYXJhbWV0ZXJzLyopOgorTW9kdWxlIG9wdGlv
bnMgKGNhbiBhbHNvIGJlIGNoYW5nZWQgdGhyb3VnaCAvc3lzL21vZHVsZS9vdmVybGF5L3BhcmFt
ZXRlcnMvKToKIAogLSAicmVkaXJlY3RfZGlyPUJPT0wiOgogICAgIFNlZSBPVkVSTEFZX0ZTX1JF
RElSRUNUX0RJUiBrZXJuZWwgY29uZmlnIG9wdGlvbiBhYm92ZS4KQEAgLTI2Myw3ICsyNjMsNyBA
QCB0b3AsIGxvd2VyMiB0aGUgbWlkZGxlIGFuZCBsb3dlcjMgdGhlIGJvdHRvbSBsYXllci4KIAog
CiBNZXRhZGF0YSBvbmx5IGNvcHkgdXAKLS0tLS0tLS0tLS0tLS0tLS0tLS0tCistLS0tLS0tLS0t
LS0tLS0tLS0tLS0KIAogV2hlbiBtZXRhZGF0YSBvbmx5IGNvcHkgdXAgZmVhdHVyZSBpcyBlbmFi
bGVkLCBvdmVybGF5ZnMgd2lsbCBvbmx5IGNvcHkKIHVwIG1ldGFkYXRhIChhcyBvcHBvc2VkIHRv
IHdob2xlIGZpbGUpLCB3aGVuIGEgbWV0YWRhdGEgc3BlY2lmaWMgb3BlcmF0aW9uCkBAIC0yODYs
MTAgKzI4NiwxMCBAQCBwb2ludGVkIGJ5IFJFRElSRUNULiBUaGlzIHNob3VsZCBub3QgYmUgcG9z
c2libGUgb24gbG9jYWwgc3lzdGVtIGFzIHNldHRpbmcKICJ0cnVzdGVkLiIgeGF0dHJzIHdpbGwg
cmVxdWlyZSBDQVBfU1lTX0FETUlOLiBCdXQgaXQgc2hvdWxkIGJlIHBvc3NpYmxlCiBmb3IgdW50
cnVzdGVkIGxheWVycyBsaWtlIGZyb20gYSBwZW4gZHJpdmUuCiAKLU5vdGU6IHJlZGlyZWN0X2Rp
cj17b2ZmfG5vZm9sbG93fGZvbGxvdygqKX0gY29uZmxpY3RzIHdpdGggbWV0YWNvcHk9b24sIGFu
ZAorTm90ZTogcmVkaXJlY3RfZGlyPXtvZmZ8bm9mb2xsb3d8Zm9sbG93WypdfSBjb25mbGljdHMg
d2l0aCBtZXRhY29weT1vbiwgYW5kCiByZXN1bHRzIGluIGFuIGVycm9yLgogCi0oKikgcmVkaXJl
Y3RfZGlyPWZvbGxvdyBvbmx5IGNvbmZsaWN0cyB3aXRoIG1ldGFjb3B5PW9uIGlmIHVwcGVyZGly
PS4uLiBpcworWypdIHJlZGlyZWN0X2Rpcj1mb2xsb3cgb25seSBjb25mbGljdHMgd2l0aCBtZXRh
Y29weT1vbiBpZiB1cHBlcmRpcj0uLi4gaXMKIGdpdmVuLgogCiBTaGFyaW5nIGFuZCBjb3B5aW5n
IGxheWVycwotLSAKMi4xNy4xCgo=
--00000000000016134905982caa47--
