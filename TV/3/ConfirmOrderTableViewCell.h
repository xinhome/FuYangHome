//
//  ConfirmOrderTableViewCell.h
//  家居定制
//
//  Created by iking on 2017/4/5.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCarModel.h"

@interface ConfirmOrderTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLB;
@property (nonatomic, strong) UILabel *numLB;
@property (nonatomic, strong) UILabel *colorLB;
@property (nonatomic, strong) UILabel *realPriceLB;
@property (nonatomic, strong) UILabel *priceLB;
@property (nonatomic, strong) UIImageView *goodsImg;
@property (nonatomic, strong) ShoppingCarModel *cellModel;

@end
