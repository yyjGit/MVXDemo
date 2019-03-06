//
//  MVCUserViewController.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/5.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "MVCUserViewController.h"

#import "MVCBlogTableViewMediator.h"
#import "MVCMineViewController.h"
#import "UserDetailViewController.h"

#import "UIView+Alert.h"
#import "UIView+Extension.h"

@interface MVCUserViewController ()

//@property (strong, nonatomic) UserInfoViewController *userInfoVC;
@property (strong, nonatomic) MVCBlogTableViewMediator *blogHelper;

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
        self.userId = userId;
    }
    return self;
}

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = [NSString stringWithFormat:@"用户%ld", self.userId];
    self.view.backgroundColor = [UIColor whiteColor];

    [self configuration];
    
    [self addUI];
    
    [self fetchData];

}

- (void)configuration
{    

    [self.blogHelper setVCGenerator:^UIViewController *(id params) {
        return [BlogDetailViewController instanceWithBlog:params];
    }];
    
//    self.userInfoVC = [UserInfoViewController instanceWithUserId:self.userId];
    
//    [self.userInfoVC setVCGenerator:^UIViewController *(id params) {
//        return [UserDetailViewController instanceWithUser:params];
//    }];
//    [self addChildViewController:self.userInfoVC];
}

- (void)addUI {
    
//    CGFloat userInfoViewHeight = [UserInfoViewController viewHeight];
//    self.userInfoVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, userInfoViewHeight);
//    [self.view addSubview:self.userInfoVC.view];
    
    self.blogHelper.tableView.frame = CGRectMake(0, 84, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 84);
    [self.view addSubview:self.blogHelper.tableView];
}

- (void)fetchData
{
    
//    [self.userInfoVC fetchData];
    
    [self showHUD];
    [self.blogHelper fetchDataWithCompletionHandler:^(NSError *error, id result) {
        [self hideHUD];
    }];
}

#pragma mark - getters
- (MVCBlogTableViewMediator *)blogHelper
{
    if (_blogHelper == nil) {
        _blogHelper = [MVCBlogTableViewMediator instanceWithUserId:self.userId];
    }
    return _blogHelper;
}

@end
