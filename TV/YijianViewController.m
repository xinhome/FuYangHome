//
//  YijianViewController.m
//  Tea
//
//  Created by HOME on 16/5/25.
//  Copyright © 2016年 安鑫一家. All rights reserved.
//

#import "YijianViewController.h"
#import "fankuiChenggong.h"

@interface YijianViewController ()<UITextViewDelegate>
@property (assign ,nonatomic)int second;
@end

@implementation YijianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _bgt.layer.cornerRadius =5;
    _bgt.layer.masksToBounds =YES;
    self.title = @"用户123";
    [self addBackForUser];
    _textview.delegate = self;
}
//提交按钮
- (IBAction)tijiao:(id)sender {
    
    [_textview resignFirstResponder];
    [_tf resignFirstResponder];
    fankuiChenggong *fankui = [[fankuiChenggong alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [fankui creatView];
    
    [fankui.btn addTarget:self action:@selector(diss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fankui];
    fankui.lab.tag = 100;
    _second = 10;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tenSecond) userInfo:nil repeats:YES];
        
    
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

#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请留下反馈内容。。。"]) {
        textView.text = @"";
    }
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"请留下反馈内容。。。";
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_tf resignFirstResponder];
    [_textview resignFirstResponder];
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
