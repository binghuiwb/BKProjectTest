//
//  WJHomeCell.m
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/14.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import "WJHomeCell.h"


@interface WJHomeCell()

@property (nonatomic, strong) YYLabel *allOrderLabel;
@property (nonatomic, strong) YYLabel *clientCompanyNameLabel;
@property (nonatomic, strong) YYLabel *completeOrderLabel;
@property (nonatomic, strong) YYLabel *noCompleteOrderLabel;


@end

@implementation WJHomeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = WJBacKGroundColor;
        [self setUpCustomSubview];
    }
    
    return self;
}

- (void)setUpCustomSubview
{
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(5, 15, 5, 15));
    }];
    
    [backView addSubview:self.allOrderLabel];
    
    [_allOrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.bottom.equalTo(0);
        make.width.equalTo(80);
    }];
    
    [backView addSubview:self.clientCompanyNameLabel];
    
    [_clientCompanyNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.allOrderLabel.right);
        make.top.equalTo(10);
        make.right.equalTo(backView.right).offset(-10);
        make.height.equalTo(30);
    }];
    
    [backView addSubview:self.completeOrderLabel];
    
    
    [_completeOrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.clientCompanyNameLabel.left);
        make.top.equalTo(self.clientCompanyNameLabel.bottom);
        make.size.equalTo(CGSizeMake((kScreenWidth-110)/2, 30));
    }];
    
    [backView addSubview:self.noCompleteOrderLabel];
    
    [_noCompleteOrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.completeOrderLabel.right);
        make.top.equalTo(self.clientCompanyNameLabel.bottom);
        make.size.equalTo(self.completeOrderLabel);
    }];

    
}

- (void)reloadData:(WJClientOrderInfoModel *)clientInfoModel
{
    NSMutableAttributedString *allOrderAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总订单\n%@",clientInfoModel.totalOrder]];
    
    allOrderAttributedString.yy_font = FONT(18);
    allOrderAttributedString.yy_color = WJMainBlueColor;
    [allOrderAttributedString yy_setColor:WJBlackTextColor range:NSMakeRange(0, 3)];
    [allOrderAttributedString yy_setFont:FONT(14) range:NSMakeRange(0, 3)];
    allOrderAttributedString.yy_lineSpacing = 10;
    
    self.allOrderLabel.attributedText = allOrderAttributedString;
    self.allOrderLabel.textAlignment = NSTextAlignmentCenter;
    
    self.clientCompanyNameLabel.text = clientInfoModel.clientName;
    
    NSMutableAttributedString *completeOrderAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已完成：%@",clientInfoModel.finished]];
    
    completeOrderAttributedString.yy_color = WJGreenTextColor;
    completeOrderAttributedString.yy_font = FONT(14);
    [completeOrderAttributedString yy_setColor:WJBlackTextColor range:NSMakeRange(0, 4)];
    
    self.completeOrderLabel.attributedText = completeOrderAttributedString;
    
    
    NSMutableAttributedString *noCompleteOrderAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"未完成：%@",clientInfoModel.unFinished]];
    
    noCompleteOrderAttributedString.yy_color = WJOrangeColor;
    noCompleteOrderAttributedString.yy_font = FONT(14);
    [noCompleteOrderAttributedString yy_setColor:WJBlackTextColor range:NSMakeRange(0, 4)];
    
    self.noCompleteOrderLabel.attributedText = noCompleteOrderAttributedString;


}

- (YYLabel *)allOrderLabel
{
    if (!_allOrderLabel) {
        _allOrderLabel = [[YYLabel alloc] init];
        _allOrderLabel.font = FONT(18);
        _allOrderLabel.textColor = WJMainBlueColor;
        _allOrderLabel.text = @"总订单\n1280";
        _allOrderLabel.textAlignment = NSTextAlignmentCenter;
        _allOrderLabel.numberOfLines = 0;

    }
    
    return _allOrderLabel;
}

- (YYLabel *)clientCompanyNameLabel
{
    if (!_clientCompanyNameLabel) {
        _clientCompanyNameLabel = [[YYLabel alloc] init];
        _clientCompanyNameLabel.font = FONT(16);
        _clientCompanyNameLabel.textColor = [UIColor blackColor];
        _clientCompanyNameLabel.text = @"上海小易科技有限公司";
        _clientCompanyNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _clientCompanyNameLabel;
}

- (YYLabel *)completeOrderLabel
{
    if (!_completeOrderLabel) {
        _completeOrderLabel = [[YYLabel alloc] init];
        _completeOrderLabel.font = FONT(14);
        _completeOrderLabel.textColor = WJBlackTextColor;
        _completeOrderLabel.text = @"已完成：1100";
        _completeOrderLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _completeOrderLabel;
}

- (YYLabel *)noCompleteOrderLabel
{
    if (!_noCompleteOrderLabel) {
        _noCompleteOrderLabel = [[YYLabel alloc] init];
        _noCompleteOrderLabel.font = FONT(14);
        _noCompleteOrderLabel.textColor = WJBlackTextColor;
        _noCompleteOrderLabel.text = @"未完成：180";
        _noCompleteOrderLabel.textAlignment = NSTextAlignmentLeft;    }
    
    return _noCompleteOrderLabel;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
