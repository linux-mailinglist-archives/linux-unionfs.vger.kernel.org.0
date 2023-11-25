Return-Path: <linux-unionfs+bounces-11-lists+linux-unionfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C66297F8983
	for <lists+linux-unionfs@lfdr.de>; Sat, 25 Nov 2023 10:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031061C20C4E
	for <lists+linux-unionfs@lfdr.de>; Sat, 25 Nov 2023 09:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50721BA28;
	Sat, 25 Nov 2023 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-unionfs@vger.kernel.org
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBC110D2
	for <linux-unionfs@vger.kernel.org>; Sat, 25 Nov 2023 01:21:40 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cf9db1ac0cso20404755ad.1
        for <linux-unionfs@vger.kernel.org>; Sat, 25 Nov 2023 01:21:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700904100; x=1701508900;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEGqev8W91UlLE+z9Vq14xAa3OdBqUjqhjL3kWN4G7A=;
        b=HSfZPgCrJ37rqKyiMsZk0NrT18uFf0HRH/BxXTwrjpUA+hrlTh8ZjmzSfVgzMT6GvE
         S0SPO1K1Hr7UWfytdhL9eIr+Ws4uRStkcD4oxWChIr7tnrUmkRR9QYbcaT6KPvRdVEkq
         rVTnfr85Ci3mNay48Tj4tpig6zkUCadai6UqhIWgLkaHbA/RUv0gbSnE2eQ1Tg3fzVYk
         MGYHpyNdWMtZUKo3cWjScDx4Lcx8ez/NmsSeFjQi8WevGxmmJ3uTRD3GKZYawNLaJvYC
         uijiHmwyZJlOpmxk6m1f5aSGJay+xRaDCsjqV1Tui020YLQvSpiRg9LulGD4eNlFHVzK
         v1+A==
X-Gm-Message-State: AOJu0Yx2pxUU0WmCxRZRU86LUXHrmMTMYvJZT9YEMff4W7RHd2FJXCqN
	b2HmNGPomWq5ioW/NzDZn17oT5PmmHW7k6n4K8Hliqq3sX2s
X-Google-Smtp-Source: AGHT+IGPVstb3OhDXZAiIYvNNdhtJBX1C3jCTeiOfdWwIX8+PfsQoQlSvWiiJmnGHUXmFN+KLYsjmuugDSZkVe13jMG/FM1hOsdm
Precedence: bulk
X-Mailing-List: linux-unionfs@vger.kernel.org
List-Id: <linux-unionfs.vger.kernel.org>
List-Subscribe: <mailto:linux-unionfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-unionfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:e88f:b0:1c9:c879:ee82 with SMTP id
 w15-20020a170902e88f00b001c9c879ee82mr1201359plg.11.1700904099848; Sat, 25
 Nov 2023 01:21:39 -0800 (PST)
Date: Sat, 25 Nov 2023 01:21:39 -0800
In-Reply-To: <CAOQ4uxj+enOZJiAJaCRnfb1soFS7aonJjHmLXiP3heQAFQoBqg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab2787060af698fc@google.com>
Subject: Re: [syzbot] [overlayfs?] KASAN: invalid-free in ovl_copy_up_one
From: syzbot <syzbot+477d8d8901756d1cbba1@syzkaller.appspotmail.com>
To: amir73il@gmail.com
Cc: amir73il@gmail.com, jannh@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: **

> On Fri, Nov 24, 2023 at 5:26=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
>>
>> On Fri, Nov 24, 2023 at 4:11=E2=80=AFPM Jann Horn <jannh@google.com> wro=
te:
>> >
>> > On Wed, Sep 27, 2023 at 5:10=E2=80=AFPM syzbot
>> > <syzbot+477d8d8901756d1cbba1@syzkaller.appspotmail.com> wrote:
>> > > syzbot has tested the proposed patch and the reproducer did not trig=
ger any issue:
>> > >
>> > > Reported-and-tested-by: syzbot+477d8d8901756d1cbba1@syzkaller.appspo=
tmail.com
>> > >
>> > > Tested on:
>> > >
>> > > commit:         8e9b46c4 ovl: do not encode lower fh with upper sb_w=
ri..
>> > > git tree:       https://github.com/amir73il/linux.git ovl_want_write
>> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D10d10ffa=
680000
>> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbb54ecdf=
a197f132
>> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D477d8d8901=
756d1cbba1
>> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils =
for Debian) 2.40
>> >
>> > It looks like the fix was submitted without the Reported-by tag, so
>> > syzkaller doesn't recognize that the fix has landed... I'll tell
>> > syzkaller now which commit the fix is supposed to be in, please
>> > correct me if this is wrong:
>> >
>> > #syz fix: ovl: do not encode lower fh with upper sb_writers held
>>
>> (Ah, and just for the record: I hadn't realized when writing this that
>> the fix was actually in a newer version of the same patch... "git
>
> That is correct.
> I am very thankful for syzbot with helping me catch bugs during developme=
nt
> and I would gladly attribute the bot and its owners, but I don't that
> Reported-and-tested-by is an adequate tag for a bug that never existed as
> far as git history.
>
> Even Tested-by: syzbot could be misleading to stable kernel bots
> that may conclude that the patch is a fix that needs to apply to stable.
>
> I am open to suggestions.
>
> Also maybe
>
> #syz correction:

unknown command "correction:"

>
> To tell syzbot we are not fixing a bug in upstream, but in a previous
> version of a patch that it had tested.
>
>> range-diff 44ef23e481b02df2f17599a24f81cf0045dc5256~1..44ef23e481b02df2f=
17599a24f81cf0045dc5256
>> 5b02bfc1e7e3811c5bf7f0fa626a0694d0dbbd77~1..5b02bfc1e7e3811c5bf7f0fa626a=
0694d0dbbd77"
>> shows an added "ovl_get_index_name", I guess that's the fix?)
>
> No, that added ovl_get_index_name() seems like a fluke of the range-diff =
tool.
> All the revisions of this patch always had this same minor change in this=
 line:
>
> -               err =3D ovl_get_index_name(ofs, c->lowerpath.dentry,
> &c->destname);
> +               err =3D ovl_get_index_name(ofs, origin, &c->destname);
>
> The fix is obviously in the other part of the range-diff.
>
> Thanks,
> Amir.
>
>                 if (err)
>      -                  return err;
>     -+                  goto out;
>     ++                  goto out_free_fh;
>         } else if (WARN_ON(!c->parent)) {
>                 /* Disconnected dentry must be copied up to index dir */
>      -          return -EIO;
>      +          err =3D -EIO;
>     -+          goto out;
>     ++          goto out_free_fh;
>         } else {
>                 /*
>                  * Mark parent "impure" because it may now contain non-pu=
re
>     @@ fs/overlayfs/copy_up.c: static int ovl_do_copy_up(struct
> ovl_copy_up_ctx *c)
>                 ovl_end_write(c->dentry);
>                 if (err)
>      -                  return err;
>     -+                  goto out;
>     ++                  goto out_free_fh;
>         }
>
>         /* Should we copyup with O_TMPFILE or with workdir? */
>     @@ fs/overlayfs/copy_up.c: static int ovl_do_copy_up(struct
> ovl_copy_up_ctx *c)
>       out:
>         if (to_index)
>                 kfree(c->destname.name);
>     ++out_free_fh:
>      +  kfree(fh);
>         return err;
>       }

