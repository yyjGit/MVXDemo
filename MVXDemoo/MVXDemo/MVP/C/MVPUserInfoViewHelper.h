//
//  MVPUserInfoViewHelper.h
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/9.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserAPIManager.h"
#import "MVPUserInfoView.h"
#import "MVPUserInfoViewPresenter.h"

@class UserDetailViewController;

@interface MVPUserInfoViewHelper : NSObject

/**
 类初始化方法
 
 @param userId 用户id
 @return infoViewPresenter
 */
+ (instancetype)helperWithUserId:(NSUInteger)userId;

/**
 生成用户详情vc

 @param vcGenerator vc生成器
 */
- (void)setUserDetailVcGenerator:(ViewControllerGenerator)vcGenerator;
           
/**
 用户信息presenter

 @return presenter
 */
- (MVPUserInfoViewPresenter *)presenter;

/**
 用户信息视图

 @return infoView
 */
- (MVPUserInfoView *)infoView;

@end

