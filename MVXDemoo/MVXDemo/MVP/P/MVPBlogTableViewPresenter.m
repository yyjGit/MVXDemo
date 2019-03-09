//
//  MVPBlogTableViewPresentor.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/9.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "MVPBlogTableViewPresenter.h"
#import "MVPBlogTableViewCellPresenter.h"

@interface MVPBlogTableViewPresenter ()

@property (nonatomic, assign) NSUInteger userId;
@property (nonatomic, strong) NSMutableArray <MVPBlogTableViewCellPresenter *>*blogsInternal;
@property (nonatomic, strong) UserAPIManager *apiManager;

@end

@implementation MVPBlogTableViewPresenter

#pragma mark - 初始化方法
+ (instancetype)presenterWithUserId:(NSUInteger)userId
{
    return [[self alloc] initWithUserId:userId];
}

- (instancetype)initWithUserId:(NSUInteger)userId
{
    if (self = [super init]) {
        _userId = userId;
    }
    return self;
}

#pragma mark - public methods
- (void)refreshBlogData
{
    kWeakSelf(self);
    [self.apiManager refreshUserBlogsWithUserId:self.userId completionHandler:^(NSError *error, id result) {
        
        if (!error && result) {
            [weakself.blogsInternal removeAllObjects];
            [weakself formatResult:result];
        }
        
        if ([weakself.delegate respondsToSelector:@selector(blogTableViewPresenter:didRefreshDataWithResult:error:)]) {
            [weakself.delegate blogTableViewPresenter:weakself didRefreshDataWithResult:result error:error];
        }
    }];
}

- (void)loadMoreBlogData
{
    kWeakSelf(self);
    [self.apiManager loadMoreUserBlogsWithUserId:self.userId completionHandler:^(NSError *error, id result) {

        if (!error && result) {
            [weakself.blogsInternal removeAllObjects];
            [weakself formatResult:result];
        }
        
        if ([weakself.delegate respondsToSelector:@selector(blogTableViewPresenter:didFetchMoreDataWithResult:error:)]) {
            [weakself.delegate blogTableViewPresenter:weakself didFetchMoreDataWithResult:result error:error];
        }
    }];
}

#pragma mark - peivate methods
- (void)formatResult:(NSArray <MVPBlogTableViewCellPresenter *>*)blogs
{
    for (Blog *blog in blogs) {
        [self.blogsInternal addObject:[MVPBlogTableViewCellPresenter presenterWithBlog:blog]];
    }
}

#pragma mark - getters
- (UserAPIManager *)apiManager
{
    if (_apiManager == nil) {
        _apiManager = [[UserAPIManager alloc] init];
    }
    return _apiManager;
}

- (NSMutableArray <MVPBlogTableViewCellPresenter *>*)blogsInternal
{
    if (_blogsInternal == nil) {
        _blogsInternal = [NSMutableArray array];
    }
    return _blogsInternal;
}

- (NSArray <MVPBlogTableViewCellPresenter *>*)blogs
{
    return self.blogsInternal.copy;
}

@end
