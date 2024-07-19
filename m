Return-Path: <linux-unionfs+bounces-817-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 943B393763A
	for <lists+linux-unionfs@lfdr.de>; Fri, 19 Jul 2024 11:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5014D281960
	for <lists+linux-unionfs@lfdr.de>; Fri, 19 Jul 2024 09:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A9484037;
	Fri, 19 Jul 2024 09:55:57 +0000 (UTC)
X-Original-To: linux-unionfs@vger.kernel.org
Received: from spam.asrmicro.com (asrmicro.com [210.13.118.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E1680639;
	Fri, 19 Jul 2024 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.13.118.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721382957; cv=none; b=RO/Pq3bel1n1tXWjvXuZbUNiDB/7ObEBayrby1LZCofcAeflU9i3eNznuRARhNSi6tkhNav3eg8fs023oTL/o1UU8iSpt0LF0Wi7PuQPnNiTxh99ZDEFn59Ebkym1+kUb/BZ8sIuc+kXra1kP8wxF5jvcHSQicpg1eNWCDrh9RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721382957; c=relaxed/simple;
	bh=01aWOk9YhnCZHZPJXR3JJYypxBQEvqT0rVVt/gay4Ns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V8ojBKY2u+3z5RVQUoZGVXgni35qimAUtW09kXD1V1YylO8054FWdnOaVBy3z+RXHPfR5JNEsFi4wzqvBUaWCfhSJSPH3D6LWdDoS54/Zfami+mWWHeHibIfHYx+L+XfYzJCx45YUyQ+4fHyX8bC69OcASHW9mkrT6n1ym0xbkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com; spf=pass smtp.mailfrom=asrmicro.com; arc=none smtp.client-ip=210.13.118.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asrmicro.com
Received: from mail2012.asrmicro.com (mail2012.asrmicro.com [10.1.24.123])
	by spam.asrmicro.com with ESMTPS id 46J9tUuG082694
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Fri, 19 Jul 2024 17:55:30 +0800 (GMT-8)
	(envelope-from feilv@asrmicro.com)
Received: from exch01.asrmicro.com (10.1.24.121) by mail2012.asrmicro.com
 (10.1.24.123) with Microsoft SMTP Server (TLS) id 15.0.847.32; Fri, 19 Jul
 2024 17:55:26 +0800
Received: from exch01.asrmicro.com ([::1]) by exch01.asrmicro.com ([::1]) with
 mapi id 15.00.0847.030; Fri, 19 Jul 2024 17:55:26 +0800
From: =?utf-8?B?THYgRmVp77yI5ZCV6aOe77yJ?= <feilv@asrmicro.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-unionfs@vger.kernel.org"
	<linux-unionfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        =?utf-8?B?WHUgTGlhbmdode+8iOW+kOiJr+iZju+8iQ==?= <lianghuxu@asrmicro.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIG92bDogZnN5bmMgYWZ0ZXIgbWV0YWRhdGEgY29w?=
 =?utf-8?Q?y-up_via_mount_option_"upsync=3Dstrict"?=
Thread-Topic: [PATCH] ovl: fsync after metadata copy-up via mount option
 "upsync=strict"
Thread-Index: AQHa2MSrkf8wwlFFlUOCkpGQrdrpJbH9IZGAgACv11A=
Date: Fri, 19 Jul 2024 09:55:25 +0000
Message-ID: <062f7b08f6dd4354877c24ea72e6d430@exch01.asrmicro.com>
References: <20240718034316.29844-1-feilv@asrmicro.com>
 <CAOQ4uxgqdOHJOT--sqf-HLtur6uKyk8mh=dkKzmdf8wupCVPhw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgqdOHJOT--sqf-HLtur6uKyk8mh=dkKzmdf8wupCVPhw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:spam.asrmicro.com 46J9tUuG082694

DQo+IA0KPiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogQW1pciBHb2xkc3Rl
aW4gW21haWx0bzphbWlyNzNpbEBnbWFpbC5jb21dIA0KPiDlj5HpgIHml7bpl7Q6IDIwMjTlubQ3
5pyIMTnml6UgMTU6MjQNCj4g5pS25Lu25Lq6OiBMdiBGZWnvvIjlkJXpo57vvIkgPGZlaWx2QGFz
cm1pY3JvLmNvbT4NCj4g5oqE6YCBOiBtaWtsb3NAc3plcmVkaS5odTsgbGludXgtdW5pb25mc0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFh1IExpYW5naHXv
vIjlvpDoia/omY7vvIkgPiA8bGlhbmdodXh1QGFzcm1pY3JvLmNvbT4NCj4g5Li76aKYOiBSZTog
W1BBVENIXSBvdmw6IGZzeW5jIGFmdGVyIG1ldGFkYXRhIGNvcHktdXAgdmlhIG1vdW50IG9wdGlv
biAidXBzeW5jPXN0cmljdCINCj4gDQo+IE9uIFRodSwgSnVsIDE4LCAyMDI0IGF0IDY6NDPigK9B
TSBGZWkgTHYgPGZlaWx2QGFzcm1pY3JvLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBJZiBhIGRpcmVj
dG9yeSBvbmx5IGV4aXN0IGluIGxvdyBsYXllciwgY3JlYXRlIGEgbmV3IGZpbGUgaW4gaXQgDQo+
ID4gdHJpZ2dlciBkaXJlY3RvcnkgY29weS11cC4gUGVybWlzc2lvbiBsb3N0IG9mIHRoZSBuZXcg
ZGlyZWN0b3J5IGluIA0KPiA+IHVwcGVyIGxheWVyIHdhcyBvYnNlcnZlZCBkdXJpbmcgcG93ZXIt
Y3V0IHN0cmVzcyB0ZXN0Lg0KPiANCj4gWW91IHNob3VsZCBzcGVjaWZ5IHRoYXQgdGhpcyBvdXRj
b21lIGhhcHBlbnMgb24gdmVyeSBzcGVjaWZpYyB1cHBlciBmcyAoaS5lLiB1Ymlmcykgd2hpY2gg
ZG9lcyBub3QgZW5mb3JjZSBvcmRlcmluZyBvbiBzdG9yaW5nIG9mIG1ldGFkYXRhIGNoYW5nZXMu
DQoNCk9LLg0KDQo+IA0KPiA+DQo+ID4gRml4IGJ5IGFkZGluZyBuZXcgbW91bnQgb3Bpb24gInVw
c3luYz1zdHJpY3QiLCBtYWtlIHN1cmUgZGF0YS9tZXRhZGF0YSANCj4gPiBvZiBjb3BpZWQgdXAg
ZGlyZWN0b3J5IHdyaXR0ZW4gdG8gZGlzayBiZWZvcmUgcmVuYW1pbmcgZnJvbSB0bXAgdG8gDQo+
ID4gZmluYWwgZGVzdGluYXRpb24uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBGZWkgTHYgPGZl
aWx2QGFzcm1pY3JvLmNvbT4NCj4gPiAtLS0NCj4gPiBPUFRfc3luYyBjaGFuZ2VkIHRvIE9QVF91
cHN5bmMgc2luY2UgbW91bnQgb3B0aW9uICJzeW5jIiBhbHJlYWR5IHVzZWQuDQo+IA0KPiBJIHNl
ZS4gSSBkb24ndCBsaWtlIHRoZSBuYW1lICJ1cHN5bmMiIHNvIG11Y2gsIGl0IGhhcyBvdGhlciBt
ZWFuaW5ncyBob3cgYWJvdXQgdXNpbmcgdGhlIG9wdGlvbiAiZnN5bmMiPw0KDQpPSy4NCg0KPiAN
Cj4gSGVyZSBpcyBhIHN1Z2dlc3RlZCBkb2N1bWVudGF0aW9uICh3aGljaCBzaG91bGQgYmUgYWNj
b21wYW5pZWQgdG8gYW55IHBhdGNoKQ0KDQpPSy4NCg0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZmlsZXN5c3RlbXMvb3ZlcmxheWZzLnJzdA0KPiBiL0RvY3VtZW50YXRpb24vZmls
ZXN5c3RlbXMvb3ZlcmxheWZzLnJzdA0KPiBpbmRleCAxNjU1MTQ0MDE0NDEuLmY4MTgzZGRmOGM0
ZCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9vdmVybGF5ZnMucnN0
DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvb3ZlcmxheWZzLnJzdA0KPiBAQCAt
NzQyLDYgKzc0Miw0MiBAQCBjb250cm9sbGVkIGJ5IHRoZSAidXVpZCIgbW91bnQgb3B0aW9uLCB3
aGljaCBzdXBwb3J0cyB0aGVzZSB2YWx1ZXM6DQo+ICAgICAgbW91bnRlZCB3aXRoICJ1dWlkPW9u
Ii4NCj4gDQo+IA0KPiArRHVyYWJpbGl0eSBhbmQgY29weSB1cA0KPiArLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiArDQo+ICtUaGUgZnN5bmMoMikgYW5kIGZkYXRhc3luYygyKSBzeXN0ZW0gY2Fs
bHMgZW5zdXJlIHRoYXQgdGhlIG1ldGFkYXRhIGFuZCANCj4gK2RhdGEgb2YgYSBmaWxlLCByZXNw
ZWN0aXZlbHksIGFyZSBzYWZlbHkgd3JpdHRlbiB0byB0aGUgYmFja2luZyANCj4gK3N0b3JhZ2Us
IHdoaWNoIGlzIGV4cGVjdGVkIHRvIGd1YXJhbnRlZSB0aGUgZXhpc3RlbmNlIG9mIHRoZSBpbmZv
cm1hdGlvbiBwb3N0IHN5c3RlbSBjcmFzaC4NCj4gKw0KPiArV2l0aG91dCB0aGUgZmRhdGFzeW5j
KDIpIGNhbGwsIHRoZXJlIGlzIG5vIGd1YXJhbnRlZSB0aGF0IHRoZSBvYnNlcnZlZCANCj4gK2Rh
dGEgYWZ0ZXIgYSBzeXN0ZW0gY3Jhc2ggd2lsbCBiZSBlaXRoZXIgdGhlIG9sZCBvciB0aGUgbmV3
IGRhdGEsIGJ1dCANCj4gK2luIHByYWN0aWNlLCB0aGUgb2JzZXJ2ZWQgZGF0YSBhZnRlciBjcmFz
aCBpcyBvZnRlbiB0aGUgb2xkIG9yIG5ldyBkYXRhIG9yIGEgbWl4IG9mIGJvdGguDQo+ICsNCj4g
K1doZW4gb3ZlcmxheWZzIGZpbGUgaXMgbW9kaWZpZWQgZm9yIHRoZSBmaXJzdCB0aW1lLCBjb3B5
IHVwIHdpbGwgY3JlYXRlIA0KPiArYSBjb3B5IG9mIHRoZSBsb3dlciBmaWxlIGFuZCBpdHMgcGFy
ZW50IGRpcmVjdG9yaWVzIGluIHRoZSB1cHBlciBsYXllci4gIA0KPiArSW4gY2FzZSBvZiBhIHN5
c3RlbSBjcmFzaCwgaWYgZmRhdGFzeW5jKDIpIHdhcyBub3QgY2FsbGVkIGFmdGVyIHRoZSANCj4g
K21vZGlmaWNhdGlvbiwgdGhlIHVwcGVyIGZpbGUgY291bGQgZW5kIHVwIHdpdGggbm8gZGF0YSBh
dCBhbGwgKGkuZS4gDQo+ICt6ZXJvcyksIHdoaWNoIHdvdWxkIGJlIGFuIHVudXN1YWwgb3V0Y29t
ZS4gIFRvIGF2b2lkIHRoaXMgZXhwZXJpZW5jZSwgDQo+ICtvdmVybGF5ZnMgY2FsbHMgZnN5bmMo
Mikgb24gdGhlIHVwcGVyIGZpbGUgYmVmb3JlIGNvbXBsZXRpbmcgdGhlIGNvcHkgdXAgd2l0aCBy
ZW5hbWUoMikgdG8gbWFrZSB0aGUgY29weSA+IHVwICJhdG9taWMiLg0KPiArDQo+ICtEZXBlbmRp
bmcgb24gdGhlIGJhY2tpbmcgZmlsZXN5c3RlbSAoZS5nLiB1YmlmcyksIGZzeW5jKDIpIGJlZm9y
ZSANCj4gK3JlbmFtZSgyKSBtYXkgbm90IGJlIGVub3VnaCB0byBwcm92aWRlIHRoZSAiYXRvbWlj
IiBjb3B5IHVwIGJlaGF2aW9yIA0KPiArYW5kIGZzeW5jKDIpIG9uIHRoZSBjb3BpZWQgdXAgcGFy
ZW50IGRpcmVjdG9yaWVzIGlzIHJlcXVpcmVkIGFzIHdlbGwuDQo+ICsNCj4gK092ZXJsYXlmcyBj
YW4gYmUgdHVuZWQgdG8gcHJlZmVyIHBlcmZvcm1hbmNlIG9yIGR1cmFiaWxpdHkgd2hlbiBzdG9y
aW5nIA0KPiArdG8gdGhlIHVuZGVybHlpbmcgdXBwZXIgbGF5ZXIuICBUaGlzIGlzIGNvbnRyb2xs
ZWQgYnkgdGhlICJmc3luYyIgbW91bnQgDQo+ICtvcHRpb24sIHdoaWNoIHN1cHBvcnRzIHRoZXNl
IHZhbHVlczoNCj4gKw0KPiArLSAib3JkZXJlZCI6IChkZWZhdWx0KQ0KPiArICAgIENhbGwgZnN5
bmMoMikgb24gdXBwZXIgZmlsZSBiZWZvcmUgY29tcGxldGlvbiBvZiBjb3B5IHVwLg0KPiArLSAi
c3RyaWN0IjoNCj4gKyAgICBDYWxsIGZzeW5jKDIpIG9uIHVwcGVyIGZpbGUgYW5kIGRpcmVjdG9y
aWVzIGJlZm9yZSBjb21wbGV0aW9uIG9mIGNvcHkgdXAuDQo+ICstICJ2b2xhdGlsZSI6IFsqXQ0K
PiArICAgIFByZWZlciBwZXJmb3JtYW5jZSBvdmVyIGR1cmFiaWxpdHkgKHNlZSBgVm9sYXRpbGUg
bW91bnRgXykNCj4gKw0KPiArWypdIFRoZSBtb3VudCBvcHRpb24gInZvbGF0aWxlIiBpcyBhbiBh
bGlhcyB0byAiZnN5bmM9dm9sYXRpbGUiLg0KPiArDQo+ICsNCj4gIFZvbGF0aWxlIG1vdW50DQo+
ICAtLS0tLS0tLS0tLS0tLQ0KPiANCj4gPg0KPiA+ICBmcy9vdmVybGF5ZnMvY29weV91cC5jICAg
fCAyMSArKysrKysrKysrKysrKysrKysrKysNCj4gPiAgZnMvb3ZlcmxheWZzL292bF9lbnRyeS5o
IHwgMjAgKysrKysrKysrKysrKysrKysrLS0NCj4gPiAgZnMvb3ZlcmxheWZzL3BhcmFtcy5jICAg
IHwgMzMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+ID4gIGZzL292ZXJsYXlm
cy9zdXBlci5jICAgICB8ICAyICstDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgNjkgaW5zZXJ0aW9u
cygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9mcy9vdmVybGF5ZnMv
Y29weV91cC5jIGIvZnMvb3ZlcmxheWZzL2NvcHlfdXAuYyBpbmRleCANCj4gPiBhNWVmMjAwNWEy
Y2MuLmI2ZjAyMWFkN2E0MyAxMDA2NDQNCj4gPiAtLS0gYS9mcy9vdmVybGF5ZnMvY29weV91cC5j
DQo+ID4gKysrIGIvZnMvb3ZlcmxheWZzL2NvcHlfdXAuYw0KPiA+IEBAIC0yNDMsNiArMjQzLDIx
IEBAIHN0YXRpYyBpbnQgb3ZsX3ZlcmlmeV9hcmVhKGxvZmZfdCBwb3MsIGxvZmZfdCBwb3MyLCBs
b2ZmX3QgbGVuLCBsb2ZmX3QgdG90bGVuKQ0KPiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gIH0N
Cj4gPg0KPiA+ICtzdGF0aWMgaW50IG92bF9jb3B5X3VwX3N5bmMoc3RydWN0IHBhdGggKnBhdGgp
IHsNCj4gPiArICAgICAgIHN0cnVjdCBmaWxlICpuZXdfZmlsZTsNCj4gPiArICAgICAgIGludCBl
cnI7DQo+ID4gKw0KPiA+ICsgICAgICAgbmV3X2ZpbGUgPSBvdmxfcGF0aF9vcGVuKHBhdGgsIE9f
TEFSR0VGSUxFIHwgT19XUk9OTFkpOw0KPiANCj4gSSBkb24ndCB0aGluayBhbnkgb2YgdGhvc2Ug
T18gZmxhZ3MgYXJlIG5lZWRlZCBmb3IgZnN5bmMuDQo+IENhbiBhIGRpcmVjdG9yeSBiZSBvcGVu
ZWQgT19XUk9OTFk/Pz8NCg0KVGhpcyBmdW5jdGlvbiBtYXkgYmUgY2FsbGVkIHdpdGggZmlsZSBv
ciBkaXJlY3RvcnksIHNoYWxsIEkgbmVlZCB0byB1c2UgZGlmZmVyZW50DQpmbGFncz8gU3VjaCBh
cyBiZWxvdzoNCg0Kc3RhdGljIGludCBvdmxfY29weV91cF9zeW5jKHN0cnVjdCBwYXRoICpwYXRo
LCBib29sIGlzX2RpcikNCnsNCglzdHJ1Y3QgZmlsZSAqbmV3X2ZpbGU7DQoJaW50IGZsYWdzOw0K
ICAgICAgICBpbnQgZXJyOw0KDQogICAgICAgIGZsYWdzID0gaXNfZGlyID8gKE9fUkRPTkxZIHwg
T19ESVJFQ1RPUlkpIDogKE9fTEFSR0VGSUxFIHwgT19XUk9OTFkpOw0KCW5ld19maWxlID0gb3Zs
X3BhdGhfb3BlbihwYXRoLCBmbGFncyk7DQoJaWYgKElTX0VSUihuZXdfZmlsZSkpDQoJCXJldHVy
biBQVFJfRVJSKG5ld19maWxlKTsNCg0KCWVyciA9IHZmc19mc3luYyhuZXdfZmlsZSwgMCk7DQoJ
ZnB1dChuZXdfZmlsZSk7DQoNCglyZXR1cm4gZXJyOw0KfQ0KDQo+IA0KPiA+ICsgICAgICAgaWYg
KElTX0VSUihuZXdfZmlsZSkpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKG5l
d19maWxlKTsNCj4gPiArDQo+ID4gKyAgICAgICBlcnIgPSB2ZnNfZnN5bmMobmV3X2ZpbGUsIDAp
Ow0KPiA+ICsgICAgICAgZnB1dChuZXdfZmlsZSk7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJu
IGVycjsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBvdmxfY29weV91cF9maWxlKHN0
cnVjdCBvdmxfZnMgKm9mcywgc3RydWN0IGRlbnRyeSAqZGVudHJ5LA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzdHJ1Y3QgZmlsZSAqbmV3X2ZpbGUsIGxvZmZfdCBsZW4pICB7IEBA
IA0KPiA+IC03MDEsNiArNzE2LDkgQEAgc3RhdGljIGludCBvdmxfY29weV91cF9tZXRhZGF0YShz
dHJ1Y3Qgb3ZsX2NvcHlfdXBfY3R4ICpjLCBzdHJ1Y3QgZGVudHJ5ICp0ZW1wKQ0KPiA+ICAgICAg
ICAgICAgICAgICBlcnIgPSBvdmxfc2V0X2F0dHIob2ZzLCB0ZW1wLCAmYy0+c3RhdCk7DQo+ID4g
ICAgICAgICBpbm9kZV91bmxvY2sodGVtcC0+ZF9pbm9kZSk7DQo+ID4NCj4gPiArICAgICAgIGlm
ICghZXJyICYmIG92bF9zaG91bGRfc3luY19zdHJpY3Qob2ZzKSkNCj4gPiArICAgICAgICAgICAg
ICAgZXJyID0gb3ZsX2NvcHlfdXBfc3luYygmdXBwZXJwYXRoKTsNCj4gPiArDQo+ID4gICAgICAg
ICByZXR1cm4gZXJyOw0KPiA+ICB9DQo+ID4NCj4gPiBAQCAtMTEwNCw2ICsxMTIyLDkgQEAgc3Rh
dGljIGludCBvdmxfY29weV91cF9tZXRhX2lub2RlX2RhdGEoc3RydWN0IG92bF9jb3B5X3VwX2N0
eCAqYykNCj4gPiAgICAgICAgIG92bF9jbGVhcl9mbGFnKE9WTF9IQVNfRElHRVNULCBkX2lub2Rl
KGMtPmRlbnRyeSkpOw0KPiA+ICAgICAgICAgb3ZsX2NsZWFyX2ZsYWcoT1ZMX1ZFUklGSUVEX0RJ
R0VTVCwgZF9pbm9kZShjLT5kZW50cnkpKTsNCj4gPiAgICAgICAgIG92bF9zZXRfdXBwZXJkYXRh
KGRfaW5vZGUoYy0+ZGVudHJ5KSk7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKCFlcnIgJiYgb3Zs
X3Nob3VsZF9zeW5jX3N0cmljdChvZnMpKQ0KPiA+ICsgICAgICAgICAgICAgICBlcnIgPSBvdmxf
Y29weV91cF9zeW5jKCZ1cHBlcnBhdGgpOw0KPiANCj4gZnN5bmMgd2FzIHByb2JhYmx5IGFscmVh
ZHkgY2FsbGVkIGluIG92bF9jb3B5X3VwX2ZpbGUoKSBtYWtpbmcgdGhpcyBjYWxsIHJlZHVuZGFu
dCBhbmQgZnN5bmMgb2YgdGhlIHJlbW92YWwgPiBvZiBtZXRhY29weSB4YXR0ciBkb2VzIG5vdCBh
ZGQgYW55IHNhZmV0eS4NCg0KTXkgb3JpZ2luYWwgaWRlYSB3YXMgdGhhdCBvdmxfc2hvdWxkX3N5
bmMgYW5kIG92bF9zaG91bGRfc3luY19zdHJpY3Qgc2hvdWxkIG5vdCBiZSBlbmFibGVkIGF0IHRo
ZSBzYW1lIHRpbWUuIFRoZSByZWFzb25zIGFyZSBhcyBmb2xsb3dzOg0KSWYgYm90aGUgb3ZsX3No
b3VsZF9zeW5jIGFuZCBvdmxfc2hvdWxkX3N5bmNfc3RyaWN0IHJldHVybiB0dXJlIGZvciAiZnN5
bmM9c3RyaWN0IiwNCmFuZCBwb3dlciBjdXQgYmV0d2VlbiBvdmxfY29weV91cF9maWxlIGFuZCBv
dmxfY29weV91cF9tZXRhZGF0YSBmb3IgZmlsZSBjb3B5LXVwLA0Kc2VlbXMgdGhpcyBmaWxlIG1h
eSBhbHNvIGxvc3QgcGVybWlzc2lvbj8gDQoNCj4gDQo+ID4gIG91dF9mcmVlOg0KPiA+ICAgICAg
ICAga2ZyZWUoY2FwYWJpbGl0eSk7DQo+ID4gIG91dDoNCj4gPiBkaWZmIC0tZ2l0IGEvZnMvb3Zl
cmxheWZzL292bF9lbnRyeS5oIGIvZnMvb3ZlcmxheWZzL292bF9lbnRyeS5oIGluZGV4IA0KPiA+
IGNiNDQ5YWIzMTBhNy4uNDU5MmU2ZjdkY2Y3IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL292ZXJsYXlm
cy9vdmxfZW50cnkuaA0KPiA+ICsrKyBiL2ZzL292ZXJsYXlmcy9vdmxfZW50cnkuaA0KPiA+IEBA
IC01LDYgKzUsMTIgQEANCj4gPiAgICogQ29weXJpZ2h0IChDKSAyMDE2IFJlZCBIYXQsIEluYy4N
Cj4gPiAgICovDQo+ID4NCj4gPiArZW51bSB7DQo+ID4gKyAgICAgICBPVkxfU1lOQ19EQVRBLA0K
PiA+ICsgICAgICAgT1ZMX1NZTkNfU1RSSUNULA0KPiA+ICsgICAgICAgT1ZMX1NZTkNfT0ZGLA0K
PiA+ICt9Ow0KPiA+ICsNCj4gPiAgc3RydWN0IG92bF9jb25maWcgew0KPiA+ICAgICAgICAgY2hh
ciAqdXBwZXJkaXI7DQo+ID4gICAgICAgICBjaGFyICp3b3JrZGlyOw0KPiA+IEBAIC0xOCw3ICsy
NCw3IEBAIHN0cnVjdCBvdmxfY29uZmlnIHsNCj4gPiAgICAgICAgIGludCB4aW5vOw0KPiA+ICAg
ICAgICAgYm9vbCBtZXRhY29weTsNCj4gPiAgICAgICAgIGJvb2wgdXNlcnhhdHRyOw0KPiA+IC0g
ICAgICAgYm9vbCBvdmxfdm9sYXRpbGU7DQo+ID4gKyAgICAgICBpbnQgc3luY19tb2RlOw0KPiA+
ICB9Ow0KPiA+DQo+ID4gIHN0cnVjdCBvdmxfc2Igew0KPiA+IEBAIC0xMjAsNyArMTI2LDE3IEBA
IHN0YXRpYyBpbmxpbmUgc3RydWN0IG92bF9mcyAqT1ZMX0ZTKHN0cnVjdCANCj4gPiBzdXBlcl9i
bG9jayAqc2IpDQo+ID4NCj4gPiAgc3RhdGljIGlubGluZSBib29sIG92bF9zaG91bGRfc3luYyhz
dHJ1Y3Qgb3ZsX2ZzICpvZnMpICB7DQo+ID4gLSAgICAgICByZXR1cm4gIW9mcy0+Y29uZmlnLm92
bF92b2xhdGlsZTsNCj4gPiArICAgICAgIHJldHVybiBvZnMtPmNvbmZpZy5zeW5jX21vZGUgPT0g
T1ZMX1NZTkNfREFUQTsNCj4gDQo+ICAgICByZXR1cm4gb2ZzLT5jb25maWcuc3luY19tb2RlICE9
IE9WTF9TWU5DX09GRjsgb3INCj4gICAgIHJldHVybiBvZnMtPmNvbmZpZy5zeW5jX21vZGUgIT0g
T1ZMX0ZTWU5DX1ZPTEFUSUxFOw0KDQpUaGVyZSBhcmUgcmlza3MgaWYgb3ZsX3Nob3VsZF9zeW5j
IGFuZCBvdmxfc2hvdWxkX3N5bmNfc3RyaWN0IGVuYWJsZWQgYXQgdGhlIHNhbWUgdGltZS4NClRo
ZSByZWFzb25zIGFyZSBhYm92ZS4NCg0KPiANCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGlu
bGluZSBib29sIG92bF9zaG91bGRfc3luY19zdHJpY3Qoc3RydWN0IG92bF9mcyAqb2ZzKSB7DQo+
ID4gKyAgICAgICByZXR1cm4gb2ZzLT5jb25maWcuc3luY19tb2RlID09IE9WTF9TWU5DX1NUUklD
VDsgfQ0KPiA+ICsNCj4gPiArc3RhdGljIGlubGluZSBib29sIG92bF9pc192b2xhdGlsZShzdHJ1
Y3Qgb3ZsX2NvbmZpZyAqY29uZmlnKSB7DQo+ID4gKyAgICAgICByZXR1cm4gY29uZmlnLT5zeW5j
X21vZGUgPT0gT1ZMX1NZTkNfT0ZGOw0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGlubGluZSB1
bnNpZ25lZCBpbnQgb3ZsX251bWxvd2VyKHN0cnVjdCBvdmxfZW50cnkgKm9lKSBkaWZmIA0KPiA+
IC0tZ2l0IGEvZnMvb3ZlcmxheWZzL3BhcmFtcy5jIGIvZnMvb3ZlcmxheWZzL3BhcmFtcy5jIGlu
ZGV4IA0KPiA+IDQ4NjBmY2M0NjExYi4uNWQ1NTM4ZGQzZGU3IDEwMDY0NA0KPiA+IC0tLSBhL2Zz
L292ZXJsYXlmcy9wYXJhbXMuYw0KPiA+ICsrKyBiL2ZzL292ZXJsYXlmcy9wYXJhbXMuYw0KPiA+
IEBAIC01OCw2ICs1OCw3IEBAIGVudW0gb3ZsX29wdCB7DQo+ID4gICAgICAgICBPcHRfeGlubywN
Cj4gPiAgICAgICAgIE9wdF9tZXRhY29weSwNCj4gPiAgICAgICAgIE9wdF92ZXJpdHksDQo+ID4g
KyAgICAgICBPcHRfdXBzeW5jLA0KPiA+ICAgICAgICAgT3B0X3ZvbGF0aWxlLA0KPiA+ICB9Ow0K
PiA+DQo+ID4gQEAgLTEzOSw2ICsxNDAsMjMgQEAgc3RhdGljIGludCBvdmxfdmVyaXR5X21vZGVf
ZGVmKHZvaWQpDQo+ID4gICAgICAgICByZXR1cm4gT1ZMX1ZFUklUWV9PRkY7DQo+ID4gIH0NCj4g
Pg0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGNvbnN0YW50X3RhYmxlIG92bF9wYXJhbWV0ZXJf
dXBzeW5jW10gPSB7DQo+ID4gKyAgICAgICB7ICJkYXRhIiwgICAgICAgT1ZMX1NZTkNfREFUQSAg
ICAgIH0sDQo+ID4gKyAgICAgICB7ICJzdHJpY3QiLCAgICAgT1ZMX1NZTkNfU1RSSUNUICAgIH0s
DQo+ID4gKyAgICAgICB7ICJvZmYiLCAgICAgICAgT1ZMX1NZTkNfT0ZGICAgICAgIH0sDQo+ID4g
KyAgICAgICB7fQ0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IGNoYXIgKm92bF91
cHN5bmNfbW9kZShzdHJ1Y3Qgb3ZsX2NvbmZpZyAqY29uZmlnKSB7DQo+ID4gKyAgICAgICByZXR1
cm4gb3ZsX3BhcmFtZXRlcl91cHN5bmNbY29uZmlnLT5zeW5jX21vZGVdLm5hbWU7DQo+ID4gK30N
Cj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgb3ZsX3Vwc3luY19tb2RlX2RlZih2b2lkKQ0KPiA+ICt7
DQo+ID4gKyAgICAgICByZXR1cm4gT1ZMX1NZTkNfREFUQTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAg
Y29uc3Qgc3RydWN0IGZzX3BhcmFtZXRlcl9zcGVjIG92bF9wYXJhbWV0ZXJfc3BlY1tdID0gew0K
PiA+ICAgICAgICAgZnNwYXJhbV9zdHJpbmdfZW1wdHkoImxvd2VyZGlyIiwgICAgT3B0X2xvd2Vy
ZGlyKSwNCj4gPiAgICAgICAgIGZzcGFyYW1fc3RyaW5nKCJsb3dlcmRpcisiLCAgICAgICAgIE9w
dF9sb3dlcmRpcl9hZGQpLA0KPiA+IEBAIC0xNTQsNiArMTcyLDcgQEAgY29uc3Qgc3RydWN0IGZz
X3BhcmFtZXRlcl9zcGVjIG92bF9wYXJhbWV0ZXJfc3BlY1tdID0gew0KPiA+ICAgICAgICAgZnNw
YXJhbV9lbnVtKCJ4aW5vIiwgICAgICAgICAgICAgICAgT3B0X3hpbm8sIG92bF9wYXJhbWV0ZXJf
eGlubyksDQo+ID4gICAgICAgICBmc3BhcmFtX2VudW0oIm1ldGFjb3B5IiwgICAgICAgICAgICBP
cHRfbWV0YWNvcHksIG92bF9wYXJhbWV0ZXJfYm9vbCksDQo+ID4gICAgICAgICBmc3BhcmFtX2Vu
dW0oInZlcml0eSIsICAgICAgICAgICAgICBPcHRfdmVyaXR5LCBvdmxfcGFyYW1ldGVyX3Zlcml0
eSksDQo+ID4gKyAgICAgICBmc3BhcmFtX2VudW0oInVwc3luYyIsICAgICAgICAgICAgICBPcHRf
dXBzeW5jLCBvdmxfcGFyYW1ldGVyX3Vwc3luYyksDQo+ID4gICAgICAgICBmc3BhcmFtX2ZsYWco
InZvbGF0aWxlIiwgICAgICAgICAgICBPcHRfdm9sYXRpbGUpLA0KPiA+ICAgICAgICAge30NCj4g
PiAgfTsNCj4gPiBAQCAtNjE3LDggKzYzNiwxMSBAQCBzdGF0aWMgaW50IG92bF9wYXJzZV9wYXJh
bShzdHJ1Y3QgZnNfY29udGV4dCAqZmMsIHN0cnVjdCBmc19wYXJhbWV0ZXIgKnBhcmFtKQ0KPiA+
ICAgICAgICAgY2FzZSBPcHRfdmVyaXR5Og0KPiA+ICAgICAgICAgICAgICAgICBjb25maWctPnZl
cml0eV9tb2RlID0gcmVzdWx0LnVpbnRfMzI7DQo+ID4gICAgICAgICAgICAgICAgIGJyZWFrOw0K
PiA+ICsgICAgICAgY2FzZSBPcHRfdXBzeW5jOg0KPiA+ICsgICAgICAgICAgICAgICBjb25maWct
PnN5bmNfbW9kZSA9IHJlc3VsdC51aW50XzMyOw0KPiA+ICsgICAgICAgICAgICAgICBicmVhazsN
Cj4gPiAgICAgICAgIGNhc2UgT3B0X3ZvbGF0aWxlOg0KPiA+IC0gICAgICAgICAgICAgICBjb25m
aWctPm92bF92b2xhdGlsZSA9IHRydWU7DQo+ID4gKyAgICAgICAgICAgICAgIGNvbmZpZy0+c3lu
Y19tb2RlID0gT1ZMX1NZTkNfT0ZGOw0KPiA+ICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiAg
ICAgICAgIGNhc2UgT3B0X3VzZXJ4YXR0cjoNCj4gPiAgICAgICAgICAgICAgICAgY29uZmlnLT51
c2VyeGF0dHIgPSB0cnVlOyBAQCAtODAyLDkgKzgyNCw5IEBAIGludCANCj4gPiBvdmxfZnNfcGFy
YW1zX3ZlcmlmeShjb25zdCBzdHJ1Y3Qgb3ZsX2ZzX2NvbnRleHQgKmN0eCwNCj4gPiAgICAgICAg
ICAgICAgICAgY29uZmlnLT5pbmRleCA9IGZhbHNlOw0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4g
LSAgICAgICBpZiAoIWNvbmZpZy0+dXBwZXJkaXIgJiYgY29uZmlnLT5vdmxfdm9sYXRpbGUpIHsN
Cj4gPiArICAgICAgIGlmICghY29uZmlnLT51cHBlcmRpciAmJiBvdmxfaXNfdm9sYXRpbGUoY29u
ZmlnKSkgew0KPiA+ICAgICAgICAgICAgICAgICBwcl9pbmZvKCJvcHRpb24gXCJ2b2xhdGlsZVwi
IGlzIG1lYW5pbmdsZXNzIGluIGEgDQo+ID4gbm9uLXVwcGVyIG1vdW50LCBpZ25vcmluZyBpdC5c
biIpOw0KPiANCj4gVGhpcyBtZXNzYWdlIHdvdWxkIGJlIGNvbmZ1c2luZyBpZiBtb3VudCBvcHRp
b24gaXMgInN5bmN1cD1vZmYiDQo+IGJ1dCBpZiB0aGUgb3B0aW9uIGlzICJmc3luYz12b2xhdGls
ZSIgSSB0aGluayB0aGUgbWVzc2FnZSBjYW4gc3RheSBhcyBpdCBpcy4NCj4gDQo+IFRoYW5rcywN
Cj4gQW1pci4NCg0KWWVzLiBUaGF0IHNvdW5kcyBnb29kISANCldlIHRob3VnaHQgdGhpcyBwbGFj
ZSB3YXMgYSBsaXR0bGUgd2VpcmQsIHRvby4uLg0KDQo+IA0KPiA+IC0gICAgICAgICAgICAgICBj
b25maWctPm92bF92b2xhdGlsZSA9IGZhbHNlOw0KPiA+ICsgICAgICAgICAgICAgICBjb25maWct
PnN5bmNfbW9kZSA9IG92bF91cHN5bmNfbW9kZV9kZWYoKTsNCj4gPiAgICAgICAgIH0NCj4gPg0K
PiA+ICAgICAgICAgaWYgKCFjb25maWctPnVwcGVyZGlyICYmIGNvbmZpZy0+dXVpZCA9PSBPVkxf
VVVJRF9PTikgeyBAQCANCj4gPiAtOTk3LDggKzEwMTksMTEgQEAgaW50IG92bF9zaG93X29wdGlv
bnMoc3RydWN0IHNlcV9maWxlICptLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpDQo+ID4gICAgICAg
ICBpZiAob2ZzLT5jb25maWcubWV0YWNvcHkgIT0gb3ZsX21ldGFjb3B5X2RlZikNCj4gPiAgICAg
ICAgICAgICAgICAgc2VxX3ByaW50ZihtLCAiLG1ldGFjb3B5PSVzIiwNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBvZnMtPmNvbmZpZy5tZXRhY29weSA/ICJvbiIgOiAib2ZmIik7DQo+
ID4gLSAgICAgICBpZiAob2ZzLT5jb25maWcub3ZsX3ZvbGF0aWxlKQ0KPiA+ICsgICAgICAgaWYg
KG92bF9pc192b2xhdGlsZSgmb2ZzLT5jb25maWcpKQ0KPiA+ICAgICAgICAgICAgICAgICBzZXFf
cHV0cyhtLCAiLHZvbGF0aWxlIik7DQo+ID4gKyAgICAgICBlbHNlIGlmIChvZnMtPmNvbmZpZy5z
eW5jX21vZGUgIT0gb3ZsX3Vwc3luY19tb2RlX2RlZigpKQ0KPiA+ICsgICAgICAgICAgICAgICBz
ZXFfcHJpbnRmKG0sICIsdXBzeW5jPSVzIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICBvdmxfdXBzeW5jX21vZGUoJm9mcy0+Y29uZmlnKSk7DQo+ID4gICAgICAgICBpZiAob2ZzLT5j
b25maWcudXNlcnhhdHRyKQ0KPiA+ICAgICAgICAgICAgICAgICBzZXFfcHV0cyhtLCAiLHVzZXJ4
YXR0ciIpOw0KPiA+ICAgICAgICAgaWYgKG9mcy0+Y29uZmlnLnZlcml0eV9tb2RlICE9IG92bF92
ZXJpdHlfbW9kZV9kZWYoKSkgZGlmZiANCj4gPiAtLWdpdCBhL2ZzL292ZXJsYXlmcy9zdXBlci5j
IGIvZnMvb3ZlcmxheWZzL3N1cGVyLmMgaW5kZXggDQo+ID4gMDZhMjMxOTcwY2I1Li44MjRjYmNm
NDA1MjMgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvb3ZlcmxheWZzL3N1cGVyLmMNCj4gPiArKysgYi9m
cy9vdmVybGF5ZnMvc3VwZXIuYw0KPiA+IEBAIC03NTAsNyArNzUwLDcgQEAgc3RhdGljIGludCBv
dmxfbWFrZV93b3JrZGlyKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBvdmxfZnMgKm9m
cywNCj4gPiAgICAgICAgICAqIEZvciB2b2xhdGlsZSBtb3VudCwgY3JlYXRlIGEgaW5jb21wYXQv
dm9sYXRpbGUvZGlydHkgZmlsZSB0byBrZWVwDQo+ID4gICAgICAgICAgKiB0cmFjayBvZiBpdC4N
Cj4gPiAgICAgICAgICAqLw0KPiA+IC0gICAgICAgaWYgKG9mcy0+Y29uZmlnLm92bF92b2xhdGls
ZSkgew0KPiA+ICsgICAgICAgaWYgKG92bF9pc192b2xhdGlsZSgmb2ZzLT5jb25maWcpKSB7DQo+
ID4gICAgICAgICAgICAgICAgIGVyciA9IG92bF9jcmVhdGVfdm9sYXRpbGVfZGlydHkob2ZzKTsN
Cj4gPiAgICAgICAgICAgICAgICAgaWYgKGVyciA8IDApIHsNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICBwcl9lcnIoIkZhaWxlZCB0byBjcmVhdGUgdm9sYXRpbGUvZGlydHkgDQo+ID4gZmls
ZS5cbiIpOw0KPiA+DQo+ID4gYmFzZS1jb21taXQ6IDBjMzgzNjQ4MjQ4MTIwMGVhZDdiNDE2Y2E4
MGM2OGEyOWNmZGFhYmQNCj4gPiAtLQ0KPiA+IDIuNDUuMg0KPiA+DQoNClRoYW5rcywNCkZlaQ0K

