//
//  WJHomeCell.h
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/14.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJClientOrderInfoModel.h"

@interface WJHomeCell : UITableViewCell

- (void)reloadData:(WJClientOrderInfoModel *)clientInfoModel;

@end
