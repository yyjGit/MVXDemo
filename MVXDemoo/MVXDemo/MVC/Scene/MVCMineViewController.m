//
//  MVCMineViewController.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/5.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "MVCMineViewController.h"
#import "UserDetailViewController.h"

#import "MVCDraftTableviewHelper.h"


@interface MVCMineViewController ()

@property (nonatomic, strong) MVCDraftTableviewHelper *draftTableViewHelper;

@end

@implementation MVCMineViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configHelper];
}

#pragma mark - private methods
- (void)configHelper
{
    self.draftTableViewHelper.tableView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, kScreenWidth, kScreenHeight - NAVIGATION_BAR_HEIGHT);
    [self.view addSubview:self.draftTableViewHelper.tableView];
    [self.draftTableViewHelper fetchData];
    
    __weak typeof(self) weakSelf = self;
    [self.draftTableViewHelper setDidSelectRowHandler:^(Draft *draft) {
        [weakSelf.navigationController pushViewController:[DraftDetailViewController instanceWithDraft:draft] animated:YES];
    }];
}

#pragma mark - getters
- (MVCDraftTableviewHelper *)draftTableViewHelper
{
    if (_draftTableViewHelper == nil) {
        _draftTableViewHelper = [MVCDraftTableviewHelper instanceWithUserId:self.userId];
    }
    return _draftTableViewHelper;
}


@end
