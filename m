Return-Path: <linux-unionfs+bounces-213-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4B083297B
	for <lists+linux-unionfs@lfdr.de>; Fri, 19 Jan 2024 13:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71AC91C23272
	for <lists+linux-unionfs@lfdr.de>; Fri, 19 Jan 2024 12:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18894F202;
	Fri, 19 Jan 2024 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ex7xtoZ+"
X-Original-To: linux-unionfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86C34F1F9
	for <linux-unionfs@vger.kernel.org>; Fri, 19 Jan 2024 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705667366; cv=none; b=O4YhdmaFCYMb94sWXPQVkDC93KCdo/VyWKMnVQLeYbzkRGLlHkNsMrlX2+d5Bo0H/1HvrqrFk7MzgLPeVxNjLW9OR1+pJOJnLiwkTbO/y2ug2WV4pPJtzvjTsxQifv8CHELyBV86st4AwaFrDf+cczZE6DipkKH97LLrPUszN7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705667366; c=relaxed/simple;
	bh=EmMuTyct4AF91+c+Ndfsih18WuxHurIuihc7YISE4AU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JT+oZDZECe1Vsf3wuW4curevnn65E6mIyg0jWwOwjzgFgualBfg4bvotiez/bc1lRja1u9Gcug242koVgnPHUrZFdQjKAsBeUFvfU0rO4arMPhG4hWlbiBqGeTRU7kq20+FsAR9Tfdcwo2SP6mmNErOnT7zFkq4+Yq0bCtdeeUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ex7xtoZ+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705667363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EmMuTyct4AF91+c+Ndfsih18WuxHurIuihc7YISE4AU=;
	b=Ex7xtoZ+MEhkoy0o3TSwyPIxFYrqJoFMHQJLMVSWF3UQGWzwQAa4t6/1DsX4VGaxI4WJ2N
	RZ75B3zUHwKL8pOAlj2M7OR3gT1OqMG/PERJP2wYJ7zlCgau4qtqUqwE9aQPh8EEXPD7+h
	5AtcGlGOhCP095nX/KGxJH7S4MpwXy8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-Wubpe-IKP8eqDQB9limapg-1; Fri, 19 Jan 2024 07:29:22 -0500
X-MC-Unique: Wubpe-IKP8eqDQB9limapg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50ed86962f6so546164e87.1
        for <linux-unionfs@vger.kernel.org>; Fri, 19 Jan 2024 04:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705667360; x=1706272160;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EmMuTyct4AF91+c+Ndfsih18WuxHurIuihc7YISE4AU=;
        b=YPL6xwFq43hE6qZcIjZLMT+prgw1Kz/oUJpfQmya1bvh2Cdw5CCGZC6svO5l771bA+
         8vz82nGHmj/omgVfDNvTtXAMcs+6J0cRldpxJiPja4pNP3KCsDLVClrb5Ibn8fSxZQqC
         KUHY5OuecFtwTvSgNm6iJDpZFbhS132TWUmmpY6Z5iQZ1LWyZrdUHH9V59JNDr4uVjwc
         NGq7iA8lm7udqxoSh85L30hOqmDLSYRGCBU8OAYpHn4NoiCeMj92dzazk4+Jnl+kKyZs
         XkSipjo2564FCwILFHz6DbkeMmjJA9ePCHluYb+301CLgYIPCDfwPi/A6T8aiyGrgegt
         2U9A==
X-Gm-Message-State: AOJu0YzGz9EG/tR0Bqfj/2+9KMyZV/pwN7MqfRCtX5xOoerACC82BkM0
	HkBXg2dMcHeGf32Z8lr3sImXRGjwTeD7tC1rkx4cnwxY6bgfPBdfftKGXba+SUBCULCfpjtbFvV
	Vcipt10mwNETMwTHGYx51yqiwqw9HiBmPTq4PFJj44IxyQFLIbNIocU0GB4W0viw=
X-Received: by 2002:ac2:4886:0:b0:50e:7d50:fca4 with SMTP id x6-20020ac24886000000b0050e7d50fca4mr287471lfc.220.1705667360670;
        Fri, 19 Jan 2024 04:29:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJISwUDmmfAdU+xgnPGocR+dYEGi6JjSbh7Y9+JW4pyOZjpjiT3SVRI3F2aS3MnLq/hCD62Q==
