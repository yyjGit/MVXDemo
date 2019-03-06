//
//  User.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/5.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithUserId:(NSUInteger)userId
{    
    self.name = [NSString stringWithFormat:@"user%lu",userId];
    self.icon = [NSString stringWithFormat:@"icon%lu.png", userId % 2];
    self.userId = userId;
    self.summary = [NSString stringWithFormat:@"userSummary%ld", userId];
    self.blogCount = userId + 8;
    self.friendCount = userId + 10;
    return self;
}

@end
