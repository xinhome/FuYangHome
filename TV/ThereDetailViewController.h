//
//  ThereDetailViewController.h
//  TV
//
//  Created by HOME on 16/9/14.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "BaseViewController.h"
#import "ThereModel.h"

@interface ThereDetailViewController : BaseViewController

@property (nonatomic, strong) ThereModel *model;///<<#注释#>
@property (nonatomic, copy) MYAction refreshAction;
@property (nonatomic, copy) MYAction praiseAction;
@end
