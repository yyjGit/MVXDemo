//
//  UserDetailViewController.h
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/6.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User, Blog, Draft;


@interface UserDetailViewController : UIViewController
+ (instancetype)instanceWithUser:(User *)user;
@end

@interface BlogDetailViewController : UIViewController
+ (instancetype)instanceWithBlog:(Blog *)blog;
@end

@interface DraftDetailViewController : UIViewController
+ (instancetype)instanceWithDraft:(Draft *)draft;
@end
