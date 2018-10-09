//
//  WJUpdateNotificationView.m
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/15.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import "WJUpdateNotificationView.h"

@interface WJUpdateNotificationView ()

@property (nonatomic, strong) UIView *backGoundView;
@property (nonatomic, strong) UIButton *sureUpdateButton;
@property (nonatomic, strong) UILabel *findNewVersionLabel;
@property (nonatomic, strong) UILabel *updateContentLabel;


@end


@implementation WJUpdateNotificationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews
{
    [self addSubview:self.backGoundView];
    
    UIView *writeBackView = [[UIView alloc] init];
    writeBackView.backgroundColor = [UIColor whiteColor];
    writeBackView.layer.masksToBounds = YES;
    writeBackView.layer.cornerRadius = 8;
    [self addSubview:writeBackView];
    
    [writeBackView makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo((kScreenWidth - 40) * 0.81);
        make.width.equalTo(kScreenWidth - 40);
        make.center.equalTo(self);
    }];

    
    UIImageView *backWriteImageView = [[UIImageView alloc] init];
    backWriteImageView.image = [UIImage imageNamed:@"other_update"];
    backWriteImageView.userInteractionEnabled = YES;
    [writeBackView addSubview:backWriteImageView];
    
    [backWriteImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(0);
        make.height.equalTo((kScreenWidth - 40) * 0.285);
    }];

    UILabel *updateTitleLabel = [[UILabel alloc] init];
    updateTitleLabel.text = @"新版本特性";
    updateTitleLabel.textAlignment = NSTextAlignmentLeft;
    updateTitleLabel.textColor = WJBlackTextColor;
    updateTitleLabel.font = [UIFont boldSystemFontOfSize:15];
    [writeBackView addSubview:updateTitleLabel];
    
    [updateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-20);
        make.left.equalTo(20);
        make.top.equalTo(backWriteImageView.bottom);
        make.height.equalTo(40);
    }];
    
    [writeBackView addSubview:self.findNewVersionLabel];
    
    [_findNewVersionLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(0);
        make.height.equalTo(backWriteImageView).multipliedBy(0.8);
    }];
    
    [writeBackView addSubview:self.sureUpdateButton];
    
    [_sureUpdateButton makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(0);
        make.height.equalTo(40);
        make.right.left.equalTo(0);
    }];
    
    [writeBackView addSubview:self.updateContentLabel];
    
    
    [_updateContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.top.equalTo(updateTitleLabel.bottom);
        make.bottom.equalTo(self.sureUpdateButton.top);
    }];

    

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    if ([[touches anyObject].view isEqual:self.backGoundView]) {
        [self removeFromSuperview];
    }
}

- (void)seeNoticeDetail:(UIButton *)noticeButton
{
//    
//    if ([self.delegate respondsToSelector:@selector(enterNoticeDetail)]) {
//        [self.delegate enterNoticeDetail];
//    }
}

// 判断View是否显示在屏幕上
- (BOOL)isDisplayedInScreen
{
    if (self == nil) {
        return FALSE;
    }
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    // 转换view对应window的Rect
    CGRect rect = [self convertRect:self.frame fromView:nil];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return FALSE;
    }
    
    // 若view 隐藏
    if (self.hidden) {
        return FALSE;
    }
    
    // 若没有superview
    if (self.superview == nil) {
        return FALSE;
    }
    
    // 若size为CGrectZero
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return  FALSE;
    }
    
    // 获取 该view与window 交叉的 Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return FALSE;
    }
    
    return TRUE;
}


- (UIView *)backGoundView {
    if (!_backGoundView) {
        _backGoundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight)];
        
        _backGoundView.backgroundColor = [UIColor blackColor];
        _backGoundView.alpha = 0.4;
    }
    
    return _backGoundView;
}

- (UILabel *)findNewVersionLabel
{
    if (!_findNewVersionLabel) {
        _findNewVersionLabel = [[UILabel alloc] init];
        _findNewVersionLabel.text = @"发现新版本2.0.0";
        _findNewVersionLabel.textAlignment = NSTextAlignmentCenter;
        _findNewVersionLabel.textColor = [UIColor whiteColor];
        _findNewVersionLabel.font = FONT(30);
    }
    
    return _findNewVersionLabel;
}

- (UILabel *)updateContentLabel
{
    if (!_updateContentLabel) {
        _updateContentLabel = [[UILabel alloc] init];
        _updateContentLabel.text = @"1.新增一些功能\n2. 实时跟踪司机配送情况\n3. 增加打电话和预警提示";
        _updateContentLabel.textAlignment = NSTextAlignmentLeft;
        _updateContentLabel.textColor = WJDarkGrayTextColor;
        _updateContentLabel.font = FONT(14);
        _updateContentLabel.numberOfLines = 0;
    }
    
    return _updateContentLabel;
}


- (UIButton *)sureUpdateButton
{
    if (!_sureUpdateButton) {
        _sureUpdateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_sureUpdateButton setTitle:@"更新" forState:UIControlStateNormal];
        [_sureUpdateButton setTitleColor:WJMainBlueColor forState:UIControlStateNormal];
        
        [_sureUpdateButton addTarget:self action:@selector(seeNoticeDetail:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _sureUpdateButton;
}


@end
