//
//  MVCDraftTableViewCell.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/5.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "MVCDraftTableViewCell.h"

@interface MVCDraftTableViewCell ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *summaryLabel;
@property (strong, nonatomic) UILabel *editDateLabel;

@end

@implementation MVCDraftTableViewCell

#pragma mark - life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.summaryLabel];
        [self.contentView addSubview:self.editDateLabel];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma mark - public methods
- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setSummary:(NSString *)summary
{
    self.summaryLabel.text = summary;
}

- (void)setEditDate:(NSString *)editDate
{
    self.editDateLabel.text = editDate;
}


#pragma mark - private methods
- (void)layoutPageSubviews
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(88);
    }];
    
    
    [self.editDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(0);
        make.width.mas_equalTo(120);
    }];
    
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(10);
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(8);
        make.right.mas_equalTo(self.editDateLabel.mas_left).mas_offset(0);
    }];
}

#pragma mark - getters
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UILabel *)summaryLabel
{
    if (_summaryLabel == nil) {
        _summaryLabel = [[UILabel alloc] init];
        _summaryLabel.font = [UIFont systemFontOfSize:13];
        _summaryLabel.textColor = [UIColor darkGrayColor];
    }
    return _summaryLabel;
}

- (UILabel *)editDateLabel
{
    if (_editDateLabel == nil) {
        _editDateLabel = [[UILabel alloc] init];
        _editDateLabel.font = [UIFont systemFontOfSize:12];
        _editDateLabel.textColor = [UIColor darkGrayColor];
    }
    return _editDateLabel;
}


@end
