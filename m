Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34C8511E21F
	for <lists+linux-unionfs@lfdr.de>; Fri, 13 Dec 2019 11:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfLMKiF (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 13 Dec 2019 05:38:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37342 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfLMKiF (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 13 Dec 2019 05:38:05 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDAYRpX182668;
        Fri, 13 Dec 2019 10:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=v5R8ljpw7DWPl+sCTfTdV5E7eSa6eLXy3uZ/hL8yPIY=;
 b=HYeHL9bDyh2EfoSQ4UZBLYwlJduEQ3/DVVwtz8kQ+7i8WPKUBtyi3J1a5T8GK2pHkJFC
 nfpEd+HNaPZgOdW9Ud49FYv0mbygaQL8OMRXd09G/NC359uQDfPZ9cThmkrOPvewxlfv
 sWFtVgk425exJVVj1RugaQlxqMUdgy+adBs1HqvJdNbXzvw+qtfxSYejBKl69kASnfmB
 OGMrItipSrocc//YxhnuXlV2KZ+9ZlWeuqEyrMbNEVe80Nq1A7EP38NppNDA4k5VRpav
 pAnknGYDxUxFkFLUsVGwvdgP/D8HpOuXByE6uTyfKqcBroplANd7Et9gP/Ze77FuHJll dA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wr41qrd1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 10:38:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDAYVmM078657;
        Fri, 13 Dec 2019 10:38:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2wumk8cpwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 10:38:01 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBDAc0Fp027381;
        Fri, 13 Dec 2019 10:38:00 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Dec 2019 02:38:00 -0800
Date:   Fri, 13 Dec 2019 13:37:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org
Subject: [bug report] ovl: make sure that real fid is 32bit aligned in memory
Message-ID: <20191213103705.iurz35cawvp6w46w@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=255
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=335 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130085
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hello Amir Goldstein,

This is a semi-automatic email about new static checker warnings.

The patch cbe7fba8edfc: "ovl: make sure that real fid is 32bit 
aligned in memory" from Nov 15, 2019, leads to the following Smatch 
complaint:

    fs/overlayfs/copy_up.c:338 ovl_set_origin()
     warn: variable dereferenced before check 'fh' (see line 337)

fs/overlayfs/copy_up.c
   336		 */
   337		err = ovl_check_setxattr(dentry, upper, OVL_XATTR_ORIGIN, fh->buf,
                                                                          ^^^^^^^
The patch adds an unconditional dereference

   338					 fh ? fh->fb.len : 0, 0);
                                         ^^
but "fh" can be NULL.

   339		kfree(fh);
   340	

regards,
dan carpenter
