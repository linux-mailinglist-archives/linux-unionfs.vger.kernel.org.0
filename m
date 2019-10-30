Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0716CE9FA1
	for <lists+linux-unionfs@lfdr.de>; Wed, 30 Oct 2019 16:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfJ3Pu0 (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 30 Oct 2019 11:50:26 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45629 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfJ3Pu0 (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 30 Oct 2019 11:50:26 -0400
Received: by mail-yb1-f194.google.com with SMTP id q143so1064849ybg.12
        for <linux-unionfs@vger.kernel.org>; Wed, 30 Oct 2019 08:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nBSrnnO2sKibUCHDZPs3fBCgYy54pd/201WIviqO4eA=;
        b=blIu0orUExI/x/V1MD8Aj8t9I1SqEqXUTke/6QexDuDtY5eol9bkYBwNTKl7diLw0k
         89Ld5erieMIArD7h7frMEKIwWX0r+t0Fn0UsYzy1wTs8zsY658bdxz8QoOisX3B4fq/w
         9cKCs4Rk1QdlCaI3zACtKnX3z47rl1QaQ2FUSgNt/BvS7TJ3I2FzFvC8qvnmfSV99z6Y
         sO0VQ633w9D6dazYGZNMFQlMgLSxhxaWy6UjzzPEdJqodr5fwwe/AOrIpi6twoq4Qw56
         Bdxgf4KHU9llvQkJaanH7WNnIpqzgAVLztl6gzNK/oRgSwRHF4ozH0/j0f9R16+EsSbM
         OjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nBSrnnO2sKibUCHDZPs3fBCgYy54pd/201WIviqO4eA=;
        b=lW5QHAPHiF/sYDxMpSb4MR3Tl5CtND/FHieHLcFt3j7zXu3yWnkd7crjyDr55eoFAx
         g0taN78dgM4esFHsrFpaCp3MaMdcaLftUSXq1FgN/cZpIhiEqnuwxVtVS/IElXKn1E7j
         VoSqs7rKNaeFR8vtmpmhjCL3Xnh6SoiqnWsgkuRGFT4yVq1WlXVPy3hbuVvDU+HNgOZs
         48R+LEb03Pcf89lMdLiM9OhF5mlIRCjg0Rsx0GO8xvOhp/AxTGMXCc+r7JQn53u5HXxi
         cO9RhWS5hQQ0Ku+VR5FVLYz/1ci3ta3FNHjdCXqUjdolndDVYN2xM0t56ckjz4nkK9to
         cN+g==
X-Gm-Message-State: APjAAAUVNMno30bDTtDI59yP62BuULUV3US0avgpiNGos+D4mqGiDts0
        jOp5TO9dAG/WdoA2rfLhqq/G1mAp74eD4lOIIiXKVgnj
X-Google-Smtp-Source: APXvYqxm5Eyk1IjGmjOBUHnv37DHzdqk7RH6PhIQQUm/MDou5GcHZVqp2h1lUWJvLa50wWR+zfM/dO6+XvEgvmzos0Q=
X-Received: by 2002:a25:3744:: with SMTP id e65mr24188yba.126.1572450625044;
 Wed, 30 Oct 2019 08:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191030124431.11242-1-cgxu519@mykernel.net>
In-Reply-To: <20191030124431.11242-1-cgxu519@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Oct 2019 17:50:13 +0200
Message-ID: <CAOQ4uxh670WFhwpQyPFTB2nUCSc9n1VmuyPOfdqiBSsq6GxLpQ@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: improving copy-up efficiency for big sparse file
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Oct 30, 2019 at 2:45 PM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> Current copy-up is not efficient for big sparse file,
> It's not only slow but also wasting more disk space
> when the target lower file has huge hole inside.
> This patch tries to recognize file hole and skip it
> during copy-up.
>
> In detail, this optimization checks the hole according
> to copy-up chunk size so it may not recognize all kind
> of holes in the file. However, it is easy to implement
> and will be enough for most of the use case.
>
> Additionally, this optimization relies on lseek(2)
> SEEK_DATA implementation, so for some specific
> filesystems which do not support this feature
> will behave as before on copy-up.
>
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
>
> Hi Miklos, Amir
>
> This is v2 version of hole copy-up improvement which
> addressed amir's concerns in previous email.
>
> Could you have a look at this patch?
>
> There is a checkpatch warning but that is
> false-positive warning, so you can ignore it.
>
> I've tested the patch with the cases under overlay dir
> (include overlay/066) in fstest for xfs/ext4 fstype,
> and passed most of the cases except below.
>
> overlay/045     [not run] fsck.overlay utility required, skipped this test
> overlay/046     [not run] fsck.overlay utility required, skipped this test
> overlay/056     [not run] fsck.overlay utility required, skipped this test

Those are not failures.
You need to install fsck.overlay from
https://github.com/hisilicon/overlayfs-progs
for these tests to run.

>
> Above three cases are fsck related cases,
> I think they are not important for copy-up.
>
> overlay/061     - output mismatch (see /home/cgxu/git/xfstests-dev/results//overlay/061.out.bad)
>     --- tests/overlay/061.out   2019-05-28 09:54:42.320874925 +0800
>     +++ /home/cgxu/git/xfstests-dev/results//overlay/061.out.bad        2019-10-30 16:11:50.490848367 +0800
>     @@ -1,4 +1,4 @@
>      QA output created by 061
>     -00000000:  61 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61  aaaaaaaaaaaaaaaa
>     +00000000:  54 68 69 73 20 69 73 20 6f 6c 64 20 6e 65 77 73  This.is.old.news
>      After mount cycle:
>      00000000:  61 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61  aaaaaaaaaaaaaaaa
>     ...
>     (Run 'diff -u /home/cgxu/git/xfstests-dev/tests/overlay/061.out /home/cgxu/git/xfstests-dev/results//overlay/061.out.bad'  to see the entire diff)
>
> overlay/061 was failed with/without my patch and test results
> were just same. have something already broken for the test?

Yes, overlayfs does not comply with this "posix"' test.
This is why it was removed from the auto and quick groups.

>
>
> v1->v2:
> - Set file size when the hole is in the end of the file.
> - Add a code comment for hole copy-up improvement.
> - Check SEEK_DATA support before doing hole skip.
> - Back to original copy-up when seek data fails(in error case).
>
>  fs/overlayfs/copy_up.c | 78 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 64 insertions(+), 14 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index b801c6353100..7d8a34c480f4 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -116,13 +116,30 @@ int ovl_copy_xattr(struct dentry *old, struct dentry *new)
>         return error;
>  }
>
> -static int ovl_copy_up_data(struct path *old, struct path *new, loff_t len)
> +static int ovl_set_size(struct dentry *upperdentry, struct kstat *stat)
> +{
> +       struct iattr attr = {
> +               .ia_valid = ATTR_SIZE,
> +               .ia_size = stat->size,
> +       };
> +
> +       return notify_change(upperdentry, &attr, NULL);
> +}
> +
> +static int ovl_copy_up_data(struct path *old, struct path *new,
> +                           struct kstat *stat)
>  {
>         struct file *old_file;
>         struct file *new_file;
> +       loff_t len = stat->size;
>         loff_t old_pos = 0;
>         loff_t new_pos = 0;
>         loff_t cloned;
> +       loff_t old_next_data_pos;
> +       loff_t hole_len;
> +       bool seek_support = false;
> +       bool skip_hole = true;
> +       bool set_size = false;
>         int error = 0;
>
>         if (len == 0)
> @@ -144,7 +161,12 @@ static int ovl_copy_up_data(struct path *old, struct path *new, loff_t len)
>                 goto out;
>         /* Couldn't clone, so now we try to copy the data */
>
> -       /* FIXME: copy up sparse files efficiently */
> +       /* Check if lower fs supports seek operation */
> +       if (old_file->f_mode & FMODE_LSEEK &&
> +           old_file->f_op->llseek) {
> +               seek_support = true;
> +       }
> +
>         while (len) {
>                 size_t this_len = OVL_COPY_UP_CHUNK_SIZE;
>                 long bytes;
> @@ -157,6 +179,38 @@ static int ovl_copy_up_data(struct path *old, struct path *new, loff_t len)
>                         break;
>                 }
>
> +               /*
> +                * Fill zero for hole will cost unnecessary disk space
> +                * and meanwhile slow down the copy-up speed, so we do
> +                * an optimization for hole during copy-up, it relies
> +                * on SEEK_DATA implementation and the hole check is
> +                * aligned to OVL_COPY_UP_CHUNK_SIZE. In other word,
> +                * we do not try to recognize all kind of holes here,
> +                * we just skip big enough hole for simplicity to
> +                * implement. If lower fs does not support SEEK_DATA
> +                * operation, the copy-up will behave as before.
> +                */
> +
> +               if (seek_support && skip_hole) {
> +                       old_next_data_pos = vfs_llseek(old_file,
> +                                               old_pos, SEEK_DATA);
> +                       if (old_next_data_pos >= old_pos +
> +                                               OVL_COPY_UP_CHUNK_SIZE) {
> +                               hole_len = (old_next_data_pos - old_pos) /
> +                                               OVL_COPY_UP_CHUNK_SIZE *
> +                                               OVL_COPY_UP_CHUNK_SIZE;

Use round_down() helper

> +                               old_pos += hole_len;
> +                               new_pos += hole_len;
> +                               len -= hole_len;
> +                               continue;
> +                       } else if (old_next_data_pos == -ENXIO) {
> +                               set_size = true;
> +                               break;
> +                       } else if (old_next_data_pos < 0) {
> +                               skip_hole = false;

Why do you need to use 2 booleans?
You can initialize skip_hole = true only in case of lower
has seek support.

>
> +                       }
> +               }
> +
>                 bytes = do_splice_direct(old_file, &old_pos,
>                                          new_file, &new_pos,
>                                          this_len, SPLICE_F_MOVE);
> @@ -168,6 +222,12 @@ static int ovl_copy_up_data(struct path *old, struct path *new, loff_t len)
>
>                 len -= bytes;
>         }
> +
> +       if (!error && set_size) {
> +               inode_lock(new->dentry->d_inode);
> +               error = ovl_set_size(new->dentry, stat);
> +               inode_unlock(new->dentry->d_inode);
> +       }

I see no reason to repeat this code here.
Two options:
1. always set_size at the end of ovl_copy_up_inode()
    what's the harm in that?
2. set boolean c->set_size here and check it at the end
    of ovl_copy_up_inode() instead of checking c->metacopy


Thanks,
Amir.
