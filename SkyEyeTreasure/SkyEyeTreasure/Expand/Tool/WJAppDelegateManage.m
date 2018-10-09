//
//  WJAppDelegateManage.m
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/17.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import "WJAppDelegateManage.h"

#import "WJSkyEyeTabBarController.h"
#import "WJLoginViewController.h"


@implementation WJAppDelegateManage

+ (WJAppDelegateManage *)shareManage {
    static WJAppDelegateManage *sharedObject = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (!sharedObject) {
            sharedObject = [[[self class] alloc] init];
        }
    });
    
    return sharedObject;
}

#pragma mark 自定义跳转不同的页面
//登录页面
-(void)setUpLoginViewController
{
    WJLoginViewController *logInVc = [[WJLoginViewController alloc]init];
    [UIApplication sharedApplication].delegate.window.rootViewController = logInVc;
    [UIApplication sharedApplication].delegate.window.backgroundColor = [UIColor whiteColor];
}

//首页
-(void)setUpHomeViewController
{
    WJSkyEyeTabBarController *tabBarController = [[WJSkyEyeTabBarController alloc] init];
    [[UIApplication sharedApplication].delegate.window setRootViewController:tabBarController];
    [UIApplication sharedApplication].delegate.window.backgroundColor = [UIColor whiteColor];
}

- (void)setUpNavigationBarStyle
{
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_bg_white_ios7"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBarTintColor:WJMainBlueColor];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    
}




@end
