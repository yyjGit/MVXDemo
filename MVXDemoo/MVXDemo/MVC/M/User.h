//
//  User.h
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/5.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *summary;
@property (assign, nonatomic) NSUInteger userId;
@property (assign, nonatomic) NSUInteger blogCount;
@property (assign, nonatomic) NSUInteger friendCount;

/**
 初始化user

 @param userId 用户id
 @return user
 */
- (instancetype)initWithUserId:(NSUInteger)userId;

@end
