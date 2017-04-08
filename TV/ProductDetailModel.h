//
//  ProductDetailModel.h
//  家居定制
//
//  Created by iKing on 2017/3/23.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductCommentModel.h"

@interface ProductDetailModel : NSObject

/*
 barcode = "";
 cid = 149016411119601;
 id = 149016597371700;
 image = "2017/03/22/1490165956139917.jpg,2017/03/22/1490165956325683.jpg,2017/03/22/1490165956368092.jpg";
 itemDesc = "<span>\U4e66\U684c\U5929\U5730</span><span>\U4e66\U684c\U5929\U5730</span><span>\U4e66\U684c\U5929\U5730</span><span>\U4e66\U684c\U5929\U5730</span><span>\U4e66\U684c\U5929\U5730</span><span>\U4e66\U684c\U5929\U5730</span>";
 num = 2;
 paramData = "[{\"group\":\"\U5b9e\U6728\U684c\",\"params\":[{\"k\":\"\U9ed1\U8272\",\"v\":\"\U9ed1\U8272\"},{\"k\":\"\U767d\U8272\",\"v\":\"\U767d\U8272\"}]},{\"group\":\"\U9752\U6728\U684c\",\"params\":[{\"k\":\"\U7ea2\U8272\",\"v\":\"\U6df1\U7ea2\"},{\"k\":\"\U767d\U8272\",\"v\":\"\U767d\"}]}]";
 price = 11200;
 sellPoint = "\U4e66\U684c\U5929\U5730";
 status = 1;
 title = "\U4e66\U684c\U5929\U5730";
 */
@property (nonatomic, copy) NSString *barcode;
@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *itemDesc;
@property (nonatomic, copy) NSString *num;
@property (nonatomic, strong) NSArray<ProductCommentModel *> *orderMsgs;///<<#注释#>
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *sellPoint;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *title;
@end
