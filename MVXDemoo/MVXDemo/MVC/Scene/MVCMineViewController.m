//
//  MVCMineViewController.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/5.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "MVCMineViewController.h"
#import "UserDetailViewController.h"

// models/others
#import "MVCUserInfoViewHelper.h"
#import "MVCBlogTableViewHelper.h"
#import "MVCDraftTableviewHelper.h"

// views
#import "UserInfoView.h"

@interface MVCMineViewController ()

@property (nonatomic, strong) MVCDraftTableviewHelper *draftTableViewHelper; // 草稿viewHelper
@property (nonatomic, strong) UIScrollView *scrollView; // blog、draft 父视图
@property (strong, nonatomic) UIButton *blogButton; // 博客按钮(点击切换到blogTabelView)
@property (strong, nonatomic) UIButton *draftButton; // 草稿按钮(点击切换到draftTableView)

@end

@implementation MVCMineViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view addSubview:self.blogButton];
    [self.view addSubview:self.draftButton];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.blogHelper.tableView];
    [self.scrollView addSubview:self.draftTableViewHelper.tableView];
    
    [self layoutPageSubviews];
    [self configHelper];
    [self fetchData];
}

#pragma mark - public methods
- (void)configHelper
{
    [super configHelper];
    __weak typeof(self) weakSelf = self;
    [self.draftTableViewHelper setDidSelectRowHandler:^(Draft *draft) {
        [weakSelf.navigationController pushViewController:[DraftDetailViewController instanceWithDraft:draft] animated:YES];
    }];
}

- (void)layoutPageSubviews
{
    [super layoutPageSubviews];
    
    [self.blogButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_equalTo(self.userInfoHelper.infoView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth / 2, 40));
    }];
    
    [self.draftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(0);
        make.top.height.width.mas_equalTo(self.blogButton);
    }];

    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_equalTo(self.blogButton.mas_bottom);
    }];
    
    [self.blogHelper.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_offset(0);
        make.height.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(kScreenWidth);
    }];

    [self.draftTableViewHelper.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_offset(0);
        make.height.mas_equalTo(self.scrollView);
        make.left.width.mas_equalTo(kScreenWidth);
    }];
}

- (void)fetchData
{
    [self.draftTableViewHelper fetchData];
    [super fetchData];
}

#pragma mark - event response
- (void)switchTableView:(UIButton *)sender
{
    if (sender == self.blogButton) {
        self.draftButton.selected = NO;
        [self.scrollView setContentOffset:CGPointZero animated:YES];
    } else {
        self.blogButton.selected = NO;
        [self.scrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
    }
    sender.selected = YES;
}

#pragma mark - private methods
- (UIButton *)buttonWithTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(switchTableView:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - getters
- (UIButton *)blogButton
{
    if (_blogButton == nil) {
        _blogButton = [self buttonWithTitle:@"博客"];
        _blogButton.selected = YES;
    }
    return _blogButton;
}

- (UIButton *)draftButton
{
    if (_draftButton == nil) {
        _draftButton = [self buttonWithTitle:@"草稿"];
    }
    return _draftButton;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:kScreenBounds];
        scrollView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
        scrollView.scrollEnabled = NO;
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (MVCDraftTableviewHelper *)draftTableViewHelper
{
    if (_draftTableViewHelper == nil) {
        _draftTableViewHelper = [MVCDraftTableviewHelper instanceWithUserId:self.userId];
    }
    return _draftTableViewHelper;
}


@end
