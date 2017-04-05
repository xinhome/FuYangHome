//
//  changeNikeNameViewController.m
//  TV
//
//  Created by HOME on 16/9/14.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "changeNikeNameViewController.h"

@interface changeNikeNameViewController ()<UITextViewDelegate>

@end

@implementation changeNikeNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改昵称";
    [self.view bringSubviewToFront:_fasong];
    _textview.delegate = self;
    _fasong.layer.cornerRadius = 5;
    _fasong.layer.masksToBounds = YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"输入昵称"]) {
        textView.text = @"";
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"输入昵称";
    }
   
}

- (IBAction)tijiao:(id)sender {
    if (self.textview.text.length == 0) {
        [MBProgressHUD showError:@"请输入昵称"];
        return;
    }
    NSDictionary *parameters = @{
                                 @"pone": self.user.tel,
                                 @"name": self.textview.text
                                 };
    [MBProgressHUD showMessage:@"修改中..."];
    [[HttpRequestManager shareManager] addPOSTURL:@"/FyjjController/xiugainicheng" person:RequestPersonYuChuan parameters:parameters success:^(id successResponse) {
        [MBProgressHUD hideHUD];
        if ([successResponse isSuccess]) {
            [MBProgressHUD showSuccess:@"修改成功"];
            [[UserUtil shareInstance] saveNickname:self.textview.text];
            [self popViewController];
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"修改失败"];
    }];
}
@end
