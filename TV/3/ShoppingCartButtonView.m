//
//  ShoppingCartButtonView.m
//  家居定制
//
//  Created by iking on 2017/3/24.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "ShoppingCartButtonView.h"

@implementation ShoppingCartButtonView

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
    self.subtractBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.subtractBtn setImage:[UIImage imageNamed:@"减号"] forState:(UIControlStateNormal)];
    [self addSubview:self.subtractBtn];
    [self.subtractBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(rateWidth(25), rateWidth(25)));
    }];
    
    self.addButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.addButton setImage:[UIImage imageNamed:@"加号"] forState:(UIControlStateNormal)];
    [self addSubview:self.addButton];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(rateWidth(25), rateWidth(25)));
    }];
    
    self.numLB = [UILabel labelWithText:@"" textColor:RGB(103, 211, 193) fontSize:17];
    self.numLB.textAlignment = NSTextAlignmentCenter;
    self.numLB.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.numLB];
    [self.numLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_offset(CGSizeMake(rateWidth(45), rateWidth(25)));
    }];
    
}
@end
