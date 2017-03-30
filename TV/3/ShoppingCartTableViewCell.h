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
@protocol ChangeGoodsNumDelegate <NSObject>

- (void)changeGoodsNum:(ShoppingCarModel *)model;
@end

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
@property (nonatomic, assign) id<ChangeGoodsNumDelegate>delegate;

@end
