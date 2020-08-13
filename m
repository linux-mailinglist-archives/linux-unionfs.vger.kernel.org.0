Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAF324394A
	for <lists+linux-unionfs@lfdr.de>; Thu, 13 Aug 2020 13:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgHMLX0 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 13 Aug 2020 07:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgHMLXZ (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 13 Aug 2020 07:23:25 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1302DC061383
        for <linux-unionfs@vger.kernel.org>; Thu, 13 Aug 2020 04:23:25 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id z3so5224517ilh.3
        for <linux-unionfs@vger.kernel.org>; Thu, 13 Aug 2020 04:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=88yNLxxsaoHcJBRx1SVcLblgpVZvR3m1RUhPyj+XgSc=;
        b=caZgvgqn4NFx3pfqYdeyc9tTSVxfrHIMBf8Agbg96R1Wt3lNn4wZN8WlATvX622Apr
         NDVpj0OEnGUx1mpYqk0Lm1vWHS1UVxWyZReSmWbRBGI3eGPwUS8DdFYPuu1YJ4mcCf9Y
         NJAM8Nkan/FbLy2ZOs6fJHaR3mDscpOTJpkKlde5RqhM+4Dw+m7+CemEzYYxTDApQIMl
         WMt9x1YK11Yqdf0Ri1uKKa97d4EUKtX4eVJuoyZ8ePVg0b3MI7jEUH5U84xao7uxtUw2
         LCIVEI46lFqtvHwV5fmxJt24YtSWqAKr19SArRn1QyJVchXKkplYW+tcgvEUeS73QsG7
         DXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88yNLxxsaoHcJBRx1SVcLblgpVZvR3m1RUhPyj+XgSc=;
        b=lHH45tDl/N/fV1+dkYzzjwBVYNgnZb04ajX85cLsPuW7OfUmdHTFVE4ZbdSlKdeuVg
         ApjD2Gu7bfMYgZyX9eF955r6dzG7KUbU8h+ewy+Xd1Ug2UxGpd1e3oW2MVz4sTcjdcIN
         DFgjJC4vyJrucCa+DdT6jKvK4r4g7jnp4mlrgAqBnRI4xMPNO59tKVzzx94ECS39Mc0e
         TqRWY9lUCHwKpgrEZjTHAuSgRFxFd/gSd5ng2bctbG088rGOPE1vzV+aCbUpH73znmlo
         5PiwoYKPkXnYyFZ7JfE9iTMzGHGojBfA5pZqrrLHKg8m7Dgy5ieOC9DvpyldapsbtnIr
         4PZw==
X-Gm-Message-State: AOAM531kaaxZ+qLtxuj9AJeYq1DtRTOWdT7BYcuy6qCvPPiRSaR14q5Y
        V44lnsONiAAHfHPXEYwFB7enfCXjz1lXjOgd+Vo=
X-Google-Smtp-Source: ABdhPJxbAUGAHcXWvxd7uNowdw1eUedqnf9XYtZ8jE9lbXS3J1G9Lp8t9dUTi3cu2wxsYCG/MS0A6ccG5kv4q4IWwIc=
X-Received: by 2002:a92:6504:: with SMTP id z4mr4217887ilb.250.1597317804336;
 Thu, 13 Aug 2020 04:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhi63LPKdmkEJjnTEgy0VaX0qXML2Uz_258_B2iZcqd3w@mail.gmail.com>
 <20190709141302.GA19084@redhat.com> <CAOQ4uxjWc8WFRFS8GTpz8uE1AHrs6yGx2A3fZy-Sxfu7CCyKuw@mail.gmail.com>
In-Reply-To: <CAOQ4uxjWc8WFRFS8GTpz8uE1AHrs6yGx2A3fZy-Sxfu7CCyKuw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 13 Aug 2020 14:23:13 +0300
Message-ID: <CAOQ4uxjz9EApvDiptgTHAOpQrTFhbeDCx4z-2vP7ApVdgLBhOw@mail.gmail.com>
Subject: Re: [RFC] Passing extra mount options to unionmount tests
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000052499905acc08844"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

--00000000000052499905acc08844
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 31, 2020 at 3:35 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > >
> > > If anyone is running unionmount-testsuite on regular basis
> > > I would be happy to know which configurations are being tested,
> > > because the test matrix grew considerably since I took over the project -
> > > both Overlayfs config options and the testsuite config options.
> >
> > For me, I think I am most interested in configuration used by
> > container runtimes (docker/podman). Docker seems to turn off
> > redirects as of now. podman is turning on metacopy (hence redirect)
> > by default now to see how do things go.
> >
> > So for me (redirect=on/off and metacopy=on/off) are important
> > configurations as of now. Having said that, I think I should talk
> > to container folks and encourage them to use "index" and "xino"
> > as well to be more posix like fs.
> >
>
> Hi Vivek,
>
> I remember you asked me about configuring extra mount options
> for unionmount but couldn't find that conversation, so replying to this
> related old discussion with my thoughts on the subject.
>
> Now that unionmount supports the environment variables:
> UNIONMOUNT_{BASEDIR,LOWERDIR,MNTPOINT}
>
> And now that xfstests has helpers to convert xfstests env vars to
> UNIONMOUNT_* env vars, one might ask: why won't we support
> UNIONMOUNT_OPTIONS=$OVERLAY_MOUNT_OPTIONS
>
> So when you asked me a question along those lines, my answer was that
> unionmount performs different validations depending on the test options,
> so for example, the test option ./run --meta adds the mount option
> "metacopy=on", but it also performs different validation tests, such as
> upper file st_blocks == 0 after metadata change.
>
> Right, so I gave a reason for why supporting extra mount options is not
> straight forward, but that doesn't mean that it is not possible.
> unionmount test could very well parse the extra mount options passed
> in env var and translate them to test config options.  As a matter of fact,
> unionmount already parses the following overlay module parameters
> and translates the following values to test config options:
>
> 1) redirect_dir does not exist => --xdev (expect EXDEV on dir rename)
> 2) redirect_dir exists and no explicit --xdev => add redirect_dir=on
> 3) index=N and --verify => add index=on and check st_ino validations
> 4) metacopy=Y => check --meta validations (e.g. upper st_blocks)
> 5) xino_auto=Y => add xino=on and check --xino validations (e.g. uniform st_dev)
>
> So apart from blindly adding the extra mount options to mount command,
> will also need to translate:
>
> 6) redirect_dir=off => --xdev
>    (redirect_dir=on conflicts with --xdev)
> 7) index=off => overrides index=on added by --verify
>    (st_ino validations should still pass on tests without multi layers)
> 8) metacopy=on => --meta
>    (metacopy=off conflicts with --meta)
> 9) xino=auto/on => --xino
>    (xino=off conflicts with --xino)
>
> At the moment, I have a patch to xfstests [1] that implements rule 8 in the
> xfstests _unionmount_testsuite_run helper, but I came to realize that would
> be wrong and that the correct way would be to implement conversion rules
> 6-9 in unionmount itself and then blindly assign in xfstest helper:
> UNIONMOUNT_OPTIONS=$OVL_BASE_MOUNT_OPTIONS
>

