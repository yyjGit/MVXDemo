//
//  Blog.h
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/5.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Blog : NSObject

@property (copy, nonatomic) NSString *blogTitle;
@property (copy, nonatomic) NSString *blogSummary;
@property (assign, nonatomic) BOOL isLiked;
@property (assign, nonatomic) NSUInteger blogId;
@property (assign, nonatomic) NSUInteger likeCount;
@property (assign, nonatomic) NSUInteger shareCount;


/**
 初始化方法

 @param blogId 博客id
 @return blog
 */
- (instancetype)initWithBlogId:(NSUInteger)blogId;

@end

