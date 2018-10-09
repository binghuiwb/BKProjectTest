//
//  WJSkyEyeBaseViewController.m
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/13.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import "WJSkyEyeBaseViewController.h"

@interface WJSkyEyeBaseViewController ()

@end

@implementation WJSkyEyeBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = WJBacKGroundColor;
    
    NSInteger controllerIndex = (NSInteger)[self.navigationController.viewControllers indexOfObject:self];
    
    if (controllerIndex > 0)
    {
        [self showBackBtn];
    }
}

- (void)showBackBtn
{
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"other_goBack"] style:UIBarButtonItemStylePlain target:self action:@selector(doBackController)];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)doBackController
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 设置左边的按钮
- (void)setLeftButton:(NSString *)buttonName
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //backBtn.backgroundColor = [UIColor yellowColor];
    
    [backBtn setFrame:CGRectMake(0, 0, 30, 30)];
    
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0,0, 30 - 13)];
    
    [backBtn setImage:[UIImage imageNamed:@"btn-back-black.png"] forState:UIControlStateNormal];
    if (buttonName)
    {
        if (![buttonName isEqualToString:@""])
        {
            [backBtn setImage:nil forState:UIControlStateNormal];
            [backBtn setTitle:buttonName forState:UIControlStateNormal];
            [backBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [backBtn setFrame:CGRectMake(0, 0, 16*[buttonName length], 30)];
        }
        
    }
    [backBtn addTarget:self action:@selector(doLeftAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark - 批量设置右边的按钮(根据图片)
- (void)setRightButton:(NSArray *)buttonImageNames
{
    NSMutableArray *rightItems = [NSMutableArray array];
    for (int i = 0; i < [buttonImageNames count]; i ++) {
        NSString *buttonName = [NSString stringWithFormat:@"%@",[buttonImageNames objectAtIndex:i]];
        UIImage *img = [UIImage imageNamed:buttonName];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setFrame:CGRectMake(0, 0, img.size.width+10, 44)];
        [rightBtn setImage:img forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(doRightAction:) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn setTag:i];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        [rightItems addObject:rightItem];
    }
    self.navigationItem.rightBarButtonItems = rightItems;
}
#pragma mark - 批量设置右边的按钮(根据名称)
- (void)setRightButtonWithTitle:(NSArray *)titleNames
{
    NSMutableArray *rightItems = [NSMutableArray array];
    for (int i = 0; i < [titleNames count]; i ++)
    {
        NSString *titleName = [NSString stringWithFormat:@"%@",[titleNames objectAtIndex:i]];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setTag:i];
        [rightBtn setTitle:titleName forState:UIControlStateNormal];
        [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [rightBtn setFrame:CGRectMake(0, 0, 18*[titleName length], 44)];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightBtn setBackgroundColor:[UIColor clearColor]];
        [rightBtn addTarget:self action:@selector(doRightAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        [rightItems addObject:rightItem];
    }
    self.navigationItem.rightBarButtonItems = rightItems;
}

- (void)setRightButtonWithTitle:(NSArray *)titleNames UIColor:(UIColor *)color
{
    NSMutableArray *rightItems = [NSMutableArray array];
    for (int i = 0; i < [titleNames count]; i ++)
    {
        NSString *titleName = [NSString stringWithFormat:@"%@",[titleNames objectAtIndex:i]];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setTag:i];
        [rightBtn setTitle:titleName forState:UIControlStateNormal];
        [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [rightBtn setFrame:CGRectMake(0, 0, 18*[titleName length], 44)];
        [rightBtn setTitleColor:color forState:UIControlStateNormal];
        [rightBtn setBackgroundColor:[UIColor clearColor]];
        [rightBtn addTarget:self action:@selector(doRightAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        [rightItems addObject:rightItem];
    }
    self.navigationItem.rightBarButtonItems = rightItems;
}

#pragma mark - 创建导航栏按钮
-(void)addNavBtnFrame:(CGRect)frame bgImage:(NSString *)bgImageName isSetImage:(BOOL)setImage title:(NSString *)title target:(id)target action:(SEL)action isLeftL:(BOOL)isLeft
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    
    if (bgImageName)
    {
        if (setImage)
        {
            [btn setImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:bgImageName] forState:UIControlStateHighlighted];
        }
        else
        {
            [btn setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateHighlighted];
        }
        
    }
    
    
    
    if (title)
    {
        [btn setTitle:title forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    if (target && action)
    {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    if (isLeft)
    {
        self.navigationItem.leftBarButtonItem = item;
    }
    else
    {
        self.navigationItem.rightBarButtonItem = item;
    }
}

#pragma mark - 导航栏左边事件
- (void)doLeftAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 导航栏右边事件
- (void)doRightAction:(UIButton *)sender
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
