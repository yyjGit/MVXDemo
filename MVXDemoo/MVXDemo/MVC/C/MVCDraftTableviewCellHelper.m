//
//  MVCDraftTableviewCellCtr.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/6.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "MVCDraftTableviewCellHelper.h"
#import "Draft.h"

@interface MVCDraftTableviewCellHelper ()

@property (strong, nonatomic) Draft *draft;

@end

@implementation MVCDraftTableviewCellHelper


+ (instancetype)helperWithDraft:(Draft *)draft
{
    return [[self alloc] initWithDraft:draft];
}

- (instancetype)initWithDraft:(Draft *)draft
{
    if (self = [super init]) {
        self.draft = draft;
    }
    return self;
}

- (NSString *)draftEditDate
{
    NSUInteger date = self.draft.editDate > 0 ? self.draft.editDate : [[NSDate date] timeIntervalSince1970];
    return [[NSDate dateWithTimeIntervalSince1970:date] description];
}

- (NSString *)draftTitleText
{
    return self.draft.draftTitle.length > 0 ? self.draft.draftTitle : @"未命名";
}

- (NSString *)draftSummaryText
{
    return self.draft.draftSummary.length > 0 ? [NSString stringWithFormat:@"摘要: %@", self.draft.draftSummary] : @"写点什么吧~";
}


@end
