//
//  OrderDetailsViewController.h
//  家居定制
//
//  Created by iking on 2017/3/23.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCarModel.h"

@interface OrderDetailsViewController :BaseViewController

@property (nonatomic, strong) ShoppingCarModel *model;

@property (nonatomic, copy) MYAction refreshAction;

@end
