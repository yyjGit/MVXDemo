//
//  MVPUserViewController.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/9.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "MVPUserViewController.h"
#import "MVPUserInfoViewHelper.h"
#import "MVPBlogTableViewHelper.h"

#import "UserDetailViewController.h"

@interface MVPUserViewController ()

@property (nonatomic, strong) MVPUserInfoViewHelper *infoViewHelper;
@property (nonatomic, strong) MVPBlogTableViewHelper *blogTableViewHelper;
@property (nonatomic, assign) NSUInteger userId;
@end

@implementation MVPUserViewController

#pragma mark - 初始化方法
+ (instancetype)instanceWithUserId:(NSUInteger)userId
{
    return [[self alloc] initWithUserId:userId];
}

- (instancetype)initWithUserId:(NSUInteger)userId
{
    if (self = [super init]) {
        _userId = userId;
    }
    return self;
}

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.title = [NSString stringWithFormat:@"用户%ld", self.userId];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.infoViewHelper.infoView];
    [self.view addSubview:self.blogTableViewHelper.tableView];

    [self layoutPageSubviews];
    [self fetchData];
    [self configHelper];
}

#pragma mark - private methods
- (void)configHelper
{
    [self.infoViewHelper setUserDetailVcGenerator:^UIViewController *(id params) {
        return [UserDetailViewController instanceWithUser:params];
    }];
    
    [self.blogTableViewHelper setBlogDetailVcGenerator:^UIViewController *(id params) {
        return [BlogDetailViewController instanceWithBlog:params];
    }];
}

- (void)layoutPageSubviews
{
    [self.infoViewHelper.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
        make.height.mas_equalTo(150);
    }];
    
    [self.blogTableViewHelper.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_equalTo(self.infoViewHelper.infoView.mas_bottom);
    }];
}

- (void)fetchData
{
    [self.infoViewHelper.presenter fetchUserInfo];
    [self.blogTableViewHelper.presenter refreshBlogData];
}

#pragma mark - getters
- (MVPUserInfoViewHelper *)infoViewHelper
{
    if (_infoViewHelper == nil) {
        _infoViewHelper = [MVPUserInfoViewHelper helperWithUserId:self.userId];
    }
    return _infoViewHelper;
}

- (MVPBlogTableViewHelper *)blogTableViewHelper
{
    if (_blogTableViewHelper == nil) {
        _blogTableViewHelper = [MVPBlogTableViewHelper helperWithUserId:self.userId];
    }
    return _blogTableViewHelper;
}

@end
