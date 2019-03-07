//
//  MVCBlogTableViewCellMediator.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/5.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "MVCBlogTableViewCellHelper.h"

@interface MVCBlogTableViewCellHelper ()

@property (strong, nonatomic) Blog *blog;

@end

@implementation MVCBlogTableViewCellHelper

+ (instancetype)helperWithBlog:(Blog *)blog 
{
    return  [[self alloc] initWithBlog:blog];
}

- (instancetype)initWithBlog:(Blog *)blog
{
    if (self = [super init]) {
        self.blog = blog;
    }
    return self;
}

- (BOOL)isLiked
{
    return self.blog.isLiked;
}

- (NSString *)blogTitleText
{
    return self.blog.blogTitle.length > 0 ? self.blog.blogTitle : @"未命名";
}

- (NSString *)blogSummaryText
{
    return self.blog.blogSummary.length > 0 ? [NSString stringWithFormat:@"摘要: %@", self.blog.blogSummary] : @"这个人很懒, 什么也没有写...";
}

- (NSString *)blogLikeCountText
{
    return [NSString stringWithFormat:@"赞 %ld", self.blog.likeCount];
}

- (NSString *)blogShareCountText
{
    return [NSString stringWithFormat:@"分享 %ld", self.blog.shareCount];
}

@end
