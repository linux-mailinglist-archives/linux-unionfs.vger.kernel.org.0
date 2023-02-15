Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A149C697F14
	for <lists+linux-unionfs@lfdr.de>; Wed, 15 Feb 2023 16:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjBOPEw (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Wed, 15 Feb 2023 10:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjBOPEr (ORCPT
        <rfc822;linux-unionfs@vger.kernel.org>);
        Wed, 15 Feb 2023 10:04:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C0B61BA
        for <linux-unionfs@vger.kernel.org>; Wed, 15 Feb 2023 07:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676473440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AA0HfJf0ghZRpE+IyHbKXXgsU5oTF5v1rWycRLY8ctI=;
        b=S+MTpMOxEheghjNxO1Z6uAuoLhkBU9vLuY/0XQjL6ZecH46ea60JCw/qiMyQjbVE8OiwU0
        StSFPYZ0qwEQKePH3i5ba2PgeiiV5ErrcGeb2KulX+KykXIYCwOwxOR78qAS9jp/WPkav0
        +0S/9XgHR5H/byUTkc5m89wzkMrCE2Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-353-waR7bzIWP4Swo5jl6ha6hw-1; Wed, 15 Feb 2023 10:03:55 -0500
X-MC-Unique: waR7bzIWP4Swo5jl6ha6hw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F21C719705B7;
        Wed, 15 Feb 2023 15:03:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32E6F40CF8EA;
        Wed, 15 Feb 2023 15:03:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegshWgUYZLc5v-Vwf6g3ZGmfnHsT_t9JLwxFoV8wPrvBnA@mail.gmail.com>
References: <CAJfpegshWgUYZLc5v-Vwf6g3ZGmfnHsT_t9JLwxFoV8wPrvBnA@mail.gmail.com> <20230214171330.2722188-1-dhowells@redhat.com> <20230214171330.2722188-6-dhowells@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v14 05/17] overlayfs: Implement splice-read
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3367218.1676473410.1@warthog.procyon.org.uk>
Date:   Wed, 15 Feb 2023 15:03:30 +0000
Message-ID: <3367219.1676473410@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> > +       ret = -EINVAL;
> > +       if (in->f_flags & O_DIRECT &&
> > +           !(real.file->f_mode & FMODE_CAN_ODIRECT))
> > +               goto out_fdput;
> 
> This is unnecessary, as it was already done in ovl_real_fdget() ->
> ovl_real_fdget_meta() -> ovl_change_flags().

Does that mean ovl_read_iter() and ovl_write_iter() shouldn't be doing it,
then?

David

