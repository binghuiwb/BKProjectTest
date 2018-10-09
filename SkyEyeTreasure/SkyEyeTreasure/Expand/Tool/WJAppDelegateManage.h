//
//  WJAppDelegateManage.h
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/17.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJAppDelegateManage : NSObject

+ (WJAppDelegateManage *)shareManage;

//登录
-(void)setUpLoginViewController;

//首页
-(void)setUpHomeViewController;

//设置导航栏颜色
- (void)setUpNavigationBarStyle;



@end
