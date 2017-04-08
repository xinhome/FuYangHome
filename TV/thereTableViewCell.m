//
//  thereTableViewCell.m
//  TV
//
//  Created by HOME on 16/8/23.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "thereTableViewCell.h"
#import "HPPhotoBrowser.h"

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
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WEIMING, model.url]] placeholderImage:UIImageNamed(@"Icon2")];
    self.nikeNameLable.text = model.name;
    self.titleLable.text = model.magazineName;
    self.contentLable.text = model.magazineTextContent;
    [self.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", KAIKANG, [model.magazineUrlContent componentsSeparatedByString:@","].firstObject]]];
//    [self.image whenTapped:^{
//        [HPPhotoBrowser showFromImageView:self.image inView:[UIApplication sharedApplication].keyWindow withURLStrings:@[[model.magazineUrlContent componentsSeparatedByString:@","].firstObject] atIndex:0];
//    }];
    self.commentLable.text = model.count;
    self.dianzanLable.text = model.likes;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
