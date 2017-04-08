//
//  ProductCommentController.h
//  家居定制
//
//  Created by iKing on 2017/3/31.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductCommentModel.h"

/// 商品评论
@interface ProductCommentController : BaseViewController
@property (nonatomic, strong) NSArray<ProductCommentModel *> *dataSource;///<<#注释#>
@end
