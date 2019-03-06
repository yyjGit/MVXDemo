
//
//  UserDetailViewController.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/6.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "UserDetailViewController.h"

#import "User.h"
#import "Blog.h"
#import "Draft.h"

#import "UIView+Extension.h"
#import "UserBlogListViewController.h"

@interface UserDetailViewController ()

@end

@implementation UserDetailViewController

+ (instancetype)instanceWithUser:(User *)user
{
    return [[UserDetailViewController alloc] initWithWithUser:user];
}

- (instancetype)initWithWithUser:(User *)user
{
    if (self = [super init]) {
        self.title = user.name;
        self.view.backgroundColor = [UIColor greenColor];
    }
    return self;
}

@end

@implementation BlogDetailViewController

+ (instancetype)instanceWithBlog:(Blog *)blog
{
    return [[BlogDetailViewController alloc] initWithWithBlog:blog];
}

- (instancetype)initWithWithBlog:(Blog *)blog
{
    if (self = [super init]) {
        
        self.title = blog.blogTitle;
        self.view.backgroundColor = [UIColor redColor];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth, 50)];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:@"SceneX" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(toBlogListViewController) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    return self;
}

- (void)toBlogListViewController
{
    [self.navigationController pushViewController:[UserBlogListViewController new] animated:YES];
}

@end

@implementation DraftDetailViewController

+ (instancetype)instanceWithDraft:(Draft *)draft {
    return [[DraftDetailViewController alloc] initWithDraft:draft];
}

- (instancetype)initWithDraft:(Draft *)draft {
    if (self = [super init]) {
        
        self.title = draft.draftTitle;
        self.view.backgroundColor = [UIColor blueColor];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth, 50)];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:@"SceneY" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(toSceneY) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    return self;
}

- (void)toSceneY
{
    [self.navigationController pushViewController:[UserBlogListViewController  new] animated:YES];
}

@end