For whoever is interested, I implemented the above and pushed to:
https://github.com/amir73il/unionmount-testsuite/commits/mntopts

There are a few more corner cases I dealt with that are not mentioned above
(e.g. "redirect_dir=nofollow") as well as minor changes to "index" <=> --verify
dependency. For more details, see the commit message of attached patch.

There are a lot of combinations (mount options/module params/test options)
to test. I tested some manually, but might have missed something.

Thanks,
Amir.

--00000000000052499905acc08844
Content-Type: text/plain; charset="US-ASCII"; 
	name="unionmount-Add-support-for-user-defined-mount-options.patch.txt"
Content-Disposition: attachment; 
	filename="unionmount-Add-support-for-user-defined-mount-options.patch.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kdspreqc0>
X-Attachment-Id: f_kdspreqc0

RnJvbSA0ZTcwMjgyMjFhZjQyNjQxNWU3ZGU4N2YzZTEwNjA3ZmJiOGU2YjIxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBXZWQsIDEyIEF1ZyAyMDIwIDIyOjEyOjI1ICswMzAwClN1YmplY3Q6IFtQQVRDSF0gQWRk
IHN1cHBvcnQgZm9yIHVzZXIgZGVmaW5lZCBtb3VudCBvcHRpb25zCgpVbnRpbCB0aGlzIGNoYW5n
ZSwgdGhlIG1vdW50IG9wdGlvbnMgdXNlZCBmb3IgYW4gb3ZlcmFseWZzIG1vdW50IHdoZXJlCmRl
dGVybWluZWQgYnk6CjEpIFN1cHBvcnQgaW4gdGhlIGtlcm5lbCBieSBjaGVja2luZyBtb2R1bGUg
cGFyYW1zCjIpIFRlc3QgcnVuIG9wdGlvbnM6IC0teGRldiwgLS12ZXJpZnksIC0teGlubywgLS1t
ZXRhCgpBcGFydCBmcm9tIGRldGVybWluaW5nIHRoZSBvdmVybGF5ZnMgbW91bnQgb3B0aW9ucywg
dGhlIHRlc3QgcnVuIG9wdGlvbnMKYWxzbyBpbXBhY3QgdGhlIHRlc3QgbG9naWMuICBGb3IgZXhh
bXBsZSwgYWZ0ZXIgYW4gb3BlcmF0aW9uIHRoYXQgY2hhbmdlcwphIGxvd2VyIGZpbGUgbWV0YWRh
dGEsIHRoZSB0ZXN0IHZlcmlmaWVzIHRoYXQgYW4gdXBwZXIgZmlsZSBleGlzdHMuCldpdGhvdXQg
LS1tZXRhLCB0aGUgdGVzdCB2ZXJpZmllcyB0aGF0IHRoZSB1cHBlciBmaWxlIGhhcyBkYXRhLCB3
aGlsZQp3aXRoIC0tbWV0YSwgdGhlIHRlc3QgdmVyaWZpZXMgdGhhdCB0aGUgdXBwZXIgZmlsZSBk
b2VzIG5vdCBoYXZlIGRhdGEuCgpUaGUgZm9sbG93aW5nIHRlc3Qgb3B0aW9ucyBhcmUgaW1wbGll
ZCBmcm9tIG92ZXJsYXlmcyBtb2R1bGUgcGFyYW1ldGVyczoKMSkgeGlub19hdXRvPVkgPT4gLS14
aW5vCjIpIG1ldGFjb3B5PVkgPT4gLS1tZXRhY29weQoKQWRkIHN1cHBvcnQgZm9yIGFkZGluZyBh
cmJpdHJhcnkgb3ZlcmFseWZzIG1vdW50IG9wdGlvbnMgd2l0aCB0aGUKZW52aXJvbm1lbnQgdmFy
aWFibGUgVU5JT05NT1VOVF9NTlRPUFRJT05TLgoKVGhlIHVzZXIgcHJvdmlkZWQgbW91bnQgb3B0
aW9ucyB3aWxsIGJlIHVzZWQgZm9yIGFuIG92ZXJhbHlmcyBtb3VudAphbmQgZXh0cmEgbW91bnQg
b3B0aW9ucyBjb3VsZCBiZSBhZGRlZCBvbiB0b3Agb2YgdGhlbSB3aXRoIHRoZSBleGlzdGluZwp0
ZXN0IHJ1biBvcHRpb25zIChlLmcuIC0tbWV0YSkuCgpJbiBvcmRlciB0byBhZGFwdCB0aGUgdGVz
dCBsb2dpYyB0byB0aGUgZWZmZWN0aXZlIG1vdW50IG9wdGlvbnMsIHRoZQpmb2xsb3dpbmcgbW91
bnQgb3B0aW9ucyBpbXBseSB0aGUgcmVzcGVjdGl2ZSB0ZXN0IG9wdGlvbnM6CjEpICJyZWRpcmVj
dF9kaXI9IjxOT1QgIm9uIj4gPT4gLS14ZGV2CjIpICJuZnNfZXhwb3J0PW9uIiA9PiAiaW5kZXg9
b24iID0+IC0tdmVyaWZ5CjMpICJ4aW5vPW9uIiA9PiAtLXhpbm8KNCkgIm1ldGFjb3B5PW9uIiA9
PiAtLW1ldGEKCldoZW4gbW91bnQgYW5kIHRlc3Qgb3B0aW9ucyBhcmUgaW4gY29uZmxpY3QsIHRo
ZSB0ZXN0IG9wdGlvbnMgd2lucy4KRm9yIGV4YW1wbGU6ICJtZXRhY29weT1vZmYiIGFuZCAtLW1l
dGEgcmVzdWx0IGluIG1ldGFjb3B5IGVuYWJsZWQuCgpGZWF0dXJlcyBkaXNhYmxlZCBieSBtb3Vu
dCBvcHRpb25zIG92ZXJyaWRlIG1vZHVsZSBwYXJhbWV0ZXIuCkZvciBleGFtcGxlOiAibWV0YWNv
cHk9b2ZmIiBhbmQgbWV0YWNvcHk9WSByZXN1bHQgaW4gbWV0YWNvcHkgZGlzYWJsZWQuCgpUaGUg
Y29uZmxpY3QgcmVzb2x1dGlvbiBvZiAiaW5kZXg9b2ZmIiBhbmQgLS12ZXJpZnkgaXMgYSBzcGVj
aWFsIGNhc2UuClRoZSB0ZXN0IG9wdGlvbiAtLXZlcmlmeSBhY3RpdmF0ZXMgdGVzdCB2ZXJpZmlj
YXRpb25zIHRoYXQgYXJlIGV4ZWN1dGVkCmFmdGVyIGV2ZXJ5IGZpbGVzeXN0ZW0gb3BlcmF0aW9u
LiAgU29tZSBvZiB0aG9zZSB2ZXJpZmljYXRpb24gbWF5IGZhaWwKb24gbXVsdGkgbGF5ZXIgdGVz
dHMgd2l0aCBpbmRleCBmZWF0dXJlIGRpc2FibGVkIGR1ZSB0byBicm9rZW4gaGFyZGxpbmtzLgoK
VW50aWwgdGhpcyBjaGFuZ2UsIC0tdmVyaWZ5IHdvdWxkIGF1dG8gZW5hYmxlIHRoZSBpbmRleCBm
ZWF0dXJlLCBzbwp2ZXJpZmljYXRpb25zIHdpbGwgbm90IGZhaWwgaW4gbXVsdGkgbGF5ZXIgdGVz
dHMuICBXaGVuIG1vdW50IG9wdGlvbgoiaW5kZXg9b2ZmIiBpcyBwcm92aWRlZCwgLS12ZXJpZnkg
ZG9lcyBub3QgYXV0byBlbmFibGUgaW5kZXggZmVhdHVyZS4KClRvIGNvbmZvcm0gd2l0aCBiZWhh
dmlvciBvZiB0ZXN0IG9wdGlvbnMgLS14aW5vIGFuZCAtLW1ldGEsIHRoZSAtLXZlcmlmeQp0ZXN0
IG9wdGlvbiBpcyBub3cgYWxzbyBpbXBsaWVkIHdoZW4gaW5kZXggZmVhdHVyZSBpcyBlbmFibGVk
IGJ5IGRlZmF1bHQKdmlhIG1vZHVsZSBwYXJhbWV0ZXIgYW5kIG5vdCBvbmx5IGJ5IG1vdW50IG9w
dGlvbi4KClNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+
Ci0tLQogbW91bnRfdW5pb24ucHkgICB8ICAyICstCiByZW1vdW50X3VuaW9uLnB5IHwgIDIgKy0K
IHJ1biAgICAgICAgICAgICAgfCA3MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLS0KIHNldHRpbmdzLnB5ICAgICAgfCAxMiArKysrKy0tLQogdG9vbF9ib3gu
cHkgICAgICB8IDE4ICsrKysrKysrKysrKwogNSBmaWxlcyBjaGFuZ2VkLCA3NCBpbnNlcnRpb25z
KCspLCAzMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9tb3VudF91bmlvbi5weSBiL21vdW50
X3VuaW9uLnB5CmluZGV4IGFhYWEyNDIuLjg4MjE2OTUgMTAwNjQ0Ci0tLSBhL21vdW50X3VuaW9u
LnB5CisrKyBiL21vdW50X3VuaW9uLnB5CkBAIC00MSw3ICs0MSw3IEBAIGRlZiBtb3VudF91bmlv
bihjdHgpOgogICAgICAgICAgICAgb3MubWtkaXIobmVzdGVkX3VwcGVyKQogICAgICAgICAgICAg
b3MubWtkaXIobmVzdGVkX3dvcmspCiAKLSAgICAgICAgbW50b3B0ID0gIiAtb3J3IiArIGNmZy5t
bnRvcHRzKCkKKyAgICAgICAgbW50b3B0ID0gIiAtbyIgKyBjZmcubW50b3B0cygpCiAgICAgICAg
IGlmIGNmZy5pc19uZXN0ZWQoKToKICAgICAgICAgICAgIG5lc3RlZF9tbnRvcHQgPSBtbnRvcHQK
ICAgICAgICAgICAgIGlmIGNmZy5pc192ZXJpZnkoKToKZGlmZiAtLWdpdCBhL3JlbW91bnRfdW5p
b24ucHkgYi9yZW1vdW50X3VuaW9uLnB5CmluZGV4IGRjNTUyNWEuLmIyZThjM2UgMTAwNjQ0Ci0t
LSBhL3JlbW91bnRfdW5pb24ucHkKKysrIGIvcmVtb3VudF91bmlvbi5weQpAQCAtMzAsNyArMzAs
NyBAQCBkZWYgcmVtb3VudF91bmlvbihjdHgsIHJvdGF0ZV91cHBlcj1GYWxzZSk6CiAgICAgICAg
ICAgICB3b3JrZGlyID0gbGF5ZXJfbW50cm9vdCArICIvdyIKIAogICAgICAgICBtbnQgPSB1bmlv
bl9tbnRyb290Ci0gICAgICAgIG1udG9wdCA9ICIgLW9ydyIgKyBjZmcubW50b3B0cygpCisgICAg
ICAgIG1udG9wdCA9ICIgLW8iICsgY2ZnLm1udG9wdHMoKQogICAgICAgICBjbWQgPSAibW91bnQg
LXQgIiArIGNmZy5mc3R5cGUoKSArICIgIiArIGNmZy5mc25hbWUoKSArICIgIiArIG1udCArIG1u
dG9wdCArICIsbG93ZXJkaXI9IiArIGxvd2VybGF5ZXJzICsgIix1cHBlcmRpcj0iICsgdXBwZXJk
aXIgKyAiLHdvcmtkaXI9IiArIHdvcmtkaXIKICAgICAgICAgc3lzdGVtKGNtZCkKICAgICAgICAg
aWYgY2ZnLmlzX3ZlcmJvc2UoKToKZGlmZiAtLWdpdCBhL3J1biBiL3J1bgppbmRleCBkODQxYTQ1
Li40ZjM1ZTUxIDEwMDc1NQotLS0gYS9ydW4KKysrIGIvcnVuCkBAIC0xMDMsMzUgKzEwMyw0NSBA
QCBpZiBsZW4oYXJncykgPiAwIGFuZCBhcmdzWzBdLnN0YXJ0c3dpdGgoIi0tZnVzZT0iKToKICAg
ICBjZmcuc2V0X2Z1c2Vmcyh0KQogICAgIGFyZ3MgPSBhcmdzWzE6XQogCi1pZiBjZmcudGVzdGlu
Z19ub25lKCk6Ci0gICAgaW5kZXggPSBOb25lCi0gICAgeGlub19hdXRvID0gTm9uZQotICAgIHJl
ZGlyZWN0X2RpciA9IE5vbmUKLSAgICBtZXRhY29weSA9IE5vbmUKLWVsaWYgY2ZnLmlzX2Z1c2Vm
cygpOgotICAgICMgRG9uJ3QgY2hlY2sga2VybmVsIG1vZHVsZSBwYXJhbXMgZm9yIEZVU0UgdGVz
dCBhbmQgYXNzdW1lIHRoZSBmb2xsb3dpbmcKLSAgICAjIGRlZmF1bHRzLCBiZWNhdXNlIHVzZXIg
Y2FuIGRpc2FibGUgcmVkaXJlY3RfZGlyIHdpdGggLS14ZGV2IGFuZCB1c2VyIGNhbgotICAgICMg
ZW5hYmxlIGluZGV4IGFuZCB4aW5vIHdpdGggLS12ZXJpZnkKLSAgICBpbmRleCA9IEZhbHNlCi0g
ICAgeGlub19hdXRvID0gRmFsc2UKK3hpbm8gPSBOb25lCitpbmRleF9kZWYgPSBOb25lCitpbmRl
eF9vcHQgPSBOb25lCittZXRhY29weSA9IE5vbmUKK3JlZGlyZWN0X2RpciA9IE5vbmUKK2lmIGNm
Zy5pc19mdXNlZnMoKToKKyAgICAjIGZ1c2Utb3ZlcmxheWZzIG9ubHkgc3VwcG9ydHMgcmVkaXJl
Y3RfZGlyPW9mZgorICAgICMgdXNlciBjYW4gZGlzYWJsZSByZWRpcmVjdF9kaXIgd2l0aCAtLXhk
ZXYKICAgICByZWRpcmVjdF9kaXIgPSBUcnVlCi0gICAgbWV0YWNvcHkgPSBGYWxzZQogZWxpZiBj
ZmcudGVzdGluZ19vdmVybGF5ZnMoKToKLSAgICBpbmRleCA9IGNoZWNrX2Jvb2xfbW9kcGFyYW0o
ImluZGV4IikKLSAgICB4aW5vX2F1dG8gPSBjaGVja19ib29sX21vZHBhcmFtKCJ4aW5vX2F1dG8i
KQorICAgICMgT3ZlcmxheWZzIGZlYXR1cmUgInJlZGlyZWN0X2RpciIgaXMgYXV0byBlbmFibGVk
IHdpdGgga2VybmVsIHZlcnNpb24gPj0gdjQuMTAsCisgICAgIyB1bmxlc3MgZXhwbGljaXRseSBk
aXNhYmxlZCB3aXRoIC0teGRldiBvciBieSBtb3VudCBvcHRpb24uICBXaGVuIHJlZGlyZWN0X2Rp
cgorICAgICMgaXMgZGlzYWJsZWQsIG92ZXJsYXlmcyB0ZXN0cyBza2lwIHJlbmFtZSB0ZXN0cyB0
aGF0IHdvdWxkIHJlc3VsdCBpbiBFWERFVi4KICAgICByZWRpcmVjdF9kaXIgPSBjaGVja19ib29s
X21vZHBhcmFtKCJyZWRpcmVjdF9kaXIiKQotICAgICMgT3ZlcmxheWZzIGZlYXR1cmUgInJlZGly
ZWN0X2RpciIgY2FuIGJlIGVuYWJsZWQgd2l0aCBrZXJuZWwgdmVyc2lvbiA+PSB2NC4xMC4KLSAg
ICAjIE90aGVyd2lzZSwgb3ZlcmxheWZzIHRlc3RzIHNob3VsZCBza2lwIHJlbmFtZSB0ZXN0cyB0
aGF0IHdvdWxkIHJlc3VsdCBpbiBFWERFVi4KLSAgICBpZiByZWRpcmVjdF9kaXIgaXMgRmFsc2U6
CisgICAgcmVkaXJlY3RfZGlyX29mZiA9ICJyZWRpcmVjdF9kaXIiIGluIGNmZy5tbnRvcHRzKCkg
YW5kIG5vdCAicmVkaXJlY3RfZGlyPW9uIiBpbiBjZmcubW50b3B0cygpCisgICAgaWYgcmVkaXJl
Y3RfZGlyIGlzIEZhbHNlIGFuZCBub3QgcmVkaXJlY3RfZGlyX29mZjoKICAgICAgICAgY2ZnLmFk
ZF9tbnRvcHQoInJlZGlyZWN0X2Rpcj1vbiIpCiAgICAgICAgIHJlZGlyZWN0X2RpciA9IFRydWUK
LSAgICAjIHhpbm8gY2FuIGJlIGVuYWJsZWQgd2l0aCBrZXJuZWwgdmVyc2lvbiA+PSB2NC4xNwot
ICAgIGlmIHhpbm9fYXV0byBpcyBUcnVlOgotICAgICAgICBjZmcuYWRkX21udG9wdCgieGlubz1v
biIpCisgICAgIyBPdmVybGF5ZnMgZmVhdHVyZSAiaW5kZXgiIGNhbiBiZSBlbmFibGVkIHdpdGgg
LS12ZXJpZnkgb3IgYnkgbW91bnQgb3B0aW9uIG9uIGtlcm5lbCB2ZXJzaW9uID49IHY0LjEzLgor
ICAgICMgV2hlbiBpbmRleCBpcyBkaXNhYmxlZCBzb21lIHZlcmlmaWNhdGlvbnMgaW4gbXVsdGkg
bGF5ZXIgdGVzdHMgbWF5IGZhaWwgZHVlIHRvIGJyb2tlbiBoYXJkbGlua3MuCisgICAgIyBXaGVu
IGluZGV4IGlzIGVuYWJsZWQgd2Ugc2V0X3ZlcmlmeSgpLCBiZWNhdXNlIGFsbCB2ZXJpZmljYXRp
b25zIGFyZSBleHBlY3RlZCB0byBwYXNzLgorICAgIGluZGV4X2RlZiA9IGNoZWNrX2Jvb2xfbW9k
cGFyYW0oImluZGV4IikKKyAgICBpZiBub3QgaW5kZXhfZGVmIGlzIE5vbmU6CisgICAgICAgIGlu
ZGV4X29wdCA9IGNoZWNrX2Jvb2xfbW50b3B0KCJpbmRleCIsIGNmZy5tbnRvcHRzKCksIE5vbmUs
IG9ub3B0Mj0ibmZzX2V4cG9ydD1vbiIpCisgICAgaWYgaW5kZXhfZGVmIG9yIGluZGV4X29wdDoK
KyAgICAgICAgY2ZnLnNldF92ZXJpZnkoKQorICAgICMgT3ZlcmxheWZzIGZlYXR1cmUgInhpbm8i
IGNhbiBiZSBlbmFibGVkIHdpdGggLS14aW5vIG9yIGJ5IG1vdW50IG9wdGlvbiBvbiBrZXJuZWwg
dmVyc2lvbiA+PSB2NC4xNy4KKyAgICAjIFdoZW4geGlubyBpcyBlbmFibGVkIHdlIHNldF94aW5v
KCksIHNvIHN0X2luby9zdF9kZXYgdmVyaWZpY2F0aW9ucyB3aWxsIHdvcmsgY29ycmVjdGx5Lgor
ICAgIHhpbm9fZGVmID0gY2hlY2tfYm9vbF9tb2RwYXJhbSgieGlub19hdXRvIikKKyAgICBpZiBu
b3QgeGlub19kZWYgaXMgTm9uZToKKyAgICAgICAgeGlubyA9IGNoZWNrX2Jvb2xfbW50b3B0KCJ4
aW5vIiwgY2ZnLm1udG9wdHMoKSwgeGlub19kZWYsIG9ub3B0Mj0ieGlubz1hdXRvIikKKyAgICBp
ZiB4aW5vOgogICAgICAgICBjZmcuc2V0X3hpbm8oKQotICAgICMgbWV0YWNvcHkgY2FuIGJlIGVu
YWJsZWQgd2l0aCBrZXJuZWwgdmVyc2lvbiA+PSB2NC4xOQotICAgIG1ldGFjb3B5ID0gY2hlY2tf
Ym9vbF9tb2RwYXJhbSgibWV0YWNvcHkiKQotICAgIGlmIG1ldGFjb3B5IGlzIFRydWU6CisgICAg
IyBPdmVybGF5ZnMgZmVhdHVyZSAibWV0YWNvcHkiIGNhbiBiZSBlbmFibGVkIHdpdGggLS1tZXRh
IGFuZCBieSBtb3VudCBvcHRpb24gb24ga2VybmVsIHZlcnNpb24gPj0gdjQuMTkuCisgICAgIyBX
aGVuIG1ldGFjb3B5IGlzIGVuYWJsZWQgd2Ugc2V0X21ldGFjb3B5KCksIHNvIGNvcHkgdXAgdmVy
aWZpY2F0aW9ucyB3aWxsIHdvcmsgY29ycmVjdGx5LgorICAgIG1ldGFjb3B5X2RlZiA9IGNoZWNr
X2Jvb2xfbW9kcGFyYW0oIm1ldGFjb3B5IikKKyAgICBpZiBub3QgbWV0YWNvcHlfZGVmIGlzIE5v
bmU6CisgICAgICAgIG1ldGFjb3B5ID0gY2hlY2tfYm9vbF9tbnRvcHQoIm1ldGFjb3B5IiwgY2Zn
Lm1udG9wdHMoKSwgbWV0YWNvcHlfZGVmLCBvZmZvcHQyPSJuZnNfZXhwb3J0PW9uIikKKyAgICBp
ZiBtZXRhY29weToKICAgICAgICAgY2ZnLnNldF9tZXRhY29weSgpCiAKIG1heGZzID0gY2ZnLm1h
eGZzKCkKQEAgLTE3NCwxMSArMTg0LDExIEBAIHdoaWxlIGxlbihhcmdzKSA+IDAgYW5kIGFyZ3Nb
MF0uc3RhcnRzd2l0aCgiLSIpOgogICAgICAgICB0ZXJtc2xhc2ggPSAiMSIKICAgICBlbGlmIGFy
Z3NbMF0gPT0gIi0teGRldiI6CiAgICAgICAgICMgRGlzYWJsZSAicmVkaXJlY3RfZGlyIiBhbmQg
c2tpcCBkaXIgcmVuYW1lIHRlc3RzCi0gICAgICAgIGlmIHJlZGlyZWN0X2RpciBpcyBUcnVlOgor
ICAgICAgICBpZiByZWRpcmVjdF9kaXI6CiAgICAgICAgICAgICBjZmcuYWRkX21udG9wdCgicmVk
aXJlY3RfZGlyPW9mZiIpCiAgICAgICAgICAgICByZWRpcmVjdF9kaXIgPSBGYWxzZQogICAgIGVs
aWYgYXJnc1swXSA9PSAiLS14aW5vIjoKLSAgICAgICAgaWYgeGlub19hdXRvIGlzIE5vbmU6Cisg
ICAgICAgIGlmIHhpbm8gaXMgTm9uZToKICAgICAgICAgICAgIHByaW50KCJ4aW5vIG5vdCBzdXBw
b3J0ZWQgLSBpZ25vcmluZyAtLXhpbm8iKQogICAgICAgICBlbHNlOgogICAgICAgICAgICAgY2Zn
LmFkZF9tbnRvcHQoInhpbm89b24iKQpAQCAtMTkxLDcgKzIwMSw4IEBAIHdoaWxlIGxlbihhcmdz
KSA+IDAgYW5kIGFyZ3NbMF0uc3RhcnRzd2l0aCgiLSIpOgogICAgICAgICAgICAgY2ZnLnNldF9t
ZXRhY29weSgpCiAgICAgZWxpZiBhcmdzWzBdID09ICItLXZlcmlmeSI6CiAgICAgICAgIGNmZy5z
ZXRfdmVyaWZ5KCkKLSAgICAgICAgaWYgaW5kZXggaXMgRmFsc2U6CisgICAgICAgICMgYXV0byBl
bmFibGUgaW5kZXggZm9yIC0tdmVyaWZ5IHVubGVzcyBleHBsaWNpdGx5IGRpc2FibGVkCisgICAg
ICAgIGlmIGluZGV4X2RlZiBpcyBGYWxzZSBhbmQgbm90IGluZGV4X29wdCBpcyBGYWxzZToKICAg
ICAgICAgICAgIGNmZy5hZGRfbW50b3B0KCJpbmRleD1vbiIpCiAgICAgZWxzZToKICAgICAgICAg
c2hvd19mb3JtYXQoIkludmFsaWQgZmxhZyAiICsgYXJnc1swXSkKQEAgLTI5Niw3ICszMDcsMTUg
QEAgZm9yIHRlc3QgaW4gdGVzdHM6CiAgICAgICAgICAgICAgICAgdGVzdF9ob3cgKz0gIiAtLW1h
eGZzPSIgKyBzdHIobWF4ZnMpCiAgICAgICAgICAgICBlbGlmIG1heGZzIDwgMDoKICAgICAgICAg
ICAgICAgICB0ZXN0X2hvdyArPSAiIC0tc2FtZWZzIgotICAgICAgICBtc2cgPSBjZmcucHJvZ25h
bWUoKSArICIgIiArIHRlc3RfaG93ICsgIiAtLXRzPSIgKyB0ZXJtc2xhc2ggKyAiICIgKyB0ZXN0
CisgICAgICAgICAgICBpZiBub3QgcmVkaXJlY3RfZGlyOgorICAgICAgICAgICAgICAgIHRlc3Rf
aG93ICs9ICIgLS14ZGV2IgorICAgICAgICAgICAgaWYgY2ZnLmlzX3hpbm8oKToKKyAgICAgICAg
ICAgICAgICB0ZXN0X2hvdyArPSAiIC0teGlubyIKKyAgICAgICAgICAgIGlmIGNmZy5pc19tZXRh
Y29weSgpOgorICAgICAgICAgICAgICAgIHRlc3RfaG93ICs9ICIgLS1tZXRhIgorICAgICAgICAg
ICAgaWYgY2ZnLmlzX3ZlcmlmeSgpOgorICAgICAgICAgICAgICAgIHRlc3RfaG93ICs9ICIgLS12
ZXJpZnkiCisgICAgICAgIG1zZyA9IGNmZy5wcm9nbmFtZSgpICsgIiAiICsgdGVzdF9ob3cgKyAi
ICIgKyB0ZXN0CiAgICAgICAgIHByaW50KCIqKioiKTsKICAgICAgICAgcHJpbnQoIioqKiIsIG1z
Zyk7CiAgICAgICAgIHByaW50KCIqKioiKTsKZGlmZiAtLWdpdCBhL3NldHRpbmdzLnB5IGIvc2V0
dGluZ3MucHkKaW5kZXggZmZhZTUyNy4uYjc5ZTFmNyAxMDA2NDQKLS0tIGEvc2V0dGluZ3MucHkK
KysrIGIvc2V0dGluZ3MucHkKQEAgLTMwLDEzICszMCwxOCBAQCBjbGFzcyBjb25maWc6CiAgICAg
ICAgIHNlbGYuX19iYXNlX21udHJvb3QgPSBvcy5nZXRlbnYoJ1VOSU9OTU9VTlRfQkFTRURJUicp
CiAgICAgICAgIHNlbGYuX19sb3dlcl9tbnRyb290ID0gb3MuZ2V0ZW52KCdVTklPTk1PVU5UX0xP
V0VSRElSJykKICAgICAgICAgc2VsZi5fX3VuaW9uX21udHJvb3QgPSBvcy5nZXRlbnYoJ1VOSU9O
TU9VTlRfTU5UUE9JTlQnKQorICAgICAgICBzZWxmLl9fbW50b3B0cyA9IG9zLmdldGVudignVU5J
T05NT1VOVF9NTlRPUFRJT05TJykKICAgICAgICAgcHJpbnQoIkVudmlyb25tZW50IHZhcmlhYmxl
czoiKQogICAgICAgICBpZiBzZWxmLl9fYmFzZV9tbnRyb290OgotICAgICAgICAgICAgcHJpbnQo
IlVOSU9OTU9VTlRfQkFTRURJUj0iICsgc2VsZi5fX2Jhc2VfbW50cm9vdCkKKyAgICAgICAgICAg
IHByaW50KCJVTklPTk1PVU5UX0JBU0VESVI9JyIgKyBzZWxmLl9fYmFzZV9tbnRyb290ICsgIici
KQogICAgICAgICBpZiBzZWxmLl9fbG93ZXJfbW50cm9vdDoKLSAgICAgICAgICAgIHByaW50KCJV
TklPTk1PVU5UX0xPV0VSRElSPSIgKyBzZWxmLl9fbG93ZXJfbW50cm9vdCkKKyAgICAgICAgICAg
IHByaW50KCJVTklPTk1PVU5UX0xPV0VSRElSPSciICsgc2VsZi5fX2xvd2VyX21udHJvb3QgKyAi
JyIpCiAgICAgICAgIGlmIHNlbGYuX191bmlvbl9tbnRyb290OgotICAgICAgICAgICAgcHJpbnQo
IlVOSU9OTU9VTlRfTU5UUE9JTlQ9IiArIHNlbGYuX191bmlvbl9tbnRyb290KQorICAgICAgICAg
ICAgcHJpbnQoIlVOSU9OTU9VTlRfTU5UUE9JTlQ9JyIgKyBzZWxmLl9fdW5pb25fbW50cm9vdCAr
ICInIikKKyAgICAgICAgaWYgc2VsZi5fX21udG9wdHM6CisgICAgICAgICAgICBwcmludCgiVU5J
T05NT1VOVF9NTlRPUFRJT05TPSciICsgc2VsZi5fX21udG9wdHMgKyAiJyIpCisgICAgICAgIGVs
c2U6ICMgVXNlIGFyYml0cmFyeSBub24gZW1wdHkgc3RyaW5nIHRvIHNpbXBsaWZ5IGFkZF9tbnRv
cHQoKQorICAgICAgICAgICAgc2VsZi5fX21udG9wdHMgPSAicnciCiAgICAgICAgIHByaW50KCkK
ICAgICAgICAgaWYgc2VsZi5fX2Jhc2VfbW50cm9vdCBhbmQgbm90IHNlbGYuX19sb3dlcl9tbnRy
b290OgogICAgICAgICAgICAgIyBFbXB0eSBVTklPTk1PVU5UX0xPV0VSRElSIHdpdGggbm9uLWVt
cHR5IFVOSU9OTU9VTlRfQkFTRURJUiBpbXBseSAtLXNhbWVmcwpAQCAtNTAsNyArNTUsNiBAQCBj
bGFzcyBjb25maWc6CiAgICAgICAgIHNlbGYuX19tZXRhY29weSA9IEZhbHNlCiAgICAgICAgIHNl
bGYuX19uZXN0ZWQgPSBGYWxzZQogICAgICAgICBzZWxmLl9feGlubyA9IEZhbHNlCi0gICAgICAg
IHNlbGYuX19tbnRvcHRzID0gIiIKICAgICAgICAgc2VsZi5fX2Z1c2VmcyA9IEZhbHNlCiAgICAg
ICAgIHNlbGYuX19mc3R5cGUgPSAib3ZlcmxheSIKICAgICAgICAgc2VsZi5fX2ZzbmFtZSA9ICJv
dmVybGF5IgpkaWZmIC0tZ2l0IGEvdG9vbF9ib3gucHkgYi90b29sX2JveC5weQppbmRleCAwMzUw
NmZlLi5iZjFmNTc4IDEwMDY0NAotLS0gYS90b29sX2JveC5weQorKysgYi90b29sX2JveC5weQpA
QCAtNjQsMyArNjQsMjEgQEAgZGVmIGNoZWNrX2Jvb2xfbW9kcGFyYW0ocGFyYW0pOgogICAgIGV4
Y2VwdCBGaWxlTm90Rm91bmRFcnJvcjoKICAgICAgICAgcmV0dXJuIE5vbmUKICAgICByZXR1cm4g
dmFsdWUuc3RhcnRzd2l0aCgiWSIpCisKKyMKKyMgQ2hlY2sgaWYgb3ZlcmxheSBmZWF0dXJlIGlz
IGVuYWJsZWQgYnkgbW91bnQgb3B0aW9uCisjCisjIFJldHVybiAnZGVmYXVsdCcgaWYgbW91bnQg
b3B0aW9uIHdhcyBub3QgcHJvdmlkZWQKKyMKK2RlZiBjaGVja19ib29sX21udG9wdChmZWF0dXJl
LCBtbnRvcHRzLCBkZWZhdWx0LCBvbm9wdDI9Tm9uZSwgb2Zmb3B0Mj1Ob25lKToKKyAgICBvbm9w
dCA9IGZlYXR1cmUgKyAiPW9uIgorICAgIG9mZm9wdCA9IGZlYXR1cmUgKyAiPW9mZiIKKyAgICBv
biA9IG9ub3B0IGluIG1udG9wdHMgb3IgKG9ub3B0MiBhbmQgb25vcHQyIGluIG1udG9wdHMpCisg
ICAgb2ZmID0gb2Zmb3B0IGluIG1udG9wdHMgb3IgKG9mZm9wdDIgYW5kIG9mZm9wdDIgaW4gbW50
b3B0cykKKyAgICBpZiBvbiBhbmQgb2ZmOgorICAgICAgICByYWlzZSBSdW50aW1lRXJyb3IoIkNv
bmZsaWN0aW5nIG1vdW50IG9wdGlvbnMgdy5yLnQgZmVhdHVyZSAnIiArIGZlYXR1cmUgKyAiJzog
IiArIG1udG9wdHMpCisgICAgaWYgb246CisgICAgICAgIHJldHVybiBUcnVlCisgICAgaWYgb2Zm
OgorICAgICAgICByZXR1cm4gRmFsc2UKKyAgICByZXR1cm4gZGVmYXVsdDsKLS0gCjIuMTcuMQoK
--00000000000052499905acc08844--
