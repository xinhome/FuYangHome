//
//  forgetPwdViewController.h
//  TV
//
//  Created by HOME on 16/9/19.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "BaseViewController.h"
#import "forgetPwd2ViewController.h"
@interface forgetPwdViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIButton *fasongyanzhengma;
@property (weak, nonatomic) IBOutlet UIButton *shangyibu;
- (IBAction)xiayibu:(id)sender;
//@property (weak, nonatomic) IBOutlet UIButton *shangyibu;
- (IBAction)shangyibu:(id)sender;

@end
