//
//  WJLoginResultModel.h
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/15.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import "JSONModel.h"

@interface WJLoginResultModel : JSONModel

@property (nonatomic,copy)NSString * userId;//用户Id
@property (nonatomic,copy)NSString * appToken;//用户token

@end
