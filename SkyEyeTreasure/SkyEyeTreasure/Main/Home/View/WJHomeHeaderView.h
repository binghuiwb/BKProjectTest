//
//  WJHomeHeaderView.h
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/13.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJHomeResultModel.h"

@interface WJHomeHeaderView : UIView

@property (nonatomic, strong) RACSubject *delegateSignal;

@property (nonatomic, strong) WJOrderLaterModel *orderLaterModel;

- (void)reloadData:(WJHomeResultModel *)homeResultModel;

@end
