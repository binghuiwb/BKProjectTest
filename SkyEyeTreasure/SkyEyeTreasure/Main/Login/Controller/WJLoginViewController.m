//
//  WJLoginViewController.m
//  SkyEyeTreasure
//
//  Created by 王兵 on 2018/8/13.
//  Copyright © 2018年 王兵. All rights reserved.
//

#import "WJLoginViewController.h"
#import "WJLoginResultModel.h"
#import "WJTextField.h"

@interface WJLoginViewController ()

@property (nonatomic, strong) WJTextField *userNameTextField;
@property (nonatomic, strong) WJTextField *passwdwordTextField;
@property (nonatomic, strong) UIButton *rememberButton;


@end

@implementation WJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpCustomSubView];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor clearColor];
    }
    
    WJLoginUserInfoModel *loginUserInfoModel = [WJLoginUserInfoModel unArchiveLoginUserInfo];
    
    if (loginUserInfoModel && loginUserInfoModel.isRememberPassword) {
        self.passwdwordTextField.text = loginUserInfoModel.password;
        self.userNameTextField.text = loginUserInfoModel.userName;
    }
}

- (void)loginIn:(UIButton *)loginButton
{
    [self.view endEditing:YES];
    
    if ([WJUtilityHelper isBlank:self.userNameTextField.text]) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入用户名"];
        
        return;
    };
    
    if ([WJUtilityHelper isBlank:self.passwdwordTextField.text]) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入密码"];
        
        return;
    };
    
//    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
//
//    [paramDic setValue:WJLoginInAction forKey:@"action"];
//
//    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
//
//    [dataDic setValue:self.passwdwordTextField.text forKey:@"pwd"];
//    [dataDic setValue:self.userNameTextField.text forKey:@"userName"];
//
//    [paramDic setValue:dataDic forKey:@"data"];
//
//    [SVProgressHUD showWithStatus:@"登录中..."];
//
//    [[WJNetWorkingManage sharedManager] AFNHttpRequestPOSTParameters:paramDic success:^(NSDictionary *responseDic) {
//
//        [SVProgressHUD dismiss];
//
//        if ([responseDic[WJCode] integerValue] == 200) {
//
//            WJLoginResultModel *loginResult  = [[WJLoginResultModel alloc] initWithDictionary:responseDic[WJResult] error:nil];
//
//            WJLoginUserInfoModel *userInfoModel = [[WJLoginUserInfoModel alloc] init];
//
//            userInfoModel.userName = self.userNameTextField.text;
//            userInfoModel.password = self.passwdwordTextField.text;
//            userInfoModel.isRememberPassword = self.rememberButton.isSelected;
//            userInfoModel.isLogin = YES;
//            userInfoModel.userId = loginResult.userId;
//            userInfoModel.appToken = loginResult.appToken;
//
//            if ([userInfoModel archiveLoginUserInfo]) {
                [[WJAppDelegateManage shareManage] setUpHomeViewController];
//            } else {
//                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请重新点击登录"];
//            }
//            
//        } else {
//            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:responseDic[WJMsg]];
//        }
//        
//    } failure:^(NSError *error) {
//        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:WJNetWorkMessage];
//    }];
}

- (void)rememberPassword:(UIButton *)remeberPasswordButton
{
    remeberPasswordButton.selected = !remeberPasswordButton.isSelected;
}

