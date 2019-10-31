Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 139F3EAAC3
	for <lists+linux-unionfs@lfdr.de>; Thu, 31 Oct 2019 07:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfJaGx2 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 31 Oct 2019 02:53:28 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41499 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfJaGx2 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 31 Oct 2019 02:53:28 -0400
Received: by mail-yw1-f67.google.com with SMTP id j131so1771425ywa.8
        for <linux-unionfs@vger.kernel.org>; Wed, 30 Oct 2019 23:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMCqL83cXUxVlZwRg9RxAOatHMyJ6bvMnyeS0pjs4Vg=;
        b=tTnGvIOscXHeyEtQ4Srbd2lqYpqoviC55HL7b0wsJefxSESW/YGppCFD3GsAkr6/UP
         vvAUOdYKsWubQdC5nCVoTjwv3zGBEHllynVIcEH2Sy4O0ztjAbSlZwvlLospwUjW9UwV
         657D5DM3yj0t1CAL5Us9dybVTYvXJJh3MRgKzZXeyBz17XokNMmB+YYdVTrS5WO4rc9n
         MNEnZ66mwTLMUKPri2Sbb4ZgnRwQpRSBQ+koa0XUNdgCxBiQp4k3zirb9xeZY8uJTb4y
         //3+GgGRZVl+C7Tf7dOo/XgmTSqU7rqLukWDB0Fm8Vh+yDqlKuMijOiG41S704d5TU5V
         ECNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMCqL83cXUxVlZwRg9RxAOatHMyJ6bvMnyeS0pjs4Vg=;
        b=uWKU8XKoOmlGrobVzmPTM9cqtdy/finpjOrw46ErI1n/RdCt8hmSn37sqpG8wGOjtA
         uXXZbu11a2Yen33lejKJHnivLsINnLvAXZs69yZE26RQro1FCyauTaFiAWD87JQxOA+r
         XWAhEVv5khJu+nEOVcBsNuxSbyivFUK+eeIDgI8M+Rh1H/d7BBDDB+mPqG6NsL5mlL1D
         Soxkgo/pHoPXN5GQq3F8DCivdWc3q5pbZmX5HgGLjTH6k7zYkd/4KkY4zPdPN8oXwTT3
         DSbsCEWHz58VAJ31j9jt5rVz8aDJcZ3AGuJCJLjJBZs27JOJPa4igRT/1jSSaWv8UyeJ
         j7vQ==
X-Gm-Message-State: APjAAAUk1YF4MPTFVvpljmKduOf6Gxp1ADOOYmTLUDsV4YseJIwHc3vs
        lZe3AXPuiNKENuIK6N8sdqBBwZUv5BINc0bFJFEvgsPU
X-Google-Smtp-Source: APXvYqzUWBI/GdDrh4O3WLy5SqEQ5CXuSoDJMoJB7ynZPPWF596dL1Gh5eAYE33X4Q3W0sV3wx6XxEOu2JhBpMi3YBA=
X-Received: by 2002:a81:9a0c:: with SMTP id r12mr2663007ywg.25.1572504806904;
 Wed, 30 Oct 2019 23:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191030124431.11242-1-cgxu519@mykernel.net> <CAOQ4uxh670WFhwpQyPFTB2nUCSc9n1VmuyPOfdqiBSsq6GxLpQ@mail.gmail.com>
 <16e204de70e.cefd69461771.2205150443916624303@mykernel.net>
In-Reply-To: <16e204de70e.cefd69461771.2205150443916624303@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 31 Oct 2019 08:53:15 +0200
Message-ID: <CAOQ4uxhdSXAvFQfhzZpBC=Xmmo9y+3AOU1o-tOWsLtr2ntU6Ag@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: improving copy-up efficiency for big sparse file
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

>  > Yes, overlayfs does not comply with this "posix"' test.
>  > This is why it was removed from the auto and quick groups.
>
> So I'm curious what is the purpose for the test?
>

This is a POSIX compliance test.
It is meant to "remind" us that this behavior is not POSIX compliant
and that we should fix it one day...
A bit controversial to have a test like this without a roadmap
when it is going to be fixed in xfstests, but it's there.

