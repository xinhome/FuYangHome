//
//  registViewController.m
//  TV
//
//  Created by HOME on 16/9/19.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "registViewController.h"

@interface registViewController ()

@end

@implementation registViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.zhuce.layer.cornerRadius = 10;
    self.zhuce.layer.masksToBounds = YES;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)yiyou:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)zhuce:(id)sender {
    yanzhengmaViewController *regist = [[yanzhengmaViewController alloc]init];
    [self.navigationController pushViewController:regist animated:YES];
}
@end
