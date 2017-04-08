//
//  ProductCommentModel.h
//  家居定制
//
//  Created by iKing on 2017/4/8.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderMsg : NSObject
@property (nonatomic, copy) NSString *buyerMsg;
@property (nonatomic, copy) NSString *buyerNm;
@property (nonatomic, copy) NSString *buyerStatus;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *orderMsg;
@end

/// 产品评论
@interface ProductCommentModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) OrderMsg *orderMsg;///<<#注释#>
@end
