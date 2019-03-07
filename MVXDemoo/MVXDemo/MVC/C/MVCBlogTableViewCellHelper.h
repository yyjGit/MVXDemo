//
//  MVCBlogTableViewCellMediator.h
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/5.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Blog.h"

@interface MVCBlogTableViewCellHelper : NSObject

+ (instancetype)helperWithBlog:(Blog *)blog;

- (Blog *)blog;

- (BOOL)isLiked;
- (NSString *)blogTitleText;
- (NSString *)blogSummaryText;
- (NSString *)blogLikeCountText;
- (NSString *)blogShareCountText;

@end
