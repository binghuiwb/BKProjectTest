//
//  WJUtilityHelper.h
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/15.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJUtilityHelper : NSObject

+ (NSString *)jsonStringWithDict:(NSDictionary *)dict;

+ (BOOL)isBlank : (NSString *)string;

+ (void)callPhone:(NSString *)phoneNumber;



@end
