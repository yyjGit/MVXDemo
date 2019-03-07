//
//  UserBlogListViewController.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/6.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "UserBlogListViewController.h"

#import "MVCBlogTableViewHelper.h"

@interface UserBlogListViewController ()

@property (strong, nonatomic) MVCBlogTableViewHelper *blogTableViewMediator;

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
- (MVCBlogTableViewHelper *)blogTableViewMediator
{
    if (_blogTableViewMediator == nil) {
        _blogTableViewMediator = [MVCBlogTableViewHelper instanceWithUserId:666];
    }
    return _blogTableViewMediator;
}

@end
