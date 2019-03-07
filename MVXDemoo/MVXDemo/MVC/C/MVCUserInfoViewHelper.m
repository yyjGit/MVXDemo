//
//  MVCUserInfoViewHelper.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/7.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "MVCUserInfoViewHelper.h"

#import "UserInfoView.h"
#import "User.h"

@interface MVCUserInfoViewHelper ()

@property (nonatomic, strong) UserAPIManager *apiManager;
@property (nonatomic, strong) UserInfoView *infoView;
@property (nonatomic, copy) ViewControllerGenerator vcGenerator;
@property (nonatomic, assign) NSUInteger userId;
@property (nonatomic, strong) User *user;
@end

@implementation MVCUserInfoViewHelper

#pragma mark - 初始化方法
+ (instancetype)instanceWithUserId:(NSUInteger)userId
{
    return [[self alloc] initWithUserId:userId];
}

- (instancetype)initWithUserId:(NSUInteger)userId
{
    if (self = [super init]) {
        self.userId = userId;
        [self configUserInfoViewEvent];
    }
    return self;
}

#pragma mark - public method
- (void)fetchUserInfo
{
    __weak typeof(self) weakSelf = self;
    [self.apiManager fetchUserInfoWithUserId:self.userId completionHandler:^(NSError *error, id result) {
        
        if (error) {
            [weakSelf.infoView showToastWithText:error.domain];

        } else {
            
            if ([result isKindOfClass:User.class]) {
                User *u = (User *)result;
                [weakSelf.infoView setUsername:u.name];
                [weakSelf.infoView setUserIcon:u.icon];
                weakSelf.user = u;
            }
        }
    }];
}

- (void)setVCGenerator:(ViewControllerGenerator)vcGenerator
{
    _vcGenerator = vcGenerator;
}

#pragma mark - private methods
- (void)configUserInfoViewEvent
{
    __weak typeof(self) weakSelf = self;
    [self.infoView setIconClickEventHandler:^{
        
        if (weakSelf.vcGenerator) {
            
            UIViewController *targetVc = weakSelf.vcGenerator(weakSelf.user);
            [weakSelf.infoView.navigationController pushViewController:targetVc animated:YES];
        }
    }];
}

#pragma mark - getter
- (UserInfoView *)infoView
{
    if (_infoView == nil) {
        _infoView = [[UserInfoView alloc] init];
    }
    return _infoView;
}

- (UserAPIManager *)apiManager
{
    if (_apiManager == nil) {
        _apiManager = [[UserAPIManager alloc] init];
    }
    return _apiManager;
}
@end
