//
//  LoginViewController.m
//  家居定制
//
//  Created by iKing on 2017/3/17.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "LoginViewController.h"
#import "registViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()
@property (nonatomic, weak) UITextField *tel;///
@property (nonatomic, weak) UITextField *password;///<<#注释#>
@end

@implementation LoginViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorWhite;
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    backgroundView.image = UIImageNamed(@"bgview");
    [self.view addSubview:backgroundView];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(0, rateHeight(28), 190, 130)];
    logo.centerX = kScreenWidth/2;
    logo.image = UIImageNamed(@"logo");
    [self.view addSubview:logo];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, rateHeight(215), rateWidth(325), 120)];
    view.layer.cornerRadius = 7;
    view.layer.masksToBounds = YES;
    view.centerX = self.view.centerX;
    view.backgroundColor = RGB(245, 245, 245);
    [self.view addSubview:view];
    
    UITextField *tel = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, view.width, 60)];
    self.tel = tel;
    tel.delegate = self;
    tel.leftView = [self leftView:@"main"];
    tel.leftViewMode = UITextFieldViewModeAlways;
    tel.placeholder = @"请输入手机号登录";
    [view addSubview:tel];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, tel.bottom, view.width, 1)];
    line.backgroundColor = RGB(225, 225, 225);
    [view addSubview:line];
    
    UITextField *password = [[UITextField alloc] initWithFrame:CGRectMake(0, 61, view.width, 60)];
    self.password = password;
    password.secureTextEntry = YES;
    password.delegate = self;
    password.leftView = [self leftView:@"pwd"];
    password.leftViewMode = UITextFieldViewModeAlways;
    password.placeholder = @"请输入密码";
    [view addSubview:password];
    
    UIButton *back = [UIButton buttonWithTitle:@"<  返回" fontSize:13 titleColor:RGB(48, 210, 183) background:[UIColor clearColor] cornerRadius:0];
    [back addActionHandler:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    back.frame = CGRectMake(view.left+10, view.bottom+15, 50, 15);
    [self.view addSubview:back];
    
    UIButton *registerBtn = [UIButton buttonWithTitle:@"立即注册" fontSize:13 titleColor:RGB(48, 210, 183) background:[UIColor clearColor] cornerRadius:0];
    [registerBtn addActionHandler:^{
        [self pushViewController:[[RegisterViewController alloc] init] animation:YES];
    }];
    registerBtn.frame = CGRectMake(0, view.bottom+15, 80, 15);
    registerBtn.right = view.right-10;
    [self.view addSubview:registerBtn];
    
    UIButton *login = [UIButton buttonWithTitle:@"登录" fontSize:16 titleColor:UIColorWhite background:RGB(48, 210, 183) cornerRadius:22.5];
    [login addActionHandler:^{
        [self login];
    }];
    login.frame = CGRectMake(0, back.bottom+20, rateWidth(325), 45);
    login.centerX = kScreenWidth/2;
    [self.view addSubview:login];
    
    UIButton *forget = [UIButton buttonWithTitle:@"忘记密码" fontSize:13 titleColor:RGB(48, 210, 183) background:[UIColor clearColor] cornerRadius:0];
    forget.frame = CGRectMake(0, login.bottom+10, 80, 15);
    forget.right = registerBtn.right;
    [self.view addSubview:forget];
}

- (void)login {
    if (self.password.text.length == 0) {
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }
    if (![self.tel.text isMobileNumber]) {
        [MBProgressHUD showError:@"输入正确手机号"];
        return;
    }
    [MBProgressHUD showMessage:@"正在登录..." toView:self.view];
    NSDictionary *parameters = @{@"pone": self.tel.text, @"password": self.password.text};
    [[HttpRequestManager shareManager] addPOSTURL:@"/FyjjController/yy" person:RequestPersonYuChuan parameters:parameters success:^(id successResponse) {
        [MBProgressHUD hideHUDForView:self.view];
//        NSLog(@"登录%@", successResponse);
        if ([successResponse isSuccess]) {
            NSDictionary *data = successResponse[@"data"];
            User *user = [User mj_objectWithKeyValues:data];
            [[UserUtil shareInstance] saveUser:user];
            [self dismissViewControllerAnimated:YES completion:nil];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:data[@"id"] forKey:@"myUserId"];
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"登录失败"];
    }];
}

- (UIView *)leftView:(NSString *)text {
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = [UIColor clearColor];
    leftView.frame = CGRectMake(0, 0, 50, 50);
    UIImageView *iv = [[UIImageView alloc] init];
    iv.image = UIImageNamed(text);
    [leftView addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.equalTo(@12);
        make.width.height.equalTo(@25);
    }];
    return leftView;
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
