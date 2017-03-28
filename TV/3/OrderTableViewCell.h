//
//  OrderTableViewCell.h
//  家居定制
//
//  Created by iking on 2017/3/23.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *orderNumLB;
@property (nonatomic, strong) UILabel *nameLB;
@property (nonatomic, strong) UILabel *numLB;
@property (nonatomic, strong) UILabel *priceLB;
@property (nonatomic, strong) UILabel *sumPriceLB;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIImageView *goodsImg;
@property (nonnull, strong) UILabel * stateLB;

@end
