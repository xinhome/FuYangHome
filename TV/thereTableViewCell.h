//
//  thereTableViewCell.h
//  TV
//
//  Created by HOME on 16/8/23.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThereModel.h"

@interface thereTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *nikeNameLable;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UILabel *commentLable;
@property (weak, nonatomic) IBOutlet UIButton *dianzanBtn;
@property (weak, nonatomic) IBOutlet UILabel *dianzanLable;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (nonatomic, strong) ThereModel *model;///<<#注释#>
@end
