//
//  MVCBlogTableViewMediator.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/5.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "MVCBlogTableViewMediator.h"

#import "MVCBlogTableViewCellMediator.h"
#import "MVCBlogTableViewCell.h"

#import "UIView+Alert.h"
#import "UIView+Controller.h"

@interface MVCBlogTableViewMediator () <UITableViewDelegate, UITableViewDataSource>

@property (copy, nonatomic) ViewControllerGenerator VCGenerator;
@property (assign, nonatomic) NSUInteger userId;
@property (strong, nonatomic) UserAPIManager *apiManager;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<MVCBlogTableViewCellMediator *> *blogs;

@end

static NSString *kBlogCellId = @"blogCellId";

@implementation MVCBlogTableViewMediator

#pragma mark - life cycle
+ (instancetype)instanceWithUserId:(NSUInteger)userId
{
    return [[self alloc] initWithUserId:userId];
}

- (instancetype)initWithUserId:(NSUInteger)userId
{
    if (self = [super init]) {
        self.userId = userId;
        [self addTableViewRefreshEvent];
    }
    return self;
}

#pragma mark - public methods
- (void)fetchDataWithCompletionHandler:(NetworkCompletionHandler)completionHander
{
    [self.apiManager refreshUserBlogsWithUserId:self.userId completionHandler:^(NSError *error, id result) {

        if (error) {
            //            ... show errorView in tableView
        } else {
            [self reloadTableViewWithBlogs:result];
        }
        !completionHander ?: completionHander(error, result);
    }];
}

#pragma mark - tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.blogs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MVCBlogTableViewCellMediator *cellHelper = self.blogs[indexPath.row];
    // 创建cell，绑定数据
    MVCBlogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBlogCellId];
    cell.title = cellHelper.blogTitleText;
    cell.summary = cellHelper.blogSummaryText;
    cell.likeState = cellHelper.isLiked;
    cell.likeCountText = cellHelper.blogLikeCountText;
    cell.shareCountText = cellHelper.blogShareCountText;
    
    // cell点赞事件回调
    __weak typeof(cell) weakCell = cell;
    [cell setGiveLikeCallback:^{
       
        if (cellHelper.blog.isLiked) {
        
            [self.tableView showToastWithText:@"你已经赞过它了~"];

        } else {

            [[UserAPIManager new] likeBlogWithBlogId:cellHelper.blog.blogId completionHandler:^(NSError *error, id result) {
                if (error) {
                    [self.tableView showToastWithText:error.domain];
                } else {
                    cellHelper.blog.likeCount += 1;
                    weakCell.likeState = cellHelper.blog.isLiked = YES;
                    weakCell.likeCountText = cellHelper.blogLikeCountText;
                }
            }];
        }
    }];
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
    
    if (self.VCGenerator) {
        UIViewController *targetVC = self.VCGenerator(self.blogs[indexPath.row].blog);
        if (targetVC) {
            [self.tableView.navigationController pushViewController:targetVC animated:YES];
        }
    }
}


#pragma mark - private methods
- (void)addTableViewRefreshEvent
{
    __weak typeof(self) weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.apiManager refreshUserBlogsWithUserId:weakSelf.userId completionHandler:^(NSError *error, id result) {
            [weakSelf.tableView.header endRefreshing];
            
            if (!error) {
                
                [weakSelf.blogs removeAllObjects];
                [weakSelf reloadTableViewWithBlogs:result];
                [weakSelf.tableView.footer resetNoMoreData];
            }
        }];
    }];
    
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf.apiManager loadModeUserBlogsWithUserId:weakSelf.userId completionHandler:^(NSError *error, id result) {
            [weakSelf.tableView.footer endRefreshing];
            
            if (!error) {
                [weakSelf reloadTableViewWithBlogs:result];
            } else if (error.code == NetworkErrorNoMoreData) {
                
                [weakSelf.tableView showToastWithText:error.domain];
                [weakSelf.tableView.footer endRefreshingWithNoMoreData];
            }
        }];
    }];
}


- (void)reloadTableViewWithBlogs:(NSArray *)blogs
{
    for (Blog *blog in blogs) {
        [self.blogs addObject:[MVCBlogTableViewCellMediator helperWithBlog:blog]];
    }
    [self.tableView reloadData];
}

#pragma mark - getters
- (NSMutableArray <MVCBlogTableViewCellMediator *>*)blogs
{
    if (_blogs == nil) {
        _blogs = [NSMutableArray array];
    }
    return _blogs;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:MVCBlogTableViewCell.class forCellReuseIdentifier:kBlogCellId];
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
