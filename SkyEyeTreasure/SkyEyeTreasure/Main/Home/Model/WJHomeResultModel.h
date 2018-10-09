//
//  WJHomeResultModel.h
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/21.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import "JSONModel.h"
#import "WJOrderLaterModel.h"
#import "WJClientOrderInfoModel.h"

@interface WJHomeResultModel : JSONModel

@property (nonatomic, strong) NSArray<WJOrderLaterModel> *light;
@property (nonatomic, strong) NSArray<WJClientOrderInfoModel> *orderList;
@property (nonatomic, strong) NSNumber *totalPage;


@end
