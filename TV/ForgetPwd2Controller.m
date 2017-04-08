//
//  ForgetPwd2Controller.m
//  家居定制
//
//  Created by iKing on 2017/4/7.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "ForgetPwd2Controller.h"

@interface ForgetPwd2Controller ()

@end

@implementation ForgetPwd2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    UITextField *pwd1 = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth-30, 50)];
    pwd1.secureTextEntry = YES;
    pwd1.placeholder = @"输入新密码";
    [self.view addSubview:pwd1];
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, pwd1.bottom, kScreenWidth, 0.6)];
    line1.backgroundColor = RGB(217, 217, 217);
    [self.view addSubview:line1];
    
    UITextField *pwd2 = [[UITextField alloc] initWithFrame:CGRectMake(15, line1.bottom, kScreenWidth-30, 50)];
    pwd2.secureTextEntry = YES;
    pwd2.placeholder = @"再次确认密码";
    [self.view addSubview:pwd2];
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0, pwd2.bottom, kScreenWidth, 0.6)];
    line2.backgroundColor = RGB(217, 217, 217);
    [self.view addSubview:line2];
    
    UIButton *finish = [UIButton buttonWithTitle:@"完成" fontSize:16 titleColor:UIColorWhite background:RGB(67, 203, 182) cornerRadius:10];
    [finish addActionHandler:^{
        [self setPassword:pwd1.text WithNewPwd:pwd2.text];
    }];
    finish.frame = CGRectMake(0, line2.bottom+70, rateWidth(250), 40);
    finish.centerX = kScreenWidth/2;
    [self.view addSubview:finish];
}
- (void)setPassword:(NSString *)password WithNewPwd:(NSString *)password1 {
    if (![password isEqualToString:password1]) {
        [MBProgressHUD showError:@"两次密码不一致"];
        return;
    }
    [MBProgressHUD showMessage:@"正在修改"];
    [[HttpRequestManager shareManager] addPOSTURL:@"/FyjjController/mima" person:RequestPersonYuChuan parameters:@{@"password": password, @"pone": self.telephone} success:^(id successResponse) {
        [MBProgressHUD hideHUD];
        if ([successResponse isSuccess]) {
            [MBProgressHUD showSuccess:@"修改成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络异常"];
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
