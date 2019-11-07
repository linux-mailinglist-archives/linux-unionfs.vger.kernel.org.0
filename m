Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF5FBF27E4
	for <lists+linux-unionfs@lfdr.de>; Thu,  7 Nov 2019 08:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfKGHI6 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 7 Nov 2019 02:08:58 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33267 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfKGHI6 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 7 Nov 2019 02:08:58 -0500
Received: by mail-yw1-f65.google.com with SMTP id q140so292817ywg.0;
        Wed, 06 Nov 2019 23:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gIDlG3JSKlde/wLrZszzeALKX0hpoO0JK8Xro3c1wfU=;
        b=VovhYwxpMBILBLnHwzeoiUZc7cdgG/Wgt9h0MN9g5cudxk3wLwC4oRw2LB1G5kyUkP
         rZkgTsfVtbdeTAYKWaRup2g1TnER4WfFoMGuxt3DFC/cZ9VysyTa71lM4w5r/ep1ll2t
         7+HDK+TboTInh0gU73G99QVeCei4j2mNiXYXbr518Sq8OrYd/Odf/jpgz2/KgZuS3O/M
         9+HcyKpTNSQSXbZV/6BhDWsLnr/2dJ9N5C6hROV+soEVCo7xy0+1NJjw/RTQ63927gqM
         mmGU+1jFuh4xELds0wbCUWa8ApQ5QvQxrpUkV3/n0VeIXx6Bv73fIvaOi923M4njO0nh
         X5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gIDlG3JSKlde/wLrZszzeALKX0hpoO0JK8Xro3c1wfU=;
        b=eMW5+1RlIGNt3JcO872kfNhOAOgNQO4oV5mHyfon6aIlrvr8UyF2/PD5PP9VmyWUJz
         rP4v4hHponYpBWbrVndWBzl+pvGaVKvsNMJxsvXrOD3zhSFMwdF4x2f/qpFcLO/ekMkp
         7zFrkCdW2dZKyxZN75g5vJN+HZjEaJzjKjUHhs5q85oUDFSM3ajbn3K8HGmwqtRVX1sH
         0jcEwApmoUerbP6RgSxt1XW+ad6bPvirfcEyxEYwjXu0vCxdiGjAs3Es/ksXRpuxlrzP
         KZan2/nfVgXOP1TjdvN0K/xwTcT9zhqhEenoNZFGbVmA6xDFYtKCCxt2AkfBFDq871zR
         kRtg==
X-Gm-Message-State: APjAAAXBYlKKej51n++pNTNCRJRD+3kTe8AzIExbxt+DHPUFxz2UcSWr
        0AuDnvIxzVHpuuq2k6L6QyZ1JccFvXRQPvyGpE0=
X-Google-Smtp-Source: APXvYqx6erHBE2mkDGi8dnZ+Q0bJeH3gVF4ucy8cDVVb43/1+/4zf08edIJHQxEyyhTDeQtXXy/vhBIQcpWoh4sFDYI=
X-Received: by 2002:a0d:f305:: with SMTP id c5mr1192964ywf.31.1573110535285;
 Wed, 06 Nov 2019 23:08:55 -0800 (PST)
MIME-Version: 1.0
References: <20191106234301.283006-1-colin.king@canonical.com>
In-Reply-To: <20191106234301.283006-1-colin.king@canonical.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 7 Nov 2019 09:08:44 +0200
Message-ID: <CAOQ4uxhT4pFzHjjKyoMOc3xVXXqyqc37zd=-pCx2+keA4e6NAg@mail.gmail.com>
Subject: Re: [PATCH] ovl: create UUIDs for file systems that do not set the
 superblock UUID
To:     Colin King <colin.king@canonical.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000a607060596bc5612"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

--000000000000a607060596bc5612
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 7, 2019 at 1:43 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Some file systems such as squashfs do not set the UUID in the
> superblock resulting in a zero'd UUID.  In cases were two or more
> of these file systems are overlayed on the lower layer we can hit
> overlay corruption issues because identical zero'd overlayfs UUIDs
> are impossible to differentiate between.  This can be fixed by
> creating an overlayfs UUID based on the file system from the
> superblock s_magic and s_dev fields.  (This currently seems like
> enough information to be able create a UUID, but the could be
> scope to use other super block fields such as the pointer s_fs_info
> but may need some obfuscation).
>

