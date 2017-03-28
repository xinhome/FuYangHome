//
//  HomeCell.h
//  家居定制
//
//  Created by iKing on 2017/3/20.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeContentModel.h"

@interface HomeCell : UITableViewCell
@property (nonatomic, weak) UIImageView *moreImageView;///<<#注释#>
@property (nonatomic, weak) UIImageView *backgroundImageView;///<<#注释#>
@property (nonatomic, copy) MYActionArgu itemTapped;
@property (nonatomic, strong) HomeContentModel *model;///<<#注释#>
@end
