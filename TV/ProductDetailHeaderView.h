//
//  ProductDetailHeaderView.h
//  家居定制
//
//  Created by iKing on 2017/3/21.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "ParamDataModel.h"

@interface ProductDetailHeaderView : UIView
@property (nonatomic, weak) SDCycleScrollView *cycleView;///<<#注释#>
@property (nonatomic, weak) UILabel *priceLabel;///<<#注释#>
@property (nonatomic, weak) UILabel *nameLabel;///<<#注释#>
@property (nonatomic, copy) NSString *selectedColor;
@property (nonatomic, copy) NSString *selectedSize;
@property (nonatomic, strong) NSArray *colors;///<<#注释#>
@property (nonatomic, strong) NSArray *sizes;///<<#注释#>
@property (nonatomic, strong) ParamDataModel *model;///<<#注释#>
@end
