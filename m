Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9416E60B8
	for <lists+linux-unionfs@lfdr.de>; Tue, 18 Apr 2023 14:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjDRMJg (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 18 Apr 2023 08:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjDRMIv (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 18 Apr 2023 08:08:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F58E1024B
        for <linux-unionfs@vger.kernel.org>; Tue, 18 Apr 2023 05:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681819376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=63GbK/KJ1/lsPq3DryN8/EGV0TfMGHKQ6TvXj38rlcc=;
        b=KXo3fdqeTzTSMKjvMiZDlSoZS3cmiVKyaCzQBbqBdZ+COcKxw6pRHV3ucYrdpVsItB4H7/
        ah5BUPJiVvrzts2kN8UihsECtLv4KYVg85Wd0v867DnEjWq2JEc8DChY3TdWdl5n6Cd8rp
        6xDdRhzvMo2jXzxPhRb/2cU+fbKa7y8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-J7f8dQzYMO-N4qeWdWEfow-1; Tue, 18 Apr 2023 08:02:55 -0400
X-MC-Unique: J7f8dQzYMO-N4qeWdWEfow-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4ec9e0761c6so3985582e87.1
        for <linux-unionfs@vger.kernel.org>; Tue, 18 Apr 2023 05:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681819374; x=1684411374;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=63GbK/KJ1/lsPq3DryN8/EGV0TfMGHKQ6TvXj38rlcc=;
        b=EhYmzG7CKeJsJOyiGL3PvWjNXSCi80Zr3ZYrBNAbfLqcKVOnJdvySmH338LZDJCmQU
         D5+Q+sPz/C/rSau+QPsJDFd+NyyORSluBf6pFBFGaKwEeveNFrC8P1vNAvmKqmG4COT+
         tZ8jhlI2GYHs8tYuhq6DeEL62KqyywUEQmPsrQjTGxWAuNGb+YcoDNTmxf6fNBUA6w66
         hPo0zO0JYsHtGJsNWXS9OgrDp9oyP79Y11Q0o9RX/KEIRuzXzixP2hiwj+ZAi+aOT3gZ
         VHWbqP0io/8wLRzAlFHa9hPwHZVaHXhD5hPWlIvcOCs+e4rVXbsmIScgPUISYpQyAVam
         tcow==
X-Gm-Message-State: AAQBX9fGMr41oqsp6ArcVsCE2vqo4AJ9WG0vVwM0/IBgaTapoXSkHggo
        eoR+0PRGSuAWPmewpfE8aBPvY/5IhJ79mlMfF4FZ+FO/8NCEJMGEKGoaS98pmwnLnx+D8CNcC8L
        9oup6MYMPRYlA6cB1kgsEHXHu1w==
X-Received: by 2002:ac2:54a6:0:b0:4dd:9eb6:443e with SMTP id w6-20020ac254a6000000b004dd9eb6443emr2224483lfk.31.1681819373870;
        Tue, 18 Apr 2023 05:02:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350aE4oRjtO8nwCW2Zp2TkFuGWKjVspKGfYQoL+b8sfJPfY03+sW5RVMeA/PVgL+nAvbyXENfkQ==
X-Received: by 2002:ac2:54a6:0:b0:4dd:9eb6:443e with SMTP id w6-20020ac254a6000000b004dd9eb6443emr2224477lfk.31.1681819373465;
        Tue, 18 Apr 2023 05:02:53 -0700 (PDT)
Received: from greebo.mooo.com (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id x2-20020a19f602000000b004d40e22c1eesm2351745lfe.252.2023.04.18.05.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 05:02:52 -0700 (PDT)
Message-ID: <8ac422621de7b422cf4b744463f3c1e4bae148d9.camel@redhat.com>
Subject: Re: [PATCH 2/5] ovl: introduce data-only lower layers
From:   Alexander Larsson <alexl@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org
Date:   Tue, 18 Apr 2023 14:02:52 +0200
In-Reply-To: <20230412135412.1684197-3-amir73il@gmail.com>
References: <20230412135412.1684197-1-amir73il@gmail.com>
         <20230412135412.1684197-3-amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

T24gV2VkLCAyMDIzLTA0LTEyIGF0IDE2OjU0ICswMzAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToK
PiBJbnRyb2R1Y2UgdGhlIGZvcm1hdCBsb3dlcmRpcj1sb3dlcjE6bG93ZXIyOjpsb3dlcmRhdGEx
Omxvd2VyZGF0YTIKPiB3aGVyZSB0aGUgbG93ZXIgbGF5ZXJzIGFmdGVyIHRoZSA6OiBzZXBhcmF0
b3IgYXJlIG5vdCBtZXJnZWQgaW50byB0aGUKPiBvdmVybGF5ZnMgbWVyZ2UgZGlycy4KPiAKPiBU
aGUgZmlsZXMgaW4gdGhvc2UgbGF5ZXJzIGFyZSBvbmx5IG1lYW50IHRvIGJlIGFjY2Vzc2libGUg
dmlhCj4gYWJzb2x1dGUKPiByZWRpcmVjdCBmcm9tIG1ldGFjb3B5IGZpbGVzIGluIGxvd2VyIGxh
eWVycy7CoCBGb2xsb3dpbmcgY2hhbmdlcyB3aWxsCj4gaW1wbGVtZW50IGxvb2t1cCBpbiB0aGUg
ZGF0YSBsYXllcnMuCj4gCj4gVGhpcyBmZWF0dXJlIHdhcyByZXF1ZXN0ZWQgZm9yIGNvbXBvc2Vm
cyBvc3RyZWUgdXNlIGNhc2UsIHdoZXJlIHRoZQo+IGxvd2VyIGRhdGEgbGF5ZXIgc2hvdWxkIG9u
bHkgYmUgYWNjZXNzaWFibGUgdmlhIGFic29sdXRlIHJlZGlyZWN0cwo+IGZyb20gbWV0YWNvcHkg
aW5vZGVzLgo+IAo+IFRoZSBsb3dlciBkYXRhIGxheWVycyBhcmUgbm90IHJlcXVpcmVkIHRvIGEg
aGF2ZSBhIHVuaXF1ZSB1dWlkIG9yIGFueQo+IHV1aWQgYXQgYWxsLCBiZWNhdXNlIHRoZXkgYXJl
IG5ldmVyIHVzZWQgdG8gY29tcG9zZSB0aGUgb3ZlcmxheWZzCj4gaW5vZGUKPiBzdF9pbm8vc3Rf
ZGV2Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5j
b20+CgpSZXZpZXdlZC1ieTogQWxleGFuZGVyIExhcnNzb24gPGFsZXhsQHJlZGhhdC5jb20+Cgo+
IC0tLQo+IMKgRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9vdmVybGF5ZnMucnN0IHwgMzIgKysr
KysrKysrKysrKysrKysKPiDCoGZzL292ZXJsYXlmcy9uYW1laS5jwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQgKy0tCj4gwqBmcy9vdmVybGF5ZnMvb3ZsX2VudHJ5
LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDkgKysrKysKPiDCoGZzL292ZXJs
YXlmcy9zdXBlci5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0NiAr
KysrKysrKysrKysrKysrKysrKystLQo+IC0tCj4gwqA0IGZpbGVzIGNoYW5nZWQsIDgyIGluc2Vy
dGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
ZmlsZXN5c3RlbXMvb3ZlcmxheWZzLnJzdAo+IGIvRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9v
dmVybGF5ZnMucnN0Cj4gaW5kZXggNGM3NmZkYTA3NjQ1Li5jOGUwNGE0ZjBlMjEgMTAwNjQ0Cj4g
LS0tIGEvRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9vdmVybGF5ZnMucnN0Cj4gKysrIGIvRG9j
dW1lbnRhdGlvbi9maWxlc3lzdGVtcy9vdmVybGF5ZnMucnN0Cj4gQEAgLTM3MSw2ICszNzEsMzgg
QEAgY29uZmxpY3Qgd2l0aCBtZXRhY29weT1vbiwgYW5kIHdpbGwgcmVzdWx0IGluIGFuCj4gZXJy
b3IuCj4gwqBbKl0gcmVkaXJlY3RfZGlyPWZvbGxvdyBvbmx5IGNvbmZsaWN0cyB3aXRoIG1ldGFj
b3B5PW9uIGlmCj4gdXBwZXJkaXI9Li4uIGlzCj4gwqBnaXZlbi4KPiDCoAo+ICsKPiArRGF0YS1v
bmx5IGxvd2VyIGxheWVycwo+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gKwo+ICtXaXRoICJt
ZXRhY29weSIgZmVhdHVyZSBlbmFibGVkLCBhbiBvdmVybGF5ZnMgcmVndWxhciBmaWxlIG1heSBi
ZSBhCj4gY29tcG9zaXRpb24KPiArb2YgaW5mb3JtYXRpb24gZnJvbSB1cCB0byB0aHJlZSBkaWZm
ZXJlbnQgbGF5ZXJzOgo+ICsKPiArIDEpIG1ldGFkYXRhIGZyb20gYSBmaWxlIGluIHRoZSB1cHBl
ciBsYXllcgo+ICsKPiArIDIpIHN0X2lubyBhbmQgc3RfZGV2IG9iamVjdCBpZGVudGlmaWVyIGZy
b20gYSBmaWxlIGluIGEgbG93ZXIgbGF5ZXIKPiArCj4gKyAzKSBkYXRhIGZyb20gYSBmaWxlIGlu
IGFub3RoZXIgbG93ZXIgbGF5ZXIgKGZ1cnRoZXIgYmVsb3cpCj4gKwo+ICtUaGUgImxvd2VyIGRh
dGEiIGZpbGUgY2FuIGJlIG9uIGFueSBsb3dlciBsYXllciwgZXhjZXB0IGZyb20gdGhlIHRvcAo+
IG1vc3QKPiArbG93ZXIgbGF5ZXIuCj4gKwo+ICtCZWxvdyB0aGUgdG9wIG1vc3QgbG93ZXIgbGF5
ZXIsIGFueSBudW1iZXIgb2YgbG93ZXIgbW9zdCBsYXllcnMgbWF5Cj4gYmUgZGVmaW5lZAo+ICth
cyAiZGF0YS1vbmx5IiBsb3dlciBsYXllcnMsIHVzaW5nIHRoZSBkb3VibGUgY29sbG9uICgiOjoi
KQo+IHNlcGFyYXRvci4KCiJjb2xvbiIsIG5vdCAiY29sbG9uIgoKPiArCj4gK0ZvciBleGFtcGxl
Ogo+ICsKPiArwqAgbW91bnQgLXQgb3ZlcmxheSBvdmVybGF5IC1vbG93ZXJkaXI9L2xvd2VyMTo6
L2xvd2VyMjovbG93ZXIzCj4gL21lcmdlZAo+ICsKPiArVGhlIHBhdGhzIG9mIGZpbGVzIGluIHRo
ZSAiZGF0YS1vbmx5IiBsb3dlciBsYXllcnMgYXJlIG5vdCB2aXNpYmxlCj4gaW4gdGhlCj4gK21l
cmdlZCBvdmVybGF5ZnMgZGlyZWN0b3JpZXMgYW5kIHRoZSBtZXRhZGF0YSBhbmQgc3RfaW5vL3N0
X2RldiBvZgo+IGZpbGVzCj4gK2luIHRoZSAiZGF0YS1vbmx5IiBsb3dlciBsYXllcnMgYXJlIG5v
dCB2aXNpYmxlIGluIG92ZXJsYXlmcyBpbm9kZXMuCj4gKwo+ICtPbmx5IHRoZSBkYXRhIG9mIHRo
ZSBmaWxlcyBpbiB0aGUgImRhdGEtb25seSIgbG93ZXIgbGF5ZXJzIG1heSBiZQo+IHZpc2libGUK
PiArd2hlbiBhICJtZXRhY29weSIgZmlsZSBpbiBvbmUgb2YgdGhlIGxvd2VyIGxheWVycyBhYm92
ZSBpdCwgaGFzIGEKPiAicmVkaXJlY3QiCj4gK3RvIHRoZSBhYnNvbHV0ZSBwYXRoIG9mIHRoZSAi
bG93ZXIgZGF0YSIgZmlsZSBpbiB0aGUgImRhdGEtb25seSIKPiBsb3dlciBsYXllci4KPiArCj4g
Kwo+IMKgU2hhcmluZyBhbmQgY29weWluZyBsYXllcnMKPiDCoC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCj4gwqAKPiBkaWZmIC0tZ2l0IGEvZnMvb3ZlcmxheWZzL25hbWVpLmMgYi9mcy9vdmVy
bGF5ZnMvbmFtZWkuYwo+IGluZGV4IGI2MjkyNjEzMjRmMS4uZmY4MjE1NWI0ZjdlIDEwMDY0NAo+
IC0tLSBhL2ZzL292ZXJsYXlmcy9uYW1laS5jCj4gKysrIGIvZnMvb3ZlcmxheWZzL25hbWVpLmMK
PiBAQCAtMzU2LDcgKzM1Niw3IEBAIGludCBvdmxfY2hlY2tfb3JpZ2luX2ZoKHN0cnVjdCBvdmxf
ZnMgKm9mcywKPiBzdHJ1Y3Qgb3ZsX2ZoICpmaCwgYm9vbCBjb25uZWN0ZWQsCj4gwqDCoMKgwqDC
oMKgwqDCoHN0cnVjdCBkZW50cnkgKm9yaWdpbiA9IE5VTEw7Cj4gwqDCoMKgwqDCoMKgwqDCoGlu
dCBpOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgZm9yIChpID0gMTsgaSA8IG9mcy0+bnVtbGF5ZXI7
IGkrKykgewo+ICvCoMKgwqDCoMKgwqDCoGZvciAoaSA9IDE7IGkgPD0gb3ZsX251bWxvd2VybGF5
ZXIob2ZzKTsgaSsrKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKgo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogSWYgbG93ZXIgZnMgdXVpZCBpcyBub3Qg
dW5pcXVlIGFtb25nIGxvd2VyIGZzIHdlCj4gY2Fubm90IG1hdGNoCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKiBmaC0+dXVpZCB0byBsYXllci4KPiBAQCAtOTA3LDcgKzkwNyw3
IEBAIHN0cnVjdCBkZW50cnkgKm92bF9sb29rdXAoc3RydWN0IGlub2RlICpkaXIsCj4gc3RydWN0
IGRlbnRyeSAqZGVudHJ5LAo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGlmICghZC5zdG9wICYmIG92
bF9udW1sb3dlcihwb2UpKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlcnIg
PSAtRU5PTUVNOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdGFjayA9IG92bF9z
dGFja19hbGxvYyhvZnMtPm51bWxheWVyIC0gMSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHN0YWNrID0gb3ZsX3N0YWNrX2FsbG9jKG92bF9udW1sb3dlcmxheWVyKG9mcykpOwo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFzdGFjaykKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF9wdXRfdXBwZXI7
Cj4gwqDCoMKgwqDCoMKgwqDCoH0KCkFnYWluLCBzdXJlbHkgb3ZsX251bWxvd2VyKHBvZSkgaXMg
YSBiZXR0ZXIgc2l6ZSBoZXJlPwoKPiBkaWZmIC0tZ2l0IGEvZnMvb3ZlcmxheWZzL292bF9lbnRy
eS5oIGIvZnMvb3ZlcmxheWZzL292bF9lbnRyeS5oCj4gaW5kZXggMjIxZjBjYmU3NDhlLi4yNWZh
YmIzMTc1Y2YgMTAwNjQ0Cj4gLS0tIGEvZnMvb3ZlcmxheWZzL292bF9lbnRyeS5oCj4gKysrIGIv
ZnMvb3ZlcmxheWZzL292bF9lbnRyeS5oCj4gQEAgLTYyLDYgKzYyLDggQEAgc3RydWN0IG92bF9m
cyB7Cj4gwqDCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGludCBudW1sYXllcjsKPiDCoMKgwqDCoMKg
wqDCoMKgLyogTnVtYmVyIG9mIHVuaXF1ZSBmcyBhbW9uZyBsYXllcnMgaW5jbHVkaW5nIHVwcGVy
IGZzICovCj4gwqDCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGludCBudW1mczsKPiArwqDCoMKgwqDC
oMKgwqAvKiBOdW1iZXIgb2YgZGF0YS1vbmx5IGxvd2VyIGxheWVycyAqLwo+ICvCoMKgwqDCoMKg
wqDCoHVuc2lnbmVkIGludCBudW1kYXRhbGF5ZXI7Cj4gwqDCoMKgwqDCoMKgwqDCoGNvbnN0IHN0
cnVjdCBvdmxfbGF5ZXIgKmxheWVyczsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IG92bF9zYiAq
ZnM7Cj4gwqDCoMKgwqDCoMKgwqDCoC8qIHdvcmtiYXNlZGlyIGlzIHRoZSBwYXRoIGF0IHdvcmtk
aXI9IG1vdW50IG9wdGlvbiAqLwo+IEBAIC05NSw2ICs5NywxMyBAQCBzdHJ1Y3Qgb3ZsX2ZzIHsK
PiDCoMKgwqDCoMKgwqDCoMKgZXJyc2VxX3QgZXJyc2VxOwo+IMKgfTsKPiDCoAo+ICsKPiArLyog
TnVtYmVyIG9mIGxvd2VyIGxheWVycywgbm90IGluY2x1ZGluZyBkYXRhLW9ubHkgbGF5ZXJzICov
Cj4gK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IG92bF9udW1sb3dlcmxheWVyKHN0cnVjdCBv
dmxfZnMgKm9mcykKPiArewo+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBvZnMtPm51bWxheWVyIC0g
b2ZzLT5udW1kYXRhbGF5ZXIgLSAxOwo+ICt9Cj4gKwo+IMKgc3RhdGljIGlubGluZSBzdHJ1Y3Qg
dmZzbW91bnQgKm92bF91cHBlcl9tbnQoc3RydWN0IG92bF9mcyAqb2ZzKQo+IMKgewo+IMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gb2ZzLT5sYXllcnNbMF0ubW50Owo+IGRpZmYgLS1naXQgYS9mcy9v
dmVybGF5ZnMvc3VwZXIuYyBiL2ZzL292ZXJsYXlmcy9zdXBlci5jCj4gaW5kZXggNzc0MmFlZjNm
M2IzLi4zNDg0ZjM5YThmMjcgMTAwNjQ0Cj4gLS0tIGEvZnMvb3ZlcmxheWZzL3N1cGVyLmMKPiAr
KysgYi9mcy9vdmVybGF5ZnMvc3VwZXIuYwo+IEBAIC0xNTc5LDYgKzE1NzksMTYgQEAgc3RhdGlj
IGludCBvdmxfZ2V0X2ZzaWQoc3RydWN0IG92bF9mcyAqb2ZzLAo+IGNvbnN0IHN0cnVjdCBwYXRo
ICpwYXRoKQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gb2ZzLT5udW1mcysrOwo+IMKgfQo+IMKg
Cj4gKy8qCj4gKyAqIFRoZSBmc2lkIGFmdGVyIHRoZSBsYXN0IGxvd2VyIGZzaWQgaXMgdXNlZCBm
b3IgdGhlIGRhdGEgbGF5ZXJzLgo+ICsgKiBJdCBpcyBhICJudWxsIGZzIiB3aXRoIGEgbnVsbCBz
YiwgbnVsbCB1dWlkLCBhbmQgbm8gcHNldWRvIGRldi4KPiArICovCj4gK3N0YXRpYyBpbnQgb3Zs
X2dldF9kYXRhX2ZzaWQoc3RydWN0IG92bF9mcyAqb2ZzKQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKg
cmV0dXJuIG9mcy0+bnVtZnM7Cj4gK30KPiArCj4gKwo+IMKgc3RhdGljIGludCBvdmxfZ2V0X2xh
eWVycyhzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3Qgb3ZsX2ZzCj4gKm9mcywKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcGF0
aCAqc3RhY2ssIHVuc2lnbmVkIGludCBudW1sb3dlciwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgb3ZsX2xheWVyICpsYXllcnMpCj4g
QEAgLTE1ODYsMTEgKzE1OTYsMTQgQEAgc3RhdGljIGludCBvdmxfZ2V0X2xheWVycyhzdHJ1Y3Qg
c3VwZXJfYmxvY2sKPiAqc2IsIHN0cnVjdCBvdmxfZnMgKm9mcywKPiDCoMKgwqDCoMKgwqDCoMKg
aW50IGVycjsKPiDCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50IGk7Cj4gwqAKPiAtwqDCoMKg
wqDCoMKgwqBvZnMtPmZzID0ga2NhbGxvYyhudW1sb3dlciArIDEsIHNpemVvZihzdHJ1Y3Qgb3Zs
X3NiKSwKPiBHRlBfS0VSTkVMKTsKPiArwqDCoMKgwqDCoMKgwqBvZnMtPmZzID0ga2NhbGxvYyhu
dW1sb3dlciArIDIsIHNpemVvZihzdHJ1Y3Qgb3ZsX3NiKSwKPiBHRlBfS0VSTkVMKTsKPiDCoMKg
wqDCoMKgwqDCoMKgaWYgKG9mcy0+ZnMgPT0gTlVMTCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybiAtRU5PTUVNOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgLyogaWR4L2Zz
aWQgMCBhcmUgcmVzZXJ2ZWQgZm9yIHVwcGVyIGZzIGV2ZW4gd2l0aCBsb3dlciBvbmx5Cj4gb3Zl
cmxheSAqLwo+ICvCoMKgwqDCoMKgwqDCoC8qCj4gK8KgwqDCoMKgwqDCoMKgICogaWR4L2ZzaWQg
MCBhcmUgcmVzZXJ2ZWQgZm9yIHVwcGVyIGZzIGV2ZW4gd2l0aCBsb3dlciBvbmx5Cj4gb3Zlcmxh
eQo+ICvCoMKgwqDCoMKgwqDCoCAqIGFuZCB0aGUgbGFzdCBmc2lkIGlzIHJlc2VydmVkIGZvciAi
bnVsbCBmcyIgb2YgdGhlIGRhdGEKPiBsYXllcnMuCj4gK8KgwqDCoMKgwqDCoMKgICovCj4gwqDC
oMKgwqDCoMKgwqDCoG9mcy0+bnVtZnMrKzsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAvKgo+IEBA
IC0xNjE1LDcgKzE2MjgsMTAgQEAgc3RhdGljIGludCBvdmxfZ2V0X2xheWVycyhzdHJ1Y3Qgc3Vw
ZXJfYmxvY2sKPiAqc2IsIHN0cnVjdCBvdmxfZnMgKm9mcywKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHN0cnVjdCBpbm9kZSAqdHJhcDsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGludCBmc2lkOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGZzaWQgPSBvdmxfZ2V0X2ZzaWQob2ZzLCAmc3RhY2tbaV0pOwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpZiAoaSA8IG51bWxvd2VyIC0gb2ZzLT5udW1kYXRhbGF5ZXIpCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmc2lkID0gb3ZsX2dl
dF9mc2lkKG9mcywgJnN0YWNrW2ldKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ZWxzZQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZnNp
ZCA9IG92bF9nZXRfZGF0YV9mc2lkKG9mcyk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBpZiAoZnNpZCA8IDApCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmV0dXJuIGZzaWQ7Cj4gwqAKPiBAQCAtMTcwMyw2ICsxNzE5LDcgQEAgc3Rh
dGljIGludCBvdmxfZ2V0X2xvd2Vyc3RhY2soc3RydWN0Cj4gc3VwZXJfYmxvY2sgKnNiLCBzdHJ1
Y3Qgb3ZsX2VudHJ5ICpvZSwKPiDCoMKgwqDCoMKgwqDCoMKgaW50IGVycjsKPiDCoMKgwqDCoMKg
wqDCoMKgc3RydWN0IHBhdGggKnN0YWNrID0gTlVMTDsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0
IG92bF9wYXRoICpsb3dlcnN0YWNrOwo+ICvCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGludCBudW1s
b3dlcmRhdGEgPSAwOwo+IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgaTsKPiDCoAo+IMKg
wqDCoMKgwqDCoMKgwqBpZiAoIW9mcy0+Y29uZmlnLnVwcGVyZGlyICYmIG51bWxvd2VyID09IDEp
IHsKPiBAQCAtMTcxNCwxMyArMTczMSwyNyBAQCBzdGF0aWMgaW50IG92bF9nZXRfbG93ZXJzdGFj
ayhzdHJ1Y3QKPiBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBvdmxfZW50cnkgKm9lLAo+IMKgwqDC
oMKgwqDCoMKgwqBpZiAoIXN0YWNrKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuIC1FTk9NRU07Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqBlcnIgPSAtRUlOVkFMOwo+IC3C
oMKgwqDCoMKgwqDCoGZvciAoaSA9IDA7IGkgPCBudW1sb3dlcjsgaSsrKSB7Cj4gK8KgwqDCoMKg
wqDCoMKgZm9yIChpID0gMDsgaSA8IG51bWxvd2VyOykgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZXJyID0gb3ZsX2xvd2VyX2Rpcihsb3dlciwgJnN0YWNrW2ldLCBvZnMsICZz
Yi0KPiA+c19zdGFja19kZXB0aCk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBp
ZiAoZXJyKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGdvdG8gb3V0X2VycjsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbG93
ZXIgPSBzdHJjaHIobG93ZXIsICdcMCcpICsgMTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGkrKzsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXJyID0gLUVJ
TlZBTDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogOjogc2VwZXJhdG9yIGlu
ZGljYXRlcyB0aGUgc3RhcnQgb2YgbG93ZXIgZGF0YQo+IGxheWVycyAqLwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoISpsb3dlciAmJiBpIDwgbnVtbG93ZXIgJiYgIW51bWxv
d2VyZGF0YSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgaWYgKCFvZnMtPmNvbmZpZy5tZXRhY29weSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByX2VycigibG93ZXIgZGF0
YS1vbmx5IGRpcnMgcmVxdWlyZQo+IG1ldGFjb3B5IHN1cHBvcnQuXG4iKTsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3Rv
IG91dF9lcnI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB9Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsb3dl
cisrOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbnVt
bG93ZXItLTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oG9mcy0+bnVtZGF0YWxheWVyID0gbnVtbG93ZXJkYXRhID0gbnVtbG93ZXIgLQo+IGk7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcl9pbmZvKCJ1c2lu
ZyB0aGUgbG93ZXN0ICVkIG9mICVkIGxvd2VyZGlycwo+IGFzIGRhdGEgbGF5ZXJzXG4iLAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoG51bWxvd2VyZGF0YSwgbnVtbG93ZXIpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB9Cj4gwqDCoMKgwqDCoMKgwqDCoH0KClRoaXMgd2lsbCBoYW5kbGUgYSAiOjoiIGF0IHRo
ZSBlbmQgb2YgdGhlIHN0cmluZyBhcyBhbiBlcnJvci4gTWF5YmUgaXQKd291bGQgYmUgYmV0dGVy
IHRvIHRyZWF0IGl0IGFzICJ6ZXJvIGxvd2VyIGRhdGEgbGF5ZXJhIiwgdG8gbWFrZSBjb2RlCnRo
YXQgZ2VuZXJhdGVzIG1vdW50IG9wdGlvbnMgbW9yZSByZWd1bGFyPyBOb3QgYSBodWdlIGlzc3Vl
IHRob3VnaC4KCj4gwqDCoMKgwqDCoMKgwqDCoGVyciA9IC1FSU5WQUw7Cj4gQEAgLTE3MzQsMTIg
KzE3NjUsMTMgQEAgc3RhdGljIGludCBvdmxfZ2V0X2xvd2Vyc3RhY2soc3RydWN0Cj4gc3VwZXJf
YmxvY2sgKnNiLCBzdHJ1Y3Qgb3ZsX2VudHJ5ICpvZSwKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKGVy
cikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0X2VycjsKPiDCoAo+
IC3CoMKgwqDCoMKgwqDCoGVyciA9IG92bF9pbml0X2VudHJ5KG9lLCBOVUxMLCBudW1sb3dlcik7
Cj4gK8KgwqDCoMKgwqDCoMKgLyogRGF0YS1vbmx5IGxheWVycyBhcmUgbm90IG1lcmdlZCBpbiBy
b290IGRpcmVjdG9yeSAqLwo+ICvCoMKgwqDCoMKgwqDCoGVyciA9IG92bF9pbml0X2VudHJ5KG9l
LCBOVUxMLCBudW1sb3dlciAtIG51bWxvd2VyZGF0YSk7Cj4gwqDCoMKgwqDCoMKgwqDCoGlmIChl
cnIpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF9lcnI7Cj4gwqAK
PiDCoMKgwqDCoMKgwqDCoMKgbG93ZXJzdGFjayA9IG92bF9sb3dlcnN0YWNrKG9lKTsKPiAtwqDC
oMKgwqDCoMKgwqBmb3IgKGkgPSAwOyBpIDwgbnVtbG93ZXI7IGkrKykgewo+ICvCoMKgwqDCoMKg
wqDCoGZvciAoaSA9IDA7IGkgPCBudW1sb3dlciAtIG51bWxvd2VyZGF0YTsgaSsrKSB7Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsb3dlcnN0YWNrW2ldLmRlbnRyeSA9IGRnZXQo
c3RhY2tbaV0uZGVudHJ5KTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxvd2Vy
c3RhY2tbaV0ubGF5ZXIgPSAmb2ZzLT5sYXllcnNbaSsxXTsKPiDCoMKgwqDCoMKgwqDCoMKgfQoK
LS0gCj0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09
LT0tPS09LT0tPS09LT0tPS0KPS09LT0KIEFsZXhhbmRlciBMYXJzc29uICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSZWQgSGF0LApJbmMgCiAgICAgICBhbGV4bEBy
ZWRoYXQuY29tICAgICAgICAgICAgYWxleGFuZGVyLmxhcnNzb25AZ21haWwuY29tIApIZSdzIGEg
b25lLWxlZ2dlZCBuYXRpdmUgQW1lcmljYW4gbWFzdGVyIGNyaW1pbmFsIG9uIHRoZSBlZGdlLiBT
aGUncyBhIApzdXBlcm5hdHVyYWwgcGFyYW5vaWQgd3Jlc3RsZXIgd2l0aCBzb21lb25lIGVsc2Un
cyBtZW1vcmllcy4gVGhleSBmaWdodApjcmltZSEgCg==

