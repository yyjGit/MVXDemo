//
//  UserInfoView.h
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/5.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;

@interface UserInfoView : UIView

/**
 设置用户名

 @param username 用户名
 */
- (void)setUsername:(NSString *)username;

/**
 设置用户头像

 @param userIcon 用户头像
 */
- (void)setUserIcon:(NSString *)userIcon;

/**
 头像点击事件处理

 @param iconClickEventHandler 点击回调处理
 */
- (void)setIconClickEventHandler:(void(^)(void))iconClickEventHandler;

@end
