//
//  HomeContentModel.h
//  家居定制
//
//  Created by iKing on 2017/3/20.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Items : NSObject

@property (nonatomic, copy) NSString *barcode;
@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, strong) NSNumber *num;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, copy) NSString *sellPoint;
@property (nonatomic, strong) NSNumber *status;///<<#注释#>
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *updated;
@end

@interface HomeContentModel : NSObject

@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *titleDesc;
@property (nonatomic, copy) NSString *updated;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSArray<Items *> *items;///<商品
@end

