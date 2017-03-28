//
//  ChangJingViewController.h
//  TV
//
//  Created by HOME on 16/9/12.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "BaseViewController.h"
#import "CommonViewController.h"
#import "HomeContentModel.h"
//#import "commentViewController.h"

/// 场景展示
@interface ChangJingViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *buttomView;
- (IBAction)LookAtAll:(id)sender;
- (IBAction)comment:(id)sender;
- (IBAction)dianzan:(id)sender;

@property (nonatomic, strong) HomeContentModel *model;

@end
