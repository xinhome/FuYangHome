//
//  SetPasswordViewController.m
//  家居定制
//
//  Created by iKing on 2017/3/17.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "SetPasswordViewController.h"

@interface SetPasswordViewController ()
@property (nonatomic, weak) UITextField *password;///<<#注释#>
@property (nonatomic, weak) UITextField *confirmPwd;///<<#注释#>
@end

@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorWhite;
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    backgroundView.image = UIImageNamed(@"bgview");
    [self.view addSubview:backgroundView];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(0, rateHeight(28), 190, 130)];
    logo.centerX = kScreenWidth/2;
    logo.image = UIImageNamed(@"logo ");
    [self.view addSubview:logo];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, rateHeight(215), rateWidth(325), 120)];
    view.layer.cornerRadius = 7;
    view.layer.masksToBounds = YES;
    view.centerX = self.view.centerX;
    view.backgroundColor = RGB(245, 245, 245);
    [self.view addSubview:view];
    
    UITextField *tel = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, view.width, 60)];
    self.password = tel;
    tel.delegate = self;
    tel.leftView = [self leftView:@"设置密码:"];
    tel.leftViewMode = UITextFieldViewModeAlways;
    tel.secureTextEntry = YES;
    [view addSubview:tel];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, tel.bottom, view.width, 1)];
    line.backgroundColor = RGB(225, 225, 225);
    [view addSubview:line];
    
    UITextField *password = [[UITextField alloc] initWithFrame:CGRectMake(0, 61, view.width, 60)];
    self.confirmPwd = password;
    password.secureTextEntry = YES;
    password.delegate = self;
    password.leftView = [self leftView:@"确认密码:"];
    password.leftViewMode = UITextFieldViewModeAlways;
    password.placeholder = @"请输入密码";
    [view addSubview:password];
    
    UIButton *back = [UIButton buttonWithTitle:@"<  返回" fontSize:13 titleColor:RGB(48, 210, 183) background:[UIColor clearColor] cornerRadius:0];
    [back addActionHandler:^{
        [self popViewController];
    }];
    back.frame = CGRectMake(view.left+10, view.bottom+15, 50, 15);
    [self.view addSubview:back];
    
    UIButton *login = [UIButton buttonWithTitle:@"完成" fontSize:16 titleColor:UIColorWhite background:RGB(48, 210, 183) cornerRadius:22.5];
    [login addActionHandler:^{
        [self finish];
    }];
    login.frame = CGRectMake(0, back.bottom+20, rateWidth(325), 45);
    login.centerX = kScreenWidth/2;
    [self.view addSubview:login];
}

- (void)finish {
    if (self.password.text.length == 0) {
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }
    if (self.confirmPwd.text.length == 0) {
        [MBProgressHUD showError:@"请再次输入密码"];
        return;
    }
    if (![self.password.text isEqualToString:self.confirmPwd.text]) {
        [MBProgressHUD showError:@"两次密码不一致"];
        return;
    }
    NSDictionary *parameters = @{
                                 @"password": self.password.text,
                                 @"pone": self.tel
                                 };
    [MBProgressHUD showMessage:@"正在注册..." toView:self.view];
    [[HttpRequestManager shareManager] addPOSTURL:@"/FyjjController/mima" person:RequestPersonYuChuan parameters:parameters success:^(id successResponse) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([successResponse isSuccess]) {
            [MBProgressHUD showSuccess:@"注册成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

- (UIView *)leftView:(NSString *)text {
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = [UIColor clearColor];
    leftView.frame = CGRectMake(0, 0, 90, 40);
    UILabel *lbl = [UILabel labelWithText:text textColor:RGB(176, 176, 176) fontSize:16];
    [leftView addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(leftView).offset(-10);
        make.centerY.equalTo(leftView);
    }];
    return leftView;
}

@end
