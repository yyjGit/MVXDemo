//
//  UIView+Controller.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/9.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Controller)


/**
 获取view所属控制器

 @return 控制器
 */
- (UIViewController *)viewController;


/**
 获取当前控制器的导航控制器

 @return 导航控制器
 */
- (UINavigationController *)navigationController;

@end
