//
//  MVCDraftTableviewCtr.h
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/6.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserAPIManager.h"
@class Draft;

/**
 MVCDraftTableviewCtr作用：
 1、获取草稿列表数据
 2、布局tableView
 3、创建DraftCellCtr
 */
@interface MVCDraftTableviewHelper : NSObject

/**
 类初始化方法

 @param userId 用户id
 @return MVCDraftTableviewCtr 实例
 */
+ (instancetype)instanceWithUserId:(NSUInteger)userId;

/**
 获取数据
 */
- (void)fetchData;

/**
 点击cell后回调

 @param didSelectRowHandler 对点击事件的处理
 */
- (void)setDidSelectRowHandler:(void (^)(Draft *))didSelectRowHandler;

// 返回tableView
- (UITableView *)tableView;

@end