The fix is incorrent. uuid stored in xattr needs to have persistent properties.
In the use case that you describe, the origin file handle should simply be
ignored.

Please test attached patch.

Thanks,
Amir.

--000000000000a607060596bc5612
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ovl-fix-lookup-failure-on-multi-lower-squashfs.patch"
Content-Disposition: attachment; 
	filename="0001-ovl-fix-lookup-failure-on-multi-lower-squashfs.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k2oddo2z0>
X-Attachment-Id: f_k2oddo2z0

RnJvbSBlMDQ3YjA3ODE1NzY5MWJhOGFiZDU5ODg2NWQ3YzZmMDhhYWI1MzEwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBUaHUsIDcgTm92IDIwMTkgMDc6MTk6NTUgKzAyMDAKU3ViamVjdDogW1BBVENIXSBvdmw6
IGZpeCBsb29rdXAgZmFpbHVyZSBvbiBtdWx0aSBsb3dlciBzcXVhc2hmcwoKSW4gdGhlIHBhc3Qs
IG92ZXJsYXlmcyByZXF1aXJlZCB0aGF0IGxvd2VyIGZzIGhhdmUgbm9uIG51bGwgdXVpZCBpbgpv
cmRlciB0byBzdXBwb3J0IG5mcyBleHBvcnQgYW5kIGRlY29kZSBjb3B5IHVwIG9yaWdpbiBmaWxl
IGhhbmRsZXMuCgpDb21taXQgOWRmMDg1ZjNjOWEyICgib3ZsOiByZWxheCByZXF1aXJlbWVudCBm
b3Igbm9uIG51bGwgdXVpZCBvZgpsb3dlciBmcyIpIHJlbGF4ZWQgdGhpcyByZXF1aXJlbWVudCBm
b3IgbmZzIGV4cG9ydCBzdXBwb3J0LCBhcyBsb25nCmFzIHV1aWQgKGV2ZW4gaWYgbnVsbCkgaXMg
dW5pcXVlIGFtb25nIGFsbCBsb3dlciBmcy4KCkhvd2V2ZXIsIHNhaWQgY29tbWl0IHVuaW50ZW50
aW9uYWxseSBhbHNvIHJlbGF4ZWQgdGhlIG5vbiBudWxsIHV1aWQKcmVxdWlyZW1lbnQgZm9yIGRl
Y29kaW5nIGNvcHkgdXAgb3JpZ2luIGZpbGUgaGFuZGxlcywgcmVnYXJkbGVzcyBvZgp0aGUgdW5p
cXVlIHV1aWQgcmVxdWlyZW1lbnQuCgpBbWVuZCB0aGlzIG1pc3Rha2UgYnkgZGlzYWJsaW5nIGRl
Y29kaW5nIG9mIGNvcHkgdXAgb3JpZ2luIGZpbGUgaGFuZGxlCmZyb20gbG93ZXIgZnMgd2l0aCBh
IGNvbmZsaWN0aW5nIHV1aWQuCgpXZSBzdGlsbCBlbmNvZGUgY29weSB1cCBvcmlnaW4gZmlsZSBo
YW5kbGVzIGZyb20gdGhvc2UgZnMsIGJlY2F1c2UKZmlsZSBoYW5kbGVzIGxpa2UgdGhvc2UgYWxy
ZWFkeSBleGlzdCBpbiB0aGUgd2lsZCBhbmQgYmVjYXVzZSB0aGV5Cm1pZ2h0IHByb3ZpZGUgdXNl
ZnVsIGluZm9ybWF0aW9uIGluIHRoZSBmdXR1cmUuCgpSZXBvcnRlZC1ieTogQ29saW4gSWFuIEtp
bmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGttbC8yMDE5MTEwNjIzNDMwMS4yODMwMDYtMS1jb2xpbi5raW5nQGNhbm9uaWNhbC5jb20v
CkZpeGVzOiA5ZGYwODVmM2M5YTIgKCJvdmw6IHJlbGF4IHJlcXVpcmVtZW50IGZvciBub24gbnVs
bCB1dWlkIC4uLiIpCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgdjQuMjArClNpZ25lZC1v
ZmYtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Ci0tLQogZnMvb3Zlcmxh
eWZzL25hbWVpLmMgICAgIHwgOCArKysrKysrKwogZnMvb3ZlcmxheWZzL292bF9lbnRyeS5oIHwg
MiArKwogZnMvb3ZlcmxheWZzL3N1cGVyLmMgICAgIHwgOSArKysrKysrKy0KIDMgZmlsZXMgY2hh
bmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzL292
ZXJsYXlmcy9uYW1laS5jIGIvZnMvb3ZlcmxheWZzL25hbWVpLmMKaW5kZXggZTk3MTdjMmY3ZDQ1
Li5kZGM1NTE0ZDhjM2IgMTAwNjQ0Ci0tLSBhL2ZzL292ZXJsYXlmcy9uYW1laS5jCisrKyBiL2Zz
L292ZXJsYXlmcy9uYW1laS5jCkBAIC0zMjUsNiArMzI1LDE0IEBAIGludCBvdmxfY2hlY2tfb3Jp
Z2luX2ZoKHN0cnVjdCBvdmxfZnMgKm9mcywgc3RydWN0IG92bF9maCAqZmgsIGJvb2wgY29ubmVj
dGVkLAogCWludCBpOwogCiAJZm9yIChpID0gMDsgaSA8IG9mcy0+bnVtbG93ZXI7IGkrKykgewor
CQkvKgorCQkgKiBJZiBsb3dlciBmcyB1dWlkIGlzIG5vdCB1bmlxdWUgYW1vbmcgbG93ZXIgZnMg
d2UgY2Fubm90IG1hdGNoCisJCSAqIGZoLT51dWlkIHRvIGxheWVyLgorCQkgKi8KKwkJaWYgKG9m
cy0+bG93ZXJfbGF5ZXJzW2ldLmZzaWQgJiYKKwkJICAgIG9mcy0+bG93ZXJfbGF5ZXJzW2ldLmZz
LT5ub3V1aWQpCisJCQljb250aW51ZTsKKwogCQlvcmlnaW4gPSBvdmxfZGVjb2RlX3JlYWxfZmgo
ZmgsIG9mcy0+bG93ZXJfbGF5ZXJzW2ldLm1udCwKIAkJCQkJICAgIGNvbm5lY3RlZCk7CiAJCWlm
IChvcmlnaW4pCmRpZmYgLS1naXQgYS9mcy9vdmVybGF5ZnMvb3ZsX2VudHJ5LmggYi9mcy9vdmVy
bGF5ZnMvb3ZsX2VudHJ5LmgKaW5kZXggYTgyNzkyODBlODhkLi5hMDIyN2MzMWZlMTcgMTAwNjQ0
Ci0tLSBhL2ZzL292ZXJsYXlmcy9vdmxfZW50cnkuaAorKysgYi9mcy9vdmVybGF5ZnMvb3ZsX2Vu
dHJ5LmgKQEAgLTIyLDYgKzIyLDggQEAgc3RydWN0IG92bF9jb25maWcgewogc3RydWN0IG92bF9z
YiB7CiAJc3RydWN0IHN1cGVyX2Jsb2NrICpzYjsKIAlkZXZfdCBwc2V1ZG9fZGV2OworCS8qIFVu
dXNhYmxlIChjb25mbGljdGluZykgdXVpZCAqLworCWJvb2wgbm91dWlkOwogfTsKIAogc3RydWN0
IG92bF9sYXllciB7CmRpZmYgLS1naXQgYS9mcy9vdmVybGF5ZnMvc3VwZXIuYyBiL2ZzL292ZXJs
YXlmcy9zdXBlci5jCmluZGV4IGFmYmNiMTE2YTdmMS4uNTQ3ZjhjZGJjOThmIDEwMDY0NAotLS0g
YS9mcy9vdmVybGF5ZnMvc3VwZXIuYworKysgYi9mcy9vdmVybGF5ZnMvc3VwZXIuYwpAQCAtMTI2
Myw5ICsxMjYzLDEzIEBAIHN0YXRpYyBib29sIG92bF9sb3dlcl91dWlkX29rKHN0cnVjdCBvdmxf
ZnMgKm9mcywgY29uc3QgdXVpZF90ICp1dWlkKQogCQkgKiBXZSB1c2UgdXVpZCB0byBhc3NvY2lh
dGUgYW4gb3ZlcmxheSBsb3dlciBmaWxlIGhhbmRsZSB3aXRoIGEKIAkJICogbG93ZXIgbGF5ZXIs
IHNvIHdlIGNhbiBhY2NlcHQgbG93ZXIgZnMgd2l0aCBudWxsIHV1aWQgYXMgbG9uZwogCQkgKiBh
cyBhbGwgbG93ZXIgbGF5ZXJzIHdpdGggbnVsbCB1dWlkIGFyZSBvbiB0aGUgc2FtZSBmcy4KKwkJ
ICogaWYgd2UgZGV0ZWN0IG11bHRpcGxlIGxvd2VyIGZzIHdpdGggdGhlIHNhbWUgdXVpZCwgd2UK
KwkJICogZGlzYWJsZSBsb3dlciBmaWxlIGhhbmRsZSBkZWNvZGluZyBvbiBhbGwgb2YgdGhlbS4K
IAkJICovCi0JCWlmICh1dWlkX2VxdWFsKCZvZnMtPmxvd2VyX2ZzW2ldLnNiLT5zX3V1aWQsIHV1
aWQpKQorCQlpZiAodXVpZF9lcXVhbCgmb2ZzLT5sb3dlcl9mc1tpXS5zYi0+c191dWlkLCB1dWlk
KSkgeworCQkJb2ZzLT5sb3dlcl9mc1tpXS5ub3V1aWQgPSB0cnVlOwogCQkJcmV0dXJuIGZhbHNl
OworCQl9CiAJfQogCXJldHVybiB0cnVlOwogfQpAQCAtMTI3Nyw2ICsxMjgxLDcgQEAgc3RhdGlj
IGludCBvdmxfZ2V0X2ZzaWQoc3RydWN0IG92bF9mcyAqb2ZzLCBjb25zdCBzdHJ1Y3QgcGF0aCAq
cGF0aCkKIAl1bnNpZ25lZCBpbnQgaTsKIAlkZXZfdCBkZXY7CiAJaW50IGVycjsKKwlib29sIG5v
dXVpZCA9IGZhbHNlOwogCiAJLyogZnNpZCAwIGlzIHJlc2VydmVkIGZvciB1cHBlciBmcyBldmVu
IHdpdGggbm9uIHVwcGVyIG92ZXJsYXkgKi8KIAlpZiAob2ZzLT51cHBlcl9tbnQgJiYgb2ZzLT51
cHBlcl9tbnQtPm1udF9zYiA9PSBzYikKQEAgLTEyODgsNiArMTI5Myw3IEBAIHN0YXRpYyBpbnQg
b3ZsX2dldF9mc2lkKHN0cnVjdCBvdmxfZnMgKm9mcywgY29uc3Qgc3RydWN0IHBhdGggKnBhdGgp
CiAJfQogCiAJaWYgKCFvdmxfbG93ZXJfdXVpZF9vayhvZnMsICZzYi0+c191dWlkKSkgeworCQlu
b3V1aWQgPSB0cnVlOwogCQlvZnMtPmNvbmZpZy5pbmRleCA9IGZhbHNlOwogCQlvZnMtPmNvbmZp
Zy5uZnNfZXhwb3J0ID0gZmFsc2U7CiAJCXByX3dhcm4oIm92ZXJsYXlmczogJXMgdXVpZCBkZXRl
Y3RlZCBpbiBsb3dlciBmcyAnJXBkMicsIGZhbGxpbmcgYmFjayB0byBpbmRleD1vZmYsbmZzX2V4
cG9ydD1vZmYuXG4iLApAQCAtMTMwMyw2ICsxMzA5LDcgQEAgc3RhdGljIGludCBvdmxfZ2V0X2Zz
aWQoc3RydWN0IG92bF9mcyAqb2ZzLCBjb25zdCBzdHJ1Y3QgcGF0aCAqcGF0aCkKIAogCW9mcy0+
bG93ZXJfZnNbb2ZzLT5udW1sb3dlcmZzXS5zYiA9IHNiOwogCW9mcy0+bG93ZXJfZnNbb2ZzLT5u
dW1sb3dlcmZzXS5wc2V1ZG9fZGV2ID0gZGV2OworCW9mcy0+bG93ZXJfZnNbb2ZzLT5udW1sb3dl
cmZzXS5ub3V1aWQgPSBub3V1aWQ7CiAJb2ZzLT5udW1sb3dlcmZzKys7CiAKIAlyZXR1cm4gb2Zz
LT5udW1sb3dlcmZzOwotLSAKMi4xNy4xCgo=
--000000000000a607060596bc5612--
