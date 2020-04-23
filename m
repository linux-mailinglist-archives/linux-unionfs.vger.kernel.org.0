Return-Path: <linux-unionfs-owner@vger.kernel.org>
X-Original-To: lists+linux-unionfs@lfdr.de
Delivered-To: lists+linux-unionfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E815A1B5A40
	for <lists+linux-unionfs@lfdr.de>; Thu, 23 Apr 2020 13:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgDWLRD (ORCPT <rfc822;lists+linux-unionfs@lfdr.de>);
        Thu, 23 Apr 2020 07:17:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:53494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgDWLRD (ORCPT <rfc822;linux-unionfs@vger.kernel.org>);
        Thu, 23 Apr 2020 07:17:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 25783B080;
        Thu, 23 Apr 2020 11:17:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6DF871E1293; Thu, 23 Apr 2020 13:17:00 +0200 (CEST)
Date:   Thu, 23 Apr 2020 13:17:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger@dilger.ca, darrick.wong@oracle.com, hch@infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 2/5] ext4: Rename fiemap_check_ranges() to make it ext4
 specific
Message-ID: <20200423111700.GI3737@quack2.suse.cz>
References: <cover.1587555962.git.riteshh@linux.ibm.com>
 <64ab9d5449f6fb96bb8633f1a40cff14ddb5614e.1587555962.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64ab9d5449f6fb96bb8633f1a40cff14ddb5614e.1587555962.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-unionfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-unionfs.vger.kernel.org>
X-Mailing-List: linux-unionfs@vger.kernel.org

On Thu 23-04-20 16:17:54, Ritesh Harjani wrote:
> This renames the fiemap_check_ranges() copy of function
> within ext4/ioctl.c to become ext4_fiemap_check_ranges().
> This is required so that we can finally get rid of this
> duplicate version.
> Since overlayfs anyways need to use this in it's
> ovl_fiemap() function, so later patches make it
> available for use by others via EXPORT_SYMBOL.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index bfc1281fc4cb..76a2b5200ba3 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -734,7 +734,7 @@ static void ext4_fill_fsxattr(struct inode *inode, struct fsxattr *fa)
>  }
>  
>  /* copied from fs/ioctl.c */
> -static int fiemap_check_ranges(struct super_block *sb,
> +static int ext4_fiemap_check_ranges(struct super_block *sb,
>  			       u64 start, u64 len, u64 *new_len)
>  {
>  	u64 maxbytes = (u64) sb->s_maxbytes;
> @@ -775,7 +775,7 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
>  	if (fiemap.fm_extent_count > FIEMAP_MAX_EXTENTS)
>  		return -EINVAL;
>  
> -	error = fiemap_check_ranges(sb, fiemap.fm_start, fiemap.fm_length,
> +	error = ext4_fiemap_check_ranges(sb, fiemap.fm_start, fiemap.fm_length,
>  				    &len);
>  	if (error)
>  		return error;
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
