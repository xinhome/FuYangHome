//
//  MyOrderModel.h
//  家居定制
//
//  Created by iKing on 2017/4/7.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShoppingCarModel.h"

/// 我的订单
@interface MyOrderModel : NSObject

@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *credit;
@property (nonatomic, strong) ShoppingCarModel *order;///<<#注释#>

@end
