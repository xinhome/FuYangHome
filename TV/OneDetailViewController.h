//
//  OneDetailViewController.h
//  TV
//
//  Created by HOME on 16/9/13.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "BaseViewController.h"
#import "MagazineModel.h"

@interface OneDetailViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *buttomView;
- (IBAction)comment:(id)sender;
- (IBAction)dianzan:(id)sender;
//@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (weak, nonatomic) IBOutlet UIButton *dingzhiBtn;

@property (nonatomic, strong) MagazineModel *model;///<<#注释#>
@end
