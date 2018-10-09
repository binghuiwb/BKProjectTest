//
//  WJLoginUserInfoModel.m
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/17.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import "WJLoginUserInfoModel.h"

#import "WZXArchiverManager.h"
#import "NSObject+WZXArchiver.h"


@implementation WJLoginUserInfoModel

- (BOOL)archiveLoginUserInfo
{
    return [self wzx_archiveToName:@"WJLoginUserInfoModel"];
}

+ (WJLoginUserInfoModel *)unArchiveLoginUserInfo
{
    WJLoginUserInfoModel *loginUserInfoModel = [WJLoginUserInfoModel wzx_unArchiveToName:@"WJLoginUserInfoModel"];
    
    return loginUserInfoModel;
}

@end
