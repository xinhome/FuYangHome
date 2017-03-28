//
//  ShoppingCartTableViewCell.h
//  家居定制
//
//  Created by iking on 2017/3/24.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartButtonView.h"
#import "ShoppingCarModel.h"

@interface ShoppingCartTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIImageView *goodsImg;
@property (nonatomic, strong) UILabel *nameLB;
@property (nonatomic, strong) UILabel *colorLB;
@property (nonatomic, strong) UILabel *priceLB;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) ShoppingCartButtonView *numBtn;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, strong) ShoppingCarModel *cellModel;
@property (nonatomic, strong) NSString *orderId;

@end
