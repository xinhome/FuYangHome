//
//  JieSuanOrderViewController.h
//  家居定制
//
//  Created by iking on 2017/3/23.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCarModel.h"
#import "AddressModel.h"

@interface JieSuanOrderViewController : BaseViewController
@property (nonatomic, strong) AddressModel *selectAddressModel;///<<#注释#>
@property (nonatomic, strong) NSArray<ShoppingCarModel *> *listArray;
@property (nonatomic, strong) NSString *credit; // 积分

@end
