Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDF152E3D4
	for <lists+linux-unionfs@lfdr.de>; Fri, 20 May 2022 06:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242517AbiETEeR (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 20 May 2022 00:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239676AbiETEeQ (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 20 May 2022 00:34:16 -0400
X-Greylist: delayed 856 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 May 2022 21:34:13 PDT
Received: from CN01-BJB-obe.outbound.protection.partner.outlook.cn (mail-bjbhn0100.outbound.protection.partner.outlook.cn [42.159.36.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CA559BBB;
        Thu, 19 May 2022 21:34:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JI+bH7JSEPe63a0ufZQe6Uh9ti30CYZ+hGWhBBMOIYbLxSLtg1nmJWY9V57t+TMbDXd1CI7D2VPJOZt3cHnf3T9XflYJcQZCUcOkNUAxoyfpB+6QjaKmp8W9qolyQNIiboFyvSBGnU/vUx51IaaBG9AbCeuCQpnvlWvPs3qi7zp+f4bC7CrflI7Ujw3QFYEYZxjyl6eM22IVuuXPw08+tQc7supWGK0wxd3MCPiU6FQODQKYE3OM07RaXsp/q2dJpfYuJ/hutvq29C500ECaf7cWw8FvD7OHtCAQk9qjDwqwagrTMgR8mVfsEgkhA3vH2KV9xg1JWPWZgm1BCIcG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHa7Vpxtm/u3S4otqoZTmpXUuVJNGmaT4A6UJUMDuKo=;
 b=IEvfOjrIktHVaamCUzHdCl9/zcAcAn6N/0OiqL7lqSQR6aiOyAnt6G4lmbdOltyd6sz4SX/9YWucGUQkTjiZV2pEaDXtVdC5LnEBCuEac4H5z+6GTjg0IjwEqF2glibVb1lm5H/ubXY/iSJdcUBpEGO++TspTr21Qi/WVRpaZ/SYc3or+jDqvXtvsdZlgP5uPgmuyWiyuIIL4qNywODqE8kE2WBum+BO/Ymfq7NCD/sdkWKkysSVWeytCSBtzIbqeihbVQxrYWwHvQ+1FnMAKvTgESNP0xU/jFGiGzJYRLt7iGeC9QcqCL3DVMlTtzkDc4D8/7boVZfPu8Mf+xJVZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gientech.com; dmarc=pass action=none header.from=gientech.com;
 dkim=pass header.d=gientech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gientech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHa7Vpxtm/u3S4otqoZTmpXUuVJNGmaT4A6UJUMDuKo=;
 b=LWUiuZhuFO/ab7LpdcZEiKDGDWY50+xvO0R82C4AweoFRIgKFTSxMp+cV1DOkPf13p5RMGwg8Ul9HUmbovHgSf+5puGz/pN/8A2t52c4+Xhol7cPXn6c2qyoE4ov48Ph/LNEBh9HvX2eiEBxGsp+tYDyR2bfIkikNPVXeQZxfQfcVBGP68XXOW4Aw+ogxSIylm1WO0VVAq7L/wt0GX0dlRDoYJ8XJZLonVr0IRMnf1fr9WYccQWADOWMZAvtC6zJgP3AuSSpqwviCLm+aqgAhvxHyVH2dvpEYjd6jMA1QtbO3PTMimj5yXBY7bvVZoU4PT+HACEzPT+bm+DWNlSu3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gientech.com;
Received: from SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn (10.43.110.19) by
 SHXPR01MB0591.CHNPR01.prod.partner.outlook.cn (10.43.109.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Fri, 20 May 2022 04:19:53 +0000
Received: from SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn ([10.43.110.19])
 by SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn ([10.43.110.19]) with mapi
 id 15.20.5273.017; Fri, 20 May 2022 04:19:53 +0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Ree
To:     Recipients <cuidong.liu@gientech.com>
From:   "J Wu" <cuidong.liu@gientech.com>
Date:   Wed, 18 May 2022 21:19:17 +0000
Reply-To: contact@jimmywu.online
X-ClientProxiedBy: BJSPR01CA0014.CHNPR01.prod.partner.outlook.cn
 (10.43.34.154) To SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
 (10.43.110.19)
Message-ID: <SHXPR01MB0623D932EAA327E1D46275A289D19@SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a216847a-0b26-495f-970d-08da39141f66
X-MS-TrafficTypeDiagnostic: SHXPR01MB0591:EE_
X-Microsoft-Antispam-PRVS: <SHXPR01MB0591204E54D6D40D0A000A1C89D39@SHXPR01MB0591.CHNPR01.prod.partner.outlook.cn>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Sq6OYOtmcB9fCvS3Jvu8eTA4SttQ+QHkLKtYhGE7E2i7sR63wqb70uG2wu?=
 =?iso-8859-1?Q?5Bxc+FgY56nqIh1Bkn0geK5SsnL32NPFPMvDCM1BwedeqR8MvVEO7PL42t?=
 =?iso-8859-1?Q?mPQ/hDLcBO4wjbEPnPS/pocvJVJxCBYJvKx/QAyffVnamnKtO+VoZgRQjv?=
 =?iso-8859-1?Q?5Fg/2r4+z1TTTPHydQOxNGoYYIuAPeVa6+shyFwj9d9kcvl3IVHv9gYP3U?=
 =?iso-8859-1?Q?g5bW3P+bEvgPM1NJvz+mVBNna525ncZpZFhN6M/ej/BAfoD/x4rj+QdWEs?=
 =?iso-8859-1?Q?fQ/vgafr8Y5HYeWTofgHIsPPW/94B9ATZP2jn4GmPHZtnUMXB09B5Enx1D?=
 =?iso-8859-1?Q?rhYIrQYoD/12/P/yn2wEDoEypTV2dmQME14ISokFY30iu6YhLcweBUwHlH?=
 =?iso-8859-1?Q?j8tGwph6xgKNiYKZCZhKqTUgRYh1GHIAOHmxDBRd+DslDIshCpbp/C1vQb?=
 =?iso-8859-1?Q?8IAK1gp7erTbkVJKLsVm0y0rlnGKcHZk+vAYhfe9HL5Fr6RCL5q9og8hzO?=
 =?iso-8859-1?Q?t0M0ldn2dZ82EMceC+ivJNO2wEAe3WBgkFP8xcJS+Q/FWbRRPXzWYVrI5F?=
 =?iso-8859-1?Q?Ap/8jwS16k61SvBYV6w9CKl9ZT/ew4K793n1tS2SmSiTIz4IEa00N2Mk8e?=
 =?iso-8859-1?Q?ygWj5JmfVZNcrl0QecW1SUZt8DV3BXx9VbGia3w7a5QxvLNzdFLnsCx9w2?=
 =?iso-8859-1?Q?TFOU80N+6k6sNvNvcMJlLkAuSigf8ILINeE8Ccy1o6opYaHqBatvV6BYV3?=
 =?iso-8859-1?Q?DLdoWKediH5qiAHeKUfIINml6yCvch7PyUXm1k4CWg4hIZLDGVwWbcLpET?=
 =?iso-8859-1?Q?8xWgUGY/lo+eC6x2oWMUrolPTVKTzfvDa+1tCcufNjxOKhCzEb+sGfSpFx?=
 =?iso-8859-1?Q?3gQjedKeUqIKPSNnnhGtwzNJypGOq7o7XRi/q5+f2eawXAWCwiRZZLdJnc?=
 =?iso-8859-1?Q?owLMeWXgUaWySitqpEFcP5VPwIz4NyE2NML8ODFFtWTj0EQc9GyGjby6Tn?=
 =?iso-8859-1?Q?QUI8HHBSaaiAmz9a3C+Ksz05PLMaPrGrfwSLcgZWRWLbD57bdY+C+mxLGZ?=
 =?iso-8859-1?Q?Ng=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:OSPM;SFS:(13230001)(366004)(8936002)(19618925003)(8676002)(6862004)(66946007)(558084003)(3480700007)(186003)(9686003)(4270600006)(7116003)(2906002)(6666004)(33656002)(40160700002)(7366002)(7406005)(7696005)(7416002)(66556008)(66476007)(38350700002)(508600001)(55016003)(38100700002)(86362001)(26005)(6200100001)(40180700001)(52116002)(62346012);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bCp9D4ddJVDwMwRZi/CmNBOGaYIG4rzgztThfGj9DwPa63a0QEDxkVd0Mm?=
 =?iso-8859-1?Q?sBVLLQUgbIIaUsGPAhNo0ezk0yEFWjOYKTVLk1oApvq0mgiXwM0rB9eimX?=
 =?iso-8859-1?Q?VAK54SR9YoXTbc/4Gl4gXRU0Uf0Q+xqZiBpnC7v9Z/EqdcpV4uFXpTxXjW?=
 =?iso-8859-1?Q?uIM/xkA5lFjQ+WzpufANs2+LcPYygnX3tn0VJ0lCD6lAGirF6nYMh2a5F5?=
 =?iso-8859-1?Q?r6V0FV1fXgPNnG5YNAXqpWru6YUhz/HaPUvS8QqRJ0i/ABcK/mtLHTH0it?=
 =?iso-8859-1?Q?/38ilyFy36qwrGoOBYwwJ/I584EpUM8394bAgSM3r24OUZmfYMTBAii9+C?=
 =?iso-8859-1?Q?Dl1h3B/cTZtPGberEYSLR/R+zzSFMn0CCBh5PlHktMOpsQ1Bx87V6xgMit?=
 =?iso-8859-1?Q?AKJCjYlX20EsIcuqNrZqomDr+JcIq5zXqjOHZRHfJPXzD//qMydDbEL2f/?=
 =?iso-8859-1?Q?yQ4KDWLcArl8aGTMbjRCP/ZSqTN68MkFnmH8GuTzWyphLbQRDZ4MZjNcUP?=
 =?iso-8859-1?Q?mfWh8bFFDZeaiMkOBkq3l4Vyd8J8zHcq9vk+cMRGfVx/ZSkUzGi/izjIJ1?=
 =?iso-8859-1?Q?wCIaqX6tmSlk6PmjGL9Gvt2jB02IaGydd2mGPJaoqsitDwl3USs6t1+ile?=
 =?iso-8859-1?Q?wdNKd35iVOFcPlVSX9Zn360byDY0kAvFSTAarG+dC7KuAKzg1zs75AtadZ?=
 =?iso-8859-1?Q?ouI1+d0bb+pVEC0RTaMVfv4zQ6I2/yrk3b5ne46I7NIwD2f+02KH6z8++Z?=
 =?iso-8859-1?Q?JYla9SnJdZXJnun076HO7xJkHExaslOHoTmHC0u3Vd24E10WE3g2uoCBRa?=
 =?iso-8859-1?Q?Y4gStEVIKpV+VTDOuX+Ibx+Mz8t4YIDYBXyHpJLp9BXSwN+1aL+YHjSjI1?=
 =?iso-8859-1?Q?dezTjzWgogZdh1XfPswqV/+fScg7BXCOco9xRI0dvgbANvhn8BQ7me5zD9?=
 =?iso-8859-1?Q?GBaxKA7dWkDNPwMrA5jU4Vp/ohrzyoDHgjJ6rpsFwJi0oqVdveKsbfPvrP?=
 =?iso-8859-1?Q?38PVQuEPn4qRmUAsoKa1Zl8xENI7id3zk2QK9RwfOub09QSJuiWZTXnRKK?=
 =?iso-8859-1?Q?LC+zSLxXh9fKVgLgdTcqX9Q5k0Q5dvP49gdBTHfZ6ZW/qlWvgnMk8JBHI7?=
 =?iso-8859-1?Q?SLm+3+017mwTNSvh/ziIXAdEFjj37yH5QXVM31bW6jAYSZPoozeY9vryya?=
 =?iso-8859-1?Q?I8IRkMAlzQP04NInPJv+Wz+mVjl/2xl5IQkF9GgMt/8EsROQ1PgfbehPKR?=
 =?iso-8859-1?Q?57nE949UxXR6n/54DPnviC1IVN4VqyawvKpP0AbTq4hHvdAM4CcbRDvYYV?=
 =?iso-8859-1?Q?+Nwi66XTGtYyFbz2WCbOjuAsML2jfYfCcqjBb02+ug+k9HLm82+ntWPxOq?=
 =?iso-8859-1?Q?KonjaMQgNVxZqwbt27vtR/KhBaYZzofD0WRm6+wm2NrvZfGYMC3uOTiQm0?=
 =?iso-8859-1?Q?s2Ed6pCe1pEhkAFXUBX5W285yTj5cTxv1ADMOQKeTJZPtrz45OKmJOr0vi?=
 =?iso-8859-1?Q?WMGzlIWQ3RiHbeW+U8KQvezl6lfrYJ7Io17vEeyzULayrazIGkbkp+gMuC?=
 =?iso-8859-1?Q?NlgU8H++P/lYtdHZeEwg/BMl4Lh9WWewAh6Jes3saY9IYRpfImN0CqvD82?=
 =?iso-8859-1?Q?yeTQzbUwmeBwP8SZxd7vcuc357ikPrMOwr3TeZ3bZPYpG8IAyZ73tcLoJE?=
 =?iso-8859-1?Q?08Vlin1m88ZafRHDZDvpZyz446Uyi3faLoXVxDOcMxIgiZ5Q+h0vm9//nm?=
 =?iso-8859-1?Q?4wVQ=3D=3D?=
X-OriginatorOrg: gientech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a216847a-0b26-495f-970d-08da39141f66
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 21:19:41.6855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 89592e53-6f9d-4b93-82b1-9f8da689f1b4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAO4rU6vmUrHg9H2MXp3O42JJy1m4xg9SWP61llnnQJliwVAnJU3ehJqA+KGMcB3sEBPK+Fhp87LbPl5BYp8ZzPGJ5/bJQuCkAa2052Bz6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0591
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,DATE_IN_PAST_24_48,
        DKIM_INVALID,DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Can you do a job with me?
