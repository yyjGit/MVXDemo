//
//  MVCDraftTableviewCtr.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/6.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "MVCDraftTableviewHelper.h"

// views
#import "MVCDraftTableViewCell.h"

// moder/other
#import "MVCDraftTableviewCellHelper.h"

@interface MVCDraftTableviewHelper () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) void(^didSelectRowHandler)(Draft *); // 点击cell回调
@property (nonatomic, assign) NSUInteger userId; // 用户id
@property (nonatomic, strong) UserAPIManager *apiManager;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<MVCDraftTableviewCellHelper *> *drafts;

@end

static NSString *kDraftCellId = @"draftCellId";
@implementation MVCDraftTableviewHelper

#pragma mark - public methods
+ (instancetype)instanceWithUserId:(NSUInteger)userId
{
    return [[self alloc] initWithUserId:userId];
}

- (instancetype)initWithUserId:(NSUInteger)userId
{
    if (self = [super init]) {
        self.userId = userId;
    }
    return self;
}

- (void)fetchData
{
    [self.apiManager refreshUserDraftsWithUserId:self.userId completionHandler:^(NSError *error, id result) {
        
        if (error) { // 有错误，显示
            [self.tableView showToastWithText:error.domain];
        } else { // 没有错误，显示数据
            [self reloadTableViewWithDrafts:result];
        }
    }];
}

#pragma mark - tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.drafts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MVCDraftTableviewCellHelper *cellHelper = self.drafts[indexPath.row];
    // 创建cell，绑定数据
    MVCDraftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDraftCellId];
    cell.title = cellHelper.draftTitleText;
    cell.summary = cellHelper.draftSummaryText;
    cell.editDate = cellHelper.draftEditDate;
    
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
    // 回调
    if (self.didSelectRowHandler) {
        self.didSelectRowHandler(self.drafts[indexPath.row].draft);
    }
}

#pragma mark - private methods
- (void)reloadTableViewWithDrafts:(NSArray*)drafts
{
    for (Draft *draft in drafts) {
        [self.drafts addObject:[MVCDraftTableviewCellHelper helperWithDraft:draft]];
    }
    [self.tableView reloadData];
}

- (void)addTableViewRefreshEvent
{
    __weak typeof(self) weakSelf = self;

    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.apiManager refreshUserDraftsWithUserId:weakSelf.userId completionHandler:^(NSError *error, id result) {
            [weakSelf.tableView.header endRefreshing];
            
            if (!error) {
                [weakSelf.drafts removeAllObjects];
                [weakSelf reloadTableViewWithDrafts:result];
                [weakSelf.tableView.footer resetNoMoreData];
            }
        }];
    }];
    
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf.apiManager loadModeUserDraftsWithUserId:weakSelf.userId completionHandler:^(NSError *error, id result) {
            [weakSelf.tableView.footer endRefreshing];
            
            if (!error) {
                [weakSelf reloadTableViewWithDrafts:result];
            } else if (error.code == NetworkErrorNoMoreData) {
                
                [weakSelf.tableView showToastWithText:error.domain];
                [weakSelf.tableView.footer endRefreshingWithNoMoreData];
            }
        }];
    }];

}

#pragma mark - getters
- (NSMutableArray <MVCDraftTableviewCellHelper *>*)drafts
{
    if (_drafts == nil) {
        _drafts = [NSMutableArray array];
    }
    return _drafts;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:MVCDraftTableViewCell.class forCellReuseIdentifier:kDraftCellId];
    }
    return _tableView;
}

- (UserAPIManager *)apiManager
{
    if (_apiManager == nil) {
        _apiManager = [[UserAPIManager alloc] init];
    }
    return _apiManager;
}

@end
