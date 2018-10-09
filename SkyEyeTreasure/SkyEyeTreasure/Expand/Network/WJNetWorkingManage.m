//
//  WJNetWorkingManage.m
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/13.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import "WJNetWorkingManage.h"
#import "AFNetworking.h"

@interface WJNetWorkingManage ()

//@property (nonatomic, strong) NSDateFormatter *timesTampDateFormat;

@end

@implementation WJNetWorkingManage

#pragma mark - 获取唯一单例
+(WJNetWorkingManage *)sharedManager
{
    static WJNetWorkingManage *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager)
        {
            manager = [[WJNetWorkingManage alloc]init];
            
        }
    });
    
    return manager;
}

//#pragma mark - AFN GET请求
//-(void)AFNHttpRequestGETWithUrlstring:(NSString *)url timeout:(NSInteger)timeout success:(void(^)(id responseDic))success failure:(void (^)(NSError *error))failue
//{
//    AFHTTPSessionManager  *session = [AFHTTPSessionManager manager];
//    
//    session.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    session.requestSerializer = [AFJSONRequestSerializer serializer];
//    
//    [session.requestSerializer setValue:@"ios" forHTTPHeaderField:@"cAgent"];
//    NSString *token = [WJUserCacheInfo shareData].token;
//    //    NSLog(@"token=%@",token);
//    [session.requestSerializer setValue:token forHTTPHeaderField:@"token"];
//    
//    [session.requestSerializer setValue:[self getTimestamp] forHTTPHeaderField:@"timestamp"];
//    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    [session.requestSerializer setValue:version forHTTPHeaderField:@"appVersionCode"];
//    
//    [session GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//        
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSDictionary *dict = (NSDictionary*)responseObject;
//        
//        WJLog(@"请求URL:%@\n请求结果********>%@",task.response.URL,dict);
//        
//        WJLog(@"-------------->%@",dict[@"Msg"]);
//        
//        
//        if (success)
//        {
//            success(dict);
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        WJLog(@"-----------*************%@",error);
//        
//        if (failue)
//        {
//            failue(error);
//        }
//        
//    }];
//    
//}



#pragma mark - AFN POST请求
-(void)AFNHttpRequestPOSTParameters:(NSMutableDictionary *)parmDic
                      success:(void(^)(NSDictionary *responseDic))success
                      failure:(void (^)(NSError *error))failue
{
    
    WJLoginUserInfoModel *loginUserInfoModel = [WJLoginUserInfoModel unArchiveLoginUserInfo];
    
    NSMutableDictionary *parmMutableDictionary = [NSMutableDictionary dictionary];
    
    if (loginUserInfoModel.appToken && loginUserInfoModel.isLogin) {
        [parmMutableDictionary setValue:loginUserInfoModel.appToken forKey:@"token"];
    }

    
    [parmMutableDictionary setValue:@"2" forKey:@"model"];
    
    if (loginUserInfoModel.userId && loginUserInfoModel.isLogin) {
        [parmMutableDictionary setValue:loginUserInfoModel.userId forKey:@"userId"];
    }
    
    NSString *versionString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [parmMutableDictionary setValue:versionString forKey:@"version"];
    
    if (loginUserInfoModel.isLogin) {
        [parmMutableDictionary setValue:@(loginUserInfoModel.isLogin) forKey:@"isAuth"];
    } else {
        [parmMutableDictionary setValue:@(NO) forKey:@"isAuth"];
    }
    
    [parmMutableDictionary addEntriesFromDictionary:parmDic];
    
    NSString *parmString = [self createSignParam:parmDic secret:WJSkyEyeAppSecret];
    
    [parmMutableDictionary setValue:parmString forKey:@"sign"];
    
    AFHTTPSessionManager  *session = [AFHTTPSessionManager manager];
    
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html", @"application/javascript", @"text/js", nil];
    
//    NSLog(@"接口开始时间：%@",[self getTimestamp]);
    
    [session POST:[NSString stringWithFormat:@"%@%@",@"http://192.168.0.42:8086",parmDic[@"action"]]  parameters:parmMutableDictionary progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        
        WJLog(@"请求url%@请求结果:%@",parmDic[@"action"],responseObject);
        
//        NSLog(@"接口完成时间：%@",[self getTimestamp]);
        
        if ([dict[WJCode] integerValue] == logoutErrorCode) {
            //异常登录

            [[NSNotificationCenter defaultCenter] postNotificationName:WJLoginAgainNotification object:dict];
            
            return;
        } else {
            
            if (success) {
                success(dict);
            }
            
        }

        
   
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error------------>%@",error);
        
        if (failue)
        {
            failue(error);
        }
    }];
    
}




- (NSString *)createSignParam:(NSMutableDictionary *)paramDic
                   secret:(NSString *)secret {

    
    NSDictionary *paraDic = paramDic[@"data"];
    
    if (!paraDic) {
        return @"";
    }
    
    // 第二步：按字典顺序将key排序(不区分大小写)
    NSArray *sortedArray = [[paraDic allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] ;
    
    // 第三步：按Key1Value1Key2Value2Key3Value3....的顺序将所有的键值按顺序拼接成一个字符串
    NSMutableString *query = [[NSMutableString alloc] init];
    for (NSString *key in sortedArray) {
        NSString *value = [[paraDic objectForKey:key] description];
        [query appendString:key];
        [query appendString:@"="];
        if (![WJUtilityHelper isBlank:value]) {
            [query appendString:value];
        }
        if (key != sortedArray.lastObject) {
            [query appendString:@"&"];
        }
    }
    
    [query appendString:secret];
    
//    NSString * str = [[NSStringalloc] initWithData:responseObjectencoding:NSUTF8StringEncoding];
    
    query = [[query stringByReplacingOccurrencesOfString:@"\r\n"withString:@""] mutableCopy];
    
    query = [[query stringByReplacingOccurrencesOfString:@"\n"withString:@""] mutableCopy];
    
    query = [[query stringByReplacingOccurrencesOfString:@"\t"withString:@""] mutableCopy];
    query = [[query stringByReplacingOccurrencesOfString:@" "withString:@""] mutableCopy];

    
    return [CryptoUtil md5:query];;
}

//- (NSString *)getTimestamp {
//
//    if (!_timesTampDateFormat) {
//        _timesTampDateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
//        [_timesTampDateFormat setDateFormat:@"yyyyMMddHHmmssSSS"];
//    }
//
//    NSString *date = [_timesTampDateFormat stringFromDate:[NSDate date]];
//    NSString *currentdateStr = [NSString stringWithFormat:@"%@", date];
//
//    return currentdateStr;
//}




@end
