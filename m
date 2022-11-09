Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7192622718
	for <lists+linux-unionfs@lfdr.de>; Wed,  9 Nov 2022 10:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiKIJeH (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 9 Nov 2022 04:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiKIJeH (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 9 Nov 2022 04:34:07 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66C79FDE
        for <linux-unionfs@vger.kernel.org>; Wed,  9 Nov 2022 01:34:05 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id i3so16162867pfc.11
        for <linux-unionfs@vger.kernel.org>; Wed, 09 Nov 2022 01:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lEwGnJAQ+cerxHO4XIC8lQuy3ljyScuAFuIc9fBasKk=;
        b=OW/3BZZ2f8nqlQiFzQw5CjaOzrd4LlVzxnIYHbXWLeU3y+mAquMEPSCfgGOHW7oBS+
         0tHJ8XsmdNQszWA2syBQJR5i0QcMCuxSBAwhpIPxJoq+L9GRB3cB+kLiVZTQZtpdZvpE
         X/SDyulosqt7dPsjgKZjtnaV201Jy1O6BUYqLsvZyEdNYIjeIdYuW0WdsH+lv2UvBBd9
         FdgdTMOXop+vEYs9bDq++2TXp05q88H61tOIVpUgH0CcBrnhdgzL4J0t9aC1HaNhefdR
         8GVd6CECqWtQe7WUAhDuV36TcA8NrXhukqMAmrNu0JXQGM+GRCLuxeTGnJ8p4X3pPFZE
         KeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEwGnJAQ+cerxHO4XIC8lQuy3ljyScuAFuIc9fBasKk=;
        b=q8FPKX8CWZQA4vQtGCs3vws5IFC+VmnepoL6k8HEeiObZiiCT4WVkS332Xgf5Fslmh
         diWnoUEJAOwYeAjm2kBfcbaxYD28PhWe60XLuceFjgQ8BVNYlmqkW7f8SMZ6tukPwK8F
         WiqIFgQNIDp11k4zrc4958UOh1Mh9qMaizHECZ/pACjislDrCDI20VLXvcs6A2p3Boev
         jdcUpTKhRqhuShM6PkD4VUkM2qcxXdgZyFjtdUjejvF6N71UEO9XTHMWyjY+mdoASqQw
         N8QDZHQ89wQdiVYQoSxkzS42NnoWMLIhT6fgG50VUqX5GdFO/uU+Lq2K9ej+08zweX6E
         GfpA==
X-Gm-Message-State: ACrzQf2FE34QlYbWdjIhBV100TrURFGjcsOpxAKrMoDuP0h3t+X/xqE8
        dZ+SR6aQdG6zY4ul2og5px7fPeuzxiw=
X-Google-Smtp-Source: AMsMyM4Qn4WZm2CvA8QSwgkow6vk6X9zB4VqY+cEjEGXxZSEsGHuDTPAVfRMbcYO3n4vHyUgkJgf1w==
X-Received: by 2002:a63:235c:0:b0:459:5fef:88ab with SMTP id u28-20020a63235c000000b004595fef88abmr52169274pgm.312.1667986444902;
        Wed, 09 Nov 2022 01:34:04 -0800 (PST)
Received: from ubuntu ([210.99.119.32])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b00187022627d7sm8516872plb.36.2022.11.09.01.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 01:34:04 -0800 (PST)
Date:   Wed, 9 Nov 2022 01:34:00 -0800
From:   "YoungJun.Park" <her0gyugyu@gmail.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-unionfs@vger.kernel.org
Subject: Re: Re: Question about ESTALE error whene deleting upper directory
 file.
Message-ID: <20221109093400.GA79512@ubuntu>
References: <20221107042932.GB1843153@ubuntu>
 <CAOQ4uxipsS3Xf00fvY4fEBgJX8MZK2VW8sHANLA6h8qoEeAiCA@mail.gmail.com>
 <20221107070621.GA1860348@ubuntu>
 <CAOQ4uxg6ZsWKqgRBTxfXkfYP0xpf7CvpYsc7aj_1SgvDGYLjJA@mail.gmail.com>
 <20221108081408.GA16209@ubuntu>
 <CAOQ4uxi2aGUOCrPb55Q9LGVbqz4M9ZKOhNLnm8kKnsDQgdxYHQ@mail.gmail.com>
 <20221108123734.GA19150@ubuntu>
 <CAOQ4uxhGCwXuaOVi3RLT5iPi+xB=TZG76k4Jx34TTd6OUvJrQg@mail.gmail.com>
 <20221109041610.GA27974@ubuntu>
 <CAOQ4uxjxv-hP_SnTROETzdZ1nh6qH=HQXozftzK+8VRVysxRiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjxv-hP_SnTROETzdZ1nh6qH=HQXozftzK+8VRVysxRiQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Wed, Nov 09, 2022 at 11:16:23AM +0200, Amir Goldstein wrote:
> On Wed, Nov 9, 2022 at 6:16 AM YoungJun.Park <her0gyugyu@gmail.com> wrote:
> >
> > On Tue, Nov 08, 2022 at 09:22:38PM +0200, Amir Goldstein wrote:
> > > On Tue, Nov 8, 2022 at 2:37 PM YoungJun.Park <her0gyugyu@gmail.com> wrote:
> > > >
> > > > On Tue, Nov 08, 2022 at 11:22:14AM +0200, Amir Goldstein wrote:
> > > > > On Tue, Nov 8, 2022, 10:14 AM YoungJun.Park <her0gyugyu@gmail.com> wrote:
> > > > >
> > > > > > On Mon, Nov 07, 2022 at 10:49:57AM +0200, Amir Goldstein wrote:
> > > > > > > On Mon, Nov 7, 2022 at 9:06 AM YoungJun.Park <her0gyugyu@gmail.com>
> > > > > > wrote:
> > > > > > > >
> > > > > > > > On Mon, Nov 07, 2022 at 08:40:02AM +0200, Amir Goldstein wrote:
> > > > > > > > > On Mon, Nov 7, 2022 at 6:38 AM YoungJun.Park <her0gyugyu@gmail.com>
> > > > > > wrote:
> > > > > > > > > >
> > > > > > > > > > Here is my curious scenario.
> > > > > > > > > >
> > > > > > > > > > 1. create a file on overlayfs.
> > > > > > > > > > 2. delete a file on upper directory.
> > > > > > > > > > 3. can see file contents using read sys call. (may file operations
> > > > > > all success)
> > > > > > > > > > 4. cannot remove, rename. it return -ESTALE error (may inode
> > > > > > operations fail)
> > > > > > > > > >
> > > > > > > > > > I understand this scenario onto the code level.
> > > > > > > > > > But I don't understand this situation itself.
> > > > > > > > > >
> > > > > > > > > > I found a overlay kernel docs and it comments
> > > > > > > > > > Changes to underlying filesystems section
> > > > > > > > > >
> > > > > > > > > > ...
> > > > > > > > > > Changes to the underlying filesystems while part of a mounted
> > > > > > overlay filesystem are not allowed.
> > > > > > > > > > If the underlying filesystem is changed, the behavior of the
> > > > > > overlay is undefined,
> > > > > > > > > > though it will not result in a crash or deadlock.
> > > > > > > > > > ....
> > > > > > > > > >
> > > > > > > > > > So here is my question (may it is suggestion)
> > > > > > > > > >
> > > > > > > > > > 1. underlying file system change is not allowed, then how about
> > > > > > implementing shadow upper directory from user?
> > > > > > > > > > 2. if read, write system call is allowed, how about changing
> > > > > > remove, rename(and more I does not percept) operation success?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > What is your use case?
> > > > > > > > > Why do you think this is worth spending time on?
> > > > > > > > > If anything, we could implement revalidate to return ESTALE also
> > > > > > from open
> > > > > > > > > in such a case.
> > > > > > > > > But again, why do you think that would matter?
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Amir.
> > > > > > > >
> > > > > > > > Thank you for replying.
> > > > > > > > I develop antivirus scanner.
> > > > > > > > When developing, I am confronted the situaion below.
> > > > > > > >
> > > > > > > > 1. make a docker container using overlayfs
> > > > > > > > 2. our antivirus scanner detect on upperdir and remove it.
> > > > > > > > 3. When I check container, the file contents can be read, buf file
> > > > > > cannot be removed.(-ESTALE error)
> > > > > > > >
> > > > > > > > And as I think, the reason is upperdir is touchable. So it is better
> > > > > > to hide upperdir.
> > > > > > > > If it is hard to implement(or maybe there is a other reson that I don'
> > > > > > know)
> > > > > > > > it is better to make the situation is clear
> > > > > > > > (file operation error, inode operations error or file operation
> > > > > > success , inode operation success)
> > > > > > > >
> > > > > > >
> > > > > > > Error on read is not an option because reading from an open and deleted
> > > > > > > file is perfectly valid even without overlayfs.
> > > > > > >
> > > > > > > ESTALE error on open is doable and makes sense and I believe it may
> > > > > > > be sufficient for your use case.
> > > > > > >
> > > > > > > I have an old branch that implements that behavior:
> > > > > > > https://github.com/amir73il/linux/commits/ovl-revalidate
> > > > > > >
> > > > > > > You can try it out and see if that works for you.
> > > > > > > If it does, I can post the patches.
> > > > > > >
> > > > > > > Note that the use case that you described does not need the last patch,
> > > > > > > but if the anti-virus would have moved a lower file to quarantine
> > > > > > > instead of deleting it, the last patch would also be useful for you.
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Amir.
> > > > > >
> > > > > > After applying the branch, I tested the scenario.
> > > > > > But it does not work. file open is success on overlayfs filesystem.
> > > > > >
> > > > > > In my scnario, the dentry is not negative and just unhashed on upper.
> > > > > >
> > > > >
> > > > > Yeh my bad.
> > > > > I also noticed that after I sent you the link.
> > > > > I think my patch also has a memleak somewhere I seen kmemleak reports
> > > > > during testing.
> > > > >
> > > > > If we check dentry is unhashed we properly block open on my scenario.
> > > > > > I write the patch and tested it working.
> > > > > > (Maybe I does not catch your point, if you give a guide then I follow it)
> > > > > >
> > > > >
> > > > > Please place the unhashed check inside ovl_revalidate_real() same as my
> > > > > checks for negative upper and renamed lower dentry.
> > > > >
> > > > > The dentry should only be considered stale if the real dentry is unhashed
> > > > > but ovl entry is hashed.
> > > > >
> > > > > The state of both ovl dentry and real dentry unhashed is possible and valid
> > > > > I think, but it should not interfere with your use case where ovl dentry is
> > > > > hashed and real upper is unhashed.
> > > > >
> > > > > I may be missing something so better if Miklos also takes a look at the
> > > > > patch.
> > > > >
> > > > > Thanks,
> > > > > Amir.
> > > > >
> > > > >
> > > > > > Signed-off-by: YoungJun.park <her0gyugyu@gmail.com>
> > > > > > ---
> > > > > >  fs/overlayfs/file.c | 4 ++++
> > > > > >  1 file changed, 4 insertions(+)
> > > > > >
> > > > > > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > > > > > index 6512d147c223..629dbcc49070 100644
> > > > > > --- a/fs/overlayfs/file.c
> > > > > > +++ b/fs/overlayfs/file.c
> > > > > > @@ -157,6 +157,10 @@ static int ovl_open(struct inode *inode, struct file
> > > > > > *file)
> > > > > >     file->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
> > > > > >
> > > > > >     ovl_path_realdata(dentry, &realpath);
> > > > > > +
> > > > > > +    if (d_unhashed(realpath.dentry))
> > > > > > +        return -ESTALE;
> > > > > > +
> > > > > >     realfile = ovl_open_realfile(file, &realpath);
> > > > > >     if (IS_ERR(realfile))
> > > > > >         return PTR_ERR(realfile);
> > > > > > --
> > > > > > 2.25.1
> > > > > >
> > > > > > And I have one more question.
> > > > > > Why upper dir must be visible..?
> > > > > > The reson I think making upper dir unvisible is like the below.
> > > > > > 1. If making a upperdir is unvisible, then these kind of problem disappear.
> > > > > > 2. upperdir visibility makes a passage to convey container's file to
> > > > > > hostland.
> > > > > > (in view of container using overlayfs)
> > > > > > making unvisible remove this kind of problem.
> > > > > > 3. Changing upper dir scenario makes undefined behavior. So, if removing
> > > > > > the interface
> > > > > > user can access, then we can make the undefined scenario itself.
> > > > > >
> > > > > > Thanks Amir.
> > > > > > Best regards
> > > > > >
> > > >
> > > > Thank you for kind guidance Amir.
> > > > Before I will do next step, I want to recheck your point Amir :)
> > > >
> > > > 1.
> > > > > Please place the unhashed check inside ovl_revalidate_real() same as my
> > > > > checks for negative upper and renamed lower dentry.
> > > >
> > > > You mean I modify your commit? It is from your branch then
> > > > How I fix it...? (Am I misunderstood somthing?)
> > > > here is pseudo patch.
> > >
> > > My branch is just a POC.
> > > If you test it and say that it is useful for you I can post it
> > > and add your use case as the motivation.
> > >
> > > >
> > > > invalidate dentry if dentry is unhashed
> > > >
> > > > Signed-off-by: YoungJun.park <her0gyugyu@gmail.com>
> > > > ---
> > > >  fs/overlayfs/super.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > > > index 6a4f2b87f1a3..411d3ed8aec1 100644
> > > > --- a/fs/overlayfs/super.c
> > > > +++ b/fs/overlayfs/super.c
> > > > @@ -129,8 +129,8 @@ static int ovl_revalidate_real(struct dentry *d, unsigned int flags, bool weak,
> > > >  {
> > > >     int ret = 1;
> > > >
> > > > -   /* Invalidate dentry if real was deleted/renamed since we found it */
> > > > -   if (ovl_dentry_is_dead(d) || (hash && hash != d->d_name.hash_len)) {
> > > > +   /* Invalidate dentry if real was deleted/renamed/unhashed since we found it */
> > > > +   if (ovl_dentry_is_dead(d) || (hash && hash != d->d_name.hash_len) || d_unhashed(d)) {
> > > >         ret = 0;
> > > >     } else if (weak) {
> > > >         if (d->d_flags & DCACHE_OP_WEAK_REVALIDATE)
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > That won't be enough and is also not accurate.
> > > I pushed another patch to branch ovl-revalidate and also
> > > tested that your use case works as expected when
> > > deleting either upper or lower non-dir files.
> > >
> > > The patch adds this functionality unconditionally for non-dir,
> > > but it may be required to use some mount option to enable it.
> > > It is up to Miklos to decide.
> 
> FYI, I changed the patch to enable this functionality based
> on new features.
> 
> So if you pull the POC branch, to enable the strict checks you
> need to enable either redirect_dir or metacopy, i.e.:
> 
> echo Y > /sys/module/overlay/parameters/redirect_dir
> echo Y > /sys/module/overlay/parameters/metacopy
> 
> at runtime or
> 
> CONFIG_OVERLAY_FS_REDIRECT_DIR=Y
> CONFIG_OVERLAY_FS_METACOPY=Y
> 
> at build time.
> 
> > >
> > > > 2.
> > > >
> > > > > The dentry should only be considered stale if the real dentry is unhashed
> > > > > but ovl entry is hashed.
> > > > >
> > > > > The state of both ovl dentry and real dentry unhashed is possible and valid
> > > > > I think, but it should not interfere with your use case where ovl dentry is
> > > > > hashed and real upper is unhashed.
> > > > >
> > > > > I may be missing something so better if Miklos also takes a look at the
> > > > > patch.
> > > > >
> > > >
> > > > You mean, if I modify the code you said, then the patch I sent works properly? (file open fail)
> > > > If you mean it, then I post my patch :)
> > > >
> > >
> > > Please test the patch that I pushed to branch ovl-revalidate.
> > >
> > > > And the last question, I really curious "hide upperdir from user" idea. If it is meaningful
> > > > I want to try to implement it, If it isn't then could you explain why this idea is not meaningful..?
> > > >
> > >
> > > It is not meaningful, it is not relevant.
> > > There is no way to hide a directory.
> > > You can bind mount an empty dir over it in one mount namespace
> > > but in other mount namespaces or other bind mounts that dir will be visible.
> > >
> > > Thanks,
> > > Amir.
> >
> > Thank you Amir
> > I tested the branch and check the -ENOENT is returned on open time in my use case.
> > And I have one more suggestion, it is would be better on upper file rename case to be covered as well.
> > The idea is pre query dentry hash on ovl_inode initialization time.
> > If it is acceptable, then consider to apply this idea.
> > here is my patch.
> 
> This patch is wrong.
> Renaming a file from overlay (not directly from upper dir) will also result in
> error trying to access the renamed file.
> 
> See my commit message on lower renames:
> 
> "We do not provide this protection for upper dentries, because that would
> require updating the hash on overlay initiated renames and that is harder
> to implement with lockless lookup."
> 
> Detecting renames in upper dir is doable, but it is more complicated.
> 
> >
> > Signed-off-by: YoungJun.park <her0gyugyu@gmail.com>
> > ---
> >  fs/overlayfs/inode.c     | 4 +++-
> >  fs/overlayfs/ovl_entry.h | 1 +
> >  fs/overlayfs/super.c     | 2 +-
> >  3 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> > index 9e61511de7a7..efed51608033 100644
> > --- a/fs/overlayfs/inode.c
> > +++ b/fs/overlayfs/inode.c
> > @@ -862,8 +862,10 @@ void ovl_inode_init(struct inode *inode, struct ovl_inode_params *oip,
> >     struct inode *realinode;
> >     struct ovl_inode *oi = OVL_I(inode);
> >
> > -   if (oip->upperdentry)
> > +   if (oip->upperdentry) {
> >         oi->__upperdentry = oip->upperdentry;
> > +       oi->upper_hash = oip->upperdentry->d_name.hash_len;
> > +   }
> >     if (oip->lowerpath && oip->lowerpath->dentry) {
> >         oi->lowerpath.dentry = dget(oip->lowerpath->dentry);
> >         oi->lowerpath.layer = oip->lowerpath->layer;
> > diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> > index b83db8b6a31c..5a11f0a83436 100644
> > --- a/fs/overlayfs/ovl_entry.h
> > +++ b/fs/overlayfs/ovl_entry.h
> > @@ -135,6 +135,7 @@ struct ovl_inode {
> >     u64 version;
> >     unsigned long flags;
> >     struct inode vfs_inode;
> > +   u64 upper_hash;
> >     struct dentry *__upperdentry;
> >     struct ovl_path lowerpath;
> >
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index 59d5e3147a50..d84e34515d7c 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -172,7 +172,7 @@ static int ovl_dentry_revalidate_common(struct dentry *dentry,
> >
> >     upper = ovl_dentry_upper(dentry);
> >     if (upper)
> > -       ret = ovl_revalidate_real(upper, flags, weak, 0);
> > +       ret = ovl_revalidate_real(upper, flags, weak, OVL_I(d_inode(upper))->upper_hash);
> >
> >     for (i = 0; ret > 0 && i < oe->numlower; i++, lower++) {
> >         ret = ovl_revalidate_real(lower->dentry, flags, weak,
> > --
> > 2.25.1
> >
> > > It is not meaningful, it is not relevant.
> > > There is no way to hide a directory.
> > > You can bind mount an empty dir over it in one mount namespace
> > > but in other mount namespaces or other bind mounts that dir will be visible.
> >
> > And this comment
> > Um, As I think, I don't know advantage of upperdir reachable (or writable)
> > So, I think hide of upperdir from user can make this situation does not happen.
> > And there is other way to make upperdir readable or semi hide state from user(as you say)
> > but it is not forcefully applied by overlayfs and user has a responsibility of doing that.
> > (many user does not care and know well this features)
> > I think hiding upperdir, making upperdir readable forcefully and any idea of blocking touchable
> > upperdir can make overlayfs happy.
> >
> 
> I don't know how to explain why this is not doable.
> 
> I have another POC
> https://github.com/amir73il/linux/commits/ovl-watch
> 
> Where overlayfs uses fsnotify to monitor changes to upper/lower dirs.
> This could be used to deny direct changes to upper/lower dirs,
> but there are many subtle details and I am not pursuing this POC
> at the moment.
> 
> Thanks,
> Amir.

I clearly understand the things you explain :)

Thanks.
YoungJun.
