//
//  WJConfigurationConstant.m
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/13.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import "WJConfigurationConstant.h"

/*
 发布需知 1.修改为正式地址
 2.修改不同版本的bundleId，并且修改版本号
 3.修改配置为release
 
 */

#define  WJReleaseVersion //要打包正式版本

// 同样
#ifdef WJReleaseVersion
//正式地址
NSString * const constAPIBaseIP         = @"http://weijie56-union.com:9800" ;
NSString * const WJEyeSkyHTMLUrl          = @"http://weijie56-union.com/h5/semapp/#";


#else
//测试地址
NSString * const constAPIBaseIP         = @"http://47.97.96.162:9026" ;

NSString *const WJEyeSkyHTMLUrl          = @"http://weijie56-union.com/h5/tianyanapp/#";

#endif


