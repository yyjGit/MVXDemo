//
//  Draft.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/5.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "Draft.h"

@implementation Draft

- (instancetype)initWithDraftId:(NSUInteger)draftId
{    
    self.draftId = draftId;
    self.draftTitle = [NSString stringWithFormat:@"draftTitle%ld", draftId];
    self.draftSummary = [NSString stringWithFormat:@"draftSummary%ld", draftId];
    self.editDate = [[NSDate date] timeIntervalSince1970] + arc4random() % 200;
    
    return self;
}

@end
