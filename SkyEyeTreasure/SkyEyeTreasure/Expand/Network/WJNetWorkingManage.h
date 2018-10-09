//
//  WJNetWorkingManage.h
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/13.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJNetWorkingManage : NSObject

+(WJNetWorkingManage *)sharedManager;

///**
// GET请求
//
// @param timeout 时间
// @param success 成功回调
// @param failue 失败回调
// */
//-(void)AFNHttpRequestGETWithUrlstring:(NSString *)url timeout:(NSInteger)timeout success:(void(^)(id responseDic))success failure:(void (^)(NSError *error))failue;



/**
 POST请求
 @param parmDic 请求体
 @param success 成功回调
 @param failue 失败回调
 */
-(void)AFNHttpRequestPOSTParameters:(NSMutableDictionary *)parmDic
                  success:(void(^)(NSDictionary *responseDic))success
                  failure:(void (^)(NSError *error))failue;

@end
