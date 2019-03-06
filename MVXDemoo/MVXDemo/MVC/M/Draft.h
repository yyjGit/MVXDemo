//
//  Draft.h
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/5.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Draft : NSObject

@property (copy, nonatomic) NSString *draftTitle;
@property (copy, nonatomic) NSString *draftSummary;
@property (assign, nonatomic) NSUInteger draftId;
@property (assign, nonatomic) NSUInteger editDate;

- (instancetype)initWithDraftId:(NSUInteger)draftId;
@end
