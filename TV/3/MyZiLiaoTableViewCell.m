//
//  MyZiLiaoTableViewCell.m
//  家居定制
//
//  Created by iking on 2017/3/25.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "MyZiLiaoTableViewCell.h"

@implementation MyZiLiaoTableViewCell

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
    UILabel *textLB = [UILabel labelWithText:@"" textColor:RGB(106, 106, 107) fontSize:16];
    [textLB sizeToFit];
    [self addSubview:textLB];
    [textLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(rateWidth(20));
        make.centerY.equalTo(self);
    }];
    self.textLB = textLB;
    
    UIImageView *arrow = [UIImageView new];
    arrow.image = [UIImage imageNamed:@"jiantou"];
    arrow.userInteractionEnabled = YES;
    [self addSubview:arrow];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-rateWidth(20));
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(8, 15));
    }];
    self.arrow = arrow;
    
    UIView *line = [UIView new];
    line.backgroundColor = RGB(210, 210, 210);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@(1));
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
