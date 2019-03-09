//
//  MVPUserInfoViewPresenter.h
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/9.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MVPUserInfoViewPresenter, User;

@protocol MVPUserInfoViewPresenterDelegate <NSObject>

@required
- (void)userInfoViewPresenter:(MVPUserInfoViewPresenter *)presenter didFetchUserInfoWithResult:(id)result error:(NSError *)error;

@end

@interface MVPUserInfoViewPresenter : NSObject

/** 代理，获取信息后的回调 */
@property (nonatomic, weak) id<MVPUserInfoViewPresenterDelegate> delegate;
/** 用户 */
@property (nonatomic, readonly) User *user;

/**
 类初始化方法

 @param userId 用户id
 @return infoViewPresenter
 */
+ (instancetype)presenterWithUserId:(NSUInteger)userId;

/**
 获取用户信息数据
 */
- (void)fetchUserInfo;

@end
