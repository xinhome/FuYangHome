//
//  phoneChangeViewController.m
//  TV
//
//  Created by HOME on 16/9/14.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "phoneChangeViewController.h"

@interface phoneChangeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *sendSmsBtn;
@property (weak, nonatomic) IBOutlet UIButton *fasong;
- (IBAction)tijiao:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *pwd1;
@property (weak, nonatomic) IBOutlet UITextField *pwd2;
@property (nonatomic, strong) NSTimer *timer;///<计时器
@property (nonatomic, assign) int timeCount;///< <#注释#>
@end

@implementation phoneChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改手机号";
    _fasong.layer.cornerRadius = 5;
    _fasong.layer.masksToBounds = YES;
    [self addBackForUser];
    self.sendSmsBtn.layer.cornerRadius = 8;
    self.sendSmsBtn.layer.masksToBounds = YES;
    self.sendSmsBtn.layer.borderColor = [RGB(162, 224, 212) CGColor];
    self.sendSmsBtn.layer.borderWidth = 0.8;
    self.sendSmsBtn.titleLabel.textColor = RGB(70, 70, 70);
}
- (IBAction)tijiao:(id)sender {
    if (![self.pwd1.text isMobileNumber]) {
        [MBProgressHUD showError:@"请输入正确手机号"];
        return;
    }
    if (self.pwd2.text.length == 0) {
        [MBProgressHUD showError:@"请输入验证码"];
        return;
    }
    NSDictionary *parameters = @{
                                 @"pone": [[NSUserDefaults standardUserDefaults] stringForKey:K_USER_NAME],
                                 @"newPone": self.pwd1.text,
                                 @"ma": self.pwd2.text
                                 };
    [MBProgressHUD showMessage:@"请稍后" toView:self.view];
    [[HttpRequestManager shareManager] addPOSTURL:@"/FyjjController/updatema" person:RequestPersonYuChuan parameters:parameters success:^(id successResponse) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([successResponse isSuccess]) {
            [MBProgressHUD showSuccess:@"修改成功"];
            [self popViewController];
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"修改失败"];
    }];
}
- (IBAction)sendSms:(UIButton *)sender {
    if (![self.pwd1.text isMobileNumber]) {
        [MBProgressHUD showError:@"请输入正确手机号"];
        return;
    }
    NSDictionary *parameters = @{
                                 @"pone": self.user.pone,
                                 @"newPone": self.pwd1.text
                                 };
    [MBProgressHUD showMessage:@"正在发送" toView:self.view];
    [[HttpRequestManager shareManager] addPOSTURL:@"/FyjjController/updatemy" person:RequestPersonYuChuan parameters:parameters success:^(id successResponse) {
        [MBProgressHUD hideHUDForView:self.view];
        if ([successResponse isSuccess]) {
            [MBProgressHUD showSuccess:@"发送成功"];
            sender.userInteractionEnabled = NO;
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeIncreament) userInfo:nil repeats:YES];
            self.timeCount = 60;
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"发送失败"];
    }];
}

- (void)timeIncreament {
    if (self.timeCount <= 0) {
        self.sendSmsBtn.userInteractionEnabled = YES;
        [self.sendSmsBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
        return;
    }
    [self.sendSmsBtn setTitle:[NSString stringWithFormat:@"%ds", --self.timeCount] forState:UIControlStateNormal];
}

@end
