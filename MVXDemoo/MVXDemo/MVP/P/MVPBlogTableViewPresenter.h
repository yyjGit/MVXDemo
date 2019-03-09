//
//  MVPBlogTableViewPresentor.h
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/9.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Blog.h"
#import "UserAPIManager.h"

@class MVPBlogTableViewPresenter, MVPBlogTableViewCellPresenter;

@protocol MVPBlogTableViewPresenterDelegate <NSObject>

@required
- (void)blogTableViewPresenter:(MVPBlogTableViewPresenter *)presenter didRefreshDataWithResult:(id)result error:(NSError *)error;

- (void)blogTableViewPresenter:(MVPBlogTableViewPresenter *)presenter didFetchMoreDataWithResult:(id)result error:(NSError *)error;

@end

@interface MVPBlogTableViewPresenter : NSObject

/** 代理，获取信息后的回调 */
@property (nonatomic, weak) id<MVPBlogTableViewPresenterDelegate> delegate;
/** 博客数组 */
@property (nonatomic, readonly) NSArray <MVPBlogTableViewCellPresenter *>*blogs;

/**
 类初始化方法
 
 @param userId 用户id
 @return bolgPresenter
 */
+ (instancetype)presenterWithUserId:(NSUInteger)userId;

/**
 刷新博客数据
 */
- (void)refreshBlogData;

/**
 加载更多数据
 */
- (void)loadMoreBlogData;

@end
