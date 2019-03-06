//
//  MVCUserViewController.h
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/5.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LoginUserId 123

@interface MVCUserViewController : UIViewController

@property (assign, nonatomic) NSUInteger userId;

/**
 类初始化方法

 @param userId 用户id
 @return controller
 */
+ (instancetype)instanceWithUserId:(NSUInteger)userId;

@end
