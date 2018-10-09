//
//  WJGlobalRequestManage.h
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/15.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJGlobalRequestManage : NSObject

+ (WJGlobalRequestManage *)shareManage;

@property (nonatomic, strong) RACSubject *updateVersionSubject;

- (void)updateVersionInfo;

/**
 退出登录，把WJLoginUserInfoModel 的islogin变为NO
 */
- (void)loginOut;


@end
