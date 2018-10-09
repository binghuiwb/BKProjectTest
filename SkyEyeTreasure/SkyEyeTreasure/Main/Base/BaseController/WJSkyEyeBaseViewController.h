//
//  WJSkyEyeBaseViewController.h
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/13.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJSkyEyeBaseViewController : UIViewController

#pragma mark - 设置左边的按钮
/**
 *  设置左边的按钮
 *
 *  @param buttonName 设置左边的按钮名称
 */
- (void)setLeftButton:(NSString *)buttonName;


#pragma mark - 批量设置右边的按钮(根据图片)
/**
 *  批量设置右边的按钮(根据图片)
 *
 *  @param buttonImageNames 图片名称
 */
- (void)setRightButton:(NSArray *)buttonImageNames;


#pragma mark - 批量设置右边的按钮(根据名称)
/**
 *  批量设置右边的按钮(根据名称)
 *
 *  @param titleNames 名称
 */
- (void)setRightButtonWithTitle:(NSArray *)titleNames;

/**
 *  批量设置右边的按钮(根据名称,并且可以设置按钮颜色)
 *
 *  @param titleNames 名称
 */
- (void)setRightButtonWithTitle:(NSArray *)titleNames UIColor:(UIColor *)color;

#pragma mark - 创建导航栏按钮
/**
 *  创建导航栏按钮
 *
 *  @param frame       位置
 *  @param bgImageName 背景
 *  @param title       名称
 *  @param target      target
 *  @param action      action
 *  @param isLeft      左边/右边
 */
-(void)addNavBtnFrame:(CGRect)frame bgImage:(NSString *)bgImageName isSetImage:(BOOL)setImage title:(NSString *)title target:(id)target action:(SEL)action isLeftL:(BOOL)isLeft;

#pragma mark - 导航栏左边事件
/**
 *  导航栏左边事件
 */
- (void)doLeftAction:(UIButton *)sender;

#pragma mark - 导航栏右边事件
/**
 *  导航栏右边事件
 */
- (void)doRightAction:(UIButton *)sender;

@end
