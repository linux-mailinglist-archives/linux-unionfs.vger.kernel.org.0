Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA33D58587
	for <lists+linux-unionfs@lfdr.de>; Thu, 27 Jun 2019 17:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfF0P1n (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 27 Jun 2019 11:27:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35936 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfF0P1n (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 27 Jun 2019 11:27:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5RFOVmh074869;
        Thu, 27 Jun 2019 15:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=J1Aypk9pSkWnkOqkKiv9Me27Hl2ukustB7/XulEzorE=;
 b=zuqcEv5cdEwuKvNN9Rhlf0dAtxFgLSeFu2orl5jHcsGeJTmk8AblwLs0DZVrEtv+MW5b
 dUfCjVhEtQe8F5TIv58AvxAi1guNW2ShnylyxzyrIz1ocWRbR/Eh6ameKXYhtjqXXD70
 plr1zsaSiRorp4sL16RHCTg6sNWcB/dnjlpVWrwn+sJDbdGXKtBVg3x45UnjVrsntiKz
 VxHRHRcsreoQUODu8V0mi7AMOCuXVjkFt5wHGVSXU5y+EycWA5/WkTozMcZMFHJkJ89C
 X8/CUACbxB6NOdXodUJZgj3xUNVapFX4WJeTdkafYcjt5CcaWck2RWp/gt2QTo/K8Omz Fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t9brth2up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 15:27:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5RFPU5Z094944;
        Thu, 27 Jun 2019 15:25:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tat7desan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 15:25:39 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5RFPcuN030384;
        Thu, 27 Jun 2019 15:25:38 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 08:25:37 -0700
Date:   Thu, 27 Jun 2019 08:25:36 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     fstests@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu
Subject: Re: [PATCH] generic/486: filter out irrelevant attrs
Message-ID: <20190627152536.GA5167@magnolia>
References: <20190627090100.18542-1-jencce.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627090100.18542-1-jencce.kernel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270178
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270178
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, Jun 27, 2019 at 05:00:59PM +0800, Murphy Zhou wrote:
> In some setup, there could be extra attrs printed, like selinux.
> They are breaking golden output and irrelevant for this test.
> So focus on the attr we are testing on to avoid false alarm.
> Print the output to .full for debug.
> 
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  tests/generic/486 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/486 b/tests/generic/486
> index ff115a07..ea571efe 100755
> --- a/tests/generic/486
> +++ b/tests/generic/486
> @@ -46,10 +46,12 @@ _scratch_mkfs >>$seqres.full 2>&1
>  _scratch_mount >>$seqres.full 2>&1
>  
>  filter_attr_output() {
> -	_filter_scratch | sed -e 's/has a [0-9]* byte value/has a NNNN byte value/g'
> +	_filter_scratch | grep world | \
> +		sed -e 's/has a [0-9]* byte value/has a NNNN byte value/g'
>  }
>  
>  ./src/attr_replace_test $SCRATCH_MNT/hello
> +$ATTR_PROG -l $SCRATCH_MNT/hello >>$seqres.full 2>&1
>  $ATTR_PROG -l $SCRATCH_MNT/hello | filter_attr_output
>  
>  status=0
> -- 
> 2.21.0
> 
