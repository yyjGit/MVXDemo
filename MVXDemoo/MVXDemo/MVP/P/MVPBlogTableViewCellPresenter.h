//
//  MVPBlogTableViewCellPresenter.h
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/9.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserAPIManager.h"
@class MVPBlogTableViewCellPresenter, Blog;

@protocol MVPBlogTableViewCellPresenterDelegate <NSObject>

- (void)blogTableViewCellPresenterDidUpdateLikeState:(MVPBlogTableViewCellPresenter *)presenter;
- (void)blogTableViewCellPresenterDidUpdateShareState:(MVPBlogTableViewCellPresenter *)presenter;

@end

@interface MVPBlogTableViewCellPresenter : NSObject

@property (nonatomic, readonly) Blog *blog;
@property (nonatomic, readonly) BOOL isLiked; // 是否点赞
@property (nonatomic, readonly) NSString *blogTitle; // 博客标题
@property (nonatomic, readonly) NSString *blogSummary; // 博客摘要
@property (nonatomic, readonly) NSString *blogLikeCount; // 点赞数
@property (nonatomic, readonly) NSString *blogShareCount; // 分享数

@property (nonatomic, weak) id<MVPBlogTableViewCellPresenterDelegate> delegate; // 事件回调

/**
 类初始化方法

 @param blog 博客对象
 @return cellPresenter
 */
+ (instancetype)presenterWithBlog:(Blog *)blog;

/**
 点赞事件
 */
- (void)likeBlogCompletionHandler:(NetworkCompletionHandler)completionHandler;

/**
 分享事件
 */
- (void)shareBlogCompletionHandler:(NetworkCompletionHandler)completionHandler;


@end
