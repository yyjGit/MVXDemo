//
//  MVCBlogTableViewCell.h
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/5.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAPIManager.h"

@interface MVCBlogTableViewCell : UITableViewCell

- (void)setTitle:(NSString *)title;
- (void)setSummary:(NSString *)summary;
- (void)setLikeState:(BOOL)isLiked;
- (void)setLikeCountText:(NSString *)likeCountText;
- (void)setShareCountText:(NSString *)shareCountText;

// 点赞后回调
- (void)setGiveLikeCallback:(void (^)(void))giveLikeCallback;
@end
