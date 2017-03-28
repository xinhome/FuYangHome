//
//  OrderFirstView.m
//  家居定制
//
//  Created by iking on 2017/3/23.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "OrderFirstView.h"

@implementation OrderFirstView

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
    UILabel *numLB = [UILabel labelWithText:@"订单编号：11111111" textColor:RGB(115, 115, 115) fontSize:14];
    numLB.frame = CGRectMake(rateWidth(20), rateHeight(15), 0, 0);
    [numLB sizeToFit];
    [self addSubview:numLB];
    self.orderNumLB = numLB;
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = RGB(247, 247, 247);
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numLB.mas_bottom).offset(rateHeight(15));
        make.left.equalTo(self);
        make.size.mas_offset(CGSizeMake(kScreenWidth, rateHeight(90)));
    }];
    
    UIImageView *image = [UIImageView new];
    image.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(rateWidth(25));
        make.centerY.equalTo(bgView);
        make.size.mas_offset(CGSizeMake(rateHeight(80), rateHeight(80)));
    }];
    self.goodsImg = image;
    
    UILabel *label1 = [UILabel labelWithText:@"产品名称" textColor:RGB(74, 74, 74) fontSize:14];
    [label1 sizeToFit];
    [bgView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image.mas_right).offset(rateWidth(15));
        make.top.equalTo(image).offset(rateHeight(5));
    }];
    
    UILabel *label2 = [UILabel labelWithText:@"数量：1件" textColor:RGB(74, 74, 74) fontSize:14];
    [label2 sizeToFit];
    [bgView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image.mas_right).offset(rateWidth(15));
        make.centerY.equalTo(image);
    }];
    self.numLB = label2;
    
    UILabel *label3 = [UILabel labelWithText:@"单价：￥50.00" textColor:RGB(242, 0, 0) fontSize:14];
    [label3 sizeToFit];
    [bgView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image.mas_right).offset(rateWidth(15));
        make.bottom.equalTo(image.mas_bottom).offset(-rateHeight(5));
    }];
    self.priceLB = label3;
    
    UILabel *label4 = [UILabel labelWithText:@"共计：60元（含10元运费）" textColor:RGB(105, 105, 105) fontSize:14];
    [label4 sizeToFit];
    [bgView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image.mas_right).offset(rateWidth(15));
        make.top.equalTo(bgView.mas_bottom).offset(rateHeight(10));
    }];
    self.sumPriceLB = label4;
    
    UIButton *shouhuoBtn = [UIButton buttonWithTitle:@"确认收货" fontSize:12 titleColor:RGB(105, 105, 105) background:[UIColor whiteColor] cornerRadius:4];
    shouhuoBtn.layer.borderWidth = 1;
    shouhuoBtn.layer.borderColor = RGB(183, 233, 225).CGColor;
    [self addSubview:shouhuoBtn];
    [shouhuoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-rateWidth(10));
        make.bottom.equalTo(self).offset(-rateHeight(15));
        make.size.mas_offset(CGSizeMake(rateWidth(65), rateHeight(25)));
    }];
    self.shouhuoBtn = shouhuoBtn;
    
}

@end
