//
//  yanzhengmaViewController.m
//  TV
//
//  Created by HOME on 16/9/19.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "yanzhengmaViewController.h"
#import "loginViewController.h"
//@class loginViewController;
@interface yanzhengmaViewController ()

@end

@implementation yanzhengmaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chongxinBtn.layer.cornerRadius = 5;
    self.chongxinBtn.layer.masksToBounds = YES;
    
    self.whiteView.layer.cornerRadius = 3;
    self.whiteView.layer.masksToBounds = YES;
    
    self.wancheng.layer.cornerRadius = 10;
    self.wancheng.layer.masksToBounds = YES;
}
- (IBAction)chongxinfasong:(id)sender {
}
- (IBAction)wanhceng:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)shangyibu:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
@end
