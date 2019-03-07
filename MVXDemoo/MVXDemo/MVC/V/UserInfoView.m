
//
//  UserInfoView.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/5.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "UserInfoView.h"

@interface UserInfoView ()

@property (nonatomic, strong) UIButton *iconButton;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, copy) void(^userIconClickEventHander)(void);


@end

@implementation UserInfoView

#pragma mark - life cycle
- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        [self addSubview:self.iconButton];
        [self addSubview:self.usernameLabel];
        [self layoutPageSubviews];
    }
    return self;
}


#pragma mark - private methods
- (void)layoutPageSubviews
{
    [self.iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(14);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.iconButton.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(20);
    }];
}

#pragma mark - event response
- (void)userIconButtonAction:(UIButton *)sender
{
    if (self.userIconClickEventHander) {
        self.userIconClickEventHander();
    }
}

#pragma mark - setters
- (void)setUserIcon:(NSString *)userIcon
{
    [self.iconButton setImage:[UIImage imageNamed:userIcon] forState:UIControlStateNormal];
}

- (void)setUsername:(NSString *)username
{
    self.usernameLabel.text = username;
}

- (void)setIconClickEventHandler:(void (^)(void))iconClickEventHandler
{
    _userIconClickEventHander = iconClickEventHandler;
}

#pragma mark - getters
- (UILabel *)usernameLabel
{
    if (_usernameLabel == nil) {
        _usernameLabel = [[UILabel alloc] init];
        _usernameLabel.font = [UIFont systemFontOfSize:16];
        _usernameLabel.textColor = [UIColor blackColor];
        _usernameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _usernameLabel;
}

- (UIButton *)iconButton
{
    if (_iconButton == nil) {
        _iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_iconButton setBackgroundColor:[UIColor redColor]];    
        [_iconButton setFrame:CGRectMake(0, 0, 60, 60)];
        [_iconButton addTarget:self action:@selector(userIconButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_iconButton yj_setCornerRadius:self.iconButton.width/2];
    }
    return _iconButton;
}

@end
