//
//  CouponCell.h
//  家居定制
//
//  Created by iKing on 2017/4/6.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponModel.h"

/// 优惠券cell
@interface CouponCell : UITableViewCell

@property (nonatomic, strong) UIImageView *bgImg;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *moneyLB;
@property (nonatomic, strong) UILabel *conditionLB;
@property (nonatomic, strong) UILabel *timeLB;
@property (nonatomic, strong) CouponModel *cellModel;

@end
