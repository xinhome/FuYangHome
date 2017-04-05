//
//  ItemTableViewCell.m
//  家居定制
//
//  Created by iking on 2017/4/5.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "ItemTableViewCell.h"

@implementation ItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
    }
    return self;
}
- (void)addSubViews
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.firstLB = [UILabel labelWithText:@"快递运费：" textColor:RGB(64, 64, 64) fontSize:15];
    [_firstLB sizeToFit];
    [self.contentView addSubview:_firstLB];
    [_firstLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(rateWidth(20));
        make.centerY.equalTo(self.contentView);
    }];
    
    self.arrow = [UIImageView new];
    _arrow.image = [UIImage imageNamed:@"jiantou"];
    [self.contentView addSubview:_arrow];
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-rateWidth(20));
        make.centerY.equalTo(self.contentView);
        make.size.mas_offset(CGSizeMake(rateWidth(8), rateHeight(13)));
    }];
    
    self.secondLB = [UILabel labelWithText:@"￥0.00" textColor:RGB(64, 64, 64) fontSize:15];
    [self.contentView addSubview:_secondLB];
    [_secondLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(_arrow.mas_left).offset(-rateWidth(10));
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = RGB(240, 240, 240);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset(rateWidth(10));
        make.right.equalTo(self).offset(-rateWidth(10));
        make.height.equalTo(@(rateHeight(1)));
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
