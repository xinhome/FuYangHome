//
//  BottomJieSuanView.m
//  家居定制
//
//  Created by iking on 2017/3/24.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "BottomJieSuanView.h"

@implementation BottomJieSuanView

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
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    line.backgroundColor = RGB(233, 233, 233);
    [self addSubview:line];
    
    UIButton *selectAllBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [selectAllBtn setImage:[UIImage imageNamed:@"椭圆 4"] forState:(UIControlStateNormal)];
    [self addSubview:selectAllBtn];
    [selectAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(rateWidth(15));
        make.size.mas_offset(CGSizeMake(rateWidth(35), rateWidth(35)));
        make.centerY.equalTo(self);
    }];
    self.selectAllBtn = selectAllBtn;
    
    UILabel *quanxuan = [UILabel labelWithText:@"全选" textColor:RGB(100, 100, 100) fontSize:14];
    [quanxuan sizeToFit];
    [self addSubview:quanxuan];
    [quanxuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selectAllBtn.mas_right).offset(rateWidth(5));
        make.centerY.equalTo(self);
    }];
    
    UILabel *hejiLB = [UILabel labelWithText:@"共计：60元（含10元运费）" textColor:RGB(100, 100, 100) fontSize:14];
    [hejiLB sizeToFit];
    [self addSubview:hejiLB];
    [hejiLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(quanxuan.mas_right).offset(rateWidth(25));
        make.centerY.equalTo(self);
    }];
    self.gongJiLB = hejiLB;
    
    UIButton *jieSuanBtn = [UIButton buttonWithTitle:@"结算" fontSize:16 titleColor:[UIColor whiteColor] background:RGB(231, 0, 13) cornerRadius:0];
    [self addSubview:jieSuanBtn];
    [jieSuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.right.equalTo(self);
        make.width.equalTo(@(rateWidth(80)));
        make.bottom.equalTo(self);
    }];
    self.jieSuanBtn = jieSuanBtn;
}

@end