>  >
>  > >
>  > >
>  > > v1->v2:
>  > > - Set file size when the hole is in the end of the file.
>  > > - Add a code comment for hole copy-up improvement.
>  > > - Check SEEK_DATA support before doing hole skip.
>  > > - Back to original copy-up when seek data fails(in error case).
>  > >
>  > >  fs/overlayfs/copy_up.c | 78 ++++++++++++++++++++++++++++++++++--------
>  > >  1 file changed, 64 insertions(+), 14 deletions(-)
>  > >
>  > > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
>  > > index b801c6353100..7d8a34c480f4 100644
>  > > --- a/fs/overlayfs/copy_up.c
>  > > +++ b/fs/overlayfs/copy_up.c
>  > > @@ -116,13 +116,30 @@ int ovl_copy_xattr(struct dentry *old, struct dentry *new)
>  > >         return error;
>  > >  }
>  > >
>  > > -static int ovl_copy_up_data(struct path *old, struct path *new, loff_t len)
>  > > +static int ovl_set_size(struct dentry *upperdentry, struct kstat *stat)
>  > > +{
>  > > +       struct iattr attr = {
>  > > +               .ia_valid = ATTR_SIZE,
>  > > +               .ia_size = stat->size,
>  > > +       };
>  > > +
>  > > +       return notify_change(upperdentry, &attr, NULL);
>  > > +}
>  > > +
>  > > +static int ovl_copy_up_data(struct path *old, struct path *new,
>  > > +                           struct kstat *stat)
>  > >  {
>  > >         struct file *old_file;
>  > >         struct file *new_file;
>  > > +       loff_t len = stat->size;
>  > >         loff_t old_pos = 0;
>  > >         loff_t new_pos = 0;
>  > >         loff_t cloned;
>  > > +       loff_t old_next_data_pos;
>  > > +       loff_t hole_len;
>  > > +       bool seek_support = false;
>  > > +       bool skip_hole = true;
>  > > +       bool set_size = false;
>  > >         int error = 0;
>  > >
>  > >         if (len == 0)
>  > > @@ -144,7 +161,12 @@ static int ovl_copy_up_data(struct path *old, struct path *new, loff_t len)
>  > >                 goto out;
>  > >         /* Couldn't clone, so now we try to copy the data */
>  > >
>  > > -       /* FIXME: copy up sparse files efficiently */
>  > > +       /* Check if lower fs supports seek operation */
>  > > +       if (old_file->f_mode & FMODE_LSEEK &&
>  > > +           old_file->f_op->llseek) {
>  > > +               seek_support = true;
>  > > +       }
>  > > +
>  > >         while (len) {
>  > >                 size_t this_len = OVL_COPY_UP_CHUNK_SIZE;
>  > >                 long bytes;
>  > > @@ -157,6 +179,38 @@ static int ovl_copy_up_data(struct path *old, struct path *new, loff_t len)
>  > >                         break;
>  > >                 }
>  > >
>  > > +               /*
>  > > +                * Fill zero for hole will cost unnecessary disk space
>  > > +                * and meanwhile slow down the copy-up speed, so we do
>  > > +                * an optimization for hole during copy-up, it relies
>  > > +                * on SEEK_DATA implementation and the hole check is
>  > > +                * aligned to OVL_COPY_UP_CHUNK_SIZE. In other word,
>  > > +                * we do not try to recognize all kind of holes here,
>  > > +                * we just skip big enough hole for simplicity to
>  > > +                * implement. If lower fs does not support SEEK_DATA
>  > > +                * operation, the copy-up will behave as before.
>  > > +                */
>  > > +
>  > > +               if (seek_support && skip_hole) {
>  > > +                       old_next_data_pos = vfs_llseek(old_file,
>  > > +                                               old_pos, SEEK_DATA);
>  > > +                       if (old_next_data_pos >= old_pos +
>  > > +                                               OVL_COPY_UP_CHUNK_SIZE) {
>  > > +                               hole_len = (old_next_data_pos - old_pos) /
>  > > +                                               OVL_COPY_UP_CHUNK_SIZE *
>  > > +                                               OVL_COPY_UP_CHUNK_SIZE;
>  >
>  > Use round_down() helper
>
> I'll change the logic of hole detection a bit, so that it could work
> more effectively for big continuous hole.

Not sure what you mean.
I meant there is a helper in the kernel you should use
instead of the expression "/ N * N"

>
>
>  >
>  > > +                               old_pos += hole_len;
>  > > +                               new_pos += hole_len;
>  > > +                               len -= hole_len;
>  > > +                               continue;
>  > > +                       } else if (old_next_data_pos == -ENXIO) {
>  > > +                               set_size = true;
>  > > +                               break;
>  > > +                       } else if (old_next_data_pos < 0) {
>  > > +                               skip_hole = false;
>  >
>  > Why do you need to use 2 booleans?
>  > You can initialize skip_hole = true only in case of lower
>  > has seek support.
>  >
>  > >
>  > > +                       }
>  > > +               }
>  > > +
>  > >                 bytes = do_splice_direct(old_file, &old_pos,
>  > >                                          new_file, &new_pos,
>  > >                                          this_len, SPLICE_F_MOVE);
>  > > @@ -168,6 +222,12 @@ static int ovl_copy_up_data(struct path *old, struct path *new, loff_t len)
>  > >
>  > >                 len -= bytes;
>  > >         }
>  > > +
>  > > +       if (!error && set_size) {
>  > > +               inode_lock(new->dentry->d_inode);
>  > > +               error = ovl_set_size(new->dentry, stat);
>  > > +               inode_unlock(new->dentry->d_inode);
>  > > +       }
>  >
>  > I see no reason to repeat this code here.
>  > Two options:
>  > 1. always set_size at the end of ovl_copy_up_inode()
>  >     what's the harm in that?
>
> I think at least it's not suitable for directory.
>
>
>  > 2. set boolean c->set_size here and check it at the end
>  >     of ovl_copy_up_inode() instead of checking c->metacopy
>  >
>
> I don't understand why 'c->set_size' can replace 'c->metacopy',
>

