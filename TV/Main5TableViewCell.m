//
//  Main5TableViewCell.m
//  shop
//
//  Created by HOME on 16/12/23.
//  Copyright © 2016年 Appcoda. All rights reserved.
//

#import "Main5TableViewCell.h"

@implementation Main5TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.goumai1.layer.masksToBounds = YES;
    self.goumai1.layer.cornerRadius = 4;
    self.goumai2.layer.masksToBounds = YES;
    self.goumai2.layer.cornerRadius = 4;
    self.goumai3.layer.masksToBounds = YES;
    self.goumai3.layer.cornerRadius = 4;
    
    
    self.pic1.layer.masksToBounds = YES;
    self.pic1.layer.cornerRadius = 2;
    
    self.pic2.layer.masksToBounds = YES;
    self.pic2.layer.cornerRadius = 2;
    
    self.pic3.layer.masksToBounds = YES;
    self.pic3.layer.cornerRadius = 2;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
