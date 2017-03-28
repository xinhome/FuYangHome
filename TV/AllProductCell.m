//
//  AllProductCell.m
//  家居定制
//
//  Created by iKing on 2017/3/22.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "AllProductCell.h"

@interface AllProductCell ()

@property (nonatomic, weak) UIImageView *iv;///<<#注释#>
@property (nonatomic, weak) UILabel *price;///<<#注释#>
@property (nonatomic, weak) UILabel *name;///<<#注释#>
@end

@implementation AllProductCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorWhite;
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, rateWidth(165), rateWidth(165))];
        _iv = iv;
        iv.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:iv];
        
        UILabel *price = [UILabel labelWithText:@"￥ 99" textColor:[UIColor redColor] fontSize:14];
        _price = price;
        price.frame = CGRectMake(0, iv.bottom+5, rateWidth(165), 14);
        [self.contentView addSubview:price];
        
        UILabel *name = [UILabel labelWithText:@"创意台灯" textColor:RGB(159, 159, 159) fontSize:14];
        _name = name;
        name.frame = CGRectMake(0, price.bottom, rateWidth(165), 14);
        [self.contentView addSubview:name];
    }
    return self;
}

- (void)setModel:(AllProductModel *)model {
    _model = model;
    //[_iv sd_setImageWithURL:[NSURL url]]
    _price.text = [NSString stringWithFormat:@"￥ %@", model.price];
    _name.text = model.title;
    NSString *str = [NSString stringWithFormat:@"%@%@", WEIMING, [model.image componentsSeparatedByString:@","].firstObject];
    [_iv sd_setImageWithURL:[NSURL URLWithString:str]];
}

@end
