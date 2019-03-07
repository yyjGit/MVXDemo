//
//  MVCUserViewController.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/5.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "MVCUserViewController.h"
#import "MVCMineViewController.h"
#import "UserDetailViewController.h"

// models/others
#import "MVCBlogTableViewHelper.h"
#import "MVCUserInfoViewHelper.h"

// views
#import "UserInfoView.h"

@interface MVCUserViewController ()
@property (nonatomic, assign) BOOL isMineVc;
@end

@implementation MVCUserViewController

#pragma mark - public methods
+ (instancetype)instanceWithUserId:(NSUInteger)userId
{
    if (userId == LoginUserId) {
        return [[MVCMineViewController alloc] initWithUserId:userId];
    } else {
        return [[MVCUserViewController alloc] initWithUserId:userId];
    }
}

- (instancetype)initWithUserId:(NSUInteger)userId
{
    if (self = [super init]) {
        _userId = userId;
        _isMineVc = (userId == LoginUserId);
    }
    return self;
}

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"用户%ld", self.userId];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.userInfoHelper.infoView];

    // 如果是mineVc则之后代码不在执行，在mineVc中执行
    if (self.isMineVc) return;
    
    [self.view addSubview:self.blogHelper.tableView];
    [self layoutPageSubviews];
    [self configHelper];
    [self fetchData];
}

#pragma mark - private methods
- (void)configHelper
{
    [self.userInfoHelper setVCGenerator:^UIViewController *(id params) {
        return [UserDetailViewController instanceWithUser:params];
    }];

    [self.blogHelper setVCGenerator:^UIViewController *(id params) {
        return [BlogDetailViewController instanceWithBlog:params];
    }];
}

- (void)layoutPageSubviews
{
    [self.userInfoHelper.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
        make.height.mas_equalTo(150);
    }];
    
    if (self.isMineVc) return;
        
    [self.blogHelper.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_equalTo(self.userInfoHelper.infoView.mas_bottom);
    }];
}

- (void)fetchData
{
    [self.userInfoHelper fetchUserInfo];
    [self showHUD];
    [self.blogHelper fetchDataWithCompletionHandler:^(NSError *error, id result) {
        [self hideHUD];
    }];
}

#pragma mark - getters
- (MVCUserInfoViewHelper *)userInfoHelper
{
    if (_userInfoHelper == nil) {
        _userInfoHelper = [MVCUserInfoViewHelper instanceWithUserId:self.userId];
    }
    return _userInfoHelper;
}

- (MVCBlogTableViewHelper *)blogHelper
{
    if (_blogHelper == nil) {
        _blogHelper = [MVCBlogTableViewHelper instanceWithUserId:self.userId];
    }
    return _blogHelper;
}

@end
