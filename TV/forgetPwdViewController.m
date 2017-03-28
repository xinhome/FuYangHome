//
//  forgetPwdViewController.m
//  TV
//
//  Created by HOME on 16/9/19.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "forgetPwdViewController.h"

@interface forgetPwdViewController ()

@end

@implementation forgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.whiteView.layer.cornerRadius = 5;
    self.whiteView.layer.masksToBounds = YES;
    
    self.fasongyanzhengma.layer.cornerRadius = 3;
    self.fasongyanzhengma.layer.masksToBounds = YES;
    
    self.shangyibu.layer.cornerRadius = 10;
    self.shangyibu.layer.masksToBounds = YES;

}

- (IBAction)xiayibu:(id)sender {
    forgetPwd2ViewController *forget = [[forgetPwd2ViewController alloc]init];
    [self.navigationController pushViewController:forget animated:YES];
}
- (IBAction)shangyibu:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
