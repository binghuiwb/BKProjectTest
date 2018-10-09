//
//  WJSkyEyeTabBarController.m
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/13.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import "WJSkyEyeTabBarController.h"
#import "WJSkyEyeNavigationController.h"
#import "WJSkyEyeBaseViewController.h"
#import "WJUpdateNotificationView.h"

static NSString* const kTabTitleKey = @"title";
static NSString* const kTabClassKey = @"rootVCName";
static NSString* const kTabImageNormalKey = @"imageNameNormal";
static NSString* const kTabImageSelectKey = @"imageNameSelect";
static NSString* const kTabTitleColorKey = @"titleColor";

@interface WJSkyEyeTabBarController ()

@property (nonatomic, assign) BOOL isAlertView;


@end

@implementation WJSkyEyeTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMainViewComtroller];
    
//    [self updateVersionAction];
    
    
    self.isAlertView = YES;

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOutNotification:) name:WJLoginAgainNotification object:nil];

}

- (void)loginOutNotification:(NSNotificationCenter *)notification
{
    
    [[WJAppDelegateManage shareManage] setUpLoginViewController];

}

- (void)updateVersionAction
{
    
    [[WJGlobalRequestManage shareManage] updateVersionInfo];

    // 2.订阅信号
    [[WJGlobalRequestManage shareManage].updateVersionSubject subscribeNext:^(id x) {
    
        WJUpdateNotificationView *updateView = [[WJUpdateNotificationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        //    updateView.delegate = self;
        [self.view addSubview:updateView];

    }];

}

- (void)setupMainViewComtroller
{
    NSArray *dataArray = @[
                           @{kTabClassKey      : @"WJHomeViewController",
                             kTabTitleKey      : @"首页",
                             kTabImageNormalKey : @"home_tabbar_nomal",
                             kTabImageSelectKey : @"home_tabbar_select",
                             kTabTitleColorKey : @"",
                             },
                           @{kTabClassKey      : @"WJOrderViewController",
                             kTabTitleKey      : @"订单",
                             kTabImageNormalKey : @"order_tabbar_nomal",
                             kTabImageSelectKey : @"order_tabbar_select",
                             kTabTitleColorKey : @"",
                             },
                           @{kTabClassKey      : @"WJPersonalViewController",
                             kTabTitleKey      : @"我的",
                             kTabImageNormalKey : @"personal_tabbar_nomal",
                             kTabImageSelectKey : @"personal_tabbar_select",
                             kTabTitleColorKey : @"",
                             },
                           ];
    @WJWeak(self);
    [dataArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        @WJStrong(self);
        WJSkyEyeBaseViewController *baseVC = [[NSClassFromString(dict[kTabClassKey]) alloc] init];
        baseVC.title = dict[kTabTitleKey];
        
        WJSkyEyeNavigationController *navi = [[WJSkyEyeNavigationController alloc] initWithRootViewController:baseVC];
        UITabBarItem *item = navi.tabBarItem;
        item.title = dict[kTabTitleKey];
        item.image = [UIImage imageNamed:dict[kTabImageNormalKey]];
        item.selectedImage = [UIImage imageNamed:dict[kTabImageSelectKey]];
        
        NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
        normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
        [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
        
        [self addChildViewController:navi];
    }];
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
