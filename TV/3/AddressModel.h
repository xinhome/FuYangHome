//
//  AddressModel.h
//  家居定制
//
//  Created by iKing on 2017/3/20.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *receiverAddress;
@property (nonatomic, copy) NSString *receiverCity;
@property (nonatomic, copy) NSString *receiverDistrict;
@property (nonatomic, copy) NSString *receiverId;
@property (nonatomic, copy) NSString *receiverMobile;
@property (nonatomic, copy) NSString *receiverName;
@property (nonatomic, copy) NSString *receiverState;
@end
