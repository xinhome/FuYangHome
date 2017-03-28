//
//  OrderDetailsViewController.m
//  家居定制
//
//  Created by iking on 2017/3/23.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "OrderDetailsViewController.h"

@interface OrderDetailsViewController ()

@end

@implementation OrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的订单";
    self.view.backgroundColor = RGB(242, 242, 242);
    [self setUpUI];
}
- (void)setUpUI
{
    self.orderFirstV = [[OrderFirstView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(210))];
    self.orderFirstV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.orderFirstV];
    
    NSArray *array1 = @[@"快递公司：", @"快递单号：", @"状态："];
    NSArray *array2 = @[@"顺丰快递", @"111111111", @"已发货"];
    for (int i = 0; i < 3; i++) {
        OrderSecondView *item = [[OrderSecondView alloc] init];
        item.backgroundColor = [UIColor whiteColor];
        item.firstLB.text = array1[i];
        item.secondLB.text = array2[i];
        [self.view addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.top.equalTo(self.orderFirstV.mas_bottom).offset(rateHeight(8)+rateHeight(48)*i);
            make.size.mas_offset(CGSizeMake(kScreenWidth, rateHeight(40)));
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
