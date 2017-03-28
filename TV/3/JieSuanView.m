//
//  JieSuanView.m
//  家居定制
//
//  Created by iking on 2017/3/23.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "JieSuanView.h"

@implementation JieSuanView

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
    self.line = [UIView new];
    _line.backgroundColor = RGB(241, 241, 241);
    [self addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.height.equalTo(@(rateHeight(1)));
    }];
    
    self.firstLB = [UILabel labelWithText:@"" textColor:RGB(156, 156, 156) fontSize:16];
    [self addSubview:self.firstLB];
    [self.firstLB sizeToFit];
    [self.firstLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(rateWidth(20));
    }];
    
    self.secondLB = [UILabel labelWithText:@"快递公司" textColor:RGB(156, 156, 156) fontSize:16];
    [self addSubview:self.secondLB];
    [self.secondLB sizeToFit];
    [self.secondLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.firstLB.mas_right);
    }];
//    self.secondLB = [UILabel labelWithText:@"快递公司" textColor:RGB(121, 121, 121) fontSize:14];
//    [self addSubview:self.secondLB];
//    [self.secondLB sizeToFit];
//    [self.secondLB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self);
//        make.left.equalTo(self.firstLB.mas_right);
//    }];
    
}

@end
