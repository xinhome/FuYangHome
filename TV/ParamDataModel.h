//
//  ParamDataModel.h
//  家居定制
//
//  Created by iKing on 2017/3/23.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Param : NSObject

@property (nonatomic, copy) NSString *k;

@property (nonatomic, copy) NSString *v;

@end

@interface ParamDataModel : NSObject

@property (nonatomic, copy) NSString *group;
@property (nonatomic, copy) NSArray *params;

@end
