//
//  UserHeaderView.h
//  家居定制
//
//  Created by iKing on 2017/3/17.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserHeaderView : UIView
@property (nonatomic, weak) UIImageView *avatar;///<<#注释#>

@property (nonatomic, weak) UIImageView *gradeImageView;///<等级

@property (nonatomic, weak) UILabel *gradeLabel;///<等级

@property (nonatomic, weak) UILabel *scoreLabel;///<积分

@property (nonatomic, weak) UILabel *nickname;///<昵称

@property (nonatomic, weak) UILabel *invitation;///<我的帖子

@property (nonatomic, weak) UILabel *order;///<我的订单

@property (nonatomic, weak) UILabel *shopCar;///<购物车

@property (nonatomic, weak) UILabel *goodsLabel;///<退换货
@property (nonatomic, copy) MYAction postAction, orderAction, shopCarAction, goodsAction;

@end
