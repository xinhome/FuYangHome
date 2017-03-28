//
//  ThereViewController.h
//  TV
//
//  Created by HOME on 16/7/19.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "BaseViewController.h"

/// 社区详情
@interface ThereViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *zuixinBtn;
@property (weak, nonatomic) IBOutlet UIButton *tuijianBnt;
- (IBAction)zuixinBtnClick:(id)sender;
- (IBAction)tuijianBtnClick:(id)sender;

@end
