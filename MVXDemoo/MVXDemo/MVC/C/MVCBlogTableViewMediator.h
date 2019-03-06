//
//  MVCBlogTableViewMediator.h
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/5.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserAPIManager.h"

/*
    MVCBlogTableViewMediator作用：
    1、获取博客列表数据
    2、布局tableView
    3、创建cellMediator
 */
@interface MVCBlogTableViewMediator : NSObject

/**
 类初始化方法

 @param userId 用户id
 @return MVCBlogTableViewMediator实例
 */
+ (instancetype)instanceWithUserId:(NSUInteger)userId;

// 获取数据
- (void)fetchDataWithCompletionHandler:(NetworkCompletionHandler)completionHander;

- (UITableView *)tableView;

// vc生成器，点击cell后，生成将要push的控制器，在scene(MVCUserViewController)中实现
- (void)setVCGenerator:(ViewControllerGenerator)VCGenerator;
@end
