//
//  WJUtilityHelper.m
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/15.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import "WJUtilityHelper.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@implementation WJUtilityHelper



+ (NSString *)jsonStringWithDict:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

+(BOOL)isBlank : (NSString *)string {
    
    if ( string == nil || string == NULL || [ string isEqualToString : @"(null)" ] || [ string isEqualToString : @"" ]) {
        return YES ;
    }
    
    if ( [string isKindOfClass:[NSNull class]] ) {
        return YES ;
    }
    
    if ( [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0 ) {
        return YES ;
    }
    return NO ;
}

+ (void)callPhone:(NSString *)phoneNumber {
    
    if ([WJUtilityHelper isBlank:phoneNumber]) {
        return;
    }
    
    NSString *callPhone = [NSString stringWithFormat:@"tel://%@", phoneNumber];
    
    if (@available(iOS 10, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
    
}





@end
