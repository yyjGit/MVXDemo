//
//  MVPUserInfoViewPresenter.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/9.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "MVPUserInfoViewPresenter.h"
#import "User.h"
#import "UserAPIManager.h"

@interface MVPUserInfoViewPresenter ()

@property (nonatomic, assign) NSUInteger userId;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) UserAPIManager *apiManager;

@end

@implementation MVPUserInfoViewPresenter

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
- (void)fetchUserInfo
{        
    kWeakSelf(self);
    [self.apiManager fetchUserInfoWithUserId:self.userId completionHandler:^(NSError *error, id result) {
        
        if (result && [result isKindOfClass:User.class]) {
            weakself.user = (User *)result;
        }
        
        if ([weakself.delegate respondsToSelector:@selector(userInfoViewPresenter:didFetchUserInfoWithResult:error:)]) {

            [weakself.delegate userInfoViewPresenter:weakself didFetchUserInfoWithResult:result error:error];
        }
    }];
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
