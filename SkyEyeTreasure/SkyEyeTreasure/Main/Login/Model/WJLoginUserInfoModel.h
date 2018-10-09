//
//  WJLoginUserInfoModel.h
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/17.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJLoginUserInfoModel : NSObject

@property (nonatomic,copy)NSString * userId;//用户Id
@property (nonatomic,copy)NSString * appToken;//用户token
@property (nonatomic,copy)NSString * userName;
@property (nonatomic,copy)NSString * password;//密码
@property (nonatomic, assign) BOOL isRememberPassword; //是否记录密码

@property (nonatomic, assign) BOOL isLogin; //是否登录状态

- (BOOL)archiveLoginUserInfo;

+ (WJLoginUserInfoModel *)unArchiveLoginUserInfo;


@end
