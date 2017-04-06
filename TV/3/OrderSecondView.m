//
//  OrderSecondView.m
//  家居定制
//
//  Created by iking on 2017/3/23.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "OrderSecondView.h"

@implementation OrderSecondView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}
- (void)addSubViews
{
    self.firstLB = [UILabel labelWithText:@"快递公司" textColor:RGB(174, 174, 174) fontSize:14];
    [self addSubview:self.firstLB];
    [self.firstLB sizeToFit];
    [self.firstLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(rateWidth(20));
    }];
    
    self.secondLB = [UILabel labelWithText:@"快递公司" textColor:RGB(121, 121, 121) fontSize:14];
    [self addSubview:self.secondLB];
    [self.secondLB sizeToFit];
    [self.secondLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.firstLB.mas_right).offset(rateWidth(25));
    }];
}

@end
