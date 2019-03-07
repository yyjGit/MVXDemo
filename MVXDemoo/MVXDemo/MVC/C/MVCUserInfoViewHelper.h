//
//  MVCUserInfoViewHelper.h
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/7.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserAPIManager.h"
@class UserInfoView;

@interface MVCUserInfoViewHelper : NSObject

/**
 类初始化方法

 @param userId 用户id
 @return userInfoViewHelper
 */
+ (instancetype)instanceWithUserId:(NSUInteger)userId;

/**
 获取数据
 */
- (void)fetchUserInfo;

/**
 点击头像头跳转

 @param vcGenerator vc生成器
 */
- (void)setVCGenerator:(ViewControllerGenerator)vcGenerator;

/**
 infoView

 @return infoView
 */
- (UserInfoView *)infoView;

@end
