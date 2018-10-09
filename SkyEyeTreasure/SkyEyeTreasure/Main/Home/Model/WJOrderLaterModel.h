//
//  WJOrderLaterModel.h
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/21.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import "JSONModel.h"

@protocol WJOrderLaterModel @end

@interface WJOrderLaterModel : JSONModel

@property (nonatomic, strong) NSNumber *num;
@property (nonatomic, strong) NSNumber *type;

@end
