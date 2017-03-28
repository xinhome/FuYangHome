//
//  RegisterViewController.m
//  家居定制
//
//  Created by iKing on 2017/3/17.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "RegisterViewController.h"

#import "SetPasswordViewController.h"

@interface RegisterViewController ()
@property (nonatomic, weak) UIButton *sendSMS;///<发送验证码
@property (nonatomic, strong) NSTimer *timer;///<计时器
@property (nonatomic, assign) int timeCount;///< <#注释#>
@property (nonatomic, weak) UITextField *tel;///<<#注释#>
@property (nonatomic, weak) UITextField *smsTextField;///<<#注释#>
@end

@implementation RegisterViewController

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
    tel.keyboardType = UIKeyboardTypeNumberPad;
    self.tel = tel;
    tel.delegate = self;
    tel.leftView = [self leftView:@"账户:"];
    tel.leftViewMode = UITextFieldViewModeAlways;
    tel.placeholder = @"请输入手机号注册";
    [view addSubview:tel];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, tel.bottom, view.width, 1)];
    line.backgroundColor = RGB(225, 225, 225);
    [view addSubview:line];
    
    UITextField *password = [[UITextField alloc] initWithFrame:CGRectMake(0, 61, view.width-85-30, 60)];
    self.smsTextField = password;
    password.delegate = self;
    password.leftView = [self leftView:@"验证码:"];
    password.leftViewMode = UITextFieldViewModeAlways;
    password.placeholder = @"请输入密码";
    [view addSubview:password];
    
    UIButton *sendSMS = [UIButton buttonWithTitle:@"发送验证码" fontSize:15 titleColor:UIColorWhite background:RGB(48, 210, 183) cornerRadius:7];
    self.sendSMS = sendSMS;
    [sendSMS addActionHandler:^{
        [self sendSms];
    }];
    sendSMS.frame = CGRectMake(0, 0, 85, 40);
    sendSMS.right = view.right-30;
    sendSMS.centerY = password.centerY;
    [view addSubview:sendSMS];
    
    UIButton *back = [UIButton buttonWithTitle:@"<  返回" fontSize:13 titleColor:RGB(48, 210, 183) background:[UIColor clearColor] cornerRadius:0];
    [back addActionHandler:^{
        [self popViewController];
    }];
    back.frame = CGRectMake(view.left+10, view.bottom+15, 50, 15);
    [self.view addSubview:back];
    
    UIButton *registerBtn = [UIButton buttonWithTitle:@"已有账号" fontSize:13 titleColor:RGB(48, 210, 183) background:[UIColor clearColor] cornerRadius:0];
    [registerBtn addActionHandler:^{
        [self popViewController];
    }];
    registerBtn.frame = CGRectMake(0, view.bottom+15, 80, 15);
    registerBtn.right = view.right-10;
    [self.view addSubview:registerBtn];
    
    UIButton *login = [UIButton buttonWithTitle:@"下一步" fontSize:16 titleColor:UIColorWhite background:RGB(48, 210, 183) cornerRadius:22.5];
    [login addActionHandler:^{
        [self setPassword]; //设置密码 下一步
    }];
    login.frame = CGRectMake(0, back.bottom+20, rateWidth(325), 45);
    login.centerX = kScreenWidth/2;
    [self.view addSubview:login];
}

#pragma mark - 发送验证码
- (void)sendSms {
    if (self.tel.text.length == 0) {
        [MBProgressHUD showError:@"请输入手机号"];
        return;
    }
    if (![self.tel.text isMobileNumber]) {
        [MBProgressHUD showError:@"请输入正确的手机号"];
        return;
    }
    [MBProgressHUD showMessage:@"正在发送..." toView:self.view];
    [[HttpRequestManager shareManager] addPOSTURL:@"/FyjjController/my" person:RequestPersonYuChuan parameters:@{@"pone": self.tel.text} success:^(id successResponse) {
        NSLog(@"%@", successResponse);
        [MBProgressHUD hideHUDForView:self.view];
        if ([successResponse isSuccess]) {
            [MBProgressHUD showSuccess:@"发送成功"];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeIncreament) userInfo:nil repeats:YES];
            self.timeCount = 60;
            self.sendSMS.userInteractionEnabled = NO;
        } else {
            [MBProgressHUD showError:@"发送失败"];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"发送失败"];
    }];
}

- (void)setPassword {
    if (self.tel.text.length == 0) {
        [MBProgressHUD showError:@"请输入手机号"];
        return;
    }
    if (self.smsTextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入验证码"];
        return;
    }
    [MBProgressHUD showMessage:@"校验验证码" toView:self.view];
    NSLog(@"%@", @{@"pone": self.tel.text, @"verification_code": self.smsTextField.text});
    [[HttpRequestManager shareManager] addPOSTURL:@"/FyjjController/ma" person:RequestPersonYuChuan parameters:@{@"pone": self.tel.text, @"ma": self.smsTextField.text} success:^(id successResponse) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([successResponse isSuccess]) {
            SetPasswordViewController *controller = [[SetPasswordViewController alloc] init];
            controller.tel = self.tel.text;
            [self pushViewController:controller animation:YES];
        } else {
            [MBProgressHUD showError:@"校验失败"];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        //[MBProgressHUD showNetworkingError:error];
        [MBProgressHUD showError:@"校验失败"];
    }];
}

- (void)timeIncreament {
    if (self.timeCount < 0) {
        self.sendSMS.userInteractionEnabled = YES;
        [self.sendSMS setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
        return;
    }
    
    [self.sendSMS setTitle:[NSString stringWithFormat:@"%d", --self.timeCount] forState:UIControlStateNormal];
}

- (UIView *)leftView:(NSString *)text {
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = [UIColor clearColor];
    leftView.frame = CGRectMake(0, 0, 80, 40);
    UILabel *lbl = [UILabel labelWithText:text textColor:RGB(176, 176, 176) fontSize:16];
    [leftView addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(leftView).offset(-10);
        make.centerY.equalTo(leftView);
    }];
    return leftView;
}

@end
