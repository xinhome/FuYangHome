//
//  ProductDetailHeaderView.m
//  家居定制
//
//  Created by iKing on 2017/3/21.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "ProductDetailHeaderView.h"

@interface ProductDetailHeaderView ()
@property (nonatomic, strong) NSMutableArray<UIButton *> *btns1;///<<#注释#>
@property (nonatomic, strong) NSMutableArray<UIButton *> *btns2;///<<#注释#>
@property (nonatomic, weak) UILabel *color;///<<#注释#>
@property (nonatomic, weak) UILabel *size;///<<#注释#>
@property (nonatomic, weak) UIView *view1;///<颜色
@property (nonatomic, weak) UIView *view2;///<尺寸
@end

@implementation ProductDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorWhite;
        
        SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.width, rateHeight(425)) imageURLStringsGroup:nil];
        
        self.cycleView = cycleView;
        [self addSubview:cycleView];
        
        UILabel *price = [UILabel labelWithText:@"￥ 200" textColor:RGB(255, 0, 0) fontSize:16];
        self.priceLabel = price;
        price.frame = CGRectMake(14, cycleView.bottom+10, self.width-28, 16);
        [self addSubview:price];
        
        UILabel *productName = [UILabel labelWithText:@"创建休闲座椅" textColor:RGB(0, 0, 0) fontSize:16];
        self.nameLabel = productName;
        productName.frame = CGRectMake(14, price.bottom+10, self.width-25, 16);
        [self addSubview:productName];
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, productName.bottom+15, self.width, 50)];
        self.view1 = view1;
        view1.backgroundColor = RGB(214, 214, 214);
        [self addSubview:view1];
        
        UILabel *color = [UILabel labelWithText:@"颜色:" textColor:RGB(135, 135, 135) fontSize:13];
        self.color = color;
        [color sizeToFit];
        color.frame = CGRectMake(14, (50-color.height)/2, color.width, color.height);
        [view1 addSubview:color];
        
        
        
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, view1.bottom+15, self.width, 50)];
        self.view2 = view2;
        view2.backgroundColor = RGB(214, 214, 214);
        [self addSubview:view2];
        
        UILabel *size = [UILabel labelWithText:@"规格:" textColor:RGB(135, 135, 135) fontSize:13];
        self.size = size;
        [size sizeToFit];
        size.frame = CGRectMake(14, (50-size.height)/2, size.width, size.height);
        [view2 addSubview:size];
//        
//        for (int i = 0; i < 4; i ++) {
//            UIButton *btn = [UIButton buttonWithTitle:@"黑色" fontSize:13 titleColor:UIColorBlack background:UIColorWhite cornerRadius:12];
//            [btn addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
//            [btn setBackgroundImage:UIImageNamed(@"border") forState:UIControlStateNormal];
//            [btn setBackgroundImage:UIImageNamed(@"border-sel") forState:UIControlStateSelected];
//            btn.frame = CGRectMake(size.right+10+i*65, 0, 50, 24);
//            btn.centerY = size.centerY;
//            [view2 addSubview:btn];
//            [self.btns2 addObject:btn];
//        }
    }
    return self;
}

- (void)setModel:(ParamDataModel *)model {
    _model = model;
    NSArray<Param *> *params = model.params;
    NSArray *colors = [params.firstObject.v componentsSeparatedByString:@","];

    NSArray *sizes = [params.lastObject.v componentsSeparatedByString:@","];
    
    for (int i = 0; i < colors.count; i ++) {
        UIButton *btn = [UIButton buttonWithTitle:colors[i] fontSize:13 titleColor:UIColorBlack background:UIColorWhite cornerRadius:12];
        btn.frame = CGRectMake(self.color.right+10+i*65, 0, 50, 24);
        [btn addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:UIImageNamed(@"border") forState:UIControlStateNormal];
        [btn setBackgroundImage:UIImageNamed(@"border-sel") forState:UIControlStateSelected];
        btn.centerY = self.color.centerY;
        [self.view1 addSubview:btn];
        [self.btns1 addObject:btn];
    }
    
    for (int i = 0; i < sizes.count; i ++) {
        UIButton *btn = [UIButton buttonWithTitle:sizes[i] fontSize:13 titleColor:UIColorBlack background:UIColorWhite cornerRadius:12];
        [btn addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:UIImageNamed(@"border") forState:UIControlStateNormal];
        [btn setBackgroundImage:UIImageNamed(@"border-sel") forState:UIControlStateSelected];
        btn.frame = CGRectMake(self.size.right+10+i*65, 0, 50, 24);
        btn.centerY = self.size.centerY;
        [self.view2 addSubview:btn];
        [self.btns2 addObject:btn];
    }
}

- (void)btnClick1:(UIButton *)sender {
    for (UIButton *btn in self.btns1) {
        if (btn == sender) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
}

- (void)btnClick2:(UIButton *)sender {
    for (UIButton *btn in self.btns2) {
        if (btn == sender) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
}

- (NSMutableArray<UIButton *> *)btns1 {
    if (!_btns1) {
        _btns1 = [NSMutableArray array];
    }
    return _btns1;
}

- (NSMutableArray<UIButton *> *)btns2 {
    if (!_btns2) {
        _btns2 = [NSMutableArray array];
    }
    return _btns2;
}


@end
