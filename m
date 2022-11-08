Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D147C6210EC
	for <lists+linux-unionfs@lfdr.de>; Tue,  8 Nov 2022 13:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiKHMhu (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Tue, 8 Nov 2022 07:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbiKHMhs (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Tue, 8 Nov 2022 07:37:48 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB0B17E00
        for <linux-unionfs@vger.kernel.org>; Tue,  8 Nov 2022 04:37:39 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o7so13685537pjj.1
        for <linux-unionfs@vger.kernel.org>; Tue, 08 Nov 2022 04:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B3sB+qVfLojHVWM3soPBniMM1fI3pvhQYZP//vt8IE0=;
        b=l5zUJuWQES+UbFyHQ8iebVdggbTziWcGQXCo9ftUfzf3It2FmtapKvaoUZUG9acjn9
         FC/P8jKYO2gbd/6UZDOOWcxUyuW36KYgp1pGQsb83EWLZnZilncahn2Ol5BCbGwrDxMZ
         L1wZARcVa1TptH8UHYlPYWPtUfVJmPkWYBthVT/aac9WZgFiC/g1e77r7dGi6jo1MR0I
         BBkv+lQPk8FWqt5X51po2JNI7tKRUxhPph2Rlr3avqT8mJCgoWZ5f1PVggdindGL+kwO
         CbHVpqcWCQAdImpzPIADXMbPVhY8qUWIBqJ4q49V3YgOmzCrHSNtXKLu4LNdOxpDfai4
         rJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3sB+qVfLojHVWM3soPBniMM1fI3pvhQYZP//vt8IE0=;
        b=wtzfeJs/YTo5PRzCmm4a+CQwqdcLw2nLq5MethZNvg2c5NiXOSQ12JkMQ6EC+qJ3E+
         gBM5RkS2hzZTLamW8V3JBC5DFxeB8qsv21RnvsBHeEHUoi+sg4h37Zh6invRyUDo7RKD
         b/0ISjswQUh62WbAqVZ5UnOswyU/WaESD4JVWz7WP2bSKcje8vTG7kB2AY5Jfn641/Yy
         QpesLToWnsn0KIQUuZGAdTrIgCJSLCBKoDyJtwPCjCGREH3WQ5gR5kLnzSl/8faLt6S+
         HcaGJOMlmCbV7kvJ65c8vajSfAjX3/S6R9HQs4E0k+iShaPD8EAjbRpRfwC6/2trlU2R
         4ZTg==
X-Gm-Message-State: ACrzQf2Tiv+Ga9cLsCuAj42f8d1IoY9+rpL1N62wFVlpnd1SnCqfB7NL
        r3SYjTq1zHq3HUu3YmQCGoVLLSl634Q=
X-Google-Smtp-Source: AMsMyM4T3e4mJRrbf3OlLbmWWYykhVurwTYU961eGwcEdHgFPJbPX5JaZXrhjYRx3sgSq4tmZuPazg==
X-Received: by 2002:a17:902:ed53:b0:186:6ad3:c155 with SMTP id y19-20020a170902ed5300b001866ad3c155mr54663694plb.43.1667911058992;
        Tue, 08 Nov 2022 04:37:38 -0800 (PST)
Received: from ubuntu ([210.99.119.32])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b0017808db132bsm6804321pln.137.2022.11.08.04.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 04:37:38 -0800 (PST)
Date:   Tue, 8 Nov 2022 04:37:34 -0800
From:   "YoungJun.Park" <her0gyugyu@gmail.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-unionfs@vger.kernel.org
Subject: Re: Re: Question about ESTALE error whene deleting upper directory
 file.
Message-ID: <20221108123734.GA19150@ubuntu>
References: <20221107042932.GB1843153@ubuntu>
 <CAOQ4uxipsS3Xf00fvY4fEBgJX8MZK2VW8sHANLA6h8qoEeAiCA@mail.gmail.com>
 <20221107070621.GA1860348@ubuntu>
 <CAOQ4uxg6ZsWKqgRBTxfXkfYP0xpf7CvpYsc7aj_1SgvDGYLjJA@mail.gmail.com>
 <20221108081408.GA16209@ubuntu>
 <CAOQ4uxi2aGUOCrPb55Q9LGVbqz4M9ZKOhNLnm8kKnsDQgdxYHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi2aGUOCrPb55Q9LGVbqz4M9ZKOhNLnm8kKnsDQgdxYHQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Tue, Nov 08, 2022 at 11:22:14AM +0200, Amir Goldstein wrote:
> On Tue, Nov 8, 2022, 10:14 AM YoungJun.Park <her0gyugyu@gmail.com> wrote:
> 
> > On Mon, Nov 07, 2022 at 10:49:57AM +0200, Amir Goldstein wrote:
> > > On Mon, Nov 7, 2022 at 9:06 AM YoungJun.Park <her0gyugyu@gmail.com>
> > wrote:
> > > >
> > > > On Mon, Nov 07, 2022 at 08:40:02AM +0200, Amir Goldstein wrote:
> > > > > On Mon, Nov 7, 2022 at 6:38 AM YoungJun.Park <her0gyugyu@gmail.com>
> > wrote:
> > > > > >
> > > > > > Here is my curious scenario.
> > > > > >
> > > > > > 1. create a file on overlayfs.
> > > > > > 2. delete a file on upper directory.
> > > > > > 3. can see file contents using read sys call. (may file operations
> > all success)
> > > > > > 4. cannot remove, rename. it return -ESTALE error (may inode
> > operations fail)
> > > > > >
> > > > > > I understand this scenario onto the code level.
> > > > > > But I don't understand this situation itself.
> > > > > >
> > > > > > I found a overlay kernel docs and it comments
> > > > > > Changes to underlying filesystems section
> > > > > >
> > > > > > ...
> > > > > > Changes to the underlying filesystems while part of a mounted
> > overlay filesystem are not allowed.
> > > > > > If the underlying filesystem is changed, the behavior of the
> > overlay is undefined,
> > > > > > though it will not result in a crash or deadlock.
> > > > > > ....
> > > > > >
> > > > > > So here is my question (may it is suggestion)
> > > > > >
> > > > > > 1. underlying file system change is not allowed, then how about
> > implementing shadow upper directory from user?
> > > > > > 2. if read, write system call is allowed, how about changing
> > remove, rename(and more I does not percept) operation success?
> > > > > >
> > > > >
> > > > > What is your use case?
> > > > > Why do you think this is worth spending time on?
> > > > > If anything, we could implement revalidate to return ESTALE also
> > from open
> > > > > in such a case.
> > > > > But again, why do you think that would matter?
> > > > >
> > > > > Thanks,
> > > > > Amir.
> > > >
> > > > Thank you for replying.
> > > > I develop antivirus scanner.
> > > > When developing, I am confronted the situaion below.
> > > >
> > > > 1. make a docker container using overlayfs
> > > > 2. our antivirus scanner detect on upperdir and remove it.
> > > > 3. When I check container, the file contents can be read, buf file
> > cannot be removed.(-ESTALE error)
> > > >
> > > > And as I think, the reason is upperdir is touchable. So it is better
> > to hide upperdir.
> > > > If it is hard to implement(or maybe there is a other reson that I don'
> > know)
> > > > it is better to make the situation is clear
> > > > (file operation error, inode operations error or file operation
> > success , inode operation success)
> > > >
> > >
> > > Error on read is not an option because reading from an open and deleted
> > > file is perfectly valid even without overlayfs.
> > >
> > > ESTALE error on open is doable and makes sense and I believe it may
> > > be sufficient for your use case.
> > >
> > > I have an old branch that implements that behavior:
> > > https://github.com/amir73il/linux/commits/ovl-revalidate
> > >
> > > You can try it out and see if that works for you.
> > > If it does, I can post the patches.
> > >
> > > Note that the use case that you described does not need the last patch,
> > > but if the anti-virus would have moved a lower file to quarantine
> > > instead of deleting it, the last patch would also be useful for you.
> > >
> > > Thanks,
> > > Amir.
> >
> > After applying the branch, I tested the scenario.
> > But it does not work. file open is success on overlayfs filesystem.
> >
> > In my scnario, the dentry is not negative and just unhashed on upper.
> >
> 
> Yeh my bad.
> I also noticed that after I sent you the link.
> I think my patch also has a memleak somewhere I seen kmemleak reports
> during testing.
> 
> If we check dentry is unhashed we properly block open on my scenario.
> > I write the patch and tested it working.
> > (Maybe I does not catch your point, if you give a guide then I follow it)
> >
> 
> Please place the unhashed check inside ovl_revalidate_real() same as my
> checks for negative upper and renamed lower dentry.
> 
> The dentry should only be considered stale if the real dentry is unhashed
> but ovl entry is hashed.
> 
> The state of both ovl dentry and real dentry unhashed is possible and valid
> I think, but it should not interfere with your use case where ovl dentry is
> hashed and real upper is unhashed.
> 
> I may be missing something so better if Miklos also takes a look at the
> patch.
> 
> Thanks,
> Amir.
> 
> 
> > Signed-off-by: YoungJun.park <her0gyugyu@gmail.com>
> > ---
> >  fs/overlayfs/file.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > index 6512d147c223..629dbcc49070 100644
> > --- a/fs/overlayfs/file.c
> > +++ b/fs/overlayfs/file.c
> > @@ -157,6 +157,10 @@ static int ovl_open(struct inode *inode, struct file
> > *file)
> >     file->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
> >
> >     ovl_path_realdata(dentry, &realpath);
> > +
> > +    if (d_unhashed(realpath.dentry))
> > +        return -ESTALE;
> > +
> >     realfile = ovl_open_realfile(file, &realpath);
> >     if (IS_ERR(realfile))
> >         return PTR_ERR(realfile);
> > --
> > 2.25.1
> >
> > And I have one more question.
> > Why upper dir must be visible..?
> > The reson I think making upper dir unvisible is like the below.
> > 1. If making a upperdir is unvisible, then these kind of problem disappear.
> > 2. upperdir visibility makes a passage to convey container's file to
> > hostland.
> > (in view of container using overlayfs)
> > making unvisible remove this kind of problem.
> > 3. Changing upper dir scenario makes undefined behavior. So, if removing
> > the interface
> > user can access, then we can make the undefined scenario itself.
> >
> > Thanks Amir.
> > Best regards
> >

Thank you for kind guidance Amir.
Before I will do next step, I want to recheck your point Amir :)

1.
> Please place the unhashed check inside ovl_revalidate_real() same as my
> checks for negative upper and renamed lower dentry.

You mean I modify your commit? It is from your branch then 
How I fix it...? (Am I misunderstood somthing?)
here is pseudo patch.

invalidate dentry if dentry is unhashed

Signed-off-by: YoungJun.park <her0gyugyu@gmail.com>
---
 fs/overlayfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 6a4f2b87f1a3..411d3ed8aec1 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -129,8 +129,8 @@ static int ovl_revalidate_real(struct dentry *d, unsigned int flags, bool weak,
 {
    int ret = 1;

-   /* Invalidate dentry if real was deleted/renamed since we found it */
-   if (ovl_dentry_is_dead(d) || (hash && hash != d->d_name.hash_len)) {
+   /* Invalidate dentry if real was deleted/renamed/unhashed since we found it */
+   if (ovl_dentry_is_dead(d) || (hash && hash != d->d_name.hash_len) || d_unhashed(d)) {
        ret = 0;
    } else if (weak) {
        if (d->d_flags & DCACHE_OP_WEAK_REVALIDATE)
--
2.25.1

2. 

> The dentry should only be considered stale if the real dentry is unhashed
> but ovl entry is hashed.
> 
> The state of both ovl dentry and real dentry unhashed is possible and valid
> I think, but it should not interfere with your use case where ovl dentry is
> hashed and real upper is unhashed.
> 
> I may be missing something so better if Miklos also takes a look at the
> patch.
>

You mean, if I modify the code you said, then the patch I sent works properly? (file open fail)
If you mean it, then I post my patch :)

And the last question, I really curious "hide upperdir from user" idea. If it is meaningful
I want to try to implement it, If it isn't then could you explain why this idea is not meaningful..?

Thanks Amir.
