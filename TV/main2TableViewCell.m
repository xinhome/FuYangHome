//
//  main2TableViewCell.m
//  TV
//
//  Created by HOME on 16/8/9.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "main2TableViewCell.h"

@implementation main2TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _dianLable.layer.cornerRadius = 5;
    _dianLable.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
