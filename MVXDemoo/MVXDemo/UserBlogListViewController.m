//
//  UserBlogListViewController.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/6.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "UserBlogListViewController.h"
#import "UIView+Alert.h"
#import "UIView+Extension.h"
#import "MVCBlogTableViewMediator.h"

@interface UserBlogListViewController ()

@property (strong, nonatomic) MVCBlogTableViewMediator *blogTableViewMediator;

@end

@implementation UserBlogListViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.blogTableViewMediator.tableView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, kScreenWidth, kScreenHeight - NAVIGATION_BAR_HEIGHT);
    [self.view addSubview:self.blogTableViewMediator.tableView];
    
    [self showHUD];
    [self.blogTableViewMediator fetchDataWithCompletionHandler:^(NSError *error, id result) {
        [self hideHUD];
    }];
}

#pragma mark - getters
- (MVCBlogTableViewMediator *)blogTableViewMediator
{
    if (_blogTableViewMediator == nil) {
        _blogTableViewMediator = [MVCBlogTableViewMediator instanceWithUserId:666];
    }
    return _blogTableViewMediator;
}

@end
