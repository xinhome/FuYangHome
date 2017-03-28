//
//  HomeContentModel.h
//  家居定制
//
//  Created by iKing on 2017/3/20.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Items : NSObject

/*
 barcode = "";
 cid = 148999095034878;
 created = "2017-03-20 14:25:45";
 id = 148999114570467;
 image = "/FyHome/2017/03/20/1489991129913557.png";
 num = 1;
 price = 2000;
 sellPoint = "\U4e66\U684c";
 status = 1;
 title = "\U4e66\U684c\U5929\U5730";
 updated = "2017-03-20 14:25:45";
 */
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

/*
 categoryId = 148945506491103;
 content = "123412<img src=\"/FyHome/2017/03/14/1489467468269594.png\" alt=\"\" />";
 coordinates = "108,394";
 created = "2017-03-14 12:57:49";
 id = 148946746925705;
 pic = "";
 pic2 = "/FyHome/2017/03/14/1489467460003320.png";
 subTitle = "\U8def\U98de";
 title = "\U8def\U98de";
 titleDesc = "\U8def\U98de";
 updated = "2017-03-14 12:57:49";
 url = index;
 */
@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *coordinates;
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *pic2;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *titleDesc;
@property (nonatomic, copy) NSString *updated;
@property (nonatomic, copy) NSString *index;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSArray<Items *> *items;///<商品
@end

