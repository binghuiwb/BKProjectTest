//
//  WJGlobalRequestManage.m
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/15.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import "WJGlobalRequestManage.h"

@implementation WJGlobalRequestManage

+ (WJGlobalRequestManage *)shareManage {
    static WJGlobalRequestManage *sharedObject = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (!sharedObject) {
            sharedObject = [[[self class] alloc] init];
        }
    });
    
    return sharedObject;
}


- (void)updateVersionInfo
{
    
    self.updateVersionSubject = [RACSubject subject];
    
    
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:@"17000000041" forKey:@"loginName"];
    
    NSMutableDictionary *bigDict = [NSMutableDictionary dictionary];
    NSString *str1 = [NSString stringWithFormat:@"/api/user/updateVer"];
    
    [bigDict setObject:str1 forKey:@"action"];
    [bigDict setObject:data forKey:@"data"];
    
    [[WJNetWorkingManage sharedManager] AFNHttpRequestPOSTParameters:bigDict success:^(NSDictionary *responseDic) {
        //        if ([responseDic[@"result"][@"isExistsNewVersion"] boolValue]) {
        //            if (!version.result.isUpdate) {
        //                [alertVC addAction:cancelAction];
        //                [alertVC addAction:OKAction];
        //            }else {
        //                [alertVC addAction:OKAction];
        //            }
        //        }
        
        
        
        [self.updateVersionSubject sendNext:@"1"];
    } failure:^(NSError *error) {
        
    }];
}

- (void)loginOut
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    
    [paramDic setValue:WJLoginOutAction forKey:@"action"];
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    
    [paramDic setValue:dataDic forKey:@"data"];
    
    [[WJNetWorkingManage sharedManager] AFNHttpRequestPOSTParameters:paramDic success:^(NSDictionary *responseDic) {
        
        if ([responseDic[WJCode] integerValue] == 200) {
            
            WJLoginUserInfoModel *userInfoModel = [WJLoginUserInfoModel unArchiveLoginUserInfo];
            
            userInfoModel.isLogin = NO;
            
            [userInfoModel archiveLoginUserInfo];
            
            [[WJAppDelegateManage shareManage] setUpLoginViewController];
                    
        } else {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:responseDic[WJMsg]];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:WJNetWorkMessage];
    }];
    
}



@end
