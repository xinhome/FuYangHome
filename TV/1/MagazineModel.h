//
//  MagazineModel.h
//  家居定制
//
//  Created by iKing on 2017/3/22.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MagazineModel : NSObject
/*
 comments =             (
 );
 generateTime = "2017-03-22 17:06:56";
 magazineId = M149017361641707;
 magazineName = "\U5367\U5ba4\U5929\U5730";
 magazineTextContent = "\U5367\U5ba4\U5929\U5730\U5367\U5ba4\U5929\U5730";
 magazineUrlContent = ";bicths/M149017361641707/1.jpg;bicths/M149017361641707/2.jpg";
 thumbs =             (
 );
 type = 1;
 */
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *generateTime;
@property (nonatomic, copy) NSString *likes;
@property (nonatomic, copy) NSString *magazineId;
@property (nonatomic, copy) NSString *magazineName;
@property (nonatomic, copy) NSString *magazineTextContent;
@property (nonatomic, copy) NSString *magazineUrlContent;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *name;
@end
