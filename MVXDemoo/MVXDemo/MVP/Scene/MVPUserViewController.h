//
//  MVPUserViewController.h
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/9.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MVPUserViewController : UIViewController

/**
 类初始化方法

 @param userId 用户id
 @return vc
 */
+ (instancetype)instanceWithUserId:(NSUInteger)userId;

@end
