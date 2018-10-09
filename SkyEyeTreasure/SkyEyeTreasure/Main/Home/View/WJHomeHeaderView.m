//
//  WJHomeHeaderView.m
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/13.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import "WJHomeHeaderView.h"
#import "WJHomeStatuView.h"
#import "UIImage+GIF.h"


@interface WJHomeHeaderView ()

@property (nonatomic, strong) NSMutableArray *itemArray;

@end

@implementation WJHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpCustomView];
    }
    return self;
}

- (void)setUpCustomView
{
    self.itemArray = [NSMutableArray arrayWithCapacity:3];
    for (NSInteger i = 0; i < 3; i++) {
        WJHomeStatuView *homeStatuView = [[WJHomeStatuView alloc] initWithFrame:CGRectMake(i * (kScreenWidth / 3), 0, kScreenWidth / 3, 95)];
        [self addSubview:homeStatuView];
        
        [_itemArray addObject:homeStatuView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enterWarningOrder:)];
        
        [homeStatuView addGestureRecognizer:tapGesture];
    }
}

- (void)reloadData:(WJHomeResultModel *)homeResultModel
{
    if (homeResultModel.light.count == 3 && _itemArray.count == 3) {
        
        for (NSInteger i = 0; i < homeResultModel.light.count; i++) {
            WJOrderLaterModel *orderLaterModel = homeResultModel.light[i];
            WJHomeStatuView *homeStatuView = _itemArray[i];
            
            if ([orderLaterModel.num integerValue] > 0) {
                NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]]pathForResource:@"home_Warning" ofType:@"gif"];
                NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
                homeStatuView.warningImageView.image = [UIImage sd_animatedGIFWithData:imageData];
            } else {
                
                NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]]pathForResource:@"home_noWarning" ofType:@"gif"];
                NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
                homeStatuView.warningImageView.image = [UIImage sd_animatedGIFWithData:imageData];

            }
            
            homeStatuView.orderWarningNumLabel.text = [NSString stringWithFormat:@"%@",orderLaterModel.num];
            
            
            if ([orderLaterModel.type integerValue] == 1) {
                //到仓
                homeStatuView.orderStatuLabel.text = @"到仓";
            } else if ([orderLaterModel.type integerValue] == 2) {
                //提货
                homeStatuView.orderStatuLabel.text = @"提货";
            } else {
                homeStatuView.orderStatuLabel.text = @"签收";
            }
        }
        

    }
}

- (void)enterWarningOrder:(UITapGestureRecognizer *)tap
{
    WJHomeStatuView *homeStatuView = (WJHomeStatuView *)tap.view;
    NSInteger indexStatu = [self.itemArray indexOfObject:homeStatuView];
    
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@(indexStatu)];
    }
}

@end
