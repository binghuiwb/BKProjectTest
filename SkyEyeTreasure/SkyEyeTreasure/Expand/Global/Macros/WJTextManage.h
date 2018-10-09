//
//  WJTextManage.h
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/13.
//  Copyright © 2018年 王兵. All rights reserved.
//

#ifndef WJTextManage_h
#define WJTextManage_h


//根据RGB 获取自定义颜色
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define logoutErrorCode 999

#define kReceiptMaxPhotoCount 8
#define kScreenShotMaxPhotoCount 4




//按钮的tag值
#define BtnTag                      10000

//textFiled textView的tag值
#define textTag                     20000

//tableview 的tag值
#define tableViewTag                40000

//背景灰色
#define WJBacKGroundColor           [UIColor hex_colorWithHex:@"#f5f5f5"]

//橘黄色
#define WJOrangeColor               [UIColor hex_colorWithHex:@"#eb6100"]

//黑色
#define WJBlackTextColor            [UIColor hex_colorWithHex:@"#333333"]

//深灰色
#define WJDarkGrayTextColor         [UIColor hex_colorWithHex:@"#666666"]

//背景深灰色
#define WJDarkGrayBackGroundColor   [UIColor hex_colorWithHex:@"#e0e0df"]

//绿色126234
#define WJGreenTextColor            [UIColor hex_colorWithHex:@"#18be47"]

#define WJMainBlueColor             [UIColor hex_colorWithHex:@"#1c7ffe"]

//设置字体大小
#define FONT(s)                 [UIFont systemFontOfSize:s]

#endif /* WJTextManage_h */
