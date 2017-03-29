//
//  thereTableViewCell.m
//  TV
//
//  Created by HOME on 16/8/23.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "thereTableViewCell.h"

@implementation thereTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.avatar.layer.cornerRadius = 18;
    self.avatar.layer.masksToBounds = YES;
    self.titleLable.textColor = RGB(51, 51, 51);
    self.contentLable.textColor = RGB(102, 102, 102);
    self.image.layer.masksToBounds = YES;
    self.image.layer.cornerRadius = 3;
}
- (void)setModel:(ThereModel *)model {
    _model = model;
//    NSLog(@"%@", [NSString stringWithFormat:@"%@%@", KAIKANG, model.user.url]);
    self.titleLable.text = model.title;
    self.contentLable.text = model.desc;
    [self.image sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", KAIKANG, [model.image componentsSeparatedByString:@","].firstObject]] forState:UIControlStateNormal];
    self.commentLable.text = model.comment;
    self.dianzanLable.text = model.praise;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
