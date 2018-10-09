//
//  WJMacros.h
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/13.
//  Copyright © 2018年 王兵. All rights reserved.
//

#ifndef WJMacros_h
#define WJMacros_h


#ifdef DEBUG
#define WJLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define WJLog(format, ...)
#endif


#define WJWeak(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define WJStrong(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

#define kScreenHeight [ UIScreen mainScreen ].bounds.size.height
#define kScreenWidth  [ UIScreen mainScreen ].bounds.size.width

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)




#endif /* WJMacros_h */
