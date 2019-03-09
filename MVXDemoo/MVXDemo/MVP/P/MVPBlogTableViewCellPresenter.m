//
//  MVPBlogTableViewCellPresenter.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/9.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "MVPBlogTableViewCellPresenter.h"
#import "Blog.h"

@interface MVPBlogTableViewCellPresenter ()

@property (nonatomic, assign) NSUInteger userId;
@property (nonatomic, strong) Blog *blog;
@property (nonatomic, strong) UserAPIManager *apiManager;

@end

@implementation MVPBlogTableViewCellPresenter

#pragma mark - 初始化方法
- (instancetype)initWithBlog:(Blog *)blog
{
    if (self = [super init]) {
        _blog = blog;
    }
    return self;
}

#pragma mark - public methods
+ (instancetype)presenterWithBlog:(Blog *)blog
{
    return [[self alloc] initWithBlog:blog];
}

- (void)likeBlogCompletionHandler:(NetworkCompletionHandler)completionHandler
{
    if (self.blog.isLiked) {
        
        if (completionHandler) {
            NSError *error = [NSError errorWithDomain:@"您已经点过赞了呢" code:123 userInfo:nil];
            completionHandler(error, nil);
        }
        
    } else {
    
        kWeakSelf(self);
        [self.apiManager likeBlogWithBlogId:self.blog.blogId completionHandler:^(NSError *error, id result) {
           
            if (error && completionHandler) {
                completionHandler(error, result);
            } else {
                
                weakself.blog.likeCount += 1;
                weakself.blog.isLiked = YES;
                if ([weakself.delegate respondsToSelector:@selector(blogTableViewCellPresenterDidUpdateLikeState:)]) {
                    [weakself.delegate blogTableViewCellPresenterDidUpdateLikeState:weakself];
                }
            }
        }];
    }
}

- (void)shareBlogCompletionHandler:(NetworkCompletionHandler)completionHandler
{
    if (completionHandler) {
        NSError *error = [NSError errorWithDomain:@"分享功能暂未开发" code:123 userInfo:nil];
        completionHandler(error, nil);
    }
}

#pragma mark - getters
- (BOOL)isLiked
{
    return self.blog.isLiked;
}

- (NSString *)blogTitle
{
    return self.blog.blogTitle.length > 0 ? self.blog.blogTitle : @"未命名";
}

- (NSString *)blogSummary
{
    return self.blog.blogSummary.length > 0 ? [NSString stringWithFormat:@"摘要：%@", self.blog.blogSummary] : @"这个人很懒什么也没有写";
}

- (NSString *)blogLikeCount
{
    return [NSString stringWithFormat:@"赞 %ld", self.blog.likeCount];
}

- (NSString *)blogShareCount
{
    return [NSString stringWithFormat:@"分享 %ld", self.blog.shareCount];
}

#pragma mark - getters
- (UserAPIManager *)apiManager
{
    if (_apiManager == nil) {
        _apiManager = [[UserAPIManager alloc] init];
    }
    return _apiManager;
}


@end
