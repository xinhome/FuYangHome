//
//  MyTieZiTableViewCell.h
//  家居定制
//
//  Created by iking on 2017/3/24.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TieZiButtonViw.h"
#import "ThereModel.h"

@interface MyTieZiTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) TieZiButtonViw *pingLunBtn;
@property (nonatomic, strong) TieZiButtonViw *dianZanBtn;
@property (nonatomic, strong) ThereModel *model;

@end
