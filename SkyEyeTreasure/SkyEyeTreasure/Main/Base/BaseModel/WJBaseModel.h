//
//  WJBaseModel.h
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/15.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import "JSONModel.h"

@interface WJBaseModel : JSONModel

@property (nonatomic,assign) NSNumber *code;
@property (nonatomic,copy) NSString *msg;

@end
