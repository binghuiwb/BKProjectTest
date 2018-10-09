//
//  WJHomeStatuView.m
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/13.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import "WJHomeStatuView.h"

@implementation WJHomeStatuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.backgroundColor = WJMainBlueColor;

        [self setUpCustomView];
    }
    return self;
}

- (void)setUpCustomView
{
    
    [self addSubview:self.orderWarningNumLabel];
    
    [_orderWarningNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(self.frame.size.height/2 - 25);
        make.centerX.equalTo(self);
        make.size.equalTo(CGSizeMake(50, 25));
    }];
    
    [self addSubview:self.orderStatuLabel];
    
    [_orderStatuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderWarningNumLabel.bottom);
        make.centerX.equalTo(self);
        make.size.equalTo(self.orderWarningNumLabel);
    }];
    
    
    [self addSubview:self.warningImageView];
    
    [_warningImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.orderWarningNumLabel.left);
        make.top.equalTo(self.orderWarningNumLabel.top);
        make.size.equalTo(CGSizeMake(20, 20));
    }];
    
    UIImageView *nextImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_next"]];

    [self addSubview:nextImageView];

    [nextImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderWarningNumLabel.right);
        make.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(6, 11.5));
    }];




    
}

- (UIImageView *)warningImageView
{
    if (!_warningImageView) {
        _warningImageView = [[UIImageView alloc] init];
        
    }
    
    return _warningImageView;
}

- (UILabel *)orderWarningNumLabel
{
    if (!_orderWarningNumLabel) {
        _orderWarningNumLabel = [[UILabel alloc] init];
        _orderWarningNumLabel.font = FONT(24);
        _orderWarningNumLabel.textColor = [UIColor whiteColor];
        _orderWarningNumLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _orderWarningNumLabel;

}

- (UILabel *)orderStatuLabel
{
    if (!_orderStatuLabel) {
        _orderStatuLabel = [[UILabel alloc] init];
        _orderStatuLabel.font = FONT(12);
        _orderStatuLabel.textColor = [UIColor whiteColor];
        _orderStatuLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _orderStatuLabel;
}


@end