I did not explain myself well.

This should be enough IMO:

@@ -483,7 +483,7 @@ static int ovl_copy_up_inode(struct
ovl_copy_up_ctx *c, struct dentry *temp)
        }

        inode_lock(temp->d_inode);
-       if (c->metacopy)
+       if (S_ISREG(c->stat.mode))
                err = ovl_set_size(temp, &c->stat);
        if (!err)
                err = ovl_set_attr(temp, &c->stat);

There is no special reason IMO to try to spare an unneeded ovl_set_size
if it simplifies the code a bit.

As a matter of fact, I think overlayfs currently does a metacopy
copy up even for files of size 0.
This will cost unneeded code to run during lookup and later
for clearing the metacopy on "data" copy up.
Not sure how much this case is common,
but that's for another patch:

@@ -717,7 +717,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
        return err;
 }

-static bool ovl_need_meta_copy_up(struct dentry *dentry, umode_t mode,
+static bool ovl_need_meta_copy_up(struct dentry *dentry, struct kstat *stat,
                                  int flags)
 {
        struct ovl_fs *ofs = dentry->d_sb->s_fs_info;
@@ -725,7 +725,7 @@ static bool ovl_need_meta_copy_up(struct dentry
*dentry, umode_t mode,
        if (!ofs->config.metacopy)
                return false;

-       if (!S_ISREG(mode))
+       if (!S_ISREG(stat->mode) || !stat->size)
                return false;

        if (flags && ((OPEN_FMODE(flags) & FMODE_WRITE) || (flags & O_TRUNC)))
@@ -805,7 +805,7 @@ static int ovl_copy_up_one(struct dentry *parent,
struct dentry *dentry,
        if (err)
                return err;

-       ctx.metacopy = ovl_need_meta_copy_up(dentry, ctx.stat.mode, flags);
+       ctx.metacopy = ovl_need_meta_copy_up(dentry, &ctx.stat, flags);

        if (parent) {
                ovl_path_upper(parent, &parentpath);

Thanks,
Amir.
