//
//  MVPUserInfoView.h
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/9.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVPUserInfoViewPresenter.h"

@interface MVPUserInfoView : UIView <MVPUserInfoViewPresenterDelegate>

/**
 头像点击事件处理
 
 @param iconClickEventHandler 点击回调处理
 */
- (void)setIconClickEventHandler:(void(^)(void))iconClickEventHandler;

@end
