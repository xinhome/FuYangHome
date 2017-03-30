//
//  OneTableViewCell.h
//  TV
//
//  Created by HOME on 16/8/23.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagazineModel.h"

@interface OneTableViewCell : UITableViewCell
@property (nonatomic, weak) UIButton *pariseBtn;///<<#注释#>
@property (nonatomic, weak) UIButton *share;///<<#注释#>
@property (nonatomic, strong) MagazineModel *model;///<<#注释#>

@end
