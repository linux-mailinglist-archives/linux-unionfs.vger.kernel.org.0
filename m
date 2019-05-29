Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2029B2DAD1
	for <lists+linux-unionfs@lfdr.de>; Wed, 29 May 2019 12:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfE2Kba (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 29 May 2019 06:31:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56056 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfE2Kba (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 29 May 2019 06:31:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TAO1jT009076;
        Wed, 29 May 2019 10:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=HgJ/uiVimMlnpkh8hoGMBh8Rt6ZLjLCLq/C0NTe5V+s=;
 b=FGX6ssAq1KAuT53S3axRF+nlUvxeTphKqtEqdv1nAVjZms0/jwWU/fPhgUctqyJna1ck
 TpoeEl9OySMHlE1Brca5wmrDQO3JjaD4CLOuhB4MN+OCmkAZnwkQHBndg4CE/eqapiN6
 KhlfUccM0iFvtuboxf/D233+MYdKIgYizA5+oM0OPZ5ne4f11Lz8hmbUIQNY9XfezGaC
 a4FBYgYd5w9BLyDfm680OS4GEfkBj4Xm+iwyCy3RcKMArqipZCYwte+zh8eniqRtjMfO
 t4suf8MOEKzyYX+sWARZ6JyFPK8pQz6TmH5tESZBoA2q21AGEXjOIN1KnhE5TEUj3yOd gQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2spxbq8p4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 10:31:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TAUNNn120292;
        Wed, 29 May 2019 10:31:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2sqh73mdcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 10:31:27 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4TAVRtC024795;
        Wed, 29 May 2019 10:31:27 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 03:31:26 -0700
Date:   Wed, 29 May 2019 13:31:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org
Subject: [bug report] ovl: detect overlapping layers
Message-ID: <20190529103120.GA15021@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=546
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905290070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=588 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290070
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Hello Amir Goldstein,

The patch 0e7f2cccb42a: "ovl: detect overlapping layers" from Apr 18,
2019, leads to the following static checker warning:

	fs/overlayfs/super.c:998 ovl_setup_trap()
	warn: passing a valid pointer to 'PTR_ERR'

fs/overlayfs/super.c
   991  static int ovl_setup_trap(struct super_block *sb, struct dentry *dir,
   992                            struct inode **ptrap, const char *name)
   993  {
   994          struct inode *trap;
   995          int err;
   996  
   997          trap = ovl_get_trap_inode(sb, dir);
   998          err = PTR_ERR(trap);
   999          if (IS_ERR(trap) && err == -ELOOP) {
  1000                  pr_err("overlayfs: conflicting %s path\n", name);
  1001                  return err;
  1002          }
  1003  
  1004          *ptrap = trap;
  1005          return 0;
  1006  }

The warning message is wrong but the code is also wrong.  The
ovl_get_trap_inode() can return ERR_PTR(-ENOMEM) and that would lead to
and Oops when we try to call iput() on it.

regards,
dan carpenter
