//
//  main1TableViewCell.m
//  TV
//
//  Created by HOME on 16/8/9.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "main1TableViewCell.h"

@implementation main1TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgImage.alpha = 0.47;
    self.imageView.alpha = 0.9;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
