//
//  UserAPIManager.h
//  MVC
//
//  Created by 黑花白花 on 2017/3/8.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NetworkCompletionHandler)(NSError *error, id result);
typedef UIViewController *(^ViewControllerGenerator)(id params);//为了方便 但实际开发肯定不会定义在API里面

typedef enum : NSUInteger {
    NetworkErrorNoData,
    NetworkErrorNoMoreData
} NetworkError;

@interface UserAPIManager : NSObject
// 假装我有一堆网络请求 其实并没有
// 获取用户信息
- (void)fetchUserInfoWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler;
// 刷新用户草稿
- (void)refreshUserDraftsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler;
// 加载更多草稿
- (void)loadModeUserDraftsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler;
// 删除指定草稿
- (void)deleteDraftWithDraftId:(NSUInteger)draftId completionHandler:(NetworkCompletionHandler)completionHandler;
// 刷新用户博客
- (void)refreshUserBlogsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler;
// 加载更多博客
- (void)loadMoreUserBlogsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler;
// 点赞博客
- (void)likeBlogWithBlogId:(NSUInteger)blogId completionHandler:(NetworkCompletionHandler)completionHandler;

@end
