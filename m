Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9392842F
	for <lists+linux-unionfs@lfdr.de>; Thu, 23 May 2019 18:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbfEWQqN (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 23 May 2019 12:46:13 -0400
Received: from fieldses.org ([173.255.197.46]:60248 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729218AbfEWQqN (ORCPT <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 23 May 2019 12:46:13 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 9001088A; Thu, 23 May 2019 12:46:12 -0400 (EDT)
Date:   Thu, 23 May 2019 12:46:12 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Petr Vorel <pvorel@suse.cz>
Subject: Re: [LTP] [PATCH] [COMMITTED] syscalls/fcntl33: Fix typo overlapfs
 -> overlayfs
Message-ID: <20190523164612.GA11083@fieldses.org>
References: <20190523134549.23103-1-chrubis@suse.cz>
 <CAOQ4uxhHVG9f1njmPgei8-QO4UEivXbxoHkqKi4f50XN6Gup9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhHVG9f1njmPgei8-QO4UEivXbxoHkqKi4f50XN6Gup9A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu, May 23, 2019 at 06:42:12PM +0300, Amir Goldstein wrote:
> On Thu, May 23, 2019 at 4:45 PM Cyril Hrubis <chrubis@suse.cz> wrote:
> >
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > ---
> >  testcases/kernel/syscalls/fcntl/fcntl33.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/testcases/kernel/syscalls/fcntl/fcntl33.c b/testcases/kernel/syscalls/fcntl/fcntl33.c
> > index 43dc5a2af..627823c5c 100644
> > --- a/testcases/kernel/syscalls/fcntl/fcntl33.c
> > +++ b/testcases/kernel/syscalls/fcntl/fcntl33.c
> > @@ -117,7 +117,7 @@ static void do_test(unsigned int i)
> >         if (TST_RET == -1) {
> >                 if (type == TST_OVERLAYFS_MAGIC && TST_ERR == EAGAIN) {
> >                         tst_res(TINFO | TTERRNO,
> > -                               "fcntl(F_SETLEASE, F_WRLCK) failed on overlapfs as expected");
> > +                               "fcntl(F_SETLEASE, F_WRLCK) failed on overlayfs as expected");
> 
> You have 3 more of this typo in fcntl tests.
> 
> If you ask me, silencing this error seems wrong.
> While the error is *expected* it is still a broken interface.
> It may be just a matter of terminology, but I am reading this message as:
> 
> TEST PASSED: Overlayfs failed as expected
> 
> While it really should be more along the lines of:
> 
> TEST SKIPPED: Overlayfs doesn't support write leased
> 
> Besides, this problem looks quite easy to fix.
> I think Bruce was already looking at changing the implementation of
> check_conflicting_open(), so if the test is not failing, nobody is going to
> nudge for a fix...

Um, I remember that discussion but I can't remember what the obstacles
were in the end.  Trying to find that thread....

--b.
