//
//  MVCBlogTableViewCell.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/5.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "MVCBlogTableViewCell.h"


@interface MVCBlogTableViewCell ()

@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UILabel *summaryLabel;
@property (strong, nonatomic)  UIButton *giveLikeButton;
@property (strong, nonatomic)  UIButton *shareButton;

@property (copy, nonatomic) void(^giveLikeCallback)(void);

@end

@implementation MVCBlogTableViewCell

#pragma mark - life cycle 
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.summaryLabel];
        [self.contentView addSubview:self.giveLikeButton];
        [self.contentView addSubview:self.shareButton];
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

- (void)setLikeState:(BOOL)isLiked
{
    [self.giveLikeButton setTitleColor:isLiked ? [UIColor redColor] : [UIColor blackColor] forState:UIControlStateNormal];
}

- (void)setLikeCountText:(NSString *)likeCountText
{
    [self.giveLikeButton setTitle:likeCountText forState:UIControlStateNormal];
}

- (void)setShareCountText:(NSString *)shareCountText
{
    [self.shareButton setTitle:shareCountText forState:UIControlStateNormal];
}

- (void)setGiveLikeCallback:(void (^)(void))giveLikeCallback
{
    _giveLikeCallback = giveLikeCallback;
}

#pragma mark - event response
- (void)giveLikeButtonAction:(UIButton *)sender
{
    if (self.giveLikeCallback) {
        self.giveLikeCallback();
    }
}

#pragma mark - private methods
- (void)layoutPageSubviews
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(88);
    }];
    
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(8);
        make.right.mas_equalTo(self.giveLikeButton.mas_left).mas_offset(-8);
    }];

    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(60);
    }];

    [self.giveLikeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.shareButton);
        make.right.mas_equalTo(self.shareButton.mas_left).mas_offset(-8);
        make.width.mas_equalTo(60);
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
        _summaryLabel.font = [UIFont systemFontOfSize:12];
        _summaryLabel.textColor = [UIColor darkGrayColor];
    }
    return _summaryLabel;
}

- (UIButton *)giveLikeButton
{
    if (_giveLikeButton == nil) {
        _giveLikeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _giveLikeButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_giveLikeButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_giveLikeButton addTarget:self action:@selector(giveLikeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _giveLikeButton;
}

- (UIButton *)shareButton
{
    if (_shareButton == nil) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_shareButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
    return _shareButton;
}


@end
