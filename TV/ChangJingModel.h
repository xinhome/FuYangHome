//
//  ChangJingModel.h
//  家居定制
//
//  Created by iKing on 2017/3/28.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coordinate : NSObject

@property (nonatomic, copy) NSString *coordinate;
@property (nonatomic, copy) NSString *coordinateId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *title;

@end

@interface ChangJingModel : NSObject
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSArray *scenesComments;
@property (nonatomic, copy) NSString *scenesId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *updated;
@property (nonatomic, strong) NSArray<Coordinate *> *coordinates;///<坐标
@property (nonatomic, copy) NSString *likes;

@end
