Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D838B1412B7
	for <lists+linux-unionfs@lfdr.de>; Fri, 17 Jan 2020 22:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgAQVTo (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Fri, 17 Jan 2020 16:19:44 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:32883 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgAQVTn (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:19:43 -0500
Received: by mail-pj1-f65.google.com with SMTP id u63so4506794pjb.0
        for <linux-unionfs@vger.kernel.org>; Fri, 17 Jan 2020 13:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JVtelnvC6J0Q34UGbqz15rhnZe3dDPULyussnAihjPY=;
        b=JFqXovHwsNMhTxKmJnSHFJ+434Vzb+9ZGEzFA/wdIdwQ9oX6SSDbcwuD58/YUH6dxa
         0vb072YtWACm3/dHkbrNTxl+9V7Fx53emSxzHMKWWhyR/t8dZB+1S069Y6GSnYvt242d
         TyEaSnBfgi0ZtpyJcYRoEisz9+kkMpazSkgjpghUyKiYOBdFmVsUcpJ6QsY9NHkDT2g+
         zcY/76NN8+nsr6c38s3kwDFS4jvs80cemUBNq9qlRCWCYlt7he165DlohSIEjeSS8nWg
         JtU9RZUWYQYHu3pO8QCxV+pm733FSrHa18jgeijYGNK2JuQqucXFzK4RO2nDg9ehYMzm
         aAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JVtelnvC6J0Q34UGbqz15rhnZe3dDPULyussnAihjPY=;
        b=ZTD9Qnspe5dTgaQLscJLH3HcEyv6C8Y0xKIYdNnVGB/gTuw82/oSz3f46BXX7IMKdR
         VGECdRBhB2qOEHm3xTVXhCP32lWkQww49OHjupqjKoeaRH8A7CdBjlXmPpWX89LgFuv8
         1k61g6BCAt0MNDg13GyAUy41XlB85sCCoSFhUoNYO5iLV0asHkVMMaJTZgadtKbq7x4t
         jL2Wktztn7gaghiYbtb3UgIUHA1TZGqx+fFGEjFdaRqSyBvjhVEQsIYM2k4tGZaHTY/X
         3fbL2PdClAqMAjkFkDFgwrs5oIk04MuV4SAFHzM2JiOCy+VQaQ6XgXBQmTJSB4Z7YGUZ
         er1g==
X-Gm-Message-State: APjAAAXdcxths9yowjzAMxD146SMjY1JsoMxq9daVNWWnssax0ATn2/X
        k8Q7VRb0ys7fHzcvrd/TyKORwA==
X-Google-Smtp-Source: APXvYqwad2dCoSnORgIV31f42OSU1Fj6QQ0q2N+/Tuo16KenyS5hmAzIWqespOnLlAeALJKV3/yhIw==
X-Received: by 2002:a17:902:16b:: with SMTP id 98mr1286982plb.218.1579295983097;
        Fri, 17 Jan 2020 13:19:43 -0800 (PST)
Received: from cisco ([156.39.10.47])
        by smtp.gmail.com with ESMTPSA id c18sm30045480pfr.40.2020.01.17.13.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:19:42 -0800 (PST)
Date:   Fri, 17 Jan 2020 13:19:40 -0800
From:   Tycho Andersen <tycho@tycho.ws>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        containers@lists.linux-foundation.org,
        linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2 2/3] fs: introduce uid/gid shifting bind mount
Message-ID: <20200117211940.GA22062@cisco>
References: <20200104203946.27914-1-James.Bottomley@HansenPartnership.com>
 <20200104203946.27914-3-James.Bottomley@HansenPartnership.com>
 <20200113034149.GA27228@mail.hallyn.com>
 <1579112360.3249.17.camel@HansenPartnership.com>
 <20200116064430.GA32763@mail.hallyn.com>
 <1579192173.3551.38.camel@HansenPartnership.com>
 <20200117154402.GA16882@mail.hallyn.com>
 <1579278342.3227.36.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579278342.3227.36.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Fri, Jan 17, 2020 at 08:25:42AM -0800, James Bottomley wrote:
> On Fri, 2020-01-17 at 09:44 -0600, Serge E. Hallyn wrote:
> > On Thu, Jan 16, 2020 at 08:29:33AM -0800, James Bottomley wrote:
> > I guess I figured we would have privileged task in the owning
> > namespace (presumably init_user_ns) mark a bind mount as shiftable 
> 
> Yes, that's what I've got today in the prototype.  It mirrors the
> original shiftfs mechanism.  However, I have also heard people say they
> want a permanent mark, like an xattr for this.

Please, no. mount() failures are already hard to reason about, I would
rather not add another temporary (or worse, permanent) non-obvious
failure mode.

What if we make shifted bind mounts always readonly? That will force
people to use an overlay (or something else) on top, but they probably
want to do that anyway so they can avoid tainting the original
container image with writes.

> > Oh - I consider the detail of whether we pass a userid or userns nsfd
> > as more of an implementation detail which we can hash out after the
> > more general shift-mount api is decided upon.  Anyway, passing nsfds
> > just has a cool factor :)
> 
> Well, yes, won't aruge on the cool factor-ness.

It's not just the cool factor: if you're doing this, it's presumably
because you want to use it with a container in a user namespace.
Specifying the same parameters twice leaves room for error, causing
CVEs and more work.

Tycho
