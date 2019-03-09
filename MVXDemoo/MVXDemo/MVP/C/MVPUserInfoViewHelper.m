//
//  MVPUserInfoViewHelper.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/9.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "MVPUserInfoViewHelper.h"
#import "MVPUserInfoViewPresenter.h"
#import "MVPUserInfoView.h"

@interface MVPUserInfoViewHelper ()

@property (nonatomic, strong) MVPUserInfoViewPresenter *presenter;
@property (nonatomic, strong) MVPUserInfoView *infoView;
@property (nonatomic, copy) ViewControllerGenerator userDetailVcGenerator;

@property (nonatomic, assign) NSUInteger userId;

@end

@implementation MVPUserInfoViewHelper

#pragma mark - 初始化方法
+ (instancetype)helperWithUserId:(NSUInteger)userId
{
    return [[self alloc] initWithUserId:userId];
}

- (instancetype)initWithUserId:(NSUInteger)userId
{
    if (self = [super init]) {
        _userId = userId;
        [self configInfoView];
    }
    return self;
}

#pragma mark - private methods
- (void)configInfoView
{
    __weak typeof(self) weakSelf = self;
    [self.infoView setIconClickEventHandler:^{
        
        if (weakSelf.userDetailVcGenerator) {

            UIViewController *targetVc = weakSelf.userDetailVcGenerator(weakSelf.presenter.user);
            if (targetVc) {
                [weakSelf.infoView.navigationController pushViewController:targetVc animated:YES];
            }
        }
    }];
}

#pragma mark - getters
- (MVPUserInfoViewPresenter *)presenter
{
    if (_presenter == nil) {
        _presenter = [MVPUserInfoViewPresenter presenterWithUserId:self.userId];
        _presenter.delegate = self.infoView;
    }
    return _presenter;
}

- (MVPUserInfoView *)infoView
{
    if (_infoView == nil) {
        _infoView = [[MVPUserInfoView alloc] init];
    }
    return _infoView;
}

@end
