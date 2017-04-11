//
//  YijianViewController.m
//  Tea
//
//  Created by HOME on 16/5/25.
//  Copyright © 2016年 安鑫一家. All rights reserved.
//

#import "YijianViewController.h"
#import "fankuiChenggong.h"
#import "EaseTextView.h"

@interface YijianViewController ()<UITextViewDelegate>
@property (assign ,nonatomic)int second;
@property (nonatomic, weak) EaseTextView *textView;///<<#注释#>
@property (nonatomic, weak) UITextField *textField;///<<#注释#>
@end

@implementation YijianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _bgt.layer.cornerRadius =5;
    _bgt.layer.masksToBounds =YES;
    self.title = @"意见反馈";
    [self addBackForUser];
//    [self addBackForUser];
    EaseTextView *textView = [[EaseTextView alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth-40, 170)];
    _textView = textView;
    textView.backgroundColor = RGB(249, 249, 249);
    textView.placeHolder = @"请留下反馈内容。。。";
    [self.view addSubview:textView];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, textView.bottom+20, kScreenWidth-40, 40)];
    _textField = textField;
    textField.backgroundColor = RGB(249, 249, 249);
    textField.placeholder = @"请留下手机号，便于我们给您回复";
    [self.view addSubview:textField];
    
    UIButton *commitButton = [UIButton buttonWithTitle:@"提交" fontSize:18 titleColor:UIColorWhite background:RGB(64, 191, 166) cornerRadius:8];
    [commitButton addActionHandler:^{
        [self tijiao];
    }];
    commitButton.frame = CGRectMake(25, textField.bottom+70, kScreenWidth-50, 50);
    [self.view addSubview:commitButton];
}
//提交按钮
- (void)tijiao {
    [self.view endEditing:YES];
    if (self.user == nil) {
        [MBProgressHUD showError:@"请登录"];
        return;
    }
    if (_textView.text.length == 0) {
        [MBProgressHUD showError:@"请填写意见"];
        return;
    }
    if (![_textField.text isMobileNumber]) {
        [MBProgressHUD showError:@"请填写正确联系方式"];
        return;
    }
    [[HttpRequestManager shareManager] addPOSTURL:@"/Back/save" person:RequestPersonWeiMing parameters:@{@"userId": self.user.ID, @"backContent": self.textView.text, @"backPone": self.textField.text} success:^(id successResponse) {
        if ([successResponse isSuccess]) {
            fankuiChenggong *fankui = [[fankuiChenggong alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            [fankui creatView];
            
            [fankui.btn addTarget:self action:@selector(diss) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:fankui];
            fankui.lab.tag = 100;
            _second = 10;
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tenSecond) userInfo:nil repeats:YES];
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"网络异常"];
    }];

    
    
}
- (void)tenSecond
{
    _second--;
    if (_second == 0) {
        [self diss];
    }
    UILabel *lab = [self.view viewWithTag:100];
    lab.text = [NSString stringWithFormat:@"%ds后自动跳转",_second];
    
}
- (void)diss
{
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    
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
