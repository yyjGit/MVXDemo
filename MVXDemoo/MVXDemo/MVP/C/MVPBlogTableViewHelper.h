//
//  MVPBlogTableViewHelper.h
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/9.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVPBlogTableViewPresenter.h"

@interface MVPBlogTableViewHelper : NSObject

@property (nonatomic, readonly) MVPBlogTableViewPresenter *presenter; // 
@property (nonatomic, readonly) UITableView *tableView;

/**
 类初始化方法

 @param userId 用户id
 @return blogHelper
 */
+ (instancetype)helperWithUserId:(NSUInteger)userId;

/**
 生成博客详情vc
 
 @param vcGenerator vc生成器
 */
- (void)setBlogDetailVcGenerator:(ViewControllerGenerator)vcGenerator;

@end
