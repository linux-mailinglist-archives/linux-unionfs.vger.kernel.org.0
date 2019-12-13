Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92D6611E430
	for <lists+linux-unionfs@lfdr.de>; Fri, 13 Dec 2019 13:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfLMM6l (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 13 Dec 2019 07:58:41 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36836 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfLMM6l (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 13 Dec 2019 07:58:41 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDCsFdH093153;
        Fri, 13 Dec 2019 12:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Lo7X5i3aeAYl4E0hOzjUTvXNaezv6f05FMLqKytQDWs=;
 b=oPbjMgcp31ClP7OmRouSbGdd3zQixq5ZebBEYJDGD5wirPltFg++fTzr/MNmEAzHokUB
 9OR938UjRQI3JGv1Vex3r5S3IWRRnoACIc7G45VB6p6p8acisERF0IfBHuZAModnpYcX
 dNXI7aG4ewvtSXm1Vw7U8CaafZsDLOE4FH06To9be7kqTeCtLyCc57SgW7fDv2u9SDTw
 0HmW99F3mhm039akuiZeHZNzBVSFxqb6xn4x3KXMgvZgxQiKn3s677lTKAmhs0aeV9RY
 JCkqC/c6l0QXgrfFy8XX4dPGR4qNZjp5ok5mBD7luO6uTNj6yLb75Swb5y8ggRIXscsJ Ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wr41qrycy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 12:58:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDCsM6N028425;
        Fri, 13 Dec 2019 12:58:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2wumw6kyy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 12:58:37 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBDCwaAv001917;
        Fri, 13 Dec 2019 12:58:36 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Dec 2019 04:58:35 -0800
Date:   Fri, 13 Dec 2019 15:58:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: [bug report] ovl: make sure that real fid is 32bit aligned in
 memory
Message-ID: <20191213125828.GE2407@kadam>
References: <20191213103705.iurz35cawvp6w46w@kili.mountain>
 <CAJfpegv1d=XRcqD0yJpobP2j3F+gBbKhmJ2mUzwq33s=4gD4Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv1d=XRcqD0yJpobP2j3F+gBbKhmJ2mUzwq33s=4gD4Bw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=816
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=878 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130104
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Fri, Dec 13, 2019 at 01:22:10PM +0100, Miklos Szeredi wrote:
> On Fri, Dec 13, 2019 at 11:38 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > Hello Amir Goldstein,
> >
> > This is a semi-automatic email about new static checker warnings.
> >
> > The patch cbe7fba8edfc: "ovl: make sure that real fid is 32bit
> > aligned in memory" from Nov 15, 2019, leads to the following Smatch
> > complaint:
> >
> >     fs/overlayfs/copy_up.c:338 ovl_set_origin()
> >      warn: variable dereferenced before check 'fh' (see line 337)
> >
> > fs/overlayfs/copy_up.c
> >    336           */
> >    337          err = ovl_check_setxattr(dentry, upper, OVL_XATTR_ORIGIN, fh->buf,
> >                                                                           ^^^^^^^
> > The patch adds an unconditional dereference
> 
> But in fact fh->buf is not a dereference:
> 
> struct ovl_fh {
>     u8 padding[3];    /* make sure fb.fid is 32bit aligned */
>     union {
>         struct ovl_fb fb;
>         u8 buf[0];
>     };
> } __packed;
> 
> Subsequent code will also not dereference fh->buf, because the
> supplied size is zero.

Ah yes.  Thanks.  Smatch got confused because the array is inside a
union.  Sorry.

regards,
dan carpenter

