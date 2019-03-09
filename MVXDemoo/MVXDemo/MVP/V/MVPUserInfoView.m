//
//  MVPUserInfoView.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/9.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "MVPUserInfoView.h"
#import "User.h"

@interface MVPUserInfoView ()

@property (nonatomic, strong) UIButton *userIconButton;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, copy) void(^iconClickEventHandler)(void);

@end

@implementation MVPUserInfoView

#pragma mark - 初始化方法
- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.userIconButton];
        [self addSubview:self.usernameLabel];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma mark - MVPUserInfoViewPresenterDelegate
- (void)userInfoViewPresenter:(MVPUserInfoViewPresenter *)presenter didFetchUserInfoWithResult:(id)result error:(NSError *)error
{
    if (error) {
        [self showToastWithText:error.domain];
    } else {
        
        if ([result isKindOfClass:User.class]) {
            
            User *u = (User *)result;
            self.usernameLabel.text = u.name;
            [self.userIconButton setBackgroundImage:[UIImage imageNamed:u.icon] forState:UIControlStateNormal];
        }
    }
}

#pragma mark - private methods
- (void)layoutPageSubviews
{
    [self.userIconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(14);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.userIconButton.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(20);
    }];
}


#pragma mark - event response
- (void)userIconButtonAction:(UIButton *)sender
{
    if (self.iconClickEventHandler) {
        self.iconClickEventHandler();
    }    
}

#pragma mark - setters

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

- (UIButton *)userIconButton
{
    if (_userIconButton == nil) {
        _userIconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_userIconButton setBackgroundColor:[UIColor redColor]];
        [_userIconButton setFrame:CGRectMake(0, 0, 60, 60)];
        [_userIconButton addTarget:self action:@selector(userIconButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_userIconButton yj_setCornerRadius:self.userIconButton.width/2];
    }
    return _userIconButton;
}

@end
