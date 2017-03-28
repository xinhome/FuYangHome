//
//  JieSuanListTableViewCell.m
//  家居定制
//
//  Created by iking on 2017/3/24.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "JieSuanListTableViewCell.h"

@implementation JieSuanListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, rateHeight(8))];
    line.backgroundColor = RGB(242, 242, 242);
    [self addSubview:line];
    
    OrderFirstView *view2 = [OrderFirstView new];
    view2.backgroundColor = [UIColor whiteColor];
    view2.shouhuoBtn.hidden = YES;
    [self addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    self.orderView = view2;
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
