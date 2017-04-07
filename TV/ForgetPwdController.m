//
//  ForgetPwdController.m
//  家居定制
//
//  Created by iKing on 2017/4/7.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "ForgetPwdController.h"
#import "ForgetPwd2Controller.h"

@interface ForgetPwdController ()
@property (nonatomic, strong) NSTimer *timer;///<<#注释#>
@property (nonatomic, assign) int timeCount;///< <#注释#>
@property (nonatomic, weak) UIButton *sendSMSBtn;///<<#注释#>
@end

@implementation ForgetPwdController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:RGB(67, 204, 182)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColorWhite}];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    UITextField *telephoneTF = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth-30, 50)];
    telephoneTF.placeholder = @"输入手机号";
    [self.view addSubview:telephoneTF];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, telephoneTF.bottom, kScreenWidth, 0.6)];
    line.backgroundColor = RGB(217, 217, 217);
    [self.view addSubview:line];
    
    UITextField *smsTF = [[UITextField alloc] initWithFrame:CGRectMake(15, line.bottom, kScreenWidth-30, 50)];
    smsTF.placeholder = @"输入验证码";
    [self.view addSubview:smsTF];
    UIButton *sendSMS = [UIButton buttonWithTitle:@"发送验证码" fontSize:15 titleColor:UIColorBlack background:UIColorWhite cornerRadius:8];
    
    sendSMS.layer.borderColor = RGB(67, 203, 182).CGColor;
    sendSMS.layer.borderWidth = 0.5;
    sendSMS.frame = CGRectMake(0, 0, 110, 35);
    sendSMS.centerY = smsTF.centerY;
    sendSMS.right = kScreenWidth-15;
    [self.view addSubview:sendSMS];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0, smsTF.bottom, kScreenWidth, 0.6)];
    line2.backgroundColor = RGB(217, 217, 217);
    [self.view addSubview:line2];
    
    UIButton *nextBtn = [UIButton buttonWithTitle:@"下一步" fontSize:16 titleColor:UIColorWhite background:RGB(67, 203, 182) cornerRadius:10];
    [nextBtn addActionHandler:^{
        [self invalidataSms:smsTF.text telephone:telephoneTF.text];
        
    }];
    nextBtn.frame = CGRectMake(0, line2.bottom+70, rateWidth(250), 40);
    nextBtn.centerX = kScreenWidth/2;
    [self.view addSubview:nextBtn];
    [sendSMS addActionHandler:^{
        [self sendSMS:telephoneTF.text];
    }];
    _sendSMSBtn = sendSMS;
}
- (void)invalidataSms:(NSString *)sms telephone:(NSString *)telephone {
    if (sms.length == 0) {
        [MBProgressHUD showError:@"请输入验证码"];
        return;
    }
    [MBProgressHUD showMessage:@"正在验证"];
    [[HttpRequestManager shareManager] addPOSTURL:@"/FyjjController/ma" person:RequestPersonYuChuan parameters:@{@"pone": telephone, @"ma": sms} success:^(id successResponse) {
        [MBProgressHUD hideHUD];
        if ([successResponse isSuccess]) {
            ForgetPwd2Controller *controller = [[ForgetPwd2Controller alloc] init];
            controller.telephone = telephone;
            [self pushViewController:controller animation:YES];
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络异常"];
    }];
}
- (void)sendSMS:(NSString *)telephone {
    if (![telephone isMobileNumber]) {
        [MBProgressHUD showError:@"输入正确的验证码"];
        return;
    }
    [MBProgressHUD showMessage:@"正在发送验证码"];
    [[HttpRequestManager shareManager] addPOSTURL:@"/FyjjController/forgetpone" person:RequestPersonYuChuan parameters:@{@"pone": telephone} success:^(id successResponse) {
        [MBProgressHUD hideHUD];
        if ([successResponse isSuccess]) {
            self.timeCount = 60;
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeIncreament) userInfo:nil repeats:YES];
            self.sendSMSBtn.userInteractionEnabled = NO;
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络错误"];
    }];
}
- (void)timeIncreament {
    if (self.timeCount < 0) {
        self.sendSMSBtn.userInteractionEnabled = YES;
        [self.sendSMSBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
        return;
    }
    
    [self.sendSMSBtn setTitle:[NSString stringWithFormat:@"%d", --self.timeCount] forState:UIControlStateNormal];
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
