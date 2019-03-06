//
//  MVCDraftTableviewCellCtr.h
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/6.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Draft;

@interface MVCDraftTableviewCellHelper : NSObject

+ (instancetype)helperWithDraft:(Draft *)draft;

- (Draft *)draft;

- (NSString *)draftEditDate;
- (NSString *)draftTitleText;
- (NSString *)draftSummaryText;

@end
