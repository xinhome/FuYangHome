//
//  changePwdViewController.m
//  TV
//
//  Created by HOME on 16/9/14.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "changePwdViewController.h"

@interface changePwdViewController ()
@property (weak, nonatomic) IBOutlet UIButton *fasong;
- (IBAction)tijiao:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *pwd1;
@property (weak, nonatomic) IBOutlet UITextField *pwd2;

@property (weak, nonatomic) IBOutlet UITextField *pwd3;
@end

@implementation changePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    self.fasong.layer.cornerRadius = 7;
    self.fasong.layer.masksToBounds = YES;
}

- (IBAction)tijiao:(id)sender {
    if (self.pwd1.text.length == 0) {
        [MBProgressHUD showError:@"请输入原始密码"];
        return;
    }
    if (self.pwd2.text.length == 0) {
        [MBProgressHUD showError:@"请输入新密码"];
        return;
    }
    if (self.pwd3.text.length == 0) {
        [MBProgressHUD showError:@"请再次确认密码"];
        return;
    }
    if (![self.pwd2.text isEqualToString:self.pwd3.text]) {
        [MBProgressHUD showError:@"两次密码不一致"];
        return;
    }
    NSDictionary *parameters = @{
                                 @"pone": self.user.tel,
                                 @"password": self.pwd1.text,
                                 @"password1": self.pwd2.text
                                 };
    [[HttpRequestManager shareManager] addPOSTURL:@"/FyjjController/xiugaimima" person:RequestPersonYuChuan parameters:parameters success:^(id successResponse) {
//        NSLog(@"%@", successResponse);
        if ([successResponse isSuccess]) {
            [MBProgressHUD showSuccess:@"修改成功"];
            [self popViewController];
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"修改失败"];
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
