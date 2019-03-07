//
//  MVCUserViewController.h
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/5.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MVCUserInfoViewHelper, MVCBlogTableViewHelper;

#define LoginUserId 123

@interface MVCUserViewController : UIViewController

@property (assign, nonatomic, readonly) NSUInteger userId; // 用户id
@property (strong, nonatomic) MVCUserInfoViewHelper *userInfoHelper; // 用户信息viewHelper
@property (strong, nonatomic) MVCBlogTableViewHelper *blogHelper; // 博客tableViewHelper

/**
 类初始化方法

 @param userId 用户id
 @return controller
 */
+ (instancetype)instanceWithUserId:(NSUInteger)userId;

/**
 配置ViewHelper
 */
- (void)configHelper;

/**
 布局页面子视图
 */
- (void)layoutPageSubviews;

/**
 获取数据
 */
- (void)fetchData;


@end