X-Received: by 2002:ac2:4886:0:b0:50e:7d50:fca4 with SMTP id x6-20020ac24886000000b0050e7d50fca4mr287463lfc.220.1705667360302;
        Fri, 19 Jan 2024 04:29:20 -0800 (PST)
Received: from [172.31.0.10] (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id c15-20020a056512238f00b0050e7e304238sm954702lfv.19.2024.01.19.04.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 04:29:19 -0800 (PST)
Message-ID: <b50d431b154bdc64462e561d9da8f04e53f1603c.camel@redhat.com>
Subject: Re: [PATCH v2] ovl: require xwhiteout feature flag on layer roots
From: Alexander Larsson <alexl@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Fri, 19 Jan 2024 13:29:19 +0100
In-Reply-To: <CAOQ4uxiWtdgCQ+kBJemAYbwNR46ogP7DhjD29cqAw0qqLvQn4A@mail.gmail.com>
References: <20240119101454.532809-1-mszeredi@redhat.com>
	 <CAOQ4uxiWtdgCQ+kBJemAYbwNR46ogP7DhjD29cqAw0qqLvQn4A@mail.gmail.com>
Autocrypt: addr=alexl@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI0LTAxLTE5IGF0IDEzOjA4ICswMjAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToK
PiBPbiBGcmksIEphbiAxOSwgMjAyNCBhdCAxMjoxNOKAr1BNIE1pa2xvcyBTemVyZWRpIDxtc3pl
cmVkaUByZWRoYXQuY29tPgo+IHdyb3RlOgo+ID4gCj4gPiBBZGQgYSBjaGVjayBvbiBlYWNoIGxv
d2VyIGxheWVyIGZvciB0aGUgeHdoaXRlb3V0IGZlYXR1cmUuwqAgVGhpcwo+ID4gcHJldmVudHMK
PiA+IHVubmVjZXNzYXJ5IGNoZWNraW5nIHRoZSBvdmVybGF5LndoaXRlb3V0cyB4YXR0ciB3aGVu
IHJlYWRpbmcgYQo+ID4gZGlyZWN0b3J5Cj4gPiBpZiB0aGlzIGZlYXR1cmUgaXMgbm90IGVuYWJs
ZWQsIGkuZS4gbW9zdCBvZiB0aGUgdGltZS4KPiA+IAo+ID4gU2hhcmUgdGhlIHNhbWUgeGF0dHIg
Zm9yIHRoZSBwZXItZGlyZWN0b3J5IGFuZCB0aGUgcGVyLWxheWVyIGZsYWcsCj4gPiB3aGljaAo+
ID4gaGFzIHRoZSBlZmZlY3QgdGhhdCBpZiB0aGlzIGlzIGVuYWJsZWQgZm9yIGEgbGF5ZXIsIHRo
ZW4gdGhlCj4gPiBvcHRpbWl6YXRpb24KPiA+IHRvIGJ5cGFzcyBjaGVja2luZyBvZiBpbmRpdmlk
dWFsIGVudHJpZXMgZG9lcyBub3Qgd29yayBvbiB0aGUgcm9vdAo+ID4gb2YgdGhlCj4gPiBsYXll
ci7CoCBUaGlzIHdhcyBkZWVtZWQgYmV0dGVyLCB0aGFuIGhhdmluZyBhIHNlcGFyYXRlIHhhdHRy
IGZvcgo+ID4gdGhlIGxheWVyCj4gPiBhbmQgdGhlIGRpcmVjdG9yeS4KPiA+IAo+ID4gRml4ZXM6
IGJjOGRmN2EzZGMwMyAoIm92bDogQWRkIGFuIGFsdGVybmF0aXZlIHR5cGUgb2Ygd2hpdGVvdXQi
KQo+ID4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIHY2LjcKPiA+IFNpZ25lZC1vZmYt
Ynk6IE1pa2xvcyBTemVyZWRpIDxtc3plcmVkaUByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiB2MjoK
PiA+IMKgLSB1c2Ugb3ZlcmxheS53aGl0ZW91dHMgaW5zdGVhZCBvZiBvdmVybGF5LmZlYXR1cmVf
eHdoaXRlb3V0Cj4gPiDCoC0gbW92ZSBpbml0aWFsaXphdGlvbiB0byBvdmxfZ2V0X2xheWVycygp
Cj4gPiDCoC0geHdoaXRlb3V0cyBjYW4gb25seSBiZSBlbmFibGVkIG9uIGxvd2VyIGxheWVyCj4g
PiAKPiA+IMKgZnMvb3ZlcmxheWZzL25hbWVpLmPCoMKgwqDCoCB8IDEwICsrKysrKystLS0KPiA+
IMKgZnMvb3ZlcmxheWZzL292ZXJsYXlmcy5oIHzCoCA3ICsrKysrLS0KPiA+IMKgZnMvb3Zlcmxh
eWZzL292bF9lbnRyeS5oIHzCoCAyICsrCj4gPiDCoGZzL292ZXJsYXlmcy9yZWFkZGlyLmPCoMKg
IHwgMTEgKysrKysrKystLS0KPiA+IMKgZnMvb3ZlcmxheWZzL3N1cGVyLmPCoMKgwqDCoCB8IDEz
ICsrKysrKysrKysrKysKPiA+IMKgZnMvb3ZlcmxheWZzL3V0aWwuY8KgwqDCoMKgwqAgfMKgIDcg
KysrKysrLQo+ID4gwqA2IGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDkgZGVsZXRp
b25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9mcy9vdmVybGF5ZnMvbmFtZWkuYyBiL2ZzL292
ZXJsYXlmcy9uYW1laS5jCj4gPiBpbmRleCAwM2JjOGQ1ZGZhMzEuLjU4M2NmNTZkZjY2ZSAxMDA2
NDQKPiA+IC0tLSBhL2ZzL292ZXJsYXlmcy9uYW1laS5jCj4gPiArKysgYi9mcy9vdmVybGF5ZnMv
bmFtZWkuYwo+ID4gQEAgLTg2Myw3ICs4NjMsOCBAQCBzdHJ1Y3QgZGVudHJ5ICpvdmxfbG9va3Vw
X2luZGV4KHN0cnVjdCBvdmxfZnMKPiA+ICpvZnMsIHN0cnVjdCBkZW50cnkgKnVwcGVyLAo+ID4g
wqAgKiBSZXR1cm5zIG5leHQgbGF5ZXIgaW4gc3RhY2sgc3RhcnRpbmcgZnJvbSB0b3AuCj4gPiDC
oCAqIFJldHVybnMgLTEgaWYgdGhpcyBpcyB0aGUgbGFzdCBsYXllci4KPiA+IMKgICovCj4gPiAt
aW50IG92bF9wYXRoX25leHQoaW50IGlkeCwgc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBzdHJ1Y3Qg
cGF0aAo+ID4gKnBhdGgpCj4gPiAraW50IG92bF9wYXRoX25leHQoaW50IGlkeCwgc3RydWN0IGRl
bnRyeSAqZGVudHJ5LCBzdHJ1Y3QgcGF0aAo+ID4gKnBhdGgsCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IG92bF9sYXllciAqKmxheWVyKQo+ID4gwqB7
Cj4gPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgb3ZsX2VudHJ5ICpvZSA9IE9WTF9FKGRlbnRyeSk7
Cj4gPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgb3ZsX3BhdGggKmxvd2Vyc3RhY2sgPSBvdmxfbG93
ZXJzdGFjayhvZSk7Cj4gPiBAQCAtODcxLDEzICs4NzIsMTYgQEAgaW50IG92bF9wYXRoX25leHQo
aW50IGlkeCwgc3RydWN0IGRlbnRyeQo+ID4gKmRlbnRyeSwgc3RydWN0IHBhdGggKnBhdGgpCj4g
PiDCoMKgwqDCoMKgwqDCoCBCVUdfT04oaWR4IDwgMCk7Cj4gPiDCoMKgwqDCoMKgwqDCoCBpZiAo
aWR4ID09IDApIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvdmxfcGF0aF91
cHBlcihkZW50cnksIHBhdGgpOwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KHBhdGgtPmRlbnRyeSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChwYXRo
LT5kZW50cnkpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAqbGF5ZXIgPSAmT1ZMX0ZTKGRlbnRyeS0+ZF9zYiktPmxheWVyc1swXTsKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIG92bF9udW1s
b3dlcihvZSkgPyAxIDogLTE7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWR4Kys7Cj4gPiDCoMKgwqDCoMKgwqDC
oCB9Cj4gPiDCoMKgwqDCoMKgwqDCoCBCVUdfT04oaWR4ID4gb3ZsX251bWxvd2VyKG9lKSk7Cj4g
PiDCoMKgwqDCoMKgwqDCoCBwYXRoLT5kZW50cnkgPSBsb3dlcnN0YWNrW2lkeCAtIDFdLmRlbnRy
eTsKPiA+IC3CoMKgwqDCoMKgwqAgcGF0aC0+bW50ID0gbG93ZXJzdGFja1tpZHggLSAxXS5sYXll
ci0+bW50Owo+ID4gK8KgwqDCoMKgwqDCoCAqbGF5ZXIgPSBsb3dlcnN0YWNrW2lkeCAtIDFdLmxh
eWVyOwo+ID4gK8KgwqDCoMKgwqDCoCBwYXRoLT5tbnQgPSAoKmxheWVyKS0+bW50Owo+ID4gCj4g
PiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gKGlkeCA8IG92bF9udW1sb3dlcihvZSkpID8gaWR4ICsg
MSA6IC0xOwo+ID4gwqB9Cj4gPiBkaWZmIC0tZ2l0IGEvZnMvb3ZlcmxheWZzL292ZXJsYXlmcy5o
IGIvZnMvb3ZlcmxheWZzL292ZXJsYXlmcy5oCj4gPiBpbmRleCAwNWMzZGQ1OTdmYTguLjYzNTlj
ZjVjNjZmZiAxMDA2NDQKPiA+IC0tLSBhL2ZzL292ZXJsYXlmcy9vdmVybGF5ZnMuaAo+ID4gKysr
IGIvZnMvb3ZlcmxheWZzL292ZXJsYXlmcy5oCj4gPiBAQCAtNDkyLDcgKzQ5Miw5IEBAIGJvb2wg
b3ZsX3BhdGhfY2hlY2tfZGlyX3hhdHRyKHN0cnVjdCBvdmxfZnMKPiA+ICpvZnMsIGNvbnN0IHN0
cnVjdCBwYXRoICpwYXRoLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnVtIG92bF94YXR0ciBveCk7Cj4gPiDCoGJvb2wgb3Zs
X3BhdGhfY2hlY2tfb3JpZ2luX3hhdHRyKHN0cnVjdCBvdmxfZnMgKm9mcywgY29uc3Qgc3RydWN0
Cj4gPiBwYXRoICpwYXRoKTsKPiA+IMKgYm9vbCBvdmxfcGF0aF9jaGVja194d2hpdGVvdXRfeGF0
dHIoc3RydWN0IG92bF9mcyAqb2ZzLCBjb25zdAo+ID4gc3RydWN0IHBhdGggKnBhdGgpOwo+ID4g
LWJvb2wgb3ZsX3BhdGhfY2hlY2tfeHdoaXRlb3V0c194YXR0cihzdHJ1Y3Qgb3ZsX2ZzICpvZnMs
IGNvbnN0Cj4gPiBzdHJ1Y3QgcGF0aCAqcGF0aCk7Cj4gPiArYm9vbCBvdmxfcGF0aF9jaGVja194
d2hpdGVvdXRzX3hhdHRyKHN0cnVjdCBvdmxfZnMgKm9mcywKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNv
bnN0IHN0cnVjdCBvdmxfbGF5ZXIgKmxheWVyLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3Ry
dWN0IHBhdGggKnBhdGgpOwo+ID4gwqBib29sIG92bF9pbml0X3V1aWRfeGF0dHIoc3RydWN0IHN1
cGVyX2Jsb2NrICpzYiwgc3RydWN0IG92bF9mcwo+ID4gKm9mcywKPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgcGF0aCAqdXBw
ZXJwYXRoKTsKPiA+IAo+ID4gQEAgLTY3NCw3ICs2NzYsOCBAQCBpbnQgb3ZsX2dldF9pbmRleF9u
YW1lKHN0cnVjdCBvdmxfZnMgKm9mcywKPiA+IHN0cnVjdCBkZW50cnkgKm9yaWdpbiwKPiA+IMKg
c3RydWN0IGRlbnRyeSAqb3ZsX2dldF9pbmRleF9maChzdHJ1Y3Qgb3ZsX2ZzICpvZnMsIHN0cnVj
dCBvdmxfZmgKPiA+ICpmaCk7Cj4gPiDCoHN0cnVjdCBkZW50cnkgKm92bF9sb29rdXBfaW5kZXgo
c3RydWN0IG92bF9mcyAqb2ZzLCBzdHJ1Y3QgZGVudHJ5Cj4gPiAqdXBwZXIsCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
dHJ1Y3QgZGVudHJ5ICpvcmlnaW4sIGJvb2wKPiA+IHZlcmlmeSk7Cj4gPiAtaW50IG92bF9wYXRo
X25leHQoaW50IGlkeCwgc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBzdHJ1Y3QgcGF0aAo+ID4gKnBh
dGgpOwo+ID4gK2ludCBvdmxfcGF0aF9uZXh0KGludCBpZHgsIHN0cnVjdCBkZW50cnkgKmRlbnRy
eSwgc3RydWN0IHBhdGgKPiA+ICpwYXRoLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNvbnN0IHN0cnVjdCBvdmxfbGF5ZXIgKipsYXllcik7Cj4gPiDCoGludCBvdmxfdmVy
aWZ5X2xvd2VyZGF0YShzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpOwo+ID4gwqBzdHJ1Y3QgZGVudHJ5
ICpvdmxfbG9va3VwKHN0cnVjdCBpbm9kZSAqZGlyLCBzdHJ1Y3QgZGVudHJ5Cj4gPiAqZGVudHJ5
LAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dW5zaWduZWQgaW50IGZsYWdzKTsKPiA+IGRpZmYgLS1naXQgYS9mcy9vdmVybGF5ZnMvb3ZsX2Vu
dHJ5LmggYi9mcy9vdmVybGF5ZnMvb3ZsX2VudHJ5LmgKPiA+IGluZGV4IGQ4MmQyYTA0M2RhMi4u
MzNmY2QzZDNhZjMwIDEwMDY0NAo+ID4gLS0tIGEvZnMvb3ZlcmxheWZzL292bF9lbnRyeS5oCj4g
PiArKysgYi9mcy9vdmVybGF5ZnMvb3ZsX2VudHJ5LmgKPiA+IEBAIC00MCw2ICs0MCw4IEBAIHN0
cnVjdCBvdmxfbGF5ZXIgewo+ID4gwqDCoMKgwqDCoMKgwqAgaW50IGlkeDsKPiA+IMKgwqDCoMKg
wqDCoMKgIC8qIE9uZSBmc2lkIHBlciB1bmlxdWUgdW5kZXJseWluZyBzYiAodXBwZXIgZnNpZCA9
PSAwKSAqLwo+ID4gwqDCoMKgwqDCoMKgwqAgaW50IGZzaWQ7Cj4gPiArwqDCoMKgwqDCoMKgIC8q
IHh3aGl0ZW91dHMgYXJlIGVuYWJsZWQgb24gdGhpcyBsYXllciovCj4gPiArwqDCoMKgwqDCoMKg
IGJvb2wgeHdoaXRlb3V0czsKPiA+IMKgfTsKPiA+IAo+ID4gwqBzdHJ1Y3Qgb3ZsX3BhdGggewo+
ID4gZGlmZiAtLWdpdCBhL2ZzL292ZXJsYXlmcy9yZWFkZGlyLmMgYi9mcy9vdmVybGF5ZnMvcmVh
ZGRpci5jCj4gPiBpbmRleCBhNDkwZmM0N2MzZTcuLmMyNTk3MDc1ZTNmOCAxMDA2NDQKPiA+IC0t
LSBhL2ZzL292ZXJsYXlmcy9yZWFkZGlyLmMKPiA+ICsrKyBiL2ZzL292ZXJsYXlmcy9yZWFkZGly
LmMKPiA+IEBAIC0zMDUsOCArMzA1LDYgQEAgc3RhdGljIGlubGluZSBpbnQgb3ZsX2Rpcl9yZWFk
KGNvbnN0IHN0cnVjdAo+ID4gcGF0aCAqcmVhbHBhdGgsCj4gPiDCoMKgwqDCoMKgwqDCoCBpZiAo
SVNfRVJSKHJlYWxmaWxlKSkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gUFRSX0VSUihyZWFsZmlsZSk7Cj4gPiAKPiA+IC3CoMKgwqDCoMKgwqAgcmRkLT5pbl94d2hp
dGVvdXRzX2RpciA9IHJkZC0+ZGVudHJ5ICYmCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBvdmxfcGF0aF9jaGVja194d2hpdGVvdXRzX3hhdHRyKE9WTF9GUyhyZGQtPmRlbnRyeS0K
PiA+ID5kX3NiKSwgcmVhbHBhdGgpOwo+ID4gwqDCoMKgwqDCoMKgwqAgcmRkLT5maXJzdF9tYXli
ZV93aGl0ZW91dCA9IE5VTEw7Cj4gPiDCoMKgwqDCoMKgwqDCoCByZGQtPmN0eC5wb3MgPSAwOwo+
ID4gwqDCoMKgwqDCoMKgwqAgZG8gewo+ID4gQEAgLTM1OSwxMCArMzU3LDE0IEBAIHN0YXRpYyBp
bnQgb3ZsX2Rpcl9yZWFkX21lcmdlZChzdHJ1Y3QgZGVudHJ5Cj4gPiAqZGVudHJ5LCBzdHJ1Y3Qg
bGlzdF9oZWFkICpsaXN0LAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5pc19s
b3dlc3QgPSBmYWxzZSwKPiA+IMKgwqDCoMKgwqDCoMKgIH07Cj4gPiDCoMKgwqDCoMKgwqDCoCBp
bnQgaWR4LCBuZXh0Owo+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3Qgb3ZsX2ZzICpvZnMgPSBPVkxf
RlMoZGVudHJ5LT5kX3NiKTsKPiA+ICvCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IG92bF9sYXll
ciAqbGF5ZXI7Cj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgIGZvciAoaWR4ID0gMDsgaWR4ICE9IC0x
OyBpZHggPSBuZXh0KSB7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXh0ID0g
b3ZsX3BhdGhfbmV4dChpZHgsIGRlbnRyeSwgJnJlYWxwYXRoKTsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIG5leHQgPSBvdmxfcGF0aF9uZXh0KGlkeCwgZGVudHJ5LCAmcmVhbHBh
dGgsCj4gPiAmbGF5ZXIpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJkZC5p
c191cHBlciA9IG92bF9kZW50cnlfdXBwZXIoZGVudHJ5KSA9PQo+ID4gcmVhbHBhdGguZGVudHJ5
Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG92bF9wYXRoX2NoZWNrX3h3
aGl0ZW91dHNfeGF0dHIob2ZzLCBsYXllciwKPiA+ICZyZWFscGF0aCkpCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmRkLmluX3h3aGl0ZW91dHNfZGly
ID0gdHJ1ZTsKPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChuZXh0
ICE9IC0xKSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGVyciA9IG92bF9kaXJfcmVhZCgmcmVhbHBhdGgsICZyZGQpOwo+ID4gQEAgLTU2OCw2ICs1
NzAsNyBAQCBzdGF0aWMgaW50IG92bF9kaXJfcmVhZF9pbXB1cmUoY29uc3Qgc3RydWN0Cj4gPiBw
YXRoICpwYXRoLMKgIHN0cnVjdCBsaXN0X2hlYWQgKmxpc3QsCj4gPiDCoMKgwqDCoMKgwqDCoCBp
bnQgZXJyOwo+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IHBhdGggcmVhbHBhdGg7Cj4gPiDCoMKg
wqDCoMKgwqDCoCBzdHJ1Y3Qgb3ZsX2NhY2hlX2VudHJ5ICpwLCAqbjsKPiA+ICvCoMKgwqDCoMKg
wqAgc3RydWN0IG92bF9mcyAqb2ZzID0gT1ZMX0ZTKHBhdGgtPmRlbnRyeS0+ZF9zYik7Cj4gPiDC
oMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgb3ZsX3JlYWRkaXJfZGF0YSByZGQgPSB7Cj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLmN0eC5hY3RvciA9IG92bF9maWxsX3BsYWluLAo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5saXN0ID0gbGlzdCwKPiA+IEBAIC01Nzcs
NiArNTgwLDggQEAgc3RhdGljIGludCBvdmxfZGlyX3JlYWRfaW1wdXJlKGNvbnN0IHN0cnVjdAo+
ID4gcGF0aCAqcGF0aCzCoCBzdHJ1Y3QgbGlzdF9oZWFkICpsaXN0LAo+ID4gwqDCoMKgwqDCoMKg
wqAgSU5JVF9MSVNUX0hFQUQobGlzdCk7Cj4gPiDCoMKgwqDCoMKgwqDCoCAqcm9vdCA9IFJCX1JP
T1Q7Cj4gPiDCoMKgwqDCoMKgwqDCoCBvdmxfcGF0aF91cHBlcihwYXRoLT5kZW50cnksICZyZWFs
cGF0aCk7Cj4gPiArwqDCoMKgwqDCoMKgIGlmIChvdmxfcGF0aF9jaGVja194d2hpdGVvdXRzX3hh
dHRyKG9mcywgJm9mcy0+bGF5ZXJzWzBdLAo+ID4gJnJlYWxwYXRoKSkKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJkZC5pbl94d2hpdGVvdXRzX2RpciA9IHRydWU7Cj4gCj4gTm90
IG5lZWRlZCBzaW5jZSB3ZSBkbyBub3Qgc3VwcG9ydCB4d2hpdGVvdXRzIG9uIHVwcGVyLgo+IAo+
ID4gCj4gPiDCoMKgwqDCoMKgwqDCoCBlcnIgPSBvdmxfZGlyX3JlYWQoJnJlYWxwYXRoLCAmcmRk
KTsKPiA+IMKgwqDCoMKgwqDCoMKgIGlmIChlcnIpCj4gPiBkaWZmIC0tZ2l0IGEvZnMvb3Zlcmxh
eWZzL3N1cGVyLmMgYi9mcy9vdmVybGF5ZnMvc3VwZXIuYwo+ID4gaW5kZXggYTA5NjdiYjI1MDAz
Li4wNDU4ODcyMWViMmEgMTAwNjQ0Cj4gPiAtLS0gYS9mcy9vdmVybGF5ZnMvc3VwZXIuYwo+ID4g
KysrIGIvZnMvb3ZlcmxheWZzL3N1cGVyLmMKPiA+IEBAIC0xMDI3LDYgKzEwMjcsNyBAQCBzdGF0
aWMgaW50IG92bF9nZXRfbGF5ZXJzKHN0cnVjdCBzdXBlcl9ibG9jawo+ID4gKnNiLCBzdHJ1Y3Qg
b3ZsX2ZzICpvZnMsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IG92
bF9mc19jb250ZXh0X2xheWVyICpsID0gJmN0eC0+bG93ZXJbaV07Cj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHZmc21vdW50ICptbnQ7Cj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGlub2RlICp0cmFwOwo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc3RydWN0IHBhdGggcm9vdDsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpbnQgZnNpZDsKPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlmIChpIDwgbnJfbWVyZ2VkX2xvd2VyKQo+ID4gQEAgLTEwNjksNiArMTA3MCwxNiBAQCBz
dGF0aWMgaW50IG92bF9nZXRfbGF5ZXJzKHN0cnVjdCBzdXBlcl9ibG9jawo+ID4gKnNiLCBzdHJ1
Y3Qgb3ZsX2ZzICpvZnMsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1udC0+bW50X2ZsYWdzIHw9IE1OVF9S
RUFET05MWSB8IE1OVF9OT0FUSU1FOwo+ID4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAvKgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIENoZWNrIGlmIHh3
aGl0ZW91dCAoeGF0dHIgd2hpdGVvdXQpIHN1cHBvcnQgaXMKPiA+IGVuYWJsZWQgb24KPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB0aGlzIGxheWVyLgo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcm9vdC5tbnQgPSBtbnQ7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByb290
LmRlbnRyeSA9IG1udC0+bW50X3Jvb3Q7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBlcnIgPSBvdmxfcGF0aF9nZXR4YXR0cihvZnMsICZyb290LAo+ID4gT1ZMX1hBVFRSX1hXSElU
RU9VVFMsIE5VTEwsIDApOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGVy
ciA+PSAwKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGxheWVyc1tvZnMtPm51bWxheWVyXS54d2hpdGVvdXRzID0gdHJ1ZTsKPiA+ICsKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsYXllcnNbb2ZzLT5udW1sYXllcl0udHJhcCA9IHRy
YXA7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGF5ZXJzW29mcy0+bnVtbGF5
ZXJdLm1udCA9IG1udDsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsYXllcnNb
b2ZzLT5udW1sYXllcl0uaWR4ID0gb2ZzLT5udW1sYXllcjsKPiA+IEBAIC0xMDc5LDYgKzEwOTAs
OCBAQCBzdGF0aWMgaW50IG92bF9nZXRfbGF5ZXJzKHN0cnVjdCBzdXBlcl9ibG9jawo+ID4gKnNi
LCBzdHJ1Y3Qgb3ZsX2ZzICpvZnMsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bC0+bmFtZSA9IE5VTEw7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb2ZzLT5u
dW1sYXllcisrOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9mcy0+ZnNbZnNp
ZF0uaXNfbG93ZXIgPSB0cnVlOwo+ID4gKwo+ID4gKwo+IAo+IGV4dHJhIHNwYWNlcy4KPiAKPiA+
IMKgwqDCoMKgwqDCoMKgIH0KPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqAgLyoKPiA+IGRpZmYgLS1n
aXQgYS9mcy9vdmVybGF5ZnMvdXRpbC5jIGIvZnMvb3ZlcmxheWZzL3V0aWwuYwo+ID4gaW5kZXgg
YzNmMDIwY2ExM2E4Li42YzZlNmY1ODkzZWEgMTAwNjQ0Cj4gPiAtLS0gYS9mcy9vdmVybGF5ZnMv
dXRpbC5jCj4gPiArKysgYi9mcy9vdmVybGF5ZnMvdXRpbC5jCj4gPiBAQCAtNzM5LDExICs3Mzks
MTYgQEAgYm9vbCBvdmxfcGF0aF9jaGVja194d2hpdGVvdXRfeGF0dHIoc3RydWN0Cj4gPiBvdmxf
ZnMgKm9mcywgY29uc3Qgc3RydWN0IHBhdGggKnBhdGgpCj4gPiDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gcmVzID49IDA7Cj4gPiDCoH0KPiA+IAo+ID4gLWJvb2wgb3ZsX3BhdGhfY2hlY2tfeHdoaXRl
b3V0c194YXR0cihzdHJ1Y3Qgb3ZsX2ZzICpvZnMsIGNvbnN0Cj4gPiBzdHJ1Y3QgcGF0aCAqcGF0
aCkKPiA+ICtib29sIG92bF9wYXRoX2NoZWNrX3h3aGl0ZW91dHNfeGF0dHIoc3RydWN0IG92bF9m
cyAqb2ZzLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IG92bF9sYXllciAqbGF5ZXIs
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgcGF0aCAqcGF0aCkKPiA+IMKgewo+ID4g
wqDCoMKgwqDCoMKgwqAgc3RydWN0IGRlbnRyeSAqZGVudHJ5ID0gcGF0aC0+ZGVudHJ5Owo+ID4g
wqDCoMKgwqDCoMKgwqAgaW50IHJlczsKPiA+IAo+ID4gK8KgwqDCoMKgwqDCoCBpZiAoIWxheWVy
LT54d2hpdGVvdXRzKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZh
bHNlOwo+ID4gKwo+ID4gwqDCoMKgwqDCoMKgwqAgLyogeGF0dHIud2hpdGVvdXRzIG11c3QgYmUg
YSBkaXJlY3RvcnkgKi8KPiA+IMKgwqDCoMKgwqDCoMKgIGlmICghZF9pc19kaXIoZGVudHJ5KSkK
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7Cj4gPiAtLQo+
ID4gMi40My4wCj4gPiAKPiAKPiBEbyB5b3Ugd2FudCBtZSB0byBmaXgvdGVzdCBhbmQgc2VuZCB0
aGlzIHRvIExpbnVzPwo+IAo+IEFsZXgsIGNhbiB3ZSBhZGQgeW91ciBSVkIgdG8gdjI/Cj4gCgpZ
ZWFoLCBvdGhlciB0aGF0IHlvdXIgY29tbWVudHMgdGhpcyBsb29rcyBnb29kIHRvIG1lIChhbmQg
SSB0ZXN0ZWQgaXQKaGVyZSB0b28pLgoKUmV2aWV3ZWQtQnk6IEFsZXhhbmRlciBMYXJzc29uIDxh
bGV4QHJlZGhhdC5jb20+CgpJJ2xsIGhhdmUgYSBsb29rIGF0IGRvaW5nIHRoZSByZXF1aXJlZCBj
aGFuZ2VzIGluIGNvbXBvc2Vmcy4KCi0tIAo9LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09
LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tPS09LT0tCj0tPS09CiBBbGV4YW5kZXIg
TGFyc3NvbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUmVkIEhh
dCwKSW5jIAogICAgICAgYWxleGxAcmVkaGF0LmNvbSAgICAgICAgICAgIGFsZXhhbmRlci5sYXJz
c29uQGdtYWlsLmNvbSAKSGUncyBhIE5vYmVsIHByaXplLXdpbm5pbmcgdm9vZG9vIG1hdGFkb3Ig
aGF1bnRlZCBieSBtZW1vcmllcyBvZiAnTmFtLiAKU2hlJ3MgYW4gb3JwaGFuZWQgZ3lwc3kgYm9k
eWd1YXJkIG9uIHRoZSB0cmFpbCBvZiBhIHNlcmlhbCBraWxsZXIuIFRoZXkKZmlnaHQgY3JpbWUh
IAo=


