//
//  MagazineModel.h
//  家居定制
//
//  Created by iKing on 2017/3/22.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
/*
 comments =                 (
 );
 id = 1490171826172;
 magazines =                 (
 {
 "$ref" = "$.data[7]";
 }
 );
 orderShoppings =                 (
 );
 orders =                 (
 );
 passWord = 123456;
 pone = 15222639312;
 registrationTime = "2017-03-22 16:37:06";
 thumbs =                 (
 );
 verificationCode = 780450;
 */
@property (nonatomic, copy) NSArray *comments;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, strong) NSArray *magazines;///<<#注释#>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *numberOrder;
@property (nonatomic, copy) NSString *numberPosts;
@property (nonatomic, copy) NSString *numberShopping;
@property (nonatomic, strong) NSArray *orderShoppings;///<<#注释#>
@property (nonatomic, strong) NSArray *orders;///<<#注释#>
@property (nonatomic, copy) NSString *passWord;
@property (nonatomic, copy) NSString *pone;
@property (nonatomic, copy) NSString *registrationTime;
@property (nonatomic, strong) NSArray *thumbs;///<<#注释#>
@property (nonatomic, copy) NSString *verificationCode;
@property (nonatomic, copy) NSString *url;

@end

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
@property (nonatomic, copy) NSString *generateTime;
@property (nonatomic, copy) NSString *magazineId;
@property (nonatomic, copy) NSString *magazineName;
@property (nonatomic, copy) NSString *magazineTextContent;
@property (nonatomic, copy) NSString *magazineUrlContent;
@property (nonatomic, strong) NSArray *thumbs;///<<#注释#>
@property (nonatomic, strong) NSNumber *type;///<<#注释#>
@property (nonatomic, strong) NSArray *comments;///<<#注释#>
@property (nonatomic, strong) UserInfo *user;///<<#注释#>

@end
