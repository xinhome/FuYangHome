//
//  TieZiButtonViw.m
//  家居定制
//
//  Created by iking on 2017/3/24.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "TieZiButtonViw.h"

@implementation TieZiButtonViw

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
    self.btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(rateWidth(20), rateWidth(20)));
    }];
    
    self.numLB = [UILabel labelWithText:@"" textColor:RGB(138, 138, 138) fontSize:15];
    [self.numLB sizeToFit];
    [self addSubview:self.numLB];
    [self.numLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.centerY.equalTo(self);
    }];
    
}
@end
