//
//  MVPBlogTableViewHelper.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/9.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "MVPBlogTableViewHelper.h"
#import "MVPBlogTableViewCell.h"

@interface MVPBlogTableViewHelper () <UITableViewDelegate, UITableViewDataSource, MVPBlogTableViewPresenterDelegate>

@property (assign, nonatomic) NSUInteger userId; // 用户id
@property (nonatomic, strong) MVPBlogTableViewPresenter *presenter; // MV P
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, copy) ViewControllerGenerator blogDetailVcGenerator; // 博客详情vc生成器

@end

static NSString *kBlogCellId = @"mvpBlogCellId";
@implementation MVPBlogTableViewHelper

#pragma mark - 初始化方法
+ (instancetype)helperWithUserId:(NSUInteger)userId
{
    return [[self alloc] initWithUserId:userId];
}

- (instancetype)initWithUserId:(NSUInteger)userId
{
    if (self = [super init]) {
        _userId = userId;
        [self addTableViewRefreshEvent];
    }
    return self;
}

#pragma mark - tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.presenter.blogs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    // 创建cell，绑定数据
    MVPBlogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBlogCellId];
    cell.presenter = self.presenter.blogs[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.blogDetailVcGenerator) {
        UIViewController *targetVC = self.blogDetailVcGenerator(self.presenter.blogs[indexPath.row].blog);
        if (targetVC) {
            [self.tableView.navigationController pushViewController:targetVC animated:YES];
        }
    }
}

#pragma mark - MVPBlogTableViewPresenterDelegate
- (void)blogTableViewPresenter:(MVPBlogTableViewPresenter *)presenter didRefreshDataWithResult:(id)result error:(NSError *)error
{
    if (result) {
        [self.tableView.header endRefreshing];
        [self.tableView reloadData];
    }
}

- (void)blogTableViewPresenter:(MVPBlogTableViewPresenter *)presenter didFetchMoreDataWithResult:(id)result error:(NSError *)error
{
    [self.tableView.footer endRefreshingWithNoMoreData];
    [self.tableView reloadData];
}

#pragma mark - peivate methods
- (void)addTableViewRefreshEvent
{
    kWeakSelf(self);
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself.presenter refreshBlogData];
    }];
    
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself.presenter loadMoreBlogData];
    }];
}

#pragma mark - getters
- (MVPBlogTableViewPresenter *)presenter
{
    if (_presenter == nil) {
        _presenter = [MVPBlogTableViewPresenter presenterWithUserId:self.userId];
        _presenter.delegate = self;
    }
    return _presenter;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:MVPBlogTableViewCell.class forCellReuseIdentifier:kBlogCellId];
    }
    return _tableView;
}


@end
