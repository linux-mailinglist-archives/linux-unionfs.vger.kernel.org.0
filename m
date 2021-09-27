Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD2D4191A9
	for <lists+linux-unionfs@lfdr.de>; Mon, 27 Sep 2021 11:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhI0Jkl (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Mon, 27 Sep 2021 05:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbhI0Jkl (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Mon, 27 Sep 2021 05:40:41 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2BBC061604
        for <linux-unionfs@vger.kernel.org>; Mon, 27 Sep 2021 02:39:03 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id s17so47995090edd.8
        for <linux-unionfs@vger.kernel.org>; Mon, 27 Sep 2021 02:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ECuwL8PYjygsXbJeg0HIr0JMSqu9hGq4/KV9n5A6dtA=;
        b=CQILzEC7pzKjk9XO7pFtNfZ/7DXYnBmKVK4NBNhCa1P8Ky74nwcKlLrArJ/RA4o5Ee
         BPMosUGfUDgE+agrVRTsixyT/PB+0Vaa6wqVMRoRrYxCvhAN1UHuWbpBgYjqE04C28Lt
         xolW6ymtZCXimpknOdvLPeKaUTjEyYKUfIGdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ECuwL8PYjygsXbJeg0HIr0JMSqu9hGq4/KV9n5A6dtA=;
        b=o0rEkxw+95gRT6QG+O9wZ/lE9bZEYi7j/ROnXWo+X7kEodhCcGKMgcSDwLqAN/NtoZ
         M0CLkNS17NBNLR2dhAMguTLxWtPisk+xWHQeZQWL665WHajFncq6XV383rZ37h6S6TpB
         l0Kw40HDwahUe7UV1ixU7mjhV8OXGazW4h57Pc6hhVi/ksSK4jNNf7PV2Dz5GqhAvSFu
         8Kiqe82l/U6rgIEg90c6laRNNxhJYhveuSbdn3GU9XSN+330B5l73ryE0SHr1RhwIQIp
         +d+N3o5WkE88rCTMjMByTVRev6D8z11MjETZZKbIjlEHEghyC3BCs9rFuaQiLl3BJyI0
         6xoA==
X-Gm-Message-State: AOAM531n3UP6f1zsx1v8g7DPL04OvjDQ29xEmU+HkauvmT4SYzqREjMe
        IuDV2XCwX2XYj++qX0pV5Dc4Ig==
X-Google-Smtp-Source: ABdhPJzW+RfuYCPBrlZd1XY3JCu+cCPxlJ0MUR8DYD5oqwXxw7pJMF2ZzojlsotC6zZLslQ5r2B7Wg==
X-Received: by 2002:a17:906:e216:: with SMTP id gf22mr25286699ejb.357.1632735541800;
        Mon, 27 Sep 2021 02:39:01 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-16.catv.broadband.hu. [86.101.169.16])
        by smtp.gmail.com with ESMTPSA id dt4sm3169554ejb.27.2021.09.27.02.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 02:39:01 -0700 (PDT)
Date:   Mon, 27 Sep 2021 11:38:58 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     Chengguang Xu <cgxu519@139.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        guoweichao@oppo.com, yh@oppo.com, zhangshiming@oppo.com,
        guanyuwei@oppo.com, jnhuang95@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Subject: Re: [PATCH v3] ovl: fix null pointer when
 filesystemdoesn'tsupportdirect IO
Message-ID: <YVGRMoRTH4oJpxWZ@miu.piliscsaba.redhat.com>
References: <9ef909de-1854-b4be-d272-2b4cda52329f@oppo.com>
 <20210922072326.3538-1-huangjianan@oppo.com>
 <e42a183f-274c-425f-2012-3ff0003e1fcb@139.com>
 <919e929d-6af7-b729-9fd2-954cd1e52999@oppo.com>
 <314324e7-02d7-dc43-b270-fb8117953549@139.com>
 <CAJfpegs_T5BQ+e79T=1fqTScjfaOyAftykmzK6=hdS=WhVvWsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegs_T5BQ+e79T=1fqTScjfaOyAftykmzK6=hdS=WhVvWsg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Sep 22, 2021 at 04:00:47PM +0200, Miklos Szeredi wrote:

> First let's fix the oops: ovl_read_iter()/ovl_write_iter() must check
> real file's ->direct_IO if IOCB_DIRECT is set in iocb->ki_flags and
> return -EINVAL if not.

And here's that fix.  Please test.

Thanks,
Miklos

---
From: Miklos Szeredi <mszeredi@redhat.com>
Subject: ovl: fix IOCB_DIRECT if underlying fs doesn't support direct IO

Normally the check at open time suffices, but e.g loop device does set
IOCB_DIRECT after doing its own checks (which are not sufficent for
overlayfs).

Make sure we don't call the underlying filesystem read/write method with
the IOCB_DIRECT if it's not supported.

Reported-by: Huang Jianan <huangjianan@oppo.com>
Fixes: 16914e6fc7e1 ("ovl: add ovl_read_iter()")
Cc: <stable@vger.kernel.org> # v4.19
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/file.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -296,6 +296,12 @@ static ssize_t ovl_read_iter(struct kioc
 	if (ret)
 		return ret;
 
+	ret = -EINVAL;
+	if (iocb->ki_flags & IOCB_DIRECT &&
+	    (!real.file->f_mapping->a_ops ||
+	     !real.file->f_mapping->a_ops->direct_IO))
+		goto out_fdput;
+
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	if (is_sync_kiocb(iocb)) {
 		ret = vfs_iter_read(real.file, iter, &iocb->ki_pos,
@@ -320,7 +326,7 @@ static ssize_t ovl_read_iter(struct kioc
 out:
 	revert_creds(old_cred);
 	ovl_file_accessed(file);
-
+out_fdput:
 	fdput(real);
 
 	return ret;
@@ -349,6 +355,12 @@ static ssize_t ovl_write_iter(struct kio
 	if (ret)
 		goto out_unlock;
 
+	ret = -EINVAL;
+	if (iocb->ki_flags & IOCB_DIRECT &&
+	    (!real.file->f_mapping->a_ops ||
+	     !real.file->f_mapping->a_ops->direct_IO))
+		goto out_fdput;
+
 	if (!ovl_should_sync(OVL_FS(inode->i_sb)))
 		ifl &= ~(IOCB_DSYNC | IOCB_SYNC);
 
@@ -384,6 +396,7 @@ static ssize_t ovl_write_iter(struct kio
 	}
 out:
 	revert_creds(old_cred);
+out_fdput:
 	fdput(real);
 
 out_unlock:
