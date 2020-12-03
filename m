Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8899C2CE0F0
	for <lists+linux-unionfs@lfdr.de>; Thu,  3 Dec 2020 22:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbgLCViS (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 3 Dec 2020 16:38:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48483 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728699AbgLCViS (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 3 Dec 2020 16:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607031410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LwOHvgjb+ITVNYkNWTpLoaczfL7kyuQfJ6OKSE/LlI4=;
        b=WCa+sh7RqOBS/JkiBsGAAyRdxA3IMRVhHulH9bl/fkBhTluVIP4sPLYHHcfjPD8N5g5fhw
        u1YuLjTdTpvucg+NBjBcJtOCliSYzK+h7NGqtyXg+vXjNgHMym5JfJRo2MoXs1R+I8Opbu
        bfL7jiXUC0+k/0fDX9KBn+PDv8fPPFo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-eOksmNmyNlOBGxS94L0-0Q-1; Thu, 03 Dec 2020 16:36:48 -0500
X-MC-Unique: eOksmNmyNlOBGxS94L0-0Q-1
Received: by mail-qt1-f198.google.com with SMTP id x62so2698954qtd.11
        for <linux-unionfs@vger.kernel.org>; Thu, 03 Dec 2020 13:36:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=LwOHvgjb+ITVNYkNWTpLoaczfL7kyuQfJ6OKSE/LlI4=;
        b=EmNeiIh2Ic04y5fb+MUKkRojJF/1Xk0LVxl6lsjWZnFdHtNrsPqu3YmpNkFhaMF+hx
         Sz0Fjbqe5uX2NOw37jKnW5tB2f6h+T2b8qEL3ii2loov54iYG7GCEMEUIeSUscVv/E/Q
         aaj+5Oh3cl29KhkLA5IlI89YaWWhy2C9yuszh+lH+RLGuD5zY8XrVIAiKbf2VvuSHsf0
         SfUWv+DF2djkyjq5R4MkAiLN2IUJp8sf7b9ooIcDEb4yR9OT422yC8IJ8LWPgdSpmi1f
         oyIVYRw/MfvzqIv21jqUGj9rpOEKri0esQlXDWS439qeKjkWXfEJPIsNVLgwdR1Njyqf
         /PnA==
X-Gm-Message-State: AOAM5338jbYtvw3LUe3/zvAiqpIpstf6JToqszCKeUotskMQqH8L1nvm
        +UszsLVPKFzV5HK4wVLVqmbSPYVZ6sPE8XkQGi5Sfx6TqWkj+GU0aDnmCTjfNSKrt8ltsS0jHT8
        3lk1C28gSkJBVpe63vTEnSmncng==
X-Received: by 2002:ac8:7083:: with SMTP id y3mr5401444qto.267.1607031407733;
        Thu, 03 Dec 2020 13:36:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgp8CGkwggBHqWGsUgvFzgI5n80cnMqjJji9DhrnmrxcNmfmEy61JAYjzZsD0cyW3vJMjy+A==
X-Received: by 2002:ac8:7083:: with SMTP id y3mr5401417qto.267.1607031407385;
        Thu, 03 Dec 2020 13:36:47 -0800 (PST)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id b3sm2380382qte.85.2020.12.03.13.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:36:46 -0800 (PST)
Message-ID: <b38de55c91ecd7b1102c62cb36e81bb156748d1c.camel@redhat.com>
Subject: Re: [PATCH] overlay: Implement volatile-specific fsync error
 behaviour
From:   Jeff Layton <jlayton@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Amir Goldstein <amir73il@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>
Date:   Thu, 03 Dec 2020 16:36:45 -0500
In-Reply-To: <20201203204356.GF3266@redhat.com>
References: <59de2220a85e858a4c397969e2a0d03f1d653a6a.camel@redhat.com>
         <20201202185601.GF147783@redhat.com>
         <0a3979479ffbf080fa1cd492923a7fa8984078b9.camel@redhat.com>
         <20201202213434.GA4070@redhat.com>
         <2e08895bf0650513d7d12e66965eec611f361be3.camel@redhat.com>
         <20201203104225.GA30173@ircssh-2.c.rugged-nimbus-611.internal>
         <20201203142712.GA3266@redhat.com>
         <93894cddefff0118d8b1f5f69816da519cb0a735.camel@redhat.com>
         <CAMp4zn_Mn8khp43XvNbAPg5qzriRY6ozdB2enMOTYRLwcBf_Cw@mail.gmail.com>
         <e5534c44661a503102cd23965a85291f0dec907a.camel@redhat.com>
         <20201203204356.GF3266@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, 2020-12-03 at 15:43 -0500, Vivek Goyal wrote:
> On Thu, Dec 03, 2020 at 12:50:58PM -0500, Jeff Layton wrote:
> > On Thu, 2020-12-03 at 09:08 -0800, Sargun Dhillon wrote:
> > > On Thu, Dec 3, 2020 at 7:20 AM Jeff Layton <jlayton@redhat.com> wrote:
> > > > 
> > > > On Thu, 2020-12-03 at 09:27 -0500, Vivek Goyal wrote:
> > > > > On Thu, Dec 03, 2020 at 10:42:26AM +0000, Sargun Dhillon wrote:
> > > > > > On Wed, Dec 02, 2020 at 04:52:33PM -0500, Jeff Layton wrote:
> > > > > > > On Wed, 2020-12-02 at 16:34 -0500, Vivek Goyal wrote:
> > > > > > > > On Wed, Dec 02, 2020 at 02:26:23PM -0500, Jeff Layton wrote:
> > > > > > > > [..]
> > > > > > > > > > > > > > > +         upper_mnt_sb = ovl_upper_mnt(ofs)->mnt_sb;
> > > > > > > > > > > > > > > +         sb->s_stack_depth = upper_mnt_sb->s_stack_depth;
> > > > > > > > > > > > > > > +         sb->s_time_gran = upper_mnt_sb->s_time_gran;
> > > > > > > > > > > > > > > +         ofs->upper_errseq = errseq_sample(&upper_mnt_sb->s_wb_err);
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > I asked this question in last email as well. errseq_sample() will return
> > > > > > > > > > > > > > 0 if current error has not been seen yet. That means next time a sync
> > > > > > > > > > > > > > call comes for volatile mount, it will return an error. But that's
> > > > > > > > > > > > > > not what we want. When we mounted a volatile overlay, if there is an
> > > > > > > > > > > > > > existing error (seen/unseen), we don't care. We only care if there
> > > > > > > > > > > > > > is a new error after the volatile mount, right?
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > I guess we will need another helper similar to errseq_smaple() which
> > > > > > > > > > > > > > just returns existing value of errseq. And then we will have to
> > > > > > > > > > > > > > do something about errseq_check() to not return an error if "since"
> > > > > > > > > > > > > > and "eseq" differ only by "seen" bit.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > Otherwise in current form, volatile mount will always return error
> > > > > > > > > > > > > > if upperdir has error and it has not been seen by anybody.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > How did you finally end up testing the error case. Want to simualate
> > > > > > > > > > > > > > error aritificially and test it.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > 
> > > > > > > > > > > > > If you don't want to see errors that occurred before you did the mount,
> > > > > > > > > > > > > then you probably can just resurrect and rename the original version of
> > > > > > > > > > > > > errseq_sample. Something like this, but with a different name:
> > > > > > > > > > > > > 
> > > > > > > > > > > > > +errseq_t errseq_sample(errseq_t *eseq)
> > > > > > > > > > > > > +{
> > > > > > > > > > > > > +       errseq_t old = READ_ONCE(*eseq);
> > > > > > > > > > > > > +       errseq_t new = old;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +       /*
> > > > > > > > > > > > > +        * For the common case of no errors ever having been set, we can skip
> > > > > > > > > > > > > +        * marking the SEEN bit. Once an error has been set, the value will
> > > > > > > > > > > > > +        * never go back to zero.
> > > > > > > > > > > > > +        */
> > > > > > > > > > > > > +       if (old != 0) {
> > > > > > > > > > > > > +               new |= ERRSEQ_SEEN;
> > > > > > > > > > > > > +               if (old != new)
> > > > > > > > > > > > > +                       cmpxchg(eseq, old, new);
> > > > > > > > > > > > > +       }
> > > > > > > > > > > > > +       return new;
> > > > > > > > > > > > > +}
> > > > > > > > > > > > 
> > > > > > > > > > > > Yes, a helper like this should solve the issue at hand. We are not
> > > > > > > > > > > > interested in previous errors. This also sets the ERRSEQ_SEEN on
> > > > > > > > > > > > sample and it will also solve the other issue when after sampling
> > > > > > > > > > > > if error gets seen, we don't want errseq_check() to return error.
> > > > > > > > > > > > 
> > > > > > > > > > > > Thinking of some possible names for new function.
> > > > > > > > > > > > 
> > > > > > > > > > > > errseq_sample_seen()
> > > > > > > > > > > > errseq_sample_set_seen()
> > > > > > > > > > > > errseq_sample_consume_unseen()
> > > > > > > > > > > > errseq_sample_current()
> > > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > errseq_sample_consume_unseen() sounds good, though maybe it should be
> > > > > > > > > > > "ignore_unseen"? IDK, naming this stuff is the hardest part.
> > > > > > > > > > > 
> > > > > > > > > > > If you don't want to add a new helper, I think you'd probably also be
> > > > > > > > > > > able to do something like this in fill_super:
> > > > > > > > > > > 
> > > > > > > > > > > Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â errseq_sample()
> > > > > > > > > > > Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â errseq_check_and_advance()
> > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > ...and just ignore the error returned by the check and advance. At that
> > > > > > > > > > > point, the cursor should be caught up and any subsequent syncfs call
> > > > > > > > > > > should return 0 until you record another error. It's a little less
> > > > > > > > > > > efficient, but only slightly so.
> > > > > > > > > > 
> > > > > > > > > > This seems even better.
> > > > > > > > > > 
> > > > > > > > > > Thinking little bit more. I am now concerned about setting ERRSEQ_SEEN on
> > > > > > > > > > sample. In our case, that would mean that we consumed an unseen error but
> > > > > > > > > > never reported it back to user space. And then somebody might complain.
> > > > > > > > > > 
> > > > > > > > > > This kind of reminds me posgresql's fsync issues where they did
> > > > > > > > > > writes using one fd and another thread opened another fd and
> > > > > > > > > > did sync and they expected any errors to be reported.
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > > Similary what if an unseen error is present on superblock on upper
> > > > > > > > > > and if we mount volatile overlay and mark the error SEEN, then
> > > > > > > > > > if another process opens a file on upper and did syncfs(), it will
> > > > > > > > > > complain that exisiting error was not reported to it.
> > > > > > > > > > 
> > > > > > > > > > Overlay use case seems to be that we just want to check if an error
> > > > > > > > > > has happened on upper superblock since we sampled it and don't
> > > > > > > > > > want to consume that error as such. Will it make sense to introduce
> > > > > > > > > > two helpers for error sampling and error checking which mask the
> > > > > > > > > > SEEN bit and don't do anything with it. For example, following compile
> > > > > > > > > > tested only patch.
> > > > > > > > > > 
> > > > > > > > > > Now we will not touch SEEN bit at all. And even if SEEN gets set
> > > > > > > > > > since we sampled, errseq_check_mask_seen() will not flag it as
> > > > > > > > > > error.
> > > > > > > > > > 
> > > > > > > > > > Thanks
> > > > > > > > > > Vivek
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Again, you're not really hiding this from anyone doing something _sane_.
> > > > > > > > > You're only hiding an error from someone who opens the file after an
> > > > > > > > > error occurs and expects to see an error.
> > > > > > > > > 
> > > > > > > > > That was the behavior for fsync before we switched to errseq_t, and we
> > > > > > > > > had to change errseq_sample for applications that relied on that. syncfs
> > > > > > > > > reporting these errors is pretty new however. I don't think we
> > > > > > > > > necessarily need to make the same guarantees there.
> > > > > > > > > 
> > > > > > > > > The solution to all of these problems is to ensure that you open the
> > > > > > > > > files early you're issuing syncfs on and keep them open. Then you'll
> > > > > > > > > always see any subsequent errors.
> > > > > > > > 
> > > > > > > > Ok. I guess we will have to set SEEN bit during error_sample otherwise,
> > > > > > > > we miss errors. I had missed this point.
> > > > > > > > 
> > > > > > > > So mounting a volatile overlay instance will become somewhat
> > > > > > > > equivalent of as if somebody did a syncfs on upper, consumed
> > > > > > > > error and did not do anything about it.
> > > > > > > > 
> > > > > > > > If a user cares about not losing such errors, they need to keep an
> > > > > > > > fd open on upper.
> > > > > > > > 
> > > > > > > > /me hopes that this does not become an issue for somebody. Even
> > > > > > > > if it does, one workaround can be don't do volatile overlay or
> > > > > > > > don't share overlay upper with other conflicting workload.
> > > > > > > > 
> > > > > > > 
> > > > > > > Yeah, there are limits to what we can do with 32 bits.
> > > > > > > 
> > > > > > > It's not pretty, but I guess you could pr_warn at mount time if you find
> > > > > > > an unseen error. That would at least not completely drop it on the
> > > > > > > floor.
> > > > > > > 
> > > > > > > --
> > > > > > > Jeff Layton <jlayton@redhat.com>
> > > > > > > 
> > > > > > 
> > > > > > If I may enumerate our choices to help my own understanding, and
> > > > > > come up with a decent decision on how to proceed:
> > > > > > 
> > > > > > 1. If the filesystem has an unseen error, pr_warn.
> > > > > > 2. If the filesystem has an unseen error, refuse to mount it until
> > > > > >    the user clears the error (via syncfs?).
> > > > > > 3. Ignore the beginning state of the upperdir
> > > > > > 4. Increment the errseq_t.
> > > > > > 5. A combination of #1, and #2 and require the user to mount
> > > > > >    -o reallyvolatile or smoe such.
> > > > > > 
> > > > > > Now the downsides of each of these options:
> > > > > > 
> > > > > > 1. The user probably won't look at these errors. Especially,
> > > > > >    if the application is a container runtime, and these are
> > > > > >    happening on behalf of the application in an automated fashion.
> > > > > > 2. Forcing a syncfs on most filesystems is a massively costly
> > > > > >    operation that we want to avoid with the volatile operation.
> > > > > >    Also, go back to #1. Until we implement the new FS API, we
> > > > > >    can't easily give meaningful warnings to users that they
> > > > > >    can programatically act on (unless we use some special errno).
> > > > > > 3. This is a noop.
> > > > > > 4. We can hide errors from other users of the upperdir if they
> > > > > >    rely on syncfs semantics rather than per-fd fsync semantics
> > > > > >    to check if the filesystem is "clean".
> > > > > > 5. See the issues with #1 and #2.
> > > > > > 
> > > > > > I'm also curious as to how the patchset that allows for partial
> > > > > > sync is going to deal with this problem [1].
> > > > > > 
> > > > > > There is one other proposal I have, which is we define errseq_t
> > > > > > as two structures:
> > > > > > -errseq_t errseq_set(errseq_t *eseq, int err);
> > > > > > +/* For use on the publishing-side of errseq */
> > > > > > +struct errseq_publisher {
> > > > > > +        atomic_t        errors;
> > > > > > +        errseq_t        errseq_t
> > > > > > +};
> > > > > > +
> > > > > > +errseq_t errseq_set(struct errseq_publisher *eseq, int err);
> > > > > > 
> > > > > > And errseq_publisher is on the superblock, and errors is always incremented no
> > > > > > matter what. We risk wrapping, but I think this falls into Jeff's "sane" test --
> > > > > > if there are 2**32+ errors without someone doing an fsync, or noticing, you
> > > > > > might have other problems.
> > > > > > 
> > > > > > This has two (and a half) downsides:
> > > > > > 1. It is a potential performance concern to introduce an atomic here.
> > > > > 
> > > > > Is updation of errseq_t performance sensitive path. Updation happens in
> > > > > error path and I would think that does not happen often. If that's the
> > > > > case, it should not be very performance sensitive path.
> > > > > 
> > > > > I agree that warning on unseen error is probably not enough. Applications
> > > > > can't do much with that. To me it boils down to two options.
> > > > > 
> > > > > A. Live with the idea of swallowing the unseen error on syncfs (if caller
> > > > >    did not keep an fd open).
> > > > > 
> > > > > B. Extend errseq infrastcture in such a way so that we can detect new
> > > > >    error without marking error SEEN.
> > > > > 
> > > > > It feels as if B is a safter choice but will be more work. With A, problem
> > > > > is that behavior will be different in difference scenarios and it will then
> > > > > become difficult to justify.
> > > > > 
> > > > > - fsync and syncfs behavior will be different w.r.t UNSEEN error.
> > > > > - syncfs behavior will be different depending on if volatile overlay
> > > > >   mounts are being used on this filesystem or not.
> > > > > 
> > > > 
> > > > (cc'ing Willy since he helped a lot with this work)
> > > > 
> > > > The design for fsync is a bit odd, in that we had to preserve historical
> > > > behavior. Note that we didn't get it right at first. Our original
> > > > assumption was that applications wouldn't expect to see any writeback
> > > > errors that occurred before they opened the file. That turned out to be
> > > > wrong, and Willy fixed that by ensuring that unseen errors would be
> > > > reported once to the next task to do an fsync [1].
> > > > 
> > > > I'm not sure how you could change the behavior to accomodate the desire
> > > > for B. One idea: you could do away with the optimization that doesn't
> > > > bump the counter and record a new error when no one has seen the
> > > > previous one yet, and it's the same error. That would increase the
> > > > chances of the counter wrapping around however.
> > > > 
> > > 
> > > I personally like this approach. If the concerns of counter-wrap or performance
> > > are well-founded, what do you think of adding the atomic which is
> > > incremented only when the seen bit is unset, effectively giving publishers
> > > 52 (32 + 20) bits of space to prevent wraparound? And subscribers can
> > > optionally opt to have 52-bit values to check against?
> > > 
> > 
> > That seems a bit hacky. I think if you're going to do that, then you
> > might as well just build 64-bit errseq_t infrastructure and move to
> > that. You could still just sample and test against the bottom 32 bits.
> > 
> > The problem there though is that growing struct address_space or struct
> > file for this is somewhat unpalatable. It would be nice to keep all of
> > this within 32 bits.
> > 
> > I think the best option is probably to just work to restructure the
> > syncfs code so that overlayfs can override the logic in the syncfs
> > syscall wrapper and return an error of its choosing to a syncfs()
> > syscall.
> > 
> > It's a more radical change, but maybe we could add a new
> > sb->s_op->syncfs operation, and turn the guts of the old syncfs syscall
> > wrapper into a generic helper.
> > 
> > The naming is a little confusing with an existing sync_fs op, however,
> > but maybe we could transition all of the old sync_fs ops to the new one
> > and get rid of ->sync_fs. That's a more invasive set though, and you'd
> > need to preserve the existing behavior everywhere.
> > 
> > Once you have that, you could just use the "realfile" in
> > private_data for your syncfs op and everything should "just work".
> 
> This should work for regular overlayfs where calling syncfs() on
> overlay will result in calling syncfs() on underlying filesystem 
> and help propagating error back, IIUC.
> 
> But for this specific use case, of volatile mount, we want to find
> out if underlying filesystem superblock had a writeback error since
> we mounted overlay instance, without calling syncfs() on underlying
> filesystem. And we don't want to consume existing error on underlying
> super block fearing applications will complain.
> 

Why? If you're not planning to do anything with the error then why check
for it in the first place? Maybe I don't really understand what you're
trying to do with this.

If it turns out that you just want to see if it ever had an error, you
can always use errseq_check with 0 as the "since" value and that will
tell you without marking or advancing anything. It's not clear to me
what the value of that is here though.

> So key requirement here seems to be being able to detect error
> on underlying superblock without consuming the unseen error.
> 

I think for overlayfs what you really want to do is basically "proxy"
fsync and syncfs calls to the upper layer. Then you should just be able
to use the upper layer's "realfile" when doing fsync/syncfs. You won't
need to sample anything at mount time that way as it should just happen
naturally when you open files on overlayfs.

That does mean you may need to rework how the syncfs syscall dispatches
to the filesystem, but that's not too difficult in principle.

-- 
Jeff Layton <jlayton@redhat.com>

