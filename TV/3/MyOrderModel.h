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
@property (nonatomic, strong) NSString *picPath; // 商品图片地址
@property (nonatomic, strong) NSString *totalFee; // 商品总金额
@property (nonatomic, strong) NSString *price; // 商品单价
@property (nonatomic, strong) NSString *title; // 商品标题
@property (nonatomic, strong) NSString *orderId; // 订单id
@property (nonatomic, strong) NSNumber *goodsId; // 商品id
@property (nonatomic, strong) NSNumber *num; // 商品购买数量
@property (nonatomic, strong) NSString *colour; // 颜色
@property (nonatomic, strong) NSString *style; // 类型
@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSNumber *status; // 0:全部 1:待发货 2:待收货 3:待评价 4:退货
@property (nonatomic, strong) NSString *postFee; // 邮费
@property (nonatomic, strong) NSNumber *outRate; // 0:退货 1:退货中 2:退货完成
@property (nonatomic, strong) NSNumber *buyerRate; // 0:待评价 1:已评价
@property (nonatomic, strong) NSString *shippingName; // 物流名称
@property (nonatomic, strong) NSString *shippingCode; // 物流单号

@end
