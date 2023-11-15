Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C327EBEF9
	for <lists+linux-unionfs@lfdr.de>; Wed, 15 Nov 2023 10:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjKOJB4 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 15 Nov 2023 04:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjKOJBz (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 15 Nov 2023 04:01:55 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CC1114;
        Wed, 15 Nov 2023 01:01:52 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-672f5fb0b39so37189976d6.2;
        Wed, 15 Nov 2023 01:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700038911; x=1700643711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQ3i+DuEH09Q0J9lmOB+LV4S6KTGmfSqN63jmMIPRT0=;
        b=jhErplvW6hdNoABzD6OLKHMIXpWSnTRGPNYMJlx5m9HRDgMFYjY2oe53CTt8X4zXxf
         TU1cki5CwKPDrUW2vkxP/YjG7X6zE8HhvCBj9MgVqK2prFF8yF78q/lPwvP8csKlu23T
         VdEOmHTQ6D+mJPRaTsS2/3HXQoh+/qWXfWoY3CZf6UnGI/+qMrQxUm6D73mUVMnSLg5K
         5MDiTL/CAmzj6SKlPMrq3E9ZAnxRSLbAg1ddoDF5e8DoFA7c7awylPJyfXo/0jj2t3Bj
         m42fOtQJOtkftG8bHkkYUgND5Z105oB19IBEHJXEgcpVBsdq2x1TUzqmYVXcK+39jzlE
         a1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700038911; x=1700643711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQ3i+DuEH09Q0J9lmOB+LV4S6KTGmfSqN63jmMIPRT0=;
        b=ujgJPTwu5RpxDSQd4Dn72stTgINL73kgtLNIOPsnLvFA7lrbZDBeosfKJ1sqM8V0z2
         /2UtTn5pT8bV0w8zGTJ5nTbL9uBC4bxH4fFQWCEb7jck5yMvOIFNf/0T8SWgcR1NN2wX
         zoauNYafRnh1rkxuAi/d85xcsCh21bF7+gLKhnFA7TEJ7cLUBed0uJMtPpEk6biHwuKK
         BpVtTKuoX7RwfNY8xzGHi1pWZGF0jsnJ9Yt3nv9YpBlWAMmKCaZVtKM16xp9qmQYsn2e
         xWr+qKgWVxQBk6XvieoUa3ubuZ5c9mhs/Q4OMS+fGslq0z/CpW+yqcnUlUL3kKck/C4k
         uQKA==
X-Gm-Message-State: AOJu0Yy6drxCRTGpPsqBNdSFR0OiO3IlopcoBBejnXC+CVGdAa1deXIc
        wi39Vs5L+JwESoVgmYXDahwbLdwGOtUhsrFvC/4=
X-Google-Smtp-Source: AGHT+IEQqBVM5LdtY3n7Q2ibrUDXKIbGXVMQj5ueNmzUtfQ2Rk8N+ThseZn83AAlKF3Z/lotDxmwAfg+Hk5EqiVEY4Q=
X-Received: by 2002:a05:6214:768:b0:66d:6311:f91f with SMTP id
 f8-20020a056214076800b0066d6311f91fmr6230180qvz.45.1700038910987; Wed, 15 Nov
 2023 01:01:50 -0800 (PST)
MIME-Version: 1.0
References: <20231114153254.1715969-1-amir73il@gmail.com> <20231114153254.1715969-10-amir73il@gmail.com>
 <20231114234209.f626le55r5if4fbp@cs.cmu.edu>
In-Reply-To: <20231114234209.f626le55r5if4fbp@cs.cmu.edu>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 15 Nov 2023 11:01:39 +0200
Message-ID: <CAOQ4uxjcnwuF1gMxe64WLODGA_MyAy8x-DtqkCUxqVQKk3Xbng@mail.gmail.com>
Subject: Re: [PATCH 09/15] fs: move file_start_write() into vfs_iter_write()
To:     Jan Harkes <jaharkes@cs.cmu.edu>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-unionfs@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Nov 15, 2023 at 1:42=E2=80=AFAM Jan Harkes <jaharkes@cs.cmu.edu> wr=
ote:
>
> That is a NACK for me.
>
> Your change inverts lock ordering so that after your change we hold the
> inode lock on the coda inode before we calls file_start_write.
>

hmm. It is not ok that my patch changes lock ordering.
It is in fact the correct locking order,
but it should be changed in a separate patch.

> See the comments for sb_start_write in include/linux/fs.h
> (__sb_start_write is pretty much the only thing file_start_write calls).
>
>  * Since freeze protection behaves as a lock, users have to preserve
>  * ordering of freeze protection and other filesystem locks. Generally,
>  * freeze protection should be the outermost lock. In particular, we
>  * have:
>  *
>  * sb_start_write
>  *   -> i_mutex                 (write path, truncate, directory ops,
>  *   ...)
>  *   -> s_umount                (freeze_super, thaw_super)
>

This describes the locking order within a specific fs.
host_file is not in the same fs as code_inode.

IIUC, host_file is a sort of backing file for the code inode.
In cases like this, as in cachefiles and overlayfs, it is best
to order all backing fs locks strictly after all the frontend fs locks.
See ovl_write_iter() for example.

IOW, the new lock ordering is preferred:
file_start_write(coda_file)
  inode_lock(code_inode)
    file_start_write(host_file)
      inode_lock(host_inode)


Thanks,
Amir.

>
>
> On Tue, Nov 14, 2023 at 05:32:48PM +0200, Amir Goldstein wrote:
> ...
> > diff --git a/fs/coda/file.c b/fs/coda/file.c
> > index 16acc58311ea..7c84555c8923 100644
> > --- a/fs/coda/file.c
> > +++ b/fs/coda/file.c
> > @@ -79,14 +79,12 @@ coda_file_write_iter(struct kiocb *iocb, struct iov=
_iter *to)
> >       if (ret)
> >               goto finish_write;
> >
> > -     file_start_write(host_file);
> >       inode_lock(coda_inode);
> > -     ret =3D vfs_iter_write(cfi->cfi_container, to, &iocb->ki_pos, 0);
> > +     ret =3D vfs_iter_write(host_file, to, &iocb->ki_pos, 0);
> >       coda_inode->i_size =3D file_inode(host_file)->i_size;
> >       coda_inode->i_blocks =3D (coda_inode->i_size + 511) >> 9;
> >       inode_set_mtime_to_ts(coda_inode, inode_set_ctime_current(coda_in=
ode));
> >       inode_unlock(coda_inode);
> > -     file_end_write(host_file);
> >
> >  finish_write:
> >       venus_access_intent(coda_inode->i_sb, coda_i2f(coda_inode),
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 5d704461e3b4..35c9546b3396 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1186,9 +1186,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc=
_fh *fhp, struct nfsd_file *nf,
> >       since =3D READ_ONCE(file->f_wb_err);
> >       if (verf)
> >               nfsd_copy_write_verifier(verf, nn);
> > -     file_start_write(file);
> >       host_err =3D vfs_iter_write(file, &iter, &pos, flags);
> > -     file_end_write(file);
> >       if (host_err < 0) {
> >               commit_reset_write_verifier(nn, rqstp, host_err);
> >               goto out_nfserr;
> > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > index 131621daeb13..690b173f34fc 100644
> > --- a/fs/overlayfs/file.c
> > +++ b/fs/overlayfs/file.c
> > @@ -436,9 +436,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, s=
truct iov_iter *iter)
> >       if (is_sync_kiocb(iocb)) {
> >               rwf_t rwf =3D iocb_to_rw_flags(ifl);
> >
> > -             file_start_write(real.file);
> >               ret =3D vfs_iter_write(real.file, iter, &iocb->ki_pos, rw=
f);
> > -             file_end_write(real.file);
> >               /* Update size */
> >               ovl_file_modified(file);
> >       } else {
> > diff --git a/fs/read_write.c b/fs/read_write.c
> > index 590ab228fa98..8cdc6e6a9639 100644
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -846,7 +846,7 @@ ssize_t vfs_iter_read(struct file *file, struct iov=
_iter *iter, loff_t *ppos,
> >  EXPORT_SYMBOL(vfs_iter_read);
> >
> >  static ssize_t do_iter_write(struct file *file, struct iov_iter *iter,
> > -             loff_t *pos, rwf_t flags)
> > +                          loff_t *pos, rwf_t flags)
> >  {
> >       size_t tot_len;
> >       ssize_t ret =3D 0;
> > @@ -901,11 +901,18 @@ ssize_t vfs_iocb_iter_write(struct file *file, st=
ruct kiocb *iocb,
> >  EXPORT_SYMBOL(vfs_iocb_iter_write);
> >
> >  ssize_t vfs_iter_write(struct file *file, struct iov_iter *iter, loff_=
t *ppos,
> > -             rwf_t flags)
> > +                    rwf_t flags)
> >  {
> > +     int ret;
> > +
> >       if (!file->f_op->write_iter)
> >               return -EINVAL;
> > -     return do_iter_write(file, iter, ppos, flags);
> > +
> > +     file_start_write(file);
> > +     ret =3D do_iter_write(file, iter, ppos, flags);
> > +     file_end_write(file);
> > +
> > +     return ret;
> >  }
> >  EXPORT_SYMBOL(vfs_iter_write);
> >
> > --
> > 2.34.1
> >
> >
