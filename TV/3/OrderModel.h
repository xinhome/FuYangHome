//
//  OrderModel.h
//  家居定制
//
//  Created by iking on 2017/3/25.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (nonatomic, strong) NSString *orderId; // 订单id
@property (nonatomic, strong) NSString *receiverId; // 收货地址id
@property (nonatomic, strong) NSString *payment; // 实付金额
@property (nonatomic, assign) NSInteger paymentType; // 支付类型
@property (nonatomic, strong) NSString *postFee; // 邮费
@property (nonatomic, assign) NSInteger status; // 状态
@property (nonatomic, strong) NSString *createTime; // 创建订单时间
@property (nonatomic, strong) NSString *updateTime; // 订单更新时间
@property (nonatomic, strong) NSString *paymentTime; // 付款时间
@property (nonatomic, strong) NSString *consignTime; // 发货时间
@property (nonatomic, strong) NSString *endTime; // 交易完成时间
@property (nonatomic, strong) NSString *closeTime; // 交易关闭时间
@property (nonatomic, strong) NSString *shippingName; // 物流名称
@property (nonatomic, strong) NSString *shippingCode; // 物流单号
@property (nonatomic, strong) NSString *userId; // 用户id
@property (nonatomic, strong) NSString *buyerNick; // 买家昵称
@property (nonatomic, assign) NSInteger buyerRate; // 买家是否已经评价
@property (nonatomic, strong) NSString *buyer_message; // 买家留言

@end
