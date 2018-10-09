//
//  WJClientOrderInfoModel.h
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/21.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import "JSONModel.h"

@protocol WJClientOrderInfoModel @end


@interface WJClientOrderInfoModel : JSONModel

@property (nonatomic, copy) NSString *unFinished;
@property (nonatomic, copy) NSString *totalOrder;
@property (nonatomic, copy) NSString *finished;
@property (nonatomic, copy) NSString *clientName;
@property (nonatomic, copy) NSString *clientId;


@end