- (void)setUpCustomSubView
{
    
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_backGround.jpg"]];
    [self.view addSubview:backImageView];
    
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    UIImageView *logoImage = [[UIImageView alloc] init];
    logoImage.image = [UIImage imageNamed:@"login_logo"];
    [self.view addSubview:logoImage];
    
    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(118);
        make.height.equalTo(55);
        make.width.equalTo(371/2);
    }];
    
    [self.view addSubview:self.userNameTextField];
    
    
    [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImage.mas_bottom).offset(74);
        make.centerX.equalTo(self.view);
        make.width.equalTo(kScreenWidth - 70);
        make.height.equalTo(45);
    }];
    
    [self.view addSubview:self.passwdwordTextField];
    
    [self.passwdwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameTextField.mas_bottom).offset(19);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.userNameTextField.mas_width);
        make.height.equalTo(45);
    }];

    [self.view addSubview:self.rememberButton];
    
    [self.rememberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwdwordTextField.mas_bottom).offset(10);
        make.left.equalTo(self.userNameTextField.mas_left);
        make.width.equalTo(100);
        make.height.equalTo(30);
    }];
    
    //创建登录注册按钮
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.layer.masksToBounds = YES;
    loginButton.layer.cornerRadius = 3;
    loginButton.backgroundColor = WJMainBlueColor;
    [loginButton addTarget:self action:@selector(loginIn:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:loginButton];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rememberButton.mas_bottom).offset(40);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.userNameTextField.mas_width);
        make.height.equalTo(45);
    }];
    
}

- (WJTextField *)userNameTextField
{
    if (!_userNameTextField) {
        //创建用户名和密码框；
        _userNameTextField = [[WJTextField alloc] init];
        _userNameTextField.borderStyle = UITextBorderStyleNone;
        _userNameTextField.placeholder = @"请输入用户名";
        UIImageView *loginimage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, 30, 24)];
        loginimage.image = [UIImage imageNamed:@"login_userName"];
        _userNameTextField.leftView = loginimage;
        _userNameTextField.leftViewMode = UITextFieldViewModeAlways;
        _userNameTextField.backgroundColor = [UIColor whiteColor];
        _userNameTextField.layer.masksToBounds = YES;
        _userNameTextField.layer.cornerRadius = 3;
        _userNameTextField.font = FONT(14);

    }
    
    return _userNameTextField;
}

- (WJTextField *)passwdwordTextField
{
    if (!_passwdwordTextField) {
        _passwdwordTextField = [[WJTextField alloc] init];
        _passwdwordTextField.borderStyle = UITextBorderStyleNone;
        _passwdwordTextField.placeholder = @"请输入密码";
        _passwdwordTextField.secureTextEntry = YES;
        _passwdwordTextField.keyboardType = UIKeyboardTypeEmailAddress;
        UIImageView *passwdimage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, 30, 24)];
        passwdimage.contentMode = UIViewContentModeScaleAspectFit;
        passwdimage.image = [UIImage imageNamed:@"login_password"];
        _passwdwordTextField.leftView = passwdimage;
        _passwdwordTextField.leftViewMode = UITextFieldViewModeAlways;
        _passwdwordTextField.backgroundColor = [UIColor whiteColor];
        _passwdwordTextField.layer.masksToBounds = YES;
        _passwdwordTextField.layer.cornerRadius = 3;
        _passwdwordTextField.font = FONT(14);

    }
    
    return _passwdwordTextField;
}

- (UIButton *)rememberButton
{
    if (!_rememberButton) {
        //创建登录注册按钮
        _rememberButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rememberButton setTitle:@"记住密码" forState:UIControlStateNormal];
        [_rememberButton setTitleColor:WJOrangeColor forState:UIControlStateNormal];
        _rememberButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        _rememberButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _rememberButton.titleLabel.font = FONT(12);
        [_rememberButton setImage:[UIImage imageNamed:@"login_noRemberPassword"] forState:UIControlStateNormal];
        [_rememberButton setImage:[UIImage imageNamed:@"login_remberPassword"] forState:UIControlStateSelected];
        _rememberButton.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
        
        
        WJLoginUserInfoModel *loginUserInfoModel = [WJLoginUserInfoModel unArchiveLoginUserInfo];
        
        if (loginUserInfoModel) {
            _rememberButton.selected = loginUserInfoModel.isRememberPassword;
        } else {
            _rememberButton.selected = YES;
        }
        

        [_rememberButton addTarget:self action:@selector(rememberPassword:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    return _rememberButton;
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
